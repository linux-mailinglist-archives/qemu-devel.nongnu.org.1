Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C61B97EC40D
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 14:49:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3GFT-00086X-3v; Wed, 15 Nov 2023 08:48:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1r3GFQ-00085z-Oa
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 08:48:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1r3GFO-0006xO-VC
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 08:48:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700056081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=anQX3qmlZryWy6jw6wdQBLhvj40k5odFfFHZzOhRmdM=;
 b=DrzAHt9ZCiqcPvfosbZsE+qHFA7Rg6dKD9xh60oIi94mdvnW333WPv5OUQLyQd3H58ge9T
 rz5N1WHs1hRR+74lSSETayFPI8AXKqwU/JuLxIBu6RFm2mL/sA0l495zJnsSQeK82oZFoo
 HHjPn0MvvaiJH44HisHswoFV2tnpfQ0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-MfqE1e6YOte0g8neRwTsVw-1; Wed, 15 Nov 2023 08:47:59 -0500
X-MC-Unique: MfqE1e6YOte0g8neRwTsVw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B384E89C800
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 13:47:59 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.115])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 23DD82166B27;
 Wed, 15 Nov 2023 13:47:59 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] docs/system: Add recommendations to Hyper-V enlightenments doc
Date: Wed, 15 Nov 2023 14:47:58 +0100
Message-ID: <20231115134758.392673-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
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

While hyperv.rst already has all currently implemented Hyper-V
enlightenments documented, it may be unclear what is the recommended set to
achieve the best result. Add the corresponding section to the doc.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 docs/system/i386/hyperv.rst | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/docs/system/i386/hyperv.rst b/docs/system/i386/hyperv.rst
index 2505dc4c86e0..1c7c4a3981ea 100644
--- a/docs/system/i386/hyperv.rst
+++ b/docs/system/i386/hyperv.rst
@@ -278,6 +278,36 @@ Supplementary features
   feature alters this behavior and only allows the guest to use exposed Hyper-V
   enlightenments.
 
+Recommendations
+---------------
+
+To achieve the best performance of Windows and Hyper-V guests and unless there
+are any specific requirements (e.g. migration to older QEMU/KVM versions,
+emulating specific Hyper-V version, ...), it is recommended to enable all
+currently implemented Hyper-V enlightenments with the following exceptions:
+
+- ``hv-syndbg``, ``hv-passthrough``, ``hv-enforce-cpuid`` should not be enabled
+  in production configurations as these are debugging/development features.
+- ``hv-reset`` can be avoided as modern Hyper-V versions don't expose it.
+- ``hv-evmcs`` can (and should) be enabled on Intel CPUs only. While the feature
+  is only used in nested configurations (Hyper-V, WSL2), enabling it for regular
+  Windows guests should not have any negative effects.
+- ``hv-no-nonarch-coresharing`` must only be enabled if vCPUs are properly pinned
+  so no non-architectural core sharing is possible.
+- ``hv-vendor-id``, ``hv-version-id-build``, ``hv-version-id-major``,
+  ``hv-version-id-minor``, ``hv-version-id-spack``, ``hv-version-id-sbranch``,
+  ``hv-version-id-snumber`` can be left unchanged, guests are not supposed to
+  behave differently when different Hyper-V version is presented to them.
+- ``hv-crash`` must only be enabled if the crash information is consumed via
+  QAPI by higher levels of the virtualization stack. Enabling this feature
+  effectively prevents Windows from creating dumps upon crashes.
+- ``hv-reenlightenment`` can only be used on hardware which supports TSC
+  scaling or when guest migration is not needed.
+- ``hv-spinlocks`` should be set to e.g. 0xfff when host CPUs are overcommited
+  (meaning there are other scheduled tasks or guests) and can be left unchanged
+  from the default value (0xffffffff) otherwise.
+- ``hv-avic``/``hv-apicv`` should not be enabled if the hardware does not
+  support APIC virtualization (Intel APICv, AMD AVIC).
 
 Useful links
 ------------
-- 
2.41.0


