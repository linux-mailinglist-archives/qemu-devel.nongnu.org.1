Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85328B0BC3D
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Jul 2025 08:03:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udjbE-0000pa-5Y; Mon, 21 Jul 2025 02:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1udjZL-0008Ls-OH
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 02:00:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1udjZK-0006Mq-7u
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 02:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753077609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Azr2cluQxKXYj/39PD27Knk3I9DTPyWGGR88WltCJEM=;
 b=TwakyZ9xXTnIh96XRzuBOd60lDyoOMS0zshD4nOxqpRwjnUzPVUYpk2NrP2tqjrIpZ05qh
 ulvxt2KU67KRYA7QCkHnut75unRrJYKuwMxY9wdOiZtyjFs5++FUvTIeTZHXd2od1z/SbG
 cybUYqBrTyZrc2FKfkIZiE/cSQ5VhzM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-fQj9bD1iMYCp0XpErAg2Zg-1; Mon,
 21 Jul 2025 02:00:05 -0400
X-MC-Unique: fQj9bD1iMYCp0XpErAg2Zg-1
X-Mimecast-MFC-AGG-ID: fQj9bD1iMYCp0XpErAg2Zg_1753077604
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F5AA1800368; Mon, 21 Jul 2025 06:00:04 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.190])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 47F781956050; Mon, 21 Jul 2025 06:00:01 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 10/12] net/passt: Check return value of g_remove() in
 net_passt_cleanup() (CID 1612369)
Date: Mon, 21 Jul 2025 13:59:25 +0800
Message-ID: <20250721055927.75951-11-jasowang@redhat.com>
In-Reply-To: <20250721055927.75951-1-jasowang@redhat.com>
References: <20250721055927.75951-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Laurent Vivier <lvivier@redhat.com>

If g_remove() fails, use warn_report() to log an error.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/passt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/passt.c b/net/passt.c
index ef59d0682b..43c336e596 100644
--- a/net/passt.c
+++ b/net/passt.c
@@ -103,7 +103,10 @@ static void net_passt_cleanup(NetClientState *nc)
 #endif
 
     kill(s->pid, SIGTERM);
-    g_remove(s->pidfile);
+    if (g_remove(s->pidfile) != 0) {
+        warn_report("Failed to remove passt pidfile %s: %s",
+                    s->pidfile, strerror(errno));
+    }
     g_free(s->pidfile);
     g_ptr_array_free(s->args, TRUE);
 }
-- 
2.42.0


