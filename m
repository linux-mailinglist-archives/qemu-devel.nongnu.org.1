Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AA079D289
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 15:43:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg3eg-0004R2-3h; Tue, 12 Sep 2023 09:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qg3ed-0004Pw-S6
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 09:42:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qg3eb-0001d2-Bg
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 09:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694526128;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yasV1g+NSOv+Pgxjeczwx+kt0tfS31yh4H7/AaBEGMY=;
 b=hkYpYvtJbNaYRH/QkdysjAOhq1X6/J2czYCpCOsBciX1YRBZIg81uUdVs3glj1HTkw11mc
 zjuJPwezds3iCcNWsufejQa1+7k/SWmGX8q1Fk/eLRiBkrLhWBJZvckX1odnPzrvyVDVTE
 k+K2nOkF4KYZfoyleD95EN9BdD4JYeA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-H5_YOFeWNACPAWvxzRD84Q-1; Tue, 12 Sep 2023 09:42:06 -0400
X-MC-Unique: H5_YOFeWNACPAWvxzRD84Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F9BE91D142
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 13:42:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CE2E200CD5A;
 Tue, 12 Sep 2023 13:42:05 +0000 (UTC)
Date: Tue, 12 Sep 2023 14:42:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] tests/qtest/netdev-socket: Raise connection timeout to
 120 seconds
Message-ID: <ZQBqqu9NNygDhBAM@redhat.com>
References: <20230912133310.60583-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230912133310.60583-1-stefanha@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

On Tue, Sep 12, 2023 at 09:33:10AM -0400, Stefan Hajnoczi wrote:
> The test still fails intermittently with a 60 second timeout in the
> GitLab CI environment. Raise the timeout to 120 seconds.
> 
>   576/839 ERROR:../tests/qtest/netdev-socket.c:293:test_stream_unix: assertion failed (resp == expect): ("st0: index=0,type=stream,connection error\r\n" == "st0: index=0,type=stream,unix:/tmp/netdev-socket.UW5IA2/stream_unix\r\n") ERROR
>   576/839 qemu:qtest+qtest-sh4 / qtest-sh4/netdev-socket                            ERROR          62.85s   killed by signal 6 SIGABRT
>   >>> MALLOC_PERTURB_=249 QTEST_QEMU_BINARY=./qemu-system-sh4 QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon G_TEST_DBUS_DAEMON=/home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/tests/dbus-vmstate-daemon.sh QTEST_QEMU_IMG=./qemu-img /home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/build/tests/qtest/netdev-socket --tap -k
>   ――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
>   stderr:
>   **
>   ERROR:../tests/qtest/netdev-socket.c:293:test_stream_unix: assertion failed (resp == expect): ("st0: index=0,type=stream,connection error\r\n" == "st0: index=0,type=stream,unix:/tmp/netdev-socket.UW5IA2/stream_unix\r\n")
>   (test program exited with status code -6)
> 
> Buglink: https://gitlab.com/qemu-project/qemu/-/issues/1881
> Fixes: 417296c8d858 ("tests/qtest/netdev-socket: Raise connection timeout to 60 seconds")
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

That bumped the timeout from 5 seconds to 60 seconds to
cope with intermittent failures, which was a x12
increases. I'm concerned that it would still be failing
in largely the same way after that, and possibly we are
instead hitting a race condition causing setup to fail,
which masquerades as a timeout.

> ---
>  tests/qtest/netdev-socket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/netdev-socket.c b/tests/qtest/netdev-socket.c
> index 8eed54801f..b2501d72a1 100644
> --- a/tests/qtest/netdev-socket.c
> +++ b/tests/qtest/netdev-socket.c
> @@ -16,7 +16,7 @@
>  #include "qapi/qobject-input-visitor.h"
>  #include "qapi/qapi-visit-sockets.h"
>  
> -#define CONNECTION_TIMEOUT    60
> +#define CONNECTION_TIMEOUT    120
>  
>  #define EXPECT_STATE(q, e, t)                             \
>  do {                                                      \

I'll add

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

but with the caveat that i'm only 50/50 on whether this is actually
the right fix. Doesn't hurt to try it, but if 120 seconds still shows
failures I'd say we're hitting a functional race not a timeout.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


