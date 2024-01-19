Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCCA832C53
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 16:27:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQqkE-0002Ip-Rj; Fri, 19 Jan 2024 10:25:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQqkC-0002Hs-6U
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 10:25:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQqk9-00018n-LH
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 10:25:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705677917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=frOfiuPvlXeFwZNxIDBC2vX8XG6P3rdgVHQ3kvF57ag=;
 b=HASOR2uBtkCQHKMJwXg2qxD9pWTf3o4tb4E1i6rF44SYYrtPsE8Pqs4gczn6FYNKnfr7gY
 ZrjHNQkkn5vAAY/TtnBOPFRtI32LCkP/sac7qDRlEUVFhVeJECac9JCXOxW3eXLrQcQor7
 O6KPlCwtf57ED4SSoNHig4wqW3Dxdwc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247--Dr-qSCQO3mj77-zUgWAXw-1; Fri,
 19 Jan 2024 10:25:12 -0500
X-MC-Unique: -Dr-qSCQO3mj77-zUgWAXw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B03A285F9B2;
 Fri, 19 Jan 2024 15:25:12 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.235])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 015F240D1B60;
 Fri, 19 Jan 2024 15:25:10 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 02/11] s390x/pci: refresh fh before disabling aif
Date: Fri, 19 Jan 2024 16:24:58 +0100
Message-ID: <20240119152507.55182-3-thuth@redhat.com>
In-Reply-To: <20240119152507.55182-1-thuth@redhat.com>
References: <20240119152507.55182-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
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

From: Matthew Rosato <mjrosato@linux.ibm.com>

Typically we refresh the host fh during CLP enable, however it's possible
that the device goes through multiple reset events before the guest
performs another CLP enable.  Let's handle this for now by refreshing the
host handle from vfio before disabling aif.

Fixes: 03451953c7 ("s390x/pci: reset ISM passthrough devices on shutdown and system reset")
Reported-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Message-ID: <20240118185151.265329-3-mjrosato@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-pci-kvm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/s390x/s390-pci-kvm.c b/hw/s390x/s390-pci-kvm.c
index 1ee510436c..9eef4fc3ec 100644
--- a/hw/s390x/s390-pci-kvm.c
+++ b/hw/s390x/s390-pci-kvm.c
@@ -18,6 +18,7 @@
 #include "hw/s390x/s390-pci-bus.h"
 #include "hw/s390x/s390-pci-kvm.h"
 #include "hw/s390x/s390-pci-inst.h"
+#include "hw/s390x/s390-pci-vfio.h"
 #include "cpu_models.h"
 
 bool s390_pci_kvm_interp_allowed(void)
@@ -64,6 +65,14 @@ int s390_pci_kvm_aif_disable(S390PCIBusDevice *pbdev)
         return -EINVAL;
     }
 
+    /*
+     * The device may have already been reset but we still want to relinquish
+     * the guest ISC, so always be sure to use an up-to-date host fh.
+     */
+    if (!s390_pci_get_host_fh(pbdev, &args.fh)) {
+        return -EPERM;
+    }
+
     rc = kvm_vm_ioctl(kvm_state, KVM_S390_ZPCI_OP, &args);
     if (rc == 0) {
         pbdev->aif = false;
-- 
2.43.0


