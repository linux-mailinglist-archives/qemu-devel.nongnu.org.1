Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E8970F318
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 11:38:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1kwW-0004hJ-2p; Wed, 24 May 2023 05:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1kwT-0004S0-2n
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:38:01 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1kwQ-0006mf-JD
 for qemu-devel@nongnu.org; Wed, 24 May 2023 05:38:00 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3f42ba32e24so6287065e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 02:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684921077; x=1687513077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NIcA0PvZwprADJczJqLbuRMLXgSZuvk7SexYJ3+yvxo=;
 b=en5yceAZyLoK2aO/2T9Bnfvl5rgwZ49K3a6wWlI9mnaRFxqKIFZbxkNPzH+5UD2TlC
 yGshVDcVMTUEqdsWqsWXRDHtkTw//aFnDEcq5+LVmYgGyvWoylIPFzvHWwtraQ3BE4O7
 w6iD5CLQfN5o9V325ZDO6oY4fsqIZDcj4Bf7s9sQoG1c22Xk14LinrB/wa23zWaquDCT
 D4ETy0ok8QvBHQZrYUj6H5aISQ8wIt2pE/ql7mOVyxPYP0yTpX+p1YyMXheEVU5QuC+g
 fANZV8T+riIrpoidczy1SO4zQSe5mNO4wMgo64LHv83zdPLq1bnhVxm+6Cx/ULt+aY/6
 90iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684921077; x=1687513077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NIcA0PvZwprADJczJqLbuRMLXgSZuvk7SexYJ3+yvxo=;
 b=AhgxGRP3PjLBbAm/uYJ9BWF5Pw7vnGy/TKIACuzqLBy/UH+QsqOVfCofqN2RuwR815
 MWWwkzhyHZL0QL0jOulWAaJs7bDJce0i3pig2atid+UoXiphCzi9mL7I7Wg5vxWIJ4G+
 2DKBJKujeEInaCSdOr5AEjctlJizYpLcOGOET1ZEwLLPCm1YZTVMLQeBbT1/O27JFyPN
 A0WJMwJGkQ1ktZyK6ueDpW+bmxdrJRXo5bQUNeUiLG3cNaO0PhiUYtxbRqZ9Yq3h0TeS
 yvFGD/iJL9lDRNJ1BfRndhMAk7UxqAIPQCxFSG7dDjsn288FpVRZR6bZHoyFaxeLST0F
 hStA==
X-Gm-Message-State: AC+VfDyLLj4XtCHrMCgJZiq2DI08CatLZBJlj6Uje/SPcq+UF7chdJFd
 3kPvkqlJjf4X/kwZESe3Y/VTuwINONdWGAy2t1ViFQ==
X-Google-Smtp-Source: ACHHUZ7YhUt2Hr+g1TURD5z4FcGhjhi4JlpHkcV3PHm1xTU5qxWpPmha7XFyWaN2LNCz/BrW7R1SvQ==
X-Received: by 2002:adf:f683:0:b0:304:8149:239b with SMTP id
 v3-20020adff683000000b003048149239bmr13080694wrp.50.1684921076839; 
 Wed, 24 May 2023 02:37:56 -0700 (PDT)
Received: from localhost.localdomain
 (fac34-h02-176-184-31-246.dsl.sta.abo.bbox.fr. [176.184.31.246])
 by smtp.gmail.com with ESMTPSA id
 b15-20020a5d4b8f000000b00306344eaebfsm13882355wrt.28.2023.05.24.02.37.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 May 2023 02:37:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 01/10] softmmu: Introduce qemu_target_page_mask() helper
Date: Wed, 24 May 2023 11:37:35 +0200
Message-Id: <20230524093744.88442-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230524093744.88442-1-philmd@linaro.org>
References: <20230524093744.88442-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Since TARGET_PAGE_MASK is poisoned in target-agnostic code,
introduce the qemu_target_page_mask() helper to get this
value from target-agnostic code at runtime.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/target_page.h | 1 +
 softmmu/physmem.c          | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/exec/target_page.h b/include/exec/target_page.h
index bbf37aea17..98ffbb5c23 100644
--- a/include/exec/target_page.h
+++ b/include/exec/target_page.h
@@ -15,6 +15,7 @@
 #define EXEC_TARGET_PAGE_H
 
 size_t qemu_target_page_size(void);
+int qemu_target_page_mask(void);
 int qemu_target_page_bits(void);
 int qemu_target_page_bits_min(void);
 
diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 9d7e172260..8067742df0 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -3354,6 +3354,11 @@ size_t qemu_target_page_size(void)
     return TARGET_PAGE_SIZE;
 }
 
+int qemu_target_page_mask(void)
+{
+    return TARGET_PAGE_MASK;
+}
+
 int qemu_target_page_bits(void)
 {
     return TARGET_PAGE_BITS;
-- 
2.38.1


