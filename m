Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A3979228A
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 14:22:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdV4b-0003f4-MF; Tue, 05 Sep 2023 08:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdV4G-0003UY-T6
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 08:22:08 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdV4E-0000pO-Ln
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 08:22:04 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31c3726cc45so2171391f8f.0
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 05:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693916520; x=1694521320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sB86fzFOmVDgMvea5i3OluWg93+WlVCOeLM0GI/SSvo=;
 b=I34CpIIuMOae5ko9w2U8XPSel/qy3c/rGoz1G10z8i2trWkHnTgeESlxQBF+y3DH1h
 tvzYkTOB2/gIaw3dcQqsffM3/dUqM7m4PkaYrnEd1V+ZkwkQscE1VvIidXquFqJjDUxs
 F59OUUsM/9PCp9esiBEnw/z6lPRT7SuJW8d/zoY2Bgl+rm/II0OKXDXbYZXqMFQgz13Z
 qBrdT2qgQiNoAUvQcVTm7x4ativZjla2tE/2ElRzvEKLZKzUmkBm7VeBw6v79Ffw5HP/
 70fsF7LN0ADeg7+RlbXKJLTrTiiLKbJ3GczuPtdqEFewEeiQIJSsmlU9dQdF6U0Vjin+
 RoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693916520; x=1694521320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sB86fzFOmVDgMvea5i3OluWg93+WlVCOeLM0GI/SSvo=;
 b=BzT9h7MFrW6mowLY/yKw/x0Dv6ZXjQNZl/PDiXZ8/L7PbkF2bcp3LmjPm0ATqChSZI
 lH63VDRLwgYxEjrvunXDV+9Rrbb6vAlwbUk7cmlIvcYlfLwi429Bx2/ymN22dGIeeFSc
 wUxwEv1g8WBtzn5JV/MQCursWDuEvhYGHptaScfTPDdyOVyGYJk+26jSkGbGc769Eefs
 7COkFpwO8Q2/v9ZipBmu6wza25Orc3HuICN3xjOYudElAaMy4lW6cYJoOJlLDRQg5F/A
 n++bWCyk5JJOjeZRf4udpKjDcBn4Xv7OBXm3RzuufSBuTP8R5d2z2f36gh1It/aZLgzb
 j3KA==
X-Gm-Message-State: AOJu0Yz8O2/SQ4BaMBMjwJ+qdylkMJvfe6b20TcxIpXQnEslh1a23wrF
 4YjcTIeu9hb3V76B1qCWAvCncJ9XHgq3ZjIM52A=
X-Google-Smtp-Source: AGHT+IGMv++IXwOb16f2+PfK5YVZCa7H80s2i/rxCKRU0mJ1BiJzgJBBclvgdAZjwKfes8Lh0/ctrQ==
X-Received: by 2002:a5d:5510:0:b0:319:6fff:f2c1 with SMTP id
 b16-20020a5d5510000000b003196ffff2c1mr8841138wrv.38.1693916519881; 
 Tue, 05 Sep 2023 05:21:59 -0700 (PDT)
Received: from localhost.localdomain ([37.69.27.38])
 by smtp.gmail.com with ESMTPSA id
 n9-20020a05600c294900b003feff926fc5sm16775933wmd.17.2023.09.05.05.21.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Sep 2023 05:21:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PATCH 3/3] sysemu/xen: Allow elision of xen_hvm_modified_memory()
Date: Tue,  5 Sep 2023 14:21:42 +0200
Message-ID: <20230905122142.5939-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230905122142.5939-1-philmd@linaro.org>
References: <20230905122142.5939-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Call xen_enabled() before xen_hvm_modified_memory() to let
the compiler elide its call.

Have xen_enabled() return a boolean to match its declaration
in the CONFIG_XEN_IS_POSSIBLE case.

Suggested-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/ram_addr.h |  8 ++++++--
 include/sysemu/xen.h    | 15 ++-------------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 9f2e3893f5..66e849ac4e 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -330,7 +330,9 @@ static inline void cpu_physical_memory_set_dirty_range(ram_addr_t start,
         }
     }
 
-    xen_hvm_modified_memory(start, length);
+    if (xen_enabled()) {
+        xen_hvm_modified_memory(start, length);
+    }
 }
 
 #if !defined(_WIN32)
@@ -406,7 +408,9 @@ uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
             }
         }
 
-        xen_hvm_modified_memory(start, pages << TARGET_PAGE_BITS);
+        if (xen_enabled()) {
+            xen_hvm_modified_memory(start, pages << TARGET_PAGE_BITS);
+        }
     } else {
         uint8_t clients = tcg_enabled() ? DIRTY_CLIENTS_ALL : DIRTY_CLIENTS_NOCODE;
 
diff --git a/include/sysemu/xen.h b/include/sysemu/xen.h
index 1f797a9abe..d84a5f3551 100644
--- a/include/sysemu/xen.h
+++ b/include/sysemu/xen.h
@@ -21,24 +21,13 @@
 #endif
 
 #ifdef CONFIG_XEN_IS_POSSIBLE
-
 extern bool xen_allowed;
-
 #define xen_enabled()           (xen_allowed)
-
-void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length);
-
 #else /* !CONFIG_XEN_IS_POSSIBLE */
-
-#define xen_enabled() 0
-
-static inline void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
-{
-    /* nothing */
-}
-
+#define xen_enabled()           false
 #endif /* CONFIG_XEN_IS_POSSIBLE */
 
+void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length);
 void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
                    struct MemoryRegion *mr, Error **errp);
 
-- 
2.41.0


