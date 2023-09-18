Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA8C7A44D4
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 10:34:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi9hR-0008E6-Oh; Mon, 18 Sep 2023 04:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qi9gC-0006Dc-Kv
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 04:32:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qi9g9-0004EM-QM
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 04:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695025944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mpfkHZQ8To5Z9cDg2CPd2qbNj4EPmVwpb4HomuZAUH8=;
 b=g2GSlE+TtHbA4LwsYDTNEn9cm374yTqqV06BJuKJbDBkOnENKIyqgRz5pouuQZhB+xF6DH
 x+k7dtiwNn5EzqiH6bxorI/ZtTnql2sVpiUNtcftdEBUaqOlQEQFBIs0wPE2PAwFZfOLUm
 4DFXYf8ScPf9MOZcwjqtRQ169Lvp0So=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-295-QrB7RK1yNdyCn1H5Pfk5og-1; Mon, 18 Sep 2023 04:32:20 -0400
X-MC-Unique: QrB7RK1yNdyCn1H5Pfk5og-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F0D2185A78E;
 Mon, 18 Sep 2023 08:32:20 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.113.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C6FFF2156701;
 Mon, 18 Sep 2023 08:32:17 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL V2 15/17] hw/net/rocker: Avoid variable length array
Date: Mon, 18 Sep 2023 16:31:30 +0800
Message-Id: <20230918083132.55423-16-jasowang@redhat.com>
In-Reply-To: <20230918083132.55423-1-jasowang@redhat.com>
References: <20230918083132.55423-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
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

From: Peter Maydell <peter.maydell@linaro.org>

Replace an on-stack variable length array in of_dpa_ig() with
a g_autofree heap allocation.

The codebase has very few VLAs, and if we can get rid of them all we
can make the compiler error on new additions.  This is a defensive
measure against security bugs where an on-stack dynamic allocation
isn't correctly size-checked (e.g.  CVE-2021-3527).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/rocker/rocker_of_dpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/rocker/rocker_of_dpa.c b/hw/net/rocker/rocker_of_dpa.c
index dfe4754..5e16056 100644
--- a/hw/net/rocker/rocker_of_dpa.c
+++ b/hw/net/rocker/rocker_of_dpa.c
@@ -1043,7 +1043,7 @@ static void of_dpa_flow_ig_tbl(OfDpaFlowContext *fc, uint32_t tbl_id)
 static ssize_t of_dpa_ig(World *world, uint32_t pport,
                          const struct iovec *iov, int iovcnt)
 {
-    struct iovec iov_copy[iovcnt + 2];
+    g_autofree struct iovec *iov_copy = g_new(struct iovec, iovcnt + 2);
     OfDpaFlowContext fc = {
         .of_dpa = world_private(world),
         .in_pport = pport,
-- 
2.7.4


