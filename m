Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B6880607A
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 22:13:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAcjB-00024j-QT; Tue, 05 Dec 2023 16:13:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1rAcjA-00024S-8M; Tue, 05 Dec 2023 16:13:12 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1rAcj5-0002gF-AT; Tue, 05 Dec 2023 16:13:11 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2c9fbb846b7so35643451fa.2; 
 Tue, 05 Dec 2023 13:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701810783; x=1702415583; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vg6vzoFsNKxfiUEYJ1FNgFnml/SyvhQ4XQv0nwtbyOg=;
 b=UUjC75TBAS4gTDEV33VUvfIfIUhuyE2C+GGOiWkRqr/cNwTKRyaVz+IrxDLQ8eciDl
 6meEiJKEi0TthbJ6v8F4HZzJc9xBiEzH1OO/7na8EwkcUlP5Rv8w1I2kz0luB8MET/XS
 2o592vH1dSn9J4Kx41h+kvBXU4cpBz3CNPw7JgY6nSmpvfpV9BK9eh6fY/rS70GmeAaI
 arto6/qNkXFv/eUmJOXUpVQN9a25Pb+pGZj7N0fO9KW2p8di6aPrqihM0091LCpbmJ/L
 zPhIyfPYNOCbW7qsD4EUHhTQF27kY3GpaijFdeDUG23GZYi0TObcQCXBS1+zTlE0C6OZ
 REzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701810783; x=1702415583;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vg6vzoFsNKxfiUEYJ1FNgFnml/SyvhQ4XQv0nwtbyOg=;
 b=laTF5anze3Q/2NC8XKWvK/GxCWAq+uyzqVRalkACczSdMjUKqrApLxcmeiUsXzCVK9
 cFEziVkCTAFQnvSveYk1wmQiPwN6f6YiPaip0unTGXb5dK6pJjZCrgRg7rwzysz025t6
 kf92voWt1rKwXSPDKzOdNSQX0+SUFSkmQ6GYDynblnM+NbE+EzbjRZ7rAIv9UYOXb8vz
 ka93J++E/YUfaGs6DdgjkWQzIBqoFY2sRRuB5Dzev8EdxKEx63C9bvPyYd5I6dpehS1i
 3FCz+9KIQJL6Vag4Lh08PQ0cjf58zV7UJ44giwIbdbkGkzBQae4m4qZodP/tcgvXvQUG
 o09Q==
X-Gm-Message-State: AOJu0YxKdRj04969NoqGtnEtXgNmyNCpk+tkF/+fjqnwaFeU0TAwneg5
 bSxNPvK4EvzPQW//hTlM2yo=
X-Google-Smtp-Source: AGHT+IFHhs+37duPYj0YL3zb151FtYeqIE+nIi1qjU0V8ZfZTAzA28oA+onq41oLDLxfs6HAtOgx7A==
X-Received: by 2002:a05:6512:e95:b0:50c:d80:85e6 with SMTP id
 bi21-20020a0565120e9500b0050c0d8085e6mr805853lfb.54.1701810783336; 
 Tue, 05 Dec 2023 13:13:03 -0800 (PST)
Received: from fralle-msi (217-76-87-105.cust.bredband2.com. [217.76.87.105])
 by smtp.gmail.com with ESMTPSA id
 f25-20020a193819000000b00507987ff761sm920405lfa.56.2023.12.05.13.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 13:13:02 -0800 (PST)
Date: Tue, 5 Dec 2023 22:13:01 +0100
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, saipavanboddu@gmail.com
Subject: Re: [PATCH 1/2] block: m25p80: Add support of mt35xu02gbba
Message-ID: <20231205211300.GB9927@fralle-msi>
References: <20231205095226.2688032-1-sai.pavan.boddu@amd.com>
 <20231205095226.2688032-2-sai.pavan.boddu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205095226.2688032-2-sai.pavan.boddu@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=frasse.iglesias@gmail.com; helo=mail-lj1-x229.google.com
X-Spam_score_int: -1020
X-Spam_score: -102.1
X-Spam_bar: ---------------------------------------------------
X-Spam_report: (-102.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01, USER_IN_WELCOMELIST=-0.01,
 USER_IN_WHITELIST=-100 autolearn=ham autolearn_force=no
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

On [2023 Dec 05] Tue 15:22:25, Sai Pavan Boddu wrote:
> Add Micro 2Gb OSPI flash part with sfdp data.
> 
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>


> ---
>  hw/block/m25p80_sfdp.h |  1 +
>  hw/block/m25p80.c      |  3 +++
>  hw/block/m25p80_sfdp.c | 36 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+)
> 
> diff --git a/hw/block/m25p80_sfdp.h b/hw/block/m25p80_sfdp.h
> index 011a880f66..1733b56950 100644
> --- a/hw/block/m25p80_sfdp.h
> +++ b/hw/block/m25p80_sfdp.h
> @@ -16,6 +16,7 @@
>  #define M25P80_SFDP_MAX_SIZE  (1 << 24)
>  
>  uint8_t m25p80_sfdp_n25q256a(uint32_t addr);
> +uint8_t m25p80_sfdp_mt35xu02g(uint32_t addr);
>  
>  uint8_t m25p80_sfdp_mx25l25635e(uint32_t addr);
>  uint8_t m25p80_sfdp_mx25l25635f(uint32_t addr);
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index afc3fdf4d6..c8c7f6c1c3 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -267,6 +267,9 @@ static const FlashPartInfo known_devices[] = {
>      { INFO("mt25ql512ab", 0x20ba20, 0x1044, 64 << 10, 1024, ER_4K | ER_32K) },
>      { INFO_STACKED("mt35xu01g", 0x2c5b1b, 0x104100, 128 << 10, 1024,
>                     ER_4K | ER_32K, 2) },
> +    { INFO_STACKED("mt35xu02gbba", 0x2c5b1c, 0x104100, 128 << 10, 2048,
> +                   ER_4K | ER_32K, 4),
> +                   .sfdp_read = m25p80_sfdp_mt35xu02g },
>      { INFO_STACKED("n25q00",    0x20ba21, 0x1000, 64 << 10, 2048, ER_4K, 4) },
>      { INFO_STACKED("n25q00a",   0x20bb21, 0x1000, 64 << 10, 2048, ER_4K, 4) },
>      { INFO_STACKED("mt25ql01g", 0x20ba21, 0x1040, 64 << 10, 2048, ER_4K, 2) },
> diff --git a/hw/block/m25p80_sfdp.c b/hw/block/m25p80_sfdp.c
> index b33811a4f5..6ee2cfaf11 100644
> --- a/hw/block/m25p80_sfdp.c
> +++ b/hw/block/m25p80_sfdp.c
> @@ -57,6 +57,42 @@ static const uint8_t sfdp_n25q256a[] = {
>  };
>  define_sfdp_read(n25q256a);
>  
> +static const uint8_t sfdp_mt35xu02g[] = {
> +    0x53, 0x46, 0x44, 0x50, 0x06, 0x01, 0x01, 0xff,
> +    0x00, 0x06, 0x01, 0x10, 0x30, 0x00, 0x00, 0xff,
> +    0x84, 0x00, 0x01, 0x02, 0x80, 0x00, 0x00, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xe5, 0x20, 0x8a, 0xff, 0xff, 0xff, 0xff, 0x7f,
> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +    0xee, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00,
> +    0xff, 0xff, 0x00, 0x00, 0x0c, 0x20, 0x11, 0xd8,
> +    0x0f, 0x52, 0x00, 0x00, 0x24, 0x5a, 0x99, 0x00,
> +    0x8b, 0x8e, 0x03, 0xe1, 0xac, 0x01, 0x27, 0x38,
> +    0x7a, 0x75, 0x7a, 0x75, 0xfb, 0xbd, 0xd5, 0x5c,
> +    0x00, 0x00, 0x70, 0xff, 0x81, 0xb0, 0x38, 0x36,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0x43, 0x0e, 0xff, 0xff, 0x21, 0xdc, 0x5c, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +};
> +
> +define_sfdp_read(mt35xu02g);
>  
>  /*
>   * Matronix
> -- 
> 2.25.1
> 

