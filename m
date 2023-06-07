Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1337262E5
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 16:34:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6uEV-0007bE-B3; Wed, 07 Jun 2023 10:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6uET-0007aY-3S
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:33:53 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6uEP-0005yj-Dw
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:33:52 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f735259fa0so45502785e9.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 07:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686148427; x=1688740427;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DRISuSMZAVWY6Gs4avNot3VpR1cnQEabLztdsVLdxb4=;
 b=lhLDEyOw/vDaSdMmiDZ9H8Gi+uwoBJ8odZGQsJm7E1P1BUNQRmeOF86XvK2TVGCbmz
 bQTlfNUiXdnDfJ7tCICt7f/jVU8ToKVDFww/D6hk/MqJzcfyFt7wXhygBxs5GMh4Y5E8
 1/10TwCv9L0lYpOJoxQmZ4t+ttgMfs15wZedM/m7M/yiqupfIe2SLbQMb5ofvqQ7i+r3
 YahuMktQJ4Yvo+KineJwG+Qa6dg8JmIGdxSNRIXW6/0f/mksoq9H5LkQ21zX4nIdr3GU
 JNyRjbeJ95uQ22YCUS2PIKJDpAQELyOURtTebrLPzQcfAntMzrXAnvJWREHBiFTxPm4g
 zm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686148427; x=1688740427;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DRISuSMZAVWY6Gs4avNot3VpR1cnQEabLztdsVLdxb4=;
 b=kAlR1KjTZ4drMdjaT+ue2cAprMdTD6hP3Hyy4VsG7gZg9iEWIU+f/96HlK5l3nbkmx
 vCJmgAehmxgE5udbu+0JyajB7YfbkY19YQ0I91zVsDs8VZbP/GdmLyLbdaGImZRMtgV0
 cP4Kh+k7GYb6PWyABK7PWgJMsXlhfZ9IR3oJvJBkHGpW+m2+v60+rI8/EYvEorqmVNif
 /f7keIEmVdmn4XfKbA7vcV/TVkY7x+hgkK5Me8LH/6PNGz0Hgv9STiAvpbJas3gDiy6Q
 k3dMRKh/a91ALtlc0KLrW2m3t510PH5hjzVQOk+FxP/t4ESTVXdwb12S0ilIuJt/NwU0
 0M1w==
X-Gm-Message-State: AC+VfDy23hScSZUu6aHor0ZkQsG82TISMH4CGBaD51LkApjEAO/ZUWCA
 7eHSWwQOvRzYdgF25Y/rFL5l6w==
X-Google-Smtp-Source: ACHHUZ7NIPV72POUlW2+LwzLVz/WKxoFEf3019z79mu1IrNPxYr0ovRxt4lxE9bli2ePrqkakVzWmg==
X-Received: by 2002:a05:600c:218b:b0:3f7:39ed:c9a4 with SMTP id
 e11-20020a05600c218b00b003f739edc9a4mr7526026wme.30.1686148427546; 
 Wed, 07 Jun 2023 07:33:47 -0700 (PDT)
Received: from [192.168.69.115] (bd137-h02-176-184-46-52.dsl.sta.abo.bbox.fr.
 [176.184.46.52]) by smtp.gmail.com with ESMTPSA id
 c23-20020a05600c0ad700b003f7f1466203sm2215326wmr.34.2023.06.07.07.33.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jun 2023 07:33:46 -0700 (PDT)
Message-ID: <ab3d3d19-2604-c519-03b0-af3952fb7718@linaro.org>
Date: Wed, 7 Jun 2023 16:33:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 1/1] tests/avocado: update firmware to enable sbsa-ref/max
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20230530152240.79160-1-marcin.juszkiewicz@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230530152240.79160-1-marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 30/5/23 17:22, Marcin Juszkiewicz wrote:
> Update prebuilt firmware images to have TF-A with FEAT_FGT support
> enabled. This allowed us to enable test for "max" cpu in sbsa-ref
> machine.
> 
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>   tests/avocado/machine_aarch64_sbsaref.py | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
> index 0a79fa7ab6..35f8042416 100644
> --- a/tests/avocado/machine_aarch64_sbsaref.py
> +++ b/tests/avocado/machine_aarch64_sbsaref.py
> @@ -29,23 +29,23 @@ def fetch_firmware(self):
>           """
>           Flash volumes generated using:
>   
> -        - Fedora GNU Toolchain version 12.2.1 20220819 (Red Hat Cross 12.2.1-2)
> +        - Fedora GNU Toolchain version 13.1.1 20230511 (Red Hat 13.1.1-2)
>   
>           - Trusted Firmware-A
> -          https://github.com/ARM-software/arm-trusted-firmware/tree/5fdb2e54
> +          https://github.com/ARM-software/arm-trusted-firmware/tree/c0d8ee38
>   
>           - Tianocore EDK II
> -          https://github.com/tianocore/edk2/tree/494127613b
> -          https://github.com/tianocore/edk2-non-osi/tree/41876073
> -          https://github.com/tianocore/edk2-platforms/tree/8efa4f42
> +          https://github.com/tianocore/edk2/tree/0f9283429dd4
> +          https://github.com/tianocore/edk2-non-osi/tree/f0bb00937ad6
> +          https://github.com/tianocore/edk2-platforms/tree/7880b92e2a04

Thanks for updating this comment!

> -    @skip("requires TF-A update to handle FEAT_FGT")
> +    @skipUnless(os.getenv("AVOCADO_TIMEOUT_EXPECTED"), "Test might timeout")

Can it still timeout?

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


