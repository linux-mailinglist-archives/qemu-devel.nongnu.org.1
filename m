Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E7E774F50
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 01:31:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTWA2-0002jS-JN; Tue, 08 Aug 2023 19:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qTW9n-0002ij-Gb
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 19:30:31 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1qTW9l-0005Pp-JJ
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 19:30:30 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fe1d9a8ec6so1822365e9.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 16:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691537428; x=1692142228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T2JhMFGTujk5geiN04ZoPLCURLKDllK7TTxmiVzVbFk=;
 b=M2OchBMejXjauppFqlZJh6a3MXGzsfVlSmNbXqc4ZunJefKoFrqMtD9Xxbg4QZlSCl
 ebIo1VKCv3rXewz66JKIF1zmBGD/AeKnHT/LtWxe/tKeFbqwAHvdDissLo0ihzCF89Ke
 ZyfLqGq2R4erqf+DbjMLS+g9VxBZQBxkK3pf92XnLlk4RaiNe/mDa73oluwFTglP2WLj
 PhmUEdNTRHVi/IHzj0kZ9+7ZE9Q2GDiX87zDCYYTfdhKZxaiW2o1CVisu5liRWo9WHkh
 5q3xfapY3Kfdb2sy+WAyqkxnEFHxuRHmow2F7iVrZ6INYbjMZ4eOrlrH4bCYjcOc2eHR
 f2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691537428; x=1692142228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T2JhMFGTujk5geiN04ZoPLCURLKDllK7TTxmiVzVbFk=;
 b=aCUdx7NqFBpF/Dk9yqLIFXMZZBIe1UETr2UrtshcVSvgDHqzh2Fhay1TKq88Qyd4uZ
 GGMV/+301SFLy6nsEqBHZbKRHG4HoHPg9fRlB8YDY+mC34OdTLioudTlWqAVmq+P8ASI
 g8N9b/6/CiKATCF3WObpiJMn5Mz1Y95mT5SxrssMi7P+J0uLqHdqt5Hhs1PTkwjW5Jej
 HzTq9VpfcO2W7vB9t0V7pFHAmWyj9o+Lo4tX2ZYxyzA6tXlgF0rMnxm+nZ5fLHcZQMYP
 oAkZnWu+UqYMMJE/QGlV5MUxEPB472XvTBC2osJhYsa/fEEcxZRIQIOTuJjxj/patgZ8
 EINQ==
X-Gm-Message-State: AOJu0YxFBzZD21nosyREyHKdbMj88kQPZHSWSwZN88d4e+aY3fhxQABz
 ZWjGXn06oqMnKPwJfl1ZpMnHmw==
X-Google-Smtp-Source: AGHT+IGmUdQcOSH4YODelTz8IrUkfP3dqzvtIQVjQNQV/Augz6PgICUAtUp2MlF9Wpy2wElcRDgFnw==
X-Received: by 2002:a5d:4cc1:0:b0:313:f38d:555f with SMTP id
 c1-20020a5d4cc1000000b00313f38d555fmr859112wrt.24.1691537427934; 
 Tue, 08 Aug 2023 16:30:27 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id
 g6-20020a056000118600b00314398e4dd4sm14776795wrx.54.2023.08.08.16.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 16:30:27 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, berrange@redhat.com
Cc: yuri.benditovich@daynix.com,
	yan@daynix.com
Subject: [PATCH v6 2/5] ebpf: Added eBPF initialization by fds.
Date: Wed,  9 Aug 2023 02:30:12 +0300
Message-Id: <20230808233015.2295947-3-andrew@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808233015.2295947-1-andrew@daynix.com>
References: <20230808233015.2295947-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::333;
 envelope-from=andrew@daynix.com; helo=mail-wm1-x333.google.com
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


