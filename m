Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 908C5706CAC
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 17:27:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJ1v-0004Jl-Tb; Wed, 17 May 2023 11:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1pzJ1n-0004IC-6o
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:25:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1pzJ1l-0000Cl-28
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684337120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K1wmvAxYvS0ef5gCKDqds4j3Qw3L/d+X6Vndts3kNjQ=;
 b=Z0mDMpUY6jn+v3do+BF8xqi2N0Hl2XwqiYsjmojVV2YU9Id88Mwblkcn3vpIQtpdHmUGy8
 lTADbdqrLZr1ZvNLRzhqdo0smtNTLeIu3KrIhiP+NYNNypWNehpWNX0EQVMwxe0DA5h3GB
 wIW010HLnglfzma7CemFGm7piOG30os=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-534-MtDQAzCANVunQuh1nHNmYg-1; Wed, 17 May 2023 11:25:18 -0400
X-MC-Unique: MtDQAzCANVunQuh1nHNmYg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D27F185A7A4;
 Wed, 17 May 2023 15:25:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C0E82166B31;
 Wed, 17 May 2023 15:25:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2BEAA21D1DA2; Wed, 17 May 2023 17:25:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 5/5] qapi/parser: Drop two bad type hints for now
Date: Wed, 17 May 2023 17:25:16 +0200
Message-Id: <20230517152516.1884640-7-armbru@redhat.com>
In-Reply-To: <20230517152516.1884640-1-armbru@redhat.com>
References: <20230517152516.1884640-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Two type hints fail centos-stream-8-x86_64 CI.  They are actually
broken.  Changing them to Optional[re.Match[str]] fixes them locally
for me, but then CI fails differently.  Drop them for now.

Fixes: 3e32dca3f0d1 (qapi: Rewrite parsing of doc comment section symbols and tags)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20230517061600.1782455-1-armbru@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Igor Mammedov <imammedo@redhat.com>
---
 scripts/qapi/parser.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index acd43cd7e1..22e7bcc4b1 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -563,11 +563,11 @@ def end_comment(self) -> None:
         self._switch_section(QAPIDoc.NullSection(self._parser))
 
     @staticmethod
-    def _match_at_name_colon(string: str) -> re.Match:
+    def _match_at_name_colon(string: str):
         return re.match(r'@([^:]*): *', string)
 
     @staticmethod
-    def _match_section_tag(string: str) -> re.Match:
+    def _match_section_tag(string: str):
         return re.match(r'(Returns|Since|Notes?|Examples?|TODO): *', string)
 
     def _append_body_line(self, line: str) -> None:
-- 
2.39.2


