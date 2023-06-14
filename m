Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FD5730AA6
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 00:31:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9Z02-00042p-2C; Wed, 14 Jun 2023 18:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1q9Yzz-00041z-Kc
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 18:29:55 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1q9Yzy-0001Dh-07
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 18:29:55 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-4f004cc54f4so9515136e87.3
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 15:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1686781792; x=1689373792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sT2zNuv2phtjQU5OPD9fFC2fkypnPs4G6uJZmNeP++4=;
 b=RbUo9xACmq3X1TdN3aTIZRc5cBNstgcTidBhoxIa311MfzeXcbo93mb3NIJbUe32zD
 BjiN2CU91eW40setDGPSNDaVlg2Dg6mv9Re2t/q6AwS6ODLln+8pcZI0Fp/11DiR7Wt0
 syFTylGvclvU1hWX5/yNXAkDpv+211yKbj55YxztDkgePU8013lrvTeQ7l+dTMEWQOxo
 XLuvqu+82ifiRHs4Mb7K8QqoDT40oVCKljSfxLqq7Nsjt8GykfeU0CTbPk4p0BQXu6pt
 2TrtRr2nSi6+hQK0Y6pS0Yi0y43QYv5ovw2+YdAT8i1ikyGBvH+5rf0lrzN64dbt7d44
 qD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686781792; x=1689373792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sT2zNuv2phtjQU5OPD9fFC2fkypnPs4G6uJZmNeP++4=;
 b=LDI145h8GhC81be4Jykn8ol9zmOV2oryWSihCa6kIYk1adwlSvUEXFeLt/Aa4aALsX
 Rb0qkRk9P/FlYzyoDjwHZiJyDc5MT/GPwJI98eehiShlNR9Tb/pNVEStf5FgEQt2UZcr
 CW1+Zj5077xqCkNJvAWIXOepw5QNnruKJC4RnOGprV5K8PLa/y8USTwapTXYiHB+0ojg
 ManYtjKot0tCCv5aga9w3FTiJ/ENagfLLepk4E1rkF1zBYC8/S3qBppE1zCVIiuA/TZX
 TunlscIGHv1DrRyR0lXNsAR2JsbfeYocx07AYg1WZliApY15QJTUvXcmTl1NDYbtN2Q6
 Txag==
X-Gm-Message-State: AC+VfDzXpXsxPvZLW+SQTGYX9vElEuQy7dYoBr1sIt1cB+Oy7N3zrIXt
 N3BCTPLMVFVkgykFahE8Ji3AzYsSYP9bL2qZnuw=
X-Google-Smtp-Source: ACHHUZ4jsm3pkSittfmiUBhk0HnWs08pEGWE551AZUp9sXFgFkQBJ8DFwWOZm8G/pJv/Hy2bScLm3Q==
X-Received: by 2002:a19:6743:0:b0:4f7:6049:7d9a with SMTP id
 e3-20020a196743000000b004f760497d9amr2978610lfj.30.1686781792536; 
 Wed, 14 Jun 2023 15:29:52 -0700 (PDT)
Received: from localhost.localdomain ([46.98.110.34])
 by smtp.gmail.com with ESMTPSA id
 x8-20020ac24888000000b004f39837204fsm2279483lfc.85.2023.06.14.15.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jun 2023 15:29:52 -0700 (PDT)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, berrange@redhat.com
Cc: yuri.benditovich@daynix.com,
	yan@daynix.com
Subject: [PATCH v3 2/6] ebpf: Added eBPF initialization by fds.
Date: Thu, 15 Jun 2023 01:10:22 +0300
Message-Id: <20230614221026.56950-3-andrew@daynix.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230614221026.56950-1-andrew@daynix.com>
References: <20230614221026.56950-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::131;
 envelope-from=andrew@daynix.com; helo=mail-lf1-x131.google.com
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
2.39.1


