Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 573FD759A09
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 17:41:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM9HS-0007H9-6q; Wed, 19 Jul 2023 11:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qM9HP-0007DZ-7U
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 11:39:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qM9HN-0000LJ-55
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 11:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689781191;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UuMFceK9e7XpuEX4eOTvaz+wGgf3+7MgU8p8zBw+3/g=;
 b=YFAet101IJgq8/uNwk1y3TV4J0EA6s7X+2ZP2c3xcwf50lU5PDtFtfnpwUEN2j/d3TOkO9
 6gN/aKwRV8qZAflqkGQ1iWxg225rj5dAaJbbtQk0tzU/+5abpw5CMYapL+8gEvVeL8c4+c
 n3fzWpeycDc/xm4JNMrBCUV2nXQGXP4=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-128-kV_kPYJ5N4e4ugvjdEzP8w-1; Wed, 19 Jul 2023 11:39:48 -0400
X-MC-Unique: kV_kPYJ5N4e4ugvjdEzP8w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 086461C07547;
 Wed, 19 Jul 2023 15:39:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A219F6CCA;
 Wed, 19 Jul 2023 15:39:47 +0000 (UTC)
Date: Wed, 19 Jul 2023 16:39:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH for-8.1] tests/test-util-filemonitor: Avoid pointless
 allocations
Message-ID: <ZLgDwWSIhK/7N9SP@redhat.com>
References: <20230719150103.36634-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230719150103.36634-1-philmd@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

On Wed, Jul 19, 2023 at 05:01:03PM +0200, Philippe Mathieu-Daudé wrote:
> Coverity reports few resource leaks. While they are
> harmless, fix them to avoid them showing on the reports.
> 
> Reported-by: Coverity (CID 1432615: RESOURCE_LEAK)
> Fixes: 4f370b1098 ("test-util-filemonitor: Skip test on non-x86 Travis containers")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  tests/unit/test-util-filemonitor.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/unit/test-util-filemonitor.c b/tests/unit/test-util-filemonitor.c
> index b629e10857..3ca687860d 100644
> --- a/tests/unit/test-util-filemonitor.c
> +++ b/tests/unit/test-util-filemonitor.c
> @@ -398,7 +398,7 @@ test_file_monitor_events(void)
>      };
>      Error *local_err = NULL;
>      GError *gerr = NULL;
> -    QFileMonitor *mon = qemu_file_monitor_new(&local_err);
> +    QFileMonitor *mon;
>      QemuThread th;
>      GTimer *timer;
>      gchar *dir = NULL;
> @@ -407,12 +407,9 @@ test_file_monitor_events(void)
>      char *pathsrc = NULL;
>      char *pathdst = NULL;
>      QFileMonitorTestData data;
> -    GHashTable *ids = g_hash_table_new(g_int64_hash, g_int64_equal);
> +    GHashTable *ids;
>      char *travis_arch;
>  
> -    qemu_mutex_init(&data.lock);
> -    data.records = NULL;
> -
>      /*
>       * This test does not work on Travis LXD containers since some
>       * syscalls are blocked in that environment.

Right here is logic that checks the TRAVIS_ARCH env variable.

IMHO this should just be moved out into the main() method, so
we don't even start test when under Travis. Just make the whole
program exits with a skip status on travis.

> @@ -423,6 +420,12 @@ test_file_monitor_events(void)
>          return;
>      }
>  
> +    mon = qemu_file_monitor_new(&local_err);
> +    ids = g_hash_table_new(g_int64_hash, g_int64_equal);
> +
> +    qemu_mutex_init(&data.lock);
> +    data.records = NULL;
> +
>      /*
>       * The file monitor needs the main loop running in
>       * order to receive events from inotify. We must
> -- 
> 2.38.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


