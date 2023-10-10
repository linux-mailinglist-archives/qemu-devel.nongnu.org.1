Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E11147BFF28
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 16:26:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqDfq-00027H-Tz; Tue, 10 Oct 2023 10:25:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1qqDfi-00021D-IJ
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 10:25:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1qqDfh-0000Gj-9z
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 10:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696947916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TApefxjm2WEaxEHFO8rc1HF2nVhBHdzR5dt4+KLCQJ0=;
 b=GrH9a1pzDl3ORBzvm4qt89NEVzZq+NVG/YQJz00q4yB1O9oxoCdr//AVvB1AkF4h7Zr/Nj
 wM0vMTV5X7V9qP0jZmtM79JcWd9LkT0KAAB/LJminMhkYV1oox8ARzgz5OQkYt1AoGG8In
 I1fBX+zP3/Fftb0s7Vitlx6Xj9L408k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-tPeLB-doNmavXo4SrMnqTw-1; Tue, 10 Oct 2023 10:25:02 -0400
X-MC-Unique: tPeLB-doNmavXo4SrMnqTw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB18581DA0F;
 Tue, 10 Oct 2023 14:25:00 +0000 (UTC)
Received: from gondolin.str.redhat.com (dhcp-192-239.str.redhat.com
 [10.33.192.239])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D0DDF21CAC76;
 Tue, 10 Oct 2023 14:24:59 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v2 3/3] arm/kvm: convert to read_sys_reg64
Date: Tue, 10 Oct 2023 16:24:53 +0200
Message-ID: <20231010142453.224369-4-cohuck@redhat.com>
In-Reply-To: <20231010142453.224369-1-cohuck@redhat.com>
References: <20231010142453.224369-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We can use read_sys_reg64 to get the SVE_VLS register instead of
calling GET_ONE_REG directly.

Suggested-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/arm/kvm64.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 558c0b88dd69..d40c89a84752 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -500,10 +500,6 @@ uint32_t kvm_arm_sve_get_vls(CPUState *cs)
             .target = -1,
             .features[0] = (1 << KVM_ARM_VCPU_SVE),
         };
-        struct kvm_one_reg reg = {
-            .id = KVM_REG_ARM64_SVE_VLS,
-            .addr = (uint64_t)&vls[0],
-        };
         int fdarray[3], ret;
 
         probed = true;
@@ -512,7 +508,7 @@ uint32_t kvm_arm_sve_get_vls(CPUState *cs)
             error_report("failed to create scratch VCPU with SVE enabled");
             abort();
         }
-        ret = ioctl(fdarray[2], KVM_GET_ONE_REG, &reg);
+        ret = read_sys_reg64(fdarray[2], &vls[0], KVM_REG_ARM64_SVE_VLS);
         kvm_arm_destroy_scratch_host_vcpu(fdarray);
         if (ret) {
             error_report("failed to get KVM_REG_ARM64_SVE_VLS: %s",
-- 
2.41.0


