Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2527724578
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:15:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6XSY-0007XX-6i; Tue, 06 Jun 2023 10:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1q6XST-0007Hh-Pn; Tue, 06 Jun 2023 10:14:50 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1q6XSR-0005sp-I0; Tue, 06 Jun 2023 10:14:49 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-652a6cf1918so2949274b3a.1; 
 Tue, 06 Jun 2023 07:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686060885; x=1688652885;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=AF0DE35EXWoB5BCT6rqWQlzUTLp4ju7AwY7YckLvqzE=;
 b=psQUmJZvMBUaV8ZOmPkgXHdS2jXpbzx42apISFtHj/m17fFu9kJ2jS7hdeGUiqtXI+
 KJnMSMjILK/baXSdiylfy83rnzRDOqJz0AKWIDNTkbpp9cF+rROO7XCb0xXbcghpceey
 FxOYs97K8yHVdVTp0TnfzN/3b5KQlLw/DAbZ+RlKLt61RD5pw0lWCZXDiYlPQ9CrhXpX
 zMxAims9gohIKGHKjfxIMddGjPjqDp07xryIpHA4AKzbAgZOSghBTh4I4b109Jnc+9cg
 qwo7ctWPIl76XkNOIPQT64JXCyJPcGhJHXhWaDMQ1h3KwSwioEXRBgOWcYplC7uKrGiF
 zroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686060885; x=1688652885;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AF0DE35EXWoB5BCT6rqWQlzUTLp4ju7AwY7YckLvqzE=;
 b=KQzYE47dfWNvh8nTwZJ/0VU5LCO83uA8DzQlCtfO5nAPW+EX8VpxSplnRjdmz0z1W1
 DSlHrOFimUvFPgDcxm2mO2wNg7IMji77SjYgjlslr86T6/asSTTdFJpF/ZxLpsSTbljU
 fN6U4YsNFK4YS/VXfHe6C+HMtczxlpgeFIQZMtMXZKLR1JXPOCN1/44GJYDGdlPkirH+
 +mGIHOfWMv69Y3mCJEoQQ+EHe3S6XWJkhSLymd0xb0KsaBSuqWhOYajD+IBUstuBlfcj
 A6A/4/2Wxx0ocfJZD0IoR4AyHWR5AG5bMpw+9PIqlJpXWxxO7yu5rxqKXV36z6gEmuZZ
 Wpug==
X-Gm-Message-State: AC+VfDxmwQS6wgj4g4hy/nWlRhvGgOGGBLdJNOtXI94OKqDfKMLmomgl
 LnhoIMSad+prTAH+IH7ruCw=
X-Google-Smtp-Source: ACHHUZ4WVkcZKfwbkhCCaR8eFBmLHqtLLH85ct59G7ruqh3a2xsqC5jsREBTbdfgx15RfdjV9L3OwQ==
X-Received: by 2002:a05:6a21:338b:b0:10e:43e:e223 with SMTP id
 yy11-20020a056a21338b00b0010e043ee223mr1880770pzb.1.1686060884812; 
 Tue, 06 Jun 2023 07:14:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 29-20020a63175d000000b00476d1385265sm7449556pgx.25.2023.06.06.07.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 07:14:44 -0700 (PDT)
Date: Tue, 6 Jun 2023 07:14:42 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH 1/2] hw/intc/allwinner-a10-pic: Handle IRQ levels other
 than 0 or 1
Message-ID: <7234e328-6ff4-4922-8a4c-b55cf3c6c619@roeck-us.net>
References: <20230606104609.3692557-1-peter.maydell@linaro.org>
 <20230606104609.3692557-2-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606104609.3692557-2-peter.maydell@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, Jun 06, 2023 at 11:46:08AM +0100, Peter Maydell wrote:
> In commit 2c5fa0778c3b430 we fixed an endianness bug in the Allwinner
> A10 PIC model; however in the process we introduced a regression.
> This is because the old code was robust against the incoming 'level'
> argument being something other than 0 or 1, whereas the new code was
> not.
> 
> In particular, the allwinner-sdhost code treats its IRQ line
> as 0-vs-non-0 rather than 0-vs-1, so when the SD controller
> set its IRQ line for any reason other than transmit the
> interrupt controller would ignore it. The observed effect
> was a guest timeout when rebooting the guest kernel.
> 
> Handle level values other than 0 or 1, to restore the old
> behaviour.
> 
> Fixes: 2c5fa0778c3b430 ("hw/intc/allwinner-a10-pic: Don't use set_bit()/clear_bit()")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>

Tested on top of 8.0.2, both this patch alone as well as this
patch plus the second patch in the series.

Guenter

> ---
>  hw/intc/allwinner-a10-pic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/intc/allwinner-a10-pic.c b/hw/intc/allwinner-a10-pic.c
> index 4875e68ba6a..d0bf8d545ba 100644
> --- a/hw/intc/allwinner-a10-pic.c
> +++ b/hw/intc/allwinner-a10-pic.c
> @@ -51,7 +51,7 @@ static void aw_a10_pic_set_irq(void *opaque, int irq, int level)
>      AwA10PICState *s = opaque;
>      uint32_t *pending_reg = &s->irq_pending[irq / 32];
>  
> -    *pending_reg = deposit32(*pending_reg, irq % 32, 1, level);
> +    *pending_reg = deposit32(*pending_reg, irq % 32, 1, !!level);
>      aw_a10_pic_update(s);
>  }
>  
> -- 
> 2.34.1
> 

