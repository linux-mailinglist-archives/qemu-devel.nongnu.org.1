Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D2C759221
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 11:57:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM3ux-00079w-4S; Wed, 19 Jul 2023 05:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qM3ul-00079Y-Cr
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 05:56:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qM3uh-0002CF-Lt
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 05:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689760565;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DnIjJcrD9xZN20ZwDE4iTEnNpwNwCBKAQiyCSpZ2kco=;
 b=InIOwCVWOGCBy/IavNdZHN32c/1TPpv7TJ/tSwgmnXJxj8QTDB2IrReFAIAhrMtmiJDdVR
 wVlLMdjTBmFnA4zUZhsuo9mzq92TM7w3taGyMR5qOBIHPxytheNc/k8QTsRNBUQAI3xqVB
 bDDbzeywgABQo0MyS//SZkE4UVVi1Yk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-53-KfHxWQKsNBe3VpQVE9Y1IA-1; Wed, 19 Jul 2023 05:56:02 -0400
X-MC-Unique: KfHxWQKsNBe3VpQVE9Y1IA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D78E185A7B1;
 Wed, 19 Jul 2023 09:56:01 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 361E74CD0F5;
 Wed, 19 Jul 2023 09:56:00 +0000 (UTC)
Date: Wed, 19 Jul 2023 10:55:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org, prerna.saxena@nutanix.com, quintela@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
Subject: Re: [PATCH v8 2/9] migration: convert migration 'uri' into
 'MigrateAddress'
Message-ID: <ZLezLXxADQ8w+ziy@redhat.com>
References: <20230713105713.236883-1-het.gala@nutanix.com>
 <20230713105713.236883-3-het.gala@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230713105713.236883-3-het.gala@nutanix.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

On Thu, Jul 13, 2023 at 10:57:06AM +0000, Het Gala wrote:
> This patch parses 'migrate' and 'migrate-incoming' QAPI's 'uri'
> string containing migration connection related information
> and stores them inside well defined 'MigrateAddress' struct.
> 
> Misc: limit line width in exec.c to 80 char recommended by Qemu.

Please remove this, it uneccessary and unrelated to the
functional change.

> 
> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> ---
>  migration/exec.c      |  4 ++--
>  migration/exec.h      |  4 ++++
>  migration/migration.c | 54 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 60 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/exec.c b/migration/exec.c
> index 2bf882bbe1..c4a3293246 100644
> --- a/migration/exec.c
> +++ b/migration/exec.c
> @@ -27,7 +27,6 @@
>  #include "qemu/cutils.h"
>  
>  #ifdef WIN32
> -const char *exec_get_cmd_path(void);
>  const char *exec_get_cmd_path(void)
>  {
>      g_autofree char *detected_path = g_new(char, MAX_PATH);
> @@ -40,7 +39,8 @@ const char *exec_get_cmd_path(void)
>  }
>  #endif
>  
> -void exec_start_outgoing_migration(MigrationState *s, const char *command, Error **errp)
> +void exec_start_outgoing_migration(MigrationState *s, const char *command,
> +                                   Error **errp)

Not relevant to this patch.

>  {
>      QIOChannel *ioc;
>  
> diff --git a/migration/exec.h b/migration/exec.h
> index b210ffde7a..736cd71028 100644
> --- a/migration/exec.h
> +++ b/migration/exec.h
> @@ -19,6 +19,10 @@
>  
>  #ifndef QEMU_MIGRATION_EXEC_H
>  #define QEMU_MIGRATION_EXEC_H
> +
> +#ifdef WIN32
> +const char *exec_get_cmd_path(void);
> +#endif
>  void exec_start_incoming_migration(const char *host_port, Error **errp);
>  
>  void exec_start_outgoing_migration(MigrationState *s, const char *host_port,
> diff --git a/migration/migration.c b/migration/migration.c
> index 91bba630a8..af2ec50061 100644
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
> @@ -421,15 +422,63 @@ void migrate_add_address(SocketAddress *address)
>                        QAPI_CLONE(SocketAddress, address));
>  }
>  
> +static bool migrate_uri_parse(const char *uri,
> +                              MigrationAddress **channel,
> +                              Error **errp)
> +{
> +    g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
> +    SocketAddress *saddr = &addr->u.socket;
> +    InetSocketAddress *isock = &addr->u.rdma;
> +    strList **tail = &addr->u.exec.args;
> +
> +    if (strstart(uri, "exec:", NULL)) {
> +        addr->transport = MIGRATION_ADDRESS_TYPE_EXEC;
> +#ifdef WIN32
> +        QAPI_LIST_APPEND(tail, g_strdup(exec_get_cmd_path()));
> +#else
> +        QAPI_LIST_APPEND(tail, g_strdup("/bin/sh"));
> +#endif
> +        QAPI_LIST_APPEND(tail, g_strdup("-c"));

This only works for !WIN32.

For Win32 it needs to be "/c", so just shuffle to be inside the
ifdef.


With those minor changes made you can add

  Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


