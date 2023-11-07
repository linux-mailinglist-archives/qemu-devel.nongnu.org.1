Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C223D7E4858
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:34:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0QsY-0002p7-AK; Tue, 07 Nov 2023 13:32:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r0QsW-0002ni-Bd
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:32:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r0QsU-0007Ng-9v
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:32:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699381961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P9N4XAMcG1M7aNdTvXweTcO2BcWqwho18VxNhTCwbE0=;
 b=IYX+d6NcI3XfawAbOQHumjZ+KtZh+AaonJlAEeNFzu2+58MgihH7y6bdNmmOqXEPoH8S+N
 vq/V91ROlAcBpWSmtciZFG1xpJBbTz5KtUn9+BG4zBhwiQ40DptLB32dUOItiKOUC+MJMO
 ejXr8JfGwSdygkvHHqiLmOl1q0yB/u0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-45hdTzT5MZKhq0n5-vCASg-1; Tue, 07 Nov 2023 13:32:38 -0500
X-MC-Unique: 45hdTzT5MZKhq0n5-vCASg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7C8E85A58B;
 Tue,  7 Nov 2023 18:32:37 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2CAC12166B27;
 Tue,  7 Nov 2023 18:32:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>
Subject: [PULL 04/11] s390/sclp: fix SCLP facility map
Date: Tue,  7 Nov 2023 19:32:21 +0100
Message-ID: <20231107183228.276424-5-thuth@redhat.com>
In-Reply-To: <20231107183228.276424-1-thuth@redhat.com>
References: <20231107183228.276424-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

From: Heiko Carstens <hca@linux.ibm.com>

Qemu's SCLP implementation incorrectly reports that it supports CPU
reconfiguration. If a guest issues a CPU reconfiguration request it
is rejected as invalid command.

Fix the SCLP_HAS_CPU_INFO mask, and remove the unused
SCLP_CMDW_CONFIGURE_CPU and SCLP_CMDW_DECONFIGURE_CPU defines.

Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Message-ID: <20231024100703.929679-1-hca@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/s390x/sclp.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
index 9aef6d9370..b4ecd04e23 100644
--- a/include/hw/s390x/sclp.h
+++ b/include/hw/s390x/sclp.h
@@ -38,10 +38,8 @@
 #define MAX_STORAGE_INCREMENTS                  1020
 
 /* CPU hotplug SCLP codes */
-#define SCLP_HAS_CPU_INFO                       0x0C00000000000000ULL
+#define SCLP_HAS_CPU_INFO                       0x0800000000000000ULL
 #define SCLP_CMDW_READ_CPU_INFO                 0x00010001
-#define SCLP_CMDW_CONFIGURE_CPU                 0x00110001
-#define SCLP_CMDW_DECONFIGURE_CPU               0x00100001
 
 /* SCLP PCI codes */
 #define SCLP_HAS_IOA_RECONFIG                   0x0000000040000000ULL
-- 
2.41.0


