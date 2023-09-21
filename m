Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9376D7A9340
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 11:47:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjGGl-0005H6-IB; Thu, 21 Sep 2023 05:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjGGj-0005Gj-Fa
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 05:46:45 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjGGh-0007aE-Ma
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 05:46:45 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50336768615so1401735e87.0
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 02:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695289600; x=1695894400; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e9ndBrkf1M5l9uj4WypwDRcgd8aCPYv0maL1J5cZhCc=;
 b=PoRQmxXR5LxdpsD2PWtGvWyCwPR6ENrUmcyiWDHK5XCt2FTRz7cLVRaUIA3s2AsYe+
 gn1SBCbXuR0OYtwYowwGiKgMBJz8LfFjGJ9aEBwDjzfCL5jqIdqRF+Rbq1CFz44ow21h
 h2XA00VFFw1lgBexMdZv2OEgQBzhiFY+GyklmZQLgPx722Q9kmGxjKGZ2LD43NS6X+RY
 ssp43nGxqWnjh6PpLLmx9Xkeo3iuDC+TxPJanj4VVGRXnRxTbmWqE7ArevUIXEpX6jC6
 hnNu0/IOt3/huDjEcPbQ4gpNZCZ5HYh6J1p8atjmma3jyAv9QAT5gdUnwgfiZcOdskP5
 5lvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695289600; x=1695894400;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e9ndBrkf1M5l9uj4WypwDRcgd8aCPYv0maL1J5cZhCc=;
 b=ArbkygFM++WB3u9g19OMTgojzUwtyioQB/o+AUF8nfw/9PYxxtEVTBOXn4mKLaxn/U
 Ju4/U/BFFUN1mU16/onT0n/GD3T12idNpRJTU0ngYSg8wcYoWgG9GmnaqMGOMO4CLzet
 Vxakv32Lkvs5w6GVlF0+pEoPzblGlgoLrK5bKFPvOlsbkvHFCDz7NcexMeWG1EZaiu2z
 IGwXrq+G8DHQJaLYIJwQQ0K820mr4EZSp7KzuNwsjL41IM/nmtv9j2kC1+IGtg0ua9/S
 LUCGAK/5vWoT7VSMYD9xD1hE4D+7KVk1ezEsxdymfHBxkQi629F9wu4CJ4MylLMlumJ7
 vgNQ==
X-Gm-Message-State: AOJu0YwJ47E3qsVKUVpAz+Uvfxzd/Q2/q026XwZb8I7SyAzqiXLnBIgp
 9aK9Soc+pZaoX+Nd8WBj55ecMQ==
X-Google-Smtp-Source: AGHT+IHl0TILgZmFAqsZ5gaQd9V3vhvPQ3TXM7eorRW9WnQOw/57oLsgAAH3SZ38ZKHM+vwD/HBE3A==
X-Received: by 2002:a19:9102:0:b0:503:28ed:143b with SMTP id
 t2-20020a199102000000b0050328ed143bmr4571692lfd.18.1695289600229; 
 Thu, 21 Sep 2023 02:46:40 -0700 (PDT)
Received: from [172.20.41.70] (static-212-193-78-212.thenetworkfactory.nl.
 [212.78.193.212]) by smtp.gmail.com with ESMTPSA id
 w25-20020aa7d299000000b005329f1aa071sm590359edq.10.2023.09.21.02.46.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 02:46:39 -0700 (PDT)
Message-ID: <f1077e85-964a-14c5-eead-c6d3ef2c15ad@linaro.org>
Date: Thu, 21 Sep 2023 11:46:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v3] input: Allow to choose console with
 qemu_input_is_absolute
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20230921082936.28100-1-akihiko.odaki@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230921082936.28100-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 21/9/23 10:29, Akihiko Odaki wrote:
> Although an input is routed depending on the console,
> qemu_input_is_absolute() had no mechanism to specify the console.
> 
> Accept QemuConsole as an argument for qemu_input_is_absolute, and let
> the display know the absolute/relative state for a particular console.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> V2 -> V3: Rebased to commit 55394dcbec8f0c29c30e792c102a0edd50a52bf4
> V1 -> V2: Rebased to commit 79b677d658d3d35e1e776826ac4abb28cdce69b8
> 
>   include/ui/input.h |  2 +-
>   ui/dbus-console.c  |  6 +++---
>   ui/gtk.c           | 12 ++++++------
>   ui/input.c         | 29 +++++++----------------------
>   ui/sdl2.c          | 26 +++++++++++++-------------
>   ui/spice-input.c   |  2 +-
>   ui/vnc.c           |  2 +-
>   ui/cocoa.m         |  2 +-
>   ui/trace-events    |  1 -
>   9 files changed, 33 insertions(+), 49 deletions(-)


> diff --git a/ui/gtk.c b/ui/gtk.c
> index e09f97a86b..40b8d27da5 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -204,7 +204,7 @@ static void gd_update_cursor(VirtualConsole *vc)
>       }
>   
>       window = gtk_widget_get_window(GTK_WIDGET(vc->gfx.drawing_area));
> -    if (s->full_screen || qemu_input_is_absolute() || s->ptr_owner == vc) {
> +    if (s->full_screen || qemu_input_is_absolute(vc->gfx.dcl.con) || s->ptr_owner == vc) {
>           gdk_window_set_cursor(window, s->null_cursor);
>       } else {
>           gdk_window_set_cursor(window, NULL);
> @@ -453,7 +453,7 @@ static void gd_mouse_set(DisplayChangeListener *dcl,
>       gint x_root, y_root;
>   
>       if (!gtk_widget_get_realized(vc->gfx.drawing_area) ||
> -        qemu_input_is_absolute()) {
> +        qemu_input_is_absolute(dcl->con)) {

Maybe vc->gfx.dcl.con instead to match with the other uses in this
file? Anyhow,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>           return;
>       }
>   
> @@ -689,7 +689,7 @@ static void gd_mouse_mode_change(Notifier *notify, void *data)
>   
>       s = container_of(notify, GtkDisplayState, mouse_mode_notifier);
>       /* release the grab at switching to absolute mode */
> -    if (qemu_input_is_absolute() && s->ptr_owner) {
> +    if (s->ptr_owner && qemu_input_is_absolute(s->ptr_owner->gfx.dcl.con)) {
>           if (!s->ptr_owner->window) {
>               gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s->grab_item),
>                                              FALSE);
> @@ -903,7 +903,7 @@ static gboolean gd_motion_event(GtkWidget *widget, GdkEventMotion *motion,
>       x = (motion->x - mx) / vc->gfx.scale_x * ws;
>       y = (motion->y - my) / vc->gfx.scale_y * ws;
>   
> -    if (qemu_input_is_absolute()) {
> +    if (qemu_input_is_absolute(vc->gfx.dcl.con)) {
>           if (x < 0 || y < 0 ||
>               x >= surface_width(vc->gfx.ds) ||
>               y >= surface_height(vc->gfx.ds)) {
> @@ -923,7 +923,7 @@ static gboolean gd_motion_event(GtkWidget *widget, GdkEventMotion *motion,
>       s->last_y = y;
>       s->last_set = TRUE;
>   
> -    if (!qemu_input_is_absolute() && s->ptr_owner == vc) {
> +    if (!qemu_input_is_absolute(vc->gfx.dcl.con) && s->ptr_owner == vc) {
>           GdkScreen *screen = gtk_widget_get_screen(vc->gfx.drawing_area);
>           GdkDisplay *dpy = gtk_widget_get_display(widget);
>           GdkWindow *win = gtk_widget_get_window(widget);
> @@ -965,7 +965,7 @@ static gboolean gd_button_event(GtkWidget *widget, GdkEventButton *button,
>   
>       /* implicitly grab the input at the first click in the relative mode */
>       if (button->button == 1 && button->type == GDK_BUTTON_PRESS &&
> -        !qemu_input_is_absolute() && s->ptr_owner != vc) {
> +        !qemu_input_is_absolute(vc->gfx.dcl.con) && s->ptr_owner != vc) {
>           if (!vc->window) {
>               gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s->grab_item),
>                                              TRUE);


