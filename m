Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC2A74BC61
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 08:27:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qI1Ob-0006fX-7Y; Sat, 08 Jul 2023 02:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1qI1OC-0006bg-GI
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 02:25:54 -0400
Received: from 8.mo552.mail-out.ovh.net ([46.105.37.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1qI1O4-0006oz-Ms
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 02:25:48 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.16.128])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 61B862C905;
 Sat,  8 Jul 2023 06:25:40 +0000 (UTC)
Received: from kaod.org (37.59.142.110) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 8 Jul
 2023 08:25:39 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S0043b341b18-c502-48bb-a2a8-1cb60126a6f2,
 E961D03A283DDF0AA3F04797A310A6A97FE9766D) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 78.197.208.248
Date: Sat, 8 Jul 2023 08:25:36 +0200
From: Greg Kurz <groug@kaod.org>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
CC: Daniel Henrique Barboza <danielhb413@gmail.com>,
 <david@gibson.dropbear.id.au>, <clg@kaod.org>, <harshpb@linux.ibm.com>,
 <npiggin@gmail.com>, <pbonzini@redhat.com>, <qemu-ppc@nongnu.org>,
 <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, <ravi.bangoria@amd.com>
Subject: Re: [PATCH v6] ppc: Enable 2nd DAWR support on p10
Message-ID: <20230708082536.73a2bfd8@bahia>
In-Reply-To: <93da1bb9-14ef-b465-3ae9-73e894232211@linux.ibm.com>
References: <168871963321.58984.15628382614621248470.stgit@ltcd89-lp2>
 <b0047746-5b36-c39b-c669-055d08ca3164@gmail.com>
 <20230707135909.1b1a89d5@bahia>
 <a5e358b3-be18-db69-9e61-cdaeaaf03de0@gmail.com>
 <93da1bb9-14ef-b465-3ae9-73e894232211@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.110]
X-ClientProxiedBy: DAG6EX1.mxp5.local (172.16.2.51) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: 49ef6d6e-b99e-4ba1-8f84-66a63904d9a0
X-Ovh-Tracer-Id: 100205095763810805
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrvddvgddutdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfofggtgfgihesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepudefleegkeekleefgeeuudevjeeutdetteeffffggfduhfeuieffgeegleffudelnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpghhithhlrggsrdgtohhmpdhkvghrnhgvlhdrohhrghenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddruddutddpjeekrdduleejrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoghhrohhugheskhgrohgurdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehssghhrghtsehlihhnuhigrdhisghmrdgtohhmpdgurghnihgvlhhhsgegudefsehgmhgrihhlrdgtohhmpdgurghvihgusehgihgsshhonhdrughrohhpsggvrghrrdhiugdrrghupdhhrghrshhhphgssehlihhnuhigrdhisghmrdgtohhmpdhnphhighhgihhnsehgmhgrihhlrdgtohhmpdhpsghonhiiihhnihesrhgvughhrghtrdgtoh
 hmpdhqvghmuhdqphhptgesnhhonhhgnhhurdhorhhgpdhqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhkvhhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrrghvihdrsggrnhhgohhrihgrsegrmhgurdgtohhmpdgtlhhgsehkrghougdrohhrghdpoffvtefjohhsthepmhhoheehvddpmhhouggvpehsmhhtphhouhht
Received-SPF: pass client-ip=46.105.37.156; envelope-from=groug@kaod.org;
 helo=8.mo552.mail-out.ovh.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, 7 Jul 2023 21:31:47 +0530
Shivaprasad G Bhat <sbhat@linux.ibm.com> wrote:

> On 7/7/23 17:52, Daniel Henrique Barboza wrote:
> >
> >
> > On 7/7/23 08:59, Greg Kurz wrote:
> >> Hi Daniel and Shiva !
> >>
> >> On Fri, 7 Jul 2023 08:09:47 -0300
> >> Daniel Henrique Barboza <danielhb413@gmail.com> wrote:
> >>
> >>> This one was a buzzer shot.
> >>>
> >>
> >> Indeed ! :-) I would have appreciated some more time to re-assess
> >> my R-b tag on this 2 year old bug though ;-)
> >
> > My bad! I never thought it was that old. Never occured to me to check=20
> > when
> > the previous version was sent.
> >
> > Folks, please bear in mind that a Reviewed-by is given on the context=20
> > when the
> > patch was sent. A handful of months? Keep the R-bs. 6 months, from one=
=20
> > release
> > to the other? Things starts to get a little murky. 2 years? hahaha c'mon
>=20
>=20
> Apologies, since v5 didn't need any rework I retained the Reviewed-bys.
>=20
> I agree, I should have been explicit in changelog about how old it is.
>=20
>=20
> > At the very least you need to point out that the acks are old.
> >
> >
> >>
> >> My concerns were that the DAWR1 spapr cap was still not enabled by
> >> default but I guess it is because POWER9 is still the default cpu
> >> type. Related, the apply function should probably spit a warning
> >> with TCG instead of failing, like already done for some other
> >> TCG limitations (e.g. cap_safe_bounds_check_apply()). This will
> >> be needed for `make test` to succeed when DAWR1 is eventually
> >> enabled by default. Not needed right now.
> >>
> Thanks Greg, I will convert the errors to warnings for DAWR1 caps checks
>=20
> in the next version. However, I dont see any new "make test" failures=20
> with the patch.
>=20
> Here are the logs "make test",
>=20
> With patch -=20
> https://gist.github.com/shivaprasadbhat/859f7f4a0c105ac1232b7ab5d8e161e8#=
file-gistfile1-txt
>=20
> Without patch -=20
> https://gist.github.com/shivaprasadbhat/25e5db9254cbe3292017f16adf41ecc1#=
file-gistfile1-txt
>=20

"make test" failures will happen only when DAWR1 is enabled by default.
Retry your test with this change in spapr_machine_class_init() :

+=C2=A0=C2=A0=C2=A0 smc->default_caps.caps[SPAPR_CAP_DAWR1] =3D SPAPR_CAP_O=
FF;
-=C2=A0=C2=A0=C2=A0 smc->default_caps.caps[SPAPR_CAP_DAWR1] =3D SPAPR_CAP_O=
N;

>=20
> >> My R-b still stands then ! :-)
> >
> > This patch got lucky then. If you/Cedric remove your acks I would=20
> > simply drop the
> > patch and re-send the PR with the greatest of ease, no remorse=20
> > whatsoever.
> >
> >
> > Thanks,
> >
> > Daniel
> >
> >>
> >> Cheers,
> >>
> >> --=20
> >> Greg
> >>
> >>>
> >>> Queued in gitlab.com/danielhb/qemu/tree/ppc-next. Thanks,
> >>>
> >>>
> >>> Daniel
> >>>
> >>>
> >>> On 7/7/23 05:47, Shivaprasad G Bhat wrote:
> >>>> From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> >>>>
> >>>> As per the PAPR, bit 0 of byte 64 in pa-features property
> >>>> indicates availability of 2nd DAWR registers. i.e. If this bit is=20
> >>>> set, 2nd
> >>>> DAWR is present, otherwise not. Use KVM_CAP_PPC_DAWR1 capability to=
=20
> >>>> find
> >>>> whether kvm supports 2nd DAWR or not. If it's supported, allow user=
=20
> >>>> to set
> >>>> the pa-feature bit in guest DT using cap-dawr1 machine capability.=20
> >>>> Though,
> >>>> watchpoint on powerpc TCG guest is not supported and thus 2nd DAWR=20
> >>>> is not
> >>>> enabled for TCG mode.
> >>>>
> >>>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> >>>> Reviewed-by: Greg Kurz <groug@kaod.org>
> >>>> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> >>>> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> >>>> ---
> >>>> Changelog:
> >>>> v5:=20
> >>>> https://lore.kernel.org/all/20210412114433.129702-1-ravi.bangoria@li=
nux.ibm.com/
> >>>> v5->v6:
> >>>> =C2=A0=C2=A0=C2=A0 - The other patches in the original series alread=
y merged.
> >>>> =C2=A0=C2=A0=C2=A0 - Rebased to the top of the tree. So, the=20
> >>>> gen_spr_book3s_310_dbg() is renamed
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to register_book3s_310_dbg_sprs() and=
 moved to cpu_init.c=20
> >>>> accordingly.
> >>>> =C2=A0=C2=A0=C2=A0 - No functional changes.
> >>>>
> >>>> v4:=20
> >>>> https://lore.kernel.org/r/20210406053833.282907-1-ravi.bangoria@linu=
x.ibm.com
> >>>> v3->v4:
> >>>> =C2=A0=C2=A0=C2=A0 - Make error message more proper.
> >>>>
> >>>> v3:=20
> >>>> https://lore.kernel.org/r/20210330095350.36309-1-ravi.bangoria@linux=
.ibm.com
> >>>> v3->v4:
> >>>> =C2=A0=C2=A0=C2=A0 - spapr_dt_pa_features(): POWER10 processor is co=
mpatible with 3.0
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (PCR_COMPAT_3_00). No need to ppc_che=
ck_compat(3_10) for now as
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ppc_check_compati(3_00) will also be =
true.=20
> >>>> ppc_check_compat(3_10)
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 can be added while introducing pa_fea=
tures_310 in future.
> >>>> =C2=A0=C2=A0=C2=A0 - Use error_append_hint() for hints. Also add ERR=
P_GUARD().
> >>>> =C2=A0=C2=A0=C2=A0 - Add kvmppc_set_cap_dawr1() stub function for CO=
NFIG_KVM=3Dn.
> >>>>
> >>>> v2:=20
> >>>> https://lore.kernel.org/r/20210329041906.213991-1-ravi.bangoria@linu=
x.ibm.com
> >>>> v2->v3:
> >>>> =C2=A0=C2=A0=C2=A0 - Don't introduce pa_features_310[], instead, reu=
se=20
> >>>> pa_features_300[]
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for 3.1 guests, as there is no differ=
ence between initial=20
> >>>> values of
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 them atm.
> >>>> =C2=A0=C2=A0=C2=A0 - Call gen_spr_book3s_310_dbg() from init_proc_PO=
WER10()=20
> >>>> instead of
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 init_proc_POWER8(). Also, Don't call =
gen_spr_book3s_207_dbg()=20
> >>>> from
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_spr_book3s_310_dbg() as init_proc=
_POWER10() already calls=20
> >>>> it.
> >>>>
> >>>> v1:=20
> >>>> https://lore.kernel.org/r/20200723104220.314671-1-ravi.bangoria@linu=
x.ibm.com
> >>>> v1->v2:
> >>>> =C2=A0=C2=A0=C2=A0 - Introduce machine capability cap-dawr1 to enabl=
e/disable
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the feature. By default, 2nd DAWR is =
OFF for guests even
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 when host kvm supports it. User has t=
o manually enable it
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with -machine cap-dawr1=3Don if he wi=
shes to use it.
> >>>> =C2=A0=C2=A0=C2=A0 - Split the header file changes into separate pat=
ch. (Sync
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 headers from v5.12-rc3)
> >>>>
> >>>> [1] https://git.kernel.org/torvalds/c/bd1de1a0e6eff
> >>>>
> >>>> =C2=A0=C2=A0 hw/ppc/spapr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 7 ++++++-
> >>>> =C2=A0=C2=A0 hw/ppc/spapr_caps.c=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 32 =
++++++++++++++++++++++++++++++++
> >>>> =C2=A0=C2=A0 include/hw/ppc/spapr.h |=C2=A0=C2=A0=C2=A0 6 +++++-
> >>>> =C2=A0=C2=A0 target/ppc/cpu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0=C2=A0 2 ++
> >>>> =C2=A0=C2=A0 target/ppc/cpu_init.c=C2=A0 |=C2=A0=C2=A0 15 ++++++++++=
+++++
> >>>> =C2=A0=C2=A0 target/ppc/kvm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 12 ++++++++++++
> >>>> =C2=A0=C2=A0 target/ppc/kvm_ppc.h=C2=A0=C2=A0 |=C2=A0=C2=A0 12 +++++=
+++++++
> >>>> =C2=A0=C2=A0 7 files changed, 84 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >>>> index 54dbfd7fe9..1e54e0c719 100644
> >>>> --- a/hw/ppc/spapr.c
> >>>> +++ b/hw/ppc/spapr.c
> >>>> @@ -241,7 +241,7 @@ static void=20
> >>>> spapr_dt_pa_features(SpaprMachineState *spapr,
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x80, 0=
x00, 0x80, 0x00, 0x80, 0x00, /* 48 - 53 */
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 54: =
DecFP, 56: DecI, 58: SHA */
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x80, 0=
x00, 0x80, 0x00, 0x80, 0x00, /* 54 - 59 */
> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 60: NM atomic, 62: RN=
G */
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 60: NM atomic, 62: RN=
G, 64: DAWR1 (ISA 3.1) */
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x80, 0=
x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t *pa_features =3D NULL;
> >>>> @@ -282,6 +282,9 @@ static void=20
> >>>> spapr_dt_pa_features(SpaprMachineState *spapr,
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=
 in pa-features. So hide it from them. */
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pa_feat=
ures[40 + 2] &=3D ~0x80; /* Radix MMU */
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>> +=C2=A0=C2=A0=C2=A0 if (spapr_get_cap(spapr, SPAPR_CAP_DAWR1)) {
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pa_features[66] |=3D 0x8=
0;
> >>>> +=C2=A0=C2=A0=C2=A0 }
> >>>>
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _FDT((fdt_setprop(fdt, offset, =
"ibm,pa-features",=20
> >>>> pa_features, pa_size)));
> >>>> =C2=A0=C2=A0 }
> >>>> @@ -2084,6 +2087,7 @@ static const VMStateDescription vmstate_spapr=
=20
> >>>> =3D {
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &vmstat=
e_spapr_cap_fwnmi,
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &vmstat=
e_spapr_fwnmi,
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &vmstat=
e_spapr_cap_rpt_invalidate,
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &vmstate_spapr_cap_dawr1,
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>> =C2=A0=C2=A0 };
> >>>> @@ -4683,6 +4687,7 @@ static void=20
> >>>> spapr_machine_class_init(ObjectClass *oc, void *data)
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 smc->default_caps.caps[SPAPR_CA=
P_CCF_ASSIST] =3D SPAPR_CAP_ON;
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 smc->default_caps.caps[SPAPR_CA=
P_FWNMI] =3D SPAPR_CAP_ON;
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 smc->default_caps.caps[SPAPR_CA=
P_RPT_INVALIDATE] =3D=20
> >>>> SPAPR_CAP_OFF;
> >>>> +=C2=A0=C2=A0=C2=A0 smc->default_caps.caps[SPAPR_CAP_DAWR1] =3D SPAP=
R_CAP_OFF;
> >>>>
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * This cap specifies whet=
her the AIL 3 mode for
> >>>> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> >>>> index 5a0755d34f..2f2cf4a250 100644
> >>>> --- a/hw/ppc/spapr_caps.c
> >>>> +++ b/hw/ppc/spapr_caps.c
> >>>> @@ -655,6 +655,28 @@ static void=20
> >>>> cap_ail_mode_3_apply(SpaprMachineState *spapr,
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>> =C2=A0=C2=A0 }
> >>>>
> >>>> +static void cap_dawr1_apply(SpaprMachineState *spapr, uint8_t val,
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error **errp)
> >>>> +{
> >>>> +=C2=A0=C2=A0=C2=A0 ERRP_GUARD();
> >>>> +=C2=A0=C2=A0=C2=A0 if (!val) {
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return; /* Disable by de=
fault */
> >>>> +=C2=A0=C2=A0=C2=A0 }
> >>>> +
> >>>> +=C2=A0=C2=A0=C2=A0 if (tcg_enabled()) {
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "DAWR1 =
not supported in TCG.");
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_append_hint(errp, =
"Try appending -machine=20
> >>>> cap-dawr1=3Doff\n");
> >>>> +=C2=A0=C2=A0=C2=A0 } else if (kvm_enabled()) {
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!kvmppc_has_cap_dawr=
1()) {
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
error_setg(errp, "DAWR1 not supported by KVM.");
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
error_append_hint(errp, "Try appending -machine=20
> >>>> cap-dawr1=3Doff\n");
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (kvmppc_set_ca=
p_dawr1(val) < 0) {
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
error_setg(errp, "Error enabling cap-dawr1 with KVM.");
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
error_append_hint(errp, "Try appending -machine=20
> >>>> cap-dawr1=3Doff\n");
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>> +=C2=A0=C2=A0=C2=A0 }
> >>>> +}
> >>>> +
> >>>> =C2=A0=C2=A0 SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D=
 {
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [SPAPR_CAP_HTM] =3D {
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =
=3D "htm",
> >>>> @@ -781,6 +803,15 @@ SpaprCapabilityInfo=20
> >>>> capability_table[SPAPR_CAP_NUM] =3D {
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .type =
=3D "bool",
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .apply =
=3D cap_ail_mode_3_apply,
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> >>>> +=C2=A0=C2=A0=C2=A0 [SPAPR_CAP_DAWR1] =3D {
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "dawr1",
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .description =3D "Allow =
2nd Data Address Watchpoint Register=20
> >>>> (DAWR1)",
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .index =3D SPAPR_CAP_DAW=
R1,
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .get =3D spapr_cap_get_b=
ool,
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .set =3D spapr_cap_set_b=
ool,
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .type =3D "bool",
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .apply =3D cap_dawr1_app=
ly,
> >>>> +=C2=A0=C2=A0=C2=A0 },
> >>>> =C2=A0=C2=A0 };
> >>>>
> >>>> =C2=A0=C2=A0 static SpaprCapabilities default_caps_with_cpu(SpaprMac=
hineState=20
> >>>> *spapr,
> >>>> @@ -923,6 +954,7 @@ SPAPR_CAP_MIG_STATE(large_decr,=20
> >>>> SPAPR_CAP_LARGE_DECREMENTER);
> >>>> =C2=A0=C2=A0 SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
> >>>> =C2=A0=C2=A0 SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI);
> >>>> =C2=A0=C2=A0 SPAPR_CAP_MIG_STATE(rpt_invalidate, SPAPR_CAP_RPT_INVAL=
IDATE);
> >>>> +SPAPR_CAP_MIG_STATE(dawr1, SPAPR_CAP_DAWR1);
> >>>>
> >>>> =C2=A0=C2=A0 void spapr_caps_init(SpaprMachineState *spapr)
> >>>> =C2=A0=C2=A0 {
> >>>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> >>>> index 538b2dfb89..47fffb921a 100644
> >>>> --- a/include/hw/ppc/spapr.h
> >>>> +++ b/include/hw/ppc/spapr.h
> >>>> @@ -80,8 +80,10 @@ typedef enum {
> >>>> =C2=A0=C2=A0 #define SPAPR_CAP_RPT_INVALIDATE=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0x0B
> >>>> =C2=A0=C2=A0 /* Support for AIL modes */
> >>>> =C2=A0=C2=A0 #define SPAPR_CAP_AIL_MODE_3=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0C
> >>>> +/* DAWR1 */
> >>>> +#define SPAPR_CAP_DAWR1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0D
> >>>> =C2=A0=C2=A0 /* Num Caps */
> >>>> -#define SPAPR_CAP_NUM (SPAPR_CAP_AIL_MODE_3 + 1)
> >>>> +#define SPAPR_CAP_NUM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (SPAPR_CAP_=
DAWR1 + 1)
> >>>>
> >>>> =C2=A0=C2=A0 /*
> >>>> =C2=A0=C2=A0=C2=A0 * Capability Values
> >>>> @@ -407,6 +409,7 @@ struct SpaprMachineState {
> >>>> =C2=A0=C2=A0 #define H_SET_MODE_RESOURCE_SET_DAWR0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2
> >>>> =C2=A0=C2=A0 #define H_SET_MODE_RESOURCE_ADDR_TRANS_MODE=C2=A0=C2=A0=
=C2=A0=C2=A0 3
> >>>> =C2=A0=C2=A0 #define H_SET_MODE_RESOURCE_LE=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 4
> >>>> +#define H_SET_MODE_RESOURCE_SET_DAWR1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5
> >>>>
> >>>> =C2=A0=C2=A0 /* Flags for H_SET_MODE_RESOURCE_LE */
> >>>> =C2=A0=C2=A0 #define H_SET_MODE_ENDIAN_BIG=C2=A0=C2=A0=C2=A0 0
> >>>> @@ -990,6 +993,7 @@ extern const VMStateDescription=20
> >>>> vmstate_spapr_cap_ccf_assist;
> >>>> =C2=A0=C2=A0 extern const VMStateDescription vmstate_spapr_cap_fwnmi;
> >>>> =C2=A0=C2=A0 extern const VMStateDescription vmstate_spapr_cap_rpt_i=
nvalidate;
> >>>> =C2=A0=C2=A0 extern const VMStateDescription vmstate_spapr_wdt;
> >>>> +extern const VMStateDescription vmstate_spapr_cap_dawr1;
> >>>>
> >>>> =C2=A0=C2=A0 static inline uint8_t spapr_get_cap(SpaprMachineState *=
spapr,=20
> >>>> int cap)
> >>>> =C2=A0=C2=A0 {
> >>>> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> >>>> index af12c93ebc..64855935f7 100644
> >>>> --- a/target/ppc/cpu.h
> >>>> +++ b/target/ppc/cpu.h
> >>>> @@ -1588,9 +1588,11 @@ void ppc_compat_add_property(Object *obj,=20
> >>>> const char *name,
> >>>> =C2=A0=C2=A0 #define SPR_PSPB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0x09F)
> >>>> =C2=A0=C2=A0 #define SPR_DPDES=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0x0B0)
> >>>> =C2=A0=C2=A0 #define SPR_DAWR0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0x0B4)
> >>>> +#define SPR_DAWR1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 (0x0B5)
> >>>> =C2=A0=C2=A0 #define SPR_RPR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0x0BA)
> >>>> =C2=A0=C2=A0 #define SPR_CIABR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0x0BB)
> >>>> =C2=A0=C2=A0 #define SPR_DAWRX0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0x0BC)
> >>>> +#define SPR_DAWRX1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (0x0BD)
> >>>> =C2=A0=C2=A0 #define SPR_HFSCR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0x0BE)
> >>>> =C2=A0=C2=A0 #define SPR_VRSAVE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0x100)
> >>>> =C2=A0=C2=A0 #define SPR_USPRG0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (0x100)
> >>>> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> >>>> index aeff71d063..c688e52928 100644
> >>>> --- a/target/ppc/cpu_init.c
> >>>> +++ b/target/ppc/cpu_init.c
> >>>> @@ -5131,6 +5131,20 @@ static void=20
> >>>> register_book3s_207_dbg_sprs(CPUPPCState *env)
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 KVM_REG_PPC_CIABR, 0x00000000);
> >>>> =C2=A0=C2=A0 }
> >>>>
> >>>> +static void register_book3s_310_dbg_sprs(CPUPPCState *env)
> >>>> +{
> >>>> +=C2=A0=C2=A0=C2=A0 spr_register_kvm_hv(env, SPR_DAWR1, "DAWR1",
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SP=
R_NOACCESS, SPR_NOACCESS,
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SP=
R_NOACCESS, SPR_NOACCESS,
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &s=
pr_read_generic, &spr_write_generic,
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KV=
M_REG_PPC_DAWR1, 0x00000000);
> >>>> +=C2=A0=C2=A0=C2=A0 spr_register_kvm_hv(env, SPR_DAWRX1, "DAWRX1",
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SP=
R_NOACCESS, SPR_NOACCESS,
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SP=
R_NOACCESS, SPR_NOACCESS,
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &s=
pr_read_generic, &spr_write_generic32,
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 KV=
M_REG_PPC_DAWRX1, 0x00000000);
> >>>> +}
> >>>> +
> >>>> =C2=A0=C2=A0 static void register_970_dbg_sprs(CPUPPCState *env)
> >>>> =C2=A0=C2=A0 {
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Breakpoints */
> >>>> @@ -6435,6 +6449,7 @@ static void init_proc_POWER10(CPUPPCState *env)
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Common Registers */
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 init_proc_book3s_common(env);
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 register_book3s_207_dbg_sprs(en=
v);
> >>>> +=C2=A0=C2=A0=C2=A0 register_book3s_310_dbg_sprs(env);
> >>>>
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Common TCG PMU */
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 init_tcg_pmu_power8(env);
> >>>> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> >>>> index a8a935e267..05f68d2d91 100644
> >>>> --- a/target/ppc/kvm.c
> >>>> +++ b/target/ppc/kvm.c
> >>>> @@ -89,6 +89,7 @@ static int cap_large_decr;
> >>>> =C2=A0=C2=A0 static int cap_fwnmi;
> >>>> =C2=A0=C2=A0 static int cap_rpt_invalidate;
> >>>> =C2=A0=C2=A0 static int cap_ail_mode_3;
> >>>> +static int cap_dawr1;
> >>>>
> >>>> =C2=A0=C2=A0 static uint32_t debug_inst_opcode;
> >>>>
> >>>> @@ -138,6 +139,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cap_ppc_nested_kvm_hv =3D kvm_v=
m_check_extension(s,=20
> >>>> KVM_CAP_PPC_NESTED_HV);
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cap_large_decr =3D kvmppc_get_d=
ec_bits();
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cap_fwnmi =3D kvm_vm_check_exte=
nsion(s, KVM_CAP_PPC_FWNMI);
> >>>> +=C2=A0=C2=A0=C2=A0 cap_dawr1 =3D kvm_vm_check_extension(s, KVM_CAP_=
PPC_DAWR1);
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Note: setting it to fal=
se because there is not such=20
> >>>> capability
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * in KVM at this moment.
> >>>> @@ -2109,6 +2111,16 @@ int kvmppc_set_fwnmi(PowerPCCPU *cpu)
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return kvm_vcpu_enable_cap(cs, =
KVM_CAP_PPC_FWNMI, 0);
> >>>> =C2=A0=C2=A0 }
> >>>>
> >>>> +bool kvmppc_has_cap_dawr1(void)
> >>>> +{
> >>>> +=C2=A0=C2=A0=C2=A0 return !!cap_dawr1;
> >>>> +}
> >>>> +
> >>>> +int kvmppc_set_cap_dawr1(int enable)
> >>>> +{
> >>>> +=C2=A0=C2=A0=C2=A0 return kvm_vm_enable_cap(kvm_state, KVM_CAP_PPC_=
DAWR1, 0,=20
> >>>> enable);
> >>>> +}
> >>>> +
> >>>> =C2=A0=C2=A0 int kvmppc_smt_threads(void)
> >>>> =C2=A0=C2=A0 {
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return cap_ppc_smt ? cap_ppc_sm=
t : 1;
> >>>> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> >>>> index 611debc3ce..584916a6d1 100644
> >>>> --- a/target/ppc/kvm_ppc.h
> >>>> +++ b/target/ppc/kvm_ppc.h
> >>>> @@ -67,6 +67,8 @@ bool kvmppc_has_cap_htm(void);
> >>>> =C2=A0=C2=A0 bool kvmppc_has_cap_mmu_radix(void);
> >>>> =C2=A0=C2=A0 bool kvmppc_has_cap_mmu_hash_v3(void);
> >>>> =C2=A0=C2=A0 bool kvmppc_has_cap_xive(void);
> >>>> +bool kvmppc_has_cap_dawr1(void);
> >>>> +int kvmppc_set_cap_dawr1(int enable);
> >>>> =C2=A0=C2=A0 int kvmppc_get_cap_safe_cache(void);
> >>>> =C2=A0=C2=A0 int kvmppc_get_cap_safe_bounds_check(void);
> >>>> =C2=A0=C2=A0 int kvmppc_get_cap_safe_indirect_branch(void);
> >>>> @@ -352,6 +354,16 @@ static inline bool kvmppc_has_cap_xive(void)
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> >>>> =C2=A0=C2=A0 }
> >>>>
> >>>> +static inline bool kvmppc_has_cap_dawr1(void)
> >>>> +{
> >>>> +=C2=A0=C2=A0=C2=A0 return false;
> >>>> +}
> >>>> +
> >>>> +static inline int kvmppc_set_cap_dawr1(int enable)
> >>>> +{
> >>>> +=C2=A0=C2=A0=C2=A0 abort();
> >>>> +}
> >>>> +
> >>>> =C2=A0=C2=A0 static inline int kvmppc_get_cap_safe_cache(void)
> >>>> =C2=A0=C2=A0 {
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> >>>>
> >>>>
> >>
> >>
> >>



--=20
Greg

