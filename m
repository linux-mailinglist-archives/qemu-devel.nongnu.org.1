Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 094CD762179
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 20:35:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOMrV-0004aE-Br; Tue, 25 Jul 2023 14:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOMrT-0004YC-BC
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 14:34:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOMrR-0008D5-IB
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 14:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690310057;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=UozPpTQTLssLpbe/J4b0irqXDAlS0T+QvxZ0X+PfSHw=;
 b=VojX95onDyObSc6jMaugE+g9eF71osd+M3lEw/R73H6rxrOJ2gNKjFLnr9VIEInf+b7BaK
 NEg3+UrcA97wXXtU7pn45PVIVHVmr5oCKHOMY5tpSjDTlzAZeekCnrutvRB9AWS3DMtWjd
 hazg4dAevhWLMtaz/QATN1SJMts+ZTE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-512-itFBIygVNjS1Z4M7McnfhA-1; Tue, 25 Jul 2023 14:34:13 -0400
X-MC-Unique: itFBIygVNjS1Z4M7McnfhA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCF241010429;
 Tue, 25 Jul 2023 18:34:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.133])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 87FDD2166B25;
 Tue, 25 Jul 2023 18:34:11 +0000 (UTC)
Date: Tue, 25 Jul 2023 19:34:09 +0100
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
Subject: Re: [PATCH v9 06/10] migration: New migrate and migrate-incoming
 argument 'channels'
Message-ID: <ZMAVodWyElfN9EFb@redhat.com>
References: <20230721144914.170991-1-het.gala@nutanix.com>
 <20230721144914.170991-7-het.gala@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230721144914.170991-7-het.gala@nutanix.com>
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

On Fri, Jul 21, 2023 at 02:49:31PM +0000, Het Gala wrote:
> MigrateChannelList allows to connect accross multiple interfaces.
> Add MigrateChannelList struct as argument to migration QAPIs.
> 
> We plan to include multiple channels in future, to connnect
> multiple interfaces. Hence, we choose 'MigrateChannelList'
> as the new argument over 'MigrateChannel' to make migration
> QAPIs future proof.
> 
> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> ---
>  migration/migration-hmp-cmds.c |   6 +-
>  migration/migration.c          |  34 ++++++++--
>  qapi/migration.json            | 109 ++++++++++++++++++++++++++++++++-
>  softmmu/vl.c                   |   2 +-
>  4 files changed, 139 insertions(+), 12 deletions(-)
> 
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 9885d7c9f7..49b150f33f 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -424,7 +424,7 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
>      Error *err = NULL;
>      const char *uri = qdict_get_str(qdict, "uri");
>  
> -    qmp_migrate_incoming(uri, &err);
> +    qmp_migrate_incoming(uri, false, NULL, &err);
>  
>      hmp_handle_error(mon, err);
>  }
> @@ -705,8 +705,8 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
>      const char *uri = qdict_get_str(qdict, "uri");
>      Error *err = NULL;
>  
> -    qmp_migrate(uri, !!blk, blk, !!inc, inc,
> -                false, false, true, resume, &err);
> +    qmp_migrate(uri, false, NULL, !!blk, blk, !!inc, inc,
> +                 false, false, true, resume, &err);
>      if (hmp_handle_error(mon, err)) {
>          return;
>      }
> diff --git a/migration/migration.c b/migration/migration.c
> index f37b388876..bd3a93fc8c 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -466,10 +466,22 @@ static bool migrate_uri_parse(const char *uri,
>      return true;
>  }
>  
> -static void qemu_start_incoming_migration(const char *uri, Error **errp)
> +static void qemu_start_incoming_migration(const char *uri, bool has_channels,
> +                                          MigrationChannelList *channels,
> +                                          Error **errp)
>  {
>      g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
>  
> +    /*
> +     * Having preliminary checks for uri and channel
> +     */
> +    if (uri && has_channels) {
> +        error_setg(errp, "'uri' and 'channels' arguments are mutually "
> +                   "exclusive; exactly one of the two should be present in "
> +                   "'migrate-incoming' qmp command ");
> +        return;
> +    }

This checks is both are present.

Also needs a check if neither are present as that's invalid.


> @@ -1694,6 +1708,16 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
>      MigrationState *s = migrate_get_current();
>      g_autoptr(MigrationAddress) channel = g_new0(MigrationAddress, 1);
>  
> +    /*
> +     * Having preliminary checks for uri and channel
> +     */
> +    if (uri && has_channels) {
> +        error_setg(errp, "'uri' and 'channels' arguments are mutually "
> +                   "exclusive; exactly one of the two should be present in "
> +                   "'migrate' qmp command ");
> +        return;
> +    }

Same here 


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


