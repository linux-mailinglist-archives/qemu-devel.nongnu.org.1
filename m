Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAE078E6CF
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 08:53:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbbXH-0004RN-Fn; Thu, 31 Aug 2023 02:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qbbXE-0004Oz-MO
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 02:52:08 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qbbXB-0005WX-MV
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 02:52:08 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-401da71b7faso4684465e9.2
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 23:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1693464724; x=1694069524;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T2JhMFGTujk5geiN04ZoPLCURLKDllK7TTxmiVzVbFk=;
 b=L0EGx9ZT1DcR2NODml+gyJSmhBZaq1NCtrW74LZDlDIHBFHluJ+mTi5oZYEbdWbda7
 Kv3GZWtXl5OjyY9Y/AAKdAExhzMlIaVv4sKQm7kh3UQmuD8Z3P5B/SJSlT5mY5aEjoPZ
 Gd7nOWICioP/eGZ9uuwydVZLFSRw7hjh3YLWb5wGE2PQo+IC9d6lWjBURBVd1rmYSqgm
 E6wWZ2vQsjxmBMc+qjKXzUWd716RxGDxk8ID8pCWn/hxoG55iDHPiyzcQjwTxpec1kgD
 mgc3NTNhtaCaaUXPwT+i+lxszxxOvyWehdbLFjKtRQ8z8vqm2hqbsJmpfOLoxV+4qXbQ
 pkPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693464724; x=1694069524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T2JhMFGTujk5geiN04ZoPLCURLKDllK7TTxmiVzVbFk=;
 b=N/ghZ41Ex2ye7rLTXhBVeJoETBGn8iqRZ4IozO0Uo+dm363G0crDF+pDDeCMg0adkR
 Rby7X8chpKpG7fvBnsSigJx9Lj8Bkv/Bgji6AyoIi6SLP2OfM5B/hTIHT73Lgj4frT/3
 koG9qBKu+czIPlToYVOdxPUA+aPxcBLpoWj8TrVtHzTYvTqemRZgvQZhWTZiGhP75ppI
 qTL95NYhVwcA5wxNBpMpsFQU/YVfup1CcshZcHYA1LdfFefA0A2xYw/k6EAfISgo5lke
 EJFhV6oCpDOLVUc06g+F7x29OZtNtzVtnXq0I7XcDgOSeOfeRkdeJwfpQNAEwKL+KGiT
 v2Lg==
X-Gm-Message-State: AOJu0YwnV9ozoJvvUC9KBKzmaqacy40E1rTLx7l94Xxn3ZPcm+kiBspk
 mUi+gByRZvJLGp1FzWJpkimq5g==
X-Google-Smtp-Source: AGHT+IGuNOsPjg5DHL7ZH65pIOt4kdMWXeVVRrYnhxEu72g9sYTUpLMiOJ4HOt9v6ANTzo+OPwyC1A==
X-Received: by 2002:a7b:c45a:0:b0:3fe:19cf:93c9 with SMTP id
 l26-20020a7bc45a000000b003fe19cf93c9mr3453139wmi.1.1693464723753; 
 Wed, 30 Aug 2023 23:52:03 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id
 hn8-20020a05600ca38800b003fee6e170f9sm969010wmb.45.2023.08.30.23.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 23:52:03 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, berrange@redhat.com
Cc: yuri.benditovich@daynix.com,
	yan@daynix.com
Subject: [PATCH v7 2/5] ebpf: Added eBPF initialization by fds.
Date: Thu, 31 Aug 2023 09:51:37 +0300
Message-Id: <20230831065140.496485-3-andrew@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230831065140.496485-1-andrew@daynix.com>
References: <20230831065140.496485-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::32d;
 envelope-from=andrew@daynix.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


