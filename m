Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 901A6724CFB
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 21:26:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6cIb-0002uU-6x; Tue, 06 Jun 2023 15:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6cIZ-0002uI-Aa
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:24:55 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6cIX-0000qv-4K
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:24:55 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f6dfc4dffaso55835185e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 12:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686079491; x=1688671491;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t3YjWVS1zegY7NmC5DkjF/dBPD8cdb5JE9tCMy1I5iA=;
 b=z5uJp4LNKZN0OhrKsQAfJcLPyu/tj2la9Jne3jyFv81rsAwvnZBaXz+r5CJVmoJxon
 GdRp/xZ3WJU7d0CgCdz1lXWrlDY21SEUSqfuPdkvgoJKvG2uS+yIuZ673E7gTVISAI+b
 lr+3FGpSjt0wfd3+rHVAjk10NMWdhHZjTjm5Cict6/F4rbYW/jI/HHBUt5jAPk5pn9hR
 Z0apbdtFTyFJbaOGcVMERCQugEqJj+pm415b4ozVqYZDRWVw7JEB0MlDeazqTLHgvZro
 6ZUa1+sozpv9BUPpPQsxARE8wES+vVhGLQVDQmPrrpb5zWIHJdlw27lmcEYReVhQoXZu
 ovVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686079491; x=1688671491;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t3YjWVS1zegY7NmC5DkjF/dBPD8cdb5JE9tCMy1I5iA=;
 b=FHAlAcffh4+nVIz5N1SZL67vkZIPHr76qgYyO81FJUeFNnOhSYyCUKfSazWZEdwXYB
 sx9CU6do8UO6+9fXI2kZglShX6UQGZJcjtplkLI2hu0TyGGbUy5T9Cp4pj6sp+VvPye2
 6g56jmkJZ3KNcKFH4exOoYJTXZYMAKlQpbH55CDaCyuWAqkqYJoCw5b1XVAsI/0fz+/A
 rTASOtRjk2iXblTqCBbFp+PYEK8Y/LwBK4KURzWGHz+1eovP9l8Pf9AwA7cxs1S5P+T9
 i4gxPzz2xsdiczTtTSXpZyPjixPE6IkZn4St3SYUPRSHEmaY5Z5laJkEe76Xjn+48oOG
 OHBw==
X-Gm-Message-State: AC+VfDyGegPrWyQg5a6meKs32kXDx6XZGd36xJOXz2J5NzeiYJ2Vu8m8
 8taNXwMrGVmSQtk1HP/7xWlukA==
X-Google-Smtp-Source: ACHHUZ7I05tH5Ug6J+P5J00fzmOPgFiiKGAl2fX9i3irCv3vpDCOaObLHYd2zZkL81LzVxaYqqkA+A==
X-Received: by 2002:a1c:4c0d:0:b0:3f5:6e6:9d83 with SMTP id
 z13-20020a1c4c0d000000b003f506e69d83mr2589519wmf.23.1686079491539; 
 Tue, 06 Jun 2023 12:24:51 -0700 (PDT)
Received: from [192.168.69.115] (vbo91-h01-176-184-50-104.dsl.sta.abo.bbox.fr.
 [176.184.50.104]) by smtp.gmail.com with ESMTPSA id
 j9-20020a5d5649000000b0030b5d203e7esm13150645wrw.97.2023.06.06.12.24.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 12:24:51 -0700 (PDT)
Message-ID: <95b2ae8b-e2d3-7554-d810-85aafc1a9c35@linaro.org>
Date: Tue, 6 Jun 2023 21:24:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH] gitlab: Disable io-raw-194 for build-tcg-disabled
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, berrange@redhat.com, jsnow@redhat.com
References: <20230606162556.58110-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230606162556.58110-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 6/6/23 18:25, Richard Henderson wrote:
> This test consistently fails on Azure cloud build hosts in
> a way that suggests a timing problem in the test itself:
> 
> --- .../194.out
> +++ .../194.out.bad
> @@ -14,7 +14,6 @@
>   {"return": {}}
>   {"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>   {"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
> -{"data": {"status": "postcopy-active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}

Is it useful to modify 194.out.bad ...

>   {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>   Gracefully ending the `drive-mirror` job on source...
>   {"return": {}}
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   .gitlab-ci.d/buildtest.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index 0f1be14cb6..000062483f 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -236,7 +236,7 @@ build-tcg-disabled:
>       - cd tests/qemu-iotests/
>       - ./check -raw 001 002 003 004 005 008 009 010 011 012 021 025 032 033 048
>               052 063 077 086 101 104 106 113 148 150 151 152 157 159 160 163
> -            170 171 183 184 192 194 208 221 226 227 236 253 277 image-fleecing
> +            170 171 183 184 192 208 221 226 227 236 253 277 image-fleecing

... if we don't run test #194 anymore?

>       - ./check -qcow2 028 051 056 057 058 065 068 082 085 091 095 096 102 122
>               124 132 139 142 144 145 151 152 155 157 165 194 196 200 202
>               208 209 216 218 227 234 246 247 248 250 254 255 257 258


