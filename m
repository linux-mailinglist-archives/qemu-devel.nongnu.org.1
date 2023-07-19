Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF59759337
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 12:38:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM4Z6-0001pp-5r; Wed, 19 Jul 2023 06:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qM4Yt-0001oY-Ny
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 06:37:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qM4Yr-0003gg-F0
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 06:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689763056;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=/I9UXSWuy4mk/jyNe4rV2vTRYdy7OSctMrSS5CDIp8k=;
 b=SRVyadZ1mMXKiK2eWVvmEi+qV5pYTcMvWc/UOVpBtwW1qrUb1/fPyT0Oh3YLwHi4MQvSuS
 UfkWDcOaJXbVxr4TXnSoWOFQN9vAwbusBdtZor7VYC+W8JU9ExRN1yq9s5fOGhdGFCLWiZ
 AsBusk1ttqu2ni6PUwb0bvqhxzLTREc=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-rGwwrzvwMvWLva2noHJBfQ-1; Wed, 19 Jul 2023 06:37:34 -0400
X-MC-Unique: rGwwrzvwMvWLva2noHJBfQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B15A3C244E9;
 Wed, 19 Jul 2023 10:37:34 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B6A34CD0FB;
 Wed, 19 Jul 2023 10:37:29 +0000 (UTC)
Date: Wed, 19 Jul 2023 11:37:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org, prerna.saxena@nutanix.com, quintela@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
Subject: Re: [PATCH v8 9/9] migration: Add test case for modified QAPI syntax
Message-ID: <ZLe85wkn8tu0aMiK@redhat.com>
References: <20230713105713.236883-1-het.gala@nutanix.com>
 <20230713105713.236883-10-het.gala@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230713105713.236883-10-het.gala@nutanix.com>
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

On Thu, Jul 13, 2023 at 10:57:13AM +0000, Het Gala wrote:
> Add multifd tcp common test case for new QAPI syntax defined.
> 
> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> ---
>  tests/qtest/migration-test.c | 45 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index efa8c729db..786e6bbe8b 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -2190,6 +2190,32 @@ test_migrate_precopy_tcp_multifd_start_common(QTestState *from,
>      return NULL;
>  }
>  
> +static void *
> +test_migrate_precopy_tcp_multifd_start_new_syntax_common(QTestState *from,
> +                                                         QTestState *to,
> +                                                         const char *method)
> +{
> +    migrate_set_parameter_int(from, "multifd-channels", 16);
> +    migrate_set_parameter_int(to, "multifd-channels", 16);
> +
> +    migrate_set_parameter_str(from, "multifd-compression", method);
> +    migrate_set_parameter_str(to, "multifd-compression", method);
> +
> +    migrate_set_capability(from, "multifd", true);
> +    migrate_set_capability(to, "multifd", true);
> +
> +    /* Start incoming migration from the 1st socket */
> +    qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
> +                             "  'arguments': { "
> +                             "      'channels': [ { 'channeltype': 'main',"
> +                             "      'addr': { 'transport': 'socket',"
> +                             "                'type': 'inet',"
> +                             "                'host': '127.0.0.1',"
> +                             "                'port': '0' } } ] } }");
> +
> +    return NULL;
> +}
> +
>  static void *
>  test_migrate_precopy_tcp_multifd_start(QTestState *from,
>                                         QTestState *to)
> @@ -2197,6 +2223,14 @@ test_migrate_precopy_tcp_multifd_start(QTestState *from,
>      return test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
>  }
>  
> +static void *
> +test_migrate_precopy_tcp_multifd_new_syntax_start(QTestState *from,
> +                                                  QTestState *to)
> +{
> +    return test_migrate_precopy_tcp_multifd_start_new_syntax_common(from,
> +                                                              to, "none");
> +}
> +
>  static void *
>  test_migrate_precopy_tcp_multifd_zlib_start(QTestState *from,
>                                              QTestState *to)
> @@ -2228,6 +2262,15 @@ static void test_multifd_tcp_none(void)
>      test_precopy_common(&args);
>  }
>  
> +static void test_multifd_tcp_new_syntax_none(void)
> +{
> +    MigrateCommon args = {
> +        .listen_uri = "defer",
> +        .start_hook = test_migrate_precopy_tcp_multifd_new_syntax_start,
> +    };
> +    test_precopy_common(&args);
> +}
> +
>  static void test_multifd_tcp_zlib(void)
>  {
>      MigrateCommon args = {
> @@ -2916,6 +2959,8 @@ int main(int argc, char **argv)
>      }
>      qtest_add_func("/migration/multifd/tcp/plain/none",
>                     test_multifd_tcp_none);
> +    qtest_add_func("/migration/multifd/tcp/plain/none",
> +                   test_multifd_tcp_new_syntax_none);

Rather than adding a new test case, I think its sufficient to modify
the existing test_multifd_tcp_none() method to use the new syntax.
We've plenty of other test cases which will still be exercising the
old syntax.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


