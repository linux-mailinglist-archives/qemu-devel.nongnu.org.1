Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FA1781159
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:13:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX31d-0008Bz-7j; Fri, 18 Aug 2023 13:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31b-0008BS-Oq
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:12:39 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31Z-00080Y-Mx
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:12:39 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bb84194bf3so8859755ad.3
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692378756; x=1692983556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=foxS0Fq91WmmfcDM8Wf9D08Fa/T038sYWUjuA+SoAyU=;
 b=J8ufQCj3bDBvRWuA6trLxcsZRKMyceecEnvjHX7M9colkmTNmxorIIcuoItIknNd2b
 HHlOjxf0ZzGCbMCom09fMncmsOtsb9THDryk5Pe1k0tD5lFl8i+DSbULcmqh2t9CtXva
 Fe4PzQSdNZluTtIu/RAmwcoWvy66U8Js0EVg2v8DOiYyrNpuGJ5UIBJ1u71vXHcScz2K
 5OJdpZOBZV/20ER6SDz7+crt2Ks1zDQ+nnOVsoSwnl6iDVWbUk77T8FZxT7DN2fLQxTB
 cwZCwMjKMibjgszE+Dfvk8mxVkmVmdJKF2bvY7wrIW7n2nrq4jmfW5QEmrrElbbdOD/E
 2dXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692378756; x=1692983556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=foxS0Fq91WmmfcDM8Wf9D08Fa/T038sYWUjuA+SoAyU=;
 b=BJmFd9ZxEwSk2sSJ0yEG5PY5HT3LeZ1F+FSyRAZK09QrV8nJknKKgMdTIMKtSQxRhS
 U+sPoDwNuTmpLI0KLezixzC2Vx19WbMEWUQs8NlhdX7fpKMfYv1TOj6/Y1Cib8nsR412
 YfuC6nXOgoy40TBZMwds80Hu9U5tsAS7718WppDyzIAECCUu3hbu8GB6ONJ1087J8+co
 e5iWK10/BpXL0p6ynuAgdYK3NA+4Dj3EwtyPSb8U5peuOsitZN4bcQHhkvhgIoSQg7OX
 SutL9Gm9whYhgvZp53Imr99BVOgOK82ORPQngILBpLseNpWFIAI3glTOsN15NpxvqLsZ
 luhQ==
X-Gm-Message-State: AOJu0YzoP51sC2gsLYfn7kAY366WP9BpiZyy8n0QMfEJY+rXEjLu8dfB
 dx/Bf3RiDOXNaax9Rb3cFmNHEFkepgk53SZnssc=
X-Google-Smtp-Source: AGHT+IHh4RJw6P0qgQGBlqg9dpjmOB14wxbpVUO6FwdlGNa2w2Bf3E4aPiqHNWgXSV8XR4ucwMiwmw==
X-Received: by 2002:a17:902:8341:b0:1bd:bfc0:4627 with SMTP id
 z1-20020a170902834100b001bdbfc04627mr3090319pln.40.1692378756303; 
 Fri, 18 Aug 2023 10:12:36 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 jw24-20020a170903279800b001adf6b21c77sm2020025plb.107.2023.08.18.10.12.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:12:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/33] linux-user/hppa: Simplify init_guest_commpage
Date: Fri, 18 Aug 2023 10:11:59 -0700
Message-Id: <20230818171227.141728-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818171227.141728-1-richard.henderson@linaro.org>
References: <20230818171227.141728-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

If reserved_va, then we have already reserved the entire
guest virtual address space; no need to remap page.
If !reserved_va, then use MAP_FIXED_NOREPLACE.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index b6af8f88aa..1da77f4f71 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1831,16 +1831,21 @@ static inline void init_thread(struct target_pt_regs *regs,
 
 static bool init_guest_commpage(void)
 {
-    void *want = g2h_untagged(LO_COMMPAGE);
-    void *addr = mmap(want, qemu_host_page_size, PROT_NONE,
-                      MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+    /* If reserved_va, then we have already mapped 0 page on the host. */
+    if (!reserved_va) {
+        int host_page_size = qemu_real_host_page_size();
+        void *want, *addr;
 
-    if (addr == MAP_FAILED) {
-        perror("Allocating guest commpage");
-        exit(EXIT_FAILURE);
-    }
-    if (addr != want) {
-        return false;
+        want = g2h_untagged(LO_COMMPAGE);
+        addr = mmap(want, host_page_size, PROT_NONE,
+                    MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED_NOREPLACE, -1, 0);
+        if (addr == MAP_FAILED) {
+            perror("Allocating guest commpage");
+            exit(EXIT_FAILURE);
+        }
+        if (addr != want) {
+            return false;
+        }
     }
 
     /*
-- 
2.34.1


