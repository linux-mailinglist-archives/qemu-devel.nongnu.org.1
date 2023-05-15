Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6103E7032AD
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 18:17:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyat2-0002Ll-Et; Mon, 15 May 2023 12:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1pyasy-0002LG-Le
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:17:20 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1pyasw-0004QU-TF
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:17:20 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6EED26029;
 Mon, 15 May 2023 19:17:18 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4F0E255AF;
 Mon, 15 May 2023 19:17:17 +0300 (MSK)
Message-ID: <92ab3277-0017-7f47-f5e9-a81636ec9fec@msgid.tls.msk.ru>
Date: Mon, 15 May 2023 19:17:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/1] ui/gtk: Launching GTK UI with OpenGL on causes the
 refreshrate update to not run
Content-Language: en-US
To: Nikola Pavlica <pavlica.nikola@gmail.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, f4bug@amsat.org
References: <55ZWKQ.X7E8ESP709H31@gmail.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <55ZWKQ.X7E8ESP709H31@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -106
X-Spam_score: -10.7
X-Spam_bar: ----------
X-Spam_report: (-10.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.811,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

06.12.2020 13:43, Nikola Pavlica wrote:
> I've discussed this issue back January and September. But it still occurs on my machine, despite the two patches. This time, the issue is that the UI 
> refresh rate doesn't get updated when I launch QEMU with gl=on. My fix for this issue is to move the code for updating the refresh rate above the code 
> that checks for OpenGL.
> 
> Or because OpenGL is meant to be called back with the "render" callback, should we instead add the refresh
> rate checking code there?
> 
> Anyway, regardless of method, I'm happy with any solution that just fixes the issue.

Is this change not needed anymore?

Nikola, your patch email is html-garbled, at the very least you have to send it as
plain text.

Thanks,

/mjt

> Signed-off-by: Nikola Pavlica (pavlica.nikola@gmail.com)---
> diff --git a/ui/gtk.c b/ui/gtk.c
> index a752aa22be..74287edde8 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -776,18 +776,6 @@ static gboolean gd_draw_event(GtkWidget *widget, cairo_t *cr, void *opaque)
>       int fbw, fbh;
>       int refresh_rate_millihz;
> -#if defined(CONFIG_OPENGL)
> -    if (vc->gfx.gls) {
> -        if (gtk_use_gl_area) {
> -            /* invoke render callback please */
> -            return FALSE;
> -        } else {
> -            gd_egl_draw(vc);
> -            return TRUE;
> -        }
> -    }
> -#endif
> -
>       if (!gtk_widget_get_realized(widget)) {
>           return FALSE;
>       }
> @@ -801,6 +789,18 @@ static gboolean gd_draw_event(GtkWidget *widget, cairo_t *cr, void *opaque)
>           vc->gfx.dcl.update_interval = MILLISEC_PER_SEC / refresh_rate_millihz;
>       }
> +#if defined(CONFIG_OPENGL)
> +    if (vc->gfx.gls) {
> +        if (gtk_use_gl_area) {
> +            /* invoke render callback please */
> +            return FALSE;
> +        } else {
> +            gd_egl_draw(vc);
> +            return TRUE;
> +        }
> +    }
> +#endif
> +
>       fbw = surface_width(vc->gfx.ds);
>       fbh = surface_height(vc->gfx.ds);
> -- 
> 2.21.1


