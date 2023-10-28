Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E067DA8E2
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:23:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwotZ-00046V-PR; Sat, 28 Oct 2023 15:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwotX-00044e-Tj
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:22:51 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwotW-0000F6-I1
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:22:51 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6b497c8575aso3167764b3a.1
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698520969; x=1699125769; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SLgl6QyBft2qTJ4ava7WRgfCmZtLPP/0i1sHdbD6lu8=;
 b=uxp4e30C0sMJG3otMJ0xu4gG3d7ws7A6KdV3hKUwjtNA+Rp7Jv0Qm5C7IldgMMT+Cz
 vqfdPR77dM7drm98NCP/rOqWJYWrXtZ6iV+kPF9QxXKeZldNpEmsHNHfHet02Q9ibhys
 lfrDSCoLYY35IiV4ZqZVbQQWILoFePWg1pH0nVqgcJcPguGSOoc+q0WgkMUdted92gzs
 pRbuzXC7gt9apMzv4hNeSo66+P5Q0XmuQsLudPIzId3A3RKWLrguGrvjm3VilaKZKpAk
 +FhOeRk1cDNMeUJUYOPKCfH6xaJeXCtYYnhWwIrLt1RMalhSpBskW3WwLjs2CV7kwrPt
 oMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698520969; x=1699125769;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SLgl6QyBft2qTJ4ava7WRgfCmZtLPP/0i1sHdbD6lu8=;
 b=PJQBaxj1mNl07v6tLYvmWr1/euTNQkZHacbnPpPhgHEVb8k1ZMcdWxD+XoE9/BS3jC
 YyVPj0CX9liYA4gWZX7fcHjJ//xz6fC2iRdtRrL7+nRnbCPLPwPQDtow7YHK0neTd4iH
 8dr/Z0dihmwUXwWlpP+VCADjzTBQ1b/GE4Sie/U3RG5whvMdnZnBvRkC8r4NXtQ8IRzY
 /501jXN9BkSDe04W5DCHSKtYyYAtPpmNxp4RZv3QcVeH0VY7c8vzI+J7PCNXmZL84h0j
 C5hEdIA/GIhjhaSa5jQAdGsMHIHMOe3EZccfHFmhb9x8U23YVmmahgGOLTiZ5rs/rpvv
 r1Og==
X-Gm-Message-State: AOJu0Yzj6FidMsLf3EWi5R/LhC839EtVkaRWOce1uwZsL1TixOatCkq5
 LUSps87H7D0lnmJ2K+qjM/3FRw==
X-Google-Smtp-Source: AGHT+IF3iZqZgx/R743+nXl9WpYrhukOEYX3s+ChH942hqzLRkwmxt4k+z23ckUGZfwx5HGGjQPBBQ==
X-Received: by 2002:a05:6a00:14d6:b0:6be:4e6e:2a85 with SMTP id
 w22-20020a056a0014d600b006be4e6e2a85mr8328372pfu.30.1698520969069; 
 Sat, 28 Oct 2023 12:22:49 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 fn4-20020a056a002fc400b006b4ac8885b4sm3390045pfb.14.2023.10.28.12.22.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 12:22:48 -0700 (PDT)
Message-ID: <777f5351-e819-4818-a874-b6281f6691ea@linaro.org>
Date: Sat, 28 Oct 2023 12:22:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/17] tests/docker: move sh4 to use
 debian-legacy-test-cross
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20231028103311.347104-1-alex.bennee@linaro.org>
 <20231028103311.347104-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231028103311.347104-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 10/28/23 03:32, Alex Bennée wrote:
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index d670fb42b9..983c95e785 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -276,7 +276,7 @@ build-user-legacy:
>       job: amd64-debian-legacy-cross-container
>     variables:
>       IMAGE: debian-legacy-test-cross
> -    TARGETS: alpha-linux-user
> +    TARGETS: alpha-linux-user sh4-linux-user
>       CONFIGURE_ARGS: --disable-tools --disable-system --static
>       MAKE_CHECK_ARGS: check-tcg

Missing exclude from build-user, like alpha.


r~

