Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB06B75A798
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 09:18:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMNtj-0000nl-71; Thu, 20 Jul 2023 03:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qMNtZ-0000fW-Q1
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 03:16:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qMNtW-0007Uf-TJ
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 03:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689837373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XpOJGuS1jqrtLNbih9X78d4vyNoiUN5qW48IyvM/zEU=;
 b=RRLd8HOI0vGK/krk2KsWoONxsI/8v0uBsR3aMlzAi8kVXFy3VTLH8UBUzT3kzhLdlUZHiC
 Qv6/PYpBVEZKGpVu1LPIqYBJoc72+KtQXmcKwi+8aVD+iYODBhly/vP1P86cQaXhP5+OWE
 GLzFM/D469W/BKVKdIY/8KaaaZkcqf8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-Fk8-xcGJNrKuQvlYC0KAUw-1; Thu, 20 Jul 2023 03:16:11 -0400
X-MC-Unique: Fk8-xcGJNrKuQvlYC0KAUw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CAE287321E
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 07:16:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D0E7492CAC
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 07:16:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 09B4121E5A0E; Thu, 20 Jul 2023 09:16:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com
Subject: [PATCH 2/6] qapi/block: Tidy up block-latency-histogram-set
 documentation
Date: Thu, 20 Jul 2023 09:16:05 +0200
Message-ID: <20230720071610.1096458-3-armbru@redhat.com>
In-Reply-To: <20230720071610.1096458-1-armbru@redhat.com>
References: <20230720071610.1096458-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Examples come out like

    Example

       set new histograms for all io types with intervals [0, 10), [10,
       50), [50, 100), [100, +inf):

The sentence "set new histograms ..." starts with a lower case letter.
Capitalize it.  Same for the other examples.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block.json | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/qapi/block.json b/qapi/block.json
index 0f25ce3961..535892fddc 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -547,7 +547,7 @@
 #
 # Example:
 #
-# set new histograms for all io types with intervals [0, 10), [10,
+# Set new histograms for all io types with intervals [0, 10), [10,
 # 50), [50, 100), [100, +inf):
 #
 # -> { "execute": "block-latency-histogram-set",
@@ -557,7 +557,7 @@
 #
 # Example:
 #
-# set new histogram only for write, other histograms will remain not
+# Set new histogram only for write, other histograms will remain not
 # changed (or not created):
 #
 # -> { "execute": "block-latency-histogram-set",
@@ -567,7 +567,7 @@
 #
 # Example:
 #
-# set new histograms with the following intervals:   read, flush: [0,
+# Set new histograms with the following intervals:   read, flush: [0,
 # 10), [10, 50), [50, 100), [100, +inf)   write: [0, 1000), [1000,
 # 5000), [5000, +inf)
 #
@@ -579,7 +579,7 @@
 #
 # Example:
 #
-# remove all latency histograms:
+# Remove all latency histograms:
 #
 # -> { "execute": "block-latency-histogram-set",
 #      "arguments": { "id": "drive0" } }
-- 
2.41.0


