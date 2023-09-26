Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FDB7AEFBD
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 17:31:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlA0W-0006yN-CX; Tue, 26 Sep 2023 11:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qlA0U-0006yB-Jw
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:29:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qlA0T-0000aN-1U
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695742188;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h3FpuoAVjtgmfR0gVBEUMoD+Y244oU+eFd2lNOx6WV4=;
 b=K9k1H8Id/CWi1x5TQwHEYinb+t0HWpS7IHsRetb5yvrpn6trlK7GCUg+liEETjBsSkr0Se
 xZNdqU2SY8lEd1YYbSVrV4aOgLpCt94UWYWmhkTLAKhrUvlhVHJWI5q32EGPmAwZwowtri
 vNYJGyUqsFn8LK262FCzzY+IcVtWJ3E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-i4vWFoNEPROxziMxTdSBPg-1; Tue, 26 Sep 2023 11:29:46 -0400
X-MC-Unique: i4vWFoNEPROxziMxTdSBPg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4052d1b19f8so81602915e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 08:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695742183; x=1696346983;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h3FpuoAVjtgmfR0gVBEUMoD+Y244oU+eFd2lNOx6WV4=;
 b=GjGnpQX2Tb3CLUBsYIdMcBo0b3dnG74LWemQ31AfUEPtsNM3TCJjAiYxIbCwykIGBj
 XeNLZuhXGhhV53n0Gkpfg7RytG/cJi0sTDpnt1t9v04ZwoMhUC1zxVFSiil5DBnuiJcv
 wkKiOBRAwxMe9KlwO4K1+j+U6mKaj9Ep/FY5AriU3c+zzLQ83ajMlYqdhUx1kSPsfTcb
 oOHbeWjoXOx8CyglE6LzMtz9rjCfAq8wIVP9mzeyAy1RTFutCECXdJ3Ho+DkJLOYVEoH
 I1zkdIExNvzTn+zlN5pBiospBPfJHHWOq6n4Igr4f7DYFsDAkZq+2K89Cq1zbj3/2XuN
 ejJA==
X-Gm-Message-State: AOJu0YxSHmQRcEQJfB+HHpMQWjmyE/7sFx59Bquk4cZv5GIKQ/lPIiDm
 wvj713I1jJoPH2YpCZcXK1UT8VawNIMvV5+xjjyNDoaoKXqh1PmorG3Z0uhfB1pvuq4wjjv3UUv
 kanEiSDtu9CIzGeUnNzCFISw=
X-Received: by 2002:a1c:7718:0:b0:401:519:d2 with SMTP id
 t24-20020a1c7718000000b00401051900d2mr9129646wmi.23.1695742183698; 
 Tue, 26 Sep 2023 08:29:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUVOQ0dXuEwEmmODIqqrLJFRkeU/bXjbNJZ1BVF54PsFtKlxYPFvtAHviG/oyjGn8KvJSeDQ==
X-Received: by 2002:a1c:7718:0:b0:401:519:d2 with SMTP id
 t24-20020a1c7718000000b00401051900d2mr9129635wmi.23.1695742183357; 
 Tue, 26 Sep 2023 08:29:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 c2-20020adfe702000000b003217c096c1esm14914913wrm.73.2023.09.26.08.29.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Sep 2023 08:29:42 -0700 (PDT)
Message-ID: <5c5ca6f8-18f8-b721-eee2-d1977210906a@redhat.com>
Date: Tue, 26 Sep 2023 17:29:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] hw/arm/smmuv3: Sort ID register setting into field
 order
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Mostafa Saleh <smostafa@google.com>
References: <20230914145705.1648377-1-peter.maydell@linaro.org>
 <20230914145705.1648377-3-peter.maydell@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230914145705.1648377-3-peter.maydell@linaro.org>
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
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 9/14/23 16:57, Peter Maydell wrote:
> In smmuv3_init_regs() when we set the various bits in the ID
> registers, we do this almost in order of the fields in the
> registers, but not quite. Move the initialization of
> SMMU_IDR3.RIL and SMMU_IDR5.OAS into their correct places.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/smmuv3.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 1e9be8e89af..94d388fc950 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -278,15 +278,15 @@ static void smmuv3_init_regs(SMMUv3State *s)
>      s->idr[1] = FIELD_DP32(s->idr[1], IDR1, EVENTQS, SMMU_EVENTQS);
>      s->idr[1] = FIELD_DP32(s->idr[1], IDR1, CMDQS,   SMMU_CMDQS);
>  
> -    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
>      s->idr[3] = FIELD_DP32(s->idr[3], IDR3, HAD, 1);
> +    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
>      s->idr[3] = FIELD_DP32(s->idr[3], IDR3, BBML, 2);
>  
> +    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS); /* 44 bits */
>      /* 4K, 16K and 64K granule support */
>      s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, 1);
>      s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, 1);
>      s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN64K, 1);
> -    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS); /* 44 bits */
>  
>      s->cmdq.base = deposit64(s->cmdq.base, 0, 5, SMMU_CMDQS);
>      s->cmdq.prod = 0;
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


