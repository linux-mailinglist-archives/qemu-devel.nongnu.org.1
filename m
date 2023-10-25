Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1798D7D66B5
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:25:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qva8q-0003V5-46; Wed, 25 Oct 2023 05:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qva8n-0003Ux-PR
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:25:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qva8l-00013g-1N
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698225926;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Rq+4/pOaqgvYjLUARcdlgDcVkkibImE33YssF5vzPCE=;
 b=GcE/jNIJ5uQWuTnJqURnfz7qb9jdFCZf303W+Q8mCplZLIzi+R+gjbVUF6Jxqqhp7PzAKO
 Xme7FBQumGh7X5pWmhXalCkPGUVdLU5McAfzeqsePhz74VtELjY6FENvrT8ctQzuMQDEPs
 TnYuty//uPaqmotuCEucCUzMZkAM+IM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-KhPXkDfLPriInoemYMXsWQ-1; Wed, 25 Oct 2023 05:25:19 -0400
X-MC-Unique: KhPXkDfLPriInoemYMXsWQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E976680171C;
 Wed, 25 Oct 2023 09:25:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.154])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 50E062026D4C;
 Wed, 25 Oct 2023 09:25:17 +0000 (UTC)
Date: Wed, 25 Oct 2023 10:25:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 29/29] tests/qtest: Add a test for migration with
 direct-io and multifd
Message-ID: <ZTje+wVLaaTU7CVO@redhat.com>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-30-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231023203608.26370-30-farosas@suse.de>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Oct 23, 2023 at 05:36:08PM -0300, Fabiano Rosas wrote:
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration-test.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index c74c911283..30e70c0e4e 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -2077,6 +2077,16 @@ static void *migrate_multifd_fixed_ram_start(QTestState *from, QTestState *to)
>      return NULL;
>  }
>  
> +static void *migrate_multifd_fixed_ram_dio_start(QTestState *from, QTestState *to)
> +{
> +    migrate_multifd_fixed_ram_start(from, to);
> +
> +    migrate_set_parameter_bool(from, "direct-io", true);
> +    migrate_set_parameter_bool(to, "direct-io", true);
> +
> +    return NULL;
> +}
> +
>  static void test_multifd_file_fixed_ram_live(void)
>  {
>      g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
> @@ -2103,6 +2113,18 @@ static void test_multifd_file_fixed_ram(void)
>      test_file_common(&args, false, true);
>  }
>  
> +static void test_multifd_file_fixed_ram_dio(void)
> +{
> +    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
> +                                           FILE_TEST_FILENAME);
> +    MigrateCommon args = {
> +        .connect_uri = uri,
> +        .listen_uri = "defer",
> +        .start_hook = migrate_multifd_fixed_ram_dio_start,
> +    };
> +
> +    test_file_common(&args, false, true);
> +}
>  
>  static void test_precopy_tcp_plain(void)
>  {
> @@ -3182,6 +3204,9 @@ int main(int argc, char **argv)
>      qtest_add_func("/migration/multifd/file/fixed-ram/live",
>                     test_multifd_file_fixed_ram_live);
>  
> +    qtest_add_func("/migration/multifd/file/fixed-ram/dio",
> +                   test_multifd_file_fixed_ram_dio);

All of the above should be put behind a #ifdef O_DIRECT check.

Also even if the platform supports O_DIRECT, we shouldn't assume
the filesystem used for QEMU build supports it. So we need to
open a tmp file at the same place as the save/restore and probe
to see if it succeeds with O_DIRECT, and skip the test if not.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


