Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D58E973722F
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 18:58:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBef2-0001DZ-RQ; Tue, 20 Jun 2023 12:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBeeu-0001D1-Cj
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:56:48 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBeer-00071R-PL
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:56:47 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-51a1d539ffaso9369776a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 09:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687280204; x=1689872204;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=mtoiq8V8RVz0iq+mEEj4y9c41TbCJb4zjY86cCBuwt4=;
 b=R1+zNCVqZHT+I8gxcD3JOvh6g7DgkO2gcRz45dqw3E25pwmMSdbpXfCudZGEd6jRlN
 P3UBn55htOWwx7i4WpD/KQmY1YSs2lb3nHEFgvZB7oYegkArnJZ0/72Ij4slgwu8bwpe
 Q4+V9qGc41h9OuGMM9SUgTWenJWmdyWG+WJ/wYH3QQBmGexQ7k0amgMiui9490RbvOY6
 o+ZKVegEyadErs5qm93DuN8+05gUrONSVFv7nj3HBhByCVjfHpeHmE57G1H+VR8esj59
 RB/nti6ZkAN+95HM3p9q1DMW1c2T2mRF/rMBcNSdC0OJNkOflu5f5NeYc4A1tzShIIZW
 P73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687280204; x=1689872204;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mtoiq8V8RVz0iq+mEEj4y9c41TbCJb4zjY86cCBuwt4=;
 b=b9zSsQZq4fJ7AncVotzpkHtjyR7AWSwkhHHZS1qQPdJsjqc4TCBTanRDpEYx6JqYqm
 4IxP69rr6AuCSqdDOUwi6b6Gza36vXLZJ/FULAEbxQhWEvWtZ3FPxUkFlKX/Yvy2d97F
 USdRTNAr/4lkoDtxuvZ103OhWkbfn417gGPU1RREzhjeZFntksXB0RJI1RW2JyAgUR6R
 Eng0YtFhZipS5Wga8fR5JH7KBVu64OZaRuaV/dh18kw8Ayl3A7RdxWibbfSQ/1t2CycH
 dDPogVz3v6mHmMpRArj89wFmwl+C1OOpzUuvhXaWMdER0B8beKG+pFIbBA9+7+L8wcZD
 cIFA==
X-Gm-Message-State: AC+VfDxxT+1UqZwnndBtylELk8Y3VJEcS4MlHXUsFgb7XzpdjOw944VR
 kC/kdWbbuHKftlgXt36RaOjG/YC8LlYuwN/R0Q9gXwn37ATzcPQR
X-Google-Smtp-Source: ACHHUZ7tGq/BsfuI6WbZO/I2srke4AfSJqE2Nq18PFE8YstFhAQU+HAKD0VvHDFXh+UvjLYF6CKD0xunGQap/+0j4lU=
X-Received: by 2002:a05:6402:27cb:b0:514:94be:323c with SMTP id
 c11-20020a05640227cb00b0051494be323cmr15102350ede.10.1687280203729; Tue, 20
 Jun 2023 09:56:43 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2023 17:56:33 +0100
Message-ID: <CAFEAcA_UkPyic7U8eJkzBdBNoQowMToJkK-ro9re51zwn9-CMw@mail.gmail.com>
Subject: 'make check-tcg' fails with an assert in qemu_plugin_vcpu_init_hook
To: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

$ make -C build/x86 check-tcg
make: Entering directory '/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86'
[...]
  TEST    munmap-pthread on arm
**
ERROR:../../plugins/core.c:221:qemu_plugin_vcpu_init_hook: assertion
failed: (success)
**
ERROR:../../accel/tcg/cpu-exec.c:1024:cpu_exec_setjmp: assertion
failed: (cpu == current_cpu)

Here's the backtrace:

#0  __pthread_kill_implementation (no_tid=0, signo=6,
threadid=140737332028096) at ./nptl/pthread_kill.c:44
#1  __pthread_kill_internal (signo=6, threadid=140737332028096) at
./nptl/pthread_kill.c:78
#2  __GI___pthread_kill (threadid=140737332028096,
signo=signo@entry=6) at ./nptl/pthread_kill.c:89
#3  0x00007ffff6fc1476 in __GI_raise (sig=sig@entry=6) at
../sysdeps/posix/raise.c:26
#4  0x00007ffff6fa77f3 in __GI_abort () at ./stdlib/abort.c:79
#5  0x00007ffff7497b57 in g_assertion_message (domain=<optimised out>,
file=<optimised out>, line=<optimised out>,
    func=0x555555800d50 <__func__.3> "qemu_plugin_vcpu_init_hook",
message=<optimised out>) at ../../../glib/gtestutils.c:3253
#6  0x00007ffff74f170f in g_assertion_message_expr (domain=0x0,
file=0x555555800ccf "../../plugins/core.c", line=221,
    func=0x555555800d50 <__func__.3> "qemu_plugin_vcpu_init_hook",
expr=<optimised out>) at ../../../glib/gtestutils.c:3279
#7  0x00005555556e5747 in qemu_plugin_vcpu_init_hook
(cpu=0x5555559d0450) at ../../plugins/core.c:221
#8  0x00005555556a9cc3 in cpu_exec_realizefn (cpu=0x5555559d0450,
errp=0x7fffffffc630) at ../../cpu.c:153
#9  0x00005555555a44ef in arm_cpu_realizefn (dev=0x5555559d0450,
errp=0x7fffffffc780) at ../../target/arm/cpu.c:1673
#10 0x000055555572ef2e in device_set_realized (obj=0x5555559d0450,
value=true, errp=0x7fffffffc9b8) at ../../hw/core/qdev.c:510
#11 0x000055555573931b in property_set_bool (obj=0x5555559d0450,
v=0x5555559c0d40, name=0x55555580ef41 "realized",
opaque=0x555555924870,
    errp=0x7fffffffc9b8) at ../../qom/object.c:2285
#12 0x0000555555737212 in object_property_set (obj=0x5555559d0450,
name=0x55555580ef41 "realized", v=0x5555559c0d40, errp=0x7fffffffc9b8)
    at ../../qom/object.c:1420
#13 0x000055555573b861 in object_property_set_qobject
(obj=0x5555559d0450, name=0x55555580ef41 "realized",
value=0x55555592bc90, errp=0x7fffffffc9b8)
    at ../../qom/qom-qobject.c:28
#14 0x0000555555737591 in object_property_set_bool
(obj=0x5555559d0450, name=0x55555580ef41 "realized", value=true,
errp=0x7fffffffc9b8)
    at ../../qom/object.c:1489
#15 0x000055555572e6bc in qdev_realize (dev=0x5555559d0450, bus=0x0,
errp=0x7fffffffc9b8) at ../../hw/core/qdev.c:292
#16 0x000055555559a65c in cpu_create (typename=0x55555591c5c0
"max-arm-cpu") at ../../hw/core/cpu-common.c:61
#17 0x00005555556f1712 in cpu_copy (env=0x555555953d80) at
../../linux-user/main.c:231
#18 0x0000555555711c4e in do_fork (env=0x555555953d80, flags=4001536,
newsp=1073734008, parent_tidptr=1073735528, newtls=1073736832,
    child_tidptr=1073735528) at ../../linux-user/syscall.c:6672
#19 0x000055555571cdea in do_syscall1 (cpu_env=0x555555953d80,
num=120, arg1=4001536, arg2=1073734008, arg3=1073735528,
arg4=1073736832,
    arg5=1073735528, arg6=1082129932, arg7=0, arg8=0) at
../../linux-user/syscall.c:10869
#20 0x00005555557243f2 in do_syscall (cpu_env=0x555555953d80, num=120,
arg1=4001536, arg2=1073734008, arg3=1073735528, arg4=1073736832,
    arg5=1073735528, arg6=1082129932, arg7=0, arg8=0) at
../../linux-user/syscall.c:13610
#21 0x00005555555a1616 in cpu_loop (env=0x555555953d80) at
../../linux-user/arm/cpu_loop.c:434
#22 0x00005555556f2ee0 in main (argc=2, argv=0x7fffffffde68,
envp=0x7fffffffde80) at ../../linux-user/main.c:973

AFAICT this is happening because we try to insert an entry
into the plugin.cpu_ht hash table whose key is cpu->cpu_index.
But in this "new thread" codepath, the new thread's
cpu_index is 0, which is the same as the old thread's
cpu_index...

The assertion in cpu-exec.c is interesting too and may or
may not be relevant.

thanks
-- PMM

