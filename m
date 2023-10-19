Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 941677CFD49
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 16:50:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtUKh-0008VG-Fd; Thu, 19 Oct 2023 10:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtUKd-0008Py-D8
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:49:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtUKb-0004nL-OU
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697726940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3144SfwpfSNPTmPvvTCbJyT/UGVlYEG4Zhvyv4Gj6qY=;
 b=dWg+rIlZLU+z1Y2jWQtXd/X082tbTmCwe1A/preyz1HdSJL078rW46/OQF3+KORgUJKfO2
 oFgIQz4T3wwnkl7BzslWyjapovwU0Nh6+fA3YjzGi268Im0ws4BdGlijiW0cnn5tVBhR4i
 yTRuIQUpJolASAxrGXt0wuJpwa9dcZw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-nvklKtykPfKe1rSag-_UPA-1; Thu, 19 Oct 2023 10:48:57 -0400
X-MC-Unique: nvklKtykPfKe1rSag-_UPA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4E17889047;
 Thu, 19 Oct 2023 14:48:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8357925C9;
 Thu, 19 Oct 2023 14:48:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7CE8021E6A26; Thu, 19 Oct 2023 16:48:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/3] qapi: re-establish linting baseline
Date: Thu, 19 Oct 2023 16:48:53 +0200
Message-ID: <20231019144855.833802-2-armbru@redhat.com>
In-Reply-To: <20231019144855.833802-1-armbru@redhat.com>
References: <20231019144855.833802-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: John Snow <jsnow@redhat.com>

Some very minor housekeeping to make the linters happy once more.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20231004230532.3002201-4-jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
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


