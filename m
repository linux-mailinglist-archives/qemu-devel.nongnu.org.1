Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FD682BD5B
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 10:37:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rODxN-0002AF-6x; Fri, 12 Jan 2024 04:36:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rODxG-000294-Qj
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 04:36:00 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rODxE-0001ko-UA
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 04:35:58 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40e66315d93so3776385e9.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 01:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705052154; x=1705656954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sZK+JIbFmFtYUzCn2Jf4pD7nH3HRngffi7UsN/G7qnc=;
 b=mmXHNggbEtM6We7SQKq+NifNhm+XocYWRYvJTgJ9ZIiIViq/0ataMNmE28r3VyXp9D
 wjJSm2ikp1ICl9mGuQUvZxd7z6+rmQgzpx51RoK/XCtY+PV82Y0TBHIWMIAJSvuOotu1
 WGM0eJT7LlOuGMslB0rCpqks3iVQOwpfU0c2gQ4VkJrpWzAMdvsTGpYAG7cCOVm/znHk
 taDGl8PHfC6qhZHbyBZlUiV3j6JSaLLwsWHM94oZH3bAb4SPypjvyEk0WeD5BQ/R2RBH
 eILFZR/onlvKY0WMyt3lDu2gsNHCCm6YUVQ5Td1OU+CxKtbrc8gpk4a9UrNsm/R/P2YM
 3c1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705052154; x=1705656954;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sZK+JIbFmFtYUzCn2Jf4pD7nH3HRngffi7UsN/G7qnc=;
 b=GNETVjsisNt20rY8tUS25dsGSexaXE9HlBz3sSHMw76hss2rOn+hAb6WHfE4q17/dq
 BWI1GgrPWk8irgrA5+TsE1mY7R8lPR/6tZBxEbPlz10jnhmSumxTLyG0GBLwHfEpTdYj
 yvmKcfMNn5U/pb2rI2nrRhJvTyLGRbe1ExlwtfVic/kdYDZu5Qx4DKK9jCBemenFzenN
 +D3yr/5aAGgbF9jjklB4FUkNTWNpiW33CK8Q/FulHCBbhofXL2f0INBx8cG77BT3nB6u
 rpby4Rm/NykdzufW1oH7INyiX018zs4hW5aJLAFuJlXUaighpkVpkVNQ+SoFOZV0gHSd
 D+7w==
X-Gm-Message-State: AOJu0Yw8u75kRT35EVgiqtO85ESQ9vJOzpPMyCBz/gmzZB2zytrY/1Df
 X4YpzDc8EflDCTuxdTzyRpGJsZN2BLFKwA==
X-Google-Smtp-Source: AGHT+IH9G37N48JcWjavoYtDleK9Y7DtvFuUVI9/zc2Vs6PuQxF5DptaL6TovbPkUTDN9VN6t77Fww==
X-Received: by 2002:a05:600c:3147:b0:40e:49b2:2c9e with SMTP id
 h7-20020a05600c314700b0040e49b22c9emr635331wmo.34.1705052153766; 
 Fri, 12 Jan 2024 01:35:53 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 je6-20020a05600c1f8600b0040d8d11bf63sm5088276wmb.41.2024.01.12.01.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 01:35:53 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0C88B5F7A4;
 Fri, 12 Jan 2024 09:35:53 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,  Pavel
 Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,  Pavel Dovgalyuk
 <pavel.dovgaluk@ispras.ru>,  Paolo Bonzini <pbonzini@redhat.com>,  Cleber
 Rosa <crosa@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,  Beraldo Leal
 <bleal@redhat.com>
Subject: Re: [PULL 13/13] tests/avocado: remove skips from replay_kernel
In-Reply-To: <bef35657-d490-4db5-ad52-daba13c8234e@redhat.com> (Thomas Huth's
 message of "Thu, 11 Jan 2024 18:19:20 +0100")
References: <20240108151352.2199097-1-alex.bennee@linaro.org>
 <20240108151352.2199097-14-alex.bennee@linaro.org>
 <bef35657-d490-4db5-ad52-daba13c8234e@redhat.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Fri, 12 Jan 2024 09:35:53 +0000
Message-ID: <871qamgah2.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

Thomas Huth <thuth@redhat.com> writes:

> On 08/01/2024 16.13, Alex Benn=C3=A9e wrote:
>> With the latest fixes for #2010 and #2013 these tests look pretty
>> stable now. Of course the only way to be really sure is to run it in
>> the CI infrastructure and see what breaks.
>> Acked-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20231211091346.14616-14-alex.bennee@linaro.org>
>
> The replay tests seem still to be very flaky, I'm now getting:
>
>  https://gitlab.com/thuth/qemu/-/jobs/5910241580#L227
>  https://gitlab.com/thuth/qemu/-/jobs/5910241593#L396
>
> I'd suggest to revert this patch to disable them in the CI again.

Ok I'll move it back to flaky. I thought I'd eliminated the problem as I
can do 100 runs without failure locally. Sadly there doesn't seem to be
anything obvious in the logs as to whats going on.

>
>  Thomas

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

