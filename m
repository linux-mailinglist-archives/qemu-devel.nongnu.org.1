Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D97475B054
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 15:46:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMTyh-0006QJ-EZ; Thu, 20 Jul 2023 09:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMTyf-0006Oj-7e
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:45:57 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMTyd-0001KX-HO
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:45:57 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4fb77f21c63so1257364e87.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 06:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689860753; x=1690465553;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8OP3T8Sfy8ldl+StOm3bD/k6Sme2E/M3Uve6FFMgIMo=;
 b=nFhxtERzL4BCPLTNqdb4xn5Pdpt6IgDktU0QT4TNBYTGyIuqymChsPY118LrcoYPEc
 L29kpTBM89BejGMjUmOlHCD2U5MtBLfS8vpCInfzfFu6x/y39AOccQvee4Ya+13W2zpt
 C0uKY59iigy//uPIUGIHM9XmZNnn1coCI25Rz95PqEPz9DCYOtDmdF8n7tV3xvWticgB
 h/ROf0GPrBhQCqqMlvWMWeTZyzsCQ4uxGGtyF/cMMEZgMvcmQ1ddG4toM42/LHwWxU8P
 GEL7w9le5+KM0gabcMzdAMiTY5C73japmpKZKYF6QWlOsYJV84BNIPaCw+4OdtcdOdP4
 jqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689860753; x=1690465553;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8OP3T8Sfy8ldl+StOm3bD/k6Sme2E/M3Uve6FFMgIMo=;
 b=b7czTkMasCqg//L4nLDMMVo2rwFIDXgeSQyElzrkzCe6hk/RVwIp/O3RI4EKCBQL0Z
 bICICfruI9BmmN4WN5bnXJpxD2EFsUTYS7a4+jcBoT0TiOXu8TjCwQtL5lqEHcUlpkVO
 1rO3QVjK4TWAUmHbNKlpzLD5P8KJn8xN0QOmEwkZI9LQuDmGCI+ozmwwNHM992aqSWHE
 tIkBk1nz67cEqWw144gguQPxd45i33CvygQz2dG0rg9TztDS2XWJMQeYkAMa/sBTImrD
 9v3IGQ+LPsAYyI/Q/AamGOdKyuZGgklFWCZtpI3mkdqss7ZU/C5QoqF4z2xQ2ufNX7yZ
 /ksg==
X-Gm-Message-State: ABy/qLaT20sULwTICkvHGMjVZGm9NLbBfS9/yU+Li+jeUxn2hwiBW5J3
 R+ghLlyG9dVWq1rxabe09632as0+CVoiKEczlKQErA==
X-Google-Smtp-Source: APBJJlHOkjx6E7h+d697HBlUa0zDRBT6FTHAzhg/B4NPYhMo/RgnKuS4tXGeA1+bplaMwLE1UkPbqjXYNei7gBbJtlY=
X-Received: by 2002:ac2:5b05:0:b0:4f8:5cde:a44f with SMTP id
 v5-20020ac25b05000000b004f85cdea44fmr2144646lfn.10.1689860752614; Thu, 20 Jul
 2023 06:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230720130448.921356-1-jsnow@redhat.com>
In-Reply-To: <20230720130448.921356-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jul 2023 14:45:41 +0100
Message-ID: <CAFEAcA-ZjYUKFM7FiDb_NcQ7L=gG8TSjipThgD9JC26DBP4zVQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] python/machine: use socketpair() for console socket
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Beraldo Leal <bleal@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Daniel Berrange <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_PORT=0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 20 Jul 2023 at 14:04, John Snow <jsnow@redhat.com> wrote:
>
> Like we did for the QMP socket, use socketpair() for the console socket
> so that hopefully there isn't a race condition during early boot where
> data might get dropped on the floor.
>
> "lightly tested"; passes local tests and gitlab CI. Doesn't seem to make
> anything worse.

I tried this on the s390 linux box and the test failed because
of a python exception:

__init__() got an unexpected keyword argument 'sock_dir'

  $ QEMU_TEST_FLAKY_TESTS=1 ./build/aarch64/tests/venv/bin/avocado run
./build/aarch64/tests/avocado/machine_aarch64_sbsaref.py:Aarch64SbsarefMachine.test_sbsaref_edk2_firmware
JOB ID     : 8392ba37b5a825ed75278f85f686364d181c01d3
JOB LOG    : /home/linux1/avocado/job-results/job-2023-07-20T13.41-8392ba3/job.log
 (1/1) ./build/aarch64/tests/avocado/machine_aarch64_sbsaref.py:Aarch64SbsarefMachine.test_sbsaref_edk2_firmware:
ERROR: __init__() got an unexpected keyword argument 'sock_dir' (3.64
s)
RESULTS    : PASS 0 | ERROR 1 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0
| CANCEL 0
JOB TIME   : 6.92 s

Backtrace etc from in the job.log:

2023-07-20 13:41:49,125 stacktrace       L0041 ERROR| Reproduced
traceback from:
/home/linux1/qemu/build/aarch64/tests/venv/lib/python3.8/site-package
s/avocado/core/test.py:770
2023-07-20 13:41:49,147 stacktrace       L0045 ERROR| Traceback (most
recent call last):
2023-07-20 13:41:49,147 stacktrace       L0045 ERROR|   File
"/home/linux1/qemu/build/aarch64/tests/venv/lib/python3.8/site-packages/avocado/core/decorators.py",
line 90, in wrapper
2023-07-20 13:41:49,147 stacktrace       L0045 ERROR|     return
function(obj, *args, **kwargs)
2023-07-20 13:41:49,147 stacktrace       L0045 ERROR|   File
"/home/linux1/qemu/build/aarch64/tests/avocado/machine_aarch64_sbsaref.py",
line 84, in test_sbsaref_edk2_firmware
2023-07-20 13:41:49,147 stacktrace       L0045 ERROR|     self.fetch_firmware()
2023-07-20 13:41:49,147 stacktrace       L0045 ERROR|   File
"/home/linux1/qemu/build/aarch64/tests/avocado/machine_aarch64_sbsaref.py",
line 66, in fetch_firmware
2023-07-20 13:41:49,147 stacktrace       L0045 ERROR|     self.vm.set_console()
2023-07-20 13:41:49,147 stacktrace       L0045 ERROR|   File
"/home/linux1/qemu/build/aarch64/tests/avocado/avocado_qemu/__init__.py",
line 348, in vm
2023-07-20 13:41:49,147 stacktrace       L0045 ERROR|     return
self.get_vm(name='default')
2023-07-20 13:41:49,147 stacktrace       L0045 ERROR|   File
"/home/linux1/qemu/build/aarch64/tests/avocado/avocado_qemu/__init__.py",
line 354, in get_vm
2023-07-20 13:41:49,147 stacktrace       L0045 ERROR|
self._vms[name] = self._new_vm(name, *args)
2023-07-20 13:41:49,147 stacktrace       L0045 ERROR|   File
"/home/linux1/qemu/build/aarch64/tests/avocado/avocado_qemu/__init__.py",
line 324, in _new_vm
2023-07-20 13:41:49,147 stacktrace       L0045 ERROR|     vm =
QEMUMachine(self.qemu_bin, base_temp_dir=self.workdir,
2023-07-20 13:41:49,147 stacktrace       L0045 ERROR| TypeError:
__init__() got an unexpected keyword argument 'sock_dir'
2023-07-20 13:41:49,147 stacktrace       L0046 ERROR|
2023-07-20 13:41:49,147 test             L0775 DEBUG| Local variables:
2023-07-20 13:41:49,160 test             L0778 DEBUG|  -> obj <class
'machine_aarch64_sbsaref.Aarch64SbsarefMachine'>:
1-./build/aarch64/tests/avocado/machine_aarch64_sbsaref.py:Aarch64SbsarefMachine.test_sbsaref_edk2_firmware
2023-07-20 13:41:49,160 test             L0778 DEBUG|  -> args <class
'tuple'>: ()
2023-07-20 13:41:49,160 test             L0778 DEBUG|  -> kwargs
<class 'dict'>: {}
2023-07-20 13:41:49,160 test             L0778 DEBUG|  -> condition
<class 'str'>: 1
2023-07-20 13:41:49,160 test             L0778 DEBUG|  -> function
<class 'function'>: <function
Aarch64SbsarefMachine.test_sbsaref_edk2_firmware at 0x3ff814d9700>
2023-07-20 13:41:49,160 test             L0778 DEBUG|  -> message
<class 'str'>: Test is not reliable
2023-07-20 13:41:49,160 test             L0778 DEBUG|  -> negate
<class 'bool'>: True

thanks
-- PMM

