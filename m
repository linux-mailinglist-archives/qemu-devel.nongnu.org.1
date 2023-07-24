Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1B875ED54
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 10:22:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNqpG-0001N6-51; Mon, 24 Jul 2023 04:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qNqoY-0001C4-O7
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 04:21:14 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qNqoW-0001TK-1i
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 04:21:10 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1DAF22058E;
 Mon, 24 Jul 2023 08:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1690186865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5NrsnEsB7EZaUudJvsIbn2LYBvnP/ZSEZPEDnwqobmw=;
 b=TNteTNFMim1hVRWLkB/w5tD3BVhYvXqPqfCDjWLRCjGVcIsRqLlMMMBeJtYM/SGHfRnBDT
 DckXlZA026LSq10IllT5u+jXD93Y9IvbKKV9Jm4agNnQIsVExFi/FvU9e69zpSfSPH/kze
 +vt929PxFZSlP8EaNR6DHBw7AJJuaJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1690186865;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5NrsnEsB7EZaUudJvsIbn2LYBvnP/ZSEZPEDnwqobmw=;
 b=2qjGVQ9l/WEv0KHVDMIrcqo+vTI7i/wzohQVgwau9fnBl8RmqiRcbgJHVl+Xy1v0hFlYux
 zYuv3HHsTZHDEgDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E3672138E8;
 Mon, 24 Jul 2023 08:21:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id a5vQNXA0vmRsfwAAMHmgww
 (envelope-from <cfontana@suse.de>); Mon, 24 Jul 2023 08:21:04 +0000
Message-ID: <e79ea434-96a4-c7db-219f-190aa628cb57@suse.de>
Date: Mon, 24 Jul 2023 10:21:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: assert fails in s390x TCG
Content-Language: en-US
From: Claudio Fontana <cfontana@suse.de>
To: Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <eaec32e3-d56a-e6a7-fcbe-860948e79658@suse.de>
In-Reply-To: <eaec32e3-d56a-e6a7-fcbe-860948e79658@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:67c:2178:6::1d;
 envelope-from=cfontana@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

.. adding Alex, maybe something related to multithreaded TCG?

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
> 
> If I build normally without debug-tcg I don't seem to incur in this assertion.
> 
> Since I have some strange misbehavior at runtime, with processes dying with segfaults and the guest kernel complaining:
> 
>  [ 2269s] [ 2243.901667][ T8318] User process fault: interruption code 0011 ilc:2 in libc.so.6[3ff87a80000+1c9000]
>  [ 2269s] [ 2243.904433][ T8318] Failing address: 000002aa0f73f000 TEID: 000002aa0f73f800
>  [ 2269s] [ 2243.904952][ T8318] Fault in primary space mode while using user ASCE.
>  [ 2269s] [ 2243.905405][ T8318] AS:00000000057841c7 R3:0000000001fdc007 S:000000000398c000 P:0000000000000400 
> 
> I thought they might possibly be related..
> 
> Thanks for any suggestion,
> 
> Claudio
> 
> 


