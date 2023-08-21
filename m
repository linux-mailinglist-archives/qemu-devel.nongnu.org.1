Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08440782431
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 09:13:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXz5h-0005Ep-SE; Mon, 21 Aug 2023 03:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1qXz5f-0005DE-Mh
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:12:43 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1qXz5d-0008Iw-Bd
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:12:43 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4ff933f9ca8so4359974e87.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 00:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692601959; x=1693206759;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p5aMrxRdsB8EoZYf9RkoGfBOac27/pTyehAH5PRVorA=;
 b=IZuYDhmDdXbyOcmBUyedKn0EjAAAu5KaJvIpEcuTBFF0b5ah8L8lUiUOOge0bV0Ru2
 JJNXLN1a3XmZMzExSqLQpauSruFMXNwT1VPOsTG7t2lUBSJFTe/Cn8aE2IZzKNp3YndJ
 EXD7UuzJMJ3O2w70T/IGH61kdyMyKt9UcG4EGs7q4rhtAYOcrYKGA5y46BFXAqgWd1Jh
 ZeKzbgl3Pe2aevyWc56Es+PUl5lDwBdw8RI6di+3l9jgg3hvwuAa0t3YLbmk1vlDPMRJ
 mHrLn3GSYh8m4BHk1nrOCeay+hiWrDtuolxetbb6hDBjovkAMPDsYZFQxBSBzGu6epr9
 q1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692601959; x=1693206759;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p5aMrxRdsB8EoZYf9RkoGfBOac27/pTyehAH5PRVorA=;
 b=hxF+vUNVMAx+GpezrUciuNkC3FDXXQIYFtxCxJL0GUpl8bYf77KxOJk5QjeCZW/Wu7
 b5OHznTRd3jbbbGrIM4Ljv61dejIVW1e2xR3fMtbyzo0yQpzHD5T6nUU0Q6/ylXFKkAN
 ZHpENF/llervw+0Mi+uQK4idZDMZrr01VqvIImmiJftn7bO3RdeT3YXR83Zm7c+yRw4y
 1h8ZT3/VIYsbQYleXDxtAn/dBDjOfH3lYbdj7PdJsC4xXtFswqpK5RWgLuTPxJx0aRLh
 GXNZmD3PyF1+UP+p0dUsantbaXMPMmV6pQ1FIB3G+e4+c4fOZ6aB8Fn7zPULG5lMiKrG
 TUJg==
X-Gm-Message-State: AOJu0YyTCxwYi67Oq7kgQYz2ZHihfBj+F+uROIMMv4GZHCyAkTziDCWS
 BJRB16vGe3JQUnmWiVkbv04=
X-Google-Smtp-Source: AGHT+IELfVHCfsVxdaTvNlBf6HTkkZIIaL7wYPq+PNM1skJEvuPnPHquhJazZC2zjamSDMPpxJSuYg==
X-Received: by 2002:a19:7b0e:0:b0:4fb:89e2:fc27 with SMTP id
 w14-20020a197b0e000000b004fb89e2fc27mr3333272lfc.54.1692601958658; 
 Mon, 21 Aug 2023 00:12:38 -0700 (PDT)
Received: from fralle-msi (217-76-87-243.cust.bredband2.com. [217.76.87.243])
 by smtp.gmail.com with ESMTPSA id
 h5-20020ac25d65000000b004fe84fde6cesm1603318lft.31.2023.08.21.00.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 00:12:38 -0700 (PDT)
Date: Mon, 21 Aug 2023 09:12:36 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH 1/2] audio/jackaudio: Avoid dynamic stack allocation in
 qjack_client_init
Message-ID: <20230821071235.GL6984@fralle-msi>
References: <20230818155846.1651287-1-peter.maydell@linaro.org>
 <20230818155846.1651287-2-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818155846.1651287-2-peter.maydell@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=frasse.iglesias@gmail.com; helo=mail-lf1-x129.google.com
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

On [2023 Aug 18] Fri 16:58:45, Peter Maydell wrote:
> Avoid a dynamic stack allocation in qjack_client_init(), by using
> a g_autofree heap allocation instead.
> 
> (We stick with allocate + snprintf() because the JACK API requires
> the name to be no more than its maximum size, so g_strdup_printf()
> would require an extra truncation step.)
> 
> The codebase has very few VLAs, and if we can get rid of them all we
> can make the compiler error on new additions.  This is a defensive
> measure against security bugs where an on-stack dynamic allocation
> isn't correctly size-checked (e.g.  CVE-2021-3527).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>

> ---
>  audio/jackaudio.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/audio/jackaudio.c b/audio/jackaudio.c
> index 5bdf3d7a78d..7cb2a49f971 100644
> --- a/audio/jackaudio.c
> +++ b/audio/jackaudio.c
> @@ -400,7 +400,8 @@ static void qjack_client_connect_ports(QJackClient *c)
>  static int qjack_client_init(QJackClient *c)
>  {
>      jack_status_t status;
> -    char client_name[jack_client_name_size()];
> +    int client_name_len = jack_client_name_size(); /* includes NUL */
> +    g_autofree char *client_name = g_new(char, client_name_len);
>      jack_options_t options = JackNullOption;
>  
>      if (c->state == QJACK_STATE_RUNNING) {
> @@ -409,7 +410,7 @@ static int qjack_client_init(QJackClient *c)
>  
>      c->connect_ports = true;
>  
> -    snprintf(client_name, sizeof(client_name), "%s-%s",
> +    snprintf(client_name, client_name_len, "%s-%s",
>          c->out ? "out" : "in",
>          c->opt->client_name ? c->opt->client_name : audio_application_name());
>  
> -- 
> 2.34.1
> 
> 

