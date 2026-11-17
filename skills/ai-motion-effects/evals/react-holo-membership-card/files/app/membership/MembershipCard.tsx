type Props = {
  name: string;
  tier: 'GOLD' | 'PLATINUM';
  memberNo: string;
  since: string;
};

export default function MembershipCard({ name, tier, memberNo, since }: Props) {
  return (
    <div className="w-[340px] aspect-[1.586] rounded-2xl bg-brand p-6 text-white shadow-lg flex flex-col justify-between">
      <div className="flex items-center justify-between">
        <span className="text-sm tracking-[0.3em] font-semibold">FITCLUB</span>
        <span className="text-xs font-bold text-brand-accent">{tier}</span>
      </div>
      <div>
        <p className="text-2xl font-bold">{name}</p>
        <p className="text-xs opacity-70 mt-1">
          No. {memberNo} · since {since}
        </p>
      </div>
    </div>
  );
}
