Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABE57B5006
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 12:18:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnFzK-0005Ch-Oy; Mon, 02 Oct 2023 06:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qnFzH-0005CZ-LM
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 06:17:15 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qnFzF-0008SY-Sb
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 06:17:15 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2FA0E26B12;
 Mon,  2 Oct 2023 13:17:44 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 738E32C1FB;
 Mon,  2 Oct 2023 13:17:01 +0300 (MSK)
Message-ID: <1fb2f4b7-aa0c-1b1c-23e9-2c9c18e33010@tls.msk.ru>
Date: Mon, 2 Oct 2023 13:17:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] ui: fix dpy_ui_info_supported(con) assertion
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
References: <20231002095445.65311-1-pbonzini@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20231002095445.65311-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -99
X-Spam_score: -10.0
X-Spam_bar: ----------
X-Spam_report: (-10.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.058,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

02.10.2023 12:54, Paolo Bonzini wrote:
> VGA does not support getting the physical video size or refresh rate.
> This is causing an assertion failure when the GTK+ user interface
> calls dpy_get_ui_info().  Return NULL from dpy_get_ui_info() if the
> information is not supported, and just ignore the request to set
> refresh rate or size in that case.
> 
> While the assertion failure was introduced by commit a92e7bb4cad
> ("ui: add precondition for dpy_get_ui_info()", 2023-09-12), QEMU had
> been using con->ui_info incorrectly since before.
> 
> Fixes: a92e7bb4cad ("ui: add precondition for dpy_get_ui_info()", 2023-09-12)
> Fixes: aeffd071ed8 ("ui: Deliver refresh rate via QemuUIInfo", 2022-06-14)
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   ui/console.c |  4 +++-
>   ui/gtk.c     | 18 ++++++++++++++++--
>   2 files changed, 19 insertions(+), 3 deletions(-)

Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>

I think it is a step to the right direction.
It might need more work still, but at least it is asking properties of the
right pointer ;)

/mjt

> diff --git a/ui/console.c b/ui/console.c
> index 4a4f19ed33e..24438b187c8 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -815,7 +815,9 @@ bool dpy_ui_info_supported(const QemuConsole *con)
>   
>   const QemuUIInfo *dpy_get_ui_info(const QemuConsole *con)
>   {
> -    assert(dpy_ui_info_supported(con));
> +    if (!dpy_ui_info_supported(con)) {
> +        return NULL;
> +    }
>   
>       if (con == NULL) {
>           con = active_console;
> diff --git a/ui/gtk.c b/ui/gtk.c
> index e09f97a86b7..0b5e314cf0d 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -724,18 +724,32 @@ static gboolean gd_window_close(GtkWidget *widget, GdkEvent *event,
>   
>   static void gd_set_ui_refresh_rate(VirtualConsole *vc, int refresh_rate)
>   {
> +    const QemuUIInfo *p_info;
>       QemuUIInfo info;
>   
> -    info = *dpy_get_ui_info(vc->gfx.dcl.con);
> +    p_info = dpy_get_ui_info(vc->gfx.dcl.con);
> +    if (!p_info) {
> +        /* not supported by guest */
> +        return;
> +    }
> +
> +    info = *p_info;
>       info.refresh_rate = refresh_rate;
>       dpy_set_ui_info(vc->gfx.dcl.con, &info, true);
>   }
>   
>   static void gd_set_ui_size(VirtualConsole *vc, gint width, gint height)
>   {
> +    const QemuUIInfo *p_info;
>       QemuUIInfo info;
>   
> -    info = *dpy_get_ui_info(vc->gfx.dcl.con);
> +    p_info = dpy_get_ui_info(vc->gfx.dcl.con);
> +    if (!p_info) {
> +        /* not supported by guest */
> +        return;
> +    }
> +
> +    info = *p_info;
>       info.width = width;
>       info.height = height;
>       dpy_set_ui_info(vc->gfx.dcl.con, &info, true);


