Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D51427291CA
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 09:55:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Wwa-0006lq-Fc; Fri, 09 Jun 2023 03:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q7WwW-0006lD-L0
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 03:53:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q7WwU-0000TE-O3
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 03:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686297233;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=LSeVeYcO6vo4wKqzbb9/9JkjK1jyzjVJTp3eCX6j67Y=;
 b=cklxuT88TSRAcfo83EmctbKgLhCNzJsqzvbgkrltBx8PfU/aWfVrl6Uns0fB6pHjJn8ee5
 wxXHHldk0fURlsCGaoTdSoNUH7tanHW3mj7cHxNBoWthNOjE/RBGoCysWWgy3ikhG6Y16O
 cuRGQEuLLRyBf9CNu9IjEXfIKYLlEfk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175-XUhKtUPTNoGKypbD1dLeWg-1; Fri, 09 Jun 2023 03:53:49 -0400
X-MC-Unique: XUhKtUPTNoGKypbD1dLeWg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB1DD1C06927;
 Fri,  9 Jun 2023 07:53:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C23D110C13;
 Fri,  9 Jun 2023 07:53:47 +0000 (UTC)
Date: Fri, 9 Jun 2023 08:53:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 24/42] migration-test: Re-enable multifd_cancel test
Message-ID: <ZILaiceoEZSpJsLe@redhat.com>
References: <20230608224943.3877-1-quintela@redhat.com>
 <20230608224943.3877-25-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230608224943.3877-25-quintela@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Jun 09, 2023 at 12:49:25AM +0200, Juan Quintela wrote:

Please explain why this is considered ok, given the comment about
why it is disabled. ie if we fixed something, refrence the commit.

> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  tests/qtest/migration-test.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 01ab51a391..9f86d9bc80 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -2886,14 +2886,8 @@ int main(int argc, char **argv)
>      }
>      qtest_add_func("/migration/multifd/tcp/plain/none",
>                     test_multifd_tcp_none);
> -    /*
> -     * This test is flaky and sometimes fails in CI and otherwise:
> -     * don't run unless user opts in via environment variable.
> -     */
> -    if (getenv("QEMU_TEST_FLAKY_TESTS")) {
> -        qtest_add_func("/migration/multifd/tcp/plain/cancel",
> -                       test_multifd_tcp_cancel);
> -    }
> +    qtest_add_func("/migration/multifd/tcp/plain/cancel",
> +                   test_multifd_tcp_cancel);
>      qtest_add_func("/migration/multifd/tcp/plain/zlib",
>                     test_multifd_tcp_zlib);
>  #ifdef CONFIG_ZSTD
> -- 
> 2.40.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


