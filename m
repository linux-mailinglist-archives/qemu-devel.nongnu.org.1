Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C6D7F3480
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 18:07:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5UCD-0006ge-Sc; Tue, 21 Nov 2023 12:05:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r5UBq-0006fN-HX
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 12:05:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r5UBk-0002Ch-5i
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 12:05:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700586320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Xsr/xOCeMLorumJj0Rs0SRtlsYp/pb/DRtVGhwLsZcU=;
 b=G4mGgEWoldCqXV8EUILi6pOxpIVZAxfmmarajj7gzXIQ7VLy7NjJcaFjit450zC8ipSSUQ
 mhnbvnanCVE5+X0SEKz7eYcDMDp1h4KINbvRrSOZNxlnSJ5OdcT2UKEAGFLoYYu/obRWQJ
 OGmavdFb2yGe6DtLnlr79NiC2h9a7AQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-yzE1e7G6MZmNC0edHDm-Zw-1; Tue, 21 Nov 2023 12:05:16 -0500
X-MC-Unique: yzE1e7G6MZmNC0edHDm-Zw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CCF185CBF2;
 Tue, 21 Nov 2023 17:05:16 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1BBA6492BFA;
 Tue, 21 Nov 2023 17:05:16 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] scripts: adjust url to Coverity tools
Date: Tue, 21 Nov 2023 12:05:15 -0500
Message-Id: <20231121170515.1171293-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The URL to the Coverity tools download has changed; the old one points
to an obsolete version that is not supported anymore.  Adjust to point
to the correct and supported tools.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/coverity-scan/run-coverity-scan | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/coverity-scan/run-coverity-scan b/scripts/coverity-scan/run-coverity-scan
index 129672c86f..d56c9b6677 100755
--- a/scripts/coverity-scan/run-coverity-scan
+++ b/scripts/coverity-scan/run-coverity-scan
@@ -116,14 +116,14 @@ update_coverity_tools () {
     cd "$COVERITY_TOOL_BASE"
 
     echo "Checking for new version of coverity build tools..."
-    wget https://scan.coverity.com/download/linux64 --post-data "token=$COVERITY_TOKEN&project=$PROJNAME&md5=1" -O coverity_tool.md5.new
+    wget https://scan.coverity.com/download/cxx/linux64 --post-data "token=$COVERITY_TOKEN&project=$PROJNAME&md5=1" -O coverity_tool.md5.new
 
     if ! cmp -s coverity_tool.md5 coverity_tool.md5.new; then
         # out of date md5 or no md5: download new build tool
         # blow away the old build tool
         echo "Downloading coverity build tools..."
         rm -rf coverity_tool coverity_tool.tgz
-        wget https://scan.coverity.com/download/linux64 --post-data "token=$COVERITY_TOKEN&project=$PROJNAME" -O coverity_tool.tgz
+        wget https://scan.coverity.com/download/cxx/linux64 --post-data "token=$COVERITY_TOKEN&project=$PROJNAME" -O coverity_tool.tgz
         if ! (cat coverity_tool.md5.new; echo "  coverity_tool.tgz") | md5sum -c --status; then
             echo "Downloaded tarball didn't match md5sum!"
             exit 1
-- 
2.39.1


