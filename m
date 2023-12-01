Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA6E800E49
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 16:15:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r95EM-0007mK-An; Fri, 01 Dec 2023 10:15:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r95EI-0007Rf-IJ
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 10:14:58 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r95EE-0005P5-7x
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 10:14:56 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40b479ec4a3so20149965e9.2
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 07:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701443693; x=1702048493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BvpUgN/RqDHcT+hK4lm0re1niy4qNm1TIIBpDqfm/T4=;
 b=dIwFbvwXoRrh4xQpNOL8Bzs/b1lZrmPrXJN6ztrY8CpQkGYUPxNqcg5ArHPPKB1c/Y
 3szLW09Rmy4AQeKhz23u5b2Lxhe5wxjd7zRYz0+MBQ6mJtv+NX/aVIOUI3ELWiye5gyM
 ZskIBiSQnhbiDnwsGDz1xvvHVwZrYBfIyoDqjitvFxCQFnQUwg4H2a/NG0OZLbq/Hzd/
 B52EmH93yaX093E9HwfbXXzWXLZB4UEwTJoBEKI9tHnc1SNZ9w8iuX5Gf3H3onvLgIim
 Snx2taCMz5uv7mcmw7V0CsX4mHBk4KKBBsvIMneJ9si492K+MaZdNHIFWHInFwzt7Tza
 j9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701443693; x=1702048493;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BvpUgN/RqDHcT+hK4lm0re1niy4qNm1TIIBpDqfm/T4=;
 b=YWHFlM9MafIjKCny6yM4Mn1syWBINo8aE/hIR82WmRO0RU7eofi8n1D0wIfl7okbWq
 42c1QoT8yjt1NnHPMlPG5FiFm7rfqqTLcI2+75zYg1UWp78EuundKAGQiwT0cVIjHhph
 M0bmYrw04OQg0E10ArYK6c9wCWCMX7h4HlsEeWDYPyHkNKollx6qI9WD8cJbOyB9xxgK
 oBZbRkytQvNkZBBzQHJBweZwRmP7hqVVSlASxmecWewcVFNLUnykpmSrTdhW4JHygLyg
 3B7q0CQFnRhzC8KonZrV+A7aAXWQsNUzlIbgrL6nzj3p3heO5IbsENJuY5YEzNS3i2Ps
 OLIg==
X-Gm-Message-State: AOJu0YznwUEgWewn8sa2/7+gZB7FNVquIDEkS5449hSxHl4IwZrlPvic
 30/AODhXIKMqjCCLEo+wQYuKng==
X-Google-Smtp-Source: AGHT+IFtqKRWiGt4fD1/GiYZcnZyk0t8BplW8j/OM4xtPy4IBW4uocOj7Drs634NcBJp6Jal4JhgUg==
X-Received: by 2002:a1c:7316:0:b0:40b:5e22:98c with SMTP id
 d22-20020a1c7316000000b0040b5e22098cmr700703wmb.123.1701443692716; 
 Fri, 01 Dec 2023 07:14:52 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 p11-20020a05600c468b00b0040b561924bbsm7414744wmo.21.2023.12.01.07.14.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 07:14:51 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EAA9C5FB5F;
 Fri,  1 Dec 2023 15:14:50 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Eric Farman <farman@linux.ibm.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Leif Lindholm
 <quic_llindhol@quicinc.com>,  Beraldo Leal <bleal@redhat.com>,  Andrew
 Jeffery <andrew@codeconstruct.com.au>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>,  Pavel Dovgalyuk
 <pavel.dovgaluk@ispras.ru>,  Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org,  Radoslaw Biernacki <rad@semihalf.com>,  Yoshinori
 Sato <ysato@users.sourceforge.jp>,  Eric Auger <eric.auger@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,  qemu-s390x@nongnu.org,  Wainer dos
 Santos Moschetta <wainersm@redhat.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@kaod.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,  Aurelien Jarno
 <aurelien@aurel32.net>,  Cleber Rosa <crosa@redhat.com>,  Joel Stanley
 <joel@jms.id.au>,  Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 3/7] tests/avocado: drop
 BootLinuxConsole.test_mips_malta_cpio test
In-Reply-To: <1f9eb253-0346-4264-8817-11cf079e8f07@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 1 Dec 2023 14:57:11
 +0100")
References: <20231201093633.2551497-1-alex.bennee@linaro.org>
 <20231201093633.2551497-4-alex.bennee@linaro.org>
 <cbcdea98-4fc2-4952-9f7b-b3db242ad8b6@linaro.org>
 <1f9eb253-0346-4264-8817-11cf079e8f07@linaro.org>
User-Agent: mu4e 1.11.25; emacs 29.1
Date: Fri, 01 Dec 2023 15:14:50 +0000
Message-ID: <87o7fa5505.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 1/12/23 14:45, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 1/12/23 10:36, Alex Benn=C3=A9e wrote:
>>> The assets are no longer archived by Debian so we can't run this on
>>> CI. While some people may still have the test in their cache we do
>>> have more recent images from tuxrun so this isn't a great loss.
>>>
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>>> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>> ---
>>> =C2=A0 tests/avocado/boot_linux_console.py | 22 ----------------------
>>> =C2=A0 1 file changed, 22 deletions(-)
>>>
>>> diff --git a/tests/avocado/boot_linux_console.py
>>> b/tests/avocado/boot_linux_console.py
>>> index 231b4f68e5..5d978f6dd0 100644
>>> --- a/tests/avocado/boot_linux_console.py
>>> +++ b/tests/avocado/boot_linux_console.py
>>> @@ -116,28 +116,6 @@ def test_x86_64_pc(self):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 console_pattern =
=3D 'Kernel command line: %s' %
>>> kernel_command_line
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.wait_for_co=
nsole_pattern(console_pattern)
>>> -=C2=A0=C2=A0=C2=A0 def test_mips_malta(self):
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Darch:mips
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Dmachine:ma=
lta
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Dendian:big
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 deb_url =3D ('http://snapsh=
ot.debian.org/archive/debian/'
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '20130217T032700Z/pool/main/l/linux=
-2.6/'
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'linux-image-2.6.32-5-4kc-malta_2.6=
.32-48_mips.deb')
>
> This link still works for me, what am I missing?
>
> $ wget
> http://snapshot.debian.org/archive/debian/20130217T032700Z/pool/main/l/li=
nux-2.6/linux-image-2.6.32-5-4kc-malta_2.6.32-48_mips.deb
> --2023-12-01 14:55:31--
>   http://snapshot.debian.org/archive/debian/20130217T032700Z/pool/main/l/=
linux-2.6/linux-image-2.6.32-5-4kc-malta_2.6.32-48_mips.deb
> Resolving snapshot.debian.org (snapshot.debian.org)... 185.17.185.185,
> 193.62.202.27
> Connecting to snapshot.debian.org
> (snapshot.debian.org)|185.17.185.185|:80... connected.
> HTTP request sent, awaiting response... 200 OK
> Length: 30231730 (29M)
> Saving to: =E2=80=98linux-image-2.6.32-5-4kc-malta_2.6.32-48_mips.deb=E2=
=80=99

The failing link is the malta_cpio linux-4.7 one, I've fixed that in the
PR.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

