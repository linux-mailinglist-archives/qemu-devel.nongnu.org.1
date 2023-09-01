Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C4878FF49
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 16:36:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc5Ez-0002FV-RH; Fri, 01 Sep 2023 10:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qc5Eo-00029q-Md
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 10:35:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qc5Em-0005pW-4C
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 10:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693578903;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3hQ8G5vtmdqmQ7KNBNQNuaix5Wi5AKUzL7Iz0APDt0w=;
 b=SNxhAK67kUaZqJksA+imYVl/1f2gBhKfqPeWxkhhGNmlO4BmP9JpDCddk6JBNLi/cwj0so
 OAkmbDbvdKBju9ovrS73ozxkifU14jMWHJNCz3qWKqNsA2uqPYbWb5AsZk4LE9PoXE5JBC
 8gk08xnsCQsJUjtwnaR+zk0hWAhKrHI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-dv13Cmq7NXeKUMn9ik60Iw-1; Fri, 01 Sep 2023 10:35:01 -0400
X-MC-Unique: dv13Cmq7NXeKUMn9ik60Iw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A172129AB400
 for <qemu-devel@nongnu.org>; Fri,  1 Sep 2023 14:35:01 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 17AD1412F2D4;
 Fri,  1 Sep 2023 14:35:00 +0000 (UTC)
Date: Fri, 1 Sep 2023 15:34:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 30/67] ui/vc: fold text_console_do_init() in vc_chr_open()
Message-ID: <ZPH2kgzUbCDvSZok@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-31-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230830093843.3531473-31-marcandre.lureau@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Aug 30, 2023 at 01:38:04PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  ui/console.c | 80 ++++++++++++++++++++--------------------------------
>  1 file changed, 31 insertions(+), 49 deletions(-)

> @@ -2612,12 +2570,36 @@ static void vc_chr_open(Chardev *chr,
>      s->chr = chr;
>      drv->console = s;
>  
> -    text_console_do_init(chr);
> +    fifo8_create(&s->out_fifo, 16);
>  
> -    /* console/chardev init sometimes completes elsewhere in a 2nd
> -     * stage, so defer OPENED events until they are fully initialized
> -     */
> -    *be_opened = false;
> +    s->total_height = DEFAULT_BACKSCROLL;
> +    if (QEMU_CONSOLE(s)->scanout.kind != SCANOUT_SURFACE) {
> +        if (active_console && active_console->scanout.kind == SCANOUT_SURFACE) {
> +            g_width = qemu_console_get_width(active_console, g_width);
> +            g_height = qemu_console_get_height(active_console, g_height);
> +        }
> +        QEMU_CONSOLE(s)->surface = qemu_create_displaysurface(g_width, g_height);
> +        QEMU_CONSOLE(s)->scanout.kind = SCANOUT_SURFACE;
> +    }
> +
> +    QEMU_CONSOLE(s)->hw_ops = &text_console_ops;
> +    QEMU_CONSOLE(s)->hw = s;

It feels like it would be worth having a local variable

"QemuConsole *c = QEMU_CONSOLE(s)"

to replace the many repeated casts.

Appreciate you merely moved existing code though, so either way

  Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


