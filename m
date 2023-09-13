Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B8179E6F6
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 13:37:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgOAy-0006rC-Ka; Wed, 13 Sep 2023 07:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgOAw-0006pL-1E
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 07:36:54 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgOAt-0007oE-G2
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 07:36:53 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2bf66a32f25so88508731fa.2
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 04:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694605009; x=1695209809; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mhPxlCP5iiHhxUWlXW9Ln6C+XMWrmPesBr1seUxNxDk=;
 b=c6/6zB5p9bwvze+6d+9MYBKDcuotdiyjK3ypwnAOqic6ldj8meRSLUdZbG1wkraWOH
 CmSi+atqpRuM41K0z9e9iSVheiLfGUPZxS2f+Z8Cpus46lJOypplIG/D42MYsD+bGWUh
 oksPc9BC1CR1AnXs9kVATLLiuXhTKnVh7rTmMborQXGypze8n3jGJWj57D7PfS0euC0u
 5zWx2nUGz4x/y0wz4du31BrLB2O7LiJUmNR/eeepQnaIgRPkURaosV6adxkqcmbtsL5+
 FrhIDB9GculfO/3ztMcl0AShOQbtj2nmM/5PF8UooAHDRPVSL3PEixlG5jWap5VQ6Ps9
 scvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694605009; x=1695209809;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mhPxlCP5iiHhxUWlXW9Ln6C+XMWrmPesBr1seUxNxDk=;
 b=KYITtZXaaMnxasdefkGvR48qsGPq46B9/dA/Z3GaHPXCkH+CP9LxskAnT3Oti2iT5r
 plbaZoiZJrG0eqQdMAEjkuayMzAR9F+7il3+9BI9weZ+gUDMeAi/qVsPX4KStDg8QadD
 A5y1HN4jrb8THBWlQ06o/V9fOh/zXMPff4DhyoH+Ilhk6ogFQ4Lc9hIX+gsRm7mfSRyN
 FfwRm8C49RKqOaR/3rQZs0EBBdqaCvqTfqVFoZ2+7P1hByTeCwBF1x1cQIhyyPO83QCV
 B0V3UGMEcqx2MN45PeBimpyRUO4Tr4GgVNzyGwqW7hV5KztQGR7spwPIFshfIH9Gjm2b
 82lw==
X-Gm-Message-State: AOJu0YxA45O2EZ7xRlpNts2tTMoyQKRRi0moORk1hhluPppxd1Ojz336
 h3+8+T/xQ2wFgL6vG2/Q1f/pug==
X-Google-Smtp-Source: AGHT+IFZvXgI/R2WpgmboOJzSPJFZH9vzpiJA3z7YOs84vTrd3+eMT+7vC/TUaRM+X/Uy+yA1Q9WLw==
X-Received: by 2002:a2e:3c0b:0:b0:2bd:14cc:ab1b with SMTP id
 j11-20020a2e3c0b000000b002bd14ccab1bmr2054585lja.44.1694605009080; 
 Wed, 13 Sep 2023 04:36:49 -0700 (PDT)
Received: from [192.168.69.115] (176-131-211-241.abo.bbox.fr.
 [176.131.211.241]) by smtp.gmail.com with ESMTPSA id
 mc14-20020a170906eb4e00b009888aa1da11sm8228757ejb.188.2023.09.13.04.36.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 04:36:48 -0700 (PDT)
Message-ID: <057bee7c-92e0-1cf2-bcdd-ef7eeb223db4@linaro.org>
Date: Wed, 13 Sep 2023 13:36:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] hw/cxl: Fix out of bound array access
Content-Language: en-US
To: Dmitry Frolov <frolov@swemel.ru>, jonathan.cameron@huawei.com,
 fan.ni@samsung.com, qemu-devel@nongnu.org
Cc: sdl.qemu@linuxtesting.org
References: <20230913101055.754709-1-frolov@swemel.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230913101055.754709-1-frolov@swemel.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

Hi Dmitry,

On 13/9/23 12:10, Dmitry Frolov wrote:
> According to cxl_interleave_ways_enc(),
> fw->num_targets is allowed to be up to 16.
> This also corresponds to CXL specs.
> So, the fw->target_hbs[] array is iterated from 0 to 15.
> But it is staticaly declared of length 8.

"statically"

> Thus, out of bound array access may occur.
> 
> Fixes: c28db9e000 ("hw/pci-bridge: Make PCIe and CXL PXB Devices inherit from TYPE_PXB_DEV")
> 
> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> ---
>   include/hw/cxl/cxl.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
> index 56c9e7676e..4944725849 100644
> --- a/include/hw/cxl/cxl.h
> +++ b/include/hw/cxl/cxl.h
> @@ -29,7 +29,7 @@ typedef struct PXBCXLDev PXBCXLDev;
>   typedef struct CXLFixedWindow {
>       uint64_t size;
>       char **targets;
> -    PXBCXLDev *target_hbs[8];
> +    PXBCXLDev *target_hbs[16];
>       uint8_t num_targets;
>       uint8_t enc_int_ways;
>       uint8_t enc_int_gran;

The loop in cxl_fixed_memory_window_config() is indeed unsafe.

OOB can be catched adding:

-- >8 --
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 034c7805b3..fe9143409b 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -33,6 +33,7 @@ static void cxl_fixed_memory_window_config(CXLState 
*cxl_state,
      for (target = object->targets; target; target = target->next) {
          fw->num_targets++;
      }
+    assert(fw->num_targets <= ARRAY_SIZE(fw->target_hbs));

      fw->enc_int_ways = cxl_interleave_ways_enc(fw->num_targets, errp);
      if (*errp) {
---

If Jonathan concurs, please add to your patch.

Thanks,

Phil.

