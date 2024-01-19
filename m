Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46744832B43
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 15:19:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQphM-00067V-1T; Fri, 19 Jan 2024 09:18:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQphG-00067A-B2
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:18:14 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQphE-00050m-AL
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:18:14 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-55a6833c21eso451024a12.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 06:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705673890; x=1706278690; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LdG5jaCz3CuPMHwVp1yW7NI3VZWR2k8kO+EJzn7h2BU=;
 b=mc+JOEfgwGF/S7rChMQEeQYw3j2+L/VDYFZFSVqUK0dXxNWD8Kt71kJPCz7ujXr8ls
 Ul2OA4Z7srfusogBUCJ3w8CCokDPLYlHOIVHXK+72YEMMkZNkCA6n6pl1Wx9ENMeWyYO
 ajt4OQwxlT+pBCRgUDqjiiAJ86WJNIRSixS65JbT+/iMDZng/COg1TP2Jo2NsQskEmLs
 dixhJYpkef2zOq34S38FNyE9/2kMFPxf91YD4pK0wru23yjNzGHKtIjxQy7Nsbfu2h/p
 g7+AIlHrkk9TKVEK/iOrFevIw+uYDILR90fL3AFyQfgLjhXb5qoMXHg7tyXs8966LIHN
 9i/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705673890; x=1706278690;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LdG5jaCz3CuPMHwVp1yW7NI3VZWR2k8kO+EJzn7h2BU=;
 b=D/yM6vDSbkujtnhjQOFCIdeTGYKoi9O9k8O4Ilt4IW4dtqL/JUzoRrspZIj5ArS6Is
 z8FueHpMx26cF/hKkjaWIV5fG6N7vqCj+UMUjmSG8cAYJhDMCz15lIRMgYzt/7lF40E1
 ldrRqvvIctYj1SekI9bCWlrWrzbWaU1X2FcjheYym89zc4l+QVlVy+eQMyhnM0hV7RkT
 m4ys2WkPfJkD3mIUbASAxBfT3ozDXX9xWw/vDDSvqOJDCYKULZvGmE9ROCXn9lPhsHpL
 L+MdLd++ooeS3bI4dc5Rmc4Q9zwD69kv6+KhoDFOkJyK1oyS+kHcjk+OY5zR9zbxCIbF
 m38A==
X-Gm-Message-State: AOJu0YxXqpfZc3JpQAR4ikZhOdTp3iDjbg8Fqv50oJ/vq+Xe6x0P5GWM
 Ed5PPY1pZ69g9NkUwc5pLU2rGQhO58VUfg679BDnZlNt7GsWSK1CNWzJT4OaD+1WlhfUANigVKH
 UgdH+6ET25TEB7+/Q7QieP2QuurH2lZSGG+uV7w==
X-Google-Smtp-Source: AGHT+IEquXnhRWS5PEpp9zqhfVyF9z5+kIcgvI1lTpHn4j/LTN63/b9Y2GpqtpCqJ/INZKrTleiqLob9SkMnhkkwUIw=
X-Received: by 2002:a50:fb05:0:b0:559:f0f9:76b0 with SMTP id
 d5-20020a50fb05000000b00559f0f976b0mr1642555edq.37.1705673890053; Fri, 19 Jan
 2024 06:18:10 -0800 (PST)
MIME-Version: 1.0
References: <20240115043431.3900922-1-bin.meng@windriver.com>
 <20240115043431.3900922-3-bin.meng@windriver.com>
In-Reply-To: <20240115043431.3900922-3-bin.meng@windriver.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jan 2024 14:17:58 +0000
Message-ID: <CAFEAcA-ScRpBAcfbWg-kVF0bWv7DvbNEE+E0LB8z4pDF8CO2jg@mail.gmail.com>
Subject: Re: [PATCH 2/3] hw/arm: Pack the QEMU generated device tree
To: Bin Meng <bin.meng@windriver.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 15 Jan 2024 at 04:34, Bin Meng <bin.meng@windriver.com> wrote:
>
> By default QEMU generates a 1 MiB sized device tree. Let's pack it
> to save some room.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> ---
>
>  hw/arm/boot.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index ff1173299f..511ec10ed0 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -662,6 +662,17 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>          binfo->modify_dtb(binfo, fdt);
>      }
>
> +    /*
> +     * By default QEMU generates a 1 MiB sized device tree.
> +     * Let's pack it to save some room.
> +     */
> +    if (binfo->get_dtb) {
> +        rc = fdt_pack(fdt);
> +        /* Should only fail if we've built a corrupted tree */
> +        g_assert(rc == 0);

We generally use plain old assert(), not g_assert().

> +        size = fdt_totalsize(fdt);
> +    }
> +
>      qemu_fdt_dumpdtb(fdt, size);

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

