Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 535E073782F
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 02:23:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBlbb-00042m-Eh; Tue, 20 Jun 2023 20:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qBlbW-00040L-Di
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 20:21:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qBlbS-0000AM-BT
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 20:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687306901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dLtrgsESiA1y9/tsmlAWVcd6ujxkZYiJAKc2n+jmnXg=;
 b=edJx8n0R55O6UZe/opndeMuqHtnmhrD3JO+hmIvAZBsGv8ujnDQbOm+A2Z/35smypWi//4
 tqsr0hDn6wYXIGcifPTHIlR41k/QM1fSpdDGrldvWQLKhn2vxyOpJpXxTE5hjuZDKOTkZ/
 kTiRKfY+ddXOoJ8Wv0XwJVAGvkCnlXk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-539-DkcmP4kqOS2NJt4bvxsd-w-1; Tue, 20 Jun 2023 20:21:38 -0400
X-MC-Unique: DkcmP4kqOS2NJt4bvxsd-w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B0AF185A78B;
 Wed, 21 Jun 2023 00:21:37 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.32.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4141E112132C;
 Wed, 21 Jun 2023 00:21:37 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Beraldo Leal <bleal@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH RFC 6/6] iotests: don't add qemu.git/python to PYTHONPATH
Date: Tue, 20 Jun 2023 20:21:21 -0400
Message-Id: <20230621002121.1609612-7-jsnow@redhat.com>
In-Reply-To: <20230621002121.1609612-1-jsnow@redhat.com>
References: <20230621002121.1609612-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

qemu.* should be provided by the configure-time venv, now.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/testenv.py | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tests/qemu-iotests/testenv.py b/tests/qemu-iotests/testenv.py
index 1b095d70f2..6441145701 100644
--- a/tests/qemu-iotests/testenv.py
+++ b/tests/qemu-iotests/testenv.py
@@ -108,12 +108,8 @@ def init_directories(self) -> None:
              SAMPLE_IMG_DIR
         """
 
-        # Path where qemu goodies live in this source tree.
-        qemu_srctree_path = Path(__file__, '../../../python').resolve()
-
         self.pythonpath = os.pathsep.join(filter(None, (
             self.source_iotests,
-            str(qemu_srctree_path),
             os.getenv('PYTHONPATH'),
         )))
 
-- 
2.40.1


