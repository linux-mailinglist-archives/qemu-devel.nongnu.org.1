Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3833074F5A4
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 18:37:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJGMO-0007MZ-7k; Tue, 11 Jul 2023 12:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qJGML-0007LC-Nd
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 12:37:06 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qJGMJ-0003D4-BB
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 12:37:05 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fbc59de0e2so61336025e9.3
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 09:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689093422; x=1691685422;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MLqnit2KhfZld1CRyQCQaO27QSVwxzmPRh7dmzw7TUY=;
 b=RyjVA4jOY/tzurmuzIf7PS/cc8i9e4yEE6OSBGMheKY+lyS3r6smneSvHf4JqKfGFI
 xj5RAlJlfh2HzgGRlSkfX/zryfezNF47rvqTYQcwpgcq43fcda1rdgGWecBhu3jNJXZB
 LtnLJlZCvHXqzB6xZU3VQkVijxSD/eXWe4RjRSIN4Aqvh+eJVoOog3tygKTIj4Uvm5Qe
 amB1nGgPX5tii7pYJmq8dFJ516UOOJogZvTqoAbFwANfK+A0YUbS72iiln8ammBsvUq6
 +WzA709s9GcTZuCgGpokpX/uaHxkZ3gk6qpxZc0g+6o+KDGBiiOjWLqpPEp2wq16bQ8l
 W/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689093422; x=1691685422;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MLqnit2KhfZld1CRyQCQaO27QSVwxzmPRh7dmzw7TUY=;
 b=fc+tTwe1hwAVdlI9VykXRLuaCjuhMEOc7XyYJu+/qpomw3Cwa1hp4VuUIjbcYE1KZI
 GG4nmV9KSMxcVCwiFaP6hsqNpoTuX2iMw6bpbFbqUB3odr1zm1f3GuINuVMe3QhnO82Q
 24cCHcBgckoZ1oP3qFbIxEzo32bYU3fZJZ7xvWtU6ZXGvFjtH3Gf9o+j19GHq0fLadpk
 9rdaRd1CQ5asDWlVUW56xRrZze7wwIV97q39kjCax5P7CeHVZE1Rnu+55SfSQb+B1w2P
 a4TvgicgFy9RvJB9ant5TaOg/rbm/4CT+F0449prR++jA34Xn1kpVhfqXl7tWK96rpEc
 0D/Q==
X-Gm-Message-State: ABy/qLZM7P5H7nA2jyH7njdRERaYQNq0DQQ0LruLQpQRGkc8HL1kDdxr
 jr54VE9AvqtMK29hduRJ7NQe8w==
X-Google-Smtp-Source: APBJJlEF8t5bRI8q4wu9XGQ36Al5Y93yqbjwz6VIV+Fx4F0EZYIJQ8qNOVj2lfN2zGVQTTot5wQXjQ==
X-Received: by 2002:a5d:5088:0:b0:313:e553:b858 with SMTP id
 a8-20020a5d5088000000b00313e553b858mr14490491wrt.33.1689093421757; 
 Tue, 11 Jul 2023 09:37:01 -0700 (PDT)
Received: from [192.168.11.252] ([185.65.165.31])
 by smtp.gmail.com with ESMTPSA id
 q10-20020adfdfca000000b003144b95e1ecsm2634841wrn.93.2023.07.11.09.37.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jul 2023 09:37:01 -0700 (PDT)
Message-ID: <fc175fa2-f12c-b4ec-6622-ff0e85902bcc@linaro.org>
Date: Tue, 11 Jul 2023 17:36:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [hotfix PATCH-for-8.1 v4] configure: Fix cross-building for RISCV
 host
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20230711110619.56588-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230711110619.56588-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 7/11/23 12:06, Philippe Mathieu-Daudé wrote:
> While when building on native Linux the host architecture
> is reported as "riscv32" or "riscv64":
> 
>    Host machine cpu family: riscv64
>    Host machine cpu: riscv64
>    Found pkg-config: /usr/bin/pkg-config (0.29.2)
> 
> Since commit ba0e733362 ("configure: Merge riscv32 and riscv64
> host architectures"), when cross-compiling it is detected as
> "riscv". Meson handles the cross-detection but displays a warning:
> 
>    WARNING: Unknown CPU family riscv, please report this at https://github.com/mesonbuild/meson/issues/new
>    Host machine cpu family: riscv
>    Host machine cpu: riscv
>    Target machine cpu family: riscv
>    Target machine cpu: riscv
>    Found pkg-config: /usr/bin/riscv64-linux-gnu-pkg-config (1.8.1)
> 
> Now since commit 278c1bcef5 ("target/riscv: Only unify 'riscv32/64'
> -> 'riscv' for host cpu in meson") Meson expects the cpu to be in
> [riscv32, riscv64]. So when cross-building (for example on our
> cross-riscv64-system Gitlab-CI job) we get:
> 
>    WARNING: Unknown CPU family riscv, please report this at https://github.com/mesonbuild/meson/issues/new
>    Host machine cpu family: riscv
>    Host machine cpu: riscv
>    Target machine cpu family: riscv
>    Target machine cpu: riscv
>    ../meson.build:684:6: ERROR: Problem encountered: Unsupported CPU riscv, try --enable-tcg-interpreter
> 
> Fix by partially revert commit ba0e733362 so when cross-building
> the ./configure script passes the proper host architecture to meson.
> 
> Fixes: ba0e733362 ("configure: Merge riscv32 and riscv64 host architectures")
> Fixes: 278c1bcef5 ("target/riscv: Only unify 'riscv32/64' -> 'riscv' for host cpu in meson")
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> v4: pass from configure

Applied to master.


r~


> ---
>   configure | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 2b41c49c0d..dffd44c059 100755
> --- a/configure
> +++ b/configure
> @@ -451,7 +451,11 @@ elif check_define __s390__ ; then
>       cpu="s390"
>     fi
>   elif check_define __riscv ; then
> -  cpu="riscv"
> +  if check_define _LP64 ; then
> +    cpu="riscv64"
> +  else
> +    cpu="riscv32"
> +  fi
>   elif check_define __arm__ ; then
>     cpu="arm"
>   elif check_define __aarch64__ ; then


