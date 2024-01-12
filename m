Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 453C982C0A6
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:15:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHKF-0005KS-FZ; Fri, 12 Jan 2024 08:11:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOHK8-0005Hq-9t
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:11:48 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOHK6-0006JM-3E
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:11:48 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3368abe1093so4927236f8f.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 05:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705065103; x=1705669903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qvomdc0NwBwCxQ/2gZuOKk1li0juoJJtoSCvd8aovNQ=;
 b=hpSW8dhoDsM0HM2lZnmmPZQYOXNhK7XLOHhPVqEACK71Q9vpO6vrOaz97EgOTrlclU
 pgz8H+FeTHl3+SMd2YBYNbBG4cliWRwAEWM8bNSvwSiQ4FufLgHHGqpnzcfvAJ8DiCpZ
 aumo1jQP4e1DqWvA5tqS+FWBih8u5zsy8ObUMtZi9dGNqNWAnBPRNh3AbJXEyvovWOi7
 8cL7vRy+WicEd0Z6GjS0Zh3qdjawVsTsw6NiL3+frSJHLVHimsTbcsTMyjNT23C/PjKn
 8TmcowXwzeualK/dNUUgD/XTsalEYOnaxLeGsOI+k6uCtq7vKNqpvpo75X09ePsGa1zv
 zUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705065103; x=1705669903;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qvomdc0NwBwCxQ/2gZuOKk1li0juoJJtoSCvd8aovNQ=;
 b=FUaFCcKuP05lw3PZH1I7mjpuz5Xsu1Fa4M0FxyOh6ZWOqoZAA34N0XBATnyFWQ5aMT
 Xrt9U5LCL1ZNsKTAJOgssysmkrlZEEDwEYOe0eLmbcx4QrrOLJuRCF134KBa6Q4PmrEJ
 KYg/qHO3nZwgFnSyR7mVlOFU+sc6xhXXw9FxbERCBxsH6W8diZFStEJPiJAN0GaV/U1c
 gX3LGZYKtRO457CnknLlDCFj92lF6q8nUoqPDCtxOI/yGSKzswWa4Iu+unMYjHHdiZoK
 mnXkF4sF0yMg/URpWHH3SskjE8wQqxm8G+fvtbr9y7vjT4yNEFljjoBer41t2QH4hCDy
 sTjA==
X-Gm-Message-State: AOJu0Yw8HJrWxB3FC5HCSB6cSHS78r/p/ja7j/V6vS9VNoY0Hf6N73b9
 H+LXF0n5xIe/OuljhcHkJcn8crRZ241nZg==
X-Google-Smtp-Source: AGHT+IE+50uH+FH5A/XMmxy5ikq3qsCRlsxFXy6b7jHaLJOv19Ex3ujCqvdMWoAHLYnHHB9QQ+AEeg==
X-Received: by 2002:a05:6000:1103:b0:337:99f5:b53a with SMTP id
 z3-20020a056000110300b0033799f5b53amr47723wrw.54.1705065103155; 
 Fri, 12 Jan 2024 05:11:43 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 z15-20020a056000110f00b00336751cd4ebsm3888203wrw.72.2024.01.12.05.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 05:11:42 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8B45D5F760;
 Fri, 12 Jan 2024 13:11:42 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,  Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Wainer dos
 Santos Moschetta <wainersm@redhat.com>,  Beraldo Leal <bleal@redhat.com>
Subject: Re: [PULL 22/22] Revert "tests/avocado: remove skips from
 replay_kernel"
In-Reply-To: <CAFEAcA8p6S-6bYXO9w2eBP=UTy0vYbBOrgaoscOE=xv3K0z-PA@mail.gmail.com>
 (Peter Maydell's message of "Fri, 12 Jan 2024 11:13:11 +0000")
References: <20240112110435.3801068-1-alex.bennee@linaro.org>
 <20240112110435.3801068-23-alex.bennee@linaro.org>
 <CAFEAcA8p6S-6bYXO9w2eBP=UTy0vYbBOrgaoscOE=xv3K0z-PA@mail.gmail.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Fri, 12 Jan 2024 13:11:42 +0000
Message-ID: <87h6jielwx.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 12 Jan 2024 at 11:11, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> This reverts commit c2ef5ee89d76f0ab77c4dd6a1c9eeed4d35d20ed.
>>
>> While the fixes for #2010 and #2013 have improved things locally it
>> seems GitLab still continues to be flaky.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>
>> diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kerne=
l.py
>> index 6fdcbd6ac3d..1eaa36444cb 100644
>> --- a/tests/avocado/replay_kernel.py
>> +++ b/tests/avocado/replay_kernel.py
>> @@ -98,10 +98,13 @@ def test_i386_pc(self):
>>
>>          self.run_rr(kernel_path, kernel_command_line, console_pattern, =
shift=3D5)
>>
>> +    # See https://gitlab.com/qemu-project/qemu/-/issues/2010
>> +    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test sometimes get=
s stuck')
>>      def test_x86_64_pc(self):
>>          """
>>          :avocado: tags=3Darch:x86_64
>>          :avocado: tags=3Dmachine:pc
>> +        :avocado: tags=3Dflaky
>>          """
>>          kernel_url =3D ('https://archives.fedoraproject.org/pub/archive=
/fedora'
>>                        '/linux/releases/29/Everything/x86_64/os/images/p=
xeboot'
>> @@ -132,6 +135,8 @@ def test_mips_malta(self):
>>
>>          self.run_rr(kernel_path, kernel_command_line, console_pattern, =
shift=3D5)
>>
>> +    # See https://gitlab.com/qemu-project/qemu/-/issues/2013
>> +    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable o=
n GitLab')
>>      def test_mips64el_malta(self):
>>          """
>>          This test requires the ar tool to extract "data.tar.gz" from
>
> These gitlab issues are both currently closed -- if we think the
> problem is still present and are re-introducing the skip lines,
> we should re-open the issues, I think.

Hmm - I certainly fixed some bugs under those two. I think I'll re-spin
with a new bug raised.

>
>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

