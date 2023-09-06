Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FC379412B
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 18:08:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdv3G-0001lA-4A; Wed, 06 Sep 2023 12:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdv3A-0001kg-Fx
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 12:06:40 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdv35-0006Em-AO
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 12:06:39 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9a5e1812378so603138866b.2
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 09:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694016393; x=1694621193; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CYl56d3Rr0xXl75o9KExaMUEcGUCUwZ4s1ox1DRCjPU=;
 b=hzvDvyug92+k2sXcNN1CBmw4amA8JntQ7nddAYXBDH9KLkOpImqxNyQzC2LGVtrkr2
 sC6rBPtLaG9pvHDvUKzw6pR4YE1Mz/+tWjGk9XvEWBbkZKyurkzmS9Fixh0iiygc3WNh
 Qi2ibAQnJGnFI85wzx53ux1Q1fYQF3McnxJvlVC25CCIQKwxLyiBPLzns3Xz0hPqaQZt
 XAFQ/nzhh/UiDrmEdchR/yDLGnPKWy2x8TOdJTXNEu4JBa+YMCqs46WnCj/c7tPqo95H
 10WsneQ/G/BUYR0x3MM9zVoJ+SFmNuiVxG/Dis+RzgTklHQ3nwnjDcOLhxstacrU8LGt
 TYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694016393; x=1694621193;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CYl56d3Rr0xXl75o9KExaMUEcGUCUwZ4s1ox1DRCjPU=;
 b=H018fX6imXYhvAhYIgYGyhlqHOgo9eQZhMrE1lk+Ez8dLaoisADxemkBcniHNBx3aS
 VjiRjRknpljU5ZMfKo1rwS0Aig3tdPJxkBzOJFuzLzhHE9gowJhxMK2fNWAmaOIh9P0/
 o6QXHKdfxCsnbzLmsriqgFqbSgkS79LsfEA2oQlswVzrx4CM94eqn+jhyDdZweEk++Qw
 XhMPDYJqVz+3sXz/15pvZb99yl+iK+lpNCuLnLthpj0nnwlHukMX7gyQIbsFYHn1Sgvm
 3TpH14QYJI3VuCk2EALEAX+wX3Y8ILX3dI6HNQ0uR6G0/COzM9hou+q5mIv59fMrl3ib
 FEtQ==
X-Gm-Message-State: AOJu0Ywew1chlffnDI3wnPmO2ExUXajhdrA8Egq94xo/zOI0+RCKZ9c2
 hrIlW47wR9nGIBJqPnu+5dH2+A==
X-Google-Smtp-Source: AGHT+IH63AHAxh35TtojkVxGExF1G7A+biupiaqyfauaSZN5p4pt8fElfiGVetNi7NNBoy9+5bo+AA==
X-Received: by 2002:a17:906:76da:b0:9a1:b5fc:8c5f with SMTP id
 q26-20020a17090676da00b009a1b5fc8c5fmr2859808ejn.49.1694016393584; 
 Wed, 06 Sep 2023 09:06:33 -0700 (PDT)
Received: from [192.168.69.115] (cou50-h01-176-172-51-223.dsl.sta.abo.bbox.fr.
 [176.172.51.223]) by smtp.gmail.com with ESMTPSA id
 s14-20020a17090699ce00b0099bccb03eadsm9059144ejn.205.2023.09.06.09.06.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 09:06:33 -0700 (PDT)
Message-ID: <6c956b90-5a13-db96-9c02-9834a512fe6f@linaro.org>
Date: Wed, 6 Sep 2023 18:06:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: mips system emulation failure with virtio
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <4f2a4b734b20b80857d56af986335f78a92a0fff.camel@linuxfoundation.org>
 <87pm2whfyn.fsf@linaro.org>
 <0cbd86af5501f18007a926598c6e2232af240d00.camel@linuxfoundation.org>
 <67d4c8dc-24d7-afa3-27b1-d6e756a597b9@linaro.org>
Content-Language: en-US
In-Reply-To: <67d4c8dc-24d7-afa3-27b1-d6e756a597b9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/9/23 17:50, Philippe Mathieu-Daudé wrote:
> +rth/pm215/dhildenb
> 
> On 5/9/23 16:50, Richard Purdie wrote:
>> On Tue, 2023-09-05 at 14:59 +0100, Alex Bennée wrote:
>>> Richard Purdie <richard.purdie@linuxfoundation.org> writes:
>>>
>>>> With qemu 8.1.0 we see boot hangs fox x86-64 targets.
>>>>
>>>> These are fixed by 0d58c660689f6da1e3feff8a997014003d928b3b (softmmu:
>>>> Use async_run_on_cpu in tcg_commit) but if I add that commit, mips and
>>>> mips64 break, hanging at boot unable to find a rootfs.
>>>
>>> (Widen CC list)
>>>
>>>>
>>>> We use virtio for network and disk and both of those change in the
>>>> bootlog from messages like:
>>>>
>>>> [    1.726118] virtio-pci 0000:00:13.0: enabling device (0000 -> 0003)
>>>> [    1.728864] virtio-pci 0000:00:14.0: enabling device (0000 -> 0003)
>>>> [    1.729948] virtio-pci 0000:00:15.0: enabling device (0000 -> 0003)
>>>> ...
>>>> [    2.162148] virtio_blk virtio2: 1/0/0 default/read/poll queues
>>>> [    2.168311] virtio_blk virtio2: [vda] 1184242 512-byte logical
>>>>
>>>> to:
>>>>
>>>> [    1.777051] virtio-pci 0000:00:13.0: enabling device (0000 -> 0003)
>>>> [    1.779822] virtio-pci 0000:00:14.0: enabling device (0000 -> 0003)
>>>> [    1.780926] virtio-pci 0000:00:15.0: enabling device (0000 -> 0003)
>>>> ...
>>>> [    1.894852] virtio_rng: probe of virtio1 failed with error -28
>>>> ...
>>>> [    2.063553] virtio_blk virtio2: 1/0/0 default/read/poll queues
>>>> [    2.064260] virtio_blk: probe of virtio2 failed with error -28
>>>> [    2.069080] virtio_net: probe of virtio0 failed with error -28
>>>>
>>>>
>>>> i.e. the virtio drivers no longer work.
>>>
>>> Interesting, as you say this seems to be VirtIO specific as the baseline
>>> tests (using IDE) work fine:
>>>
>>>    ➜  ./tests/venv/bin/avocado run 
>>> ./tests/avocado/tuxrun_baselines.py:test_mips64
>>>    JOB ID     : 71f3e3b7080164b78ef1c8c1bb6bc880932d8c9b
>>>    JOB LOG    : 
>>> /home/alex/avocado/job-results/job-2023-09-05T15.01-71f3e3b/job.log
>>>     (1/2) 
>>> ./tests/avocado/tuxrun_baselines.py:TuxRunBaselineTest.test_mips64: 
>>> PASS (12.19 s)
>>>     (2/2) 
>>> ./tests/avocado/tuxrun_baselines.py:TuxRunBaselineTest.test_mips64el: 
>>> PASS (11.78 s)
>>>    RESULTS    : PASS 2 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | 
>>> INTERRUPT 0 | CANCEL 0
>>>    JOB TIME   : 24.79 s
>>>
>>>> I tested with current qemu master
>>>> (17780edd81d27fcfdb7a802efc870a99788bd2fc) and mips is still broken
>>>> there.
>>>>
>>>> Is this issue known about?
>>>
>>> Could you raise a bug at:
>>>
>>>    https://gitlab.com/qemu-project/qemu/-/issues
>>
>> Done, https://gitlab.com/qemu-project/qemu/-/issues/1866
>>
>>> I'm curious why MIPS VirtIO is affected but nothing else is...
>>
>> Me too, it seems there is a real code issue somewhere in this...
> 
> This seems to fix the issue for me, but I'm not really sure what
> I'm doing after various hours debugging, so sharing here before
> I take some rest:
> 
> -- >8 --
> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> index 18277ddd67..ec31ebcb56 100644
> --- a/softmmu/physmem.c
> +++ b/softmmu/physmem.c
> @@ -2517,7 +2517,7 @@ static void tcg_commit(MemoryListener *listener)
>        * That said, the listener is also called during realize, before
>        * all of the tcg machinery for run-on is initialized: thus 
> halt_cond.
>        */
> -    if (cpu->halt_cond) {
> +    if (cpu->halt_cond && !qemu_cpu_is_self(cpu)) {
>           async_run_on_cpu(cpu, tcg_commit_cpu, 
> RUN_ON_CPU_HOST_PTR(cpuas));
>       } else {
>           tcg_commit_cpu(cpu, RUN_ON_CPU_HOST_PTR(cpuas));
> ---
> 
> That said, the same logic moved generically to async_run_on_cpu()
> also works ...:
> 
> -- >8 --
> diff --git a/cpus-common.c b/cpus-common.c
> index 45c745ecf6..b0539c4fb8 100644
> --- a/cpus-common.c
> +++ b/cpus-common.c
> @@ -167,6 +167,9 @@ void do_run_on_cpu(CPUState *cpu, run_on_cpu_func 
> func, run_on_cpu_data data,
> 
>   void async_run_on_cpu(CPUState *cpu, run_on_cpu_func func, 
> run_on_cpu_data data)
>   {
> +    if (qemu_cpu_is_self(cpu)) {
> +        return func(cpu, data);
> +    }
>       struct qemu_work_item *wi;
> 
>       wi = g_new0(struct qemu_work_item, 1);
> ---

Ah, this is what commit c978b31687 removed:

commit c978b3168727d3a76ffcb18462ea972f50b53634
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Wed Aug 31 18:03:39 2016 +0200

     cpus-common: always defer async_run_on_cpu work items

     async_run_on_cpu is only called from the I/O thread, not from
     CPU threads, so it doesn't make any difference.  It will make
     a difference however for async_safe_run_on_cpu.

So adding:

-- >8 --
diff --git a/cpus-common.c b/cpus-common.c
index 45c745ecf6..8554e3f7a1 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -169,6 +169,8 @@ void async_run_on_cpu(CPUState *cpu, run_on_cpu_func 
func, run_on_cpu_data data)
  {
      struct qemu_work_item *wi;

+    g_assert(!qemu_cpu_is_self(cpu));
+
      wi = g_new0(struct qemu_work_item, 1);
      wi->func = func;
      wi->data = data;
---

We get:

* thread #4, stop reason = signal SIGABRT
   * frame #0: 0x00000001887d8764 libsystem_kernel.dylib`__pthread_kill + 8
     frame #1: 0x000000018880fc28 libsystem_pthread.dylib`pthread_kill + 288
     frame #2: 0x000000018871dae8 libsystem_c.dylib`abort + 180
     frame #3: 0x0000000101efdddc 
libglib-2.0.0.dylib`g_assertion_message + 464
     frame #4: 0x0000000101efde50 
libglib-2.0.0.dylib`g_assertion_message_expr + 116
     frame #5: 0x000000010000f6a8 
qemu-system-mips`async_run_on_cpu(cpu=0x0000000104815a00, 
func=(qemu-system-mips`tcg_commit_cpu at physmem.c:2490), data=(host_int 
= 61900768, host_ulong = 105553178167264, host_ptr = 0x0000600003b087e0, 
target_ptr = 105553178167264)) at cpus-common.c:172:5
     frame #6: 0x00000001004d469c 
qemu-system-mips`tcg_commit(listener=0x0000600003b087f8) at physmem.c:2521:9
     frame #7: 0x00000001004c4b70 
qemu-system-mips`memory_region_transaction_commit at memory.c:1126:13
     frame #8: 0x000000010020f620 
qemu-system-mips`gt64120_isd_mapping(s=0x0000000104875c00) at 
gt64120.c:318:5
     frame #9: 0x000000010020dbe4 
qemu-system-mips`gt64120_writel(opaque=0x0000000104875c00, addr=104, 
val=223, size=4) at gt64120.c:502:9
     frame #10: 0x00000001004c638c 
qemu-system-mips`memory_region_write_accessor(mr=0x0000000104877600, 
addr=104, value=0x000000016ff9e2f0, size=4, shift=0, mask=4294967295, 
attrs=MemTxAttrs @ 0x000000016ff9e21c) at memory.c:493:5
     frame #11: 0x00000001004c6160 
qemu-system-mips`access_with_adjusted_size(addr=104, 
value=0x000000016ff9e2f0, size=4, access_size_min=4, access_size_max=4, 
access_fn=(qemu-system-mips`memory_region_write_accessor at 
memory.c:483), mr=0x0000000104877600, attrs=MemTxAttrs @ 
0x000000016ff9e2a8) at memory.c:564:18
     frame #12: 0x00000001004c5cd0 
qemu-system-mips`memory_region_dispatch_write(mr=0x0000000104877600, 
addr=104, data=3741319168, op=MO_32, attrs=MemTxAttrs @ 
0x000000016ff9e2e8) at memory.c:1533:16
     frame #13: 0x00000001004decc0 
qemu-system-mips`flatview_write_continue(fv=0x00006000017151c0, 
addr=335544424, attrs=MemTxAttrs @ 0x000000016ff9e384, 
ptr=0x000000016ff9e450, len=4, addr1=104, l=4, mr=0x0000000104877600) at 
physmem.c:2677:23
     frame #14: 0x00000001004db090 
qemu-system-mips`flatview_write(fv=0x00006000017151c0, addr=335544424, 
attrs=MemTxAttrs @ 0x000000016ff9e3e0, buf=0x000000016ff9e450, len=4) at 
physmem.c:2719:12
     frame #15: 0x00000001004e2f54 
qemu-system-mips`subpage_write(opaque=0x0000000104907400, addr=104, 
value=3741319168, len=4, attrs=MemTxAttrs @ 0x000000016ff9e44c) at 
physmem.c:2328:12
     frame #16: 0x00000001004c64dc 
qemu-system-mips`memory_region_write_with_attrs_accessor(mr=0x0000000104907400, 
addr=104, value=0x000000016ff9e5a0, size=4, shift=0, mask=4294967295, 
attrs=MemTxAttrs @ 0x000000016ff9e4cc) at memory.c:514:12
     frame #17: 0x00000001004c6160 
qemu-system-mips`access_with_adjusted_size(addr=104, 
value=0x000000016ff9e5a0, size=4, access_size_min=1, access_size_max=8, 
access_fn=(qemu-system-mips`memory_region_write_with_attrs_accessor at 
memory.c:504), mr=0x0000000104907400, attrs=MemTxAttrs @ 
0x000000016ff9e558) at memory.c:564:18
     frame #18: 0x00000001004c5d14 
qemu-system-mips`memory_region_dispatch_write(mr=0x0000000104907400, 
addr=104, data=3741319168, op=MO_32, attrs=MemTxAttrs @ 
0x000000016ff9e598) at memory.c:1540:13
     frame #19: 0x000000010054f5c8 
qemu-system-mips`io_writex(env=0x0000000104818260, 
full=0x0000000104828000, mmu_idx=3, val=223, addr=3019898984, 
retaddr=10737419088, op=MO_32) at cputlb.c:1449:13
     frame #20: 0x000000010054f9a4 
qemu-system-mips`do_st_mmio_leN(env=0x0000000104818260, 
full=0x0000000104828000, val_le=223, addr=3019898984, size=4, mmu_idx=3, 
ra=10737419088) at cputlb.c:2756:13
     frame #21: 0x00000001005500bc 
qemu-system-mips`do_st_4(env=0x0000000104818260, p=0x000000016ff9e760, 
val=223, mmu_idx=3, memop=226, ra=10737419088) at cputlb.c:2922:9
     frame #22: 0x000000010053dff0 
qemu-system-mips`do_st4_mmu(env=0x0000000104818260, addr=3019898984, 
val=223, oi=3619, ra=10737419088) at cputlb.c:3007:9
     frame #23: 0x000000010053df44 
qemu-system-mips`helper_stl_mmu(env=0x0000000104818260, addr=3019898984, 
val=223, oi=3619, retaddr=10737419088) at cputlb.c:3023:5
     frame #24: 0x0000000280000624
     frame #25: 0x0000000100522e70 
qemu-system-mips`cpu_tb_exec(cpu=0x0000000104815a00, 
itb=0x0000000118000200, tb_exit=0x000000016ff9ee24) at cpu-exec.c:457:11
     frame #26: 0x0000000100525714 
qemu-system-mips`cpu_loop_exec_tb(cpu=0x0000000104815a00, 
tb=0x0000000118000200, pc=3217032576, last_tb=0x000000016ff9ee28, 
tb_exit=0x000000016ff9ee24) at cpu-exec.c:919:10
     frame #27: 0x0000000100524d3c 
qemu-system-mips`cpu_exec_loop(cpu=0x0000000104815a00, 
sc=0x000000016ff9eea0) at cpu-exec.c:1040:13
     frame #28: 0x000000010052366c 
qemu-system-mips`cpu_exec_setjmp(cpu=0x0000000104815a00, 
sc=0x000000016ff9eea0) at cpu-exec.c:1057:12
     frame #29: 0x0000000100523340 
qemu-system-mips`cpu_exec(cpu=0x0000000104815a00) at cpu-exec.c:1083:11
     frame #30: 0x00000001005569bc 
qemu-system-mips`tcg_cpus_exec(cpu=0x0000000104815a00) at 
tcg-accel-ops.c:75:11
     frame #31: 0x00000001005575c4 
qemu-system-mips`mttcg_cpu_thread_fn(arg=0x0000000104815a00) at 
tcg-accel-ops-mttcg.c:95:17
     frame #32: 0x00000001007d86c8 
qemu-system-mips`qemu_thread_start(args=0x000060000022e400) at 
qemu-thread-posix.c:541:9
     frame #33: 0x000000018880ffa8 
libsystem_pthread.dylib`_pthread_start + 148

(in case that helps catching other similar issues).

