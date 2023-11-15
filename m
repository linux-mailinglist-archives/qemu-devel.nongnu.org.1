Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2477EBADE
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 02:17:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r34VT-0000LH-Mi; Tue, 14 Nov 2023 20:15:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r34VS-0000Kw-Gm; Tue, 14 Nov 2023 20:15:50 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r34VP-0000yi-D8; Tue, 14 Nov 2023 20:15:50 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6be0277c05bso5693771b3a.0; 
 Tue, 14 Nov 2023 17:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700010946; x=1700615746; darn=nongnu.org;
 h=in-reply-to:references:message-id:to:from:subject:cc:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BAmrZygHqXrNN2EYLVQc6j6e9Mfrv2tRLEfsDwNoXMk=;
 b=bRuJ3PRS6pIjltZw8Mw6apxOrZqJJTml13QxcP1u2ZeTJBWOsNElVaaTAZBP04j4uV
 a1JY9ALCYxmwMHDVS5hTFr0j4RERcTtA0qR0lrQX1OoEM6eoKTQKND/6cjWJdOFW/UIF
 ZYPuRwyrb0VTo3wUx7+++SIXUhxJFlbS6pp11MEVmZ131ergb6NLKimLtiMmR3yW4xR0
 PHhPWo7cNYdsmC29KFgCOSsvHqX7RlxcKAPpFBm9j+iorOV5Kd9hxPXHlsdl94zU4eNB
 pC1dUoAQ6WLbOflHJ/kLh879b11HzhEY4417B6bXUoT4E1uhl74QGtvjezEgPK99ZRs/
 FYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700010946; x=1700615746;
 h=in-reply-to:references:message-id:to:from:subject:cc:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BAmrZygHqXrNN2EYLVQc6j6e9Mfrv2tRLEfsDwNoXMk=;
 b=fZpfDBdeP9haqWyCwrZQ1KjIxBmPsAoExay57J3qDYVyuTlyuWHPWm4GI96vwVjiU9
 0F6ADHwZ9hIFKGMLtm08CT2QgA++dZ18ONkfzfM0qhZlyUug0aEK4KHTLSeftbAB7uto
 LJDHH2CGim5wddx1OUqVLD3HVps8JLQkB+oO59IUAIkLYe8N1bPrkO9XMFupHVDjkiLp
 tEYKWIAXq6yEBmO7sh/m8p1Wg5hmzXH2pEnaXfMjJvhh+WMPlluWhWGw+4JVvNsFRzTh
 IRNLGDHJb5acJmxAQCcKzvwU6S/0fzMbTGC2eawYA0FPJgbzujgXE+rJMzQjPDz3VlwM
 4t2Q==
X-Gm-Message-State: AOJu0YxkPUb4ghh5u7jcfQiR9DIKracJM+QfYanxjnHnjPz/y8D9yUAn
 XB8dOcUWptK94T4TRwSbxag=
X-Google-Smtp-Source: AGHT+IFcSVHlPu9YGcRd8w8qLNbPgT74y23KfTrzO6zdSLgzv+6aVRf06W1WrrVSSVHE/rD05Lnqsg==
X-Received: by 2002:a05:6a20:914b:b0:185:876f:4f0a with SMTP id
 x11-20020a056a20914b00b00185876f4f0amr11146615pzc.24.1700010945608; 
 Tue, 14 Nov 2023 17:15:45 -0800 (PST)
Received: from localhost (121-44-82-40.tpgi.com.au. [121.44.82.40])
 by smtp.gmail.com with ESMTPSA id
 u4-20020aa78484000000b006bf83e892e9sm1803405pfn.155.2023.11.14.17.15.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 17:15:45 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Nov 2023 11:15:38 +1000
Cc: "Wainer dos Santos Moschetta" <wainersm@redhat.com>, "Beraldo Leal"
 <bleal@redhat.com>, "Cleber Rosa" <crosa@redhat.com>, "Pavel Dovgalyuk"
 <pavel.dovgaluk@ispras.ru>, "Paolo Bonzini" <pbonzini@redhat.com>,
 <qemu-ppc@nongnu.org>, "John Snow" <jsnow@redhat.com>
Subject: Re: [PATCH] tests/avocado/reverse_debugging: Disable the ppc64
 tests by default
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Thomas Huth" <thuth@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 <qemu-devel@nongnu.org>
Message-Id: <CWYYRW53VEPJ.3UL1X7GB1P4H2@wheely>
X-Mailer: aerc 0.15.2
References: <20231114163115.298041-1-thuth@redhat.com>
 <12b4420e-1440-4516-8276-e0e907003c16@linaro.org>
 <9f6247e4-7e81-44f8-a63b-8ee11f722710@redhat.com>
In-Reply-To: <9f6247e4-7e81-44f8-a63b-8ee11f722710@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed Nov 15, 2023 at 4:29 AM AEST, Thomas Huth wrote:
> On 14/11/2023 17.37, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 14/11/23 17:31, Thomas Huth wrote:
> >> The tests seem currently to be broken. Disable them by default
> >> until someone fixes them.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >> =C2=A0 tests/avocado/reverse_debugging.py | 7 ++++---
> >> =C2=A0 1 file changed, 4 insertions(+), 3 deletions(-)
> >=20
> > Similarly, I suspect https://gitlab.com/qemu-project/qemu/-/issues/1961
> > which has a fix ready:
> > https://lore.kernel.org/qemu-devel/20231110170831.185001-1-richard.hend=
erson@linaro.org/
> >=20
> > Maybe wait the fix gets in first?
>
> No, I applied Richard's patch, but the problem persists. Does this test=
=20
> still work for you?

I bisected it to 1d4796cd008373 ("python/machine: use socketpair() for
console connections"), which causes this halfway through the test:

2023-11-15 10:37:04,600 stacktrace       L0045 ERROR| Traceback (most recen=
t call last):
2023-11-15 10:37:04,600 stacktrace       L0045 ERROR|   File "/home/npiggin=
/src/qemu/build/pyvenv/lib/python3.11/site-packages/avocado/core/decorators=
.py", line 90, in wrapper
2023-11-15 10:37:04,600 stacktrace       L0045 ERROR|     return function(o=
bj, *args, **kwargs)
2023-11-15 10:37:04,600 stacktrace       L0045 ERROR|            ^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^
2023-11-15 10:37:04,600 stacktrace       L0045 ERROR|   File "/home/npiggin=
/src/qemu/build/tests/avocado/reverse_debugging.py", line 264, in test_ppc6=
4_powernv
2023-11-15 10:37:04,600 stacktrace       L0045 ERROR|     self.reverse_debu=
gging()
2023-11-15 10:37:04,600 stacktrace       L0045 ERROR|   File "/home/npiggin=
/src/qemu/build/tests/avocado/reverse_debugging.py", line 173, in reverse_d=
ebugging
2023-11-15 10:37:04,600 stacktrace       L0045 ERROR|     g.cmd(b'c')
2023-11-15 10:37:04,600 stacktrace       L0045 ERROR|   File "/home/npiggin=
/src/qemu/build/pyvenv/lib/python3.11/site-packages/avocado/utils/gdb.py", =
line 783, in cmd
2023-11-15 10:37:04,600 stacktrace       L0045 ERROR|     response_payload =
=3D self.decode(result)
2023-11-15 10:37:04,600 stacktrace       L0045 ERROR|                      =
  ^^^^^^^^^^^^^^^^^^^
2023-11-15 10:37:04,600 stacktrace       L0045 ERROR|   File "/home/npiggin=
/src/qemu/build/pyvenv/lib/python3.11/site-packages/avocado/utils/gdb.py", =
line 738, in decode
2023-11-15 10:37:04,600 stacktrace       L0045 ERROR|     raise InvalidPack=
etError
2023-11-15 10:37:04,600 stacktrace       L0045 ERROR| avocado.utils.gdb.Inv=
alidPacketError
2023-11-15 10:37:04,600 stacktrace       L0046 ERROR|

It doesn't always fail the same gdb command
(I saw a bc on line 182 as well). It seems to be receiving a
zero length response?

No idea what's happening or why ppc seems to be more fragile.
Or why changing console connection affects gdb connection?

Thanks,
Nick

