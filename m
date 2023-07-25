Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 394D7762191
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 20:38:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOMvg-0008Ds-Tx; Tue, 25 Jul 2023 14:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOMvf-0008Di-8A
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 14:38:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOMvb-0000ZB-W6
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 14:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690310315;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=wdMy2cDEqeZevX/cl1y1E+plxFLPXVdCsqexrFdtUqY=;
 b=a+tqIQRye8iK0vd0Ybjb9XWrD6ZInrMnSwTNUPTYWS/Gx+a7MmA3xDJH2e4DW1lb1LK6gO
 fU4tHX5ZF0w7j6rUdeoBOyc/s9kn5WjPKVS0OKzmWPO21ozwd1ZjLboIYpdhf4fBdQlf0Q
 hbtOsgBy03EVOn8JIbbsrxVyXSlsK7c=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-446-AB5ykMvBNGKTqaVmUAXl4Q-1; Tue, 25 Jul 2023 14:38:33 -0400
X-MC-Unique: AB5ykMvBNGKTqaVmUAXl4Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E64A3C01B90;
 Tue, 25 Jul 2023 18:38:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.133])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A6C0492C13;
 Tue, 25 Jul 2023 18:38:31 +0000 (UTC)
Date: Tue, 25 Jul 2023 19:38:29 +0100
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
Subject: Re: [PATCH v9 08/10] migration: Implement MigrateChannelList to qmp
 migration flow.
Message-ID: <ZMAWpS7GsQUiDc7p@redhat.com>
References: <20230721144914.170991-1-het.gala@nutanix.com>
 <20230721144914.170991-9-het.gala@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230721144914.170991-9-het.gala@nutanix.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

On Fri, Jul 21, 2023 at 02:49:34PM +0000, Het Gala wrote:
> Integrate MigrateChannelList with all transport backends
> (socket, exec and rdma) for both src and dest migration
> endpoints for qmp migration.
> 
> For current series, limit the size of MigrateChannelList
> to single element (single interface) as runtime check.
> 
> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> ---
>  migration/migration.c | 77 ++++++++++++++++++++++++++++---------------
>  1 file changed, 50 insertions(+), 27 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 6e0a8beaf2..acf80b3590 100644
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
> @@ -465,7 +466,9 @@ static bool migrate_uri_parse(const char *uri,
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
> @@ -473,7 +476,8 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
>                                            MigrationChannelList *channels,
>                                            Error **errp)
>  {
> -    g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
> +    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
> +    g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
>  
>      /*
>       * Having preliminary checks for uri and channel
> @@ -483,20 +487,29 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
>                     "exclusive; exactly one of the two should be present in "
>                     "'migrate-incoming' qmp command ");
>          return;
> +    } else if (channels) {
> +        /* To verify that Migrate channel list has only item */
> +        if (channels->next) {
> +            error_setg(errp, "Channel list has more than one entries");
> +            return;
> +        }
> +        channel = channels->value;
> +    } else {
> +        /* caller uses the old URI syntax */
> +        if (uri && !migrate_uri_parse(uri, &channel, errp)) {
> +            return;
> +        }
>      }
> -
> -    if (uri && !migrate_uri_parse(uri, &channel, errp)) {
> -        return;
> -    }
> +    addr = channel->addr;
>  
>      /* transport mechanism not suitable for migration? */
> -    if (!migration_channels_and_transport_compatible(channel, errp)) {
> +    if (!migration_channels_and_transport_compatible(addr, errp)) {
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
> @@ -505,11 +518,11 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
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
> @@ -1709,7 +1722,8 @@ void qmp_migrate(const char *uri, bool has_channels,
>      bool resume_requested;
>      Error *local_err = NULL;
>      MigrationState *s = migrate_get_current();
> -    g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
> +    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
> +    g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
>  
>      /*
>       * Having preliminary checks for uri and channel
> @@ -1719,14 +1733,23 @@ void qmp_migrate(const char *uri, bool has_channels,
>                     "exclusive; exactly one of the two should be present in "
>                     "'migrate' qmp command ");
>          return;
> +    } else if (channels) {
> +        /* To verify that Migrate channel list has only item */
> +        if (channels->next) {
> +            error_setg(errp, "Channel list has more than one entries");
> +            return;
> +        }
> +        channel = channels->value;
> +    } else {

} else if (uri) {
     if (!migrate_uri_parse(....))
} else {
    ...error - neither uri or has_channels ...

}
> +        /* caller uses the old URI syntax */
> +        if (uri && !migrate_uri_parse(uri, &channel, errp)) {
> +            return;
> +        }
>      }
> -
> -    if (!migrate_uri_parse(uri, &channel, errp)) {
> -        return;
> -    }
> +    addr = channel->addr;
>  
>      /* transport mechanism not suitable for migration? */
> -    if (!migration_channels_and_transport_compatible(channel, errp)) {
> +    if (!migration_channels_and_transport_compatible(addr, errp)) {
>          return;
>      }
>  
> @@ -1743,8 +1766,8 @@ void qmp_migrate(const char *uri, bool has_channels,
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
> @@ -1753,11 +1776,11 @@ void qmp_migrate(const char *uri, bool has_channels,
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
> -- 
> 2.22.3
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


