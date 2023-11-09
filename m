Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 816837E6E33
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 17:06:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r17WQ-0007gL-IR; Thu, 09 Nov 2023 11:04:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r17W3-0007cn-C0
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 11:04:24 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r17W1-0001UA-74
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 11:04:22 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40842752c6eso7647345e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 08:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699545859; x=1700150659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d7/odcMHPyRWP9Cp8jHjOALDKNHfR30r5MKW5SKiTWU=;
 b=xMxsqhNAUWduRicBfG+zZG5wyPjnA9djNDAHjZw8xby8J117hxDo46SzXgHxfh4AwT
 J8zLMOKAuoNR8ySgbxhEGBFHzyJBZ40EusPrI42+75bonS/eXqJ7A9o7BGpIY3PqihqY
 8aDj8hkIBy4S84zuirmQPyt8Ob4v6YzrUXbnyFV9+e+3/seVh5ga1hYTGdJ4VTqewFHz
 QdiTfUAZMwGbQDyDf9WtXCrH2zuqUFoNplLumacConkijHARGRwYSX8KUD1InHqhMeUv
 pF1YPHRNrzPpSUiZ2nEDGq5Rmn+oazNOhNqH8hdW8ufrFIQYlqAsOausJnDo0rOaj9uw
 2dQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699545859; x=1700150659;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d7/odcMHPyRWP9Cp8jHjOALDKNHfR30r5MKW5SKiTWU=;
 b=fPHmm4QruzE8X7CnoHTFz6G3RCuv9/qJPc5pwpHJ5IVFjqZ0LB0iuxyXmoKp+Q5E2T
 zMaq1klbiL2dR3jHCq6MszLPyVegl2Zymx9ex87/fDqus2jfZyeAdGbNHpZ3FMBSS/01
 nYJsGCq1AUO8Q6FEDx1aGbIc7OmwBm3YmlQmsDE3IqRPeed0T11M0H3ItHyxkATahBv6
 +xYby8re/bBFVoleoj1rZ7wdDOt2eC2+MtBdzw82h6EH010rNQ7MJTMKIFjecsPHpWxc
 FfKxXqNQgJqFIVpseqqV+YB05aa1382UjKbTNlhXAOg9RI9lQa3WVor0FNapIFVeU567
 f/vw==
X-Gm-Message-State: AOJu0Yz2Q1XOFy5oMFvD1XbXYI0laXIDdF666SKYEzgoI4mgSGiVbXkX
 lGitAQTL9WV3rGTIDb4pjxQl8w==
X-Google-Smtp-Source: AGHT+IFQb2ppnM3FVXoj/CNengyz8j/LyLezceQ6s/niUXgx5PYuaYSyFLfntUtLKmKWLaueXkHMzw==
X-Received: by 2002:a05:600c:1c98:b0:405:34e4:14cf with SMTP id
 k24-20020a05600c1c9800b0040534e414cfmr4871381wms.4.1699545859215; 
 Thu, 09 Nov 2023 08:04:19 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ay15-20020a05600c1e0f00b0040586360a36sm2521784wmb.17.2023.11.09.08.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 08:04:18 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6BDF85F756;
 Thu,  9 Nov 2023 16:04:18 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Greg Manning <gmanning@rapitasystems.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 0/1] plugins: fix win plugin tests on cross compile
In-Reply-To: <20231109124326.21106-1-gmanning@rapitasystems.com> (Greg
 Manning's message of "Thu, 9 Nov 2023 12:43:18 +0000 (2 hours, 53
 minutes, 40 seconds ago)")
References: <20231109124326.21106-1-gmanning@rapitasystems.com>
User-Agent: mu4e 1.11.24; emacs 29.1
Date: Thu, 09 Nov 2023 16:04:18 +0000
Message-ID: <87msvm7w1p.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

Greg Manning <gmanning@rapitasystems.com> writes:

> v1-v2: Added the signed-off-by line.
> v2-v3: Fixed the issue reference.
>
> Greg Manning (1):
>   plugins: fix win plugin tests on cross compile
>
>  .gitlab-ci.d/crossbuilds.yml | 2 +-
>  contrib/plugins/Makefile     | 2 +-
>  plugins/meson.build          | 2 +-
>  tests/plugin/meson.build     | 3 ++-
>  4 files changed, 5 insertions(+), 4 deletions(-)

Actually I'm still seeing failures:

  FAILED: qemu-system-aarch64.exe=20
  x86_64-w64-mingw32-gcc -m64 -mcx16 @qemu-system-aarch64.exe.rsp
  /usr/lib/gcc/x86_64-w64-mingw32/12.2.1/../../../../x86_64-w64-mingw32/bin=
/ld: libcommon.fa.p/os-win32.c.obj: in function `set_dll_delaylink_hook':
  /builds/stsquad/qemu/build/../os-win32.c:83: undefined reference to `g_mo=
dule_symbol'
  /usr/lib/gcc/x86_64-w64-mingw32/12.2.1/../../../../x86_64-w64-mingw32/bin=
/ld: /builds/stsquad/qemu/build/../os-win32.c:89: undefined reference to `g=
_module_symbol'
  collect2: error: ld returned 1 exit status
  [2104/3331] Linking target qemu-system-aarch64w.exe
  FAILED: qemu-system-aarch64w.exe=20
  x86_64-w64-mingw32-gcc -m64 -mcx16 @qemu-system-aarch64w.exe.rsp
  /usr/lib/gcc/x86_64-w64-mingw32/12.2.1/../../../../x86_64-w64-mingw32/bin=
/ld: libcommon.fa.p/os-win32.c.obj: in function `set_dll_delaylink_hook':
  /builds/stsquad/qemu/build/../os-win32.c:83: undefined reference to `g_mo=
dule_symbol'
  /usr/lib/gcc/x86_64-w64-mingw32/12.2.1/../../../../x86_64-w64-mingw32/bin=
/ld: /builds/stsquad/qemu/build/../os-win32.c:89: undefined reference to `g=
_module_symbol'
  collect2: error: ld returned 1 exit status
  [2105/3331] Compiling C object libqemu-loongarch64-softmmu.fa.p/hw_loonga=
rch_virt.c.obj
  ninja: build stopped: subcommand failed.
  make: *** [Makefile:162: run-ninja] Error 1

Should I drop the other patch I grabbed:

  plugins: Move the windows linking function to qemu

?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

