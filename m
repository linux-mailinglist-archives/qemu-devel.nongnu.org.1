Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 071DEA30E62
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Feb 2025 15:35:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thrKq-0006S4-0q; Tue, 11 Feb 2025 09:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1thrKn-0006Rb-Br
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 09:33:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1thrKl-0001sT-Lc
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 09:33:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739284435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rWeM8xEh0bgDY2ynaZY0NiCmiLKkWLzv3qy5lwA7tlY=;
 b=C8ahcU19t+265cMjjgKZMYvFUtT6MF/6kFg+9CgCoVi19StjRrXSchKAhWJqaqzNSUhA20
 FUzvsEen9jdhyHER9wiU5xURiaBISp3cH8dvueVPXBaVvZXU4P4nM4Nd+oQr8z6J02yYhv
 vOnEoARXzAvKhCiKeYrtAeURHduf/Cw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-539-_sHfBJwYPJmaUxNbIRugew-1; Tue,
 11 Feb 2025 09:33:50 -0500
X-MC-Unique: _sHfBJwYPJmaUxNbIRugew-1
X-Mimecast-MFC-AGG-ID: _sHfBJwYPJmaUxNbIRugew
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B36F1801A10
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 14:33:49 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.39])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 19F7F18008CC; Tue, 11 Feb 2025 14:33:47 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 01/12] vfio/igd: Fix potential overflow in igd_gtt_memory_size()
Date: Tue, 11 Feb 2025 15:33:29 +0100
Message-ID: <20250211143340.787996-2-clg@redhat.com>
In-Reply-To: <20250211143340.787996-1-clg@redhat.com>
References: <20250211143340.787996-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The risk is mainly theoretical since the applied bit mask will keep
the 'ggms' shift value below 3. Nevertheless, let's use a 64 bit
integer type and resolve the coverity issue.

Resolves: Coverity CID 1585908
Fixes: 1e1eac5f3dcd ("vfio/igd: canonicalize memory size calculations")
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Link: https://lore.kernel.org/r/20250107130604.669697-1-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/igd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 0740a5dd8cc9346a92c4613194faa8dea42e1d98..b5303ea565d6a344d0a43273f288bbb4a7f48327 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -133,7 +133,7 @@ static uint64_t igd_gtt_memory_size(int gen, uint16_t gmch)
     } else {
         ggms = (gmch >> IGD_GMCH_GEN8_GGMS_SHIFT) & IGD_GMCH_GEN8_GGMS_MASK;
         if (ggms != 0) {
-            ggms = 1 << ggms;
+            ggms = 1ULL << ggms;
         }
     }
 
-- 
2.48.1


