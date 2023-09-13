Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E50B79E416
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 11:47:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgMR4-00014M-Qj; Wed, 13 Sep 2023 05:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgMR2-000146-7x
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:45:24 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgMQz-00089R-HZ
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:45:24 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-52f33659d09so4953148a12.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 02:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694598319; x=1695203119; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NlEuFrbLbnFvdp7u5cagwWG5ekfzjk87zL3lXOG+/zk=;
 b=WFl9dXW5rAZiyYvot598inJ5VX3ome38308NYdxwmpbhQgGUn02daYc+mg9fzwAvTG
 8f4Jg5aJZntn2VVAn9eTn2qXZYwbf13MYnlKbB57g41Vjk3gbPbYUGK2yaNAWNC53OD8
 wOnVSLOFrsKkpx/Vu0yQV+qdbRAYFXyBcpUAO0GkxJq4Xul9mfeS1U33SaFiRAqaBvJt
 CrSBZMoJxK7UXFenwDth8UatYuW/3VxW2TZDgkbwPaz/6UpDrZ7nN3cPL90R1AG1b1Er
 BILNmpJlxAWvkSC3ZLqj83UH5X7gnKN1mD5vFKr8MsgX7Tz0msDwVdMn/4WGf/gOP7JX
 O9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694598319; x=1695203119;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NlEuFrbLbnFvdp7u5cagwWG5ekfzjk87zL3lXOG+/zk=;
 b=XE/ZgkargoCAAlmaWKgs3aK3P5N6DBRoZ7LMBY2OyYIXUhrgQGM4V430vn6fBYA/ZM
 Zn0DveqExPP334osR8SCQyiifqFB1ghjowUdjy9TiSH5OytEgeJeyxbo52NFmHfL578V
 s72EnRmcPswwGEcFoNWQjyKVgGuXuHpmKEHmJYrN9c/tac8jKpi0he43fU7bvBuVTNt6
 k28MiysleeNn3Un3fl0EVM7S5ZvRFrTSjLFtQEMEJ9GJV3kWQllRK/5mChJNKKCnQc9Q
 o5kUOxZ6PvVPlNCiImm4e68Dtgw1G9vGf/CPXNVNCUCS4uPH0XMXYNMVkSGFFyEPWjSt
 cFSg==
X-Gm-Message-State: AOJu0YyXjyWX2VFc14HHMyXIYmElgygzWQlIolJ+MbO5OQM2TnmDYB/V
 mQyOzu8zyLHFzpFVq5c0kK5Idw==
X-Google-Smtp-Source: AGHT+IGJXNk0WLG385Oweuudz718AK1F+X/0W9vFdotUi2W47VYU9PSarLMMOqPadDZcv7eYMGOdjQ==
X-Received: by 2002:a05:6402:8d6:b0:525:7d81:71ee with SMTP id
 d22-20020a05640208d600b005257d8171eemr1731190edz.15.1694598319279; 
 Wed, 13 Sep 2023 02:45:19 -0700 (PDT)
Received: from [192.168.69.115] (176-131-211-241.abo.bbox.fr.
 [176.131.211.241]) by smtp.gmail.com with ESMTPSA id
 g12-20020a056402114c00b0052ea9ad21bdsm7034651edw.72.2023.09.13.02.45.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 02:45:18 -0700 (PDT)
Message-ID: <4e335f86-d075-4cc0-af5a-9dca9b3bf261@linaro.org>
Date: Wed, 13 Sep 2023 11:45:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] gitlab: remove unreliable avocado CI jobs
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
References: <20230912150611.70676-1-stefanha@redhat.com>
 <27e38912-0bad-7398-dda6-1670fc644f74@redhat.com>
 <CAFEAcA_roU-_E4P94km1RF=u6c+GRBxrGP0jS1_dXsRABCymJg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_roU-_E4P94km1RF=u6c+GRBxrGP0jS1_dXsRABCymJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

On 13/9/23 11:18, Peter Maydell wrote:
> On Tue, 12 Sept 2023 at 21:00, Thomas Huth <thuth@redhat.com> wrote:
>> Please don't remove the whole job! Just disable the failing tests within the job, e.g.:
>>
>> diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
>> --- a/tests/avocado/replay_kernel.py
>> +++ b/tests/avocado/replay_kernel.py
>> @@ -503,6 +503,7 @@ def do_test_mips_malta32el_nanomips(self, kernel_path_xz):
>>            console_pattern = 'Kernel command line: %s' % kernel_command_line
>>            self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
>>
>> +    @skipIf(os.getenv('GITLAB_CI'), 'Skipping unstable test on GitLab')
>>        def test_mips_malta32el_nanomips_4k(self):
>>            """
>>            :avocado: tags=arch:mipsel
> 
> Please don't skip unstable tests on gitlab only. If they're
> unstable, then nobody wants to be running them and wondering
> if these are flaky tests or real issues, whether theyr'e doing
> it on gitlab or locally. (I know we already have a lot of these,
> but the effect is that instead of saying 'make check-avocado'
> you have to say 'GITLAB_CI=1 make check-avocado'.)

Good point, I'll simply use:

         @skip('Pending https://gitlab.com/qemu-project/qemu/-/issues/1884')

Looking at other ones:

$ git grep -w @skip tests/avocado/
tests/avocado/machine_sparc_leon3.py:17:    @skip("Test currently broken")
tests/avocado/netdev-ethtool.py:89:    @skip("Incomplete reg 0x00178 
support")
tests/avocado/netdev-ethtool.py:96:    @skip("Incomplete reg 0x00178 
support")
tests/avocado/replay_kernel.py:333:    @skip("Test currently broken") # 
Console stuck as of 5.2-rc1
tests/avocado/replay_kernel.py:368:    @skip("nios2 emulation is buggy 
under record/replay")
tests/avocado/virtio_check_params.py:119:    @skip("break multi-arch CI")

Looking at the first one:

commit 5baecf58ad9fb3ce24d331978526909d0beca482
Author: Philippe Mathieu-Daudé <f4bug@amsat.org>
Date:   Tue Mar 31 12:50:42 2020 +0200

     tests/acceptance/machine_sparc_leon3: Disable HelenOS test

     This test was written/tested around beginning of 2019, but was
     extracted from a bigger series and posted end of June 2019 [*].
     Unfortunately I did not notice commit 162abf1a8 was merged by
     then, which implements the AHB and APB plug and play devices.

     HelenOS 0.6 is expecting the PnP registers to be not implemented
     by QEMU, then forces the discovered AMBA devices (see [2]).

     Before 162abf1a8, the console was displaying:

       HelenOS bootloader, release 0.6.0 (Elastic Horse)
       Built on 2014-12-21 20:17:42 for sparc32
       Copyright (c) 2001-2014 HelenOS project
        0x4000bf20|0x4000bf20: kernel image (496640/128466 bytes)
        0x4002b4f2|0x4002b4f2: ns image (154195/66444 bytes)
        0x4003b87e|0x4003b87e: loader image (153182/66437 bytes)
        0x4004bc03|0x4004bc03: init image (155339/66834 bytes)
        0x4005c115|0x4005c115: locsrv image (162063/70267 bytes)
        0x4006d390|0x4006d390: rd image (152678/65889 bytes)
        0x4007d4f1|0x4007d4f1: vfs image (168480/73394 bytes)
        0x4008f3a3|0x4008f3a3: logger image (158034/68368 bytes)
        0x4009feb3|0x4009feb3: ext4fs image (234510/100301 bytes)
        0x400b8680|0x400b8680: initrd image (8388608/1668901 bytes)
       ABMA devices:
       <1:00c> at 0x80000100 irq 3
       <1:00d> at 0x80000200
       <1:011> at 0x80000300 irq 8
       Memory size: 64 MB

     As of this commit, it is now confused:

       ABMA devices:
       <1:3000> at 0x00000000 irq 0
       <1:3000> at 0x00000000 irq 0
       <1:3000> at 0x00000000 irq 0
       <1:3000> at 0x00000000 irq 0
       <1:3000> at 0x00000000 irq 0
       <1:3000> at 0x00000000 irq 0
       <1:3000> at 0x00000000 irq 0
       ...

     As this test is not working as expected, simply disable it (by
     skipping it) for now.

More than 3 years passed already, what a disappointment.
Offending commit is 4 years old.

commit 162abf1a83ddd06ce1618666f84f88ba4dbffe10
Author: KONRAD Frederic <frederic.konrad@adacore.com>
Date:   Wed May 15 14:31:32 2019 +0200

     leon3: introduce the plug and play mechanism

     This adds the AHB and APB plug and play devices.
     They are scanned during the linux boot to discover the various
     peripheral.

I'm not complaining about that particular commit, I wonder about
usefulness of disabling tests from unmaintained areas.

Maybe we can commit a date when disabling a test, having a disabled
test failing _after_ that date, so if it isn't fixed we remove it.
Smth like,

   @SkipBroken(date='2023-11-15',
               desc='Pending 
https://gitlab.com/qemu-project/qemu/-/issues/1884') # Will fail if run 
after 2023-11-15 and this test isn't fixed

Thoughts?

