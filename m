Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D36B49994
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Sep 2025 21:14:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvh9t-0006Af-IL; Mon, 08 Sep 2025 15:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uvh9e-00069S-Bt
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 15:03:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uvh9N-0007rM-Re
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 15:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757358212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sg3+K42TjHTCHBz/doPg1ENvH2yOKzAmlCKgdHLoqQs=;
 b=IXoB3j/UsPoSvtA5Z0ueTWbkwW9X9m6sYsiq0IFPfk1e9EOCmXt+kvc9gjT40YKyi19vsI
 UXKmLmTgHoYfJme7AUhKDwidjs1Ye6lbvboWgthGOISnEWvgoqzjx37ear8jnZSwjEt8r0
 kgquZ9uOj6GKQ11MIxdiEfF63Yd912k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-K_coBnfdNpGnYCnhvK-gPA-1; Mon,
 08 Sep 2025 15:03:30 -0400
X-MC-Unique: K_coBnfdNpGnYCnhvK-gPA-1
X-Mimecast-MFC-AGG-ID: K_coBnfdNpGnYCnhvK-gPA_1757358209
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A643519560B7; Mon,  8 Sep 2025 19:03:29 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.36])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2A54A19540EE; Mon,  8 Sep 2025 19:03:26 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH v3 02/19] python: backport 'EventListener: add __repr__ method'
Date: Mon,  8 Sep 2025 15:03:01 -0400
Message-ID: <20250908190318.3331728-3-jsnow@redhat.com>
In-Reply-To: <20250908190318.3331728-1-jsnow@redhat.com>
References: <20250908190318.3331728-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

When the object is not stateful, this repr method prints what you'd
expect. In cases where there are pending events, the output is augmented
to illustrate that.

The object itself has no idea if it's "active" or not, so it cannot
convey that information.

Signed-off-by: John Snow <jsnow@redhat.com>
cherry picked from commit python-qemu-qmp@8a6f2e136dae395fec8aa5fd77487cfe12d9e05e
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 python/qemu/qmp/events.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/python/qemu/qmp/events.py b/python/qemu/qmp/events.py
index 6199776cc66..66583496192 100644
--- a/python/qemu/qmp/events.py
+++ b/python/qemu/qmp/events.py
@@ -497,6 +497,21 @@ def __init__(
         #: Optional, secondary event filter.
         self.event_filter: Optional[EventFilter] = event_filter
 
+    def __repr__(self) -> str:
+        args: List[str] = []
+        if self.names:
+            args.append(f"names={self.names!r}")
+        if self.event_filter:
+            args.append(f"event_filter={self.event_filter!r}")
+
+        if self._queue.qsize():
+            state = f"<pending={self._queue.qsize()}>"
+        else:
+            state = ''
+
+        argstr = ", ".join(args)
+        return f"{type(self).__name__}{state}({argstr})"
+
     @property
     def history(self) -> Tuple[Message, ...]:
         """
-- 
2.50.1


