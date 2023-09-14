Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A96C7A0991
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 17:45:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgoVx-0004Kw-4q; Thu, 14 Sep 2023 11:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgoVv-0004KP-2t
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:44:19 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgoVt-0005jo-FX
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:44:18 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5230a22cfd1so1387078a12.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 08:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694706255; x=1695311055; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qPgmFXRtS/xN/OycSULZHA+IWJP98uMtjeIzMDivTjg=;
 b=UGNKNNr0hvnNbW8wrpDUb6mE0ylIDFe/NrlVd84D3uaw69hsdZE5YOCZvEj14NuD+0
 CDkBksdNm6Am+HRUllxxDdbiC/0Jtzbak4mPTM3585ISZCm+dYqnmg4oWVbunXAv4HVy
 +EPmBnZRKA6Dzv/Wrm5xWhIQ9e4dDbhCnsZEWaINRCz0RplvrceeaITfdg4kAd1KhsU9
 p2H/ln2RrrmthI6l5SGrDtFwWgrTnEuf0aYf+o2Vsj+lhEb8SQ6y+XBgGZ2NyPeEa3Uh
 v2J/VxvlUKAHaGl1CuEADBQSKunERLprutu6NwXU1Ze2Ho7o2nv/bLxeQJJrchOBhZar
 KA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694706255; x=1695311055;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qPgmFXRtS/xN/OycSULZHA+IWJP98uMtjeIzMDivTjg=;
 b=mmPVKAipP1IyQhwydUcEJWNKfOJOrUubdZRjad6GJYKuN+M1uWSCCb005dBoB/EI6R
 nUjg95GW1ecl9zWn3S9/ol4nMu4h1UoYr7hP3MXbEEi8GhTvHzYfjK64MkzCea6mNxyC
 fvnNyLNr6C+9dL0hsC14UIXmk7X3lWSM/+iqD0V5IPj6//FOp6KgalVtOSrVJ9Ih7P4K
 3NTyWXZ/7r/kijaZQO95lhmJKYMbP5ggiJbel9SsUlyC0Pyg4e6+90Vst06F+/rDnehk
 PdvKzTFWwIyIXozEdVXlrAzlJbMAquxu2BHPkZzOmDs+vMJbzuL7aUdzL7Dj+F57sU82
 FBUw==
X-Gm-Message-State: AOJu0YyTuWaH3EiSUWCj7+u7UKKd0Pb2kC0IFudLOrdVUT9tNZNCVKoX
 Ixvp5YCigIprKmwsSJ0ygNiPIQ==
X-Google-Smtp-Source: AGHT+IEzxW3DkAdfzj1E6mToBTR+r0XK91m3dnyVx1bcQkUn8gkfxxIv6oY8QaupLUQww8WieMqIJQ==
X-Received: by 2002:a17:906:3158:b0:9a2:5bf:8b14 with SMTP id
 e24-20020a170906315800b009a205bf8b14mr4752349eje.22.1694706254980; 
 Thu, 14 Sep 2023 08:44:14 -0700 (PDT)
Received: from [192.168.69.115] (176-131-223-129.abo.bbox.fr.
 [176.131.223.129]) by smtp.gmail.com with ESMTPSA id
 qx9-20020a170906fcc900b0099d0a8ccb5fsm1183857ejb.152.2023.09.14.08.44.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 08:44:14 -0700 (PDT)
Message-ID: <2cfd1afd-ad83-8507-b8be-b0d743f9d0ee@linaro.org>
Date: Thu, 14 Sep 2023 17:44:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 22/24] accel/tcg: Remove env_tlb()
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, ale@rev.ng
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
 <20230914024435.1381329-23-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230914024435.1381329-23-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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

On 14/9/23 04:44, Richard Henderson wrote:
> From: Anton Johansson <anjo@rev.ng>
> 
> The function is no longer used to access the TLB,
> and has been replaced by cpu->neg.tlb.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Message-Id: <20230912153428.17816-9-anjo@rev.ng>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> [rth: Merge comment update patch]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu-all.h       | 11 -----------
>   tcg/aarch64/tcg-target.c.inc |  2 +-
>   tcg/arm/tcg-target.c.inc     |  2 +-
>   3 files changed, 2 insertions(+), 13 deletions(-)

Missing:

-- >8 --
diff --cc accel/tcg/cputlb.c
index bb7dcb87af,08df68f03a..0000000000
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@@ -1746,7 -1734,7 +1734,7 @@@ bool tlb_plugin_lookup(CPUState *cpu, v
           /* We must have an iotlb entry for MMIO */
           if (tlb_addr & TLB_MMIO) {
               CPUTLBEntryFull *full;
-             full = &env_tlb(env)->d[mmu_idx].fulltlb[index];
++            full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
               data->is_io = true;
               data->v.io.section =
                   iotlb_to_section(cpu, full->xlat_section, full->attrs);
---

(Noticed using --enable-plugins).

