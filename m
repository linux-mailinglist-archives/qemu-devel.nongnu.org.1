Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0F87A1F1D
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 14:46:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh8Ct-0005LX-Vg; Fri, 15 Sep 2023 08:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qh8CV-0005HU-6T
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 08:45:48 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qh8CS-0006Mh-E2
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 08:45:34 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 792882235D;
 Fri, 15 Sep 2023 15:45:29 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9D8902863C;
 Fri, 15 Sep 2023 15:45:19 +0300 (MSK)
Message-ID: <0cae6d58-1476-9b92-0b48-f593b8e92ef2@tls.msk.ru>
Date: Fri, 15 Sep 2023 15:45:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] ui/gtk: fix UI info precondition
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com
References: <20230915113637.2127644-1-marcandre.lureau@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230915113637.2127644-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
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

15.09.2023 14:36, marcandre.lureau@redhat.com:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> dpy_get_ui_info() shouldn't be called if the underlying GPU doesn't
> support it.
> 
> Before the assert() was added and the regression introduced, GTK code
> used to get "zero" UI info, for ex with a simple VGA device. The assert
> was added to prevent from calling when there are no console too. The
> other display backend that calls dpy_get_ui_info() correctly checks that
> pre-condition.
> 
> Calling dpy_set_ui_info() is "safe" in this case, it will simply return
> an error that can be generally ignored.
> 
> Fixes: commit a92e7bb4c ("ui: add precondition for dpy_get_ui_info()")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/gtk.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/ui/gtk.c b/ui/gtk.c
> index e09f97a86b..7b542da0c0 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -726,6 +726,10 @@ static void gd_set_ui_refresh_rate(VirtualConsole *vc, int refresh_rate)
>   {
>       QemuUIInfo info;
>   
> +    if (!dpy_ui_info_supported(vc->gfx.dcl.con)) {
> +        return;
> +    }
> +
>       info = *dpy_get_ui_info(vc->gfx.dcl.con);

Current dpy_ui_info_supported():

bool dpy_ui_info_supported(QemuConsole *con)
{
     if (con == NULL) {
         con = active_console;
     }
     if (con == NULL) {
         return false;
     }

     return con->hw_ops->ui_info != NULL;
}

This whole thing smells a bit wrong.  I'm not saying it *is* wrong, but
the feeling is here.

Where dpy_ui_info_supported() is called with a NULL con, so that an "active"
console needs to be used instead?

Maybe we should instead use something like

    if (!vc->gfx.dcl.con)

here in gd_set_ui_refresh_rate() ?

At the very least, the code is a bit, well, confusing.

/mjt

