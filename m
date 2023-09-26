Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6B47AEF8A
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 17:23:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql9tR-0003i5-6i; Tue, 26 Sep 2023 11:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ql9tO-0003fh-9A
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:22:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ql9tM-0007L0-Lj
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695741747;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yREIMhGIRmS2vIJeWqtGtP1sHxsODDB2aT48ikFyCdA=;
 b=h0fzJQTQ8Hzmwr+viVt+F0bV1XaBE8gVFFQeyr3eCc7tpP2DyHyu3fqZajIHCwUVpeS1oc
 j/NTkwCgyRS6GInGfcUvWAou+Vfvi4voG8Fl31UPq8s6kqO7ywg6SomtYKrQNSxpVEAwR2
 SMNcfB4hdWEASCPe8KkqdOZXpFnn6VY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-6IwvhyPSNGay72rMqqLuzw-1; Tue, 26 Sep 2023 11:22:24 -0400
X-MC-Unique: 6IwvhyPSNGay72rMqqLuzw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40554735995so63640015e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 08:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695741743; x=1696346543;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yREIMhGIRmS2vIJeWqtGtP1sHxsODDB2aT48ikFyCdA=;
 b=pesrOUT8wRD47v2mlpYLk+w2fQbUkXezvVOVz85pKnLQ2q9dm5/wjoYDMeVw7P+iK1
 +xHC/gSBb0acDaN0jWoleX+/0qGiAiLM4kChXR8oAo++XRb3gPbvYLrc3SF8wTgGdxWM
 Wjf796zjZDAwUTsqTcbcqIUYa8sk4W9VExNvleItBQv4kyyVrorYDqIKIUiYqhtUMPkO
 6sUcn21pRDrKJ54BgcAi2zB/V19uvhCJftmbjznNQFZctA+lSzJy8+NZDFmM3FzpGEzf
 vspF/xKDoSqVMQK7lj9nHp87xw103X2oHK1iH+bR9YKXNVACaxcYE8TVnebREfpPCO1O
 +khw==
X-Gm-Message-State: AOJu0YwWZpcZmRvXhNI4lfK5qxYLbgYEmdbXDlt7foQ3mjFoHRmc0Bgv
 wG9MGdV7dnfrf/lWR0u/JBMKbFswniVDbw9X3JinFZ9kG4W5+fxvEaDW8B7bq/xihNXJAmYr2XL
 kIhST86ZP5u1XqQA=
X-Received: by 2002:a05:600c:2294:b0:3fe:dcd0:2e10 with SMTP id
 20-20020a05600c229400b003fedcd02e10mr9782376wmf.17.1695741743829; 
 Tue, 26 Sep 2023 08:22:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYpxGmoSr20A89z5ByIywJZ4Mmb0ZbjK5xLrLkY8rWYuxypJ94ZV5DrRkwKEtIJIu10L29AQ==
X-Received: by 2002:a05:600c:2294:b0:3fe:dcd0:2e10 with SMTP id
 20-20020a05600c229400b003fedcd02e10mr9782357wmf.17.1695741743463; 
 Tue, 26 Sep 2023 08:22:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d9-20020a1c7309000000b00402f713c56esm15273948wmb.2.2023.09.26.08.22.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Sep 2023 08:22:22 -0700 (PDT)
Message-ID: <c0b21b06-9250-f3f5-7074-08cf37f2a49b@redhat.com>
Date: Tue, 26 Sep 2023 17:22:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] hw/arm/smmuv3: Update ID register bit field
 definitions
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Mostafa Saleh <smostafa@google.com>
References: <20230914145705.1648377-1-peter.maydell@linaro.org>
 <20230914145705.1648377-2-peter.maydell@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230914145705.1648377-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Peter,

On 9/14/23 16:57, Peter Maydell wrote:
> Update the SMMUv3 ID register bit field definitions to the
> set in the most recent specification (IHI0700 F.a).
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/smmuv3-internal.h | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index 6d1c1edab7b..25abf117095 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -38,33 +38,71 @@ REG32(IDR0,                0x0)
>      FIELD(IDR0, S1P,         1 , 1)
>      FIELD(IDR0, TTF,         2 , 2)
>      FIELD(IDR0, COHACC,      4 , 1)
> +    FIELD(IDR0, BTM,         5 , 1)
> +    FIELD(IDR0, HTTU,        6 , 2)
> +    FIELD(IDR0, DORMHINT,    8 , 1)
> +    FIELD(IDR0, HYP,         9 , 1)
> +    FIELD(IDR0, ATS,         10, 1)
> +    FIELD(IDR0, NS1ATS,      11, 1)
>      FIELD(IDR0, ASID16,      12, 1)
> +    FIELD(IDR0, MSI,         13, 1)
> +    FIELD(IDR0, SEV,         14, 1)
> +    FIELD(IDR0, ATOS,        15, 1)
> +    FIELD(IDR0, PRI,         16, 1)
> +    FIELD(IDR0, VMW,         17, 1)
>      FIELD(IDR0, VMID16,      18, 1)
> +    FIELD(IDR0, CD2L,        19, 1)
> +    FIELD(IDR0, VATOS,       20, 1)
>      FIELD(IDR0, TTENDIAN,    21, 2)
> +    FIELD(IDR0, ATSRECERR,   23, 1)
>      FIELD(IDR0, STALL_MODEL, 24, 2)
>      FIELD(IDR0, TERM_MODEL,  26, 1)
>      FIELD(IDR0, STLEVEL,     27, 2)
> +    FIELD(IDR0, RME_IMPL,    30, 1)
>  
>  REG32(IDR1,                0x4)
>      FIELD(IDR1, SIDSIZE,      0 , 6)
> +    FIELD(IDR1, SSIDSIZE,     6 , 5)
> +    FIELD(IDR1, PRIQS,        11, 5)
>      FIELD(IDR1, EVENTQS,      16, 5)
>      FIELD(IDR1, CMDQS,        21, 5)
> +    FIELD(IDR1, ATTR_PERMS_OVR, 26, 1)
> +    FIELD(IDR1, ATTR_TYPES_OVR, 27, 1)
> +    FIELD(IDR1, REL,          28, 1)
> +    FIELD(IDR1, QUEUES_PRESET, 29, 1)
> +    FIELD(IDR1, TABLES_PRESET, 30, 1)
> +    FIELD(IDR1, ECMDQ,        31, 1)
>  
>  #define SMMU_IDR1_SIDSIZE 16
>  #define SMMU_CMDQS   19
>  #define SMMU_EVENTQS 19
>  
>  REG32(IDR2,                0x8)
> +     FIELD(IDR2, BA_VATOS, 0, 10)
> +
>  REG32(IDR3,                0xc)
>       FIELD(IDR3, HAD,         2, 1);
> +     FIELD(IDR3, PBHA,        3, 1);
> +     FIELD(IDR3, XNX,         4, 1);
> +     FIELD(IDR3, PPS,         5, 1);
> +     FIELD(IDR3, MPAM,        7, 1);
> +     FIELD(IDR3, FWB,         8, 1);
> +     FIELD(IDR3, STT,         9, 1);
>       FIELD(IDR3, RIL,        10, 1);
>       FIELD(IDR3, BBML,       11, 2);
> +     FIELD(IDR3, E0PD,       13, 1);
> +     FIELD(IDR3, PTWNNC,     14, 1);
> +     FIELD(IDR3, DPT,        15, 1);
> +
>  REG32(IDR4,                0x10)
> +
>  REG32(IDR5,                0x14)
>       FIELD(IDR5, OAS,         0, 3);
>       FIELD(IDR5, GRAN4K,      4, 1);
>       FIELD(IDR5, GRAN16K,     5, 1);
>       FIELD(IDR5, GRAN64K,     6, 1);
> +     FIELD(IDR5, VAX,        10, 2);
> +     FIELD(IDR5, STALL_MAX,  16, 16);
>  
>  #define SMMU_IDR5_OAS 4
>  
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


