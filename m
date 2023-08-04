Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D32376F725
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 03:47:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRjst-0002fs-CH; Thu, 03 Aug 2023 21:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRjsm-0002dD-5K
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 21:45:38 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRjsk-0005BR-Ev
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 21:45:35 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-68783004143so1184002b3a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 18:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691113530; x=1691718330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ELcQtbKVbBoHF9FWDbse8cJpBmtrHN0KISCq9awCB6k=;
 b=Q3i6fetWC9GtJWvlWnBCG1HHMIRj9nh6S0XQND9lV6pi1IAcSgjMu+7IFOPi6xIZOe
 ON+dOSUGcliUomuvB/6yA7S/8wSHA3J8iq0Cq5iGQxDeSo+0HBmcUaNfCNNXSZpOoGkr
 Jwm/Z+iqhJPymw5GGjyF3A42T+HJcp5DD7qv1iIKUsHkkPmpL0iAdjtLtQa8I0OWZsiP
 ZYuZoTK7Tbl4g4Z4Tc5KrPRUT4WHEqR3vqug+WwK4/eb2J/lMoZLa6YFFEkHftihcMwu
 aINsxwOEEyzJPWZq7qJ1t69ILaisb4PCcEJ7qPoOGJ491JeIoqjj9PonR1naWe93bhwJ
 N3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691113530; x=1691718330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ELcQtbKVbBoHF9FWDbse8cJpBmtrHN0KISCq9awCB6k=;
 b=RqVPp5s+93q1ngiEyG3QS2+MOO1xElxpgWOISRW3t0wChz6lLAkK5rvA/Jr3db3Ek0
 /5rNjqKEEEbuOKs0NxcwRv24/zcVs0RnF9O2HhzNb6x3GdobuOfF/3Lgbim/v44+n1ys
 odvlg28W8LmZ5FNss/WCt0s1JLBMPrsAds27nFkshMlQScS6U2a8qRtFxAaIqTjKDOwI
 nTwpOFPPLwaCPM5Qm49Z8m493iCnHNPH2tvlvgKbZ513c7LOytAQ+SM0FZ/fU5mb28E9
 6OYZpv3p5BNyAQ3M0LEqyCv05R7YF7ZQH1fC4tJzFzOKjol2vNqwg1XBSLarhjA8+E+F
 L55w==
X-Gm-Message-State: AOJu0YzGQsnhnVWzdH+w7W2UrFYq9qbJlpP2ji4trAtRNuVH4VootREL
 QhrNVZBsYzZnMVQY0jU1bRhavNSEHBCMNSC/Eq8=
X-Google-Smtp-Source: AGHT+IHox95dNmb//e/zfppO2EkkCOKAFx5fl9CeUIWKaA8W8XCbYgIMEWiIXdJ+6k78OwIzYzWJ5g==
X-Received: by 2002:a05:6a20:3ca3:b0:131:6fd:8f5a with SMTP id
 b35-20020a056a203ca300b0013106fd8f5amr341004pzj.32.1691113530688; 
 Thu, 03 Aug 2023 18:45:30 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:9d52:4fe8:10ce:5c3])
 by smtp.gmail.com with ESMTPSA id
 c5-20020aa78c05000000b0066f37665a63sm456138pfd.73.2023.08.03.18.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 18:45:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: joel@jms.id.au, akihiko.odaki@daynix.com, laurent@vivier.eu, deller@gmx.de
Subject: [PATCH v8 15/17] linux-user: Do not adjust image mapping for host
 page size
Date: Thu,  3 Aug 2023 18:45:15 -0700
Message-Id: <20230804014517.6361-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804014517.6361-1-richard.henderson@linaro.org>
References: <20230804014517.6361-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Remove TARGET_ELF_EXEC_PAGESIZE, and 3 other TARGET_ELF_PAGE* macros
based off of that.  Rely on target_mmap to handle guest vs host page
size mismatch.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index fa0c9ace8e..e853a4ab33 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1959,15 +1959,6 @@ struct exec
 #define ZMAGIC 0413
 #define QMAGIC 0314
 
-/* Necessary parameters */
-#define TARGET_ELF_EXEC_PAGESIZE \
-        (((eppnt->p_align & ~qemu_host_page_mask) != 0) ? \
-         TARGET_PAGE_SIZE : MAX(qemu_host_page_size, TARGET_PAGE_SIZE))
-#define TARGET_ELF_PAGELENGTH(_v) ROUND_UP((_v), TARGET_ELF_EXEC_PAGESIZE)
-#define TARGET_ELF_PAGESTART(_v) ((_v) & \
-                                 ~(abi_ulong)(TARGET_ELF_EXEC_PAGESIZE-1))
-#define TARGET_ELF_PAGEOFFSET(_v) ((_v) & (TARGET_ELF_EXEC_PAGESIZE-1))
-
 #define DLINFO_ITEMS 16
 
 static inline void memcpy_fromfs(void * to, const void * from, unsigned long n)
@@ -3240,8 +3231,8 @@ static void load_elf_image(const char *image_name, int image_fd,
             }
 
             vaddr = load_bias + eppnt->p_vaddr;
-            vaddr_po = TARGET_ELF_PAGEOFFSET(vaddr);
-            vaddr_ps = TARGET_ELF_PAGESTART(vaddr);
+            vaddr_po = vaddr & ~TARGET_PAGE_MASK;
+            vaddr_ps = vaddr & TARGET_PAGE_MASK;
 
             vaddr_ef = vaddr + eppnt->p_filesz;
             vaddr_em = vaddr + eppnt->p_memsz;
@@ -3251,7 +3242,7 @@ static void load_elf_image(const char *image_name, int image_fd,
              * but no backing file segment.
              */
             if (eppnt->p_filesz != 0) {
-                vaddr_len = TARGET_ELF_PAGELENGTH(eppnt->p_filesz + vaddr_po);
+                vaddr_len = eppnt->p_filesz + vaddr_po;
                 error = target_mmap(vaddr_ps, vaddr_len, elf_prot,
                                     MAP_PRIVATE | MAP_FIXED,
                                     image_fd, eppnt->p_offset - vaddr_po);
@@ -3267,7 +3258,7 @@ static void load_elf_image(const char *image_name, int image_fd,
                     zero_bss(vaddr_ef, vaddr_em, elf_prot);
                 }
             } else if (eppnt->p_memsz != 0) {
-                vaddr_len = TARGET_ELF_PAGELENGTH(eppnt->p_memsz + vaddr_po);
+                vaddr_len = eppnt->p_memsz + vaddr_po;
                 error = target_mmap(vaddr_ps, vaddr_len, elf_prot,
                                     MAP_PRIVATE | MAP_FIXED | MAP_ANONYMOUS,
                                     -1, 0);
-- 
2.34.1


