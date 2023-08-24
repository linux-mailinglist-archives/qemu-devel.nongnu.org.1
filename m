Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FC67870F5
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 15:58:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZApt-0007ln-23; Thu, 24 Aug 2023 09:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1qZApq-0007lF-Th
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 09:57:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1qZApo-0001oq-UJ
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 09:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692885436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Le11YyP9LAsOnpmeeP8WjlQ4OOVibsNIF1PZ2J9gI14=;
 b=cn/cmgTb3qDHUVMc3xGthulA/Vz88cE7/I/Zys3O1g4qo6dCjC66HMF1+rJu69YrMq4M3l
 Z9sgFJdpiF0Ba2CfTCyADra/hItGF2lzFzEsWEa6HF0UjHcqLwVV1AveULZJ5oPdzGyjxU
 jnCUDBQl6yAbRmSgOTsufG90YRIEqD8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-369-HcspVemHMwKNkvJ86qeUuQ-1; Thu, 24 Aug 2023 09:57:13 -0400
X-MC-Unique: HcspVemHMwKNkvJ86qeUuQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 938BA8D40B6
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 13:57:12 +0000 (UTC)
Received: from work.redhat.com (unknown [10.39.193.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0BDE86B2B3;
 Thu, 24 Aug 2023 13:57:11 +0000 (UTC)
From: Tim Wiederhake <twiederh@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tim Wiederhake <twiederh@redhat.com>
Subject: [PATCH 1/3] target/i386: Add missing feature names in
 FEAT_VMX_EPT_VPID_CAPS
Date: Thu, 24 Aug 2023 15:57:08 +0200
Message-Id: <20230824135710.343175-2-twiederh@redhat.com>
In-Reply-To: <20230824135710.343175-1-twiederh@redhat.com>
References: <20230824135710.343175-1-twiederh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=twiederh@redhat.com;
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

Add the missing feature names for two bits in the FEAT_VMX_EPT_VPID_CAPS
cpuid leaf. "vmx-ept-uc" is currently unused, but "vmx-ept-wb" is enabled
for multiple cpu models.

Signed-off-by: Tim Wiederhake <twiederh@redhat.com>
---
 target/i386/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 97ad229d8b..e6b8c62b92 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1314,8 +1314,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .feat_names = {
             "vmx-ept-execonly", NULL, NULL, NULL,
             NULL, NULL, "vmx-page-walk-4", "vmx-page-walk-5",
-            NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            "vmx-ept-uc", NULL, NULL, NULL,
+            NULL, NULL, "vmx-ept-wb", NULL,
             "vmx-ept-2mb", "vmx-ept-1gb", NULL, NULL,
             "vmx-invept", "vmx-eptad", "vmx-ept-advanced-exitinfo", NULL,
             NULL, "vmx-invept-single-context", "vmx-invept-all-context", NULL,
-- 
2.39.2


