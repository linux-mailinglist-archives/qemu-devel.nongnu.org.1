Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1BE7B988A
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 01:07:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoAw2-00040m-Gi; Wed, 04 Oct 2023 19:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qoAw1-00040M-Fs
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 19:05:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qoAvz-0002dm-UP
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 19:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696460738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EZYIJOqRCYopW7f77LO6wfJOEC5zD2/spCi1zTY51PI=;
 b=GyMe3oCu+2ClNdxwwQb2h+vVzaQ7cmXq/SYoVZnIw4Ktq6hR8PAmJNRV7nie65l0uRGaee
 L6cLn/d057eAq24QBtfJE8reDaUBI3qUsbxktGNjGNyDS7gJbG82KQ1iiU/rVmt4ntXLVZ
 ni77n31gxVxUylPzpFyT8iGsSVLQjnI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-hDadj1sFPBe4LSghLtNgRA-1; Wed, 04 Oct 2023 19:05:34 -0400
X-MC-Unique: hDadj1sFPBe4LSghLtNgRA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 47B0A85A5BD;
 Wed,  4 Oct 2023 23:05:34 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 079BCC15BB8;
 Wed,  4 Oct 2023 23:05:34 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v5 3/3] qapi: re-establish linting baseline
Date: Wed,  4 Oct 2023 19:05:32 -0400
Message-ID: <20231004230532.3002201-4-jsnow@redhat.com>
In-Reply-To: <20231004230532.3002201-1-jsnow@redhat.com>
References: <20231004230532.3002201-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

Some very minor housekeeping to make the linters happy once more.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/gen.py    | 2 +-
 scripts/qapi/parser.py | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index bf5716b5f3..5412716617 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -13,8 +13,8 @@
 
 from contextlib import contextmanager
 import os
-import sys
 import re
+import sys
 from typing import (
     Dict,
     Iterator,
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 22e7bcc4b1..bf31018aef 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -22,6 +22,7 @@
     Dict,
     List,
     Mapping,
+    Match,
     Optional,
     Set,
     Union,
@@ -563,11 +564,11 @@ def end_comment(self) -> None:
         self._switch_section(QAPIDoc.NullSection(self._parser))
 
     @staticmethod
-    def _match_at_name_colon(string: str):
+    def _match_at_name_colon(string: str) -> Optional[Match[str]]:
         return re.match(r'@([^:]*): *', string)
 
     @staticmethod
-    def _match_section_tag(string: str):
+    def _match_section_tag(string: str) -> Optional[Match[str]]:
         return re.match(r'(Returns|Since|Notes?|Examples?|TODO): *', string)
 
     def _append_body_line(self, line: str) -> None:
-- 
2.41.0


