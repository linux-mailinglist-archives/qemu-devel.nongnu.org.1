Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 066BD95581B
	for <lists+qemu-devel@lfdr.de>; Sat, 17 Aug 2024 15:25:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfIcg-0005up-TL; Sat, 17 Aug 2024 08:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@szczek.dev>) id 1sfIcd-0005sk-3m
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 08:33:31 -0400
Received: from mail-4317.proton.ch ([185.70.43.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@szczek.dev>) id 1sfIcb-0004tb-0b
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 08:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szczek.dev;
 s=protonmail3; t=1723898006; x=1724157206;
 bh=Csm1pOE8jE5m94kJ6LApwzPc0/yzGlVC7GRZGP3aqBU=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=BeVw6U/m1ctXRiM69MAFNEo6ToqjTYEPPiFebRp8tGWu0F1jsseb1AMAjagzkjyhG
 8HSZ8aFFUr0H8dcGvLqIO4Q60rHkpVhyfGTdKeHOYk2Wmg4nYPsSWRo34MzL5TMC4N
 /s4cc9SH1j87iMiPX0fdz8KYvdulUnqbvbQVWmCQlUOHq0oaxtu2hXRFfL5B980MjI
 CCH3X+2UBMaqB9qeaSmR16CynrBgXZK8TpuYYQ7VaOEnCHdWdXLXIwswQLarN6PrMN
 pX28V9EIOth6LxU/Psuf9F6rjX4Ve69rI4NxdG4t9M5I5ojoeOk4rSxcp4gdjcU1BF
 jSVOaIy1btOag==
Date: Sat, 17 Aug 2024 12:33:23 +0000
To: Bernhard Beschow <shentey@gmail.com>
From: =?utf-8?Q?Kamil_Szcz=C4=99k?= <kamil@szczek.dev>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] hw/i386/pc: Warn about unsatisfied vmport deps
Message-ID: <vQeoaqqQu2wnU_oJzBBfc1I2T4gs5dhPVfHkjhekdBs5hHqgVcyqT-UQeZPFRo8mXFnTSfIRitw90S5PCETh2wGNz6hwL_fEnep7vmOQoVk=@szczek.dev>
In-Reply-To: <FFCCC526-C9CD-4C60-856E-968413BF5455@gmail.com>
References: <vsm1ly2eX009LRKgURcMp6qTYHWw1bZd3zg2GUbd4M90T91QvJRdKxiRS3rPl8PR96y2r890Am3Ajf4kQrwihn7-7hKBU9VicRPPtIRv_GI=@szczek.dev>
 <0D723368-3251-4D5E-A625-73169CBE3395@gmail.com>
 <qT_ps6medVHIOIF5hUE_tIMUtEdbHQw5wnhE2ZVauM1cpnfHXqnl9-hroGS-3due9uRtKlMR5RsREbzeIV_0Xp1-FM0w4UDFsvdo3PsIG6U=@szczek.dev>
 <30A32FEE-B310-49E7-8D79-746C786C3CE3@gmail.com>
 <FFCCC526-C9CD-4C60-856E-968413BF5455@gmail.com>
Feedback-ID: 37679334:user:proton
X-Pm-Message-ID: 6d7ef32f5da3b32c30d1a634743caca19610b6ef
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.17; envelope-from=kamil@szczek.dev;
 helo=mail-4317.proton.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001,
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

On Saturday, August 17th, 2024 at 13:59, Bernhard Beschow <shentey@gmail.co=
m> wrote:

>=20
> Am 17. August 2024 11:54:42 UTC schrieb Bernhard Beschow shentey@gmail.co=
m:
>=20
> > Am 17. August 2024 08:49:05 UTC schrieb "Kamil Szcz=C4=99k" kamil@szcze=
k.dev:
> >=20
> > > On Friday, August 16th, 2024 at 15:14, Bernhard Beschow shentey@gmail=
.com wrote:
> > >=20
> > > > Am 14. August 2024 11:10:16 UTC schrieb "Kamil Szcz=C4=99k" kamil@s=
zczek.dev:
> > > >=20
> > > > > Since commit 4ccd5fe22feb95137d325f422016a6473541fe9f ('pc: add o=
ption
> > > > > to disable PS/2 mouse/keyboard'), the vmport will not be created =
unless
> > > > > the i8042 PS/2 controller is enabled. To not confuse users, let's=
 add a
> > > > > warning if vmport was explicitly requested, but the i8042 control=
ler is
> > > > > disabled. This also changes the behavior of vmport=3Dauto to take=
 i8042
> > > > > controller availability into account.
> > > > >=20
> > > > > Signed-off-by: Kamil Szcz=C4=99k kamil@szczek.dev
> > > > > ---
> > > > > hw/i386/pc.c | 4 ++++
> > > > > hw/i386/pc_piix.c | 3 ++-
> > > > > hw/i386/pc_q35.c | 2 +-
> > > > > qemu-options.hx | 4 ++--
> > > > > 4 files changed, 9 insertions(+), 4 deletions(-)
> > > > >=20
> > > > > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > > > > index c74931d577..5bd8dd0350 100644
> > > > > --- a/hw/i386/pc.c
> > > > > +++ b/hw/i386/pc.c
> > > > > @@ -1100,6 +1100,10 @@ static void pc_superio_init(ISABus *isa_bu=
s, bool create_fdctrl,
> > > > > }
> > > > >=20
> > > > > if (!create_i8042) {
> > > > > + if (!no_vmport) {
> > > > > + warn_report("vmport requires the i8042 controller to be enabled=
");
> > > > > + }
> > > > > +
> > > > > return;
> > > > > }
> > > > >=20
> > > > > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > > > > index d9e69243b4..cf2e2e3e30 100644
> > > > > --- a/hw/i386/pc_piix.c
> > > > > +++ b/hw/i386/pc_piix.c
> > > > > @@ -312,7 +312,8 @@ static void pc_init1(MachineState *machine, c=
onst char *pci_type)
> > > > >=20
> > > > > assert(pcms->vmport !=3D ON_OFF_AUTO__MAX);
> > > > > if (pcms->vmport =3D=3D ON_OFF_AUTO_AUTO) {
> > > > > - pcms->vmport =3D xen_enabled() ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_=
ON;
> > > > > + pcms->vmport =3D (xen_enabled() || !pcms->i8042_enabled)
> > > > > + ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;
> > > > > }
> > > >=20
> > > > I think it makes sense to consolidate this handling into pc_basic_d=
evices_init() before doing this change. Maybe just in front of the call to =
pc_superio_init()? The additional handling of xen_enabled() shouldn't hurt =
there for q35: Even though q35 doesn't (yet) support Xen there are already =
code paths where this check is done.
> > >=20
> > > Makes sense technically, but since I'm new to the mailing list workfl=
ow I could use some help with logistics. I've already posted a v2 of this p=
atch which was reviewed and accepted,
> >=20
> > Ouch, I've missed that.
> >=20
> > > should I wait for it to be pulled in and post a follow-up patch or po=
st another revision of this patch?
> >=20
> > Since Michael already tagged it, it seems safer to follow up with a new=
 series or patch. You can use the `Based-on:` tag there to make the depende=
ncy of the new series explicit. See [1] for inspiration. To determine the m=
ail ID look up this series on lore.kernel.org/qemu-devel .
>=20
>=20
> Of course I meant the tagged version: https://lore.kernel.org/qemu-devel/=
CJaQOvoJMl8P04F7-0Pk23paXt29GnSt2ICM-xlruQ9rGsMHocU_xH3RRaRRJEQpqUxGo63sATZ=
b5St7968jHLV0r7NORODN3zHgi_qxpPE=3D@szczek.dev/

I've got the OK from Michael to post v3, but thanks for that nonetheless. W=
ill definitely come in handy in the future.

>=20
> > Best regards,
> > Bernhard
> >=20
> > [1] https://patchew.org/QEMU/20230105143228.244965-1-shentey@gmail.com/
> >=20
> > > > > /* init basic PC hardware */
> > > > > diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> > > > > index 9d108b194e..6c112d804d 100644
> > > > > --- a/hw/i386/pc_q35.c
> > > > > +++ b/hw/i386/pc_q35.c
> > > > > @@ -278,7 +278,7 @@ static void pc_q35_init(MachineState *machine=
)
> > > > >=20
> > > > > assert(pcms->vmport !=3D ON_OFF_AUTO__MAX);
> > > > > if (pcms->vmport =3D=3D ON_OFF_AUTO_AUTO) {
> > > > > - pcms->vmport =3D ON_OFF_AUTO_ON;
> > > > > + pcms->vmport =3D pcms->i8042_enabled ? ON_OFF_AUTO_ON : ON_OFF_=
AUTO_OFF;
> > > > > }
> > > > >=20
> > > > > /* init basic PC hardware */
> > > > > diff --git a/qemu-options.hx b/qemu-options.hx
> > > > > index cee0da2014..0bc780a669 100644
> > > > > --- a/qemu-options.hx
> > > > > +++ b/qemu-options.hx
> > > > > @@ -68,8 +68,8 @@ SRST
> > > > >=20
> > > > > `vmport=3Don|off|auto`
> > > > > Enables emulation of VMWare IO port, for vmmouse etc. auto says
> > > > > - to select the value based on accel. For accel=3Dxen the default=
 is
> > > > > - off otherwise the default is on.
> > > > > + to select the value based on accel and i8042. For accel=3Dxen
> > > > > + and/or i8042=3Doff the default is off otherwise the default is =
on.
> > > >=20
> > > > I'd do s#and/or#or# for readability.
> > > >=20
> > > > Best regards,
> > > > Bernhard
> > > >=20
> > > > > `dump-guest-core=3Don|off`
> > > > > Include guest memory in a core dump. The default is on.

