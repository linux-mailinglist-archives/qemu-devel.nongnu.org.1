Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EEEA11B18
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Jan 2025 08:40:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXxz8-0005A3-RY; Wed, 15 Jan 2025 02:38:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tXxz6-00059X-LT
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 02:38:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tXxz5-0007qR-53
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 02:38:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736926717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fiJKKitgM5DanHKXYYZjFCzuQYPBryo2TpK0bi6DK50=;
 b=EPhycLqBwqsOTSPKQUeCsfBpv/MK/A5ye7vJ9+6Z4G2pi0vvdmQBBqfS/u9cGPJefM/nn5
 qpzeAlrAFlt9HrELuDqtzVuvXsuAyMiXJUfHM3w3NnXUevwhDjavzSEsJrBMZhdVh5xuDn
 zEE5iOd0mroo8EvndfNMUBTTU25qoMQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-SP-e2OOSPAyID1OxyWJjdQ-1; Wed,
 15 Jan 2025 02:38:32 -0500
X-MC-Unique: SP-e2OOSPAyID1OxyWJjdQ-1
X-Mimecast-MFC-AGG-ID: SP-e2OOSPAyID1OxyWJjdQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8CA8319560B9; Wed, 15 Jan 2025 07:38:31 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.143])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A13D2195608A; Wed, 15 Jan 2025 07:38:26 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 1/8] hw/s390x/s390-virtio-ccw: Remove the deprecated 2.9
 machine type
Date: Wed, 15 Jan 2025 08:38:12 +0100
Message-ID: <20250115073819.15452-2-thuth@redhat.com>
In-Reply-To: <20250115073819.15452-1-thuth@redhat.com>
References: <20250115073819.15452-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The s390-ccw-virtio-2.9 machine is older than 6 years, so according to
our machine support policy, it can be removed now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 38aeba14ee..b5635c43c4 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -1236,30 +1236,6 @@ static void ccw_machine_2_10_class_options(MachineClass *mc)
 }
 DEFINE_CCW_MACHINE(2, 10);
 
-static void ccw_machine_2_9_instance_options(MachineState *machine)
-{
-    ccw_machine_2_10_instance_options(machine);
-    s390_cpudef_featoff_greater(12, 1, S390_FEAT_ESOP);
-    s390_cpudef_featoff_greater(12, 1, S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2);
-    s390_cpudef_featoff_greater(12, 1, S390_FEAT_ZPCI);
-    s390_cpudef_featoff_greater(12, 1, S390_FEAT_ADAPTER_INT_SUPPRESSION);
-    s390_cpudef_featoff_greater(12, 1, S390_FEAT_ADAPTER_EVENT_NOTIFICATION);
-    css_migration_enabled = false;
-}
-
-static void ccw_machine_2_9_class_options(MachineClass *mc)
-{
-    static GlobalProperty compat[] = {
-        { TYPE_S390_STATTRIB, "migration-enabled", "off", },
-        { TYPE_S390_FLIC_COMMON, "migration-enabled", "off", },
-    };
-
-    ccw_machine_2_10_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_9, hw_compat_2_9_len);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
-}
-DEFINE_CCW_MACHINE(2, 9);
-
 #endif
 
 static void ccw_machine_register_types(void)
-- 
2.47.1


