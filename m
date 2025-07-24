Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0315B10745
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Jul 2025 12:02:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueslJ-00084w-Q7; Thu, 24 Jul 2025 06:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uesl6-0007uW-HL
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 06:01:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uesl4-00045P-Rk
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 06:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753351261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=Wl5RDN1QnIh3CyXqW9wln1wsfGYYE9vvFxxQpnj1B2Y=;
 b=HqhOy8LY3FliFS2f2QtRFN7r6OBtBMdIYIaji6oTTJ3Fn+LLkEREk33lHAd4dKVCB8/JVY
 NPcVkebUENi2B99g9tsEXloBUQYK0UzIDbErVEzXHIPMOvZAPAYOJUqS/WD5m3PTOC7h/l
 uhmveVbnEGAIvVCZ/xbh396RaRzfFNg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-LS8SBE3FPl-fY5DByxNgSg-1; Thu,
 24 Jul 2025 06:00:58 -0400
X-MC-Unique: LS8SBE3FPl-fY5DByxNgSg-1
X-Mimecast-MFC-AGG-ID: LS8SBE3FPl-fY5DByxNgSg_1753351257
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B24F01956048; Thu, 24 Jul 2025 10:00:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3FB371800298; Thu, 24 Jul 2025 10:00:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9552921E6925; Thu, 24 Jul 2025 12:00:54 +0200 (CEST)
Resent-To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Thu, 24 Jul 2025 12:00:54 +0200
Resent-Message-ID: <87v7nhnc15.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com  Thu Jul 24 11:17:42 2025
X-Original-To: armbru
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 606F021E6925; Thu, 24 Jul 2025 11:17:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	eblake@redhat.com,
	philmd@linaro.org
Subject: [PATCH 2/2] tests/qapi-schema: Bury dead test case
 doc-non-first-section
Date: Thu, 24 Jul 2025 11:17:42 +0200
Message-ID: <20250724091742.1950167-3-armbru@redhat.com>
In-Reply-To: <20250724091742.1950167-1-armbru@redhat.com>
References: <20250724091742.1950167-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Lines: 42
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.377,
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

The test passed when it was added.  However, the commit adding it
neglected to make Meson aware of it, so it never ran automatically.
The test stopped making sense when we changed headings markup, and
ceased to pass then.  It should've been removed then.  Do that now.

Fixes: 6c10778826a8 (docs/sphinx: remove special parsing for freeform sections)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qapi-schema/doc-non-first-section.err  | 1 -
 tests/qapi-schema/doc-non-first-section.json | 6 ------
 tests/qapi-schema/doc-non-first-section.out  | 0
 3 files changed, 7 deletions(-)
 delete mode 100644 tests/qapi-schema/doc-non-first-section.err
 delete mode 100644 tests/qapi-schema/doc-non-first-section.json
 delete mode 100644 tests/qapi-schema/doc-non-first-section.out

diff --git a/tests/qapi-schema/doc-non-first-section.err b/tests/qapi-schema/doc-non-first-section.err
deleted file mode 100644
index eeced2bca7..0000000000
--- a/tests/qapi-schema/doc-non-first-section.err
+++ /dev/null
@@ -1 +0,0 @@
-doc-non-first-section.json:5:1: '=' heading must come first in a comment block
diff --git a/tests/qapi-schema/doc-non-first-section.json b/tests/qapi-schema/doc-non-first-section.json
deleted file mode 100644
index 1590876061..0000000000
--- a/tests/qapi-schema/doc-non-first-section.json
+++ /dev/null
@@ -1,6 +0,0 @@
-# = section must be first line
-
-##
-#
-# = Not first
-##
diff --git a/tests/qapi-schema/doc-non-first-section.out b/tests/qapi-schema/doc-non-first-section.out
deleted file mode 100644
index e69de29bb2..0000000000
-- 
2.49.0



