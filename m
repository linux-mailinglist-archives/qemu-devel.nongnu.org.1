Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 596F4752F5C
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 04:25:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK8Tb-0005T8-RS; Thu, 13 Jul 2023 22:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qK8Ta-0005Sa-1e
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 22:24:10 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qK8TY-0000D3-H6
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 22:24:09 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2b6f52e1c5cso21362331fa.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 19:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1689301446; x=1691893446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T2JhMFGTujk5geiN04ZoPLCURLKDllK7TTxmiVzVbFk=;
 b=Q4kqp9lFpgLIv6DdO09fPJrFJcWVtb3o2S+ssPff6cdWZmA9p7WqFfKNOiYWPZE8lX
 znSYLbGfLuXADrek2eSnaLf6PjK69kPxfUm+iCLYumRtETXFAgCTL4RaVFWiVf5LXS0C
 R2QeGzblkRzlOZO6GC0/2bbyG3hSDReC6Dfs2asPq6LrTm7Wk+ZSwhohsflp18Xeobze
 qZqNJd25y0vQMAeUIPtIRI6nR/0U8XmUtJXgRKl+1Hp7ND/6WkI8KgBS+hZSct9dXxkn
 8+4DCSL1328CgGET6j5YRCbyZ7kuzo8DezKa7k27GZyEDEBiOhYu942mQYOXxOOtue7S
 0KVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689301446; x=1691893446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T2JhMFGTujk5geiN04ZoPLCURLKDllK7TTxmiVzVbFk=;
 b=T2NEHuod2veyQgbHU6l2JWftI4DslzZKaQYhgrWYdLtGSMveEft56FJM1zoreh6HQi
 fZQO5TsPLqIGhHlbxOr0evg/K4ZKKRdOMNR5gSm3ZwGSQGcL7+Lyi+J2KH90fyD8Jgv4
 epaaM/itrNRafGNg+n013icM4Qtqe33SZKFMrrvhpaqQ/3HbcdIm5L0WWsR1uzVsUebF
 AqQ+gOyimzJXtAnAnSKmP54xpD2t4IZs6lLgGt+/WWFRGtvdUE3ZbdAvVTH+X2B/22Jy
 8Ztq3P7kze2V2pE0tigwPKZZeCBswIrCo6lY/can4ycpIpoZH/ykKBA7Cj6skRB1erps
 f4MA==
X-Gm-Message-State: ABy/qLa50s4xSHgJb5N79HhZqFe6jLnDwV1GfH9PoNQHs4hMzkpAzDoj
 IJVJt+cN2meC9zb44tSHgSrO8Q==
X-Google-Smtp-Source: APBJJlFT3mMJPvwD3fgvO8FiEq4fs8FG1pUMBEGrd2CyS6ZrC7KMM+1EbJ1Looxti1SGzGHpAbhofQ==
X-Received: by 2002:a05:6512:238b:b0:4f8:58d3:b7ab with SMTP id
 c11-20020a056512238b00b004f858d3b7abmr3498425lfv.4.1689301446614; 
 Thu, 13 Jul 2023 19:24:06 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id
 r24-20020ac24d18000000b004fbe2172f7csm1294765lfi.49.2023.07.13.19.24.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jul 2023 19:24:06 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, berrange@redhat.com
Cc: yuri.benditovich@daynix.com,
	yan@daynix.com
Subject: [PATCH v4 2/6] ebpf: Added eBPF initialization by fds.
Date: Fri, 14 Jul 2023 05:23:54 +0300
Message-Id: <20230714022358.2438995-3-andrew@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230714022358.2438995-1-andrew@daynix.com>
References: <20230714022358.2438995-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::234;
 envelope-from=andrew@daynix.com; helo=mail-lj1-x234.google.com
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
index e71e229190..8d7fae2ad9 100644
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
index 247f5eee1b..24bc6cc409 100644
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
index ab08a7266d..239242b0d2 100644
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
2.40.1


