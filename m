Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C90766F02
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 16:05:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPNXc-0003UL-GV; Fri, 28 Jul 2023 09:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qPNXa-0003U6-Ic
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 09:29:58 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qPNXX-0000e2-AN
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 09:29:58 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AFF2721863;
 Fri, 28 Jul 2023 13:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1690550990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bjkrdhnO9uZO1mBrB7e8jGtcFfCQsvUl6JubRiA8sO0=;
 b=c05a0CgA3RYYB8hiX98kkRr/OjPkzrV3X2KAkXui0BGvpPj3buYX2XePd62dPH0t/+aCIc
 wN84TUGQ6ZwT3mqmTfciGqkCLr8n34/rAB9MUkfdONl6K4TocD+VwxmVCmabagzNoPAX4s
 9d2t4lNM14AuoWpFiJl+/ThjnzupSrQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1690550990;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bjkrdhnO9uZO1mBrB7e8jGtcFfCQsvUl6JubRiA8sO0=;
 b=aUddxGqlttyisN9BmwFNz+TdtBch0X6JgZUHMWXL0iD6sX0vmY3BCwQwtzxhTegLnxs0VK
 aX439joXuTfOfeAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 76997133F7;
 Fri, 28 Jul 2023 13:29:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id K28pGs7Cw2RXCgAAMHmgww
 (envelope-from <cfontana@suse.de>); Fri, 28 Jul 2023 13:29:50 +0000
Message-ID: <0e06f694-7aeb-66d1-48d8-317a93f8f741@suse.de>
Date: Fri, 28 Jul 2023 15:29:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: assert fails in s390x TCG
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <eaec32e3-d56a-e6a7-fcbe-860948e79658@suse.de>
 <def2df0d-fb58-8e67-a0eb-7d646da3be42@linaro.org>
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <def2df0d-fb58-8e67-a0eb-7d646da3be42@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:67c:2178:6::1c;
 envelope-from=cfontana@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

On 7/27/23 19:41, Richard Henderson wrote:
> On 7/21/23 02:08, Claudio Fontana wrote:
>> Thread 3 "qemu-system-s39" received signal SIGABRT, Aborted.
>> [Switching to Thread 0x7ffff53516c0 (LWP 215975)]
>> (gdb) bt
>> #0  0x00007ffff730dabc in __pthread_kill_implementation () at /lib64/libc.so.6
>> #1  0x00007ffff72bc266 in raise () at /lib64/libc.so.6
>> #2  0x00007ffff72a4897 in abort () at /lib64/libc.so.6
>> #3  0x00007ffff76f0eee in  () at /lib64/libglib-2.0.so.0
>> #4  0x00007ffff775649a in g_assertion_message_expr () at /lib64/libglib-2.0.so.0
>> #5  0x0000555555b96134 in page_unlock__debug (pd=0x7ffee8680440) at ../accel/tcg/tb-maint.c:348
>> #6  0x0000555555b962a9 in page_unlock (pd=0x7ffee8680440) at ../accel/tcg/tb-maint.c:397
>> #7  0x0000555555b96580 in tb_unlock_pages (tb=0x7fffefffeb00) at ../accel/tcg/tb-maint.c:483
>> #8  0x0000555555b94698 in cpu_exec_longjmp_cleanup (cpu=0x555556566a30) at ../accel/tcg/cpu-exec.c:556
> 
> 
> https://patchew.org/QEMU/20230726201330.357175-1-richard.henderson@linaro.org/
> 
> 
> r~

Hi Richard,

I applied your patch, however I still encounter an assert:

ERROR:../accel/tcg/tb-maint.c:367:assert_no_pages_locked: assertion failed: (g_hash_table_size(ht_pages_locked_debug) == 0)
Bail out! ERROR:../accel/tcg/tb-maint.c:367:assert_no_pages_locked: assertion failed: (g_hash_table_size(ht_pages_locked_debug) == 0)

Thread 6 "qemu-system-s39" received signal SIGABRT, Aborted.
[Switching to Thread 0x7ffeef5fe6c0 (LWP 116343)]
0x00007ffff730dabc in __pthread_kill_implementation () from /lib64/libc.so.6
(gdb) bt
#0  0x00007ffff730dabc in __pthread_kill_implementation () at /lib64/libc.so.6
#1  0x00007ffff72bc266 in raise () at /lib64/libc.so.6
#2  0x00007ffff72a4897 in abort () at /lib64/libc.so.6
#3  0x00007ffff76f0eee in  () at /lib64/libglib-2.0.so.0
#4  0x00007ffff775649a in g_assertion_message_expr () at /lib64/libglib-2.0.so.0
#5  0x0000555555b96f82 in assert_no_pages_locked () at ../accel/tcg/tb-maint.c:367
#6  0x0000555555b976cc in page_collection_lock (start=6674, last=6674) at ../accel/tcg/tb-maint.c:614
#7  0x0000555555b9877c in tb_invalidate_phys_range (start=27336872, last=27336879) at ../accel/tcg/tb-maint.c:1197
#8  0x0000555555b6b25e in invalidate_and_set_dirty (mr=0x5555563f6e90, addr=27336872, length=8) at ../softmmu/physmem.c:2542
#9  0x0000555555b6d72d in address_space_stq_internal
    (as=0x5555566b7350, addr=27336872, val=2930044561408, attrs=..., result=0x0, endian=DEVICE_NATIVE_ENDIAN)
    at /root/git/qemu/memory_ldst.c.inc:495
#10 0x0000555555b6d7aa in address_space_stq (as=0x5555566b7350, addr=27336872, val=2930044561408, attrs=..., result=0x0)
    at /root/git/qemu/memory_ldst.c.inc:510
#11 0x0000555555a9fff6 in stq_phys (as=0x5555566b7350, addr=27336872, val=2930044561408)
    at /root/git/qemu/include/exec/memory_ldst_phys.h.inc:55
#12 0x0000555555aa0630 in s390_cpu_tlb_fill
    (cs=0x555556663c80, address=2930044559360, size=1, access_type=MMU_INST_FETCH, mmu_idx=0, probe=false, retaddr=0)
    at ../target/s390x/tcg/excp_helper.c:194
#13 0x0000555555ba8a89 in probe_access_internal
    (env=0x555556666460, addr=2930044559360, fault_size=1, access_type=MMU_INST_FETCH, mmu_idx=0, nonfault=false, phost=0x7ffeef5fcfd0, pfu\
ll=0x7ffeef5fcfc8, retaddr=0, check_mem_cbs=false) at ../accel/tcg/cputlb.c:1530
#14 0x0000555555ba90f0 in get_page_addr_code_hostp (env=0x555556666460, addr=2930044559360, hostp=0x7ffeef5fd2f0)
    at ../accel/tcg/cputlb.c:1695
#15 0x0000555555ba122d in translator_access (env=0x555556666460, db=0x7ffeef5fd2c0, pc=2930044559360, len=4)
    at ../accel/tcg/translator.c:257
#16 0x0000555555ba15e2 in translator_ldl (env=0x555556666460, db=0x7ffeef5fd2c0, pc=2930044559360) at ../accel/tcg/translator.c:351
#17 0x0000555555abd537 in ld_code4 (env=0x555556666460, s=0x7ffeef5fd2c0, pc=2930044559360) at ../target/s390x/tcg/translate.c:399
#18 0x0000555555ad9e93 in extract_insn (env=0x555556666460, s=0x7ffeef5fd2c0) at ../target/s390x/tcg/translate.c:6204
#19 0x0000555555ada171 in translate_one (env=0x555556666460, s=0x7ffeef5fd2c0) at ../target/s390x/tcg/translate.c:6296
#20 0x0000555555ada85c in s390x_tr_translate_insn (dcbase=0x7ffeef5fd2c0, cs=0x555556663c80) at ../target/s390x/tcg/translate.c:6469
#21 0x0000555555ba100d in translator_loop
    (cpu=0x555556663c80, tb=0x7fffe77a1480, max_insns=0x7ffeef5fd3f4, pc=2930044559358, host_pc=0x7fff08801ffe, ops=0x555556216b60 <s390x_t\
r_ops>, db=0x7ffeef5fd2c0) at ../accel/tcg/translator.c:180
#22 0x0000555555adaabe in gen_intermediate_code
    (cs=0x555556663c80, tb=0x7fffe77a1480, max_insns=0x7ffeef5fd3f4, pc=2930044559358, host_pc=0x7fff08801ffe)
    at ../target/s390x/tcg/translate.c:6535
#23 0x0000555555b9f167 in setjmp_gen_code
    (env=0x555556666460, tb=0x7fffe77a1480, pc=2930044559358, host_pc=0x7fff08801ffe, max_insns=0x7ffeef5fd3f4, ti=0x7ffeef5fd410)
    at ../accel/tcg/translate-all.c:278
#24 0x0000555555b9f47e in tb_gen_code (cpu=0x555556663c80, pc=2930044559358, cs_base=0, flags=1744961539, cflags=-16252928)
    at ../accel/tcg/translate-all.c:360
#25 0x0000555555b960b3 in cpu_exec_loop (cpu=0x555556663c80, sc=0x7ffeef5fd540) at ../accel/tcg/cpu-exec.c:1005
#26 0x0000555555b96252 in cpu_exec_setjmp (cpu=0x555556663c80, sc=0x7ffeef5fd540) at ../accel/tcg/cpu-exec.c:1057
#27 0x0000555555b962d9 in cpu_exec (cpu=0x555556663c80) at ../accel/tcg/cpu-exec.c:1083
#28 0x0000555555bba868 in tcg_cpus_exec (cpu=0x555556663c80) at ../accel/tcg/tcg-accel-ops.c:75
#29 0x0000555555bbaf20 in mttcg_cpu_thread_fn (arg=0x555556663c80) at ../accel/tcg/tcg-accel-ops-mttcg.c:95
#30 0x0000555555dc1ece in qemu_thread_start (args=0x5555566b74f0) at ../util/qemu-thread-posix.c:541
#31 0x00007ffff730bc64 in start_thread () at /lib64/libc.so.6
#32 0x00007ffff7393550 in clone3 () at /lib64/libc.so.6

(gdb) thread apply all bt

Thread 87 (Thread 0x7ffec2beb6c0 (LWP 116440) "qemu-system-s39"):
#0  0x00007ffff730820e in __futex_abstimed_wait_common () at /lib64/libc.so.6
#1  0x00007ffff730b275 in pthread_cond_timedwait@@GLIBC_2.3.2 () at /lib64/libc.so.6
#2  0x0000555555dc1739 in qemu_cond_timedwait_ts (cond=0x5555563ff1b0, mutex=0x5555563ff140, ts=0x7ffec2bea580, file=0x555555fea535 "../util/thread-pool.c", line=90) at ../util/qemu-thread-posix.c:239
#3  0x0000555555dc17d4 in qemu_cond_timedwait_impl (cond=0x5555563ff1b0, mutex=0x5555563ff140, ms=10000, file=0x555555fea535 "../util/thread-pool.c", line=90) at ../util/qemu-thread-posix.c:253
#4  0x0000555555ddddfc in worker_thread (opaque=0x5555563ff130) at ../util/thread-pool.c:90
#5  0x0000555555dc1ece in qemu_thread_start (args=0x7ffebc000b70) at ../util/qemu-thread-posix.c:541
#6  0x00007ffff730bc64 in start_thread () at /lib64/libc.so.6
#7  0x00007ffff7393550 in clone3 () at /lib64/libc.so.6

Thread 86 (Thread 0x7ffecde2c6c0 (LWP 116439) "qemu-system-s39"):
#0  0x00007ffff730820e in __futex_abstimed_wait_common () at /lib64/libc.so.6
#1  0x00007ffff730b275 in pthread_cond_timedwait@@GLIBC_2.3.2 () at /lib64/libc.so.6
#2  0x0000555555dc1739 in qemu_cond_timedwait_ts (cond=0x5555563ff1b0, mutex=0x5555563ff140, ts=0x7ffecde2b580, file=0x555555fea535 "../util/thread-pool.c", line=90) at ../util/qemu-thread-posix.c:239
#3  0x0000555555dc17d4 in qemu_cond_timedwait_impl (cond=0x5555563ff1b0, mutex=0x5555563ff140, ms=10000, file=0x555555fea535 "../util/thread-pool.c", line=90) at ../util/qemu-thread-posix.c:253
#4  0x0000555555ddddfc in worker_thread (opaque=0x5555563ff130) at ../util/thread-pool.c:90
#5  0x0000555555dc1ece in qemu_thread_start (args=0x7ffea4000b70) at ../util/qemu-thread-posix.c:541
#6  0x00007ffff730bc64 in start_thread () at /lib64/libc.so.6
#7  0x00007ffff7393550 in clone3 () at /lib64/libc.so.6

Thread 85 (Thread 0x7ffecf73e6c0 (LWP 116438) "qemu-system-s39"):
#0  0x00007ffff730820e in __futex_abstimed_wait_common () at /lib64/libc.so.6
#1  0x00007ffff730b275 in pthread_cond_timedwait@@GLIBC_2.3.2 () at /lib64/libc.so.6
#2  0x0000555555dc1739 in qemu_cond_timedwait_ts (cond=0x5555563ff1b0, mutex=0x5555563ff140, ts=0x7ffecf73d580, file=0x555555fea535 "../util/thread-pool.c", line=90) at ../util/qemu-thread-posix.c:239
#3  0x0000555555dc17d4 in qemu_cond_timedwait_impl (cond=0x5555563ff1b0, mutex=0x5555563ff140, ms=10000, file=0x555555fea535 "../util/thread-pool.c", line=90) at ../util/qemu-thread-posix.c:253
#4  0x0000555555ddddfc in worker_thread (opaque=0x5555563ff130) at ../util/thread-pool.c:90
#5  0x0000555555dc1ece in qemu_thread_start (args=0x7ffeb0000b70) at ../util/qemu-thread-posix.c:541
#6  0x00007ffff730bc64 in start_thread () at /lib64/libc.so.6
#7  0x00007ffff7393550 in clone3 () at /lib64/libc.so.6

Thread 84 (Thread 0x7ffec14e26c0 (LWP 116437) "qemu-system-s39"):
#0  0x00007ffff730820e in __futex_abstimed_wait_common () at /lib64/libc.so.6
#1  0x00007ffff730b275 in pthread_cond_timedwait@@GLIBC_2.3.2 () at /lib64/libc.so.6
#2  0x0000555555dc1739 in qemu_cond_timedwait_ts (cond=0x5555563ff1b0, mutex=0x5555563ff140, ts=0x7ffec14e1580, file=0x555555fea535 "../util/thread-pool.c", line=90) at ../util/qemu-thread-posix.c:239
#3  0x0000555555dc17d4 in qemu_cond_timedwait_impl (cond=0x5555563ff1b0, mutex=0x5555563ff140, ms=10000, file=0x555555fea535 "../util/thread-pool.c", line=90) at ../util/qemu-thread-posix.c:253
#4  0x0000555555ddddfc in worker_thread (opaque=0x5555563ff130) at ../util/thread-pool.c:90
#5  0x0000555555dc1ece in qemu_thread_start (args=0x7ffe88000b70) at ../util/qemu-thread-posix.c:541
#6  0x00007ffff730bc64 in start_thread () at /lib64/libc.so.6
#7  0x00007ffff7393550 in clone3 () at /lib64/libc.so.6

Thread 83 (Thread 0x7ffea3fff6c0 (LWP 116436) "qemu-system-s39"):
#0  0x00007ffff730820e in __futex_abstimed_wait_common () at /lib64/libc.so.6
#1  0x00007ffff730b275 in pthread_cond_timedwait@@GLIBC_2.3.2 () at /lib64/libc.so.6
#2  0x0000555555dc1739 in qemu_cond_timedwait_ts (cond=0x5555563ff1b0, mutex=0x5555563ff140, ts=0x7ffea3ffe580, file=0x555555fea535 "../util/thread-pool.c", line=90) at ../util/qemu-thread-posix.c:239
#3  0x0000555555dc17d4 in qemu_cond_timedwait_impl (cond=0x5555563ff1b0, mutex=0x5555563ff140, ms=10000, file=0x555555fea535 "../util/thread-pool.c", line=90) at ../util/qemu-thread-posix.c:253
#4  0x0000555555ddddfc in worker_thread (opaque=0x5555563ff130) at ../util/thread-pool.c:90
#5  0x0000555555dc1ece in qemu_thread_start (args=0x55555675eb70) at ../util/qemu-thread-posix.c:541
#6  0x00007ffff730bc64 in start_thread () at /lib64/libc.so.6
#7  0x00007ffff7393550 in clone3 () at /lib64/libc.so.6

Thread 82 (Thread 0x7ffea0ff96c0 (LWP 116435) "qemu-system-s39"):
#0  0x00007ffff730820e in __futex_abstimed_wait_common () at /lib64/libc.so.6
#1  0x00007ffff730b275 in pthread_cond_timedwait@@GLIBC_2.3.2 () at /lib64/libc.so.6
#2  0x0000555555dc1739 in qemu_cond_timedwait_ts (cond=0x5555563ff1b0, mutex=0x5555563ff140, ts=0x7ffea0ff8580, file=0x555555fea535 "../util/thread-pool.c", line=90) at ../util/qemu-thread-posix.c:239
#3  0x0000555555dc17d4 in qemu_cond_timedwait_impl (cond=0x5555563ff1b0, mutex=0x5555563ff140, ms=10000, file=0x555555fea535 "../util/thread-pool.c", line=90) at ../util/qemu-thread-posix.c:253
#4  0x0000555555ddddfc in worker_thread (opaque=0x5555563ff130) at ../util/thread-pool.c:90
#5  0x0000555555dc1ece in qemu_thread_start (args=0x5555565bc420) at ../util/qemu-thread-posix.c:541
#6  0x00007ffff730bc64 in start_thread () at /lib64/libc.so.6
#7  0x00007ffff7393550 in clone3 () at /lib64/libc.so.6

Thread 81 (Thread 0x7ffe6e7fc6c0 (LWP 116434) "qemu-system-s39"):
#0  0x00007ffff730820e in __futex_abstimed_wait_common () at /lib64/libc.so.6
#1  0x00007ffff730b275 in pthread_cond_timedwait@@GLIBC_2.3.2 () at /lib64/libc.so.6
#2  0x0000555555dc1739 in qemu_cond_timedwait_ts (cond=0x5555563ff1b0, mutex=0x5555563ff140, ts=0x7ffe6e7fb580, file=0x555555fea535 "../util/thread-pool.c", line=90) at ../util/qemu-thread-posix.c:239
#3  0x0000555555dc17d4 in qemu_cond_timedwait_impl (cond=0x5555563ff1b0, mutex=0x5555563ff140, ms=10000, file=0x555555fea535 "../util/thread-pool.c", line=90) at ../util/qemu-thread-posix.c:253
#4  0x0000555555ddddfc in worker_thread (opaque=0x5555563ff130) at ../util/thread-pool.c:90
#5  0x0000555555dc1ece in qemu_thread_start (args=0x5555565bf630) at ../util/qemu-thread-posix.c:541
#6  0x00007ffff730bc64 in start_thread () at /lib64/libc.so.6
#7  0x00007ffff7393550 in clone3 () at /lib64/libc.so.6

Thread 10 (Thread 0x7ffeed5fa6c0 (LWP 116347) "qemu-system-s39"):
#0  0x00007ffff730820e in __futex_abstimed_wait_common () at /lib64/libc.so.6
#1  0x00007ffff730af50 in pthread_cond_wait@@GLIBC_2.3.2 () at /lib64/libc.so.6
#2  0x0000555555dc1686 in qemu_cond_wait_impl (cond=0x555556806210, mutex=0x55555632cf60 <qemu_global_mutex>, file=0x555555f07d6b "../softmmu/cpus.c", line=424) at ../util/qemu-thread-posix.c:225
#3  0x00005555559d78fb in qemu_wait_io_event (cpu=0x5555567b28e0) at ../softmmu/cpus.c:424
#4  0x0000555555bbafec in mttcg_cpu_thread_fn (arg=0x5555567b28e0) at ../accel/tcg/tcg-accel-ops-mttcg.c:123
#5  0x0000555555dc1ece in qemu_thread_start (args=0x555556806250) at ../util/qemu-thread-posix.c:541
#6  0x00007ffff730bc64 in start_thread () at /lib64/libc.so.6
#7  0x00007ffff7393550 in clone3 () at /lib64/libc.so.6

Thread 9 (Thread 0x7ffeeddfb6c0 (LWP 116346) "qemu-system-s39"):
#0  0x00007ffff730820e in __futex_abstimed_wait_common () at /lib64/libc.so.6
#1  0x00007ffff730af50 in pthread_cond_wait@@GLIBC_2.3.2 () at /lib64/libc.so.6
#2  0x0000555555dc1686 in qemu_cond_wait_impl (cond=0x5555567b2620, mutex=0x55555632cf60 <qemu_global_mutex>, file=0x555555f07d6b "../softmmu/cpus.c", line=424) at ../util/qemu-thread-posix.c:225
#3  0x00005555559d78fb in qemu_wait_io_event (cpu=0x55555675edf0) at ../softmmu/cpus.c:424
#4  0x0000555555bbafec in mttcg_cpu_thread_fn (arg=0x55555675edf0) at ../accel/tcg/tcg-accel-ops-mttcg.c:123
#5  0x0000555555dc1ece in qemu_thread_start (args=0x5555567b2660) at ../util/qemu-thread-posix.c:541
#6  0x00007ffff730bc64 in start_thread () at /lib64/libc.so.6
#7  0x00007ffff7393550 in clone3 () at /lib64/libc.so.6

Thread 8 (Thread 0x7ffeee5fc6c0 (LWP 116345) "qemu-system-s39"):
#0  0x00007ffff730820e in __futex_abstimed_wait_common () at /lib64/libc.so.6
#1  0x00007ffff730af50 in pthread_cond_wait@@GLIBC_2.3.2 () at /lib64/libc.so.6
#2  0x0000555555dc1686 in qemu_cond_wait_impl (cond=0x55555675eb30, mutex=0x55555632cf60 <qemu_global_mutex>, file=0x555555f07d6b "../softmmu/cpus.c", line=424) at ../util/qemu-thread-posix.c:225
#3  0x00005555559d78fb in qemu_wait_io_event (cpu=0x55555670b3d0) at ../softmmu/cpus.c:424
#4  0x0000555555bbafec in mttcg_cpu_thread_fn (arg=0x55555670b3d0) at ../accel/tcg/tcg-accel-ops-mttcg.c:123
#5  0x0000555555dc1ece in qemu_thread_start (args=0x55555675eb70) at ../util/qemu-thread-posix.c:541
#6  0x00007ffff730bc64 in start_thread () at /lib64/libc.so.6
#7  0x00007ffff7393550 in clone3 () at /lib64/libc.so.6

Thread 7 (Thread 0x7ffeeedfd6c0 (LWP 116344) "qemu-system-s39"):
#0  0x0000555555ba7596 in tlb_reset_dirty_range_locked (tlb_entry=0x555556757140, start=140732950200320, length=4096) at ../accel/tcg/cputlb.c:993
#1  0x0000555555ba76d7 in tlb_reset_dirty (cpu=0x55555670b3d0, start1=140732950200320, length=4096) at ../accel/tcg/cputlb.c:1041
#2  0x0000555555b66e02 in tlb_reset_dirty_range_all (start=27344896, length=4096) at ../softmmu/physmem.c:839
#3  0x0000555555b6709d in cpu_physical_memory_test_and_clear_dirty (start=27344896, length=4096, client=1) at ../softmmu/physmem.c:886
#4  0x0000555555ba755b in tlb_protect_code (ram_addr=27344896) at ../accel/tcg/cputlb.c:961
#5  0x0000555555b97a4b in tb_page_add (p=0x7ffee8120090, tb=0x7fffe8599f80, n=0) at ../accel/tcg/tb-maint.c:706
#6  0x0000555555b97b2b in tb_record (tb=0x7fffe8599f80) at ../accel/tcg/tb-maint.c:721
#7  0x0000555555b9848d in tb_link_page (tb=0x7fffe8599f80) at ../accel/tcg/tb-maint.c:983
#8  0x0000555555b9facd in tb_gen_code (cpu=0x5555566b7770, pc=1026, cs_base=0, flags=1744928771, cflags=-16252928) at ../accel/tcg/translate-all.c:553
#9  0x0000555555b960b3 in cpu_exec_loop (cpu=0x5555566b7770, sc=0x7ffeeedfc540) at ../accel/tcg/cpu-exec.c:1005
#10 0x0000555555b96252 in cpu_exec_setjmp (cpu=0x5555566b7770, sc=0x7ffeeedfc540) at ../accel/tcg/cpu-exec.c:1057
#11 0x0000555555b962d9 in cpu_exec (cpu=0x5555566b7770) at ../accel/tcg/cpu-exec.c:1083
#12 0x0000555555bba868 in tcg_cpus_exec (cpu=0x5555566b7770) at ../accel/tcg/tcg-accel-ops.c:75
#13 0x0000555555bbaf20 in mttcg_cpu_thread_fn (arg=0x5555566b7770) at ../accel/tcg/tcg-accel-ops-mttcg.c:95
#14 0x0000555555dc1ece in qemu_thread_start (args=0x55555670b170) at ../util/qemu-thread-posix.c:541
#15 0x00007ffff730bc64 in start_thread () at /lib64/libc.so.6
#16 0x00007ffff7393550 in clone3 () at /lib64/libc.so.6

Thread 6 (Thread 0x7ffeef5fe6c0 (LWP 116343) "qemu-system-s39"):
#0  0x00007ffff730dabc in __pthread_kill_implementation () at /lib64/libc.so.6
#1  0x00007ffff72bc266 in raise () at /lib64/libc.so.6
#2  0x00007ffff72a4897 in abort () at /lib64/libc.so.6
#3  0x00007ffff76f0eee in  () at /lib64/libglib-2.0.so.0
#4  0x00007ffff775649a in g_assertion_message_expr () at /lib64/libglib-2.0.so.0
#5  0x0000555555b96f82 in assert_no_pages_locked () at ../accel/tcg/tb-maint.c:367
#6  0x0000555555b976cc in page_collection_lock (start=6674, last=6674) at ../accel/tcg/tb-maint.c:614
#7  0x0000555555b9877c in tb_invalidate_phys_range (start=27336872, last=27336879) at ../accel/tcg/tb-maint.c:1197
#8  0x0000555555b6b25e in invalidate_and_set_dirty (mr=0x5555563f6e90, addr=27336872, length=8) at ../softmmu/physmem.c:2542
#9  0x0000555555b6d72d in address_space_stq_internal (as=0x5555566b7350, addr=27336872, val=2930044561408, attrs=..., result=0x0, endian=DEVICE_NATIVE_ENDIAN) at /root/git/qemu/memory_ldst.c.inc:495
#10 0x0000555555b6d7aa in address_space_stq (as=0x5555566b7350, addr=27336872, val=2930044561408, attrs=..., result=0x0) at /root/git/qemu/memory_ldst.c.inc:510
#11 0x0000555555a9fff6 in stq_phys (as=0x5555566b7350, addr=27336872, val=2930044561408) at /root/git/qemu/include/exec/memory_ldst_phys.h.inc:55
#12 0x0000555555aa0630 in s390_cpu_tlb_fill (cs=0x555556663c80, address=2930044559360, size=1, access_type=MMU_INST_FETCH, mmu_idx=0, probe=false, retaddr=0) at ../target/s390x/tcg/excp_helper.c:194
#13 0x0000555555ba8a89 in probe_access_internal (env=0x555556666460, addr=2930044559360, fault_size=1, access_type=MMU_INST_FETCH, mmu_idx=0, nonfault=false, phost=0x7ffeef5fcfd0, pfull=0x7ffeef5fcfc8, retaddr=0, check_mem_cbs=false) at ../accel/tcg/cputlb.c:1530
#14 0x0000555555ba90f0 in get_page_addr_code_hostp (env=0x555556666460, addr=2930044559360, hostp=0x7ffeef5fd2f0) at ../accel/tcg/cputlb.c:1695
#15 0x0000555555ba122d in translator_access (env=0x555556666460, db=0x7ffeef5fd2c0, pc=2930044559360, len=4) at ../accel/tcg/translator.c:257
#16 0x0000555555ba15e2 in translator_ldl (env=0x555556666460, db=0x7ffeef5fd2c0, pc=2930044559360) at ../accel/tcg/translator.c:351
#17 0x0000555555abd537 in ld_code4 (env=0x555556666460, s=0x7ffeef5fd2c0, pc=2930044559360) at ../target/s390x/tcg/translate.c:399
#18 0x0000555555ad9e93 in extract_insn (env=0x555556666460, s=0x7ffeef5fd2c0) at ../target/s390x/tcg/translate.c:6204
#19 0x0000555555ada171 in translate_one (env=0x555556666460, s=0x7ffeef5fd2c0) at ../target/s390x/tcg/translate.c:6296
#20 0x0000555555ada85c in s390x_tr_translate_insn (dcbase=0x7ffeef5fd2c0, cs=0x555556663c80) at ../target/s390x/tcg/translate.c:6469
#21 0x0000555555ba100d in translator_loop (cpu=0x555556663c80, tb=0x7fffe77a1480, max_insns=0x7ffeef5fd3f4, pc=2930044559358, host_pc=0x7fff08801ffe, ops=0x555556216b60 <s390x_tr_ops>, db=0x7ffeef5fd2c0) at ../accel/tcg/translator.c:180
#22 0x0000555555adaabe in gen_intermediate_code (cs=0x555556663c80, tb=0x7fffe77a1480, max_insns=0x7ffeef5fd3f4, pc=2930044559358, host_pc=0x7fff08801ffe) at ../target/s390x/tcg/translate.c:6535
#23 0x0000555555b9f167 in setjmp_gen_code (env=0x555556666460, tb=0x7fffe77a1480, pc=2930044559358, host_pc=0x7fff08801ffe, max_insns=0x7ffeef5fd3f4, ti=0x7ffeef5fd410) at ../accel/tcg/translate-all.c:278
#24 0x0000555555b9f47e in tb_gen_code (cpu=0x555556663c80, pc=2930044559358, cs_base=0, flags=1744961539, cflags=-16252928) at ../accel/tcg/translate-all.c:360
#25 0x0000555555b960b3 in cpu_exec_loop (cpu=0x555556663c80, sc=0x7ffeef5fd540) at ../accel/tcg/cpu-exec.c:1005
#26 0x0000555555b96252 in cpu_exec_setjmp (cpu=0x555556663c80, sc=0x7ffeef5fd540) at ../accel/tcg/cpu-exec.c:1057
#27 0x0000555555b962d9 in cpu_exec (cpu=0x555556663c80) at ../accel/tcg/cpu-exec.c:1083
#28 0x0000555555bba868 in tcg_cpus_exec (cpu=0x555556663c80) at ../accel/tcg/tcg-accel-ops.c:75
#29 0x0000555555bbaf20 in mttcg_cpu_thread_fn (arg=0x555556663c80) at ../accel/tcg/tcg-accel-ops-mttcg.c:95
#30 0x0000555555dc1ece in qemu_thread_start (args=0x5555566b74f0) at ../util/qemu-thread-posix.c:541
#31 0x00007ffff730bc64 in start_thread () at /lib64/libc.so.6
#32 0x00007ffff7393550 in clone3 () at /lib64/libc.so.6

Thread 5 (Thread 0x7ffeefdff6c0 (LWP 116342) "qemu-system-s39"):
#0  0x00007ffff730820e in __futex_abstimed_wait_common () at /lib64/libc.so.6
#1  0x00007ffff730af50 in pthread_cond_wait@@GLIBC_2.3.2 () at /lib64/libc.so.6
#2  0x0000555555dc1686 in qemu_cond_wait_impl (cond=0x5555566639c0, mutex=0x55555632cf60 <qemu_global_mutex>, file=0x555555f07d6b "../softmmu/cpus.c", line=424) at ../util/qemu-thread-posix.c:225
#3  0x00005555559d78fb in qemu_wait_io_event (cpu=0x555556610190) at ../softmmu/cpus.c:424
#4  0x0000555555bbafec in mttcg_cpu_thread_fn (arg=0x555556610190) at ../accel/tcg/tcg-accel-ops-mttcg.c:123
#5  0x0000555555dc1ece in qemu_thread_start (args=0x555556663a00) at ../util/qemu-thread-posix.c:541
#6  0x00007ffff730bc64 in start_thread () at /lib64/libc.so.6
#7  0x00007ffff7393550 in clone3 () at /lib64/libc.so.6

Thread 4 (Thread 0x7ffff4b506c0 (LWP 116341) "qemu-system-s39"):
#0  0x00007ffff730820e in __futex_abstimed_wait_common () at /lib64/libc.so.6
#1  0x00007ffff730af50 in pthread_cond_wait@@GLIBC_2.3.2 () at /lib64/libc.so.6
#2  0x0000555555dc1686 in qemu_cond_wait_impl (cond=0x55555660fed0, mutex=0x55555632cf60 <qemu_global_mutex>, file=0x555555f07d6b "../softmmu/cpus.c", line=424) at ../util/qemu-thread-posix.c:225
#3  0x00005555559d78fb in qemu_wait_io_event (cpu=0x5555565bc6a0) at ../softmmu/cpus.c:424
#4  0x0000555555bbafec in mttcg_cpu_thread_fn (arg=0x5555565bc6a0) at ../accel/tcg/tcg-accel-ops-mttcg.c:123
#5  0x0000555555dc1ece in qemu_thread_start (args=0x55555660ff10) at ../util/qemu-thread-posix.c:541
#6  0x00007ffff730bc64 in start_thread () at /lib64/libc.so.6
#7  0x00007ffff7393550 in clone3 () at /lib64/libc.so.6

Thread 3 (Thread 0x7ffff53516c0 (LWP 116339) "qemu-system-s39"):
#0  0x00007ffff730820e in __futex_abstimed_wait_common () at /lib64/libc.so.6
#1  0x00007ffff730af50 in pthread_cond_wait@@GLIBC_2.3.2 () at /lib64/libc.so.6
#2  0x0000555555dc1686 in qemu_cond_wait_impl (cond=0x5555565bc3e0, mutex=0x55555632cf60 <qemu_global_mutex>, file=0x555555f07d6b "../softmmu/cpus.c", line=424) at ../util/qemu-thread-posix.c:225
#3  0x00005555559d78fb in qemu_wait_io_event (cpu=0x555556568c90) at ../softmmu/cpus.c:424
#4  0x0000555555bbafec in mttcg_cpu_thread_fn (arg=0x555556568c90) at ../accel/tcg/tcg-accel-ops-mttcg.c:123
#5  0x0000555555dc1ece in qemu_thread_start (args=0x5555565bc420) at ../util/qemu-thread-posix.c:541
#6  0x00007ffff730bc64 in start_thread () at /lib64/libc.so.6
#7  0x00007ffff7393550 in clone3 () at /lib64/libc.so.6

Thread 2 (Thread 0x7ffff63bb6c0 (LWP 116338) "qemu-system-s39"):
#0  0x00007ffff738b41d in syscall () at /lib64/libc.so.6
#1  0x0000555555dc1b34 in qemu_futex_wait (f=0x555556354cf8 <rcu_call_ready_event>, val=4294967295) at /root/git/qemu/include/qemu/futex.h:29
#2  0x0000555555dc1d1b in qemu_event_wait (ev=0x555556354cf8 <rcu_call_ready_event>) at ../util/qemu-thread-posix.c:464
#3  0x0000555555dce603 in call_rcu_thread (opaque=0x0) at ../util/rcu.c:278
#4  0x0000555555dc1ece in qemu_thread_start (args=0x5555563bff20) at ../util/qemu-thread-posix.c:541
#5  0x00007ffff730bc64 in start_thread () at /lib64/libc.so.6
#6  0x00007ffff7393550 in clone3 () at /lib64/libc.so.6

Thread 1 (Thread 0x7ffff63bef40 (LWP 116335) "qemu-system-s39"):
#0  0x00007ffff7385596 in ppoll () at /lib64/libc.so.6
#1  0x0000555555ddf603 in qemu_poll_ns (fds=0x55555680d130, nfds=75, timeout=9583649) at ../util/qemu-timer.c:351
#2  0x0000555555ddaf2b in os_host_main_loop_wait (timeout=9583649) at ../util/main-loop.c:308
#3  0x0000555555ddb05a in main_loop_wait (nonblocking=0) at ../util/main-loop.c:592
#4  0x00005555559e5ec1 in qemu_main_loop () at ../softmmu/runstate.c:732
#5  0x0000555555bc0cb4 in qemu_default_main () at ../softmmu/main.c:37
#6  0x0000555555bc0cea in main (argc=46, argv=0x7fffffffe278) at ../softmmu/main.c:48
(gdb) 



