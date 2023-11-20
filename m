Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 935867F0E96
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 10:10:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r50HB-00066i-24; Mon, 20 Nov 2023 04:09:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r50H9-00066X-2W
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 04:09:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r50H3-0004mB-VE
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 04:09:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700471336;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AcK0vnZYGPdIu0voL7FHRE6w4AoLWeS2p6MfJhpB3hU=;
 b=N7AQEEnjYBA+JsFmssTqhPCQnoNRTHD9LKjXSVmfSB3mgXvbUj7u/H69c7O/9r7ejr0A9P
 1e5FMX8kdaD2+Va4lcdbqzvhJgRoAkdalyvY4C/Ovxx9IPxsgnSgVLhOZYq8fjssCLNFwg
 HEOMwRrf0ro9UWiprgX4xtBWgLk0uZw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-hH3eCMDpP9ieN8siyVkGgw-1; Mon, 20 Nov 2023 04:08:54 -0500
X-MC-Unique: hH3eCMDpP9ieN8siyVkGgw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2EA8D85A5B5;
 Mon, 20 Nov 2023 09:08:54 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A994E1C060AE;
 Mon, 20 Nov 2023 09:08:51 +0000 (UTC)
Date: Mon, 20 Nov 2023 09:08:48 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zongmin Zhou <zhouzongmin@kylinos.cn>
Cc: peterx@redhat.com, farosas@suse.de, leobras@redhat.com,
 qemu-devel@nongnu.org, quintela@redhat.com
Subject: Re: [PATCH v3] migration: free 'saddr' since be no longer used
Message-ID: <ZVsiIGZ1qS_hbzEw@redhat.com>
References: <ZVdw_XMJ4mKMFejd@x1n>
 <20231120031428.908295-1-zhouzongmin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231120031428.908295-1-zhouzongmin@kylinos.cn>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Nov 20, 2023 at 11:14:28AM +0800, Zongmin Zhou wrote:
> Since socket_parse() will allocate memory for 'saddr',and its value
> will pass to 'addr' that allocated by migrate_uri_parse(),
> then 'saddr' will no longer used,need to free.
> But due to 'saddr->u' is shallow copying the contents of the union,
> the members of this union containing allocated strings,and will be used after that.
> So just free 'saddr' itself without doing a deep free on the contents of the SocketAddress.
> 
> Fixes: 72a8192e225c ("migration: convert migration 'uri' into 'MigrateAddress'")
> Signed-off-by: Zongmin Zhou<zhouzongmin@kylinos.cn>
> ---
>  migration/migration.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

and we want this fix in the next -rc release, since the memleak is a regression.

> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 28a34c9068..1832dad618 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -462,7 +462,6 @@ bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
>  {
>      g_autoptr(MigrationChannel) val = g_new0(MigrationChannel, 1);
>      g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
> -    SocketAddress *saddr = NULL;
>      InetSocketAddress *isock = &addr->u.rdma;
>      strList **tail = &addr->u.exec.args;
>  
> @@ -487,12 +486,14 @@ bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
>                  strstart(uri, "vsock:", NULL) ||
>                  strstart(uri, "fd:", NULL)) {
>          addr->transport = MIGRATION_ADDRESS_TYPE_SOCKET;
> -        saddr = socket_parse(uri, errp);
> +        SocketAddress *saddr = socket_parse(uri, errp);
>          if (!saddr) {
>              return false;
>          }
>          addr->u.socket.type = saddr->type;
>          addr->u.socket.u = saddr->u;
> +        /* Don't free the objects inside; their ownership moved to "addr" */
> +        g_free(saddr);
>      } else if (strstart(uri, "file:", NULL)) {
>          addr->transport = MIGRATION_ADDRESS_TYPE_FILE;
>          addr->u.file.filename = g_strdup(uri + strlen("file:"));
> -- 
> 2.34.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


