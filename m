Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA8874B062
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 14:00:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHk7T-00061B-07; Fri, 07 Jul 2023 07:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1qHk7R-00060o-Fk
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 07:59:25 -0400
Received: from 9.mo548.mail-out.ovh.net ([46.105.48.137])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1qHk7N-0008W2-Va
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 07:59:25 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.52])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 865F22225B;
 Fri,  7 Jul 2023 11:59:11 +0000 (UTC)
Received: from kaod.org (37.59.142.95) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 7 Jul
 2023 13:59:10 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G001785c78bc-1f51-45f0-9c2b-867c936ac6f9,
 3C9B0486422B2545FF0DF1F8924E5A20C3FFA119) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 78.197.208.248
Date: Fri, 7 Jul 2023 13:59:09 +0200
From: Greg Kurz <groug@kaod.org>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
CC: Shivaprasad G Bhat <sbhat@linux.ibm.com>, <david@gibson.dropbear.id.au>,
 <clg@kaod.org>, <harshpb@linux.ibm.com>, <npiggin@gmail.com>,
 <pbonzini@redhat.com>, <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>,
 <kvm@vger.kernel.org>, <ravi.bangoria@amd.com>
Subject: Re: [PATCH v6] ppc: Enable 2nd DAWR support on p10
Message-ID: <20230707135909.1b1a89d5@bahia>
In-Reply-To: <b0047746-5b36-c39b-c669-055d08ca3164@gmail.com>
References: <168871963321.58984.15628382614621248470.stgit@ltcd89-lp2>
 <b0047746-5b36-c39b-c669-055d08ca3164@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.95]
X-ClientProxiedBy: DAG9EX2.mxp5.local (172.16.2.82) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: 90fd0c21-aa6e-48ae-96ce-d5b8c7bfee47
X-Ovh-Tracer-Id: 18306851014357719541
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrvddugdegiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhfogggtgfhisehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeelveehudekgfevleegueeuvdekheehtefgtdegjeejgeetueduveefhffgtdekteenucffohhmrghinhepghhithhlrggsrdgtohhmpdhkvghrnhgvlhdrohhrghenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddrleehpdejkedrudeljedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehgrhhouhhgsehkrghougdrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepuggrnhhivghlhhgsgedufeesghhmrghilhdrtghomhdpshgshhgrtheslhhinhhugidrihgsmhdrtghomhdpuggrvhhiugesghhisghsohhnrdgurhhophgsvggrrhdrihgurdgruhdphhgrrhhshhhpsgeslhhinhhugidrihgsmhdrtghomhdpnhhpihhgghhinhesghhmrghilhdrtghomhdpphgsohhniihinhhisehrvgguhhgrthdrtghomhdpqhgvmhhuqdhpphgtsehnoh
 hnghhnuhdrohhrghdpqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdpkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgrvhhirdgsrghnghhorhhirgesrghmugdrtghomhdptghlgheskhgrohgurdhorhhgpdfovfetjfhoshhtpehmohehgeekpdhmohguvgepshhmthhpohhuth
Received-SPF: pass client-ip=46.105.48.137; envelope-from=groug@kaod.org;
 helo=9.mo548.mail-out.ovh.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Daniel and Shiva !

On Fri, 7 Jul 2023 08:09:47 -0300
Daniel Henrique Barboza <danielhb413@gmail.com> wrote:

> This one was a buzzer shot.
>=20

Indeed ! :-) I would have appreciated some more time to re-assess
my R-b tag on this 2 year old bug though ;-)

My concerns were that the DAWR1 spapr cap was still not enabled by
default but I guess it is because POWER9 is still the default cpu
type. Related, the apply function should probably spit a warning
with TCG instead of failing, like already done for some other
TCG limitations (e.g. cap_safe_bounds_check_apply()). This will
be needed for `make test` to succeed when DAWR1 is eventually
enabled by default. Not needed right now.

My R-b still stands then ! :-)

Cheers,

--
Greg

>=20
> Queued in gitlab.com/danielhb/qemu/tree/ppc-next. Thanks,
>=20
>=20
> Daniel
>=20
>=20
> On 7/7/23 05:47, Shivaprasad G Bhat wrote:
> > From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> >=20
> > As per the PAPR, bit 0 of byte 64 in pa-features property
> > indicates availability of 2nd DAWR registers. i.e. If this bit is set, =
2nd
> > DAWR is present, otherwise not. Use KVM_CAP_PPC_DAWR1 capability to find
> > whether kvm supports 2nd DAWR or not. If it's supported, allow user to =
set
> > the pa-feature bit in guest DT using cap-dawr1 machine capability. Thou=
gh,
> > watchpoint on powerpc TCG guest is not supported and thus 2nd DAWR is n=
ot
> > enabled for TCG mode.
> >=20
> > Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> > Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> > Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> > ---
> > Changelog:
> > v5: https://lore.kernel.org/all/20210412114433.129702-1-ravi.bangoria@l=
inux.ibm.com/
> > v5->v6:
> >    - The other patches in the original series already merged.
> >    - Rebased to the top of the tree. So, the gen_spr_book3s_310_dbg() i=
s renamed
> >      to register_book3s_310_dbg_sprs() and moved to cpu_init.c accordin=
gly.
> >    - No functional changes.
> >=20
> > v4: https://lore.kernel.org/r/20210406053833.282907-1-ravi.bangoria@lin=
ux.ibm.com
> > v3->v4:
> >    - Make error message more proper.
> >=20
> > v3: https://lore.kernel.org/r/20210330095350.36309-1-ravi.bangoria@linu=
x.ibm.com
> > v3->v4:
> >    - spapr_dt_pa_features(): POWER10 processor is compatible with 3.0
> >      (PCR_COMPAT_3_00). No need to ppc_check_compat(3_10) for now as
> >      ppc_check_compati(3_00) will also be true. ppc_check_compat(3_10)
> >      can be added while introducing pa_features_310 in future.
> >    - Use error_append_hint() for hints. Also add ERRP_GUARD().
> >    - Add kvmppc_set_cap_dawr1() stub function for CONFIG_KVM=3Dn.
> >=20
> > v2: https://lore.kernel.org/r/20210329041906.213991-1-ravi.bangoria@lin=
ux.ibm.com
> > v2->v3:
> >    - Don't introduce pa_features_310[], instead, reuse pa_features_300[]
> >      for 3.1 guests, as there is no difference between initial values of
> >      them atm.
> >    - Call gen_spr_book3s_310_dbg() from init_proc_POWER10() instead of
> >      init_proc_POWER8(). Also, Don't call gen_spr_book3s_207_dbg() from
> >      gen_spr_book3s_310_dbg() as init_proc_POWER10() already calls it.
> >=20
> > v1: https://lore.kernel.org/r/20200723104220.314671-1-ravi.bangoria@lin=
ux.ibm.com
> > v1->v2:
> >    - Introduce machine capability cap-dawr1 to enable/disable
> >      the feature. By default, 2nd DAWR is OFF for guests even
> >      when host kvm supports it. User has to manually enable it
> >      with -machine cap-dawr1=3Don if he wishes to use it.
> >    - Split the header file changes into separate patch. (Sync
> >      headers from v5.12-rc3)
> >=20
> > [1] https://git.kernel.org/torvalds/c/bd1de1a0e6eff
> >=20
> >   hw/ppc/spapr.c         |    7 ++++++-
> >   hw/ppc/spapr_caps.c    |   32 ++++++++++++++++++++++++++++++++
> >   include/hw/ppc/spapr.h |    6 +++++-
> >   target/ppc/cpu.h       |    2 ++
> >   target/ppc/cpu_init.c  |   15 +++++++++++++++
> >   target/ppc/kvm.c       |   12 ++++++++++++
> >   target/ppc/kvm_ppc.h   |   12 ++++++++++++
> >   7 files changed, 84 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 54dbfd7fe9..1e54e0c719 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -241,7 +241,7 @@ static void spapr_dt_pa_features(SpaprMachineState =
*spapr,
> >           0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 48 - 53 */
> >           /* 54: DecFP, 56: DecI, 58: SHA */
> >           0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 54 - 59 */
> > -        /* 60: NM atomic, 62: RNG */
> > +        /* 60: NM atomic, 62: RNG, 64: DAWR1 (ISA 3.1) */
> >           0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
> >       };
> >       uint8_t *pa_features =3D NULL;
> > @@ -282,6 +282,9 @@ static void spapr_dt_pa_features(SpaprMachineState =
*spapr,
> >            * in pa-features. So hide it from them. */
> >           pa_features[40 + 2] &=3D ~0x80; /* Radix MMU */
> >       }
> > +    if (spapr_get_cap(spapr, SPAPR_CAP_DAWR1)) {
> > +        pa_features[66] |=3D 0x80;
> > +    }
> >=20
> >       _FDT((fdt_setprop(fdt, offset, "ibm,pa-features", pa_features, pa=
_size)));
> >   }
> > @@ -2084,6 +2087,7 @@ static const VMStateDescription vmstate_spapr =3D=
 {
> >           &vmstate_spapr_cap_fwnmi,
> >           &vmstate_spapr_fwnmi,
> >           &vmstate_spapr_cap_rpt_invalidate,
> > +        &vmstate_spapr_cap_dawr1,
> >           NULL
> >       }
> >   };
> > @@ -4683,6 +4687,7 @@ static void spapr_machine_class_init(ObjectClass =
*oc, void *data)
> >       smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_ON;
> >       smc->default_caps.caps[SPAPR_CAP_FWNMI] =3D SPAPR_CAP_ON;
> >       smc->default_caps.caps[SPAPR_CAP_RPT_INVALIDATE] =3D SPAPR_CAP_OF=
F;
> > +    smc->default_caps.caps[SPAPR_CAP_DAWR1] =3D SPAPR_CAP_OFF;
> >=20
> >       /*
> >        * This cap specifies whether the AIL 3 mode for
> > diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> > index 5a0755d34f..2f2cf4a250 100644
> > --- a/hw/ppc/spapr_caps.c
> > +++ b/hw/ppc/spapr_caps.c
> > @@ -655,6 +655,28 @@ static void cap_ail_mode_3_apply(SpaprMachineState=
 *spapr,
> >       }
> >   }
> >=20
> > +static void cap_dawr1_apply(SpaprMachineState *spapr, uint8_t val,
> > +                               Error **errp)
> > +{
> > +    ERRP_GUARD();
> > +    if (!val) {
> > +        return; /* Disable by default */
> > +    }
> > +
> > +    if (tcg_enabled()) {
> > +        error_setg(errp, "DAWR1 not supported in TCG.");
> > +        error_append_hint(errp, "Try appending -machine cap-dawr1=3Dof=
f\n");
> > +    } else if (kvm_enabled()) {
> > +        if (!kvmppc_has_cap_dawr1()) {
> > +            error_setg(errp, "DAWR1 not supported by KVM.");
> > +            error_append_hint(errp, "Try appending -machine cap-dawr1=
=3Doff\n");
> > +        } else if (kvmppc_set_cap_dawr1(val) < 0) {
> > +            error_setg(errp, "Error enabling cap-dawr1 with KVM.");
> > +            error_append_hint(errp, "Try appending -machine cap-dawr1=
=3Doff\n");
> > +        }
> > +    }
> > +}
> > +
> >   SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
> >       [SPAPR_CAP_HTM] =3D {
> >           .name =3D "htm",
> > @@ -781,6 +803,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM=
] =3D {
> >           .type =3D "bool",
> >           .apply =3D cap_ail_mode_3_apply,
> >       },
> > +    [SPAPR_CAP_DAWR1] =3D {
> > +        .name =3D "dawr1",
> > +        .description =3D "Allow 2nd Data Address Watchpoint Register (=
DAWR1)",
> > +        .index =3D SPAPR_CAP_DAWR1,
> > +        .get =3D spapr_cap_get_bool,
> > +        .set =3D spapr_cap_set_bool,
> > +        .type =3D "bool",
> > +        .apply =3D cap_dawr1_apply,
> > +    },
> >   };
> >=20
> >   static SpaprCapabilities default_caps_with_cpu(SpaprMachineState *spa=
pr,
> > @@ -923,6 +954,7 @@ SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DEC=
REMENTER);
> >   SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
> >   SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI);
> >   SPAPR_CAP_MIG_STATE(rpt_invalidate, SPAPR_CAP_RPT_INVALIDATE);
> > +SPAPR_CAP_MIG_STATE(dawr1, SPAPR_CAP_DAWR1);
> >=20
> >   void spapr_caps_init(SpaprMachineState *spapr)
> >   {
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index 538b2dfb89..47fffb921a 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -80,8 +80,10 @@ typedef enum {
> >   #define SPAPR_CAP_RPT_INVALIDATE        0x0B
> >   /* Support for AIL modes */
> >   #define SPAPR_CAP_AIL_MODE_3            0x0C
> > +/* DAWR1 */
> > +#define SPAPR_CAP_DAWR1                 0x0D
> >   /* Num Caps */
> > -#define SPAPR_CAP_NUM                   (SPAPR_CAP_AIL_MODE_3 + 1)
> > +#define SPAPR_CAP_NUM                   (SPAPR_CAP_DAWR1 + 1)
> >=20
> >   /*
> >    * Capability Values
> > @@ -407,6 +409,7 @@ struct SpaprMachineState {
> >   #define H_SET_MODE_RESOURCE_SET_DAWR0           2
> >   #define H_SET_MODE_RESOURCE_ADDR_TRANS_MODE     3
> >   #define H_SET_MODE_RESOURCE_LE                  4
> > +#define H_SET_MODE_RESOURCE_SET_DAWR1           5
> >=20
> >   /* Flags for H_SET_MODE_RESOURCE_LE */
> >   #define H_SET_MODE_ENDIAN_BIG    0
> > @@ -990,6 +993,7 @@ extern const VMStateDescription vmstate_spapr_cap_c=
cf_assist;
> >   extern const VMStateDescription vmstate_spapr_cap_fwnmi;
> >   extern const VMStateDescription vmstate_spapr_cap_rpt_invalidate;
> >   extern const VMStateDescription vmstate_spapr_wdt;
> > +extern const VMStateDescription vmstate_spapr_cap_dawr1;
> >=20
> >   static inline uint8_t spapr_get_cap(SpaprMachineState *spapr, int cap)
> >   {
> > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > index af12c93ebc..64855935f7 100644
> > --- a/target/ppc/cpu.h
> > +++ b/target/ppc/cpu.h
> > @@ -1588,9 +1588,11 @@ void ppc_compat_add_property(Object *obj, const =
char *name,
> >   #define SPR_PSPB              (0x09F)
> >   #define SPR_DPDES             (0x0B0)
> >   #define SPR_DAWR0             (0x0B4)
> > +#define SPR_DAWR1             (0x0B5)
> >   #define SPR_RPR               (0x0BA)
> >   #define SPR_CIABR             (0x0BB)
> >   #define SPR_DAWRX0            (0x0BC)
> > +#define SPR_DAWRX1            (0x0BD)
> >   #define SPR_HFSCR             (0x0BE)
> >   #define SPR_VRSAVE            (0x100)
> >   #define SPR_USPRG0            (0x100)
> > diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> > index aeff71d063..c688e52928 100644
> > --- a/target/ppc/cpu_init.c
> > +++ b/target/ppc/cpu_init.c
> > @@ -5131,6 +5131,20 @@ static void register_book3s_207_dbg_sprs(CPUPPCS=
tate *env)
> >                           KVM_REG_PPC_CIABR, 0x00000000);
> >   }
> >=20
> > +static void register_book3s_310_dbg_sprs(CPUPPCState *env)
> > +{
> > +    spr_register_kvm_hv(env, SPR_DAWR1, "DAWR1",
> > +                        SPR_NOACCESS, SPR_NOACCESS,
> > +                        SPR_NOACCESS, SPR_NOACCESS,
> > +                        &spr_read_generic, &spr_write_generic,
> > +                        KVM_REG_PPC_DAWR1, 0x00000000);
> > +    spr_register_kvm_hv(env, SPR_DAWRX1, "DAWRX1",
> > +                        SPR_NOACCESS, SPR_NOACCESS,
> > +                        SPR_NOACCESS, SPR_NOACCESS,
> > +                        &spr_read_generic, &spr_write_generic32,
> > +                        KVM_REG_PPC_DAWRX1, 0x00000000);
> > +}
> > +
> >   static void register_970_dbg_sprs(CPUPPCState *env)
> >   {
> >       /* Breakpoints */
> > @@ -6435,6 +6449,7 @@ static void init_proc_POWER10(CPUPPCState *env)
> >       /* Common Registers */
> >       init_proc_book3s_common(env);
> >       register_book3s_207_dbg_sprs(env);
> > +    register_book3s_310_dbg_sprs(env);
> >=20
> >       /* Common TCG PMU */
> >       init_tcg_pmu_power8(env);
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index a8a935e267..05f68d2d91 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -89,6 +89,7 @@ static int cap_large_decr;
> >   static int cap_fwnmi;
> >   static int cap_rpt_invalidate;
> >   static int cap_ail_mode_3;
> > +static int cap_dawr1;
> >=20
> >   static uint32_t debug_inst_opcode;
> >=20
> > @@ -138,6 +139,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
> >       cap_ppc_nested_kvm_hv =3D kvm_vm_check_extension(s, KVM_CAP_PPC_N=
ESTED_HV);
> >       cap_large_decr =3D kvmppc_get_dec_bits();
> >       cap_fwnmi =3D kvm_vm_check_extension(s, KVM_CAP_PPC_FWNMI);
> > +    cap_dawr1 =3D kvm_vm_check_extension(s, KVM_CAP_PPC_DAWR1);
> >       /*
> >        * Note: setting it to false because there is not such capability
> >        * in KVM at this moment.
> > @@ -2109,6 +2111,16 @@ int kvmppc_set_fwnmi(PowerPCCPU *cpu)
> >       return kvm_vcpu_enable_cap(cs, KVM_CAP_PPC_FWNMI, 0);
> >   }
> >=20
> > +bool kvmppc_has_cap_dawr1(void)
> > +{
> > +    return !!cap_dawr1;
> > +}
> > +
> > +int kvmppc_set_cap_dawr1(int enable)
> > +{
> > +    return kvm_vm_enable_cap(kvm_state, KVM_CAP_PPC_DAWR1, 0, enable);
> > +}
> > +
> >   int kvmppc_smt_threads(void)
> >   {
> >       return cap_ppc_smt ? cap_ppc_smt : 1;
> > diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> > index 611debc3ce..584916a6d1 100644
> > --- a/target/ppc/kvm_ppc.h
> > +++ b/target/ppc/kvm_ppc.h
> > @@ -67,6 +67,8 @@ bool kvmppc_has_cap_htm(void);
> >   bool kvmppc_has_cap_mmu_radix(void);
> >   bool kvmppc_has_cap_mmu_hash_v3(void);
> >   bool kvmppc_has_cap_xive(void);
> > +bool kvmppc_has_cap_dawr1(void);
> > +int kvmppc_set_cap_dawr1(int enable);
> >   int kvmppc_get_cap_safe_cache(void);
> >   int kvmppc_get_cap_safe_bounds_check(void);
> >   int kvmppc_get_cap_safe_indirect_branch(void);
> > @@ -352,6 +354,16 @@ static inline bool kvmppc_has_cap_xive(void)
> >       return false;
> >   }
> >=20
> > +static inline bool kvmppc_has_cap_dawr1(void)
> > +{
> > +    return false;
> > +}
> > +
> > +static inline int kvmppc_set_cap_dawr1(int enable)
> > +{
> > +    abort();
> > +}
> > +
> >   static inline int kvmppc_get_cap_safe_cache(void)
> >   {
> >       return 0;
> >=20
> >=20



--=20
Greg

