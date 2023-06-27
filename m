Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AD073F841
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 11:07:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE4fS-0007Zg-Ee; Tue, 27 Jun 2023 05:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qE4fM-0007ZG-Oj
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:07:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qE4fL-0002CB-4Q
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687856834;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=S+F0G+LAo/nfdsXPynSvGMd8iWuNylZQ5ATQzTgQzRw=;
 b=CVmdkxPfbex7dSgCM19qaKYrS+bLOwbeONtUuUurFuf5M5IcTgJ8kxGGI1YvyMJtH/7hRY
 sF0bZjq3CiHAPsqVDupO9SMtJnck9/LAjleDfLSagw4r7/E55WyJhciBclN92veSPpxIPt
 TYQhDUjUoBPcLZqxV1t8+zjDcfnr/o0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-374-i-2uuOZLMwWCtYcMIYtGZw-1; Tue, 27 Jun 2023 05:07:12 -0400
X-MC-Unique: i-2uuOZLMwWCtYcMIYtGZw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 262683C100BE;
 Tue, 27 Jun 2023 09:07:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D6B9CF5CD4;
 Tue, 27 Jun 2023 09:07:10 +0000 (UTC)
Date: Tue, 27 Jun 2023 10:07:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Steve Sistare <steven.sistare@oracle.com>,
 Nikolay Borisov <nborisov@suse.com>,
 Leonardo Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6/6] tests/qtest: migration-test: Add tests for
 file-based migration
Message-ID: <ZJqmvBzeZox2nrXs@redhat.com>
References: <20230626182210.8792-1-farosas@suse.de>
 <20230626182210.8792-7-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230626182210.8792-7-farosas@suse.de>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 26, 2023 at 03:22:10PM -0300, Fabiano Rosas wrote:
> From: Nikolay Borisov <nborisov@suse.com>
> 
> Add basic tests for file-based migration.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration-test.c | 66 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index acb778a8cd..5a77257a53 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -763,6 +763,7 @@ static void test_migrate_end(QTestState *from, QTestState *to, bool test_dest)
>      cleanup("migsocket");
>      cleanup("src_serial");
>      cleanup("dest_serial");
> +    cleanup("migfile");
>  }
>  
>  #ifdef CONFIG_GNUTLS
> @@ -1460,11 +1461,28 @@ static void test_precopy_common(MigrateCommon *args)
>               */
>              wait_for_migration_complete(from);
>  
> +            /*
> +             * For file based migration the target must begin its
> +             * migration after the source has finished.
> +             */
> +            if (strstr(connect_uri, "file:")) {
> +                migrate_incoming_qmp(to, connect_uri, "{}");
> +            }
> +
>              if (!got_src_stop) {
>                  qtest_qmp_eventwait(from, "STOP");
>              }
>          } else {
>              wait_for_migration_complete(from);
> +
> +            /*
> +             * For file based migration the target must begin its
> +             * migration after the source has finished.
> +             */
> +            if (strstr(connect_uri, "file:")) {
> +                migrate_incoming_qmp(to, connect_uri, "{}");
> +            }
> +
>              /*
>               * Must wait for dst to finish reading all incoming
>               * data on the socket before issuing 'cont' otherwise
> @@ -1682,6 +1700,46 @@ static void test_precopy_unix_compress_nowait(void)
>      test_precopy_common(&args);
>  }
>  
> +static void test_precopy_file(void)
> +{
> +    g_autofree char *uri = g_strdup_printf("file:%s/migfile", tmpfs);

There's no unlink(), so I presume you're relying on the entire 'tmpfs'
being recursively deleted ?

> +    MigrateCommon args = {
> +        .connect_uri = uri,
> +        .listen_uri = "defer",
> +    };
> +
> +    test_precopy_common(&args);
> +}
> +
> +static void test_precopy_file_offset(void)
> +{
> +    g_autofree char *uri = g_strdup_printf("file:%s/migfile,offset=0x1000",
> +                                           tmpfs);
> +    MigrateCommon args = {
> +        .connect_uri = uri,
> +        .listen_uri = "defer",
> +    };
> +
> +    test_precopy_common(&args);

There ought to be something here that values 0->0x1000 bytes are
all zeroes in the file.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


