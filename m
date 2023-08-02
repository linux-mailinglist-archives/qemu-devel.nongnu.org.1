Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F1C76D921
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 23:03:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRIyl-0003OJ-2n; Wed, 02 Aug 2023 17:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qRIyh-0003NQ-U2
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 17:01:55 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qRIyg-00067n-9a
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 17:01:55 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2b9b9f0387dso3752341fa.0
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 14:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691010112; x=1691614912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3azo7f5aJ7d2GzqDzLJztwRu9tgjQ+jbRXt47M8jNj0=;
 b=FUeEWJUbgnLW0JdrvlPFGsZTD4BWiM6hTBhhhSJlFZNE/sLwRSn2S3GPXWwdE2AV/E
 SSbxCFbnqeDf5Q5CjK+UOMTiSgIhQzGGZspug3w9Lop/mq+naIgzEQ3ZH97qri1WOERP
 xy0hxv9Saivtj/fnnEyTKJWRWCCKJy1TRjogEBkGLcHM9vF6s204LEE8zZjr8DWmejzi
 QhfiDj9vvJGJWEc8IGFhKpHAHwjSkLAsZwE1EwPx1jb4K35AGgIZJxVPE9UJ7pbhBC+I
 Zf//dohaSj7I+eWfMi2heYItkhzv59jgJoZPHGTUiWBrqKCmxldAaQ3VnWqC91rovj4g
 721Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691010112; x=1691614912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3azo7f5aJ7d2GzqDzLJztwRu9tgjQ+jbRXt47M8jNj0=;
 b=a3ZM2MPSRGbb72v8JZ48HTmbgE4Q4tNi3XPuIzu1H+9reCNOW4V0MdkJgvRwzV5QmJ
 J2vO8hXPyR++ySEm1gN4z03DiGhPtcWcgWy85ZOKO6WH3zsJO7Dlzr6EoTutQhN7Txea
 kdZAdVJd7M1jJBq4qY4OMvUvCjC34fgCSXx4uYoY/zdCFPXF2wyB5R7oGQJkOa+OJT+k
 QOQ2NyqG3yEmo45npQ+4k/WPZJyD+EURlk45KejOXv3JuWqkTGXqgtphaGf+Rb8wCOyp
 TzWZzV20t15oAQMx8uVJ3i0xVb/6agxex54FaGK9JS/+KfZy/VdLuxrrH1HRpOVFOjDA
 aI5w==
X-Gm-Message-State: ABy/qLZNJ/gDjBkJlEo1lpEZ4oKQ7nKtx1SRW6OP+oyHcV8RLnc8ib9L
 a179OkkgU75R4K3PVSjCc4tEng==
X-Google-Smtp-Source: APBJJlHE9MEHjMtMIVJYVsjDjVyBFkYh9ITuuo+rYXi865eFOznJxoHKhtw42TH4/CCRk/Kc2j9zeg==
X-Received: by 2002:a2e:9d55:0:b0:2b9:c4f6:fdd with SMTP id
 y21-20020a2e9d55000000b002b9c4f60fddmr5768609ljj.14.1691010112495; 
 Wed, 02 Aug 2023 14:01:52 -0700 (PDT)
Received: from localhost.localdomain ([194.126.180.172])
 by smtp.gmail.com with ESMTPSA id
 8-20020a05651c00c800b002ba045496d0sm391880ljr.125.2023.08.02.14.01.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 14:01:52 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, eblake@redhat.com,
 berrange@redhat.com, qemu-devel@nongnu.org
Cc: yuri.benditovich@daynix.com,
	yan@daynix.com
Subject: [PATCH v5 2/5] ebpf: Added eBPF initialization by fds.
Date: Wed,  2 Aug 2023 23:41:20 +0300
Message-ID: <20230802204125.33688-3-andrew@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802204125.33688-1-andrew@daynix.com>
References: <20230802204125.33688-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::22b;
 envelope-from=andrew@daynix.com; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

It allows using file descriptors of eBPF provided
outside of QEMU.
QEMU may be run without capabilities for eBPF and run
RSS program provided by management tool(g.e. libvirt).

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 ebpf/ebpf_rss-stub.c |  6 ++++++
 ebpf/ebpf_rss.c      | 27 +++++++++++++++++++++++++++
 ebpf/ebpf_rss.h      |  5 +++++
 3 files changed, 38 insertions(+)

diff --git a/ebpf/ebpf_rss-stub.c b/ebpf/ebpf_rss-stub.c
index e71e229190d..8d7fae2ad92 100644
--- a/ebpf/ebpf_rss-stub.c
+++ b/ebpf/ebpf_rss-stub.c
@@ -28,6 +28,12 @@ bool ebpf_rss_load(struct EBPFRSSContext *ctx)
     return false;
 }
 
+bool ebpf_rss_load_fds(struct EBPFRSSContext *ctx, int program_fd,
+                       int config_fd, int toeplitz_fd, int table_fd)
+{
+    return false;
+}
+
 bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *config,
                       uint16_t *indirections_table, uint8_t *toeplitz_key)
 {
diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
index 247f5eee1b6..24bc6cc409e 100644
--- a/ebpf/ebpf_rss.c
+++ b/ebpf/ebpf_rss.c
@@ -146,6 +146,33 @@ error:
     return false;
 }
 
+bool ebpf_rss_load_fds(struct EBPFRSSContext *ctx, int program_fd,
+                       int config_fd, int toeplitz_fd, int table_fd)
+{
+    if (ctx == NULL || ebpf_rss_is_loaded(ctx)) {
+        return false;
+    }
+
+    if (program_fd < 0 || config_fd < 0 || toeplitz_fd < 0 || table_fd < 0) {
+        return false;
+    }
+
+    ctx->program_fd = program_fd;
+    ctx->map_configuration = config_fd;
+    ctx->map_toeplitz_key = toeplitz_fd;
+    ctx->map_indirections_table = table_fd;
+
+    if (!ebpf_rss_mmap(ctx)) {
+        ctx->program_fd = -1;
+        ctx->map_configuration = -1;
+        ctx->map_toeplitz_key = -1;
+        ctx->map_indirections_table = -1;
+        return false;
+    }
+
+    return true;
+}
+
 static bool ebpf_rss_set_config(struct EBPFRSSContext *ctx,
                                 struct EBPFRSSConfig *config)
 {
diff --git a/ebpf/ebpf_rss.h b/ebpf/ebpf_rss.h
index ab08a7266d0..239242b0d26 100644
--- a/ebpf/ebpf_rss.h
+++ b/ebpf/ebpf_rss.h
@@ -14,6 +14,8 @@
 #ifndef QEMU_EBPF_RSS_H
 #define QEMU_EBPF_RSS_H
 
+#define EBPF_RSS_MAX_FDS 4
+
 struct EBPFRSSContext {
     void *obj;
     int program_fd;
@@ -41,6 +43,9 @@ bool ebpf_rss_is_loaded(struct EBPFRSSContext *ctx);
 
 bool ebpf_rss_load(struct EBPFRSSContext *ctx);
 
+bool ebpf_rss_load_fds(struct EBPFRSSContext *ctx, int program_fd,
+                       int config_fd, int toeplitz_fd, int table_fd);
+
 bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *config,
                       uint16_t *indirections_table, uint8_t *toeplitz_key);
 
-- 
2.41.0


