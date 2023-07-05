Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AE67482E7
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 13:31:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH0hR-0004ql-Tm; Wed, 05 Jul 2023 07:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qH0hQ-0004qZ-7e
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 07:29:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qH0hO-0007zw-P0
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 07:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688556569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1GION45l99bvaOSMLKaYczU1iPV7H4LpUmfK+UN48rA=;
 b=PN29QorKCACFjqoj0ZxmjlL1x/Yo5P8JKV51yyfnUCx4R2e80LItTk4X/ooea7nLoAGeeo
 z0bGwORZQeWGucBdJh/ScljajSzIR7Oq+/QT62PJr+adjkbM890lzscOn++x+CcVwdJV2T
 7aPVNrpaZiT3sabRQlUVQKOnFY7Y0QA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-QshFrFzUMomYbW8wFWtesg-1; Wed, 05 Jul 2023 07:29:25 -0400
X-MC-Unique: QshFrFzUMomYbW8wFWtesg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5EAF58022EF;
 Wed,  5 Jul 2023 11:29:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B2B010197;
 Wed,  5 Jul 2023 11:29:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3799521E6A1F; Wed,  5 Jul 2023 13:29:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org,  prerna.saxena@nutanix.com,  quintela@redhat.com,
 dgilbert@redhat.com,  pbonzini@redhat.com,  berrange@redhat.com,
 armbru@redhat.com,  eblake@redhat.com,  manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
Subject: Re: [PATCH v6 2/9] migration: convert uri parameter into
 'MigrateAddress' struct
References: <20230606101557.202060-1-het.gala@nutanix.com>
 <20230606101557.202060-3-het.gala@nutanix.com>
Date: Wed, 05 Jul 2023 13:29:24 +0200
In-Reply-To: <20230606101557.202060-3-het.gala@nutanix.com> (Het Gala's
 message of "Tue, 6 Jun 2023 10:15:50 +0000")
Message-ID: <877creiokr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Drive-by comment...

Het Gala <het.gala@nutanix.com> writes:

> This patch parses 'migrate' and 'migrate-incoming' QAPI's 'uri' parameter
> with all the migration connection related information and stores them
> inside well defined 'MigrateAddress' struct.
>
> Misc: limit line width in exec.c to 80 characters recommended by Qemu.
>
> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> Signed-off-by: Het Gala <het.gala@nutanix.com>

[...]

> diff --git a/migration/migration.c b/migration/migration.c
> index dc05c6f6ea..0eb25bb5a4 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -64,6 +64,7 @@
>  #include "yank_functions.h"
>  #include "sysemu/qtest.h"
>  #include "options.h"
> +#include "qemu/sockets.h"
>  
>  static NotifierList migration_state_notifiers =
>      NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
> @@ -420,15 +421,63 @@ void migrate_add_address(SocketAddress *address)
>                        QAPI_CLONE(SocketAddress, address));
>  }
>  
> +static bool migrate_uri_parse(const char *uri,
> +                              MigrationAddress **channel,
> +                              Error **errp)
> +{
> +    g_autoptr(MigrationAddress) addrs = g_new0(MigrationAddress, 1);

@addrs suggests plural, yet it points to a single MigrationAddress.
Recommend @addr.

Same elsewhere.

[...]


