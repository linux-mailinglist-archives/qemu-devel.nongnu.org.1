Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CF17849D2
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 21:00:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYWat-0000yZ-7u; Tue, 22 Aug 2023 14:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timothee.cocault@gmail.com>)
 id 1qYWar-0000yR-PC
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 14:59:09 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timothee.cocault@gmail.com>)
 id 1qYWap-00044Q-Il
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 14:59:09 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fea0640d7aso48351735e9.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 11:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692730745; x=1693335545;
 h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
 :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=yAYY21JyUYj9QrA9mfRX6QNt2bqLxMoucJ9ZY4UBaTE=;
 b=UnYJcBuHlDow3g8B6fwy3LfijNW3Kd7ACqqhCHPtbENSxk0N6O8FgnO7qQ/RC3rsjZ
 25NAWNO1tJEBee85/63Kcoczuzn+tXVpriRWlg1bL3tZjhWJWDAvD3YOISfrPTNsCIZR
 n40Pq5oigpTzawWC/z2pX1TJPo3AbWnZUEKWz3mx8HfAqw4zHa2npBXD6jAe/PbFJ4ja
 a9is/dYSe7DFbAf9Jx/0bMrkrcQpOGTwNkfyzHDfDFNqjS40F09mAAaqDRqJ6FengofF
 hHQX/4B5kUkv/9tFTB7qL2e4vgsyrDyO+x4m0FxuFOdjp6rM8NHyuZqns/0vA+z5nknW
 EQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692730745; x=1693335545;
 h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
 :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=yAYY21JyUYj9QrA9mfRX6QNt2bqLxMoucJ9ZY4UBaTE=;
 b=Sw4xRosREzZMylvd6wv4YfikOXBOoNRZ571aXtVZj1FO+t+nHH6SHWlbKtdlCDSPaS
 lasGvUyY/VteGP5U3DfCGMtG7oCfU4u6YFZcxkWmNQ8TdjIMR5iL+hlKXK5R5PSNNgZz
 8ulQiGnbCpfDM70HDzSVUdKilJel24A0d2QIpiDMbm0oK/E6oxXvYqFXEofab/0NOXfl
 iX207QS2d9L/g+dboQsUCDPQVj4wxyrSpbpbl9NJ77txFRdjHMlDMTuKe0cael0dD4Aq
 i9Bcn6LX38M3e3PiJqRurn8C/PjCURFO+FY35oE1FasrrYWZpLYAr+HbSwGB+a+WeS+f
 JFsQ==
X-Gm-Message-State: AOJu0YzBNeC+gV9NVCm1OIFaJwCHobHHGsndE6yBX51sqjtFwmEWmX1q
 PLFN9Nkma55zP7w0i13pr2mQ9Vkl0mS5wg==
X-Google-Smtp-Source: AGHT+IGi+R2aXSxyYcTEvD7heMg8/fRKrTcl3OubMg8jENtZQ7DYxjmzF4ucO7/CweJ1Y+TrMNCfFQ==
X-Received: by 2002:a05:600c:3799:b0:3f5:878:c0c2 with SMTP id
 o25-20020a05600c379900b003f50878c0c2mr7965474wmr.3.1692730744729; 
 Tue, 22 Aug 2023 11:59:04 -0700 (PDT)
Received: from 2a01cb0881159e00c5ce940f107a4ac7.ipv6.abo.wanadoo.fr
 (2a01cb0881159e00c5ce940f107a4ac7.ipv6.abo.wanadoo.fr.
 [2a01:cb08:8115:9e00:c5ce:940f:107a:4ac7])
 by smtp.gmail.com with ESMTPSA id
 l20-20020a7bc454000000b003feee8d8011sm9012598wmi.41.2023.08.22.11.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 11:59:04 -0700 (PDT)
Message-ID: <00e9e08eae1004ef67fe8dca3aaf5043e6863faa.camel@gmail.com>
Subject: Re: [PATCH 0/9] Replace remaining target_ulong in system-mode accel
From: timothee.cocault@gmail.com
To: richard.henderson@linaro.org, anjo@rev.ng
Cc: qemu-devel@nongnu.org
Date: Tue, 22 Aug 2023 21:02:24 +0200
In-Reply-To: e871da82-dcaf-b7da-d299-99e8911d1e9b@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=timothee.cocault@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi,

Maybe its too late for the 8.1 window, but I noticed that this patchset
fixes a segfault in qemu-system-ppc (and other 32 bits archs ?) introduced =
by
commit fb2c53c.
Therefore maybe it would be relevant to get merge it before 8.2.

I put the details below, please tell me if you prefer I file a bug.


If the guest accesses memory accross the 32-bits boundary (eg: fetching a d=
word
at 0xffffffff), do_ld4_mmu will make two calls to do_ld_beN (one for
0xffffffff, the other for 0x100000000).

In the second call, mmu_lookup1 will call tlb_hit(tlb_addr, addr) to see ch=
eck
if the address is already in the TLB. If the first page is loaded, this
will result in a call to tlb_hit(0, 0x100000000) which returns 0,
telling it wrongly that the address belongs in page 0.
data->haddr will then be set to an out-of-bounds address.

The Patch 7/9 "include/exec: Widen tlb_hit/tlb_hit_page()" fixes that.


Example crash:

# asm dump
# 0x04: 3820ffff   li r1, -1
# 0x08: 81210000   lwz r9, 0(r1)
$ ./build/qemu-system-ppc -device loader,addr=3D4,data=3D0x3820ffff81210000=
,data-len=3D8,data-be=3Dtrue -device loader,addr=3D0x4,cpu-num=3D0

Thread 3 "qemu-system-ppc" received signal SIGSEGV, Segmentation fault.
#0  0x0000555555cbf8c7 in do_ld_bytes_beN (p=3D0x7ffff6c4a2a0, ret_be=3D0x2=
5) at ../accel/tcg/cputlb.c:2141
#1  0x0000555555cbfe41 in do_ld_beN (env=3D0x55555684faa0, p=3D0x7ffff6c4a2=
a0, ret_be=3D0x25, mmu_idx=3D0x3, type=3DMMU_DATA_LOAD, mop=3DMO_BEUL, ra=
=3D0x7fff7000014d) at ../accel/tcg/cputlb.c:2302
#2  0x0000555555cc088b in do_ld4_mmu (env=3D0x55555684faa0, addr=3D0xffffff=
ff, oi=3D0x123, ra=3D0x7fff7000014d, access_type=3DMMU_DATA_LOAD) at ../acc=
el/tcg/cputlb.c:2505
#3  0x0000555555cc092b in helper_ldul_mmu (env=3D0x55555684faa0, addr=3D0xf=
fffffff, oi=3D0x123, retaddr=3D0x7fff7000014d) at ../accel/tcg/cputlb.c:251=
6
#4  0x00007fff70000190 in code_gen_buffer ()
#5  0x0000555555cab186 in cpu_tb_exec (cpu=3D0x55555684d2d0, itb=3D0x7fffb0=
000040, tb_exit=3D0x7ffff6c4a8b0) at ../accel/tcg/cpu-exec.c:457
#6  0x0000555555cabeaf in cpu_loop_exec_tb (cpu=3D0x55555684d2d0, tb=3D0x7f=
ffb0000040, pc=3D0x4, last_tb=3D0x7ffff6c4a8c0, tb_exit=3D0x7ffff6c4a8b0) a=
t ../accel/tcg/cpu-exec.c:919
#7  0x0000555555cac219 in cpu_exec_loop (cpu=3D0x55555684d2d0, sc=3D0x7ffff=
6c4a940) at ../accel/tcg/cpu-exec.c:1040
#8  0x0000555555cac2d7 in cpu_exec_setjmp (cpu=3D0x55555684d2d0, sc=3D0x7ff=
ff6c4a940) at ../accel/tcg/cpu-exec.c:1057
#9  0x0000555555cac35e in cpu_exec (cpu=3D0x55555684d2d0) at ../accel/tcg/c=
pu-exec.c:1083
#10 0x0000555555ccb9a0 in tcg_cpus_exec (cpu=3D0x55555684d2d0) at ../accel/=
tcg/tcg-accel-ops.c:75
#11 0x0000555555cccef5 in rr_cpu_thread_fn (arg=3D0x55555684d2d0) at ../acc=
el/tcg/tcg-accel-ops-rr.c:261
#12 0x0000555555e8d661 in qemu_thread_start (args=3D0x5555568b6310) at ../u=
til/qemu-thread-posix.c:541
#13 0x00007ffff7a8c9eb in start_thread (arg=3D<optimized out>) at pthread_c=
reate.c:444
#14 0x00007ffff7b10dfc in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/cl=
one3.S:78

Regards,
Timoth=C3=A9e.

