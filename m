Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AA4B0589F
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Jul 2025 13:21:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubdie-0006zF-CW; Tue, 15 Jul 2025 07:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubdhS-00068H-PJ
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 07:20:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubdhP-0001lG-DX
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 07:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752578386;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+oIkOYfnU9a09+hIEuVf4hUtpsAhI2IuCD7obuf0VhM=;
 b=KFzBZDcMB6VjesGhRZfpCZfyoUGIE7dqiYzkEwjJyWv0F9cBwNTAc3JmqTQW0ECEKB422C
 RQqDdynqM+0sSVlsg2Xaqh+uogLLVrnmh44JfBZgCnAEglw7Juhe2YBw/F/bZUnigHdjBf
 q1CrccFqZOM3mpidE9OYDza9ARY1YQk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-rMIvrehON_KvDxlO59k28Q-1; Tue,
 15 Jul 2025 07:19:45 -0400
X-MC-Unique: rMIvrehON_KvDxlO59k28Q-1
X-Mimecast-MFC-AGG-ID: rMIvrehON_KvDxlO59k28Q_1752578384
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BBDE018002AC
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 11:19:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.173])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 033F9180035C; Tue, 15 Jul 2025 11:19:42 +0000 (UTC)
Date: Tue, 15 Jul 2025 12:19:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: jsnow@redhat.com, crosa@redhat.com, qemu-devel@nongnu.org,
 mhroncok@redhat.com
Subject: Re: [PATCH] python: Replace asyncio.get_event_loop for Python 3.14
Message-ID: <aHY5S17NO42FanTs@redhat.com>
References: <20250715105113.623604-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250715105113.623604-1-rjones@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 15, 2025 at 11:51:10AM +0100, Richard W.M. Jones wrote:
> In Python 3.14, no asyncio event loop gets generated automatically.
> Instead create one when we need it.  This should work with Python 3.13
> as well.  This is a mechanical change as suggested here:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=2375004#c4
> 
> See-also: https://docs.python.org/3.14/whatsnew/3.14.html#id7
> Thanks: Miro Hrončok
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> ---
>  python/qemu/qmp/legacy.py  | 5 ++++-
>  python/qemu/qmp/qmp_tui.py | 5 ++++-
>  python/qemu/qmp/util.py    | 5 ++++-
>  python/tests/protocol.py   | 5 ++++-
>  4 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/python/qemu/qmp/legacy.py b/python/qemu/qmp/legacy.py
> index 22a2b5616e..e11d05afbd 100644
> --- a/python/qemu/qmp/legacy.py
> +++ b/python/qemu/qmp/legacy.py
> @@ -86,7 +86,10 @@ def __init__(self,
>                  "server argument should be False when passing a socket")
>  
>          self._qmp = QMPClient(nickname)
> -        self._aloop = asyncio.get_event_loop()
> +        try:
> +            self._aloop = asyncio.get_event_loop()
> +        except RuntimeError:
> +            self._aloop = asyncio.new_event_loop()
>          self._address = address
>          self._timeout: Optional[float] = None
>

The usage contract of QEMUMonitorProtocol is sufficiently ill
defined that we probably have to expect the caller might have
arranged for a specific event loop to be set against the
thread, so the try/except dance is likely required.


> diff --git a/python/qemu/qmp/qmp_tui.py b/python/qemu/qmp/qmp_tui.py
> index 2d9ebbd20b..84c5da4e66 100644
> --- a/python/qemu/qmp/qmp_tui.py
> +++ b/python/qemu/qmp/qmp_tui.py
> @@ -377,7 +377,10 @@ def run(self, debug: bool = False) -> None:
>          screen = urwid.raw_display.Screen()
>          screen.set_terminal_properties(256)
>  
> -        self.aloop = asyncio.get_event_loop()
> +        try:
> +            self.aloop = asyncio.get_event_loop()
> +        except RuntimeError:
> +            self.aloop = asyncio.new_event_loop()
>          self.aloop.set_debug(debug)
>  
>          # Gracefully handle SIGTERM and SIGINT signals

I'm somewhat inclined to say that this "App" class should
always use asyncio.new_event_loop, as the usge model is
for running a self contained QMP application. I don't
expect we should need to integrate with code that has
set an event loop against the thread.

> diff --git a/python/qemu/qmp/util.py b/python/qemu/qmp/util.py
> index ca6225e9cd..8f9f849a5f 100644
> --- a/python/qemu/qmp/util.py
> +++ b/python/qemu/qmp/util.py
> @@ -160,7 +160,10 @@ def asyncio_run(coro: Coroutine[Any, Any, T], *, debug: bool = False) -> T:
>          return asyncio.run(coro, debug=debug)
>  
>      # Python 3.6
> -    loop = asyncio.get_event_loop()
> +    try:
> +        loop = asyncio.get_event_loop()
> +    except RuntimeError:
> +        loop = asyncio.new_event_loop()
>      loop.set_debug(debug)
>      ret = loop.run_until_complete(coro)
>      loop.close()

This change is not requred as this code path only runs with
Python <= 3.6. In fact it is dead code given we only support
python >= 3.9.

I'm prepping a patch to kill all py 3.6 compat code.

> diff --git a/python/tests/protocol.py b/python/tests/protocol.py
> index 56c4d441f9..aa7c0e4397 100644
> --- a/python/tests/protocol.py
> +++ b/python/tests/protocol.py
> @@ -228,7 +228,10 @@ def async_test(async_test_method):
>          Decorator; adds SetUp and TearDown to async tests.
>          """
>          async def _wrapper(self, *args, **kwargs):
> -            loop = asyncio.get_event_loop()
> +            try:
> +                loop = asyncio.get_event_loop()
> +            except RuntimeError:
> +                loop = asyncio.new_event_loop()
>              loop.set_debug(True)

For the usage model here we should exclusively use
asyncio.new_event_loop(). This is a test decorator
so it is impossible for an existing event loop to be
set against the thread.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


