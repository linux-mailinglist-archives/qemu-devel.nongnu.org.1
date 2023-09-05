Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5A279212A
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 10:50:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdRkH-0008KZ-GJ; Tue, 05 Sep 2023 04:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdRk5-0008JC-4s
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 04:49:02 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdRk2-0005Q3-GW
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 04:49:00 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4018af103bcso14412795e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 01:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693903736; x=1694508536; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4gvuu+n42szEBpyOL3PLFtjXB9ZXWCf1x5xn2iFhGvI=;
 b=OeBcS/po8tfaWsat1bPkFM1tjFRWl4vvS31R7kFA+HXOegEj2l4sf54brAbYmEiz2R
 RoHzAsErxYqoJk0c/oWR/TPx9mit8ypQVyg+rS44VdBe3ExI8OYFuFkK0KHHZzrOWrNc
 wliQ7FPti0WeVqIeqsP3OHq9bMoVA3A1SHXAIN5LhpNYHXOc3MvPPwiLbYGSZMZjySDp
 C2cEabQc4huRsoBeU7bK+/hl3GYXbPPL42O1K2VHH3rG8UvRQefj28E5zfMgERMnlADS
 KOdg5m9NiSr5Ng8K2Bx/w9QNvCePE36+pLBQTbHgsc8IY0gkjiqiIqCr9SRbkmNeiRDt
 Ocbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693903736; x=1694508536;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4gvuu+n42szEBpyOL3PLFtjXB9ZXWCf1x5xn2iFhGvI=;
 b=LcmtkWPOS0n0WIz6VG1W/WgNIUyYHSXuGiSL15DyzFecqaCgeovGE20Svjx5EiDrdQ
 rMupUTRTlPIxrAu9duMFjxdb5U/FuTooE9euZBdJpac5/B2wPfbEkPm4ZEibb6yP15aN
 m38Po/QMcFa6d52/Ovl8boAls3AmUY7HfixnJsTF6bTyqOukOTGAGGhYrsNYlwGo/D0e
 txmzk7x2sxiea4LiPLwMfZtXEDVT/We5reVcFxK46PbDw2HIU9AxGO/0cd45RV3N2UPj
 oFA4JzRZezW43CVltnYkwGgOxVciv/xsHDmUYdKWHirEmBxEbw1d+tQZq7AYhmvxMAIY
 A3dg==
X-Gm-Message-State: AOJu0YxMgOs7SmFGVe+vL+GdOkE8jfvE7D2WHwOBKSCAReeC9u2l8Fgu
 HK+Gm8I+uPImbmEENCCnH1k1tw==
X-Google-Smtp-Source: AGHT+IG2H8+WGOu/SYUEp+7oYi2OkfupVCJKA01NZ7bYZIfOp6mpcNc8N/FmY44RFF2V27J17Wbk2g==
X-Received: by 2002:a05:600c:c6:b0:401:c717:ec6d with SMTP id
 u6-20020a05600c00c600b00401c717ec6dmr12114419wmm.15.1693903736677; 
 Tue, 05 Sep 2023 01:48:56 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-79.dsl.sta.abo.bbox.fr.
 [176.184.47.79]) by smtp.gmail.com with ESMTPSA id
 17-20020a05600c249100b003fbc30825fbsm16127067wms.39.2023.09.05.01.48.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 01:48:56 -0700 (PDT)
Message-ID: <ba7d895f-72d0-8a11-34ad-b5ca75f482bb@linaro.org>
Date: Tue, 5 Sep 2023 10:48:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] hw/pci-bridge/cxl-upstream: Add serial number extended
 capability support
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Michael Tsirkin <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 linux-cxl@vger.kernel.org
Cc: linuxarm@huawei.com
References: <20230904175752.17927-1-Jonathan.Cameron@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230904175752.17927-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Hi Jonathan,

On 4/9/23 19:57, Jonathan Cameron wrote:
> Will be needed so there is a defined serial number for
> information queries via the Switch CCI.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> No ordering dependencies wrt to other CXL patch sets.
> 
> Whilst we 'need' it for the Switch CCI set it is valid without
> it and aligns with existing EP serial number support. Seems sensible
> to upstream this first and reduce my out of tree backlog a little!
> 
>   hw/pci-bridge/cxl_upstream.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
> index 2b9cf0cc97..15c4d84a56 100644
> --- a/hw/pci-bridge/cxl_upstream.c
> +++ b/hw/pci-bridge/cxl_upstream.c
> @@ -14,6 +14,11 @@
>   #include "hw/pci/msi.h"
>   #include "hw/pci/pcie.h"
>   #include "hw/pci/pcie_port.h"
> +/*
> + * Null value of all Fs suggested by IEEE RA guidelines for use of
> + * EU, OUI and CID
> + */
> +#define UI64_NULL (~0ULL)

Already defined in hw/mem/cxl_type3.c, can we move it to some common
CXL header? Or include/qemu/units.h?

>   #define CXL_UPSTREAM_PORT_MSI_NR_VECTOR 2
>   
> @@ -30,6 +35,7 @@ typedef struct CXLUpstreamPort {
>       /*< public >*/
>       CXLComponentState cxl_cstate;
>       DOECap doe_cdat;
> +    uint64_t sn;
>   } CXLUpstreamPort;
>   
>   CXLComponentState *cxl_usp_to_cstate(CXLUpstreamPort *usp)
> @@ -326,8 +332,12 @@ static void cxl_usp_realize(PCIDevice *d, Error **errp)
>       if (rc) {
>           goto err_cap;
>       }
> -
> -    cxl_cstate->dvsec_offset = CXL_UPSTREAM_PORT_DVSEC_OFFSET;
> +    if (usp->sn != UI64_NULL) {
> +        pcie_dev_ser_num_init(d, CXL_UPSTREAM_PORT_DVSEC_OFFSET, usp->sn);
> +        cxl_cstate->dvsec_offset = CXL_UPSTREAM_PORT_DVSEC_OFFSET + 0x0c;

Could it be clearer to have:

diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
@@ -23,2 +23,2 @@
-#define CXL_UPSTREAM_PORT_DVSEC_OFFSET \
-    (CXL_UPSTREAM_PORT_AER_OFFSET + PCI_ERR_SIZEOF)
+#define CXL_UPSTREAM_PORT_DVSEC_OFFSET(offset) \
+    (CXL_UPSTREAM_PORT_AER_OFFSET + PCI_ERR_SIZEOF + offset)

?

> +    } else {
> +        cxl_cstate->dvsec_offset = CXL_UPSTREAM_PORT_DVSEC_OFFSET;
> +    }
>       cxl_cstate->pdev = d;
>       build_dvsecs(cxl_cstate);
>       cxl_component_register_block_init(OBJECT(d), cxl_cstate, TYPE_CXL_USP);
> @@ -366,6 +376,7 @@ static void cxl_usp_exitfn(PCIDevice *d)
>   }
>   
>   static Property cxl_upstream_props[] = {
> +    DEFINE_PROP_UINT64("sn", CXLUpstreamPort, sn, UI64_NULL),
>       DEFINE_PROP_STRING("cdat", CXLUpstreamPort, cxl_cstate.cdat.filename),
>       DEFINE_PROP_END_OF_LIST()
>   };


