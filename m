Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AFD712461
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 12:17:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2UUj-0002MX-V9; Fri, 26 May 2023 06:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q2UUb-0002LW-3D
 for qemu-devel@nongnu.org; Fri, 26 May 2023 06:16:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q2UUV-0001W5-LS
 for qemu-devel@nongnu.org; Fri, 26 May 2023 06:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685096165;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=+csB8LCjO6GsR+ik67DUdw0RgWoXqGikOcNI3J+dpQ4=;
 b=NhEvfjcHOiSVJPjf5F17oytDoHBy6LgwLhhZAQU10Ia0iZ74svkVij18Ag52k/u9cSrnEo
 f81T39Qb9rQ/aDIoS5zWTjTAC1YO8E/9LcWb81OY5xVpI8YybQzglBXxa2OCUWqn3RlWl9
 fnwDENf767dXm89t+rYWXq945mmr2/0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-Vou3YmpOPKyDyw8biaP9Fw-1; Fri, 26 May 2023 06:16:03 -0400
X-MC-Unique: Vou3YmpOPKyDyw8biaP9Fw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f6cc1997fdso2579855e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 03:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685096162; x=1687688162;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+csB8LCjO6GsR+ik67DUdw0RgWoXqGikOcNI3J+dpQ4=;
 b=B2j0HtgWkqUn8ykt7lDXO5EhAtjVKvhnlEXXizNVX2eu7maQhqYm9p8KKh22aRS+G2
 yQ7bcR+VernsySKVaO96HVbMUPz9YhudlAgvng++VpsXHIUH1o4X+s1WohBgrcSWsCVA
 xaWtK1YK8MIQ5GxaVL2reapmgwwBf5UFFoKDHGZLsTFO9NLsaw2yJoAPT3B2LS7TchB8
 77A6YnVVTWUwKzjRWB8j/E4Oyq22QaXzcpX0P4Zp7Qw0ta440Vb6x8N+bXJMpzlQeLjw
 hkBvYSev0ZZSqfXg566QkDJBlB1gGW6Wzo4IgRUp4Qril47Pgc7RpJ/9xC5QCdZLNwl3
 nd2A==
X-Gm-Message-State: AC+VfDx4sGhlXhNu2YnFoHKrUtTL4B1vl8URT81oZRvQMaF9VM9qR6jF
 mWzq2hdXLxy+5jzCmo56bz4zGzS36Nf7qLL6N3LDl+BG+jmhJeizaglZT8OisK2Pc4Rya5YbeJl
 mITnBPyOnD9m77N8=
X-Received: by 2002:a05:600c:b57:b0:3f4:2328:b5c2 with SMTP id
 k23-20020a05600c0b5700b003f42328b5c2mr875591wmr.35.1685096162188; 
 Fri, 26 May 2023 03:16:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4L6r0hRtiD0WHsGHe0eGi6V6Wms8SJPvHTQpcxUpSz4zu+S/jZwf7AobytpxkG7PHcxGMPkw==
X-Received: by 2002:a05:600c:b57:b0:3f4:2328:b5c2 with SMTP id
 k23-20020a05600c0b5700b003f42328b5c2mr875565wmr.35.1685096161734; 
 Fri, 26 May 2023 03:16:01 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 n4-20020a05600c294400b003f3157988f8sm4737603wmd.26.2023.05.26.03.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 03:16:01 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 eblake@redhat.com,  vsementsov@yandex-team.ru,  jsnow@redhat.com,
 stefanha@redhat.com,  fam@euphon.net,  qemu-block@nongnu.org,
 pbonzini@redhat.com,  t.lamprecht@proxmox.com
Subject: Re: [PATCH v2] migration: hold the BQL during setup
In-Reply-To: <20230525164726.45176-1-f.ebner@proxmox.com> (Fiona Ebner's
 message of "Thu, 25 May 2023 18:47:26 +0200")
References: <20230525164726.45176-1-f.ebner@proxmox.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Fri, 26 May 2023 12:16:00 +0200
Message-ID: <87sfbj1jq7.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fiona Ebner <f.ebner@proxmox.com> wrote:

Nak

Sometimes it works, and sometimes it hangs.

When I was preparing with make check to send the pull request, I got
this:


Thread 5 (Thread 0x7f01d6ffd6c0 (LWP 921583) "live_migration"):
#0  0x00007f0217ff81d9 in __futex_abstimed_wait_common64 (private=0, cancel=true, abstime=0x0, op=393, expected=0, futex_word=0x55d20315e860) at futex-internal.c:57
#1  __futex_abstimed_wait_common (futex_word=futex_word@entry=0x55d20315e860, expected=expected@entry=0, clockid=clockid@entry=0, abstime=abstime@entry=0x0, private=private@entry=0, cancel=cancel@entry=true) at futex-internal.c:87
#2  0x00007f0217ff825f in __GI___futex_abstimed_wait_cancelable64 (futex_word=futex_word@entry=0x55d20315e860, expected=expected@entry=0, clockid=clockid@entry=0, abstime=abstime@entry=0x0, private=private@entry=0) at futex-internal.c:139
#3  0x00007f0217ffab79 in __pthread_cond_wait_common (abstime=0x0, clockid=0, mutex=0x7f01d6ffc380, cond=0x55d20315e838) at pthread_cond_wait.c:503
#4  ___pthread_cond_wait (cond=cond@entry=0x55d20315e838, mutex=mutex@entry=0x55d20315e808) at pthread_cond_wait.c:618
#5  0x000055d2014fa10b in qemu_cond_wait_impl (cond=0x55d20315e838, mutex=0x55d20315e808, file=0x55d201710eb0 "../../../../mnt/code/qemu/full/util/qemu-thread-posix.c", line=314) at ../../../../mnt/code/qemu/full/util/qemu-thread-posix.c:225
#6  0x000055d2014fa617 in qemu_sem_wait (sem=0x55d20315e808) at ../../../../mnt/code/qemu/full/util/qemu-thread-posix.c:314
#7  0x000055d2011780cf in multifd_send_sync_main (f=f@entry=0x55d202830d10) at ../../../../mnt/code/qemu/full/migration/multifd.c:633
#8  0x000055d2012fdc1b in ram_save_setup (f=0x55d202830d10, opaque=<optimized out>) at ../../../../mnt/code/qemu/full/migration/ram.c:3029
#9  0x000055d201183995 in qemu_savevm_state_setup (f=0x55d202830d10) at ../../../../mnt/code/qemu/full/migration/savevm.c:1269
#10 0x000055d20117482f in migration_thread (opaque=opaque@entry=0x55d202852070) at ../../../../mnt/code/qemu/full/migration/migration.c:2963
#11 0x000055d2014f95f8 in qemu_thread_start (args=0x55d20340a1a0) at ../../../../mnt/code/qemu/full/util/qemu-thread-posix.c:541
#12 0x00007f0217ffb907 in start_thread (arg=<optimized out>) at pthread_create.c:444
#13 0x00007f0218081870 in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81

Thread 4 (Thread 0x7f02158876c0 (LWP 921554) "CPU 0/KVM"):
#0  futex_wait (private=0, expected=2, futex_word=0x55d201dd3000 <qemu_global_mutex>) at ../sysdeps/nptl/futex-internal.h:146
#1  __GI___lll_lock_wait (futex=futex@entry=0x55d201dd3000 <qemu_global_mutex>, private=0) at lowlevellock.c:49
#2  0x00007f0217ffee21 in lll_mutex_lock_optimized (mutex=0x55d201dd3000 <qemu_global_mutex>) at pthread_mutex_lock.c:48
#3  ___pthread_mutex_lock (mutex=mutex@entry=0x55d201dd3000 <qemu_global_mutex>) at pthread_mutex_lock.c:93
#4  0x000055d2014f99d3 in qemu_mutex_lock_impl (mutex=0x55d201dd3000 <qemu_global_mutex>, file=0x55d2016942d0 "../../../../mnt/code/qemu/full/softmmu/physmem.c", line=2588) at ../../../../mnt/code/qemu/full/util/qemu-thread-posix.c:94
#5  0x000055d201148142 in qemu_mutex_lock_iothread_impl (file=file@entry=0x55d2016942d0 "../../../../mnt/code/qemu/full/softmmu/physmem.c", line=line@entry=2588) at ../../../../mnt/code/qemu/full/softmmu/cpus.c:504
#6  0x000055d2012eeaf1 in prepare_mmio_access (mr=0x55d20315db10) at ../../../../mnt/code/qemu/full/softmmu/physmem.c:2588
#7  flatview_write_continue (fv=fv@entry=0x7f01cc016d50, addr=addr@entry=1016, attrs=..., attrs@entry=..., ptr=ptr@entry=0x7f0219524000, len=len@entry=1, addr1=<optimized out>, l=<optimized out>, mr=0x55d20315db10) at ../../../../mnt/code/qemu/full/softmmu/physmem.c:2643
#8  0x000055d2012eebe9 in flatview_write (fv=0x7f01cc016d50, addr=addr@entry=1016, attrs=attrs@entry=..., buf=buf@entry=0x7f0219524000, len=len@entry=1) at ../../../../mnt/code/qemu/full/softmmu/physmem.c:2690
#9  0x000055d2012f1feb in address_space_write (len=1, buf=0x7f0219524000, attrs=..., addr=1016, as=0x55d201de6e60 <address_space_io>) at ../../../../mnt/code/qemu/full/softmmu/physmem.c:2786
#10 address_space_rw (as=0x55d201de6e60 <address_space_io>, addr=addr@entry=1016, attrs=attrs@entry=..., buf=0x7f0219524000, len=len@entry=1, is_write=is_write@entry=true) at ../../../../mnt/code/qemu/full/softmmu/physmem.c:2796
#11 0x000055d20137071b in kvm_handle_io (count=1, size=1, direction=<optimized out>, data=<optimized out>, attrs=..., port=1016) at ../../../../mnt/code/qemu/full/accel/kvm/kvm-all.c:2775
#12 kvm_cpu_exec (cpu=cpu@entry=0x55d202853d60) at ../../../../mnt/code/qemu/full/accel/kvm/kvm-all.c:3026
#13 0x000055d201371bdd in kvm_vcpu_thread_fn (arg=arg@entry=0x55d202853d60) at ../../../../mnt/code/qemu/full/accel/kvm/kvm-accel-ops.c:51
#14 0x000055d2014f95f8 in qemu_thread_start (args=0x55d20285de20) at ../../../../mnt/code/qemu/full/util/qemu-thread-posix.c:541
#15 0x00007f0217ffb907 in start_thread (arg=<optimized out>) at pthread_create.c:444
#16 0x00007f0218081870 in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81

Thread 3 (Thread 0x7f02161ba6c0 (LWP 921553) "IO mon_iothread"):
#0  0x00007f021807435d in __GI___poll (fds=0x7f0208000fe0, nfds=3, timeout=-1) at ../sysdeps/unix/sysv/linux/poll.c:29
#1  0x00007f021859f3a9 in g_main_context_poll (priority=<optimized out>, n_fds=3, fds=0x7f0208000fe0, timeout=<optimized out>, context=0x55d202850d50) at ../glib/gmain.c:4584
#2  g_main_context_iterate.isra.0 (context=0x55d202850d50, block=1, dispatch=1, self=<optimized out>) at ../glib/gmain.c:4271
#3  0x00007f021854099f in g_main_loop_run (loop=0x55d202850f40) at ../glib/gmain.c:4479
#4  0x000055d2013b6819 in iothread_run (opaque=opaque@entry=0x55d20282d870) at ../../../../mnt/code/qemu/full/iothread.c:70
#5  0x000055d2014f95f8 in qemu_thread_start (args=0x55d202850f80) at ../../../../mnt/code/qemu/full/util/qemu-thread-posix.c:541
#6  0x00007f0217ffb907 in start_thread (arg=<optimized out>) at pthread_create.c:444
#7  0x00007f0218081870 in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81

Thread 2 (Thread 0x7f0216fff6c0 (LWP 921550) "qemu-system-x86"):
#0  syscall () at ../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
#1  0x000055d2014fa77a in qemu_futex_wait (val=<optimized out>, f=<optimized out>) at /mnt/code/qemu/full/include/qemu/futex.h:29
#2  qemu_event_wait (ev=ev@entry=0x55d201e04b00 <rcu_gp_event>) at ../../../../mnt/code/qemu/full/util/qemu-thread-posix.c:464
#3  0x000055d20150391f in wait_for_readers () at ../../../../mnt/code/qemu/full/util/rcu.c:136
#4  synchronize_rcu () at ../../../../mnt/code/qemu/full/util/rcu.c:172
#5  0x000055d201503d8f in call_rcu_thread (opaque=opaque@entry=0x0) at ../../../../mnt/code/qemu/full/util/rcu.c:285
#6  0x000055d2014f95f8 in qemu_thread_start (args=0x55d202586220) at ../../../../mnt/code/qemu/full/util/qemu-thread-posix.c:541
#7  0x00007f0217ffb907 in start_thread (arg=<optimized out>) at pthread_create.c:444
#8  0x00007f0218081870 in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81

Thread 1 (Thread 0x7f0217a5ff80 (LWP 921548) "qemu-system-x86"):
#0  futex_wait (private=0, expected=2, futex_word=0x55d201dd3000 <qemu_global_mutex>) at ../sysdeps/nptl/futex-internal.h:146
#1  __GI___lll_lock_wait (futex=futex@entry=0x55d201dd3000 <qemu_global_mutex>, private=0) at lowlevellock.c:49
#2  0x00007f0217ffee21 in lll_mutex_lock_optimized (mutex=0x55d201dd3000 <qemu_global_mutex>) at pthread_mutex_lock.c:48
#3  ___pthread_mutex_lock (mutex=mutex@entry=0x55d201dd3000 <qemu_global_mutex>) at pthread_mutex_lock.c:93
#4  0x000055d2014f99d3 in qemu_mutex_lock_impl (mutex=0x55d201dd3000 <qemu_global_mutex>, file=0x55d201714e68 "../../../../mnt/code/qemu/full/util/main-loop.c", line=311) at ../../../../mnt/code/qemu/full/util/qemu-thread-posix.c:94
#5  0x000055d201148142 in qemu_mutex_lock_iothread_impl (file=file@entry=0x55d201714e68 "../../../../mnt/code/qemu/full/util/main-loop.c", line=line@entry=311) at ../../../../mnt/code/qemu/full/softmmu/cpus.c:504
#6  0x000055d20150cf56 in os_host_main_loop_wait (timeout=0) at ../../../../mnt/code/qemu/full/util/main-loop.c:311
#7  main_loop_wait (nonblocking=nonblocking@entry=0) at ../../../../mnt/code/qemu/full/util/main-loop.c:592
#8  0x000055d201152187 in qemu_main_loop () at ../../../../mnt/code/qemu/full/softmmu/runstate.c:738
#9  0x000055d201379ab6 in qemu_default_main () at ../../../../mnt/code/qemu/full/softmmu/main.c:37
#10 0x00007f0217f96b4a in __libc_start_call_main (main=main@entry=0x55d200f4b070 <main>, argc=argc@entry=25, argv=argv@entry=0x7fff8cdb7bc8) at ../sysdeps/nptl/libc_start_call_main.h:58
#11 0x00007f0217f96c0b in __libc_start_main_impl (main=0x55d200f4b070 <main>, argc=25, argv=0x7fff8cdb7bc8, init=<optimized out>, fini=<optimized out>, rtld_fini=<optimized out>, stack_end=0x7fff8cdb7bb8) at ../csu/libc-start.c:360
#12 0x000055d200f4cbd5 in _start ()

And this on the other side:

Thread 4 (Thread 0x7f31277fe6c0 (LWP 921563) "CPU 0/KVM"):
#0  0x00007f312e3941d9 in __futex_abstimed_wait_common64 (private=0, cancel=true, abstime=0x0, op=393, expected=0, futex_word=0x55eb7ed62e0c) at futex-internal.c:57
#1  __futex_abstimed_wait_common (futex_word=futex_word@entry=0x55eb7ed62e0c, expected=expected@entry=0, clockid=clockid@entry=0, abstime=abstime@entry=0x0, private=private@entry=0, cancel=cancel@entry=true) at futex-internal.c:87
#2  0x00007f312e39425f in __GI___futex_abstimed_wait_cancelable64 (futex_word=futex_word@entry=0x55eb7ed62e0c, expected=expected@entry=0, clockid=clockid@entry=0, abstime=abstime@entry=0x0, private=private@entry=0) at futex-internal.c:139
#3  0x00007f312e396b79 in __pthread_cond_wait_common (abstime=0x0, clockid=0, mutex=0x7f31277fd550, cond=0x55eb7ed62de0) at pthread_cond_wait.c:503
#4  ___pthread_cond_wait (cond=cond@entry=0x55eb7ed62de0, mutex=mutex@entry=0x55eb7d5f9000 <qemu_global_mutex>) at pthread_cond_wait.c:618
#5  0x000055eb7cd2010b in qemu_cond_wait_impl (cond=0x55eb7ed62de0, mutex=0x55eb7d5f9000 <qemu_global_mutex>, file=0x55eb7ce533c0 "../../../../mnt/code/qemu/full/softmmu/cpus.c", line=424) at ../../../../mnt/code/qemu/full/util/qemu-thread-posix.c:225
#6  0x000055eb7c96df71 in qemu_wait_io_event (cpu=cpu@entry=0x55eb7ed58d60) at ../../../../mnt/code/qemu/full/softmmu/cpus.c:424
#7  0x000055eb7cb97bc0 in kvm_vcpu_thread_fn (arg=arg@entry=0x55eb7ed58d60) at ../../../../mnt/code/qemu/full/accel/kvm/kvm-accel-ops.c:56
#8  0x000055eb7cd1f5f8 in qemu_thread_start (args=0x55eb7ed62e20) at ../../../../mnt/code/qemu/full/util/qemu-thread-posix.c:541
#9  0x00007f312e397907 in start_thread (arg=<optimized out>) at pthread_create.c:444
#10 0x00007f312e41d870 in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81

Thread 3 (Thread 0x7f3127fff6c0 (LWP 921562) "IO mon_iothread"):
#0  0x00007f312e41035d in __GI___poll (fds=0x7f3120000fe0, nfds=3, timeout=-1) at ../sysdeps/unix/sysv/linux/poll.c:29
#1  0x00007f312e99f3a9 in g_main_context_poll (priority=<optimized out>, n_fds=3, fds=0x7f3120000fe0, timeout=<optimized out>, context=0x55eb7ed55d50) at ../glib/gmain.c:4584
#2  g_main_context_iterate.isra.0 (context=0x55eb7ed55d50, block=1, dispatch=1, self=<optimized out>) at ../glib/gmain.c:4271
#3  0x00007f312e94099f in g_main_loop_run (loop=0x55eb7ed55f40) at ../glib/gmain.c:4479
#4  0x000055eb7cbdc819 in iothread_run (opaque=opaque@entry=0x55eb7ed32870) at ../../../../mnt/code/qemu/full/iothread.c:70
#5  0x000055eb7cd1f5f8 in qemu_thread_start (args=0x55eb7ed55f80) at ../../../../mnt/code/qemu/full/util/qemu-thread-posix.c:541
#6  0x00007f312e397907 in start_thread (arg=<optimized out>) at pthread_create.c:444
#7  0x00007f312e41d870 in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81

Thread 2 (Thread 0x7f312d3ff6c0 (LWP 921559) "qemu-system-x86"):
#0  futex_wait (private=0, expected=2, futex_word=0x55eb7d5f9000 <qemu_global_mutex>) at ../sysdeps/nptl/futex-internal.h:146
#1  __GI___lll_lock_wait (futex=futex@entry=0x55eb7d5f9000 <qemu_global_mutex>, private=0) at lowlevellock.c:49
#2  0x00007f312e39ae21 in lll_mutex_lock_optimized (mutex=0x55eb7d5f9000 <qemu_global_mutex>) at pthread_mutex_lock.c:48
#3  ___pthread_mutex_lock (mutex=mutex@entry=0x55eb7d5f9000 <qemu_global_mutex>) at pthread_mutex_lock.c:93
#4  0x000055eb7cd1f9d3 in qemu_mutex_lock_impl (mutex=0x55eb7d5f9000 <qemu_global_mutex>, file=0x55eb7cf38ce8 "../../../../mnt/code/qemu/full/util/rcu.c", line=286) at ../../../../mnt/code/qemu/full/util/qemu-thread-posix.c:94
#5  0x000055eb7c96e142 in qemu_mutex_lock_iothread_impl (file=file@entry=0x55eb7cf38ce8 "../../../../mnt/code/qemu/full/util/rcu.c", line=line@entry=286) at ../../../../mnt/code/qemu/full/softmmu/cpus.c:504
#6  0x000055eb7cd29cf8 in call_rcu_thread (opaque=opaque@entry=0x0) at ../../../../mnt/code/qemu/full/util/rcu.c:286
#7  0x000055eb7cd1f5f8 in qemu_thread_start (args=0x55eb7ea8b220) at ../../../../mnt/code/qemu/full/util/qemu-thread-posix.c:541
#8  0x00007f312e397907 in start_thread (arg=<optimized out>) at pthread_create.c:444
#9  0x00007f312e41d870 in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81

Thread 1 (Thread 0x7f312d853f80 (LWP 921557) "qemu-system-x86"):
#0  0x00007f312e41f78b in __recvmsg_syscall (flags=2, msg=0x7ffe27448a50, fd=20) at ../sysdeps/unix/sysv/linux/recvmsg.c:27
#1  __libc_recvmsg (fd=20, msg=msg@entry=0x7ffe27448a50, flags=flags@entry=2) at ../sysdeps/unix/sysv/linux/recvmsg.c:41
#2  0x000055eb7cbb3531 in qio_channel_socket_readv (ioc=<optimized out>, iov=<optimized out>, niov=<optimized out>, fds=0x0, nfds=0x0, flags=<optimized out>, errp=0x7ffe27448bb0) at ../../../../mnt/code/qemu/full/io/channel-socket.c:532
#3  0x000055eb7c9909b0 in migration_channel_read_peek (ioc=ioc@entry=0x55eb7fb859f0, buf=buf@entry=0x7ffe27448bac "", buflen=buflen@entry=4, errp=errp@entry=0x7ffe27448bb0) at ../../../../mnt/code/qemu/full/migration/channel.c:117
#4  0x000055eb7c997de1 in migration_ioc_process_incoming (ioc=ioc@entry=0x55eb7fb859f0, errp=errp@entry=0x7ffe27448bf8) at ../../../../mnt/code/qemu/full/migration/migration.c:689
#5  0x000055eb7c990715 in migration_channel_process_incoming (ioc=0x55eb7fb859f0) at ../../../../mnt/code/qemu/full/migration/channel.c:45
#6  0x000055eb7cbbaab7 in qio_net_listener_channel_func (ioc=<optimized out>, condition=<optimized out>, opaque=<optimized out>) at ../../../../mnt/code/qemu/full/io/net-listener.c:54
#7  0x00007f312e94139c in g_main_dispatch (context=0x55eb7eafdb20) at ../glib/gmain.c:3460
#8  g_main_context_dispatch (context=0x55eb7eafdb20) at ../glib/gmain.c:4200
#9  0x000055eb7cd32fe8 in glib_pollfds_poll () at ../../../../mnt/code/qemu/full/util/main-loop.c:290
#10 os_host_main_loop_wait (timeout=977785000) at ../../../../mnt/code/qemu/full/util/main-loop.c:313
#11 main_loop_wait (nonblocking=nonblocking@entry=0) at ../../../../mnt/code/qemu/full/util/main-loop.c:592
#12 0x000055eb7c978187 in qemu_main_loop () at ../../../../mnt/code/qemu/full/softmmu/runstate.c:738
#13 0x000055eb7cb9fab6 in qemu_default_main () at ../../../../mnt/code/qemu/full/softmmu/main.c:37
#14 0x00007f312e332b4a in __libc_start_call_main (main=main@entry=0x55eb7c771070 <main>, argc=argc@entry=27, argv=argv@entry=0x7ffe27448f18) at ../sysdeps/nptl/libc_start_call_main.h:58
#15 0x00007f312e332c0b in __libc_start_main_impl (main=0x55eb7c771070 <main>, argc=27, argv=0x7ffe27448f18, init=<optimized out>, fini=<optimized out>, rtld_fini=<optimized out>, stack_end=0x7ffe27448f08) at ../csu/libc-start.c:360
#16 0x000055eb7c772bd5 in _start ()

Can you take a look?

Later, Juan.


> This is intended to be a semantic revert of commit 9b09503752
> ("migration: run setup callbacks out of big lock"). There have been so
> many changes since that commit (e.g. a new setup callback
> dirty_bitmap_save_setup() that also needs to be adapted now), it's
> easier to do the revert manually.
>
> For snapshots, the bdrv_writev_vmstate() function is used during setup
> (in QIOChannelBlock backing the QEMUFile), but not holding the BQL
> while calling it could lead to an assertion failure. To understand
> how, first note the following:
>
> 1. Generated coroutine wrappers for block layer functions spawn the
> coroutine and use AIO_WAIT_WHILE()/aio_poll() to wait for it.
> 2. If the host OS switches threads at an inconvenient time, it can
> happen that a bottom half scheduled for the main thread's AioContext
> is executed as part of a vCPU thread's aio_poll().
>
> An example leading to the assertion failure is as follows:
>
> main thread:
> 1. A snapshot-save QMP command gets issued.
> 2. snapshot_save_job_bh() is scheduled.
>
> vCPU thread:
> 3. aio_poll() for the main thread's AioContext is called (e.g. when
> the guest writes to a pflash device, as part of blk_pwrite which is a
> generated coroutine wrapper).
> 4. snapshot_save_job_bh() is executed as part of aio_poll().
> 3. qemu_savevm_state() is called.
> 4. qemu_mutex_unlock_iothread() is called. Now
> qemu_get_current_aio_context() returns 0x0.
> 5. bdrv_writev_vmstate() is executed during the usual savevm setup
> via qemu_fflush(). But this function is a generated coroutine wrapper,
> so it uses AIO_WAIT_WHILE. There, the assertion
> assert(qemu_get_current_aio_context() == qemu_get_aio_context());
> will fail.
>
> To fix it, ensure that the BQL is held during setup. While it would
> only be needed for snapshots, adapting migration too avoids additional
> logic for conditional locking/unlocking in the setup callbacks.
> Writing the header could (in theory) also trigger qemu_fflush() and
> thus bdrv_writev_vmstate(), so the locked section also covers the
> qemu_savevm_state_header() call, even for migration for consistentcy.
>
> The comment in ram_init_bitmaps() was introduced by 4987783400
> ("migration: fix incorrect memory_global_dirty_log_start outside BQL")
> and is removed, because it referred to the qemu_mutex_lock_iothread()
> call.
>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>  include/migration/register.h   | 2 +-
>  migration/block-dirty-bitmap.c | 3 ---
>  migration/block.c              | 5 -----
>  migration/migration.c          | 6 ++++++
>  migration/ram.c                | 3 ---
>  migration/savevm.c             | 2 --
>  6 files changed, 7 insertions(+), 14 deletions(-)
>
> diff --git a/include/migration/register.h b/include/migration/register.h
> index a8dfd8fefd..ed8c42063b 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -20,6 +20,7 @@ typedef struct SaveVMHandlers {
>      /* This runs inside the iothread lock.  */
>      SaveStateHandler *save_state;
>  
> +    int (*save_setup)(QEMUFile *f, void *opaque);
>      void (*save_cleanup)(void *opaque);
>      int (*save_live_complete_postcopy)(QEMUFile *f, void *opaque);
>      int (*save_live_complete_precopy)(QEMUFile *f, void *opaque);
> @@ -45,7 +46,6 @@ typedef struct SaveVMHandlers {
>      int (*save_live_iterate)(QEMUFile *f, void *opaque);
>  
>      /* This runs outside the iothread lock!  */
> -    int (*save_setup)(QEMUFile *f, void *opaque);
>      /* Note for save_live_pending:
>       * must_precopy:
>       * - must be migrated in precopy or in stopped state
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index 032fc5f405..03cb2e72ee 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -1214,9 +1214,7 @@ static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque)
>      DBMSaveState *s = &((DBMState *)opaque)->save;
>      SaveBitmapState *dbms = NULL;
>  
> -    qemu_mutex_lock_iothread();
>      if (init_dirty_bitmap_migration(s) < 0) {
> -        qemu_mutex_unlock_iothread();
>          return -1;
>      }
>  
> @@ -1224,7 +1222,6 @@ static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque)
>          send_bitmap_start(f, s, dbms);
>      }
>      qemu_put_bitmap_flags(f, DIRTY_BITMAP_MIG_FLAG_EOS);
> -    qemu_mutex_unlock_iothread();
>      return 0;
>  }
>  
> diff --git a/migration/block.c b/migration/block.c
> index b9580a6c7e..4df7862f07 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -722,18 +722,13 @@ static int block_save_setup(QEMUFile *f, void *opaque)
>      trace_migration_block_save("setup", block_mig_state.submitted,
>                                 block_mig_state.transferred);
>  
> -    qemu_mutex_lock_iothread();
>      ret = init_blk_migration(f);
>      if (ret < 0) {
> -        qemu_mutex_unlock_iothread();
>          return ret;
>      }
>  
>      /* start track dirty blocks */
>      ret = set_dirty_tracking();
> -
> -    qemu_mutex_unlock_iothread();
> -
>      if (ret) {
>          return ret;
>      }
> diff --git a/migration/migration.c b/migration/migration.c
> index 5de7f734b9..c1b3c515e9 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2929,7 +2929,9 @@ static void *migration_thread(void *opaque)
>      object_ref(OBJECT(s));
>      update_iteration_initial_status(s);
>  
> +    qemu_mutex_lock_iothread();
>      qemu_savevm_state_header(s->to_dst_file);
> +    qemu_mutex_unlock_iothread();
>  
>      /*
>       * If we opened the return path, we need to make sure dst has it
> @@ -2957,7 +2959,9 @@ static void *migration_thread(void *opaque)
>          qemu_savevm_send_colo_enable(s->to_dst_file);
>      }
>  
> +    qemu_mutex_lock_iothread();
>      qemu_savevm_state_setup(s->to_dst_file);
> +    qemu_mutex_unlock_iothread();
>  
>      qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
>                                 MIGRATION_STATUS_ACTIVE);
> @@ -3068,8 +3072,10 @@ static void *bg_migration_thread(void *opaque)
>      ram_write_tracking_prepare();
>  #endif
>  
> +    qemu_mutex_lock_iothread();
>      qemu_savevm_state_header(s->to_dst_file);
>      qemu_savevm_state_setup(s->to_dst_file);
> +    qemu_mutex_unlock_iothread();
>  
>      qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
>                                 MIGRATION_STATUS_ACTIVE);
> diff --git a/migration/ram.c b/migration/ram.c
> index 9fb076fa58..1a2edef527 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2881,8 +2881,6 @@ static void migration_bitmap_clear_discarded_pages(RAMState *rs)
>  
>  static void ram_init_bitmaps(RAMState *rs)
>  {
> -    /* For memory_global_dirty_log_start below.  */
> -    qemu_mutex_lock_iothread();
>      qemu_mutex_lock_ramlist();
>  
>      WITH_RCU_READ_LOCK_GUARD() {
> @@ -2894,7 +2892,6 @@ static void ram_init_bitmaps(RAMState *rs)
>          }
>      }
>      qemu_mutex_unlock_ramlist();
> -    qemu_mutex_unlock_iothread();
>  
>      /*
>       * After an eventual first bitmap sync, fixup the initial bitmap
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 03795ce8dc..be97770620 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1624,10 +1624,8 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
>      memset(&compression_counters, 0, sizeof(compression_counters));
>      ms->to_dst_file = f;
>  
> -    qemu_mutex_unlock_iothread();
>      qemu_savevm_state_header(f);
>      qemu_savevm_state_setup(f);
> -    qemu_mutex_lock_iothread();
>  
>      while (qemu_file_get_error(f) == 0) {
>          if (qemu_savevm_state_iterate(f, false) > 0) {


