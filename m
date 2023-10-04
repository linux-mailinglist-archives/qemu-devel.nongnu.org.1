Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1970B7B8DA3
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 21:48:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo7pE-0004hU-NW; Wed, 04 Oct 2023 15:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qo7pB-0004g2-Fb
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 15:46:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qo7p9-00058R-Uc
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 15:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696448782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q9h+cageP+sFv7Pz8M2/uena7/9BQ+/VSci8+mUVQIo=;
 b=ak58GLhnnSS/YRmbr6L2mdm9JedNFZV96L3YnyTManV3NBGQSbnbgW+bYQYeN9XT819kob
 ATGLPpMUNWJKBtxwZIQmW1lTxWk91rKrgW7a3ec3/9Ydq/KBQladhBOtVuKz3E8ufqUQ30
 uaPga46Uhp9DBN6wyFeoLF/7qqJPB/Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-94-3DTRmH4zM9mG88Pv9be21g-1; Wed, 04 Oct 2023 15:46:18 -0400
X-MC-Unique: 3DTRmH4zM9mG88Pv9be21g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0048185A79B;
 Wed,  4 Oct 2023 19:46:17 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.16.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A87731005B8E;
 Wed,  4 Oct 2023 19:46:16 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>, qemu-block@nongnu.org,
 Beraldo Leal <bleal@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Vladimir Sementsov-Ogievskiy <v.sementsov-og@mail.ru>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 2/9] python/machine: move socket setup out of _base_args
 property
Date: Wed,  4 Oct 2023 15:46:06 -0400
Message-ID: <20231004194613.2900323-3-jsnow@redhat.com>
In-Reply-To: <20231004194613.2900323-1-jsnow@redhat.com>
References: <20231004194613.2900323-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

This property isn't meant to do much else besides return a list of
strings, so move this setup back out into _pre_launch().

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20230928044943.849073-2-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/machine/machine.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
index 35d5a672dbb..345610d6e46 100644
--- a/python/qemu/machine/machine.py
+++ b/python/qemu/machine/machine.py
@@ -301,9 +301,7 @@ def _base_args(self) -> List[str]:
 
         if self._qmp_set:
             if self._sock_pair:
-                fd = self._sock_pair[0].fileno()
-                os.set_inheritable(fd, True)
-                moncdev = f"socket,id=mon,fd={fd}"
+                moncdev = f"socket,id=mon,fd={self._sock_pair[0].fileno()}"
             elif isinstance(self._monitor_address, tuple):
                 moncdev = "socket,id=mon,host={},port={}".format(
                     *self._monitor_address
@@ -340,6 +338,7 @@ def _pre_launch(self) -> None:
         if self._qmp_set:
             if self._monitor_address is None:
                 self._sock_pair = socket.socketpair()
+                os.set_inheritable(self._sock_pair[0].fileno(), True)
                 sock = self._sock_pair[1]
             if isinstance(self._monitor_address, str):
                 self._remove_files.append(self._monitor_address)
-- 
2.41.0


