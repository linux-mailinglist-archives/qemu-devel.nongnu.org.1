Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8844C74F26E
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 16:37:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJEUW-0006iS-J9; Tue, 11 Jul 2023 10:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJEUS-0006i9-2Z
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 10:37:21 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJEUQ-0000Rn-Iq
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 10:37:19 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4fba1288bbdso8502101e87.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 07:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689086236; x=1691678236;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ji68/Oh4J2TtNldtqxEF5x54wYyCk/SRYVelvPIkRYQ=;
 b=gCBPi30xkmst1vgEJVxBS+Kz09jBGx9cKzqkgfFkv56mCK5WDQ7E5xMXMC63jT0got
 O6+g4jjLyUWKDa7OyWz0Fey9Fh3THorGViKfw6mcZWbPr/wJ9Sc7Mz87PBJD/pPOkxf/
 7zdwo9tz3BchvnOVNKdO4d/H7nOKdVQJJ9sd2aXw9UwYBfRDqPXoPZBGyhtGgzHuCzuK
 0Q3vlQ4yrupgd/qGWSck5P6ilcZuDfLE2LMI2XL4VyMow0BpicaNMjdezRUfwL43J0pB
 bVOL7Bw0BxBVymXGbbQ0fDgwkTt5L+wqxD2HMHipHRgaG1UK8cZD59dl7mR5J0jDgluK
 2y+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689086236; x=1691678236;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ji68/Oh4J2TtNldtqxEF5x54wYyCk/SRYVelvPIkRYQ=;
 b=PaHhTR+ierFV5Qs/LFH7+88FaUuQNRlqSnCMic7m46na0wMW3vTiuWTalolSw26/nJ
 yMtvBkMt6JB8yUawbzhpSQ1PfxH5Ct7xKd/TO2YUGW4kSEwN+lA7Zhia497kjoN0r/Wc
 g9sq3wJGcg11IEwj6+qgpXcJJS5LawxM6OLHldS6wUg11pcFRZ7OoLwgyr8aGn56YPBS
 eO02uRYMD8/3kLsGXaOqrDvn5Y09ZOlTt+/2jUuTvfV+GXPhuSLOcaUMgL82huK7d+qd
 RVBY5zkCXh5OcNiboNXKWSm/UfuXrBhdspWxjLH05fkhU7ATbGRfckQfZhpizHOgJEZf
 hyqg==
X-Gm-Message-State: ABy/qLbu3S7EDD5WkG/ioADThuySy0fjslac95KmuRLRMJeG6KoCtLfY
 9cRGGo51kH2R3sacXzMelRxhtfBYGOMEoU80tcI=
X-Google-Smtp-Source: APBJJlHkXcrbWuh6l/HjATNCRXhyGyW8eq5o3dHhsFOtqFXyuuQIVr2DZ88gn2lO++zuFsmo5y8e0w==
X-Received: by 2002:a19:6503:0:b0:4f8:5713:7dd5 with SMTP id
 z3-20020a196503000000b004f857137dd5mr13071058lfb.10.1689086236129; 
 Tue, 11 Jul 2023 07:37:16 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.194.156])
 by smtp.gmail.com with ESMTPSA id
 e3-20020a056402088300b0051e06693590sm1312577edy.91.2023.07.11.07.37.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jul 2023 07:37:15 -0700 (PDT)
Message-ID: <f76b44f9-8852-d284-331f-5587ecbd1dcc@linaro.org>
Date: Tue, 11 Jul 2023 16:37:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/3] tests/lcitool: Generate distribution packages list
 in JSON format
Content-Language: en-US
To: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: Warner Losh <imp@bsdimp.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Erik Skultety <eskultet@redhat.com>
References: <20230711140143.65818-1-philmd@linaro.org>
 <20230711140143.65818-2-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230711140143.65818-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
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

On 11/7/23 16:01, Philippe Mathieu-Daudé wrote:
> Add the generate_pkglist() helper to generate a list of packages
> required by a distribution to build QEMU.
> 
> Generate the FreeBSD JSON file (based on FreeBSD 13).
> 
> Suggested-by: Erik Skultety <eskultet@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/lcitool/refresh | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
> index b54566edcc..a5df096074 100755
> --- a/tests/lcitool/refresh
> +++ b/tests/lcitool/refresh
> @@ -84,6 +84,12 @@ def generate_cirrus(target, trailer=None):
>       generate(filename, cmd, trailer)
>   
>   
> +def generate_pkglist(vm, target):
> +    filename = Path(src_dir, "tests", "vm", vm + ".json")
> +    cmd = lcitool_cmd + ["variables", "--format", "json", target, "qemu"]
> +    generate(filename, cmd, None)

Note since json files don't have comments, we can't have the
"THIS IS GENERATED BY A SCRIPT" in header.

