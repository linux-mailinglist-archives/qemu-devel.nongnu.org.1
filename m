Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0764882E833
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 04:22:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPa1S-0007gc-4h; Mon, 15 Jan 2024 22:21:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPa0i-0006HG-Q0
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 22:21:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPa0g-00037X-NP
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 22:21:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705375266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gicgabJmF07S0wCWqnYSu+RO4ouf2Ed+JzSkPhuW3+g=;
 b=AwBr2+XgLAlMmzM7CnOgv+1jD6mIfATWUeKiJMQDf08ycrMky+ogdQ2x72dn9irzxJaYh8
 7Pf/l7j4BcepNNd85pYMekOWw9vWrDhhRrkTPYcrGIo8nvW77MZ6X0jUu3aogj5WoDhxrZ
 7zzKneOO2e459GkKToYB/E+FoPjm+t0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-j2tHyg1VNJCg_xFO9vc-Zg-1; Mon,
 15 Jan 2024 22:21:03 -0500
X-MC-Unique: j2tHyg1VNJCg_xFO9vc-Zg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F3C663C025C4;
 Tue, 16 Jan 2024 03:21:02 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 345463C25;
 Tue, 16 Jan 2024 03:20:59 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Nick Briggs <nicholas.h.briggs@gmail.com>
Subject: [PULL 20/20] migration/rdma: define htonll/ntohll only if not
 predefined
Date: Tue, 16 Jan 2024 11:19:47 +0800
Message-ID: <20240116031947.69017-21-peterx@redhat.com>
In-Reply-To: <20240116031947.69017-1-peterx@redhat.com>
References: <20240116031947.69017-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
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

From: Nick Briggs <nicholas.h.briggs@gmail.com>

Solaris has #defines for htonll and ntohll which cause syntax errors
when compiling code that attempts to (re)define these functions..

Signed-off-by: Nick Briggs <nicholas.h.briggs@gmail.com>
Link: https://lore.kernel.org/r/65a04a7d.497ab3.3e7bef1f@gateway.sonic.net
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/rdma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/migration/rdma.c b/migration/rdma.c
index 94c0f871f0..a355dcea89 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -238,6 +238,7 @@ static const char *control_desc(unsigned int rdma_control)
     return strs[rdma_control];
 }
 
+#if !defined(htonll)
 static uint64_t htonll(uint64_t v)
 {
     union { uint32_t lv[2]; uint64_t llv; } u;
@@ -245,13 +246,16 @@ static uint64_t htonll(uint64_t v)
     u.lv[1] = htonl(v & 0xFFFFFFFFULL);
     return u.llv;
 }
+#endif
 
+#if !defined(ntohll)
 static uint64_t ntohll(uint64_t v)
 {
     union { uint32_t lv[2]; uint64_t llv; } u;
     u.llv = v;
     return ((uint64_t)ntohl(u.lv[0]) << 32) | (uint64_t) ntohl(u.lv[1]);
 }
+#endif
 
 static void dest_block_to_network(RDMADestBlock *db)
 {
-- 
2.43.0


