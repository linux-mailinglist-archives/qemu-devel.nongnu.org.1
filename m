Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CB3BAC03A
	for <lists+qemu-devel@lfdr.de>; Tue, 30 Sep 2025 10:24:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3VeB-0000Ku-22; Tue, 30 Sep 2025 04:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3VdG-0008W6-DD
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:22:47 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3VcU-0000oV-0j
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:22:44 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3f99ac9acc4so679601f8f.3
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 01:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759220511; x=1759825311; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jPaFfZE+Vm6W3t7QC31lKwf41cuqTfJ0BWTKMrsHvkU=;
 b=ZsMUAj/chNZ3fVrr0juJJrJkbmyf/VeLeILmds2WrC7ZhfxBiIW0fp2yZ95jtUPJw+
 rsCdLXyepjAXjyBtcS6x5AiQq9MjAUvasdTrSgUq51bUcpuLmL2veXWECB0zw8KeaK3V
 bqMaj6W86n6jrxS9cpAzHrv47rEFNLzdnfgDUq8eP8xrEZhnVpiXNwpEHH5d3XXN2bdS
 tPCqAvX3yUUG7fBQcxF349HpPM47NMnGVh0NlOeXvlyJGaBetSELOKBqrdOZqJP3MWib
 GaBtqC5KZ5vgqd+hqfSVg9LdTcUt40FPYqJfmJzL6JMjmQg83ln8knJORYOnTETKA5O+
 xcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759220511; x=1759825311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jPaFfZE+Vm6W3t7QC31lKwf41cuqTfJ0BWTKMrsHvkU=;
 b=dmwMhk6Zi42ogE39fu2FytRAE42t3g6npJAEb3jR+QOkdFl4ifSfotAVR6f+AW7Mqe
 tzuImpbLo52c3eHBzWrpsfwFQqe2JyvnMRMP2S6ipjWck3Hv9iZanrHvHRNXoUd+2Kmy
 9+E7QPskY6gacDnHc0uyX+Lm+igfYPph3ZDUrM1JdotGAwqlPOefIaPZUaV0JCRLRXfb
 PKBYjCs4MekrujfrvIWhKavspMspvK3yQZw7QBLV0fNra8ViTD+uhz6iMLFcQl7YgLc5
 g+/TtTiJa4s4ghMHR7ZcKI6EZ0DNG1EMC3543pJkRTdSoRS0l8SiqtLlZvKF9/doVX8T
 KRjg==
X-Gm-Message-State: AOJu0Yz/4MMWdzkf9S48Xd8dcJfT5E6uE+PFzzKDhNZXTjOAIPxz/wR6
 gu828U9y2/5KE1YA8znINr4MJnOoWqWzGpD4JqV8U3Rl6LwKOLeXwyIrKGPHWL8BgnQPeWWCFrI
 fcM01Z+WqUg==
X-Gm-Gg: ASbGncv8aERfYQBbTVPdIW+2LUTaGWVQ9isEXgffO6X1XX99QMvODpXZwSPk3g7XYjQ
 9UOx52OkDXgMPYP2dFOeGK6JIZ6g4yHrynMtJ2uPnnRhVnHTqdGwnF0kkhaJ4ggplglpwmPA5Gs
 JZjXE/PMebB7HhpxLBjG/xv7tufruwZ15EJE8oK+quaM9FLnpa/crSKVUst66Q7n7W7rNfDR7Af
 McQj13m7mrLdSZ1RbJXlWKvhq9+7oairSwMinpVA2Yk5cdvI4PNJFD3hcdFDOe6ZNgun8pIEHD8
 +B2H3lP7nsVrhMaXHODPGGKin5ztPtWfaj+4xNtRdqMPU2nFyYwQotgN8xTuDSTtHIf+y6uom4M
 cVGp5rco1Ry3XoqIbnirCvvCATJ1F1bEqqPO0ERTSAefzG/07zVbhiyRjxz66vdn/ww5hrghlby
 mKYmlf6PAOpJn43JhI42Vz
X-Google-Smtp-Source: AGHT+IEB8eNGO8ibaj4OUUkCL1Gk/lot4nZRiwg5YPnw3XMPBC9mULq1peqy0gUd0OsdrauuTBslPQ==
X-Received: by 2002:a05:6000:2511:b0:3d8:3eca:a978 with SMTP id
 ffacd0b85a97d-40e44682229mr16305754f8f.21.1759220510700; 
 Tue, 30 Sep 2025 01:21:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc5602f15sm21609359f8f.39.2025.09.30.01.21.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Sep 2025 01:21:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Stefano Garzarella <sgarzare@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Jason Herne <jjherne@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v3 04/18] target/i386/arch_memory_mapping: Use
 address_space_memory_is_io()
Date: Tue, 30 Sep 2025 10:21:11 +0200
Message-ID: <20250930082126.28618-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930082126.28618-1-philmd@linaro.org>
References: <20250930082126.28618-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Since all functions have an address space argument, it is
trivial to replace cpu_physical_memory_is_io() by
address_space_memory_is_io().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/arch_memory_mapping.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/arch_memory_mapping.c b/target/i386/arch_memory_mapping.c
index a2398c21732..560f4689abc 100644
--- a/target/i386/arch_memory_mapping.c
+++ b/target/i386/arch_memory_mapping.c
@@ -35,7 +35,7 @@ static void walk_pte(MemoryMappingList *list, AddressSpace *as,
         }
 
         start_paddr = (pte & ~0xfff) & ~(0x1ULL << 63);
-        if (cpu_physical_memory_is_io(start_paddr)) {
+        if (address_space_is_io(as, start_paddr)) {
             /* I/O region */
             continue;
         }
@@ -65,7 +65,7 @@ static void walk_pte2(MemoryMappingList *list, AddressSpace *as,
         }
 
         start_paddr = pte & ~0xfff;
-        if (cpu_physical_memory_is_io(start_paddr)) {
+        if (address_space_is_io(as, start_paddr)) {
             /* I/O region */
             continue;
         }
@@ -100,7 +100,7 @@ static void walk_pde(MemoryMappingList *list, AddressSpace *as,
         if (pde & PG_PSE_MASK) {
             /* 2 MB page */
             start_paddr = (pde & ~0x1fffff) & ~(0x1ULL << 63);
-            if (cpu_physical_memory_is_io(start_paddr)) {
+            if (address_space_is_io(as, start_paddr)) {
                 /* I/O region */
                 continue;
             }
@@ -142,7 +142,7 @@ static void walk_pde2(MemoryMappingList *list, AddressSpace *as,
              */
             high_paddr = ((hwaddr)(pde & 0x1fe000) << 19);
             start_paddr = (pde & ~0x3fffff) | high_paddr;
-            if (cpu_physical_memory_is_io(start_paddr)) {
+            if (address_space_is_io(as, start_paddr)) {
                 /* I/O region */
                 continue;
             }
@@ -203,7 +203,7 @@ static void walk_pdpe(MemoryMappingList *list, AddressSpace *as,
         if (pdpe & PG_PSE_MASK) {
             /* 1 GB page */
             start_paddr = (pdpe & ~0x3fffffff) & ~(0x1ULL << 63);
-            if (cpu_physical_memory_is_io(start_paddr)) {
+            if (address_space_is_io(as, start_paddr)) {
                 /* I/O region */
                 continue;
             }
-- 
2.51.0


