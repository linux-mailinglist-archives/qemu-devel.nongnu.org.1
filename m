Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE62B4143E
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Sep 2025 07:17:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utfpW-0000sC-2j; Wed, 03 Sep 2025 01:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1utfn7-0006N3-T5
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:12:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1utfn4-0006sz-5d
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756876332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/BmZ9w7l2CougITuHQBHRbvcKQikdf1OA1lcFK/juXY=;
 b=OfNMV6x9mSt50gdjN5c3uZ9PxPekFsY3o9vHGUf71sm7WETpSlQajIpCTiZaPLh2qSlBGK
 BCngpkZZbpNrpBOdk+OffPl+EuPL5Fyw0E5136QBEBhwSPDwLD/8mzQ+UqptfkOm4DhJaN
 Z7b7pcQ6ZviAr/x0Ylcdr5w/PItN9js=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-2iWvJj1kOXiEUh1eW0uvWw-1; Wed,
 03 Sep 2025 01:12:08 -0400
X-MC-Unique: 2iWvJj1kOXiEUh1eW0uvWw-1
X-Mimecast-MFC-AGG-ID: 2iWvJj1kOXiEUh1eW0uvWw_1756876328
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E6D081800365; Wed,  3 Sep 2025 05:12:07 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5E3E619560A2; Wed,  3 Sep 2025 05:12:05 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Daniel=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 15/18] python: ensure QEMUQtestProtocol closes its socket
Date: Wed,  3 Sep 2025 01:11:21 -0400
Message-ID: <20250903051125.3020805-16-jsnow@redhat.com>
In-Reply-To: <20250903051125.3020805-1-jsnow@redhat.com>
References: <20250903051125.3020805-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

While QEMUQtestMachine closes the socket that was passed to
QEMUQtestProtocol, the python resource leak manager still
believes that the copy QEMUQtestProtocol holds is open. We
must explicitly call close to avoid this leak warnnig.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/machine/qtest.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/python/qemu/machine/qtest.py b/python/qemu/machine/qtest.py
index 4f5ede85b23..781f674ffaf 100644
--- a/python/qemu/machine/qtest.py
+++ b/python/qemu/machine/qtest.py
@@ -177,6 +177,8 @@ def _post_shutdown(self) -> None:
             self._qtest_sock_pair[0].close()
             self._qtest_sock_pair[1].close()
             self._qtest_sock_pair = None
+        if self._qtest is not None:
+            self._qtest.close()
         super()._post_shutdown()
 
     def qtest(self, cmd: str) -> str:
-- 
2.50.1


