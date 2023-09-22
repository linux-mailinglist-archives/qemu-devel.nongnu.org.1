Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD517AAFC5
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 12:42:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjdbt-0003lX-9y; Fri, 22 Sep 2023 06:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1qjdbo-0003ks-Kj
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 06:42:04 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1qjdbl-0001uq-AH
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 06:42:04 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-405459d9a96so585e9.0
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 03:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695379319; x=1695984119; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gbwKIMAQY843T2eDSSWgLUtteW4wUp4xBFENdl0MFcI=;
 b=gASbfIRrJu6xFcQGaFykPdFPi4AvyPC8W+C1M//nmnrbqUDmt9RMzzxIWKf4+38dt+
 1m6YSXeT5eu+0Gi9onMGERVaBFNCtyDZDocK/R3Z3FBXlsWec6dheKOm4F2MNc8IH1Gb
 PvYCuv6y+9zu8EaW1OuFm+RhhGoYRdQRydvrixDPlWc3wNGvjUphEN+JYzPvj0tuzPZL
 GXPfHspqtMbW8yv9y5QlXUFaBEJdixjb6a9SueJVzE6Qvnzj0w0WQGW611Svz+yVorcl
 oTobIOdrZ8XmvVUpBIygw32MGtog8FuuyzD2qqU43GoSOFWOV8H0e4J0Q8MTwSaYfeaN
 37+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695379319; x=1695984119;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gbwKIMAQY843T2eDSSWgLUtteW4wUp4xBFENdl0MFcI=;
 b=XrNEugooUAeacSpBGc6qkDL2qJScG62nn7BTQht1UMEqtfFC1DQWIyO+b6+VElf2u2
 YSISIDm5Ifhaqy0euGFM19aGBK9VU2d4APu8iKsM+y58sfVzNzaqyNKSth4eM15jNPt6
 wjxmPZewB4yDO9vJW/wtpSLLtiKNqJg1DHgaLvnY5y6PAzgCsis+RHIj5WHKTsEWRwYO
 SxGdfRtRT3AjJc2/8WvA3TDgC25mBj9Rj4tG37ZDWQ+cy/nonBqteInVlZ0pj4ieMsit
 lccgLZBqnh2dL26PoNnF79/odT6ZYjao6M531YfP6d91YLMUhu4FcQb+tVxQ7vSK8Q9P
 ROnw==
X-Gm-Message-State: AOJu0Yx3o0QHCY7VAw9cj5wNM0hZ/qb96q0Uol27jR7A5tiWbZ32YSte
 8wR9g44PHF4SdbghOq2bbsdNzw==
X-Google-Smtp-Source: AGHT+IFEmHFbHFPmdYR32j2cBD1FiEYiZzaZhESCgQEmg/wfY2MO+1AFDdiDGp7KoIkZmLrleFOxlw==
X-Received: by 2002:a1c:6a08:0:b0:3f6:f4b:d4a6 with SMTP id
 f8-20020a1c6a08000000b003f60f4bd4a6mr38078wmc.7.1695379318985; 
 Fri, 22 Sep 2023 03:41:58 -0700 (PDT)
Received: from google.com (203.75.199.104.bc.googleusercontent.com.
 [104.199.75.203]) by smtp.gmail.com with ESMTPSA id
 p14-20020adfe60e000000b003197b85bad2sm4140418wrm.79.2023.09.22.03.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 03:41:58 -0700 (PDT)
Date: Fri, 22 Sep 2023 10:41:54 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 0/3] hw/arm/smmuv3: Advertise SMMUv3.1-XNX
Message-ID: <ZQ1vctP8rVPLY966@google.com>
References: <20230914145705.1648377-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914145705.1648377-1-peter.maydell@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=smostafa@google.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

Hi Peter,

On Thu, Sep 14, 2023 at 03:57:02PM +0100, Peter Maydell wrote:
> The SMMUv3.1-XNX feature is mandatory for an SMMUv3.1 if S2P is
> supported, so we should theoretically have implemented it as part of
> the recent S2P work.  Fortunately, for us the implementation is a
> no-op.
Oh, I missed that, thanks for spotting it.

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
> 
> These two things together mean that for our implementation, it never
> has to deal with transactions with the INST attribute, and so it can
> correctly ignore the XN bits entirely.  So we already implement
> FEAT_XNX's "XN field is now 2 bits, not 1" behaviour to the extent
> that we need to.
> 
> Patches 1 and 2 in this series do a little bit of tidy up
> on the ID register bit code. Patch 3 is the one-liner to
> advertise SMMUv3.1-XNX in the ID register.
> 
> thanks
> -- PMM
> 
> Peter Maydell (3):
>   hw/arm/smmuv3: Update ID register bit field definitions
>   hw/arm/smmuv3: Sort ID register setting into field order
>   hw/arm/smmuv3: Advertise SMMUv3.1-XNX feature
> 
>  hw/arm/smmuv3-internal.h | 38 ++++++++++++++++++++++++++++++++++++++
>  hw/arm/smmuv3.c          |  5 +++--
>  2 files changed, 41 insertions(+), 2 deletions(-)
> 
> -- 
> 2.34.1

I left a comment/question on the last patch, otherwise

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa


