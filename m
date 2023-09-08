Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95661798755
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 14:47:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeasD-0003gf-0E; Fri, 08 Sep 2023 08:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1qeas9-0003gS-6j
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:46:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1qeas2-0006Kt-Hz
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694177141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7dIA4q8l/1YGfhWGTPsegsXPh0H8iDvPKD306R29RwE=;
 b=bqKlzzFjjyFt4ZI/LWmawSy9lmz3djE3BPjShogWHZBOGGqbLCQ2blzbD13o3BBPfY6GVb
 bwB7SgKqGovQavewhdzyQOkC+CU5dvy2MMEfEDulDR5lqxJlfbAIpNVrqvdJ1ulHPXKLXc
 rvFB5v/DjX8/W2gPKMSSfmJqQjN26HI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-286-CljUndrmMqeLWhnSmJI3rw-1; Fri, 08 Sep 2023 08:45:38 -0400
X-MC-Unique: CljUndrmMqeLWhnSmJI3rw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 590CE184174D;
 Fri,  8 Sep 2023 12:45:37 +0000 (UTC)
Received: from work.redhat.com (unknown [10.39.194.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7098321EE566;
 Fri,  8 Sep 2023 12:45:36 +0000 (UTC)
From: Tim Wiederhake <twiederh@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Tim Wiederhake <twiederh@redhat.com>
Subject: [PATCH v2 01/10] target/i386: Add missing feature names in
 FEAT_VMX_EPT_VPID_CAPS
Date: Fri,  8 Sep 2023 14:45:25 +0200
Message-Id: <20230908124534.25027-2-twiederh@redhat.com>
In-Reply-To: <20230908124534.25027-1-twiederh@redhat.com>
References: <20230908124534.25027-1-twiederh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=twiederh@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 24ee67b42d..7c2c48ac06 100644
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


