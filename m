Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DA37B34BE
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 16:20:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmEL9-0004l4-4J; Fri, 29 Sep 2023 10:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qmEL6-0004km-Pa
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:19:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qmEL1-0006Xz-7B
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695997165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=iqYMIamWrP/SmmBX8/AGSzxUrEhRLkqiXJbY7Cy23Q8=;
 b=Lbrr/oRbAHq5PordVA4eaLn4t+OVEbeNXPZCBmKm2ByHD8MXjpWOFrPU4xKpTTEdk2DtNb
 Q2As60gF6z7h6EKl1hkfRghIlfK+8JPqKvK0QOGSFeT1W42nxvcNf/YNpEdPECu+I+Ht9q
 /xNlbnQf1NM7QCZ8qC2XoRQYVxUUZ7g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-T82n9d5mN9uZFysUu7E65Q-1; Fri, 29 Sep 2023 10:19:21 -0400
X-MC-Unique: T82n9d5mN9uZFysUu7E65Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ECFEB811E8D;
 Fri, 29 Sep 2023 14:19:20 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.194])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E5582156702;
 Fri, 29 Sep 2023 14:19:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Radoslaw Biernacki <rad@semihalf.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>
Cc: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] MAINTAINERS: Add some unowned files to the SBSA-REF section
Date: Fri, 29 Sep 2023 16:19:18 +0200
Message-ID: <20230929141918.397096-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

These files belong to the sbsa-ref machine and thus should
be listed here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 874234cb7b..fc415d3cea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -954,6 +954,9 @@ R: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/sbsa-ref.c
+F: hw/misc/sbsa_ec.c
+F: hw/watchdog/sbsa_gwdt.c
+F: include/hw/watchdog/sbsa_gwdt.h
 F: docs/system/arm/sbsa.rst
 F: tests/avocado/machine_aarch64_sbsaref.py
 
-- 
2.41.0


