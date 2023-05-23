Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 784C670E1B2
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:28:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1UsA-0007zt-TU; Tue, 23 May 2023 12:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1Us8-0007zi-JM
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:28:28 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1Us7-0007ue-56
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:28:28 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f423521b10so695525e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684859305; x=1687451305;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+y0J6rHknnSF9YxLDHkj14T6EgK7Sai42Q1y1S0C18w=;
 b=IXSmUQbP2jmcUetelDZ0McsLkOR7mH9It9lliToz4mNzuUtJz8n/OsOm604MdFrw7V
 QXD0T+sWBXpDcaL43ZbJIpAA+nYlDZGaWlTDMUm4KOSIclDnPeDUAbtfyUCiqwgz23Yi
 TWGn/JUCw3DIZJzvnpwgtC9PwOqFOD/PqIK5EIMgd6PosN1f3ouC2UxRhojVYQntoSV4
 iyk+Wyd1EDzW9iO0HxIE4S+l2BigipvJOA/VwPr8TPs2MiCrPFCDrgV8Uo7RQ9L6Sdwh
 c1MvOUeVFyPsN+j1meOnRIlzd7i/CdQJ1ro+VnXkn5RWBwhe9Reb5/dwmsND6ZfOZY6t
 bHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684859305; x=1687451305;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+y0J6rHknnSF9YxLDHkj14T6EgK7Sai42Q1y1S0C18w=;
 b=PMTjovh3hr4FupUjKgOg8Tmto6PdiPGKIQi1k29D52Js+ehN1ySWcWD7NY5sWGPWET
 Zvk+dIRFQqEQKausoFHkpTGPq4vfuSQS2Pz57TVXUc2g5xqRxVnKP8uGbSVhpS+M7MAd
 cyZw0UogTI8lGrfeKab5r2uK+Y71hwJ0y6W+9Tz+ejZ5F4VT87L4xtIRxADN4iqjdeEQ
 xncGSe18ti52vVXAHzogUzDh4Bep16NausdnRMWbWh1sGPZL+idinrB8+6z+deInrze0
 IX+/5QkQVNCSX838nCODhxPa2yp4GN3GjHVDEyL1x9yt+DJOlg8HKHeV430CPVrETvL4
 bpvA==
X-Gm-Message-State: AC+VfDyYeVS1Bogj3OX/p4iAjccYjpMZ0vGzlNhd3nzlpM4k6zjRmy2Y
 qnnObNsMAlc/8tVkr82nHbXDkJ480LqvAfi2jX0=
X-Google-Smtp-Source: ACHHUZ6C+GgufkR5O9LneV3/HEI9K5FjRtIOO4G2xBOlhFrzTf9jeTE7KSE+8TEKotiq9E9qmBotEw==
X-Received: by 2002:a7b:cb0d:0:b0:3f6:a16:4010 with SMTP id
 u13-20020a7bcb0d000000b003f60a164010mr2445218wmj.1.1684859305571; 
 Tue, 23 May 2023 09:28:25 -0700 (PDT)
Received: from [192.168.1.102] (vil69-h02-176-184-48-94.dsl.sta.abo.bbox.fr.
 [176.184.48.94]) by smtp.gmail.com with ESMTPSA id
 k1-20020a7bc301000000b003f50e88ffc1sm15710384wmj.0.2023.05.23.09.28.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 09:28:25 -0700 (PDT)
Message-ID: <c317e0ee-09ac-e8f7-e0de-b1b927ed1f2e@linaro.org>
Date: Tue, 23 May 2023 18:28:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 05/52] tcg: Move TCG_TYPE_TL from tcg.h to tcg-op.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230523135322.678948-1-richard.henderson@linaro.org>
 <20230523135322.678948-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230523135322.678948-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 23/5/23 15:52, Richard Henderson wrote:
> Removes the only use of TARGET_LONG_BITS from tcg.h, which is to be
> target independent.  Move the symbol to a define in tcg-op.h, which
> will continue to be target dependent.  Rather than complicate matters
> for the use in tb_gen_code(), expand the definition there.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op.h      | 8 ++++++++
>   include/tcg/tcg.h         | 7 -------
>   accel/tcg/translate-all.c | 2 +-
>   3 files changed, 9 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


