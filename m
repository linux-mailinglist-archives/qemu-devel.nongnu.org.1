Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B95B87EBFB9
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 10:51:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3CWs-0004JV-3X; Wed, 15 Nov 2023 04:49:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r3CWo-0004E5-Vw
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 04:49:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r3CWV-000811-9B
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 04:49:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700041758;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=bkVCl1Fy0QgrprtZ3g6lmWufTHz/Gn0ecLzEQyt84Pg=;
 b=RgTz5k9ROlwz9XwofL2mTIvcrhDbTkcuGdvuf5nQdSF7Vy1RQ3tSSkfOgbn1dQZ2v3tzkW
 w0n1iJREicJEqTQ3t0Tahsm0TuH/W9K+8XxJUrpemE+SLbHy6/DtGYAvsw/tvqcu9HT0Nj
 PdSijKrU+3FL6yHV8P7IZFJQjdElaQc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-5uV_f6W9PDGULEw0r7f0pw-1; Wed, 15 Nov 2023 04:49:14 -0500
X-MC-Unique: 5uV_f6W9PDGULEw0r7f0pw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A47C6185A780;
 Wed, 15 Nov 2023 09:49:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.144])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B13F492BE0;
 Wed, 15 Nov 2023 09:49:11 +0000 (UTC)
Date: Wed, 15 Nov 2023 09:49:09 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zongmin Zhou <zhouzongmin@kylinos.cn>
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de,
 leobras@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] migration: free 'saddr' since be no longer used
Message-ID: <ZVSUFTBwSKHxVV_9@redhat.com>
References: <20231115032739.933043-1-zhouzongmin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231115032739.933043-1-zhouzongmin@kylinos.cn>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Nov 15, 2023 at 11:27:39AM +0800, Zongmin Zhou wrote:
> Since socket_parse() will allocate memory for 'saddr',
> and its value will pass to 'addr' that allocated
> by migrate_uri_parse(),so free 'saddr' to avoid memory leak.
> 
> Fixes: 72a8192e225c ("migration: convert migration 'uri' into 'MigrateAddress'")
> Signed-off-by: Zongmin Zhou<zhouzongmin@kylinos.cn>
> ---
>  migration/migration.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 28a34c9068..30ed4bf6b6 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -493,6 +493,7 @@ bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
>          }
>          addr->u.socket.type = saddr->type;
>          addr->u.socket.u = saddr->u;

'saddr->u' is a union embedded in SocketAddress, containing:

    union { /* union tag is @type */
        InetSocketAddressWrapper inet;
        UnixSocketAddressWrapper q_unix;
        VsockSocketAddressWrapper vsock;
        StringWrapper fd;
    } u;

THis assignment is *shallow* copying the contents of the union.

All the type specifics structs that are members of this union
containing allocated strings, and with this shallow copy, we
are stealing the pointers to these allocated strings


> +        qapi_free_SocketAddress(saddr);

This meanwhle is doing a *deep* free of the contents of the
SocketAddress, which includes all the pointers we just stole.

IOW, unless I'm mistaken somehow, this is going to cause a
double-free


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


