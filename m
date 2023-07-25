Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 934A276221E
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 21:16:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qONVZ-0004Wj-Ks; Tue, 25 Jul 2023 15:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qONVX-0004WI-9g
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 15:15:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qONVR-0000kQ-W9
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 15:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690312536;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Ij/3GGA0pv9szKZAKb1Mw9qHfRnFM6mj/RsTXNcoK5Y=;
 b=hPE3U4e9M2wiJ0fV3Ky/hXT4zDAyJqP+UcGjr68XD7eggpsfqMRqWKjX0jWNokK4UFpm2o
 sZm/uedZxN1s35pRwISNen5tMMlYpDQHcIkSrf/xHFDqfpsOJl+JRJBoWlPVfTV+pfZIiU
 99GPeUwjwAV+NRv90I0m702T6hNpBWY=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-402-gVZAoxx-NZ6vGfaKS0Mjxw-1; Tue, 25 Jul 2023 15:15:34 -0400
X-MC-Unique: gVZAoxx-NZ6vGfaKS0Mjxw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 192A53C02521;
 Tue, 25 Jul 2023 19:15:34 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.133])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CD3F44094DC1;
 Tue, 25 Jul 2023 19:15:32 +0000 (UTC)
Date: Tue, 25 Jul 2023 20:15:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Prerna Saxena <prerna.saxena@nutanix.com>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>,
 Manish Mishra <manish.mishra@nutanix.com>,
 Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Subject: Re: [PATCH v9 09/10] migration: Implement MigrateChannelList to hmp
 migration flow.
Message-ID: <ZMAfUtLLcjr+6JRQ@redhat.com>
References: <20230721144914.170991-1-het.gala@nutanix.com>
 <20230721144914.170991-10-het.gala@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230721144914.170991-10-het.gala@nutanix.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Jul 21, 2023 at 02:49:35PM +0000, Het Gala wrote:
> Integrate MigrateChannelList with all transport backends
> (socket, exec and rdma) for both src and dest migration
> endpoints for hmp migration.
> 
> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> ---
>  migration/migration-hmp-cmds.c | 16 +++++++++++++---
>  migration/migration.c          |  5 ++---
>  migration/migration.h          |  3 ++-
>  3 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 49b150f33f..25f51ec99c 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -423,10 +423,14 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
>  {
>      Error *err = NULL;
>      const char *uri = qdict_get_str(qdict, "uri");
> +    MigrationChannelList *caps = NULL;
> +    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
>  
> -    qmp_migrate_incoming(uri, false, NULL, &err);
> +    migrate_uri_parse(uri, &channel, &err);
> +    QAPI_LIST_PREPEND(caps, channel);
>  
> -    hmp_handle_error(mon, err);
> +    qmp_migrate_incoming(NULL, true, caps, &err);
> +    qapi_free_MigrationChannelList(caps);

IIRC, you still need the hmp_handle_error call to print any
error message.

>  }
>  
>  void hmp_migrate_recover(Monitor *mon, const QDict *qdict)
> @@ -704,9 +708,15 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
>      bool resume = qdict_get_try_bool(qdict, "resume", false);
>      const char *uri = qdict_get_str(qdict, "uri");
>      Error *err = NULL;
> +    MigrationChannelList *caps = NULL;
> +    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
> +
> +    migrate_uri_parse(uri, &channel, &err);
> +    QAPI_LIST_PREPEND(caps, channel);
>  
> -    qmp_migrate(uri, false, NULL, !!blk, blk, !!inc, inc,
> +    qmp_migrate(NULL, true, caps, !!blk, blk, !!inc, inc,
>                   false, false, true, resume, &err);
> +    qapi_free_MigrationChannelList(caps);
>      if (hmp_handle_error(mon, err)) {
>          return;
>      }
> diff --git a/migration/migration.c b/migration/migration.c
> index acf80b3590..cf063a76df 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -425,9 +425,8 @@ void migrate_add_address(SocketAddress *address)
>                        QAPI_CLONE(SocketAddress, address));
>  }
>  
> -static bool migrate_uri_parse(const char *uri,
> -                              MigrationChannel **channel,
> -                              Error **errp)
> +bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
> +                       Error **errp)
>  {
>      g_autoptr(MigrationChannel) val = g_new0(MigrationChannel, 1);
>      g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
> diff --git a/migration/migration.h b/migration/migration.h
> index b7c8b67542..a8268394ca 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -501,7 +501,8 @@ bool check_dirty_bitmap_mig_alias_map(const BitmapMigrationNodeAliasList *bbm,
>                                        Error **errp);
>  
>  void migrate_add_address(SocketAddress *address);
> -
> +bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
> +                       Error **errp);
>  int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
>  
>  #define qemu_ram_foreach_block \
> -- 
> 2.22.3
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


