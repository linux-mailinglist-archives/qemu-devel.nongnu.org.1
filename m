Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6E57B15C9
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 10:14:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlm8k-0005L3-Un; Thu, 28 Sep 2023 04:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qlm8T-0005G6-Nm
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 04:12:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qlm8L-0008J2-PL
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 04:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695888747;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=5sRIT6ZkOBMatFiLU5DeSl70YS56xdp2SI1ypObMXUM=;
 b=IPJ8UbUGLR2eCjH9mpTWzAuEdZIfPnnXTDPZI6pxnuIelZWHsqG/8D9d90bEmMFrVrcj/D
 qXvTj6I1n7th+JwHA9x5tmPwxbIyuqNnODHIBs4ZBmG4cDS+SPfPqXFcRF+57jAmK9Y78u
 DpediLjE2/2VWe0dofbV0f/0asz7zQY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-16-RHe4dsu0OPabLVC2ghQxRA-1; Thu, 28 Sep 2023 04:12:23 -0400
X-MC-Unique: RHe4dsu0OPabLVC2ghQxRA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 059888039CB;
 Thu, 28 Sep 2023 08:12:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 58839492C37;
 Thu, 28 Sep 2023 08:12:20 +0000 (UTC)
Date: Thu, 28 Sep 2023 09:12:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 0/6] python/machine: use socketpair() for console socket
Message-ID: <ZRU1YoV0ndInO5Wb@redhat.com>
References: <20230928044943.849073-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230928044943.849073-1-jsnow@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Sep 28, 2023 at 12:49:37AM -0400, John Snow wrote:
> Like we did for the QMP socket, use socketpair() for the console socket
> so that hopefully there isn't a race condition during early boot where
> data might get dropped on the floor.
> 
> May or may not help with various race conditions where early console
> output is not showing up in the logs and/or potentially being missed by
> wait_for_console_pattern.
> 
> V3:
>   - Rebased.

V3 has R-B on every single patch already. Should this
just have been a PULL instead ?

> 
> V2:
>   - Fixed some Socket ownership/garbage collection problems
>   - Fixed callers of now-dropped VM arguments/properties
>   - added a dedicated sock_fd arg to ConsoleSocket()
>   - now using socketpair() for qtest console, too.
>   - dropped sock_dir arg from *all* machine.py classes
>   - Tested quite a bit more thoroughly ...
> 
> CI: https://gitlab.com/jsnow/qemu/-/pipelines/1019123030
> 
> John Snow (6):
>   python/machine: move socket setup out of _base_args property
>   python/machine: close sock_pair in cleanup path
>   python/console_socket: accept existing FD in initializer
>   python/machine: use socketpair() for console connections
>   python/machine: use socketpair() for qtest connection
>   python/machine: remove unused sock_dir argument
> 
>  python/qemu/machine/console_socket.py      | 29 ++++++++---
>  python/qemu/machine/machine.py             | 58 +++++++++++++---------
>  python/qemu/machine/qtest.py               | 54 +++++++++++++++-----
>  tests/avocado/acpi-bits.py                 |  5 +-
>  tests/avocado/avocado_qemu/__init__.py     |  2 +-
>  tests/avocado/machine_aspeed.py            |  5 +-
>  tests/qemu-iotests/iotests.py              |  2 +-
>  tests/qemu-iotests/tests/copy-before-write |  3 +-
>  8 files changed, 104 insertions(+), 54 deletions(-)
> 
> -- 
> 2.41.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


