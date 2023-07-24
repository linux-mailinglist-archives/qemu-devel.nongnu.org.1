Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AC175EE53
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 10:49:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNrFr-0007nL-N6; Mon, 24 Jul 2023 04:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qNrFo-0007hQ-Tl
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 04:49:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qNrFm-0007v5-29
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 04:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690188556;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=bQrgx/6ap/BcbhxZ7N/L2EnWLm9lv1OSHeyn+KV+XjI=;
 b=SRulBZeWGCMOtVa8l530LOjhCduO7I7GjH8jFCgJkCssvVmxXFJ2nRrRdIWA/gbHWH3Sv1
 4tw+Y/LY9LDkfucNddYioXbmuoAjzOdfAGwwR5R4hHThiHC397en1hFTVV8VFaE8MbDNvH
 Y9WbdF70pW5w5XEVy3p4TdQBKUFjYyY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-326-ONJXyySmMsqX981TSOVUDQ-1; Mon, 24 Jul 2023 04:49:14 -0400
X-MC-Unique: ONJXyySmMsqX981TSOVUDQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A6798022EF;
 Mon, 24 Jul 2023 08:49:14 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 14DBEC2C7D3;
 Mon, 24 Jul 2023 08:49:13 +0000 (UTC)
Date: Mon, 24 Jul 2023 09:49:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Sergii Zasenko <sergii@zasenko.name>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] Allow UNIX socket for VNC websocket
Message-ID: <ZL47B09wgJybWThE@redhat.com>
References: <20230723210355.28717-1-sergii@zasenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230723210355.28717-1-sergii@zasenko.name>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Jul 24, 2023 at 12:03:56AM +0300, Sergii Zasenko wrote:
> Signed-off-by: Sergii Zasenko <sergii@zasenko.name>
> ---
>  ui/vnc.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 92964dc..dea1414 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -3715,11 +3715,6 @@ static int vnc_display_get_address(const char *addrstr,
>          addr->type = SOCKET_ADDRESS_TYPE_UNIX;
>          addr->u.q_unix.path = g_strdup(addrstr + 5);
>  
> -        if (websocket) {
> -            error_setg(errp, "UNIX sockets not supported with websock");
> -            goto cleanup;
> -        }
> -
>          if (to) {
>              error_setg(errp, "Port range not support with UNIX socket");
>              goto cleanup;

Missing docs update to qemu-options.hx to describe the permitted
syntax for the new feature.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


