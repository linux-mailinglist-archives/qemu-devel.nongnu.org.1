Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20111AB69F2
	for <lists+qemu-devel@lfdr.de>; Wed, 14 May 2025 13:29:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAHI-0001WW-3m; Wed, 14 May 2025 07:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uFAHF-0001V0-SO
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:27:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uFAHE-0002CQ-36
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747222074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rTn/gid945Xe/t0ccsamCqrEKpBUX+j6hvdKHYFqLDU=;
 b=eaKZ3bLTRDi9ZWoklRJAi7qnV4yy2Iru73QvowMBP6jgklgX2bNR9bSBBBftB9RNVNpgR7
 xNW7Zh9hweeWhrV4Q9DwvBF4yxAwL9RpVPkRclpGWyKgk4hWqrUY/GeE33CfnGX8MyyiYA
 RalQaNonBqRmAPG4TqDeExvXow8e7Wo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-TysiRx1pOvixrc01lleAYA-1; Wed,
 14 May 2025 07:27:53 -0400
X-MC-Unique: TysiRx1pOvixrc01lleAYA-1
X-Mimecast-MFC-AGG-ID: TysiRx1pOvixrc01lleAYA_1747222071
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C69101956087; Wed, 14 May 2025 11:27:51 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-219.str.redhat.com
 [10.33.192.219])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 30D9619560B9; Wed, 14 May 2025 11:27:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 09/13] hw/s390x/s390-virtio-ccw: Remove the deprecated 4.0
 machine type
Date: Wed, 14 May 2025 13:27:29 +0200
Message-ID: <20250514112733.456644-10-thuth@redhat.com>
In-Reply-To: <20250514112733.456644-1-thuth@redhat.com>
References: <20250514112733.456644-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

The s390-ccw-virtio-4.0 machine is older than 6 years, so according to
our machine support policy, it can be removed now. The corresponding
v4.0 CPU feature group gets merged into the minimum feature group now.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250506062148.306084-10-thuth@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c  | 14 --------------
 target/s390x/gen-features.c |  4 ----
 2 files changed, 18 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 95c12a41773..431d6b782a8 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -1158,20 +1158,6 @@ static void ccw_machine_4_1_class_options(MachineClass *mc)
 }
 DEFINE_CCW_MACHINE(4, 1);
 
-static void ccw_machine_4_0_instance_options(MachineState *machine)
-{
-    static const S390FeatInit qemu_cpu_feat = { S390_FEAT_LIST_QEMU_V4_0 };
-    ccw_machine_4_1_instance_options(machine);
-    s390_set_qemu_cpu_model(0x2827, 12, 2, qemu_cpu_feat);
-}
-
-static void ccw_machine_4_0_class_options(MachineClass *mc)
-{
-    ccw_machine_4_1_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_4_0, hw_compat_4_0_len);
-}
-DEFINE_CCW_MACHINE(4, 0);
-
 static void ccw_machine_register_types(void)
 {
     type_register_static(&ccw_machine_info);
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 4346b92431b..a814ece82f2 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -878,9 +878,6 @@ static uint16_t qemu_MIN[] = {
     S390_FEAT_ADAPTER_INT_SUPPRESSION,
     S390_FEAT_MSA_EXT_3,
     S390_FEAT_MSA_EXT_4,
-};
-
-static uint16_t qemu_V4_0[] = {
     /*
      * Only BFP bits are implemented (HFP, DFP, PFPO and DIVIDE TO INTEGER not
      * implemented yet).
@@ -1052,7 +1049,6 @@ static FeatGroupDefSpec FeatGroupDef[] = {
  *******************************/
 static FeatGroupDefSpec QemuFeatDef[] = {
     QEMU_FEAT_INITIALIZER(MIN),
-    QEMU_FEAT_INITIALIZER(V4_0),
     QEMU_FEAT_INITIALIZER(V4_1),
     QEMU_FEAT_INITIALIZER(V6_0),
     QEMU_FEAT_INITIALIZER(V6_2),
-- 
2.49.0


