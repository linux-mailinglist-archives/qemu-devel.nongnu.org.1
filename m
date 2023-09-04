Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6228C7912FC
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 10:09:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd4c1-0002Ap-K4; Mon, 04 Sep 2023 04:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qd4by-00021x-5m
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 04:07:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qd4bu-0006XH-He
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 04:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693814821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k2oowtsVMHgV/gX0BOO0dY/1y0XnnvK0ZYYn6+GB3/M=;
 b=G3ci9UHYBHdphjoI5VilKRQIIRNDsR/vaM5w+80TwiVLbK0RxPIYoRf37Pgxnj1pXn++0y
 1ajtu76SmOUPJj5aP5uXodTINGeWQdSMqH9roZwD6y7hD2S3z7YYvzRH1QMC5ser/VkEBT
 RbdEJAh3eR4ygNvkDB/z+ky36J9kYyk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-353-_0rgm7GvMgSy4SMH_2zrvQ-1; Mon, 04 Sep 2023 04:05:21 -0400
X-MC-Unique: _0rgm7GvMgSy4SMH_2zrvQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F36A8EE7C5;
 Mon,  4 Sep 2023 08:05:21 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 28AD440C6CCC;
 Mon,  4 Sep 2023 08:05:18 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, alex.williamson@redhat.com, clg@redhat.com,
 jean-philippe@linaro.org, mst@redhat.com, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org
Subject: [PATCH 08/13] range: Make range_compare() public
Date: Mon,  4 Sep 2023 10:03:51 +0200
Message-ID: <20230904080451.424731-9-eric.auger@redhat.com>
In-Reply-To: <20230904080451.424731-1-eric.auger@redhat.com>
References: <20230904080451.424731-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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

Let's expose range_compare() in the header so that it can be
reused outside of util/range.c

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/qemu/range.h | 6 ++++++
 util/range.c         | 6 +-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/qemu/range.h b/include/qemu/range.h
index fc1d3dabe6..52641dfb79 100644
--- a/include/qemu/range.h
+++ b/include/qemu/range.h
@@ -217,6 +217,12 @@ static inline int ranges_overlap(uint64_t first1, uint64_t len1,
     return !(last2 < first1 || last1 < first2);
 }
 
+/*
+ * Return -1 if @a < @b, 1 @a > @b, and 0 if they touch or overlap.
+ * Both @a and @b must not be empty.
+ */
+int range_compare(Range *a, Range *b);
+
 GList *range_list_insert(GList *list, Range *data);
 
 void range_inverse_array(uint32_t nr_ranges, Range *ranges,
diff --git a/util/range.c b/util/range.c
index 11c4ff0b78..1fc399e88f 100644
--- a/util/range.c
+++ b/util/range.c
@@ -20,11 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/range.h"
 
-/*
- * Return -1 if @a < @b, 1 @a > @b, and 0 if they touch or overlap.
- * Both @a and @b must not be empty.
- */
-static inline int range_compare(Range *a, Range *b)
+int range_compare(Range *a, Range *b)
 {
     assert(!range_is_empty(a) && !range_is_empty(b));
 
-- 
2.41.0


