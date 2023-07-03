Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA3774587E
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 11:36:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGFxw-0001HA-BX; Mon, 03 Jul 2023 05:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1qGFxr-0001Gl-Fi
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 05:35:23 -0400
Received: from 7.mo548.mail-out.ovh.net ([46.105.33.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1qGFxo-00082S-8T
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 05:35:23 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.4.240])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 7FC67219CA;
 Mon,  3 Jul 2023 09:35:10 +0000 (UTC)
Received: from kaod.org (37.59.142.95) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 3 Jul
 2023 11:35:09 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G0010ebeb8e6-190d-46cd-afc8-1fdd3cbb39d1,
 402CDD763E8F3FE895DD118CE8F9FDD198E40389) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 78.197.208.248
Date: Mon, 3 Jul 2023 11:35:08 +0200
From: Greg Kurz <groug@kaod.org>
To: Narayana Murty N <nnmlinux@linux.ibm.com>
CC: <danielhb413@gmail.com>, <clg@kaod.org>, <david@gibson.dropbear.id.au>,
 <npiggin@gmail.com>, <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>,
 <farosas@suse.de>, <npiggin@linux.ibm.com>, <vaibhav@linux.ibm.com>,
 <harshpb@linux.ibm.com>, <sbhat@linux.ibm.com>
Subject: Re: [PATCH v4] target: ppc: Use MSR_HVB bit to get the target
 endianness for memory dump
Message-ID: <20230703113508.6af48248@bahia>
In-Reply-To: <20230623072506.34713-1-nnmlinux@linux.ibm.com>
References: <20230623072506.34713-1-nnmlinux@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.95]
X-ClientProxiedBy: DAG8EX2.mxp5.local (172.16.2.72) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: 25935476-5ac0-4ea3-a3e9-10415b34ed80
X-Ovh-Tracer-Id: 10830594156293560824
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedruddvgdduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvfevuffkjghfofggtgfgihesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnheptdefgeduhfegkefhhedtueffgedvhfekheegvdduveevhfeiueetgfevjeeuveeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddrleehpdejkedrudeljedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehgrhhouhhgsehkrghougdrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepnhhnmhhlihhnuhigsehlihhnuhigrdhisghmrdgtohhmpdgurghnihgvlhhhsgegudefsehgmhgrihhlrdgtohhmpdgurghvihgusehgihgsshhonhdrughrohhpsggvrghrrdhiugdrrghupdhnphhighhgihhnsehgmhgrihhlrdgtohhmpdhqvghmuhdqphhptgesnhhonhhgnhhurdhorhhgpdhqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhfrghrohhsrghssehsuhhsvgdruggvpdhnphhighhgihhnsehlihhnuhigrdhisghmrdgtohhmpd
 hvrghisghhrghvsehlihhnuhigrdhisghmrdgtohhmpdhhrghrshhhphgssehlihhnuhigrdhisghmrdgtohhmpdhssghhrghtsehlihhnuhigrdhisghmrdgtohhmpdgtlhhgsehkrghougdrohhrghdpoffvtefjohhsthepmhhoheegkedpmhhouggvpehsmhhtphhouhht
Received-SPF: pass client-ip=46.105.33.25; envelope-from=groug@kaod.org;
 helo=7.mo548.mail-out.ovh.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 23 Jun 2023 03:25:06 -0400
Narayana Murty N <nnmlinux@linux.ibm.com> wrote:

> Currently on PPC64 qemu always dumps the guest memory in
> Big Endian (BE) format even though the guest running in Little Endian
> (LE) mode. So crash tool fails to load the dump as illustrated below:
>=20
> Log :
> $ virsh dump DOMAIN --memory-only dump.file
>=20
> Domain 'DOMAIN' dumped to dump.file
>=20
> $ crash vmlinux dump.file
>=20
> <snip>
> crash 8.0.2-1.el9
>=20
> WARNING: endian mismatch:
>           crash utility: little-endian
>           dump.file: big-endian
>=20
> WARNING: machine type mismatch:
>           crash utility: PPC64
>           dump.file: (unknown)
>=20
> crash: dump.file: not a supported file format
> <snip>
>=20
> This happens because cpu_get_dump_info() passes cpu->env->has_hv_mode
> to function ppc_interrupts_little_endian(), the cpu->env->has_hv_mode
> always set for powerNV even though the guest is not running in hv mode.
> The hv mode should be taken from msr_mask MSR_HVB bit
> (cpu->env.msr_mask & MSR_HVB). This patch fixes the issue by passing
> MSR_HVB value to ppc_interrupts_little_endian() in order to determine
> the guest endianness.
>=20
> The crash tool also expects guest kernel endianness should match the
> endianness of the dump.
>=20
> The patch was tested on POWER9 box booted with Linux as host in
> following cases:
>=20
> Host-Endianess Qemu-Target-Machine                Qemu-Generated-Guest
>                                                   Memory-Dump-Format
> BE             powernv(OPAL/PowerNV)                   LE
> BE             powernv(OPAL/PowerNV)                   BE
> LE             powernv(OPAL/PowerNV)                   LE
> LE             powernv(OPAL/PowerNV)                   BE
> LE             pseries(OPAL/PowerNV/pSeries) KVMHV     LE
> LE             pseries TCG                             LE
>=20
> Fixes: 5609400a4228 ("target/ppc: Set the correct endianness for powernv =
memory
> dumps")
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---

Thanks !

Reviewed-by: Greg Kurz <groug@kaod.org>

> Changes since V3:
> commit message modified as per feedback from Greg Kurz, C=C3=A9dric Le
> Goater and Nicholas Piggin.
> Changes since V2:
> commit message modified as per feedback from Nicholas Piggin.
> Changes since V1:
> https://lore.kernel.org/qemu-devel/20230420145055.10196-1-nnmlinux@linux.=
ibm.com/
> The approach to solve the issue was changed based on feedback from
> Fabiano Rosas on patch V1.
> ---
>  target/ppc/arch_dump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
> index f58e6359d5..a8315659d9 100644
> --- a/target/ppc/arch_dump.c
> +++ b/target/ppc/arch_dump.c
> @@ -237,7 +237,7 @@ int cpu_get_dump_info(ArchDumpInfo *info,
>      info->d_machine =3D PPC_ELF_MACHINE;
>      info->d_class =3D ELFCLASS;
> =20
> -    if (ppc_interrupts_little_endian(cpu, cpu->env.has_hv_mode)) {
> +    if (ppc_interrupts_little_endian(cpu, !!(cpu->env.msr_mask & MSR_HVB=
))) {
>          info->d_endian =3D ELFDATA2LSB;
>      } else {
>          info->d_endian =3D ELFDATA2MSB;



--=20
Greg

