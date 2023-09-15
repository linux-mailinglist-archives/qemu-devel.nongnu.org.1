Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF477A122A
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 02:08:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgwMq-0003M2-0Z; Thu, 14 Sep 2023 20:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qgwMo-0003La-2T; Thu, 14 Sep 2023 20:07:26 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qgwMm-000471-Gy; Thu, 14 Sep 2023 20:07:25 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bf55a81eeaso12592115ad.0; 
 Thu, 14 Sep 2023 17:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694736442; x=1695341242; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=akMA5DHTLp8/TK4390g5G9f8eKB/RVwJvhVQoNI8nwA=;
 b=pjGpma0FC1zCGB8j4BT2UQgadliHxrnzadwlkYwLQSZznQdJOGSPNgwg0L71XWJIUd
 2zpjmiQu36K0dvD5GGNT3+Lx3JdJNzQ7yUE5bSStG/GiyqsIsMJQE94qbjBxIcC+Ap0A
 hbmvu8+1hLNQi7LlC5xsc3jJQLuuMAdVb3gGhpdI2nlmcpkzWfuSauObUgRrVt/L/wWv
 ZlOttbJyrI4APggpbVHlTP5xg7n5iVd8axzJQ4BBCwDPSTpJ8vos5CYzUXDPhOkJOJL0
 BKfrzMsXQaxNhBkBdzcIaed/slmQFrsa7789Cq7ddVnZwjg21TUHOm4jFc63NO0HQAaO
 A2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694736442; x=1695341242;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=akMA5DHTLp8/TK4390g5G9f8eKB/RVwJvhVQoNI8nwA=;
 b=VCxE0WuT/xc/LhBjyC2caB4kPRX3LxcRgryrZHz/Ky8lq5hvaIaQvqve+haKqz5IbZ
 DnrgclD/ifrDDH/jlKsjiXtynmTTOGmdwMnwVktYatCEZVeAMwg9KBwb+s54nGX3qaAF
 qJyAYXwUOMm6G9Zr96v5ZQVfK/LJbdZ+3AsWX/vBxz2HvtPbpPFLo233gcIyhHa0KG99
 CPTZH/SMADx83rDmnKd3k1zyi4Eqe1r85q98TOYoCTtoy1Y9NU2zjDpDS/fR5Wel/07C
 qshmwp8JElbUpKYtOzfexyff+IZpUuA7ALwXZ0qmMbFJpoSkOLaKS/vwhUR+UCbR2hzE
 dgXw==
X-Gm-Message-State: AOJu0YzmXX5/1ebXZTc8g7BuaWmP9ayKVAihd6V6SJ6+tpsCCEBHQ02J
 DW8crpDTevK05uAGPEkcpT4=
X-Google-Smtp-Source: AGHT+IEwPpHYBSuGlb2geknI+C5e9qp7iOtMECPROdZplGUVS8ZMz4sIB9kZmqFsh4oEO4LoY0Z3Cw==
X-Received: by 2002:a17:902:d895:b0:1c1:e4f8:a5a9 with SMTP id
 b21-20020a170902d89500b001c1e4f8a5a9mr105321plz.34.1694736442153; 
 Thu, 14 Sep 2023 17:07:22 -0700 (PDT)
Received: from localhost ([193.114.103.68]) by smtp.gmail.com with ESMTPSA id
 j21-20020a170902c3d500b001bb8895848bsm2150165plj.71.2023.09.14.17.07.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 17:07:21 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 15 Sep 2023 10:07:15 +1000
Message-Id: <CVJ1XEE2EVJ1.LRJP84PIGBIG@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: "John Snow" <jsnow@redhat.com>, "Cleber Rosa" <crosa@redhat.com>,
 "Beraldo Leal" <bleal@redhat.com>, =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, "Wainer dos Santos Moschetta" <wainersm@redhat.com>,
 <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH] tests/avocado: Fix console data loss
X-Mailer: aerc 0.15.2
References: <20230912131340.405619-1-npiggin@gmail.com>
 <87h6nytpwr.fsf@linaro.org>
In-Reply-To: <87h6nytpwr.fsf@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
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

On Wed Sep 13, 2023 at 6:51 PM AEST, Alex Benn=C3=A9e wrote:
>
> Nicholas Piggin <npiggin@gmail.com> writes:
>
> > Occasionally some avocado tests will fail waiting for console line
> > despite the machine running correctly. Console data goes missing, as ca=
n
> > be seen in the console log. This is due to _console_interaction calling
> > makefile() on the console socket each time it is invoked, which must be
> > losing old buffer contents when going out of scope.
> >
> > It is not enough to makefile() with buffered=3D0. That helps significan=
tly
> > but data loss is still possible. My guess is that readline() has a line
> > buffer even when the file is in unbuffered mode, that can eat data.
> >
> > Fix this by providing a console file that persists for the life of the
> > console.
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>
> Queued to testing/next, thanks.
>
> > ---
> >
> > For some reason, ppc_prep_40p.py:IbmPrep40pMachine.test_openbios_192m
> > was flakey for me due to this bug. I don't know why that in particular,
> > 3 calls to wait_for_console_pattern probably helps.
> >
> > I didn't pinpoint when the bug was introduced because the original
> > was probably not buggy because it was only run once at the end of the
> > test. At some point after it was moved to common code, something would
> > have started to call it more than once which is where potential for bug
> > is introduced.
>
> There is a sprawling mass somewhere between:
>
>   - pythons buffering of IO
>   - device models dropping chars when blocked
>   - noisy tests with competing console output
>
> that adds up to unreliable tests that rely on seeing certain patterns on
> the console.=20

Yeah it's a tricky bug and a difficult stack to diagnose. I started to
look at 40p machine firmware console at first since it was happening on
there.

It's actually not too bad now, I was irritating it by putting delays in
various avocado console socket reading, which can trigger it easily (my
guess is due to delay allowing file buffer to pull in more data than is
consumed). With patch the only check-avocado failures I was getting was
some OS watchdog timeouts in their console print code caused by back
pressure.

Thanks,
Nick

