Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D05757819
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 11:33:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLh2l-000414-QH; Tue, 18 Jul 2023 05:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qLh2f-0003zb-Hm
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 05:30:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qLh2d-0004C0-Vp
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 05:30:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689672646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qZeEJXXcsKrADfEPlgmlgoy3efKYccao4IULmLaV7SQ=;
 b=dyIGU7PLXw60rB3dWBbrZW/qDahiPfKQ8K/zOkgiS9sDCF2EOlGMGtNEujIDWJ9V4gNO0O
 i+prkFK3h9ySYw9NX49RPXCVUn5EmIPWy518zpeJPkVxuxBX7AZHfHs7ttzQmBIvPT62f0
 V+W8suIi02Avq4uLvS5h5BSJ7DPJxo4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-xk85MK4mPeahozjIoa8DTg-1; Tue, 18 Jul 2023 05:30:44 -0400
X-MC-Unique: xk85MK4mPeahozjIoa8DTg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F21185A58A;
 Tue, 18 Jul 2023 09:30:44 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 41A2D2166B25;
 Tue, 18 Jul 2023 09:30:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/8] s390x: Fix QEMU abort by selecting S390_FLIC_KVM
Date: Tue, 18 Jul 2023 11:30:33 +0200
Message-Id: <20230718093040.172145-2-thuth@redhat.com>
In-Reply-To: <20230718093040.172145-1-thuth@redhat.com>
References: <20230718093040.172145-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Cédric Le Goater <clg@redhat.com>

If QEMU is built with --without-default-devices, the s390-flic-kvm
device is missing and QEMU aborts when started with the KVM accelerator.
Make sure it's available by selecting S390_FLIC_KVM in Kconfig.

Consequently, this also fixes an abort in tests/qtest/migration-test.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20230711151440.716822-1-clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/intc/Kconfig  | 1 -
 hw/s390x/Kconfig | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 21441d0a0c..97d550b06b 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -49,7 +49,6 @@ config S390_FLIC
 
 config S390_FLIC_KVM
     bool
-    default y
     depends on S390_FLIC && KVM
 
 config OMPIC
diff --git a/hw/s390x/Kconfig b/hw/s390x/Kconfig
index e8d4d68ece..4c068d7960 100644
--- a/hw/s390x/Kconfig
+++ b/hw/s390x/Kconfig
@@ -8,6 +8,7 @@ config S390_CCW_VIRTIO
     imply PCIE_DEVICES
     select PCI_EXPRESS
     select S390_FLIC
+    select S390_FLIC_KVM if KVM
     select SCLPCONSOLE
     select VIRTIO_CCW
     select MSI_NONBROKEN
-- 
2.39.3


