Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA9E7A0F5E
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:58:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgtOK-0007Wj-Nb; Thu, 14 Sep 2023 16:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1qgtOI-0007Vu-Ls; Thu, 14 Sep 2023 16:56:46 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1qgtOG-0001nZ-Vg; Thu, 14 Sep 2023 16:56:46 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3acac5d0b91so633957b6e.0; 
 Thu, 14 Sep 2023 13:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694725002; x=1695329802; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yH///efoKwzBbqbqbKoqlNogfct5RTcSS36xjQi8MoA=;
 b=jKXh6q0F3L2sTcZfisU28b4NZaDxRoD+CMmWTUnPH7IWT1QfScfjJodLvarIxdOgXe
 JsBZSYivljKY6mqNUt2FD4djzwYSVmH2GACI46N0VrLk6J0ZlP9xtJQYF8aWcNA9Wyn/
 1m89FXWoZRiRcXy3t5ctLDkV+9w9Wp1yIg5sOtwdMX3Rm4whJOo7o0JqJm54AtrLCI4o
 HmINZmCvE59+rbynsxe9LLNset89wYXGCabDR2cbBuJOmY1QJ+s36F9r6NYijNd6o9hG
 mlP0IkyxXuJdfnm0jDiJvXJnKBzuRs3NRajyNvO/FQq03BqLXmIA0dvEmDcQ6/w+q9vx
 5ckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694725002; x=1695329802;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yH///efoKwzBbqbqbKoqlNogfct5RTcSS36xjQi8MoA=;
 b=WiIt3H0+D8bEO6EticrA1kwr5XZr0VhRnO5stH8vorR4BcpW/qHnW/uh8QoOZc/2pr
 yg359jI+2Vazw7wQe/rNWJP+vAEz5t/3rqSXz1ALTPLePs22deBaH+hXclUSm3LK8Ktz
 XaKl8ydlVvQULPlZ83+bvxOOcJy/TmGMbyY7VlpSyE66x9TMVF+WHS/bsyA5ICly80lq
 nKLUxRVRfEH/b7Cne/NSBxhUQZCTftfZAT7rtj+ll8BXH3kjM8RclZL0CIpuzEDOhbXA
 b/WuYE7jq10aPUw1xR+Z1sllareiZVe1IiwPMX2ULAfPr59VNrfRPx0jTiBRXtxoCeDK
 XyPQ==
X-Gm-Message-State: AOJu0Yzn+NiBTn6PavpIXT8mwbzQ+O8VdRDViwcS2mSNkKfMiXBJXsAV
 aGtFB02KSZxqnvGkfxiHxQ==
X-Google-Smtp-Source: AGHT+IFr1Ew0S7O3Qaj/lqtQY/yH93GtnMOhrXGXCtqd2ocHwjLsy2hc4v7BcHu8LpfBUBGxsGmSDw==
X-Received: by 2002:a05:6808:d5:b0:3a8:ccf0:1a6d with SMTP id
 t21-20020a05680800d500b003a8ccf01a6dmr6768163oic.52.1694725002497; 
 Thu, 14 Sep 2023 13:56:42 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id
 fa12-20020a0568082a4c00b003a4243d034dsm977047oib.17.2023.09.14.13.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:56:41 -0700 (PDT)
Received: from mail.minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:82e2:1f7b:b4e5:7826])
 by serve.minyard.net (Postfix) with ESMTPSA id E4678180108;
 Thu, 14 Sep 2023 20:56:40 +0000 (UTC)
Date: Thu, 14 Sep 2023 15:56:39 -0500
From: Corey Minyard <minyard@acm.org>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Corey Minyard <cminyard@mvista.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Lior Weintraub <liorw@pliops.com>, Jeremy Kerr <jk@codeconstruct.com.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Peter Delevoryas <peter@pjd.dev>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v6 1/3] hw/i2c: add smbus pec utility function
Message-ID: <ZQNzh6vL1HtTARMj@mail.minyard.net>
References: <20230914-nmi-i2c-v6-0-11bbb4f74d18@samsung.com>
 <20230914-nmi-i2c-v6-1-11bbb4f74d18@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914-nmi-i2c-v6-1-11bbb4f74d18@samsung.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=tcminyard@gmail.com; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: minyard@acm.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Sep 14, 2023 at 11:53:41AM +0200, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Add i2c_smbus_pec() to calculate the SMBus Packet Error Code for a
> message.

Seems fine.

Acked-by: Corey Minyard <cminyard@mvista.com>

> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/i2c/smbus_master.c         | 26 ++++++++++++++++++++++++++
>  include/hw/i2c/smbus_master.h |  2 ++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/hw/i2c/smbus_master.c b/hw/i2c/smbus_master.c
> index 6a53c34e70b7..01a8e4700222 100644
> --- a/hw/i2c/smbus_master.c
> +++ b/hw/i2c/smbus_master.c
> @@ -15,6 +15,32 @@
>  #include "hw/i2c/i2c.h"
>  #include "hw/i2c/smbus_master.h"
>  
> +static uint8_t crc8(uint16_t data)
> +{
> +    int i;
> +
> +    for (i = 0; i < 8; i++) {
> +        if (data & 0x8000) {
> +            data ^= 0x1070U << 3;
> +        }
> +
> +        data <<= 1;
> +    }
> +
> +    return (uint8_t)(data >> 8);
> +}
> +
> +uint8_t i2c_smbus_pec(uint8_t crc, uint8_t *buf, size_t len)
> +{
> +    int i;
> +
> +    for (i = 0; i < len; i++) {
> +        crc = crc8((crc ^ buf[i]) << 8);
> +    }
> +
> +    return crc;
> +}
> +
>  /* Master device commands.  */
>  int smbus_quick_command(I2CBus *bus, uint8_t addr, int read)
>  {
> diff --git a/include/hw/i2c/smbus_master.h b/include/hw/i2c/smbus_master.h
> index bb13bc423c22..d90f81767d86 100644
> --- a/include/hw/i2c/smbus_master.h
> +++ b/include/hw/i2c/smbus_master.h
> @@ -27,6 +27,8 @@
>  
>  #include "hw/i2c/i2c.h"
>  
> +uint8_t i2c_smbus_pec(uint8_t crc, uint8_t *buf, size_t len);
> +
>  /* Master device commands.  */
>  int smbus_quick_command(I2CBus *bus, uint8_t addr, int read);
>  int smbus_receive_byte(I2CBus *bus, uint8_t addr);
> 
> -- 
> 2.42.0
> 
> 

