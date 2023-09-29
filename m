Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCF07B2E9A
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:57:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9Dl-0005Im-7f; Fri, 29 Sep 2023 04:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9Da-00059a-3G
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DD-0005e9-5B
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mNNZqgGBCRydSpAMm3CyVCUzTpS3bjgDJpddGBx98jU=;
 b=B2Sy3zHywSbkwhrRNbXXzkh8TTaEz5iJbyXuwhdWZsYtN2FPPGgkEbOxFYzn1dcdWTPzmi
 C9DFw9Zr2/KCFEDE4Sz+d4q9zmOPpdvnM3Qz1pkNvKLc16vUwm6Wmr6JO+4uuKIxwu6E1b
 lljPkU/pYskcaV+U+ymAP0jJI0P47hg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-687-lCh5EhyPOK65QNQSC-WqAw-1; Fri, 29 Sep 2023 04:50:55 -0400
X-MC-Unique: lCh5EhyPOK65QNQSC-WqAw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FCE385A5A8;
 Fri, 29 Sep 2023 08:50:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B9D910005D2;
 Fri, 29 Sep 2023 08:50:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6C83021E6913; Fri, 29 Sep 2023 10:50:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 10/56] target/arm/hvf: Clean up local variable shadowing
Date: Fri, 29 Sep 2023 10:50:07 +0200
Message-ID: <20230929085053.2789105-11-armbru@redhat.com>
In-Reply-To: <20230929085053.2789105-1-armbru@redhat.com>
References: <20230929085053.2789105-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Per Peter Maydell analysis [*]:

  The hvf_vcpu_exec() function is not documented, but in practice
  its caller expects it to return either EXCP_DEBUG (for "this was
  a guest debug exception you need to deal with") or something else
  (presumably the intention being 0 for OK).

  The hvf_sysreg_read() and hvf_sysreg_write() functions are also not
  documented, but they return 0 on success, or 1 for a completely
  unrecognized sysreg where we've raised the UNDEF exception (but
  not if we raised an UNDEF exception for an unrecognized GIC sysreg --
  I think this is a bug). We use this return value to decide whether
  we need to advance the PC past the insn or not. It's not the same
  as the return value we want to return from hvf_vcpu_exec().

  Retain the variable as locally scoped but give it a name that
  doesn't clash with the other function-scoped variable.

This fixes:

  target/arm/hvf/hvf.c:1936:13: error: declaration shadows a local variable [-Werror,-Wshadow]
        int ret = 0;
            ^
  target/arm/hvf/hvf.c:1807:9: note: previous declaration is here
    int ret;
        ^
[*] https://lore.kernel.org/qemu-devel/CAFEAcA_e+fU6JKtS+W63wr9cCJ6btu_hT_ydZWOwC0kBkDYYYQ@mail.gmail.com/

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230904161235.84651-4-philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 target/arm/hvf/hvf.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 546c0e817f..757e13b0f9 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1934,16 +1934,16 @@ int hvf_vcpu_exec(CPUState *cpu)
         uint32_t rt = (syndrome >> 5) & 0x1f;
         uint32_t reg = syndrome & SYSREG_MASK;
         uint64_t val;
-        int ret = 0;
+        int sysreg_ret = 0;
 
         if (isread) {
-            ret = hvf_sysreg_read(cpu, reg, rt);
+            sysreg_ret = hvf_sysreg_read(cpu, reg, rt);
         } else {
             val = hvf_get_reg(cpu, rt);
-            ret = hvf_sysreg_write(cpu, reg, val);
+            sysreg_ret = hvf_sysreg_write(cpu, reg, val);
         }
 
-        advance_pc = !ret;
+        advance_pc = !sysreg_ret;
         break;
     }
     case EC_WFX_TRAP:
-- 
2.41.0


