Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DCE7E64FF
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 09:14:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r109o-000147-FZ; Thu, 09 Nov 2023 03:12:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r109m-00011y-8Q
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 03:12:54 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r109k-0005wa-KD
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 03:12:54 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2c5056059e0so7311851fa.3
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 00:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699517569; x=1700122369; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+XF/9ZrNLOWMXQDZEKKNALeSXTTRCr0/uVaS7tJ+Ras=;
 b=Orj7J4gL3ej4ypN8vCJKmmivSz9y46HmeHzsUaCWvtQH+WyOBMFEhVdly3iqLNgSs1
 HhDFju8lIFY7jN/TTGET3/RLcV/QMnTimMrBtfHHDdu+NtRKbSBRPp2/+q8G/CNspr2T
 ShfWRUAfM+ekY8K42/IiynOE1HLu9xCpSz2Xgkxw4OGk6DA6mfzA/v0dS1HdP3hGsQEt
 KnRYOXLVMI2k0Wv2iRyCXgn+CFU1TXcorbOGZ8dOKBuiNWUbg4a7w1eDakRccFmSCw8D
 YkNXwLo6/k5znzCgrEXMy8m5OGunj1nmoRwedqjwcYjURf+rsHDCcDx2bN9eepYgDV8f
 +gBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699517569; x=1700122369;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+XF/9ZrNLOWMXQDZEKKNALeSXTTRCr0/uVaS7tJ+Ras=;
 b=vvcUw72NCDJI/KVumToN4xhJHqc+YppfHX/FfoABnpTt3QFzjnSo9RNNR5vlOABA+T
 0n63L+ZTm/WAQAtFGkQU7K+iLNsfvUEg1ESpWgTZF1/7ms6L8mWJdS6TXTpiUwczafkA
 6gL6v7b8hpt279BUwQaHvQt7s7hxKyYWS+oBnaVXnsUy9rwPJ43B5m/KEmqB3pDh86ic
 ebzvBMF7N3LIY0RpeNBT5cBAcq+iqngsF1hrQMfk4JFAYcEiPSDI5NaPxDJBiGG9UQsP
 u2xW7dGXPHAkFKiBIq/f3wsQNyLomHerbAI3Y3nOEDHuf+lrIV4RbbVi1k23Y4zPnsxu
 Nb9g==
X-Gm-Message-State: AOJu0YzJi3NVtxfRoLc9Df5N8+SH0E8/RnpaAvfNRgqQFQUB7Nf7gJF8
 97xpqB31oCML1xC2NxXn0jpf9g==
X-Google-Smtp-Source: AGHT+IHNlEXd3avYcZGcf4hTn5AGVhFFyMV9qCS3Ipmsy0OjoMOJT6oOC4ZXWokb6y8JpWZ+GSCV6A==
X-Received: by 2002:a2e:7203:0:b0:2c5:174b:9a53 with SMTP id
 n3-20020a2e7203000000b002c5174b9a53mr3505454ljc.26.1699517569258; 
 Thu, 09 Nov 2023 00:12:49 -0800 (PST)
Received: from [192.168.23.175] (226.red-88-28-2.dynamicip.rima-tde.net.
 [88.28.2.226]) by smtp.gmail.com with ESMTPSA id
 c17-20020a056000105100b0032d829e10c0sm6920475wrx.28.2023.11.09.00.12.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 00:12:48 -0800 (PST)
Message-ID: <64852c52-88cb-4ed1-913e-0b36ff2af7c2@linaro.org>
Date: Thu, 9 Nov 2023 09:12:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc/pnv: Fix potential overflow in I2C model
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.vnet.ibm.com>
References: <20231109080536.1005500-1-clg@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231109080536.1005500-1-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 9/11/23 09:05, Cédric Le Goater wrote:
> Coverity warns that "i2c_bus_busy(i2c->busses[i]) << i" might overflow
> because the expression is evaluated using 32-bit arithmetic and then
> used in a context expecting a uint64_t.
> 
> Fixes: Coverity CID 1523918
> Cc: Glenn Miles <milesg@linux.vnet.ibm.com>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/ppc/pnv_i2c.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
> index f75e59e70977..ab73c59f7704 100644
> --- a/hw/ppc/pnv_i2c.c
> +++ b/hw/ppc/pnv_i2c.c
> @@ -437,7 +437,7 @@ static uint64_t pnv_i2c_xscom_read(void *opaque, hwaddr addr,
>       case I2C_PORT_BUSY_REG: /* compute busy bit for each port  */
>           val = 0;
>           for (i = 0; i < i2c->num_busses; i++) {
> -            val |= i2c_bus_busy(i2c->busses[i]) << i;
> +            val |= (uint64_t) i2c_bus_busy(i2c->busses[i]) << i;

Alternatively:

                val = deposit64(val, i, 1, i2c_bus_busy(i2c->busses[i]));

>           }
>           break;
>   


