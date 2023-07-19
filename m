Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C19B6759238
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 12:00:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM3yQ-0007vq-Sl; Wed, 19 Jul 2023 05:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qM3yL-0007vU-90
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 05:59:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qM3yJ-0002st-DK
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 05:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689760790;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qUSH8aleRU3tJJXgn6QHwqEqzQQtmNfKEyyrF4PMqrc=;
 b=dvOw0j90pBdCxUQr9CXvP3lMHr42xVKoas0Ii9AZCDz25TxGuCcErNDfKcsKGOENsiM/MO
 COumjnnz2Cl/Zd/wIACEM3PwGJcKjTtS5lc0MvhithsFrRGYeS9Qm8bBcRGdKI3QW+yMKy
 G0TPfuKmKKsDdZd49GXQWYsY6oI0dvQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-j7I38YnuMRenpe1vVX1dWA-1; Wed, 19 Jul 2023 05:59:47 -0400
X-MC-Unique: j7I38YnuMRenpe1vVX1dWA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D18A387323F;
 Wed, 19 Jul 2023 09:59:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 69F822166B25;
 Wed, 19 Jul 2023 09:59:45 +0000 (UTC)
Date: Wed, 19 Jul 2023 10:59:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org, prerna.saxena@nutanix.com, quintela@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
Subject: Re: [PATCH v8 3/9] migration: convert socket backend to accept
 MigrateAddress
Message-ID: <ZLe0D0ErzGF/j5ac@redhat.com>
References: <20230713105713.236883-1-het.gala@nutanix.com>
 <20230713105713.236883-4-het.gala@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230713105713.236883-4-het.gala@nutanix.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

On Thu, Jul 13, 2023 at 10:57:07AM +0000, Het Gala wrote:
> Socket transport backend for 'migrate'/'migrate-incoming' QAPIs accept
> new wire protocol of MigrateAddress struct.
> 
> It is achived by parsing 'uri' string and storing migration parameters
> required for socket connection into well defined SocketAddress struct.
> 
> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> ---
>  migration/migration.c | 32 +++++++++++++++++++-------------
>  migration/socket.c    | 34 +++++-----------------------------
>  migration/socket.h    |  7 ++++---
>  3 files changed, 28 insertions(+), 45 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index af2ec50061..8108d4248f 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -480,18 +480,21 @@ static void qemu_start_incoming_migration(const char *uri, Error **errp)
>      }
>  
>      qapi_event_send_migration(MIGRATION_STATUS_SETUP);
> -    if (strstart(uri, "tcp:", &p) ||
> -        strstart(uri, "unix:", NULL) ||
> -        strstart(uri, "vsock:", NULL)) {
> -        socket_start_incoming_migration(p ? p : uri, errp);
> +    if (channel->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
> +        SocketAddress *saddr = &channel->u.socket;
> +        if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
> +            saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
> +            saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
> +            socket_start_incoming_migration(saddr, errp);
> +        } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
> +            fd_start_incoming_migration(saddr->u.fd.str, errp);
> +        }
>  #ifdef CONFIG_RDMA
>      } else if (strstart(uri, "rdma:", &p)) {
>          rdma_start_incoming_migration(p, errp);
>  #endif
>      } else if (strstart(uri, "exec:", &p)) {
>          exec_start_incoming_migration(p, errp);
> -    } else if (strstart(uri, "fd:", &p)) {
> -        fd_start_incoming_migration(p, errp);
>      } else {
>          error_setg(errp, "unknown migration protocol: %s", uri);
>      }
> @@ -1697,7 +1700,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
>          return;
>      }
>  
> -    if (!migrate_uri_parse(uri, &channel, &local_err)) {
> +    if (!migrate_uri_parse(uri, &channel, errp)) {
>          return;
>      }
>

This chunk should be squashed into the previous patch

With that changed:

  Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


