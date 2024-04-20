Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA4B8AB9E9
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Apr 2024 07:47:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ry3Z7-0003gb-4z; Sat, 20 Apr 2024 01:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ry3Yx-0003aa-K1
 for qemu-devel@nongnu.org; Sat, 20 Apr 2024 01:47:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ry3Yw-0007Ll-1s
 for qemu-devel@nongnu.org; Sat, 20 Apr 2024 01:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713592016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VDidJPtQ1hsEoE1S5vbkkb8deUNiUQ8N5oRRQWyroFI=;
 b=iUMLrcpdy0zhFe+kd1LqATARpARXhQ9GcQ+G+A5XplCL0vpdZYx0SkSds84MK/3nnzxRcc
 Ritkx8e+MR9vOPcJPJYHolAwacRpRgS4mJsgyGlClQKGsb41zxDVpAsNp1NOdiDw48Od4U
 o0gKQ5avrrPNNfPpoU3SdzJ5Wlj3vpI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-Dcs-t54rOwSCTPcV9mTqiQ-1; Sat,
 20 Apr 2024 01:46:12 -0400
X-MC-Unique: Dcs-t54rOwSCTPcV9mTqiQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D32729AA2C2;
 Sat, 20 Apr 2024 05:46:12 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF97F400F12;
 Sat, 20 Apr 2024 05:46:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-trivial@nongnu.org
Subject: [PATCH 1/3] target/i386/cpu: Remove "x86" prefix from the CPU list
Date: Sat, 20 Apr 2024 07:46:04 +0200
Message-ID: <20240420054606.13353-2-thuth@redhat.com>
In-Reply-To: <20240420054606.13353-1-thuth@redhat.com>
References: <20240420054606.13353-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.313,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Printing an "x86" in front of each CPU name is not helpful at all:
It is confusing for the users since they don't know whether they
have to specify these letters for the "-cpu" parameter, too, and
it also takes some precious space in the dense output of the CPU
entries. Let's simply remove this now and use two spaces at the
beginning of the lines for the indentation of the entries instead,
like most other target architectures are doing it for their CPU help
output already.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 33760a2ee1..fd46e264a2 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5572,7 +5572,7 @@ static void x86_cpu_list_entry(gpointer data, gpointer user_data)
         desc = g_strdup_printf("%s (deprecated)", olddesc);
     }
 
-    qemu_printf("x86 %-20s  %s\n", name, desc);
+    qemu_printf("  %-20s  %s\n", name, desc);
 }
 
 /* list available CPU models and flags */
-- 
2.44.0


