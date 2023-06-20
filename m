Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52588736F0F
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 16:48:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBcea-0008DD-IP; Tue, 20 Jun 2023 10:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1qBceY-0008BA-MB
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 10:48:18 -0400
Received: from 6.mo548.mail-out.ovh.net ([188.165.58.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1qBceV-0000QE-Qd
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 10:48:17 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.4.66])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 3A74320C63;
 Tue, 20 Jun 2023 14:48:05 +0000 (UTC)
Received: from kaod.org (37.59.142.95) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 20 Jun
 2023 16:48:04 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G0016a6684ad-52af-482e-b21c-949cbc4df826,
 26134D463BE26AE7AD6874E45E6C9094DBC59A6F) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 78.197.208.248
Date: Tue, 20 Jun 2023 16:48:03 +0200
From: Greg Kurz <groug@kaod.org>
To: Claudio Fontana <cfontana@suse.de>
CC: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, Daniel Henrique Barboza
 <danielhb413@gmail.com>, David Gibson <david@gibson.dropbear.id.au>,
 <qemu-ppc@nongnu.org>
Subject: Re: [PATCH] hw/ppc/spapr: Test whether TCG is enabled with
 tcg_enabled()
Message-ID: <20230620164803.0aa623e6@bahia>
In-Reply-To: <eb064809-7253-899a-97d1-635eb652b7fd@suse.de>
References: <20230620074802.86898-1-philmd@linaro.org>
 <eb064809-7253-899a-97d1-635eb652b7fd@suse.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.95]
X-ClientProxiedBy: DAG7EX2.mxp5.local (172.16.2.62) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: 8ef3f157-9a5c-4747-af7a-53b11a992838
X-Ovh-Tracer-Id: 13557242256497678700
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefhedgheelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfofggtgfgihesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepueeuieejtdelleeutdfhteejffeiteffueevffeffeetvdeifeeujefgudegteeunecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrdelhedpjeekrdduleejrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoghhrohhugheskhgrohgurdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopegtfhhonhhtrghnrgesshhushgvrdguvgdpphhhihhlmhgusehlihhnrghrohdrohhrghdpqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdphhgrrhhshhhpsgeslhhinhhugidrihgsmhdrtghomhdpuggrnhhivghlhhgsgedufeesghhmrghilhdrtghomhdpuggrvhhiugesghhisghsohhnrdgurhhophgsvggrrhdrihgurdgruhdpqhgvmhhuqdhpphgtsehnohhnghhnuhdrohhrghdptghlgheskhgrohgurdhorhhgpdfovfetjfhoshhtpe
 hmohehgeekpdhmohguvgepshhmthhpohhuth
Received-SPF: pass client-ip=188.165.58.48; envelope-from=groug@kaod.org;
 helo=6.mo548.mail-out.ovh.net
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

On Tue, 20 Jun 2023 09:55:49 +0200
Claudio Fontana <cfontana@suse.de> wrote:

> On 6/20/23 09:48, Philippe Mathieu-Daud=C3=A9 wrote:
> > Although the PPC target only supports the TCG and KVM
> > accelerators, QEMU supports more. We can no assume that
> > '!kvm =3D=3D tcg', so test for the correct accelerator. This
> > also eases code review, because here we don't care about
> > KVM, we really want to test for TCG.
> >=20
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>=20
> I don't remember anymore, but what about qtest ? It is usually the forgot=
ten case in these kind of tests... so much complexity :-)
>=20

This check was added with TCG in mind because it is a known limitation.
I don't see any reason to prevent qtest from being used with the rest
of this function though.

> Ciao,
>=20
> Claudio
>=20
>=20
> > ---
> >  hw/ppc/spapr.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index dcb7f1c70a..c4b666587b 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2524,7 +2524,7 @@ static void spapr_set_vsmt_mode(SpaprMachineState=
 *spapr, Error **errp)
> >      int ret;
> >      unsigned int smp_threads =3D ms->smp.threads;
> > =20
> > -    if (!kvm_enabled() && (smp_threads > 1)) {
> > +    if (tcg_enabled() && (smp_threads > 1)) {

Bonjour Philippe,

Please drop the unneeded parens in the second check.

With this fixed,

Reviewed-by: Greg Kurz <groug@kaod.org>

Cheers,

--
Greg

> >          error_setg(errp, "TCG cannot support more than 1 thread/core "
> >                     "on a pseries machine");
> >          return;
>=20



--=20
Greg

