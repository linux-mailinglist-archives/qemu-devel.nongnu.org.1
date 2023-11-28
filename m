Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB4F7FB289
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 08:18:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7sLK-0007W7-Eu; Tue, 28 Nov 2023 02:17:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r7sLA-0007V4-OK
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 02:17:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r7sL9-0004ZZ-5X
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 02:17:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701155821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2IP2tERrhKSWpdlY1KYnTeBzIUVcIpzq6uYQQKwYKLw=;
 b=OlV/LOebZtJc7niEylD89nyQGiInLYtcsT6BJ+8c8qmZGkvn98CZt+KHq7nJNyyFO6Felc
 gahpPatKlQ6q5z8CUQVL58YaA5t17DfjJ9siNrfAN2OzF9cysY72YPwcHXeV3udzcC6GDL
 M/BeNCDM+HdlZnpCW8w5E0/RK246KEU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-nqezglUbO7u2v3-NVjqIpg-1; Tue, 28 Nov 2023 02:16:57 -0500
X-MC-Unique: nqezglUbO7u2v3-NVjqIpg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B10380346A;
 Tue, 28 Nov 2023 07:16:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 59FCE20268D8;
 Tue, 28 Nov 2023 07:16:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 39D8A21E6A1F; Tue, 28 Nov 2023 08:16:55 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org,  prerna.saxena@nutanix.com,  quintela@redhat.com,
 berrange@redhat.com,  peter.maydell@linaro.org,  farosas@suse.de
Subject: Re: [PATCH] 'channel' and 'addr' in qmp_migrate() are not
 auto-freed. migrate_uri_parse() allocates memory which is returned to
 'channel', which is leaked because there is no code for freeing 'channel'
 or 'addr'. So, free addr and channel to avoid memory leak. 'addr' does
 shallow copying of channel->addr, hence free 'channel' itself and deep
 free contents of 'addr'
References: <20231128062520.36456-1-het.gala@nutanix.com>
Date: Tue, 28 Nov 2023 08:16:55 +0100
In-Reply-To: <20231128062520.36456-1-het.gala@nutanix.com> (Het Gala's message
 of "Tue, 28 Nov 2023 06:25:20 +0000")
Message-ID: <87a5qy4aag.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Your commit message is all in one line.  You need to format it like

     migration: Plug memory leak

    'channel' and 'addr' in qmp_migrate() are not auto-freed.
    migrate_uri_parse() allocates memory which is returned to 'channel',
    which is leaked because there is no code for freeing 'channel' or
    'addr'.  So, free addr and channel to avoid memory leak.  'addr'
    does shallow copying of channel->addr, hence free 'channel' itself
    and deep free contents of 'addr'.

Het Gala <het.gala@nutanix.com> writes:

> Fixes: 5994024f ("migration: Implement MigrateChannelList to qmp
> migration flow")
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> ---
>  migration/migration.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 28a34c9068..29efb51b62 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2004,6 +2004,8 @@ void qmp_migrate(const char *uri, bool has_channels,
>                            MIGRATION_STATUS_FAILED);
>          block_cleanup_parameters();
>      }
> +    g_free(channel);
> +    qapi_free_MigrationAddress(addr);
>  
>      if (local_err) {
>          if (!resume_requested) {

What makes you think there's a memory leak?  I can't see it.

qmp_migrate() has two callers:

1. qmp_marshal_migrate(), in generated qapi-commands-migration.c

   qmp_marshal_migrate() deserializes @args into @arg with a visitor.
   This allocates @arg and its members, including arg.channels.  It
   passes all the members of @arg to qmp_migrate().  And then it frees
   @arg and its members including arg.channels.

2. hmp_migrate()

   hmp_migrate() allocates @channel with migrate_uri_parse(), adds it to
   list @caps, passes @caps to qmp_migrate(), then frees @caps with
   qapi_free_MigrationChannelList().


