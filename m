Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FCD79E363
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 11:19:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgM13-0005bF-KV; Wed, 13 Sep 2023 05:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qgM0y-0005ag-Rf
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:18:29 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qgM0w-0006I5-L8
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:18:28 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-52e64bc7c10so8492974a12.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 02:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694596703; x=1695201503; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jIUwBMgg3G97ZH9wzmRimjfRiWE7dmnEgFhigWWp/Pg=;
 b=w8E/UWQmvMQUvQufhPPOpgp4OXj/Zn2Ydev2DhpvHOmCW6WMKw1+04oocL6atrTUvC
 qUFUIsyGMFucebBDH18DJWUEB/AvIkdKMSmCPLp3oJboIJUpKmRb6/ieeJYt8HJmmqtH
 RctCGaKmBnESPQdFF9H+aOi6dkhPccW3RlWmYlPYWpA/pUNfhcLXBCpFNFBE9hIh6GIv
 VBb/QxIIDZhP77y/ajcLWFd/ZpqV6trPeXUZ68KNmA6eJpE94duirx4YlJr9lBJ4GeZB
 NNHgX3JXN03gOjtUShAAAwioQKcHmfuFhH2R3g6hMUEKyLEujnb/e06RmKPl5pVmOYho
 3udw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694596703; x=1695201503;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jIUwBMgg3G97ZH9wzmRimjfRiWE7dmnEgFhigWWp/Pg=;
 b=ZBusxvmuBCyq9GqzHdwoc3hJ/Y9JgDLujyKIJLbfqs0OQpSdMNnmzg+fR13PtUUXAs
 eb1jl6HMxnmVPi02n9odGJDv69FSGc4wR+SsamjsYL1b0ic7O9mBTAsGa7Vt9kyCyHix
 OGl9X41AlEcCkHwskam29X7X0hqXm4Z6DmA9JvX62BvGhlyjMQWLY6DX4F0oGUHULu3W
 vxcfD0JdwJgRA3IQ7rewQnT7xAjoGpVpSKQYrjRGlaKr6RiBobziVcrjTmfPcRabUYyN
 lXVvx8eHbluNB+A/LtSCE15BemH0hMBWHrBt9wrsd0HlDoNesCf4TnZokdLnmT3K9uWf
 VUxA==
X-Gm-Message-State: AOJu0YzARhrNdglRtaOgbgOUwLR5z/AHA3ScGgER9OHBRa8q2KT60b9O
 xsRBlkZtiQPDgyn7sTBeD8V4VcKt7b3vEsqQXf9+/g==
X-Google-Smtp-Source: AGHT+IGxdXxMNAt6Q4xJXxZs/fF+zOoF+7ydFhtAFEBj4X1PgscWgmo2+vS657GIPKzhh+nkBHKHmEoAXR3J2n7e2M0=
X-Received: by 2002:aa7:c6d0:0:b0:525:5a65:6dfa with SMTP id
 b16-20020aa7c6d0000000b005255a656dfamr1670116eds.14.1694596703667; Wed, 13
 Sep 2023 02:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230912150611.70676-1-stefanha@redhat.com>
 <27e38912-0bad-7398-dda6-1670fc644f74@redhat.com>
In-Reply-To: <27e38912-0bad-7398-dda6-1670fc644f74@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Sep 2023 10:18:12 +0100
Message-ID: <CAFEAcA_roU-_E4P94km1RF=u6c+GRBxrGP0jS1_dXsRABCymJg@mail.gmail.com>
Subject: Re: [PATCH] gitlab: remove unreliable avocado CI jobs
To: Thomas Huth <thuth@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Tue, 12 Sept 2023 at 21:00, Thomas Huth <thuth@redhat.com> wrote:
> Please don't remove the whole job! Just disable the failing tests within the job, e.g.:
>
> diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
> --- a/tests/avocado/replay_kernel.py
> +++ b/tests/avocado/replay_kernel.py
> @@ -503,6 +503,7 @@ def do_test_mips_malta32el_nanomips(self, kernel_path_xz):
>           console_pattern = 'Kernel command line: %s' % kernel_command_line
>           self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
>
> +    @skipIf(os.getenv('GITLAB_CI'), 'Skipping unstable test on GitLab')
>       def test_mips_malta32el_nanomips_4k(self):
>           """
>           :avocado: tags=arch:mipsel

Please don't skip unstable tests on gitlab only. If they're
unstable, then nobody wants to be running them and wondering
if these are flaky tests or real issues, whether theyr'e doing
it on gitlab or locally. (I know we already have a lot of these,
but the effect is that instead of saying 'make check-avocado'
you have to say 'GITLAB_CI=1 make check-avocado'.)

thanks
-- PMM

