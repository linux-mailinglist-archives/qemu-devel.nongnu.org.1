Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A02B7EB4B1
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 17:23:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2wBU-0007vQ-Ip; Tue, 14 Nov 2023 11:22:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r2wBJ-0007uR-VU
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 11:22:31 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r2wBI-0004Qy-EM
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 11:22:29 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-53dd752685fso8922289a12.3
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 08:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699978946; x=1700583746; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oqNXPjnw9wycvLc05CCxqksTeUQEfgDI22Ju8g/KxO8=;
 b=Nc8Rzag+7NegUcj5MEq8uGKIUZgeuIN2CCe/S5AG1NUUvRUeBe+cA4kMy4WHV8khzA
 ZsA2e51sqhYYJALJRosuy7KKYqWXk3FM1FT6M2qDRdruv4dQM2AWsXCuUYCijRcwgd3T
 sVZGRCey+c9BDSmtDVpivRzKyOs9Ct7IdMQbFMNoFxYpGl4KqJr5+d/G/Qs8bQGlHYa+
 wE3g4InlEDfFTCqMYfwKIcMTimyzhYWbsZL9rAxW3LqT9gzYwukEEpx53ezv590XObnP
 BsDFLN/8jduJfUYFpwEqc6bUTXsZfJneVWm12HdIyAfEOAVeHIClKrNPBhkviQqqUFRA
 GD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699978946; x=1700583746;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oqNXPjnw9wycvLc05CCxqksTeUQEfgDI22Ju8g/KxO8=;
 b=fbV6jZE2pZliSuo5wDMEWo2yjGKuYTk5Q8/S0UDglcYEvEy6WWBP/7vS/hyjmc2GpV
 upqXNXg0Ame/3L30dDSDK2YyeUtecSHqWqsQGe2TDNk9maIZS5RGdkm6v5pNMYUSm/Lp
 Uvlqs5mv6WgyHS81G/qwtpu8nQKuZGUSgh5YVao7eelUFx+HuBdTXD0gK7PKpjncWeoy
 Nq6pjWhlFachK4ivGnJegkU5il52widB3CYlYiu6bnCe73KIoCCJIRMN0vRGsXFdYWog
 pVIW892ablkBtrZFLQgHWHyLBKpUL36Cle9xyhr78EAnB8WCHRmlj+4x/fjVlz+iHhNV
 7Xkg==
X-Gm-Message-State: AOJu0YyulZj19wCnj9M320Lo1wMmkbpi0kd8XX2Qj+n0JRgx1vzGAtzL
 aoB5wVwZ8eZ/wdtgREHHhYoP0uRSmJ4EU2SL9u8wCw==
X-Google-Smtp-Source: AGHT+IESGvtFxckGM7wZ0xrKE7BYzO3mSlEyWlWV4a24Y9GX6DATm9qgC253vtLy+c+MbiVEQXtXs1c6CO09b/QlHF0=
X-Received: by 2002:aa7:dbd9:0:b0:544:7c9b:6227 with SMTP id
 v25-20020aa7dbd9000000b005447c9b6227mr6732538edt.4.1699978946329; Tue, 14 Nov
 2023 08:22:26 -0800 (PST)
MIME-Version: 1.0
References: <20231114153019.295131-1-thuth@redhat.com>
In-Reply-To: <20231114153019.295131-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Nov 2023 16:22:15 +0000
Message-ID: <CAFEAcA905bJ1PAv-SRNKKeC_KvCvi=OOU9SznuXbn6=5p-+eKw@mail.gmail.com>
Subject: Re: [PATCH] tests/avocado/replay_kernel: Mark the test_x86_64_pc as
 flaky
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Tue, 14 Nov 2023 at 15:30, Thomas Huth <thuth@redhat.com> wrote:
>
> It's failing very often, so don't run this by default anymore
> until it gets fixed.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/avocado/replay_kernel.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
> index a18610542e..53cb7e5091 100644
> --- a/tests/avocado/replay_kernel.py
> +++ b/tests/avocado/replay_kernel.py
> @@ -81,7 +81,8 @@ def run_rr(self, kernel_path, kernel_command_line, console_pattern,
>          logger.info('replay overhead {:.2%}'.format(t2 / t1 - 1))
>
>  class ReplayKernelNormal(ReplayKernelBase):
> -    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
> +
> +    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test sometimes gets stuck')
>      def test_x86_64_pc(self):
>          """
>          :avocado: tags=arch:x86_64

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

We should replace all of the "skip if GITLAB_CI" checks
with "skip on QEMU_TEST_FLAKY_TESTS" (or other check as
appropriate), I think.

thanks
-- PMM

