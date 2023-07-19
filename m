Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C314975997C
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 17:22:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM8zi-00016a-2K; Wed, 19 Jul 2023 11:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qM8zf-00014U-U2
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 11:21:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qM8ze-00032l-9T
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 11:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689780093;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=6p89ZWy5m0GMj+w9jARQtFPEHYgTBBbpyssEMWvHqxU=;
 b=G3wc5edkEU7AxLwuQtoXcNsS1D6V9F7WRRmOROzopSkhSihbND8qAQIDQ1CBWx9lr1IWeE
 igxvhKsP+d1/05zh/BTWnf7p0h11O4JwF2CUK2b67izNX9siqenmetEscRDL1tZ6LsHi6u
 sBTVX2G0tsQFCtMRZyuth50Kv30c4/U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-ewAgYYEsNMyDNgjDmEQAxw-1; Wed, 19 Jul 2023 11:21:30 -0400
X-MC-Unique: ewAgYYEsNMyDNgjDmEQAxw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 90E47185A78F;
 Wed, 19 Jul 2023 15:21:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 517D01454142;
 Wed, 19 Jul 2023 15:21:28 +0000 (UTC)
Date: Wed, 19 Jul 2023 16:21:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org, prerna.saxena@nutanix.com, quintela@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
Subject: Re: [PATCH v8 3/9] migration: convert socket backend to accept
 MigrateAddress
Message-ID: <ZLf/dqkLhkqALTEA@redhat.com>
References: <20230713105713.236883-1-het.gala@nutanix.com>
 <20230713105713.236883-4-het.gala@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230713105713.236883-4-het.gala@nutanix.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

> diff --git a/migration/socket.c b/migration/socket.c
> index 1b6f5baefb..8e7430b266 100644
> --- a/migration/socket.c
> +++ b/migration/socket.c
> @@ -108,10 +108,9 @@ out:
>      object_unref(OBJECT(sioc));
>  }
>  
> -static void
> -socket_start_outgoing_migration_internal(MigrationState *s,
> -                                         SocketAddress *saddr,
> -                                         Error **errp)
> +void socket_start_outgoing_migration(MigrationState *s,
> +                                     SocketAddress *saddr,
> +                                     Error **errp)
>  {
>      QIOChannelSocket *sioc = qio_channel_socket_new();
>      struct SocketConnectData *data = g_new0(struct SocketConnectData, 1);
> @@ -135,18 +134,6 @@ socket_start_outgoing_migration_internal(MigrationState *s,
>                                       NULL);
>  }
>  
> -void socket_start_outgoing_migration(MigrationState *s,
> -                                     const char *str,
> -                                     Error **errp)
> -{
> -    Error *err = NULL;
> -    SocketAddress *saddr = socket_parse(str, &err);
> -    if (!err) {
> -        socket_start_outgoing_migration_internal(s, saddr, &err);
> -    }
> -    error_propagate(errp, err);
> -}

In this original code, socket_start_outgoing_migration would allocate
the SocketAddress, and then call socket_start_outgoing_migration_internal
which would take ownership of it. This is fine.

In the new code, the caller of socket_start_outgoing_migration
owns the SocketAddress. So socket_start_outgoing_migration must
create its own copy. IOW, this patch is where the QAPI_CLONE
additions from patch 8 must be put.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


