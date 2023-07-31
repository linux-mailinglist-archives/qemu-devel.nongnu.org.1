Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B45687694F2
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 13:33:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQR7x-0007DO-Sb; Mon, 31 Jul 2023 07:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qQR7u-0007DD-Qe
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 07:31:51 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qQR7s-0002ny-72
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 07:31:50 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 35B0A2227F;
 Mon, 31 Jul 2023 11:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1690803105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sE2VhXG5tTN8UaU2KZaTAFi19GhEmvjNftrpSFsJ1gE=;
 b=kd21sUDSQcdaOf/c3DI7PN/uUcmO6t/MuWV61FPGYr3vhDcF2gFDrbKCYrMdsLbFjShgQC
 dSRn5OnkHMqhdrH3Y8eEh8xid5+v0zsayZDPIXVeUuV2mOTNKvYc7OelrktbT8JUPH+t9G
 VSCSFGlOuUGOjKdBUqA5K8y17Ctv1gI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1690803105;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sE2VhXG5tTN8UaU2KZaTAFi19GhEmvjNftrpSFsJ1gE=;
 b=edJ3dFFh28HrDLgrni6uDchkGVfZOAXeQwb+AJ9713mCiP8RDFu7vD3Cf+oQo+9TMKXYbc
 yf8r9zUJSJ/boOAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EF5B01322C;
 Mon, 31 Jul 2023 11:31:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Akd6OKCbx2RYfAAAMHmgww
 (envelope-from <cfontana@suse.de>); Mon, 31 Jul 2023 11:31:44 +0000
Message-ID: <8141c5c6-833a-5e1e-586b-c4d99c2585f7@suse.de>
Date: Mon, 31 Jul 2023 13:31:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: assert fails in s390x TCG
Content-Language: en-US
From: Claudio Fontana <cfontana@suse.de>
To: Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <eaec32e3-d56a-e6a7-fcbe-860948e79658@suse.de>
In-Reply-To: <eaec32e3-d56a-e6a7-fcbe-860948e79658@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:67c:2178:6::1c;
 envelope-from=cfontana@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 7/21/23 11:08, Claudio Fontana wrote:
> 
> Hello Cornelia, Richard,
> 
> I had some strange behavior in an s390x TCG VM that I am debugging,
> 
> and configured latest upstream QEMU with --enable-debug --enable-debug-tcg
> 
> and I am running the qemu binary with -d unimp,guest_errors .
> 
> I get:
> 
> /usr/bin/qemu-system-s390x -nodefaults -no-reboot -nographic -vga none -cpu qemu -d unimp,guest_errors -object rng-random,filename=/dev/random,id=rng0 -device virtio-rng-ccw,rng=rng0 -runas qemu -net none -kernel /var/tmp/boot/kernel -initrd /var/tmp/boot/initrd -append root=/dev/disk/by-id/virtio-0 rootfstype=ext3 rootflags=data=writeback,nobarrier,commit=150,noatime elevator=noop nmi_watchdog=0 rw oops=panic panic=1 quiet elevator=noop console=hvc0 init=build -m 2048 -drive file=/var/tmp/img,format=raw,if=none,id=disk,cache=unsafe -device virtio-blk-ccw,drive=disk,serial=0 -drive file=/var/tmp/swap,format=raw,if=none,id=swap,cache=unsafe -device virtio-blk-ccw,drive=swap,serial=1 -device virtio-serial-ccw -device virtconsole,chardev=virtiocon0 -chardev stdio,id=virtiocon0 -chardev socket,id=monitor,server=on,wait=off,path=/var/tmp/img.qemu/monitor -mon chardev=monitor,mode=readline -smp 8
> 
> unimplemented opcode 0xb9ab
> unimplemented opcode 0xb2af
> 
> ERROR:../accel/tcg/tb-maint.c:348:page_unlock__debug: assertion failed: (page_is_locked(pd))
> Bail out! ERROR:../accel/tcg/tb-maint.c:348:page_unlock__debug: assertion failed: (page_is_locked(pd))
> 
> Thread 3 "qemu-system-s39" received signal SIGABRT, Aborted.
> [Switching to Thread 0x7ffff53516c0 (LWP 215975)]
> (gdb) bt
> #0  0x00007ffff730dabc in __pthread_kill_implementation () at /lib64/libc.so.6
> #1  0x00007ffff72bc266 in raise () at /lib64/libc.so.6
> #2  0x00007ffff72a4897 in abort () at /lib64/libc.so.6
> #3  0x00007ffff76f0eee in  () at /lib64/libglib-2.0.so.0
> #4  0x00007ffff775649a in g_assertion_message_expr () at /lib64/libglib-2.0.so.0
> #5  0x0000555555b96134 in page_unlock__debug (pd=0x7ffee8680440) at ../accel/tcg/tb-maint.c:348
> #6  0x0000555555b962a9 in page_unlock (pd=0x7ffee8680440) at ../accel/tcg/tb-maint.c:397
> #7  0x0000555555b96580 in tb_unlock_pages (tb=0x7fffefffeb00) at ../accel/tcg/tb-maint.c:483
> #8  0x0000555555b94698 in cpu_exec_longjmp_cleanup (cpu=0x555556566a30) at ../accel/tcg/cpu-exec.c:556
> #9  0x0000555555b954e0 in cpu_exec_setjmp (cpu=0x555556566a30, sc=0x7ffff5350540) at ../accel/tcg/cpu-exec.c:1054
> #10 0x0000555555b9557a in cpu_exec (cpu=0x555556566a30) at ../accel/tcg/cpu-exec.c:1083
> #11 0x0000555555bb9af6 in tcg_cpus_exec (cpu=0x555556566a30) at ../accel/tcg/tcg-accel-ops.c:75
> #12 0x0000555555bba1ae in mttcg_cpu_thread_fn (arg=0x555556566a30) at ../accel/tcg/tcg-accel-ops-mttcg.c:95
> #13 0x0000555555dc0af3 in qemu_thread_start (args=0x5555565ba150) at ../util/qemu-thread-posix.c:541
> #14 0x00007ffff730bc64 in start_thread () at /lib64/libc.so.6
> #15 0x00007ffff7393550 in clone3 () at /lib64/libc.so.6
> 
> (gdb) frame 5
> #5  0x0000555555b96134 in page_unlock__debug (pd=0x7ffee8680440) at ../accel/tcg/tb-maint.c:348
> 348         g_assert(page_is_locked(pd));
> (gdb) list 348
> 343     static void page_unlock__debug(const PageDesc *pd)
> 344     {
> 345         bool removed;
> 346
> 347         ht_pages_locked_debug_init();
> 348         g_assert(page_is_locked(pd));
> 349         removed = g_hash_table_remove(ht_pages_locked_debug, pd);
> 350         g_assert(removed);
> 351     }
> 352
> 
> (gdb) info threads
>   Id   Target Id                                            Frame 
>   1    Thread 0x7ffff63bef40 (LWP 215971) "qemu-system-s39" 0x00007ffff7385596 in ppoll () from /lib64/libc.so.6
>   2    Thread 0x7ffff63bb6c0 (LWP 215974) "qemu-system-s39" 0x00007ffff738b41d in syscall () from /lib64/libc.so.6
> * 3    Thread 0x7ffff53516c0 (LWP 215975) "qemu-system-s39" 0x00007ffff730dabc in __pthread_kill_implementation () from /lib64/libc.so.6
>   4    Thread 0x7ffff4b506c0 (LWP 215976) "qemu-system-s39" 0x00007ffff730820e in __futex_abstimed_wait_common () from /lib64/libc.so.6
>   5    Thread 0x7ffeefdff6c0 (LWP 215977) "qemu-system-s39" 0x00007ffff730820e in __futex_abstimed_wait_common () from /lib64/libc.so.6
>   6    Thread 0x7ffeef5fe6c0 (LWP 215978) "qemu-system-s39" 0x00007ffff730820e in __futex_abstimed_wait_common () from /lib64/libc.so.6
>   7    Thread 0x7ffeeedfd6c0 (LWP 215979) "qemu-system-s39" 0x00007ffff730820e in __futex_abstimed_wait_common () from /lib64/libc.so.6
>   8    Thread 0x7ffeee5fc6c0 (LWP 215980) "qemu-system-s39" 0x00007ffff730820e in __futex_abstimed_wait_common () from /lib64/libc.so.6
>   9    Thread 0x7ffeeddfb6c0 (LWP 215981) "qemu-system-s39" 0x00007ffff730820e in __futex_abstimed_wait_common () from /lib64/libc.so.6
>   10   Thread 0x7ffeed5fa6c0 (LWP 215982) "qemu-system-s39" 0x00007ffff730820e in __futex_abstimed_wait_common () from /lib64/libc.so.6
> 
> (gdb) thread apply all bt
> 
> Thread 10 (Thread 0x7ffeed5fa6c0 (LWP 215982) "qemu-system-s39"):
> #0  0x00007ffff730820e in __futex_abstimed_wait_common () at /lib64/libc.so.6
> #1  0x00007ffff730af50 in pthread_cond_wait@@GLIBC_2.3.2 () at /lib64/libc.so.6
> #2  0x0000555555dc02ab in qemu_cond_wait_impl (cond=0x555556803f30, mutex=0x55555632aac0 <qemu_global_mutex>, file=0x555555f05d6b "../softmmu/cpus.c", line=424) at ../util/qemu-thread-posix.c:225
> #3  0x00005555559d78fb in qemu_wait_io_event (cpu=0x5555567b0600) at ../softmmu/cpus.c:424
> #4  0x0000555555bba27a in mttcg_cpu_thread_fn (arg=0x5555567b0600) at ../accel/tcg/tcg-accel-ops-mttcg.c:123
> #5  0x0000555555dc0af3 in qemu_thread_start (args=0x555556803f70) at ../util/qemu-thread-posix.c:541
> #6  0x00007ffff730bc64 in start_thread () at /lib64/libc.so.6
> #7  0x00007ffff7393550 in clone3 () at /lib64/libc.so.6
> 
> Thread 9 (Thread 0x7ffeeddfb6c0 (LWP 215981) "qemu-system-s39"):
> #0  0x00007ffff730820e in __futex_abstimed_wait_common () at /lib64/libc.so.6
> #1  0x00007ffff730af50 in pthread_cond_wait@@GLIBC_2.3.2 () at /lib64/libc.so.6
> #2  0x0000555555dc02ab in qemu_cond_wait_impl (cond=0x5555567b0340, mutex=0x55555632aac0 <qemu_global_mutex>, file=0x555555f05d6b "../softmmu/cpus.c", line=424) at ../util/qemu-thread-posix.c:225
> #3  0x00005555559d78fb in qemu_wait_io_event (cpu=0x55555675cb10) at ../softmmu/cpus.c:424
> #4  0x0000555555bba27a in mttcg_cpu_thread_fn (arg=0x55555675cb10) at ../accel/tcg/tcg-accel-ops-mttcg.c:123
> #5  0x0000555555dc0af3 in qemu_thread_start (args=0x5555567b0380) at ../util/qemu-thread-posix.c:541
> #6  0x00007ffff730bc64 in start_thread () at /lib64/libc.so.6
> #7  0x00007ffff7393550 in clone3 () at /lib64/libc.so.6
> 
> Thread 8 (Thread 0x7ffeee5fc6c0 (LWP 215980) "qemu-system-s39"):
> #0  0x00007ffff730820e in __futex_abstimed_wait_common () at /lib64/libc.so.6
> #1  0x00007ffff730af50 in pthread_cond_wait@@GLIBC_2.3.2 () at /lib64/libc.so.6
> #2  0x0000555555dc02ab in qemu_cond_wait_impl (cond=0x55555675c850, mutex=0x55555632aac0 <qemu_global_mutex>, file=0x555555f05d6b "../softmmu/cpus.c", line=424) at ../util/qemu-thread-posix.c:225
> #3  0x00005555559d78fb in qemu_wait_io_event (cpu=0x5555567090f0) at ../softmmu/cpus.c:424
> #4  0x0000555555bba27a in mttcg_cpu_thread_fn (arg=0x5555567090f0) at ../accel/tcg/tcg-accel-ops-mttcg.c:123
> #5  0x0000555555dc0af3 in qemu_thread_start (args=0x55555675c890) at ../util/qemu-thread-posix.c:541
> #6  0x00007ffff730bc64 in start_thread () at /lib64/libc.so.6
> #7  0x00007ffff7393550 in clone3 () at /lib64/libc.so.6
> 
> Thread 7 (Thread 0x7ffeeedfd6c0 (LWP 215979) "qemu-system-s39"):
> #0  0x00007ffff730820e in __futex_abstimed_wait_common () at /lib64/libc.so.6
> #1  0x00007ffff730af50 in pthread_cond_wait@@GLIBC_2.3.2 () at /lib64/libc.so.6
> #2  0x0000555555dc02ab in qemu_cond_wait_impl (cond=0x555556708e50, mutex=0x55555632aac0 <qemu_global_mutex>, file=0x555555f05d6b "../softmmu/cpus.c", line=424) at ../util/qemu-thread-posix.c:225
> #3  0x00005555559d78fb in qemu_wait_io_event (cpu=0x5555566b5490) at ../softmmu/cpus.c:424
> #4  0x0000555555bba27a in mttcg_cpu_thread_fn (arg=0x5555566b5490) at ../accel/tcg/tcg-accel-ops-mttcg.c:123
> #5  0x0000555555dc0af3 in qemu_thread_start (args=0x555556708e90) at ../util/qemu-thread-posix.c:541
> #6  0x00007ffff730bc64 in start_thread () at /lib64/libc.so.6
> #7  0x00007ffff7393550 in clone3 () at /lib64/libc.so.6
> 
> Thread 6 (Thread 0x7ffeef5fe6c0 (LWP 215978) "qemu-system-s39"):
> #0  0x00007ffff730820e in __futex_abstimed_wait_common () at /lib64/libc.so.6
> #1  0x00007ffff730af50 in pthread_cond_wait@@GLIBC_2.3.2 () at /lib64/libc.so.6
> #2  0x0000555555dc02ab in qemu_cond_wait_impl (cond=0x5555566b51d0, mutex=0x55555632aac0 <qemu_global_mutex>, file=0x555555f05d6b "../softmmu/cpus.c", line=424) at ../util/qemu-thread-posix.c:225
> #3  0x00005555559d78fb in qemu_wait_io_event (cpu=0x5555566619a0) at ../softmmu/cpus.c:424
> #4  0x0000555555bba27a in mttcg_cpu_thread_fn (arg=0x5555566619a0) at ../accel/tcg/tcg-accel-ops-mttcg.c:123
> #5  0x0000555555dc0af3 in qemu_thread_start (args=0x5555566b5210) at ../util/qemu-thread-posix.c:541
> #6  0x00007ffff730bc64 in start_thread () at /lib64/libc.so.6
> #7  0x00007ffff7393550 in clone3 () at /lib64/libc.so.6
> 
> Thread 5 (Thread 0x7ffeefdff6c0 (LWP 215977) "qemu-system-s39"):
> #0  0x00007ffff730820e in __futex_abstimed_wait_common () at /lib64/libc.so.6
> #1  0x00007ffff730af50 in pthread_cond_wait@@GLIBC_2.3.2 () at /lib64/libc.so.6
> #2  0x0000555555dc02ab in qemu_cond_wait_impl (cond=0x5555566616e0, mutex=0x55555632aac0 <qemu_global_mutex>, file=0x555555f05d6b "../softmmu/cpus.c", line=424) at ../util/qemu-thread-posix.c:225
> #3  0x00005555559d78fb in qemu_wait_io_event (cpu=0x55555660deb0) at ../softmmu/cpus.c:424
> #4  0x0000555555bba27a in mttcg_cpu_thread_fn (arg=0x55555660deb0) at ../accel/tcg/tcg-accel-ops-mttcg.c:123
> #5  0x0000555555dc0af3 in qemu_thread_start (args=0x555556661720) at ../util/qemu-thread-posix.c:541
> #6  0x00007ffff730bc64 in start_thread () at /lib64/libc.so.6
> #7  0x00007ffff7393550 in clone3 () at /lib64/libc.so.6
> 
> Thread 4 (Thread 0x7ffff4b506c0 (LWP 215976) "qemu-system-s39"):
> #0  0x00007ffff730820e in __futex_abstimed_wait_common () at /lib64/libc.so.6
> #1  0x00007ffff730af50 in pthread_cond_wait@@GLIBC_2.3.2 () at /lib64/libc.so.6
> #2  0x0000555555dc02ab in qemu_cond_wait_impl (cond=0x55555660dbf0, mutex=0x55555632aac0 <qemu_global_mutex>, file=0x555555f05d6b "../softmmu/cpus.c", line=424) at ../util/qemu-thread-posix.c:225
> #3  0x00005555559d78fb in qemu_wait_io_event (cpu=0x5555565ba3d0) at ../softmmu/cpus.c:424
> #4  0x0000555555bba27a in mttcg_cpu_thread_fn (arg=0x5555565ba3d0) at ../accel/tcg/tcg-accel-ops-mttcg.c:123
> #5  0x0000555555dc0af3 in qemu_thread_start (args=0x55555660dc30) at ../util/qemu-thread-posix.c:541
> #6  0x00007ffff730bc64 in start_thread () at /lib64/libc.so.6
> #7  0x00007ffff7393550 in clone3 () at /lib64/libc.so.6
> 
> Thread 3 (Thread 0x7ffff53516c0 (LWP 215975) "qemu-system-s39"):
> #0  0x00007ffff730dabc in __pthread_kill_implementation () at /lib64/libc.so.6
> #1  0x00007ffff72bc266 in raise () at /lib64/libc.so.6
> #2  0x00007ffff72a4897 in abort () at /lib64/libc.so.6
> #3  0x00007ffff76f0eee in  () at /lib64/libglib-2.0.so.0
> #4  0x00007ffff775649a in g_assertion_message_expr () at /lib64/libglib-2.0.so.0
> #5  0x0000555555b96134 in page_unlock__debug (pd=0x7ffee8680440) at ../accel/tcg/tb-maint.c:348
> #6  0x0000555555b962a9 in page_unlock (pd=0x7ffee8680440) at ../accel/tcg/tb-maint.c:397
> #7  0x0000555555b96580 in tb_unlock_pages (tb=0x7fffefffeb00) at ../accel/tcg/tb-maint.c:483
> #8  0x0000555555b94698 in cpu_exec_longjmp_cleanup (cpu=0x555556566a30) at ../accel/tcg/cpu-exec.c:556
> #9  0x0000555555b954e0 in cpu_exec_setjmp (cpu=0x555556566a30, sc=0x7ffff5350540) at ../accel/tcg/cpu-exec.c:1054
> #10 0x0000555555b9557a in cpu_exec (cpu=0x555556566a30) at ../accel/tcg/cpu-exec.c:1083
> #11 0x0000555555bb9af6 in tcg_cpus_exec (cpu=0x555556566a30) at ../accel/tcg/tcg-accel-ops.c:75
> #12 0x0000555555bba1ae in mttcg_cpu_thread_fn (arg=0x555556566a30) at ../accel/tcg/tcg-accel-ops-mttcg.c:95
> #13 0x0000555555dc0af3 in qemu_thread_start (args=0x5555565ba150) at ../util/qemu-thread-posix.c:541
> #14 0x00007ffff730bc64 in start_thread () at /lib64/libc.so.6
> #15 0x00007ffff7393550 in clone3 () at /lib64/libc.so.6
> 
> Thread 2 (Thread 0x7ffff63bb6c0 (LWP 215974) "qemu-system-s39"):
> #0  0x00007ffff738b41d in syscall () at /lib64/libc.so.6
> #1  0x0000555555dc0759 in qemu_futex_wait (f=0x555556352818 <rcu_call_ready_event>, val=4294967295) at /root/git/qemu/include/qemu/futex.h:29
> #2  0x0000555555dc0940 in qemu_event_wait (ev=0x555556352818 <rcu_call_ready_event>) at ../util/qemu-thread-posix.c:464
> #3  0x0000555555dcd228 in call_rcu_thread (opaque=0x0) at ../util/rcu.c:278
> #4  0x0000555555dc0af3 in qemu_thread_start (args=0x5555563bdf20) at ../util/qemu-thread-posix.c:541
> #5  0x00007ffff730bc64 in start_thread () at /lib64/libc.so.6
> #6  0x00007ffff7393550 in clone3 () at /lib64/libc.so.6
> 
> Thread 1 (Thread 0x7ffff63bef40 (LWP 215971) "qemu-system-s39"):
> #0  0x00007ffff7385596 in ppoll () at /lib64/libc.so.6
> #1  0x0000555555dde228 in qemu_poll_ns (fds=0x55555680ae50, nfds=75, timeout=9378142) at ../util/qemu-timer.c:351
> #2  0x0000555555dd9b50 in os_host_main_loop_wait (timeout=9378142) at ../util/main-loop.c:308
> #3  0x0000555555dd9c7f in main_loop_wait (nonblocking=0) at ../util/main-loop.c:592
> #4  0x00005555559e5c3e in qemu_main_loop () at ../softmmu/runstate.c:732
> #5  0x0000555555bbff42 in qemu_default_main () at ../softmmu/main.c:37
> #6  0x0000555555bbff78 in main (argc=46, argv=0x7fffffffe278) at ../softmmu/main.c:48
> 
> ----

Hi Richard,

with the two patches:

accel/tcg: Clear tcg_ctx->gen_tb on buffer overflow

and

target/s390x: Move trans_exc_code update to do_program_interrupt

I do not get asserts anymore.

I did notice though some error happening once, that I never saw before when I was running without these patches (and without --enable-debug-tcg, so I would not get asserts).

I have "-d unimp,guest_errors" currently in the cmdline.

unimplemented opcode 0x0000
[   87.544553][  T320] illegal operation: 0001 ilc:1 [#1] SMP 
[   87.546245][  T320] Modules linked in: virtio_blk(+) xfs btrfs blake2b_generic xor raid6_pq libcrc32c ext4 crc32_vx_s390 crc16 mbcache jbd2 squashfs lz4_decompress fuse dm_snapshot dm_bufio dm_crypt essiv authenc dm_mod binfmt_misc loop sg scsi_mod
[   87.550754][  T320] Supported: Yes
[   87.552441][  T320] CPU: 4 PID: 320 Comm: modprobe Not tainted 5.14.21-150400.22-default #1 SLE15-SP4 a8270a81de044ce12d2ba9b360e3443bea691c52
[   87.554408][  T320] Hardware name: QEMU 8561 QEMU (KVM/Linux)
[   87.555528][  T320] Krnl PSW : 0704e00180000000 000003ff80580002 (____versions+0x7f80240c6a/0x7f802411f8 [virtio_blk])
[   87.557435][  T320]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
[   87.558866][  T320] Krnl GPRS: 0000000007ca7520 000003ff805805d8 000000000400f030 0000000007c40000
[   87.559938][  T320]            0000000000000000 0000000000000000 0000000000000000 000000000400f030
[   87.561557][  T320]            0000000007ca7480 0000000000000007 0000000000000000 0000000007c40000
[   87.562821][  T320]            0000000002dfa100 0000000000002200 000003ff805805de 000003800033b6d8
[   87.566124][  T320] Krnl Code:#000003ff80580000: 0000                illegal 
[   87.566124][  T320]           >000003ff80580002: 0000                illegal 
[   87.566124][  T320]            000003ff80580004: 011a                unknown
[   87.566124][  T320]            000003ff80580006: c1f800000000        unknown
[   87.566124][  T320]            000003ff8058000c: 00fa                unknown
[   87.566124][  T320]            000003ff8058000e: c1a800000000        unknown
[   87.566124][  T320]            000003ff80580014: 00fd                unknown
[   87.566124][  T320]            000003ff80580016: 6c500d10            md      %f5,3344
[   87.573838][  T320] Call Trace:
[   87.576335][  T320]  [<000003ff80580002>] ____versions+0x7f80240c6a/0x7f802411f8 [virtio_blk] 
[   87.577717][  T320] ([<00000000005cf7d6>] blk_mq_alloc_rqs+0xfe/0x2a8)
[   87.578756][  T320]  [<00000000005cf9fe>] __blk_mq_alloc_map_and_request+0x7e/0x100 
[   87.579829][  T320]  [<00000000005d09be>] blk_mq_alloc_tag_set+0x266/0x3b8 
[   87.580847][  T320]  [<000003ff80581b62>] virtblk_probe+0x3d2/0xb88 [virtio_blk] 
[   87.582545][  T320]  [<00000000006ddb12>] virtio_dev_probe+0x192/0x360 
[   87.583506][  T320]  [<000000000072d2e2>] really_probe+0x1c2/0x490 
[   87.584357][  T320]  [<000000000072d768>] driver_probe_device+0x40/0xf8 
[   87.585248][  T320]  [<000000000072ddf6>] __driver_attach+0x86/0x198 
[   87.586055][  T320]  [<000000000072a8fa>] bus_for_each_dev+0x82/0xc8 
[   87.586964][  T320]  [<000000000072c130>] bus_add_driver+0x170/0x258 
[   87.587767][  T320]  [<000000000072e608>] driver_register+0x88/0x160 
[   87.588631][  T320]  [<000003ff8058706a>] init+0x6a/0x1000 [virtio_blk] 
[   87.589550][  T320]  [<0000000000100bf0>] do_one_initcall+0x40/0x208 
[   87.590491][  T320]  [<00000000009c1620>] do_init_module+0x70/0x260 
[   87.592186][  T320]  [<000000000021e0b4>] load_module+0x1de4/0x25d0 
[   87.593207][  T320]  [<000000000021ea58>] __do_sys_init_module+0x1b8/0x1e8 
[   87.594226][  T320]  [<00000000009c570a>] __do_syscall+0x1c2/0x1e8 
[   87.595069][  T320]  [<00000000009d4a28>] system_call+0x78/0xa0 
[   87.596053][  T320] Last Breaking-Event-Address:
[   87.596697][  T320]  [<000000003fffe2c0>] 0x3fffe2c0
[   87.598784][  T320] Kernel panic - not syncing: Fatal exception: panic_on_oops
Guest crashed on cpu 4: disabled-wait
PSW: 0x0002000180000000 0x000000000010fdd0

This did not manifest again when rerunning.
Just FYI in case it helps, it might "just" be a kernel error, but I never saw this before when running unpatched...

Thanks,

Claudio



