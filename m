Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFE57C8137
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:59:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrE0H-0005Df-UD; Fri, 13 Oct 2023 04:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrE0D-00059I-RB
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:58:38 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrE0B-0003Bj-3F
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:58:37 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-53e2308198eso2192330a12.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697187513; x=1697792313; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k7DaaiAVT+qCy5XCxx/o4eoTbH9HtGBkhBy38h9uHKM=;
 b=xSWLed6By6hYRDVeTh2ih650n3DnLQW8CqXAKMS+melrteDg8p+U/nzev+ITHR09Do
 1hBdpNwXKVzhpaFBRLvrCdcS0WZOSbIx08sNoqFQWar8qxXMNHshNdYRhdST1aTzGB0h
 9x8QfuOyBn/iquL9Iu88T1wm/eLc7cxvjXXKxzee9zi5TgId/4rgre8+A7NKRlWvR5ZI
 2oyOEoh1CvjVdHV4swZZnBZLRE1m6+RMkS1ibcem+Q9d7UrTIm30p8q2f+YpA9T2Ej7E
 UGbI5hZawH6JOqeNhTDLOpuMLlvMpHx8qgszyGVOqcA4QVtdckApkXeGh8Ah4UGDSKvX
 tAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697187513; x=1697792313;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k7DaaiAVT+qCy5XCxx/o4eoTbH9HtGBkhBy38h9uHKM=;
 b=FSPX41/Fm6Wmz4eyC8a8nQZAf9ywXUfPIY3j8B9OEN4IyUZgeFfLxmUfwPWMDe6zMb
 G1HmVyJuRNTTO+ww8dT4fQgIqGv3QRP6sC3F9klN4+biQ+LFki6X8OxdTR0O1hC84FRD
 qfBj/jBsO7epLbWbBH2M8VVhxTZEAf140cm2aMBrfpd9KAQ+k/CuNSEleI4dzNhaP+Rz
 2OXEZWkGqCyuQuVX2O6wCwuRMnAh1mK/QkEgpvrAvQiYEVqApGSMEcRjwfpYvNxMEIx6
 DgMF3oJF2NR/OfeuI+UsTB4hGwxpi7Y9DkBlcBkwT7TIRSGcxwtUyv8RClqRnGUtvxGQ
 KMpA==
X-Gm-Message-State: AOJu0Yzrdl3aGC4CI5Im4W3qxDbhNg+HvlQP4vZGemUtVw4JEx5lJh8y
 j3NNOjnsGvURcdV8JvYs9OJdNA==
X-Google-Smtp-Source: AGHT+IG9eqsq2IHiJXrcy1IzjOPovJCM9Id2tt/aYWnaswza8pPnfDN13yMNp6xDyHmLauIIgw13ZA==
X-Received: by 2002:aa7:c547:0:b0:530:d8df:afaa with SMTP id
 s7-20020aa7c547000000b00530d8dfafaamr22551808edr.41.1697187512776; 
 Fri, 13 Oct 2023 01:58:32 -0700 (PDT)
Received: from [192.168.69.115] ([176.172.118.168])
 by smtp.gmail.com with ESMTPSA id
 bd19-20020a056402207300b0053e31113ff7sm980386edb.94.2023.10.13.01.58.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 01:58:31 -0700 (PDT)
Message-ID: <31467531-ed8c-507e-1a39-3271fa375e59@linaro.org>
Date: Fri, 13 Oct 2023 10:58:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/2] ppc/pnv: Add an I2C controller model
Content-Language: en-US
To: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com
References: <20231012200851.3020858-1-milesg@linux.vnet.ibm.com>
 <20231012200851.3020858-2-milesg@linux.vnet.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231012200851.3020858-2-milesg@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

Hi Glenn, Cédric,

On 12/10/23 22:08, Glenn Miles wrote:
> From: Cédric Le Goater <clg@kaod.org>
> 
> The more recent IBM power processors have an embedded I2C
> controller that is accessible by software via the XSCOM
> address space.
> 
> Each instance of the I2C controller is capable of controlling
> multiple I2C buses (one at a time).  Prior to beginning a
> transaction on an I2C bus, the bus must be selected by writing
> the port number associated with the bus into the PORT_NUM
> field of the MODE register.  Once an I2C bus is selected,
> the status of the bus can be determined by reading the
> Status and Extended Status registers.
> 
> I2C bus transactions can be started by writing a command to
> the Command register and reading/writing data from/to the
> FIFO register.
> 
> Not supported :
> 
>   . 10 bit I2C addresses
>   . Multimaster
>   . Slave
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> [milesg: Split wiring to powernv9 into its own commit]
> [milesg: Added more detail to commit message]
> [milesg: Added SPDX Licensed Identifier to new files]
> [milesg: updated copyright dates]
> [milesg: Added use of g_autofree]
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> ---
> 
> Changes in v2:
>      - Updated copyright dates
>      - Removed copyright paragraph (replaced by SPDX-License-Identifier)
>      - Added use of g_autofree
> 
>   hw/ppc/meson.build         |   1 +
>   hw/ppc/pnv_i2c.c           | 673 +++++++++++++++++++++++++++++++++++++
>   include/hw/ppc/pnv_i2c.h   |  38 +++
>   include/hw/ppc/pnv_xscom.h |   3 +
>   4 files changed, 715 insertions(+)
>   create mode 100644 hw/ppc/pnv_i2c.c
>   create mode 100644 include/hw/ppc/pnv_i2c.h


> +/* I2C mode register */
> +#define I2C_MODE_REG                    0x6
> +#define I2C_MODE_BIT_RATE_DIV           PPC_BITMASK(0, 15)
> +#define I2C_MODE_PORT_NUM               PPC_BITMASK(16, 21)
> +#define I2C_MODE_ENHANCED               PPC_BIT(28)
> +#define I2C_MODE_DIAGNOSTIC             PPC_BIT(29)
> +#define I2C_MODE_PACING_ALLOW           PPC_BIT(30)
> +#define I2C_MODE_WRAP                   PPC_BIT(31)


> +static I2CBus *pnv_i2c_get_bus(PnvI2C *i2c)
> +{
> +    uint8_t port = GETFIELD(I2C_MODE_PORT_NUM, i2c->regs[I2C_MODE_REG]);
> +
> +    if (port >= i2c->num_busses) {

Can we sanitize in pnv_i2c_xscom_write() instead ...?

> +        qemu_log_mask(LOG_GUEST_ERROR, "I2C: invalid bus number %d/%d\n", port,
> +                      i2c->num_busses);
> +        return NULL;
> +    }
> +    return i2c->busses[port];
> +}


> +static void pnv_i2c_xscom_write(void *opaque, hwaddr addr,
> +                                uint64_t val, unsigned size)
> +{
> +    PnvI2C *i2c = PNV_I2C(opaque);
> +    uint32_t offset = addr >> 3;
> +
> +    switch (offset) {
> +    case I2C_MODE_REG:

... here?

> +        i2c->regs[offset] = val;
> +        if (i2c_bus_busy(pnv_i2c_get_bus(i2c))) {
> +            i2c->regs[I2C_STAT_REG] |= I2C_STAT_INVALID_CMD;
> +            qemu_log_mask(LOG_GUEST_ERROR, "I2C: command in progress\n");
> +        }
> +        break;

[...]

Regards,

Phil.

