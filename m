Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9287EB4FE
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 17:37:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2wPG-0004Cl-1O; Tue, 14 Nov 2023 11:36:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2wP7-0004AE-E7
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 11:36:45 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2wP5-0007nT-Iz
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 11:36:45 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-507973f3b65so8297585e87.3
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 08:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699979802; x=1700584602; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qjggQVNSAsvz3AmnhfnmRULpg7MuJShyvfJx3mGDBmM=;
 b=ByrNIyQQtq7t1979I8XK7/bUe3h31tqX4SM+zUXzxOaeerfQ84gJAbhnkRM1kzbQbv
 xEpy4et1DJSYyo7MrUUWWV4p3paUSIWcmqriZqlxcqoXAgpCW7EauWaR4MIxg34oVosv
 4FALQLH5mVM9Vj3dQuz+zWdZJqjUsibjfXtkbLXqfFwHbPLUs1VyxKR5eCI5feMMlBpt
 hbCT6fSrIxPISu1yutydjwNxb0eyz+mw7Amb1zGJORdJDt0MnzvrLHV/qiTVa0jccfFb
 tgAuB/yQ2YrwPV8XmIaJTuAY5+9OyJkaa6lccZN2luahIkISkFAKK1oQqDVAwKCzIr4a
 UuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699979802; x=1700584602;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qjggQVNSAsvz3AmnhfnmRULpg7MuJShyvfJx3mGDBmM=;
 b=sAnizmvwGQzYLy9NZHvT0nd7OH0PYoNkYJON2aqoOLQmzxvvTZ9lZogLFUobwPdvq9
 qZkzjQjPjNYHEJPOV4G9XmizavUi454SSbdoJmDV+2Cu+BeiKvsaY0aOJmiMwcrH4ra1
 FTqw5Eol14q3uElDIdr1f7RW6WJJE+qPbMg4CU6yzddFdAoeagKrSFuACxpbekQ7JalL
 eAzKXytdJZSG5EUFb5OOo3CZNR4bmK+JSCtpUa8Q8r66Xoe/1Nmj6hnCWyKsAJ6k2gWu
 rfVg+eabCZujAismXl+r6uJOOXbrGgONdeXqVfQPVTpOADErc0wvAtsdMBuqQXS36rcr
 3vhA==
X-Gm-Message-State: AOJu0Ywi/HfiLu+SxHAEUUw3sjjweBWwMYPZF20oIeE13G07KXJUoyNJ
 c2pDhY0QtjVYb+XL7c8nJ8mLmg==
X-Google-Smtp-Source: AGHT+IE2v43qFutoGrfv8d4Bxmk5MZnhILbJz09qDcaBikhi5cCQR1F+Cce4VfzQUXcQ0rG4f564Tw==
X-Received: by 2002:a05:6512:3604:b0:509:47ba:3160 with SMTP id
 f4-20020a056512360400b0050947ba3160mr6475670lfs.56.1699979801845; 
 Tue, 14 Nov 2023 08:36:41 -0800 (PST)
Received: from [192.168.69.100] (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 x11-20020a50ba8b000000b0053d9cb67248sm5388374ede.18.2023.11.14.08.36.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 08:36:41 -0800 (PST)
Message-ID: <2ab35329-f45f-437e-9d2a-99ad0fbbccda@linaro.org>
Date: Tue, 14 Nov 2023 17:36:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/avocado/replay_kernel: Mark the test_x86_64_pc as
 flaky
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20231114153019.295131-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231114153019.295131-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

On 14/11/23 16:30, Thomas Huth wrote:
> It's failing very often, so don't run this by default anymore
> until it gets fixed.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/avocado/replay_kernel.py | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
> index a18610542e..53cb7e5091 100644
> --- a/tests/avocado/replay_kernel.py
> +++ b/tests/avocado/replay_kernel.py
> @@ -81,7 +81,8 @@ def run_rr(self, kernel_path, kernel_command_line, console_pattern,
>           logger.info('replay overhead {:.2%}'.format(t2 / t1 - 1))
>   
>   class ReplayKernelNormal(ReplayKernelBase):
> -    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
> +
> +    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test sometimes gets stuck')
>       def test_x86_64_pc(self):
>           """
>           :avocado: tags=arch:x86_64

Hmm I suspect https://gitlab.com/qemu-project/qemu/-/issues/1961 which
has a fix ready:
https://lore.kernel.org/qemu-devel/20231110170831.185001-1-richard.henderson@linaro.org/


