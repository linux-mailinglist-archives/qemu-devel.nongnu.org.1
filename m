Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5132A70DA6E
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 12:25:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1PAM-0005DX-0u; Tue, 23 May 2023 06:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1q1PAJ-0005Cd-VE; Tue, 23 May 2023 06:22:52 -0400
Received: from 7.mo548.mail-out.ovh.net ([46.105.33.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1q1PAH-0003rD-9r; Tue, 23 May 2023 06:22:51 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.180])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id EB97A20233;
 Tue, 23 May 2023 10:22:38 +0000 (UTC)
Received: from kaod.org (37.59.142.106) by DAG4EX2.mxp5.local (172.16.2.32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 23 May
 2023 12:22:38 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R006673cc451-2107-4999-8519-aacbf635d1c3,
 3FF756ED2DFBFFA1C653908339DD7057409F5F10) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <b73560c5-6422-bc5b-1819-ca0ea41e2baf@kaod.org>
Date: Tue, 23 May 2023 12:22:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] target: ppc: Use MSR_HVB bit to get the target
 endianness for memory dump
Content-Language: en-US
To: Narayana Murty N <nnmlinux@linux.ibm.com>, <danielhb413@gmail.com>,
 <david@gibson.dropbear.id.au>, <groug@kaod.org>, <npiggin@gmail.com>
CC: <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>, <farosas@suse.de>,
 <npiggin@linux.ibm.com>, <vaibhav@linux.ibm.com>, <harshpb@linux.ibm.com>,
 <sbhat@linux.ibm.com>
References: <20230522160242.37261-1-nnmlinux@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230522160242.37261-1-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG4EX2.mxp5.local (172.16.2.32) To DAG4EX2.mxp5.local
 (172.16.2.32)
X-Ovh-Tracer-GUID: 0d72b591-e2f7-4b80-a934-4e32e678d35d
X-Ovh-Tracer-Id: 10659457368877861880
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejfedgvdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefkffggfgfuvfevfhfhjggtgfhisehtjeertddtfeejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepkefhvefhheeiffduvefhfeeitefhleevudfgkedujeduieetfeffgfffvdelueelnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddruddtiedpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoegtlhhgsehkrghougdrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepnhhnmhhlihhnuhigsehlihhnuhigrdhisghmrdgtohhmpdgurghnihgvlhhhsgegudefsehgmhgrihhlrdgtohhmpdgurghvihgusehgihgsshhonhdrughrohhpsggvrghrrdhiugdrrghupdhnphhighhgihhnsehgmhgrihhlrdgtohhmpdhqvghmuhdqphhptgesnhhonhhgnhhurdhorhhgpdhqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhfrghrohhsrghssehsuhhsvgdruggvpdhnphhighhgihhnsehlihhnuhigrdhisghmrd
 gtohhmpdhvrghisghhrghvsehlihhnuhigrdhisghmrdgtohhmpdhhrghrshhhphgssehlihhnuhigrdhisghmrdgtohhmpdhssghhrghtsehlihhnuhigrdhisghmrdgtohhmpdhgrhhouhhgsehkrghougdrohhrghdpoffvtefjohhsthepmhhoheegkedpmhhouggvpehsmhhtphhouhht
Received-SPF: pass client-ip=46.105.33.25; envelope-from=clg@kaod.org;
 helo=7.mo548.mail-out.ovh.net
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 5/22/23 18:02, Narayana Murty N wrote:
> Currently on PPC64 qemu always dumps the guest memory in
> Big Endian (BE) format even though the guest running in Little Endian



The patch is surely correct. I have problems understanding the config
you are testing. PPC Book3s has multiple hypervisor implementations :

1. pHyp (AKA PowerVM)
2. OPAL/PowerNV (AKA Power KVM-HV)
3. OPAL/PowerNV/pSeries (AKA Power KVMHV-on-pSeries)
4. pHyp/pSeries (very recent implementation, I don't know how it is
    referred to in the kernel)

I am leaving the KVM-PR implementation out of the discussions for
simplicity.

QEMU also supports emulation of 2. and 3. in two different machines
PowerNV and pseries, although running pseries guests under a PowerNV
machine is slow, so is running pseries guests under pseries.

Could you please describe your environment ?

Thanks,

C.



> (LE) mode. So crash tool fails to load the dump as illustrated below:
> 
> Log :
> $ virsh dump DOMAIN --memory-only dump.file
> 
> Domain 'DOMAIN' dumped to dump.file
> 
> $ crash vmlinux dump.file
> 
> <snip>
> crash 8.0.2-1.el9
> 
> WARNING: endian mismatch:
>            crash utility: little-endian
>            dump.file: big-endian
> 
> WARNING: machine type mismatch:
>            crash utility: PPC64
>            dump.file: (unknown)
> 
> crash: dump.file: not a supported file format
> <snip>
> 
> This happens because cpu_get_dump_info() passes cpu->env->has_hv_mode
> to function ppc_interrupts_little_endian(), the cpu->env->has_hv_mode
> always set for powerNV even though the guest is not running in hv mode.
> The hv mode should be taken from msr_mask MSR_HVB bit
> (cpu->env.msr_mask & MSR_HVB). This patch fixes the issue by passing
> MSR_HVB value to ppc_interrupts_little_endian() in order to determine
> the guest endianness.
> 
> The crash tool also expects guest kernel endianness should match the
> endianness of the dump.
> 
> The patch was tested on POWER9 box booted with Linux as host in
> following cases:
> 
> Host-Endianess Qemu-Target-Machine Qemu-Guest-Endianess  Qemu-Generated-Guest
>                                                            Memory-Dump-Format
> BE             powernv             LE KVM guest                 LE
> BE             powernv             BE KVM guest                 BE
> LE             powernv             LE KVM guest                 LE
> LE             powernv             BE KVM guest                 BE
> LE             pseries KVM         LE KVM guest                 LE
> LE             pseries TCG         LE guest                     LE
> 
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
> Changes since V2:
> commit message modified as per feedbak from Nicholas Piggin.
> Changes since V1:
> https://lore.kernel.org/qemu-devel/20230420145055.10196-1-nnmlinux@linux.ibm.com/
> The approach to solve the issue was changed based on feedback from
> Fabiano Rosas on patch V1.
> ---
>   target/ppc/arch_dump.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
> index f58e6359d5..a8315659d9 100644
> --- a/target/ppc/arch_dump.c
> +++ b/target/ppc/arch_dump.c
> @@ -237,7 +237,7 @@ int cpu_get_dump_info(ArchDumpInfo *info,
>       info->d_machine = PPC_ELF_MACHINE;
>       info->d_class = ELFCLASS;
>   
> -    if (ppc_interrupts_little_endian(cpu, cpu->env.has_hv_mode)) {
> +    if (ppc_interrupts_little_endian(cpu, !!(cpu->env.msr_mask & MSR_HVB))) {
>           info->d_endian = ELFDATA2LSB;
>       } else {
>           info->d_endian = ELFDATA2MSB;


