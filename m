Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 400F6787444
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 17:33:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZCKW-0001pA-Eb; Thu, 24 Aug 2023 11:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZCKT-0001oA-4P
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:33:01 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZCKP-0003dm-BP
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:32:59 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fe32016bc8so63508845e9.1
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 08:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692891176; x=1693495976;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7/YUrTOKu4dk0P5WhQmzy5HYC9YUqZJmJFanjBBLrzQ=;
 b=oAGvfWsIVmkrG6Iyv/WLmeGzaJyQvGxaF02qi3NpmegS9YIl+md53OAey8pnVfgqlk
 tYSo4UvQyyiMYGFyUcdmfjkuiH19PMh6oQfxIB36fext/UywHlImgc6FlVAGiCVizunI
 6+oQR7/M8Ujn9Dz4rQYEfP6mZ2qyAxHbZgYx7FknGVJJhW6c+P28gNoRRSOdR4Nb0j2w
 DEe0+a4zJrlrOlg/rW4Oyv3mkgh6rpRq3aE3lpUa9cKaGUZ3ZD5SVRjpHENjzWJ+cNNG
 WYK5u4ugEIela1mEdIqmuTfx6eL27KrPH98/f+MvU6rY8+zqAKm8FQNYSjQKpj/G2ePl
 XcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692891176; x=1693495976;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7/YUrTOKu4dk0P5WhQmzy5HYC9YUqZJmJFanjBBLrzQ=;
 b=Jav3HPja5JdQCQo+FVv/JJBHpi7ZQx6HdXRWkP9sARGNIbum6hhPqv1myXZoa673Nf
 C9Ai7b6tnWgN5T1uroUECYFGzVSMscPaQFHovpgiNoFQ+4IXXUNChdQxr++X7vx2IX/k
 qcAgjYv5sB8eXFmQvaPF5zxJ6EZony3Ng8WcMmoKHLnFXDHUA76QVnvndaWbLO0CwYlx
 9l/BubtFhwHQSqpzITXl8uo7Ou2p22I0hhl5EAcz8L2e2wBWAcWtVvN/XNB1jrKBz0qi
 DvlrKbY7W+WrjnLFqwhevxihCK/5H0AKcGYX32BfvBHuTSeNNVnZiGwCtPY8FxvKxVC2
 R8jg==
X-Gm-Message-State: AOJu0YxgdO3a1znnyneFg/zWfGwlH/uJD2ismIfFLGHpuga8T17onhkI
 f76tHb7OtrM8DYpKpOjIdAMK7A==
X-Google-Smtp-Source: AGHT+IH7g7hC0H4gXkBUTJ+l3D5HS08Bpt9ZU5uonK2AxfDo3RU6c+BWM64dG4fEkHGjHU78VkEk3g==
X-Received: by 2002:a5d:5242:0:b0:319:71be:9248 with SMTP id
 k2-20020a5d5242000000b0031971be9248mr13124873wrc.19.1692891175884; 
 Thu, 24 Aug 2023 08:32:55 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a7bc302000000b003fc06169ab3sm2962827wmj.20.2023.08.24.08.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 08:32:55 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B2FFC1FFBB;
 Thu, 24 Aug 2023 16:32:54 +0100 (BST)
References: <20230806033715.244648-1-richard.henderson@linaro.org>
 <772eb951-8a43-902b-3737-e52b44f7dcdb@redhat.com>
 <59a970fb-ad7b-d30b-1290-7b167bec0226@linaro.org>
User-agent: mu4e 1.11.14; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Richard Henderson
 <richard.henderson@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: Failing avocado tests in CI (was: Re: [PULL 00/24] tcg +
 linux-user queue for 8.1-rc3)
Date: Thu, 24 Aug 2023 16:31:25 +0100
In-reply-to: <59a970fb-ad7b-d30b-1290-7b167bec0226@linaro.org>
Message-ID: <87sf88fobd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


Richard Henderson <richard.henderson@linaro.org> writes:

> On 8/23/23 06:04, Thomas Huth wrote:
>> On 06/08/2023 05.36, Richard Henderson wrote:
>>> The following changes since commit 6db03ccc7f4ca33c99debaac290066f4500a=
2dfb:
>>>
>>> =C2=A0=C2=A0 Merge tag 'for-upstream' of https://gitlab.com/bonzini/qem=
u into
>>> staging (2023-08-04 14:47:00 -0700)
>>>
>>> are available in the Git repository at:
>>>
>>> =C2=A0=C2=A0 https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230805
>>>
>>> for you to fetch changes up to 843246699425adfb6b81f927c16c9c6249b51e1d:
>>>
>>> =C2=A0=C2=A0 linux-user/elfload: Set V in ELF_HWCAP for RISC-V (2023-08=
-05 18:17:20 +0000)
>>>
>>> ----------------------------------------------------------------
>>> accel/tcg: Do not issue misaligned i/o
>>> accel/tcg: Call save_iotlb_data from io_readx
>>> gdbstub: use 0 ("any process") on packets with no PID
>>> linux-user: Fixes for MAP_FIXED_NOREPLACE
>>> linux-user: Fixes for brk
>>> linux-user: Adjust task_unmapped_base for reserved_va
>>> linux-user: Use ELF_ET_DYN_BASE for ET_DYN with interpreter
>>> linux-user: Remove host !=3D guest page size workarounds in brk and ima=
ge load
>>> linux-user: Set V in ELF_HWCAP for RISC-V
>>> *-user: Remove last_brk as unused
>>  =C2=A0Hi Richard,
>> I noticed that we currently have two failing Avocado jobs in our CI,
>> avocado-system-centos and avocado-system-opensuse, where the
>> boot_linux.py:BootLinuxX8664.test_pc_i440fx_tcg and the
>> boot_linux.py:BootLinuxX8664.test_pc_q35_tcg are now apparently
>> crashing. If I've got the history right, it started with your pull
>> request here, in the preceeding one from Paolo, everything is still
>> green:
>>  =C2=A0https://gitlab.com/qemu-project/qemu/-/pipelines/956543770
>> But here the jobs started failing:
>>  =C2=A0https://gitlab.com/qemu-project/qemu/-/pipelines/957458385
>> Could you please have a look?
>
> It's some sort of timing issue, which sometimes goes away when re-run.
> I was re-running tests *a lot* in order to get them to go green while
> running the 8.1 release.

There is a definite regression point for the test_pc_q35 case:

  ./tests/venv/bin/avocado run ./tests/avocado/boot_linux.py:BootLinuxX8664=
.test_pc_q35_tcg
  JOB ID     : b8ea329d3353db7a47eb955fcad2f26b2dbe9f29
  JOB LOG    : /home/alex.bennee/avocado/job-results/job-2023-08-24T15.27-b=
8ea329/job.log
   (1/1) ./tests/avocado/boot_linux.py:BootLinuxX8664.test_pc_q35_tcg: PASS=
 (110.70 s)
  RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | =
CANCEL 0
  JOB TIME   : 111.22 s
  =F0=9F=95=9915:29:06 alex.bennee@hackbox2:qemu.git/builds/bisect  (190aba=
8) (BISECTING) [$!?] took 1m51s=20
  =E2=9E=9C  make -j30
  [1/8] Generating qemu-version.h with a custom command (wrapped by meson t=
o capture output)
  [2/8] Compiling C object qga/qemu-ga.p/main.c.o
  [3/8] Compiling C object libqmp.fa.p/monitor_qmp-cmds-control.c.o
  [4/8] Compiling C object libqemu-x86_64-softmmu.fa.p/accel_tcg_cputlb.c.o
  [5/8] Compiling C object libcommon.fa.p/softmmu_vl.c.o
  [6/8] Linking static target libqmp.fa
  [7/8] Linking target qga/qemu-ga
  [8/8] Linking target qemu-system-x86_64
  =F0=9F=95=9915:30:12 alex.bennee@hackbox2:qemu.git/builds/bisect  (f7eaf9=
d) (BISECTING) [$!?] took 5s=20
  =E2=9E=9C  ./tests/venv/bin/avocado run ./tests/avocado/boot_linux.py:Boo=
tLinuxX8664.test_pc_q35_tcg
  JOB ID     : 56768272dee373062792251ee3445cc81092634e
  JOB LOG    : /home/alex.bennee/avocado/job-results/job-2023-08-24T15.30-5=
676827/job.log
   (1/1) ./tests/avocado/boot_linux.py:BootLinuxX8664.test_pc_q35_tcg: INTE=
RRUPTED: Test interrupted by SIGTERM\nRunner error occurred: Timeout reache=
d\nOriginal status: ERROR\n{'name': '1-./tests/avocado/boot_linux.py:BootLi=
nuxX8664.test_pc_q35_tcg', 'logdir': '/home/alex.bennee/avocado/job-results=
/job-2023-08-24T15.30-5676827/test-results... (480.28 s)
  RESULTS    : PASS 0 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 1 | =
CANCEL 0
  JOB TIME   : 480.80 s

which bisects to:

  commit f7eaf9d702efdd02481d5f1c25f7d8e0ffb64c6e (HEAD, refs/bisect/bad)
  Author: Richard Henderson <richard.henderson@linaro.org>
  Date:   Tue Aug 1 10:46:03 2023 -0700

      accel/tcg: Do not issue misaligned i/o

      In the single-page case we were issuing misaligned i/o to
      the memory subsystem, which does not handle it properly.
      Split such accesses via do_{ld,st}_mmio_*.

      Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1800
      Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
      Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

>
> For instance, with very little added except for your s390x pull, the
> same BootLinuxX8664.test_pc_i440fx_tcg test passes:
>
> https://gitlab.com/qemu-project/qemu/-/jobs/4931341744#L136
>
> In the failing i44fx_tcg test, you can even see it's a timing issue:
>
> https://qemu-project.gitlab.io/-/qemu/-/jobs/4813804725/artifacts/build/t=
ests/results/latest/test-results/02-tests_avocado_boot_linux.py_BootLinuxX8=
664.test_pc_i440fx_tcg/debug.log
>
> 23:42:30 DEBUG| [   61.003328] Sending NMI from CPU 0 to CPUs 1:
> 23:42:30 DEBUG| [   61.007829] INFO: NMI handler
> (nmi_cpu_backtrace_handler) took too long to run: 2.622 msecs
> 23:42:30 DEBUG| [   61.003328] NMI backtrace for cpu 1 skipped: idling
> at native_safe_halt+0xe/0x10
> 23:42:30 DEBUG| [   61.003328] rcu: rcu_sched kthread starved for
> 60002 jiffies! g-963 f0x0 RCU_GP_WAIT_FQS(5) ->state=3D0x402 ->cpu=3D1
> 23:42:30 DEBUG| [   61.003328] rcu: RCU grace-period kthread stack dump:
> 23:42:30 DEBUG| [   61.003328] rcu_sched       I    0    10      2 0x8000=
4000
> 23:42:30 DEBUG| [   61.003328] Call Trace:
> 23:42:30 DEBUG| [   61.003328]  ? __schedule+0x29f/0x680
> ...
>
>
> r~


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

