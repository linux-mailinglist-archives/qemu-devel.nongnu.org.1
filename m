Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 386C8714B81
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 16:05:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3dUp-0008R2-Mx; Mon, 29 May 2023 10:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q3dUo-0008Pt-7V; Mon, 29 May 2023 10:05:14 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q3dUm-00085D-CN; Mon, 29 May 2023 10:05:13 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C7B011F8D7;
 Mon, 29 May 2023 14:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1685369109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tuaqVehZpaTUfTQZt+bC/s2xCVD+ZQ2WOnxlCDcqYxw=;
 b=xuNUibAbHoMhX2kLi19Pog7zt1lPdoGOjwLG7bHTYR9U1mhaROORBlcsnb8TgZv7/51ncd
 HOUMjUQjvLKUL1Q7OwGJ4gLxHYfe9y899NgriHz4Ad5Q55TnFG3wAh93FnqxAoukQ4iY1c
 bqc7ywaRbEJUiFJidcDdRExy2NZs6C8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1685369109;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tuaqVehZpaTUfTQZt+bC/s2xCVD+ZQ2WOnxlCDcqYxw=;
 b=srvbEg4zXQbeIWVxTGe6UOVdCK50uDmxyfRrBzTxpZeewxL566BXCjj33TYLKaIPhJlquA
 E71fOqv10TeLWSBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 50AC41332D;
 Mon, 29 May 2023 14:05:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nUMqBxWxdGROMQAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 29 May 2023 14:05:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Nicholas Piggin <npiggin@gmail.com>, Narayana Murty N
 <nnmlinux@linux.ibm.com>, danielhb413@gmail.com, clg@kaod.org,
 david@gibson.dropbear.id.au, groug@kaod.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@linux.ibm.com,
 vaibhav@linux.ibm.com, harshpb@linux.ibm.com, sbhat@linux.ibm.com
Subject: Re: [PATCH v3] target: ppc: Use MSR_HVB bit to get the target
 endianness for memory dump
In-Reply-To: <CSYG8RTMAB5O.2H9DDPSRE7JR0@wheely>
References: <20230522160242.37261-1-nnmlinux@linux.ibm.com>
 <CSYG8RTMAB5O.2H9DDPSRE7JR0@wheely>
Date: Mon, 29 May 2023 11:05:06 -0300
Message-ID: <87pm6js06l.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

"Nicholas Piggin" <npiggin@gmail.com> writes:

> On Tue May 23, 2023 at 2:02 AM AEST, Narayana Murty N wrote:
>> Changes since V2:
>> commit message modified as per feedbak from Nicholas Piggin.
>> Changes since V1:
>> https://lore.kernel.org/qemu-devel/20230420145055.10196-1-nnmlinux@linux.ibm.com/
>> The approach to solve the issue was changed based on feedback from
>> Fabiano Rosas on patch V1.
>> ---
>>  target/ppc/arch_dump.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
>> index f58e6359d5..a8315659d9 100644
>> --- a/target/ppc/arch_dump.c
>> +++ b/target/ppc/arch_dump.c
>> @@ -237,7 +237,7 @@ int cpu_get_dump_info(ArchDumpInfo *info,
>>      info->d_machine = PPC_ELF_MACHINE;
>>      info->d_class = ELFCLASS;
>>  
>> -    if (ppc_interrupts_little_endian(cpu, cpu->env.has_hv_mode)) {
>> +    if (ppc_interrupts_little_endian(cpu, !!(cpu->env.msr_mask & MSR_HVB))) {
>>          info->d_endian = ELFDATA2LSB;
>>      } else {
>>          info->d_endian = ELFDATA2MSB;
>
> Oh, and now I see it cpu_get_dump_info just picks the first CPU to test
> this! So a test that can change at runtime is surely not the right one.
> If you use MSR[HV] then if you have a SMP machine that is doing a bunch
> of things and you want to dump to debug the system, this will just
> randomly give you a wrong-endian dump if CPU0 just happened to be
> running some KVM guest.
>

Not sure if you are just thinking out loud about MSR_HV or if you
mistook MSR_HVB for MSR_HV. But just in case:

The env->msr_mask is what tells us what MSR bits are supported for this
CPU, i.e. what features it contains. So MSR_HVB is not equivalent to
MSR[HV], but merely informs that this CPU knows about MSR_HV. We then
store that information at has_hv_mode. The MSR_HVB bit changes only
once (at cpu_ppc_set_vhyp), after we decide whether to use vhyp. So:

env->has_hv_mode == cpu supports HV mode;

MSR_HVB=1 == cpu supports HV mode AND we allow the OS to run with MSR_HV=1;

MSR_HVB=0 == cpu doesn't support HV mode OR
             cpu supports HV mode, but we don't allow the OS to run with
             MSR_HV=1 because QEMU is the HV (i.e. vhyp);

For the arch_dump code, passing (msr_mask & MSR_HVB) ends up meaning:
"can this OS ever run with MSR_HV=1?", which for emulated powernv would
be Yes and for pseries (incl. nested) would be No. So for emulated
powernv we always look at the emulated HILE and for pseries we always
look at LPCR_ILE.

> But even ignoring all of that, let's say you have all the same endian
> host and guest kernels and dump format... If you dump host memory then
> you need host kernel and structures to debug guest kernel/image
> (assuming crash or the person debugging it is smart enough to make sense
> of it). So I don't see how you can sanely use the crash dump of host
> memory with the guest kernel. I must still be missing something.
>

You're right, the QEMU instance that receives the qmp_dump_guest_memory
command should generate a memory dump of whatever OS is running in it at
a direct level.  So the endianness reported in the dump's ELF should
match the guest OS image ELF (roughly, there's -bios which doesn't
require an ELF).

