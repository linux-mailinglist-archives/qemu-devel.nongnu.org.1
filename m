Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA6474974C
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 10:18:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHKBy-0003YT-Dt; Thu, 06 Jul 2023 04:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHKBw-0003Xs-Gu
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:18:20 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHKBv-0008Vt-1s
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:18:20 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fbef8ad9bbso4459585e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 01:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688631497; x=1691223497;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GtKKyEkgV14EoIncNyDv5Bcn/wcGOYCw9/TVGiEKiug=;
 b=wWqTZRchwBpTXRs5jwU3iOLRl7Mpc1dP/LMfDhNh8Xtj9j10uwZoXcy11t8I6X+EAJ
 1v7ebX1eWPTqQoLEHvKeUlNpaFfa/LiMq9oVoU7eTgmMjBLkD1zGxIXkfpee9gQDb+Xn
 ooyOwgCo829aldIUVY19IDukpvkLM10d0wjPiOovcBrAT63he80Igem7cLU04wXMXYKo
 iKDFDmch0t5mld0wKG38wsn1FPpg6os1qb6kOtniIZVyZDuhwfdVlO959dFU7WeNRrXz
 EfNO1WvFVKMf6z4h37FfRDYU0PwYgzee1qVMyJONv3DkiO25wrTYX0Ml+y5XIqoF+Z+Y
 cN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688631497; x=1691223497;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GtKKyEkgV14EoIncNyDv5Bcn/wcGOYCw9/TVGiEKiug=;
 b=U3RmBGpg/mtNwGzdpq53UOfeyvsg8K4FXY/zWAFaf/TlX3X61VHjZNH8sf/lCg5p6b
 KiQXkhKopMMD5WXeLAOulmb4XD4sXbd0/9MtGDLSqB1Tb5TKxBnGAhPScwwWNgo3pE8y
 Sf0IDw3Z4cjnt8z6i/FACAOi4ef87bLvqjpNjILiAOFRbnQmKVfSXTiAQttRvlysBWZp
 Kfw0W1C+htLbbKtQUI+ytjY4KJZPy+FkdIqvOt30BC+K9uZP2ke995SIdqunMv0C+oQP
 GkoHJdECiGQlOUzBOQAUz+43gAk6TyCv3nxb1YlPyx0RPSrsWUXcIP4DHGVmGLxm+EV4
 GOYQ==
X-Gm-Message-State: ABy/qLbI6yntB4qLma2uLn2bVYQfeShuEzvsRwVyyohXB9TPffcARaKr
 csxeXJBTb5WunsOVnIAejG4d/w==
X-Google-Smtp-Source: APBJJlGpQB08XenvJfsRLqSJBv31kN36IutX+pE/BVDeCMJGN8Sm9+6lc3LE1ENqzYc40i8FEuIZ1g==
X-Received: by 2002:a05:600c:2054:b0:3f9:b358:8197 with SMTP id
 p20-20020a05600c205400b003f9b3588197mr756784wmg.11.1688631497321; 
 Thu, 06 Jul 2023 01:18:17 -0700 (PDT)
Received: from [192.168.82.227] ([91.209.212.17])
 by smtp.gmail.com with ESMTPSA id
 10-20020a05600c024a00b003fa98908014sm4347306wmj.8.2023.07.06.01.18.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 01:18:16 -0700 (PDT)
Message-ID: <6a23a963-a289-e0bd-6131-641c6dce6363@linaro.org>
Date: Thu, 6 Jul 2023 09:18:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 11/46] target/loongarch: Implement xavg/xvagr
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230630075904.45940-1-gaosong@loongson.cn>
 <20230630075904.45940-12-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230630075904.45940-12-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
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

On 6/30/23 08:58, Song Gao wrote:
> +    len = (simd_oprsz(v) == 16) ? LSX_LEN : LASX_LEN;       \
> +    for (i = 0; i < len / BIT; i++) {                       \

Likewise.


r~

