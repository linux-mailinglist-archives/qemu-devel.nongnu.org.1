Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9AB7EBA39
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 00:32:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r32rr-0000yr-65; Tue, 14 Nov 2023 18:30:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1r32rl-0000vY-EV
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 18:30:46 -0500
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1r32rj-0002RJ-Ln
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 18:30:45 -0500
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5849fc56c62so3924009eaf.3
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 15:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700004640; x=1700609440; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nusZZnalu3uTHEFMdiHu0SeIj4vzoTROUNWekYSMfPw=;
 b=PU7XvI/DzBUG1vfIyyAwPgkidb5xHNOx/RroQcz5EnC+Q5gYOOmLpg1npJ9P/j2yio
 D+Eng+LYKUpWzVK27O4lJgu5ym5pBEHgNQA/+3vdpuZlnwz2HqtPd2nAojA17IY6mGxB
 AIhBqV969V9K/567ljt+RGkQiBLAodoSS7Q7B/vCUMt3eNYunRqqouSqYxtQe3/LOMg0
 +y8NMlQHUfRwFFZkSHr0JwBbVT6a2j/RbFlGG7v80UFzSKCOiCzGgpL4DiNmTyTsWubM
 2Mm8aR9rbx7uHafCzz95HE8kc1UUeFfBEucQArhXjJtWggDIHfYm47H2RE2dfM5mWB0n
 6wZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700004640; x=1700609440;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nusZZnalu3uTHEFMdiHu0SeIj4vzoTROUNWekYSMfPw=;
 b=UFUuGgyDUnQlJ/UUVE6XkIhknnBo7BzyepRKsGBQWTLaVjUKs8UlcCKlnFBkayCQt/
 3HMlCdMedZx2LRoi1KxMFALUtVOkwqiYuI9dvNA+ViU0Ts9zyiTsNaB4PkewDxULHTha
 Sep+gu5qXMSqm5A7wm6whb0ZDmhkvZ/gu2eKc4/QKuiyD/7grPC44I90R4iXJCDtJajL
 Y9YACBWQ+K1dU3RDGXptoQ5Ugk81oLmqUWzV6R/UF6JzwWh+4LhbFx38S7hX3n5LKQTW
 +ofjqFRXtEos0YqbvBw4yj+YXUTt3AH+bEHuyuXMtIYFAQ6hE3R08x0jEs7uRo3IY8zY
 tuGw==
X-Gm-Message-State: AOJu0YxEjXpPShoSUwK73AP65iPB17pp6zPkL4mLrEDaF+/2eszVIrXv
 Bz1wz7VR2QEnYw36V+/gaw==
X-Google-Smtp-Source: AGHT+IFWXCqDLdbnE0IYFMA5OyxJ72bJKuuApEc/o6R9KiiFspFZkFUZwPtuJQQr8a15ZyU9ww8pyg==
X-Received: by 2002:a05:6820:52:b0:57b:92f2:1f64 with SMTP id
 v18-20020a056820005200b0057b92f21f64mr11934174oob.8.1700004640458; 
 Tue, 14 Nov 2023 15:30:40 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id
 e142-20020a4a5594000000b0057e7c1118b9sm453904oob.31.2023.11.14.15.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 15:30:40 -0800 (PST)
Received: from mail.minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:f934:97c6:154a:1c20])
 by serve.minyard.net (Postfix) with ESMTPSA id 2E2C0180053;
 Tue, 14 Nov 2023 23:30:39 +0000 (UTC)
Date: Tue, 14 Nov 2023 17:30:38 -0600
From: Corey Minyard <minyard@acm.org>
To: Potin Lai <potin.lai.pt@gmail.com>
Cc: Patrick Venture <venture@google.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/1] hw/i2c: add pca9543 i2c-mux switch
Message-ID: <ZVQDHlS7TgZpXms8@mail.minyard.net>
References: <20231113063156.2264941-1-potin.lai.pt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113063156.2264941-1-potin.lai.pt@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=tcminyard@gmail.com; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: minyard@acm.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Nov 13, 2023 at 02:31:56PM +0800, Potin Lai wrote:
> Add pca9543 2-channel i2c-mux switch support.
> 
> Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>

Looks good to me.

Acked-by: Corey Minyard <cminyard@mvista.com>

> ---
>  hw/i2c/i2c_mux_pca954x.c         | 12 ++++++++++++
>  include/hw/i2c/i2c_mux_pca954x.h |  1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/hw/i2c/i2c_mux_pca954x.c b/hw/i2c/i2c_mux_pca954x.c
> index db5db956a6..6aace0fc47 100644
> --- a/hw/i2c/i2c_mux_pca954x.c
> +++ b/hw/i2c/i2c_mux_pca954x.c
> @@ -30,6 +30,7 @@
>  
>  #define PCA9548_CHANNEL_COUNT 8
>  #define PCA9546_CHANNEL_COUNT 4
> +#define PCA9543_CHANNEL_COUNT 2
>  
>  /*
>   * struct Pca954xState - The pca954x state object.
> @@ -172,6 +173,12 @@ I2CBus *pca954x_i2c_get_bus(I2CSlave *mux, uint8_t channel)
>      return pca954x->bus[channel];
>  }
>  
> +static void pca9543_class_init(ObjectClass *klass, void *data)
> +{
> +    Pca954xClass *s = PCA954X_CLASS(klass);
> +    s->nchans = PCA9543_CHANNEL_COUNT;
> +}
> +
>  static void pca9546_class_init(ObjectClass *klass, void *data)
>  {
>      Pca954xClass *s = PCA954X_CLASS(klass);
> @@ -246,6 +253,11 @@ static const TypeInfo pca954x_info[] = {
>          .class_init    = pca954x_class_init,
>          .abstract      = true,
>      },
> +    {
> +        .name          = TYPE_PCA9543,
> +        .parent        = TYPE_PCA954X,
> +        .class_init    = pca9543_class_init,
> +    },
>      {
>          .name          = TYPE_PCA9546,
>          .parent        = TYPE_PCA954X,
> diff --git a/include/hw/i2c/i2c_mux_pca954x.h b/include/hw/i2c/i2c_mux_pca954x.h
> index 3dd25ec983..1da5508ed5 100644
> --- a/include/hw/i2c/i2c_mux_pca954x.h
> +++ b/include/hw/i2c/i2c_mux_pca954x.h
> @@ -3,6 +3,7 @@
>  
>  #include "hw/i2c/i2c.h"
>  
> +#define TYPE_PCA9543 "pca9543"
>  #define TYPE_PCA9546 "pca9546"
>  #define TYPE_PCA9548 "pca9548"
>  
> -- 
> 2.31.1
> 
> 

