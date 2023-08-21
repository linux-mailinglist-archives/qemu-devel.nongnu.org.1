Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9713278246D
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 09:26:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXzIu-0004JF-0N; Mon, 21 Aug 2023 03:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1qXzIr-0004Il-JI
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:26:21 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1qXzIo-0003GK-Eh
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:26:21 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-4ff8f2630e3so4654560e87.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 00:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692602776; x=1693207576;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zogNEr/18XzUhh6YwZns25ZhpAN+4TxKu4Z9b8aSMHU=;
 b=fGFbrrcTIJNAKapDNrxybhy2ibPN1+b3TDZrkogxVqI+4gnI8EMutwD6ad6tTBer+5
 ZJzmp2uvmMzOVK9sLBKo3LlQWT/j045eTLpl7SrRRsOav4yUyYi4jPSM3rbA8nquqcAr
 ECGCAzYuS3jdgMyq/siXJ1VId5+ocYQrO6kfImxwMp+FCwQ5N9Pj8TAxSZEggvgjy+r7
 t8uswViQ1EhNhntf6eodG2+qVvBHcItHlNXmFM7ilxqywyLPWG326+yPL5stk7t1wj1t
 Dg3DmhoYcdoGiPbX0KXxHfPg6I6qesPCN0vwjtAH7PWl6TT+o9GwGlth0qOmpvLOBVSF
 3Lvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692602776; x=1693207576;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zogNEr/18XzUhh6YwZns25ZhpAN+4TxKu4Z9b8aSMHU=;
 b=JjormFwIV7w4WwZpxrKleZ+PcNPFx8w3TtaNkURxGNcBSmbYMQa57E53pP101Knxv+
 K2OeqmuQ7M+lshPt6ZLvhibUfJ2OINaR9KMZKsg27vbqE8C5a06Np4TOBSLfZ7l9T7je
 bmbQolKu8v7ry7WSEaJne4y66v7+sYKZGXMR5nTLDrvU12sEkB70c+PtgnriwYBDjf6J
 v4IEi2G5nGgrdvwgYjf970tHqOijQdefZdYTO9TOhVjguv2MBp1xur62r5jszL9yRr3T
 RhecwGKqxhiMdgNugSf63xPwQa6iXLHcobtpNHLFWk8saLZ/8CojF/rCbfaDJctk31Em
 +pVA==
X-Gm-Message-State: AOJu0YzMqsfU1gP8QD9qrZFr18g2QpLVcdXB3dus9ITDkLX8XXedGYea
 tUuvWp3G7kGgQHomOJZMrw26S0UszYw=
X-Google-Smtp-Source: AGHT+IEl9s2ay0nHuJjbxy2g5EeEw2lWgrD8ZTdq+osukNRhtygZ7nVlNsUKDbvHdGvQmXAGfcp9mw==
X-Received: by 2002:a05:6512:1290:b0:4f6:3677:54e with SMTP id
 u16-20020a056512129000b004f63677054emr5363978lfs.36.1692602776192; 
 Mon, 21 Aug 2023 00:26:16 -0700 (PDT)
Received: from fralle-msi (217-76-87-243.cust.bredband2.com. [217.76.87.243])
 by smtp.gmail.com with ESMTPSA id
 eq5-20020a056512488500b004fdd6b72bfdsm1630577lfb.117.2023.08.21.00.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 00:26:15 -0700 (PDT)
Date: Mon, 21 Aug 2023 09:26:14 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 3/3] ui/vnc-enc-tight: Avoid dynamic stack allocation
Message-ID: <20230821072613.GM6984@fralle-msi>
References: <20230818151057.1541189-1-peter.maydell@linaro.org>
 <20230818151057.1541189-4-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230818151057.1541189-4-peter.maydell@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=frasse.iglesias@gmail.com; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -1020
X-Spam_score: -102.1
X-Spam_bar: ---------------------------------------------------
X-Spam_report: (-102.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_WELCOMELIST=-0.01,
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

On [2023 Aug 18] Fri 16:10:57, Peter Maydell wrote:
> From: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Use autofree heap allocation instead of variable-length
> array on the stack.
> 
> The codebase has very few VLAs, and if we can get rid of them all we
> can make the compiler error on new additions.  This is a defensive
> measure against security bugs where an on-stack dynamic allocation
> isn't correctly size-checked (e.g.  CVE-2021-3527).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> [PMM: expanded commit message]
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>

> ---
>  ui/vnc-enc-tight.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
> index ee853dcfcb8..41f559eb837 100644
> --- a/ui/vnc-enc-tight.c
> +++ b/ui/vnc-enc-tight.c
> @@ -1097,13 +1097,13 @@ static int send_palette_rect(VncState *vs, int x, int y,
>      switch (vs->client_pf.bytes_per_pixel) {
>      case 4:
>      {
> -        size_t old_offset, offset;
> -        uint32_t header[palette_size(palette)];
> +        size_t old_offset, offset, palette_sz = palette_size(palette);
> +        g_autofree uint32_t *header = g_new(uint32_t, palette_sz);
>          struct palette_cb_priv priv = { vs, (uint8_t *)header };
>  
>          old_offset = vs->output.offset;
>          palette_iter(palette, write_palette, &priv);
> -        vnc_write(vs, header, sizeof(header));
> +        vnc_write(vs, header, palette_sz * sizeof(uint32_t));
>  
>          if (vs->tight->pixel24) {
>              tight_pack24(vs, vs->output.buffer + old_offset, colors, &offset);
> @@ -1115,11 +1115,12 @@ static int send_palette_rect(VncState *vs, int x, int y,
>      }
>      case 2:
>      {
> -        uint16_t header[palette_size(palette)];
> +        size_t palette_sz = palette_size(palette);
> +        g_autofree uint16_t *header = g_new(uint16_t, palette_sz);
>          struct palette_cb_priv priv = { vs, (uint8_t *)header };
>  
>          palette_iter(palette, write_palette, &priv);
> -        vnc_write(vs, header, sizeof(header));
> +        vnc_write(vs, header, palette_sz * sizeof(uint16_t));
>          tight_encode_indexed_rect16(vs->tight->tight.buffer, w * h, palette);
>          break;
>      }
> -- 
> 2.34.1
> 
> 

