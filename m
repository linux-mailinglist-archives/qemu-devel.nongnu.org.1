Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67904806D22
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 12:00:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rApcM-0001CB-GU; Wed, 06 Dec 2023 05:59:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rApcK-0001C0-Fa
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 05:59:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rApcI-0005lU-Id
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 05:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701860336;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=9J4qnQfHEtruHeIi2e5+xA0lRlLPKgnWZ6wPkeJ6/1Y=;
 b=VSDvrPgkEKUCN9ZRIzfF72V/4MiS8YQgCneo0PzT6H/x7eY8wd0EpPjG14CFCtOVHRqDWM
 oJ87VRgJD6VwrO6+3Kd31dHH+dsXLS4ufoWBRVKvkBan4LYVvU6qeUSnI/rJo12vdMFgyC
 Y6WWZU3Ny9WVcfv/doAICVcvkmevWcI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-rcyRhPatOv6jC21t_7SdXw-1; Wed, 06 Dec 2023 05:58:54 -0500
X-MC-Unique: rcyRhPatOv6jC21t_7SdXw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3213D881B73;
 Wed,  6 Dec 2023 10:58:54 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 986ED40C6EB9;
 Wed,  6 Dec 2023 10:58:48 +0000 (UTC)
Date: Wed, 6 Dec 2023 10:57:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: lijiejun <a_lijiejun@163.com>
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] migration: using qapi_free_SocketAddress instead of g_free
Message-ID: <ZXBTKs1zBCBq-JlQ@redhat.com>
References: <20231206100111.2996016-1-a_lijiejun@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231206100111.2996016-1-a_lijiejun@163.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Dec 06, 2023 at 06:01:11PM +0800, lijiejun wrote:
> use unified function qapi_free_SocketAddress to free SocketAddress
> object.
> 
> Signed-off-by: lijiejun <a_lijiejun@163.com>
> ---
>  migration/migration.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 3ce04b2aaf..e78d31bbbf 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -493,7 +493,7 @@ bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
>          addr->u.socket.type = saddr->type;
>          addr->u.socket.u = saddr->u;
>          /* Don't free the objects inside; their ownership moved to "addr" */
> -        g_free(saddr);
> +        qapi_free_SocketAddress(saddr);

The comment on the line above that explains we only want to free
'saddr', not its contents.

>      } else if (strstart(uri, "file:", NULL)) {
>          addr->transport = MIGRATION_ADDRESS_TYPE_FILE;
>          addr->u.file.filename = g_strdup(uri + strlen("file:"));
> -- 
> 2.25.1
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


