Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 290EC7D2ABB
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 08:53:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quon4-0006Vi-JX; Mon, 23 Oct 2023 02:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1quomy-0006V8-Dq
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 02:51:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1quoms-00029f-Qf
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 02:51:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698043902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4mk0QCEp1CbfpDh68BQvC6AMgeDN94yJ1McQNsWxgkc=;
 b=aXGm01E1gC8ocJvirvxUcHFRlVA//KXDMbhjptq/2XyjtyI0V5YCH1rwH++Dt0OlsHZBBG
 XclnjxE0QnrDSEMm1VVhRFQ4dBvuMUAcszXMedRKmzqSWda97W5udI2wX73pDIx5PHKE8c
 Ik1P1/BPAmdO2QQ2yxt2p8CCkiJ+cAU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-c94Y2dMKPsq6vXXSn-8flQ-1; Mon, 23 Oct 2023 02:51:39 -0400
X-MC-Unique: c94Y2dMKPsq6vXXSn-8flQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-99bca0b9234so163271966b.2
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 23:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698043898; x=1698648698;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4mk0QCEp1CbfpDh68BQvC6AMgeDN94yJ1McQNsWxgkc=;
 b=LbAK2HcFINSrXOFhA74LMOcKXUwxvSOwpSzq3J62d5B1AhnSFywfk/4MexDQ3zl7Fg
 r+JYKN8sHfNLNS8LF97fDvD3pIsdqSQIDx7gP+eu7PTyMSV6L5KS7BA5HOEmnhFQ0PRS
 6qC8RyEVeXtlO6z63HwnU6fk2chmpYNIrj1o/ZYpA9oY30nK91F0fLtiuG4m2Q2BSJwR
 wOeggC3Rma1IAEYpcIfuMTZ86SRsWJPzR0exqoOZiw5eo9c9GS/rTirvDSegYRIESM5n
 kp1GME692GQGG1TG5vgs8N/lMOASPwS1X4e0fapUWjvbmdJQbZFd4oejbqidd54hANQs
 eyvw==
X-Gm-Message-State: AOJu0YzwhlENo1blzu6kDSqYc+Sh28vSmX2g/g8xBZ/SnKrfsEgcKNHR
 kj/PaElVAZCMujsrSiOn1gg7l8n4sz4AS3WJMq/bcL01r2DJ9fxCt7yswfOrM4ZkCsZQkIUQzGm
 in6dn688/fwRmUv4=
X-Received: by 2002:a17:906:c146:b0:9b2:89ec:d701 with SMTP id
 dp6-20020a170906c14600b009b289ecd701mr7068346ejc.27.1698043898703; 
 Sun, 22 Oct 2023 23:51:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmBYnPxY7Ylv36BWDUZ5o1tu1aRv1vYnuTGY7O0JhEW+TZohSf7d4c+YwIhicCwuIP4y4N0A==
X-Received: by 2002:a17:906:c146:b0:9b2:89ec:d701 with SMTP id
 dp6-20020a170906c14600b009b289ecd701mr7068336ejc.27.1698043898431; 
 Sun, 22 Oct 2023 23:51:38 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-141.web.vodafone.de.
 [109.43.176.141]) by smtp.gmail.com with ESMTPSA id
 17-20020a17090602d100b009b2ca104988sm6106870ejk.98.2023.10.22.23.51.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Oct 2023 23:51:37 -0700 (PDT)
Message-ID: <567d1dbf-8b4b-4447-b6ab-c6125ef9daff@redhat.com>
Date: Mon, 23 Oct 2023 08:51:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/10] hw/fsi: Added qtest
Content-Language: en-US
To: Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org, clg@kaod.org, 
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org
References: <20231021211720.3571082-1-ninad@linux.ibm.com>
 <20231021211720.3571082-9-ninad@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20231021211720.3571082-9-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 21/10/2023 23.17, Ninad Palsule wrote:
> Added basic qtests for FSI model.
> 
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
> v3:
>   - Added new qtest as per Cedric's comment.
> V4:
>   - Remove MAINTAINER and documentation changes from this commit
> v6:
>   - Incorporated review comments by Thomas Huth.
> ---
>   tests/qtest/fsi-test.c  | 207 ++++++++++++++++++++++++++++++++++++++++
>   tests/qtest/meson.build |   1 +
>   2 files changed, 208 insertions(+)
>   create mode 100644 tests/qtest/fsi-test.c
> 
> diff --git a/tests/qtest/fsi-test.c b/tests/qtest/fsi-test.c
> new file mode 100644
> index 0000000000..01a0739092
> --- /dev/null
> +++ b/tests/qtest/fsi-test.c
> @@ -0,0 +1,207 @@
> +/*
> + * QTest testcases for IBM's Flexible Service Interface (FSI)
> + *
> + * Copyright (c) 2023 IBM Corporation
> + *
> + * Authors:
> + *   Ninad Palsule <ninad@linux.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include <glib/gstdio.h>
> +
> +#include "qemu/module.h"
> +#include "libqtest-single.h"
> +
> +/* Registers from ast2600 specifications */
> +#define ASPEED_FSI_ENGINER_TRIGGER   0x04
> +#define ASPEED_FSI_OPB0_BUS_SELECT   0x10
> +#define ASPEED_FSI_OPB1_BUS_SELECT   0x28
> +#define ASPEED_FSI_OPB0_RW_DIRECTION 0x14
> +#define ASPEED_FSI_OPB1_RW_DIRECTION 0x2c
> +#define ASPEED_FSI_OPB0_XFER_SIZE    0x18
> +#define ASPEED_FSI_OPB1_XFER_SIZE    0x30
> +#define ASPEED_FSI_OPB0_BUS_ADDR     0x1c
> +#define ASPEED_FSI_OPB1_BUS_ADDR     0x34
> +#define ASPEED_FSI_INTRRUPT_CLEAR    0x40
> +#define ASPEED_FSI_INTRRUPT_STATUS   0x48
> +#define ASPEED_FSI_OPB0_BUS_STATUS   0x80
> +#define ASPEED_FSI_OPB1_BUS_STATUS   0x8c
> +#define ASPEED_FSI_OPB0_READ_DATA    0x84
> +#define ASPEED_FSI_OPB1_READ_DATA    0x90
> +
> +/*
> + * FSI Base addresses from the ast2600 specifications.
> + */
> +#define AST2600_OPB_FSI0_BASE_ADDR 0x1e79b000
> +#define AST2600_OPB_FSI1_BASE_ADDR 0x1e79b100
> +
> +static uint32_t aspeed_fsi_base_addr;
> +
> +static uint32_t aspeed_fsi_readl(QTestState *s, uint32_t reg)
> +{
> +    return qtest_readl(s, aspeed_fsi_base_addr + reg);
> +}
> +
> +static void aspeed_fsi_writel(QTestState *s, uint32_t reg, uint32_t val)
> +{
> +    qtest_writel(s, aspeed_fsi_base_addr + reg, val);
> +}
> +
> +/* Setup base address and select register */
> +static void test_fsi_setup(QTestState *s, uint32_t base_addr)
> +{
> +    uint32_t curval;
> +
> +    /* Set the base select register */
> +    if (base_addr == AST2600_OPB_FSI0_BASE_ADDR) {
> +        aspeed_fsi_base_addr = base_addr;
> +
> +        /* Unselect FSI1 */
> +        aspeed_fsi_writel(s, ASPEED_FSI_OPB1_BUS_SELECT, 0x0);
> +        curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB1_BUS_SELECT);
> +        g_assert_cmpuint(curval, ==, 0x0);
> +
> +        /* Select FSI0 */
> +        aspeed_fsi_writel(s, ASPEED_FSI_OPB0_BUS_SELECT, 0x1);
> +        curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB0_BUS_SELECT);
> +        g_assert_cmpuint(curval, ==, 0x1);
> +    } else if (base_addr == AST2600_OPB_FSI1_BASE_ADDR) {
> +        aspeed_fsi_base_addr = base_addr;

You could move "aspeed_fsi_base_addr = base_addr" before the if-statement, 
so that you don't have to repeat it in both cases.

> +        /* Unselect FSI0 */
> +        aspeed_fsi_writel(s, ASPEED_FSI_OPB0_BUS_SELECT, 0x0);
> +        curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB0_BUS_SELECT);
> +        g_assert_cmpuint(curval, ==, 0x0);
> +
> +        /* Select FSI1 */
> +        aspeed_fsi_writel(s, ASPEED_FSI_OPB1_BUS_SELECT, 0x1);
> +        curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB1_BUS_SELECT);
> +        g_assert_cmpuint(curval, ==, 0x1);
> +    } else {
> +        g_assert_not_reached();
> +    }
> +}

Anyway:
Acked-by: Thomas Huth <thuth@redhat.com>


