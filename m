Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7207DDF49
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 11:22:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy8LA-0006ko-EW; Wed, 01 Nov 2023 06:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qy8Kw-0006gV-JA
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 06:20:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qy8Ku-0003zm-Gz
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 06:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698834031;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=YPnJv+TpE8n2QqZ0MLCdy+igYIVYZKf4ZhOjyZdSqKQ=;
 b=hEwRGBERM6U2veUueCYZFtDRGA0QwSwnr6ZLLSuPJ2h6+b3twQz17AGh8SEIzy3RrWu5fO
 TYRJ/giQXA7/jQdrRZ/3Pna1X3ZOb6qllHFlC5k/aqOKAvy5IfHa3UFPuWvGJOERRyEkkd
 TPXCCeWgL1EP7rEXBodX3mWj3j4vivc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-GJQYZ3VXNCGRil0Gv1NpYw-1; Wed, 01 Nov 2023 06:20:30 -0400
X-MC-Unique: GJQYZ3VXNCGRil0Gv1NpYw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0CCA0185A784
 for <qemu-devel@nongnu.org>; Wed,  1 Nov 2023 10:20:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 53F5C40C6EBC;
 Wed,  1 Nov 2023 10:20:29 +0000 (UTC)
Date: Wed, 1 Nov 2023 10:20:27 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Anthony Harivel <aharivel@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com
Subject: Re: [PATCH v2 1/3] qio: add support for SO_PEERCRED for socket channel
Message-ID: <ZUImaz5rK/ltE4ex@redhat.com>
References: <20231031144605.64822-1-aharivel@redhat.com>
 <20231031144605.64822-2-aharivel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231031144605.64822-2-aharivel@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 31, 2023 at 03:46:01PM +0100, Anthony Harivel wrote:
> The function qio_channel_get_peercred() returns a pointer to the
> credentials of the peer process connected to this socket.
> 
> This credentials structure is defined in <sys/socket.h> as follows:
> 
> struct ucred {
> 	pid_t pid;    /* Process ID of the sending process */
> 	uid_t uid;    /* User ID of the sending process */
> 	gid_t gid;    /* Group ID of the sending process */
> };
> 
> The use of this function is possible only for connected AF_UNIX stream
> sockets and for AF_UNIX stream and datagram socket pairs.
> 
> Signed-off-by: Anthony Harivel <aharivel@redhat.com>
> ---
>  include/io/channel.h | 20 ++++++++++++++++++++
>  io/channel-socket.c  | 17 +++++++++++++++++
>  io/channel.c         | 12 ++++++++++++
>  3 files changed, 49 insertions(+)
> 
> diff --git a/include/io/channel.h b/include/io/channel.h
> index 5f9dbaab65b0..99c02d61c3d9 100644
> --- a/include/io/channel.h
> +++ b/include/io/channel.h
> @@ -149,6 +149,9 @@ struct QIOChannelClass {
>                                    void *opaque);
>      int (*io_flush)(QIOChannel *ioc,
>                      Error **errp);
> +    void (*io_peercred)(QIOChannel *ioc,
> +                        struct ucred *cred,
> +                        Error **errp);

This isn't going to fly. 'struct ucred' is Linux specific, so this won't
compile on macOS, Windows, *BSD, and we don't really want a huge #ifdef
ladder in these APIs. This will need to explode the struct and return
the individual fields that are present instead, and the impl side must
compile on other OS, even if its just stubbed out to return an error.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


