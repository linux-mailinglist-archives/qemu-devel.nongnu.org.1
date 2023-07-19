Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BE9759324
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 12:36:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM4Vs-0000sn-Rx; Wed, 19 Jul 2023 06:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qM4Vk-0000sS-FD
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 06:34:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qM4Vi-0002uh-EM
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 06:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689762861;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=MPlOido35afeKQGRLppecd3FowSJzWhY5tfHwBI+ebg=;
 b=Z0AeHDtszMh5lAuRXysnGKNCprXeXPgMcK2nfGzUxZdVXlcNGIGf6/++oj/rROLvBKyKMj
 FDZAwYXaT87f8y/4lwPhM057DI0mBgbQxqKLIMC20Wd3nlerp5QEBgJBsEjWBcFw6Fg0jw
 awMfhAjdoxUocm+ZZzPEupDD4Xse9gQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-148-I687KmesMfyVJyQvaKvaxQ-1; Wed, 19 Jul 2023 06:34:18 -0400
X-MC-Unique: I687KmesMfyVJyQvaKvaxQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BD6AD936D2D;
 Wed, 19 Jul 2023 10:34:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 918BE40C6F4C;
 Wed, 19 Jul 2023 10:33:03 +0000 (UTC)
Date: Wed, 19 Jul 2023 11:33:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org, prerna.saxena@nutanix.com, quintela@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
Subject: Re: [PATCH v8 8/9] migration: Implement MigrateChannelList to
 migration flow.
Message-ID: <ZLe73VZAoQ1Z9zSJ@redhat.com>
References: <20230713105713.236883-1-het.gala@nutanix.com>
 <20230713105713.236883-9-het.gala@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230713105713.236883-9-het.gala@nutanix.com>
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

On Thu, Jul 13, 2023 at 10:57:12AM +0000, Het Gala wrote:
> Integrate MigrateChannelList with all transport backends
> (socket, exec and rdma) for both src and dest migration
> endpoints.
> 
> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> ---
>  migration/migration.c | 77 ++++++++++++++++++++++++++++---------------
>  migration/socket.c    |  5 ++-
>  2 files changed, 54 insertions(+), 28 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 62894952ca..43c7e4b525 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -426,9 +426,10 @@ void migrate_add_address(SocketAddress *address)
>  }
>  
>  static bool migrate_uri_parse(const char *uri,
> -                              MigrationAddress **channel,
> +                              MigrationChannel **channel,
>                                Error **errp)
>  {
> +    g_autoptr(MigrationChannel) val = g_new0(MigrationChannel, 1);
>      g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
>      SocketAddress *saddr = &addr->u.socket;
>      InetSocketAddress *isock = &addr->u.rdma;
> @@ -464,7 +465,9 @@ static bool migrate_uri_parse(const char *uri,
>          return false;
>      }
>  
> -    *channel = addr;
> +    val->channel_type = MIGRATION_CHANNEL_TYPE_MAIN;
> +    val->addr = addr;
> +    *channel = val;
>      return true;
>  }
>  
> @@ -472,7 +475,8 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
>                                            MigrationChannelList *channels,
>                                            Error **errp)
>  {
> -    g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
> +    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
> +    g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
>  
>      /*
>       * Having preliminary checks for uri and channel
> @@ -482,20 +486,29 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
>                     "exclusive; exactly one of the two should be present in "
>                     "'migrate-incoming' qmp command ");
>          return;
> -    }
> -
> -    if (uri && !migrate_uri_parse(uri, &channel, errp)) {
> -        return;
> +    } else if (channels) {
> +        /* To verify that Migrate channel list has only item */
> +        if (channels->next) {
> +            error_setg(errp, "Channel list has more than one entries");
> +            return;
> +        }
> +        channel = channels->value;
> +        addr = channel->addr;
> +    } else {
> +        /* caller uses the old URI syntax */
> +        if (uri && !migrate_uri_parse(uri, &channel, errp)) {
> +            return;
> +        }
>      }
>  
>      /* transport mechanism not suitable for migration? */
> -    if (!migration_channels_and_transport_compatible(channel, errp)) {
> +    if (!migration_channels_and_transport_compatible(addr, errp)) {

This is strange - the API contract of migration_channels_and_transport_compatible
hasn't changed, so replacing MigrationChannel object with MigrationAddress is
surely not going to compile.  Also the '} else {' branch above doesn't
set 'addr' so it will be NULL in that codepath

>          return;
>      }
>  
>      qapi_event_send_migration(MIGRATION_STATUS_SETUP);
> -    if (channel->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
> -        SocketAddress *saddr = &channel->u.socket;
> +    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
> +        SocketAddress *saddr = &addr->u.socket;
>          if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
>              saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
>              saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
> @@ -504,11 +517,11 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
>              fd_start_incoming_migration(saddr->u.fd.str, errp);
>          }
>  #ifdef CONFIG_RDMA
> -    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
> -        rdma_start_incoming_migration(&channel->u.rdma, errp);
> -#endif
> -    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
> -        exec_start_incoming_migration(channel->u.exec.args, errp);
> +    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
> +        rdma_start_incoming_migration(&addr->u.rdma, errp);
> + #endif
> +    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
> +        exec_start_incoming_migration(addr->u.exec.args, errp);
>      } else {
>          error_setg(errp, "unknown migration protocol: %s", uri);
>      }
> @@ -1708,7 +1721,8 @@ void qmp_migrate(const char *uri, bool has_channels,
>      bool resume_requested;
>      Error *local_err = NULL;
>      MigrationState *s = migrate_get_current();
> -    g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
> +    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
> +    g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
>  
>      /*
>       * Having preliminary checks for uri and channel
> @@ -1718,14 +1732,23 @@ void qmp_migrate(const char *uri, bool has_channels,
>                     "exclusive; exactly one of the two should be present in "
>                     "'migrate' qmp command ");
>          return;
> -    }
> -
> -    if (!migrate_uri_parse(uri, &channel, errp)) {
> -        return;
> +    } else if (channels) {
> +        /* To verify that Migrate channel list has only item */
> +        if (channels->next) {
> +            error_setg(errp, "Channel list has more than one entries");
> +            return;
> +        }
> +        channel = channels->value;
> +        addr = channel->addr;
> +    } else {
> +        /* caller uses the old URI syntax */
> +        if (uri && !migrate_uri_parse(uri, &channel, errp)) {
> +            return;
> +        }
>      }
>  
>      /* transport mechanism not suitable for migration? */
> -    if (!migration_channels_and_transport_compatible(channel, errp)) {
> +    if (!migration_channels_and_transport_compatible(addr, errp)) {
>          return;
>      }
>  
> @@ -1742,8 +1765,8 @@ void qmp_migrate(const char *uri, bool has_channels,
>          }
>      }
>  
> -    if (channel->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
> -        SocketAddress *saddr = &channel->u.socket;
> +    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
> +        SocketAddress *saddr = &addr->u.socket;
>          if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
>              saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
>              saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
> @@ -1752,11 +1775,11 @@ void qmp_migrate(const char *uri, bool has_channels,
>              fd_start_outgoing_migration(s, saddr->u.fd.str, &local_err);
>          }
>  #ifdef CONFIG_RDMA
> -    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
> -        rdma_start_outgoing_migration(s, &channel->u.rdma, &local_err);
> +    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
> +        rdma_start_outgoing_migration(s, &addr->u.rdma, &local_err);
>  #endif
> -    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
> -        exec_start_outgoing_migration(s, channel->u.exec.args, &local_err);
> +    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
> +        exec_start_outgoing_migration(s, addr->u.exec.args, &local_err);
>      } else {
>          if (!resume_requested) {
>              yank_unregister_instance(MIGRATION_YANK_INSTANCE);
> diff --git a/migration/socket.c b/migration/socket.c
> index 8e7430b266..98e3ea1514 100644
> --- a/migration/socket.c
> +++ b/migration/socket.c
> @@ -28,6 +28,8 @@
>  #include "trace.h"
>  #include "postcopy-ram.h"
>  #include "options.h"
> +#include "qapi/clone-visitor.h"
> +#include "qapi/qapi-visit-sockets.h"
>  
>  struct SocketOutgoingArgs {
>      SocketAddress *saddr;
> @@ -114,12 +116,13 @@ void socket_start_outgoing_migration(MigrationState *s,
>  {
>      QIOChannelSocket *sioc = qio_channel_socket_new();
>      struct SocketConnectData *data = g_new0(struct SocketConnectData, 1);
> +    SocketAddress *addr = QAPI_CLONE(SocketAddress, saddr);
>  
>      data->s = s;
>  
>      /* in case previous migration leaked it */
>      qapi_free_SocketAddress(outgoing_args.saddr);
> -    outgoing_args.saddr = saddr;
> +    outgoing_args.saddr = addr;
>  
>      if (saddr->type == SOCKET_ADDRESS_TYPE_INET) {
>          data->hostname = g_strdup(saddr->u.inet.host);

This patch isn't changing the API contract of socket_start_outgoing_migration,
so if this QAPI_CLONE is indeed required, that suggests it should have been
in an earlier patch which introduced the pre-requisite to clone.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


