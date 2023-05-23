Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E347670DA2B
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 12:18:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1P3N-0006dG-IQ; Tue, 23 May 2023 06:15:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1q1P3L-0006cO-3k
 for qemu-devel@nongnu.org; Tue, 23 May 2023 06:15:39 -0400
Received: from smtpout3.mo529.mail-out.ovh.net ([46.105.54.81])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1q1P3H-0001hR-RK
 for qemu-devel@nongnu.org; Tue, 23 May 2023 06:15:38 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.1.250])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 8BB0C21DF6;
 Tue, 23 May 2023 10:15:31 +0000 (UTC)
Received: from kaod.org (37.59.142.102) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 23 May
 2023 12:15:30 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-102R004ad17168d-9d52-4d6f-a36f-8df47cb818b6,
 5354F1BE48D8676E327CF87D7838D956CE2421D7) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 78.197.208.248
Date: Tue, 23 May 2023 12:15:29 +0200
From: Greg Kurz <groug@kaod.org>
To: Narayana Murty N <nnmlinux@linux.vnet.ibm.com>
CC: Narayana Murty N <nnmlinux@linux.ibm.com>, <danielhb413@gmail.com>,
 <clg@kaod.org>, <david@gibson.dropbear.id.au>, <npiggin@gmail.com>,
 <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>, <farosas@suse.de>,
 <npiggin@linux.ibm.com>, <vaibhav@linux.ibm.com>, <harshpb@linux.ibm.com>,
 <sbhat@linux.ibm.com>
Subject: Re: [PATCH v3] target: ppc: Use MSR_HVB bit to get the target
 endianness for memory dump
Message-ID: <20230523121529.57739259@bahia>
In-Reply-To: <29625575-d8f1-a66a-6d5a-0ce28a486525@linux.vnet.ibm.com>
References: <20230522160242.37261-1-nnmlinux@linux.ibm.com>
 <20230522202024.735f02a6@bahia>
 <29625575-d8f1-a66a-6d5a-0ce28a486525@linux.vnet.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.102]
X-ClientProxiedBy: DAG5EX1.mxp5.local (172.16.2.41) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: e9390875-dbad-4578-b303-45766f492d93
X-Ovh-Tracer-Id: 10539267554478234043
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejfedgvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfhisehtjeeftdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeelkeevfedujeduvdelgffhgeekudevveekhfejteeffeduheefffdvfefhhefhhfenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddruddtvddpjeekrdduleejrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoghhrohhugheskhgrohgurdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehnnhhmlhhinhhugieslhhinhhugidrvhhnvghtrdhisghmrdgtohhmpdhnnhhmlhhinhhugieslhhinhhugidrihgsmhdrtghomhdpuggrnhhivghlhhgsgedufeesghhmrghilhdrtghomhdpuggrvhhiugesghhisghsohhnrdgurhhophgsvggrrhdrihgurdgruhdpnhhpihhgghhinhesghhmrghilhdrtghomhdpqhgvmhhuqdhpphgtsehnohhnghhnuhdrohhrghdpqhgvmhhuqdguvghvvghlsehnohhnghhnuhdroh
 hrghdpfhgrrhhoshgrshesshhushgvrdguvgdpnhhpihhgghhinheslhhinhhugidrihgsmhdrtghomhdpvhgrihgshhgrvheslhhinhhugidrihgsmhdrtghomhdphhgrrhhshhhpsgeslhhinhhugidrihgsmhdrtghomhdpshgshhgrtheslhhinhhugidrihgsmhdrtghomhdptghlgheskhgrohgurdhorhhgpdfovfetjfhoshhtpehmohehvdelpdhmohguvgepshhmthhpohhuth
Received-SPF: pass client-ip=46.105.54.81; envelope-from=groug@kaod.org;
 helo=smtpout3.mo529.mail-out.ovh.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Tue, 23 May 2023 12:20:17 +0530
Narayana Murty N <nnmlinux@linux.vnet.ibm.com> wrote:

> 
> On 5/22/23 23:50, Greg Kurz wrote:
> > On Mon, 22 May 2023 12:02:42 -0400
> > Narayana Murty N<nnmlinux@linux.ibm.com>  wrote:
> >
> >> Currently on PPC64 qemu always dumps the guest memory in
> >> Big Endian (BE) format even though the guest running in Little Endian
> >> (LE) mode. So crash tool fails to load the dump as illustrated below:
> >>
> >> Log :
> >> $ virsh dump DOMAIN --memory-only dump.file
> >>
> >> Domain 'DOMAIN' dumped to dump.file
> >>
> >> $ crash vmlinux dump.file
> >>
> >> <snip>
> >> crash 8.0.2-1.el9
> >>
> >> WARNING: endian mismatch:
> >>            crash utility: little-endian
> >>            dump.file: big-endian
> >>
> >> WARNING: machine type mismatch:
> >>            crash utility: PPC64
> >>            dump.file: (unknown)
> >>
> >> crash: dump.file: not a supported file format
> >> <snip>
> >>
> >> This happens because cpu_get_dump_info() passes cpu->env->has_hv_mode
> >> to function ppc_interrupts_little_endian(), the cpu->env->has_hv_mode
> >> always set for powerNV even though the guest is not running in hv mode.
> >> The hv mode should be taken from msr_mask MSR_HVB bit
> >> (cpu->env.msr_mask & MSR_HVB). This patch fixes the issue by passing
> >> MSR_HVB value to ppc_interrupts_little_endian() in order to determine
> >> the guest endianness.
> >>
> >> The crash tool also expects guest kernel endianness should match the
> >> endianness of the dump.
> >>
> >> The patch was tested on POWER9 box booted with Linux as host in
> >> following cases:
> >>
> >> Host-Endianess Qemu-Target-Machine Qemu-Guest-Endianess  Qemu-Generated-Guest
> >>                                                            Memory-Dump-Format
> >> BE             powernv             LE KVM guest                 LE
> >> BE             powernv             BE KVM guest                 BE
> >> LE             powernv             LE KVM guest                 LE
> >> LE             powernv             BE KVM guest                 BE
> > I don't quite understand why KVM is mentioned with the powernv machine.
> 
> guest running mode was mentioned.
> 

QEMU cannot use KVM on the host to run a powernv machine. The
guest is thus necessarily running in TCG mode.

Please describe your setup and what exactly you are testing.

> >
> > Also have you tried to dump at various moments, e.g. during skiboot
> > and when guest is booted, as in [1] which introduced the code this
> > patch is changing ?
> >
> > [1]https://github.com/qemu/qemu/commit/5609400a422809c89ea788e4d0e13124a617582e.
> >
> >> LE             pseries KVM         LE KVM guest                 LE
> >> LE             pseries TCG         LE guest                     LE
> >>
> > Fixes: 5609400a4228 ("target/ppc: Set the correct endianness for powernv memory dumps")
> 
> I agree, commit 5609400a4228 fixes endianness detection only for initial stage (skiboot) till endianness switch happens.
> However, has_hv_mode is just a capability flag which is always set based on command-line param and doesnt really represent current hv state.
> With this patch, it relies on the current state of the hv state based on the MSR_HVB of the msr_mask.
> 

Yes I see what your patch is doing. The 'Fixes: 5609400a4228 ...' line is
intended to the changelog because it is supposedly a fix to this commit.

> >
> >> Signed-off-by: Narayana Murty N<nnmlinux@linux.ibm.com>
> >> ---
> >> Changes since V2:
> >> commit message modified as per feedbak from Nicholas Piggin.
> >> Changes since V1:
> >> https://lore.kernel.org/qemu-devel/20230420145055.10196-1-nnmlinux@linux.ibm.com/
> >> The approach to solve the issue was changed based on feedback from
> >> Fabiano Rosas on patch V1.
> >> ---
> >>   target/ppc/arch_dump.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
> >> index f58e6359d5..a8315659d9 100644
> >> --- a/target/ppc/arch_dump.c
> >> +++ b/target/ppc/arch_dump.c
> >> @@ -237,7 +237,7 @@ int cpu_get_dump_info(ArchDumpInfo *info,
> >>       info->d_machine = PPC_ELF_MACHINE;
> >>       info->d_class = ELFCLASS;
> >>   
> >> -    if (ppc_interrupts_little_endian(cpu, cpu->env.has_hv_mode)) {
> >> +    if (ppc_interrupts_little_endian(cpu, !!(cpu->env.msr_mask & MSR_HVB))) {
> >>           info->d_endian = ELFDATA2LSB;
> >>       } else {
> >>           info->d_endian = ELFDATA2MSB;

