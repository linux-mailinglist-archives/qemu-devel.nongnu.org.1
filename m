Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A8BB0C8A6
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Jul 2025 18:25:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtJV-0006lP-6j; Mon, 21 Jul 2025 12:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtIH-0003iG-Im
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:23:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtIE-0001Rd-Rk
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753114989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zNNGby1h709b31T6L7CLVx3l9zQwZoveLZOvkgOivvU=;
 b=DqoecJtiMmRpLLnxlcNO14Lg9dhKa7GqRFHcT65GjxGVBLNy1LfmTvytCnpRH55Y3LydqB
 y9wXkJwjzkCNk8KaqgCyGSsopH48IK3aEbj+gEUcESu91FA0c/fZ2FLqIOezPrR6WYaQVB
 HRP2MMmVpGrkx5UoB9Cb2XGvOzp16/U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-DfnAs3a7NT-I7MQ8pzxs6w-1; Mon,
 21 Jul 2025 12:23:08 -0400
X-MC-Unique: DfnAs3a7NT-I7MQ8pzxs6w-1
X-Mimecast-MFC-AGG-ID: DfnAs3a7NT-I7MQ8pzxs6w_1753114986
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C13461800C37; Mon, 21 Jul 2025 16:23:06 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 517FF19560AD; Mon, 21 Jul 2025 16:23:04 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 10/50] ppc/xive2: Fix treatment of PIPR in CPPR update
Date: Mon, 21 Jul 2025 18:21:53 +0200
Message-ID: <20250721162233.686837-11-clg@redhat.com>
In-Reply-To: <20250721162233.686837-1-clg@redhat.com>
References: <20250721162233.686837-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Glenn Miles <milesg@linux.ibm.com>

According to the XIVE spec, updating the CPPR should also update the
PIPR. The final value of the PIPR depends on other factors, but it
should never be set to a value that is above the CPPR.

Also added support for redistributing an active group interrupt when it
is precluded as a result of changing the CPPR value.

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-11-npiggin@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/intc/xive2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 36e842f041e5..c23933f8f550 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -995,7 +995,9 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
             }
         }
     }
-    regs[TM_PIPR] = pipr_min;
+
+    /* PIPR should not be set to a value greater than CPPR */
+    regs[TM_PIPR] = (pipr_min > cppr) ? cppr : pipr_min;
 
     rc = xive2_tctx_get_nvp_indexes(tctx, ring_min, &nvp_blk, &nvp_idx);
     if (rc) {
-- 
2.50.1


