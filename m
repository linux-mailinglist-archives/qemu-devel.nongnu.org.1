Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2077C70D1
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 16:58:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqx84-0007wp-1A; Thu, 12 Oct 2023 10:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqx81-0007wQ-Nx
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:57:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qqx80-0000sK-D7
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697122651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BOBvTN24AwDZymRAdlgF5sszPLVku+wG5poAs5x4ffs=;
 b=gPLYwXmTntJ7L+gX5NPTVyB9DuH2T+Q9Go2IY+Y1sYisvuQjwHUpz7WgLb55SfC3rEhhQ5
 ETZp6FNMkeElbfuphq9wAvTm6ovQY5XOsNQJverJR0/mFJecBDcyXEHbABJqPabjYv53r9
 mFj2+AKehZJP/84wZUMb2j2lk4JyyII=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6-GznckU62PSmlxVLzGM_36w-1; Thu, 12 Oct 2023 10:57:25 -0400
X-MC-Unique: GznckU62PSmlxVLzGM_36w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 38578185A7B5;
 Thu, 12 Oct 2023 14:57:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 17BE1202701E;
 Thu, 12 Oct 2023 14:57:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B713621E6A26; Thu, 12 Oct 2023 16:57:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 5/5] target/i386: fix shadowed variable pasto
Date: Thu, 12 Oct 2023 16:57:21 +0200
Message-ID: <20231012145721.77039-6-armbru@redhat.com>
In-Reply-To: <20231012145721.77039-1-armbru@redhat.com>
References: <20231012145721.77039-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

From: Paolo Bonzini <pbonzini@redhat.com>

Commit a908985971a ("target/i386/seg_helper: introduce tss_set_busy",
2023-09-26) failed to use the tss_selector argument of the new function,
which was therefore unused.

This shows up as a #GP fault when booting old versions of 32-bit
Linux.

Fixes: a908985971a ("target/i386/seg_helper: introduce tss_set_busy", 2023-09-26)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20231011135350.438492-1-pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 target/i386/tcg/seg_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 2b92aee207..eb29a1fd4e 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -229,7 +229,7 @@ static void tss_load_seg(CPUX86State *env, X86Seg seg_reg, int selector,
 static void tss_set_busy(CPUX86State *env, int tss_selector, bool value,
                          uintptr_t retaddr)
 {
-    target_ulong ptr = env->gdt.base + (env->tr.selector & ~7);
+    target_ulong ptr = env->gdt.base + (tss_selector & ~7);
     uint32_t e2 = cpu_ldl_kernel_ra(env, ptr + 4, retaddr);
 
     if (value) {
-- 
2.41.0


