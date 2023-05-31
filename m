Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4613718B64
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:44:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Sfe-0005mu-8T; Wed, 31 May 2023 16:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q4Sfa-0005mJ-QW
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:43:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q4SfX-0004tQ-Uo
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685565822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vHrxhh25RghyZgOJVCQbCikVFDojRPigsLAB2HuB1JM=;
 b=L0V+4uLmxQtKQ2ctQlkCqRpUn62bfaaI83h39RKIraFKYeqGB2cZ6JaJvUYdrL4zu9SAXn
 Ioan42VWrop6aI9uvhkZLvzp4OmYClrTXgCU2GNn8awa0dAsFfQlYVP08w3P2cuo36beg1
 W2cEG85JlIHSesq03bGgyK3GhJ+T10I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-27-1TKiyq7NNsS8idaT5wFpRA-1; Wed, 31 May 2023 16:43:41 -0400
X-MC-Unique: 1TKiyq7NNsS8idaT5wFpRA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C710C385556A;
 Wed, 31 May 2023 20:43:40 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.9.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 48F562029F6D;
 Wed, 31 May 2023 20:43:40 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <v.sementsov-og@mail.ru>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PULL 2/5] python/qmp/legacy: allow using sockets for connect()
Date: Wed, 31 May 2023 16:43:35 -0400
Message-Id: <20230531204338.1656158-3-jsnow@redhat.com>
In-Reply-To: <20230531204338.1656158-1-jsnow@redhat.com>
References: <20230531204338.1656158-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Instead of asserting that we have an address, allow the use of sockets
instead of addresses during a call to connect().

Signed-off-by: John Snow <jsnow@redhat.com>
Message-id: 20230517163406.2593480-3-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/qmp/legacy.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/python/qemu/qmp/legacy.py b/python/qemu/qmp/legacy.py
index 8b09ee7dbb..b1eb3f360f 100644
--- a/python/qemu/qmp/legacy.py
+++ b/python/qemu/qmp/legacy.py
@@ -150,12 +150,13 @@ def connect(self, negotiate: bool = True) -> Optional[QMPMessage]:
         :return: QMP greeting dict, or None if negotiate is false
         :raise ConnectError: on connection errors
         """
-        assert self._address is not None
+        addr_or_sock = self._address or self._sock
+        assert addr_or_sock is not None
         self._qmp.await_greeting = negotiate
         self._qmp.negotiate = negotiate
 
         self._sync(
-            self._qmp.connect(self._address)
+            self._qmp.connect(addr_or_sock)
         )
         return self._get_greeting()
 
-- 
2.40.1


