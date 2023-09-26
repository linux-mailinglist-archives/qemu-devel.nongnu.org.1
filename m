Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1E37AEFD2
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 17:40:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlA9h-0003VW-R6; Tue, 26 Sep 2023 11:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qlA9f-0003V5-Q0
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:39:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qlA9e-0002wO-8r
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695742757;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ajuvXVOphlmV/SSckwSiXuo4QwYthV5liTFlBAbmoiY=;
 b=PK+4gLe5JZzVEm0Im0ZFP37KWwVbFsKFQGcHIkVVidTSYDfE4FQ+9CgZdk5ZiPK5DFiRzc
 kGwIE3mHDvJSZ4c/ohJG3l42Y9MJnPRjZoxaA+4mAhxryl5WTyAuHTF3FRNtJbOBoFJlZK
 U6hVKXzW4NzE4gDf4m2kgdGah/rVo/k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-yGD2kHWdNqGra_ipT3WbmA-1; Tue, 26 Sep 2023 11:39:16 -0400
X-MC-Unique: yGD2kHWdNqGra_ipT3WbmA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40540179bcdso68573645e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 08:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695742755; x=1696347555;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ajuvXVOphlmV/SSckwSiXuo4QwYthV5liTFlBAbmoiY=;
 b=DQJbgFETJFJuWBRVYtFyS4/jEeYNWiWt5FtnPWrvmc/XkId8pv6UbdWIvk+/G+AMlL
 3H3qggVBLEo2Kjb4day+pQTn2l4fqxDJp8rnty/SF+kxgWcGh1npC1sIQj4eimXzaHnc
 HzqmA+K8mu8AlrM87kNpwzNyySzTpMDRfb4JVq55GjxnFnJ9/MI/N1+McXwNrAOThyju
 XrDx1UgKTVdkPgWoYUUwnXpzsQxtK5c1KYaRH8mv2gRnChnb+iG+L73b40CUHDRHKDKm
 fDvTtXu3ZUNgg7NbYy9uitB3s6Hxroa/qStHFQbBpRgomPnYC89DmcFNPZDSL1c4Y6fH
 SuzA==
X-Gm-Message-State: AOJu0Yz7pijQwONpgeya7tmDyePL6zvjl9dVumImKpXf+NDGag6ijTNg
 UNmn/8Mu+49Rv4ytl4ap0jlHbJ24gi+CecRanEOFWYsVEEBWuM8TlIrJpTfCR5rZKS9a5Vj90Z4
 oxztAQXRURqOf2wM=
X-Received: by 2002:a05:600c:280b:b0:3fb:e2af:49f6 with SMTP id
 m11-20020a05600c280b00b003fbe2af49f6mr8584157wmb.39.1695742755115; 
 Tue, 26 Sep 2023 08:39:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuO9YFNk+kQBwSMFDnYiQlNoVVret/k0zzyDVkksoBSPz3GoWZlfzmNME+VuRbmeUrLl0Z2g==
X-Received: by 2002:a05:600c:280b:b0:3fb:e2af:49f6 with SMTP id
 m11-20020a05600c280b00b003fbe2af49f6mr8584145wmb.39.1695742754811; 
 Tue, 26 Sep 2023 08:39:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 k22-20020a05600c0b5600b003fe601a7d46sm18368605wmr.45.2023.09.26.08.39.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Sep 2023 08:39:13 -0700 (PDT)
Message-ID: <f254b6e5-f02a-5781-570a-2c9688667b36@redhat.com>
Date: Tue, 26 Sep 2023 17:39:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] hw/arm/smmuv3: Advertise SMMUv3.1-XNX feature
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Mostafa Saleh <smostafa@google.com>
References: <20230914145705.1648377-1-peter.maydell@linaro.org>
 <20230914145705.1648377-4-peter.maydell@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230914145705.1648377-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Peter,

On 9/14/23 16:57, Peter Maydell wrote:
> The SMMUv3.1-XNX feature is mandatory for an SMMUv3.1 if S2P is
> supported, so we should theoretically have implemented it as part of
> the recent S2P work.  Fortunately, for us the implementation is a
> no-op.
>
> This feature is about interpretation of the stage 2 page table
> descriptor XN bits, which control execute permissions.
>
> For QEMU, the permission bits passed to an IOMMU (via MemTxAttrs and
> IOMMUAccessFlags) only indicate read and write; we do not distinguish
> data reads from instruction reads outside the CPU proper.  In the
> SMMU architecture's terms, our interconnect between the client device
> and the SMMU doesn't have the ability to convey the INST attribute,
> and we therefore use the default value of "data" for this attribute.
>
> We also do not support the bits in the Stream Table Entry that can
> override the on-the-bus transaction attribute permissions (we do not
> set SMMU_IDR1.ATTR_PERMS_OVR=1).
you may precise it is called INSTCFG
>
> These two things together mean that for our implementation, it never
> has to deal with transactions with the INST attribute, and so it can
> correctly ignore the XN bits entirely.  So we already implement
> FEAT_XNX's "XN field is now 2 bits, not 1" behaviour to the extent
> that we need to.
>
> Advertise the presence of the feature in SMMU_IDR3.XNX.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/smmuv3.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 94d388fc950..d9e639f7c41 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -279,6 +279,7 @@ static void smmuv3_init_regs(SMMUv3State *s)
>      s->idr[1] = FIELD_DP32(s->idr[1], IDR1, CMDQS,   SMMU_CMDQS);
>  
>      s->idr[3] = FIELD_DP32(s->idr[3], IDR3, HAD, 1);
> +    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, XNX, 1);
>      s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
>      s->idr[3] = FIELD_DP32(s->idr[3], IDR3, BBML, 2);
>  
With Mostafa's suggestion
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric


