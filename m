Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 884767EDD7C
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 10:19:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3YUy-0001zs-M7; Thu, 16 Nov 2023 04:17:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r3YUv-0001zN-7F
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 04:17:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r3YUn-0002Ep-Ru
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 04:17:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700126227;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JMjI2XfaZPZ8aJPRJ2OB+Zq7VaBJBQrbnLsWTaiaZso=;
 b=cX+w2CZdL+KsVhjKwE8dOO0ffnmjx0DpQSaoC3qkMZyZV39StOuy+9kdKobsBky0T64dim
 p2sigo3VN4/rQzMClzAAPoA7mEcdGhv2eFTCGqqdmeIy5xu3qtzpHr+jYkHEUef2bWDkj2
 4fXTuPL+8nUVyasy8j/iMWlMiOxw/bs=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-9FwwjGSoMW2lkHDhFhw2aQ-1; Thu, 16 Nov 2023 04:17:05 -0500
X-MC-Unique: 9FwwjGSoMW2lkHDhFhw2aQ-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-da0cb98f66cso746223276.2
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 01:17:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700126225; x=1700731025;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JMjI2XfaZPZ8aJPRJ2OB+Zq7VaBJBQrbnLsWTaiaZso=;
 b=vPDmV4HHoEwngNzyh3wZmXbx93vwlSMQ1aUx6bg6+DJ5DSbk5NIk0B5IQPaEsyQTel
 OmpAMRCSx1vy4jgr42DE/9bFnd546bd0FiM16gIHQla8BHrgbwedbfn+i5QIRZfmbD2j
 gOyPLE866vNosdauIGF8j5aVOn4ki/fEHECVaH+F7rpkYsM/73t+EqVQ1gXrNkFqolgy
 HWw/KwuWRuUOfK47d6ER6fV4A+B3t49uFtlED5QmZOcXSoUtGfFuGDj+H3j60/UtAd4S
 UUX3Cu0hluegMmLAduze6j5SZ/rprKH7PKWJMPZnA5As/fSzZknx3AUzSHLGrajTjv/h
 UhJg==
X-Gm-Message-State: AOJu0YxYdg+JwtfKx6ijfs00Z2wcqhzsbavoKR0qjmzwKYknpThE+8VQ
 8CDgqN2V01wZgjxpq3C2+wTOSA4m8aOnCP4o/6ppiXFgwv/ygcBDt1/MItesu2JDvGF97eIDszA
 DYuNrOE6sl/daNew=
X-Received: by 2002:a25:4215:0:b0:daf:936f:4547 with SMTP id
 p21-20020a254215000000b00daf936f4547mr11461019yba.19.1700126225371; 
 Thu, 16 Nov 2023 01:17:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQx0/s9WnUaEvefnQxiYuQQs59358SoLrpA+3H2oMXu4YxSiMnzQPA4wjlxH3ouZLUR4dJJg==
X-Received: by 2002:a25:4215:0:b0:daf:936f:4547 with SMTP id
 p21-20020a254215000000b00daf936f4547mr11460994yba.19.1700126225117; 
 Thu, 16 Nov 2023 01:17:05 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 p11-20020ad451cb000000b0066d04196c3dsm1240544qvq.49.2023.11.16.01.17.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 01:17:04 -0800 (PST)
Message-ID: <60f67b6b-a9f8-4bf2-a05a-6edc01c5da7e@redhat.com>
Date: Thu, 16 Nov 2023 10:17:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 19/21] hw/arm: Activate IOMMUFD for virt machines
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-20-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20231114100955.1961974-20-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



On 11/14/23 11:09, Zhenzhong Duan wrote:
> From: Cédric Le Goater <clg@redhat.com>
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 3ada335a24..660f49db49 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -8,6 +8,7 @@ config ARM_VIRT
>      imply TPM_TIS_SYSBUS
>      imply TPM_TIS_I2C
>      imply NVDIMM
> +    imply IOMMUFD
>      select ARM_GIC
>      select ACPI
>      select ARM_SMMUV3
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


