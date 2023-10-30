Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3BE7DB2AE
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 06:16:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxKcm-0002fX-On; Mon, 30 Oct 2023 01:15:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxKcb-0002Xw-AB
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:15:33 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxKcY-0002EY-5i
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:15:28 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5ac865d1358so2799069a12.3
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 22:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698642924; x=1699247724;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y61p5FMMcfWvvqbRqBr1GjNfFP2hj2byDlX9tvC0bnM=;
 b=HTfKouTDkYlinpI2U4stxcHCTzLFVMf/4JonnB4viwpbvs1ByyrcQxqJaZyK4n9z9t
 i4C/JqxKldAmKHdV1fyZYwUg6SrMKQDv1KSUv/H7x70OmNPPngeb0BbKcz5yWrRZiFwz
 1Jc5wivmGpaS0eIGmV7PXYCWXt/b90lhIPfnGe/oA3TQ7+Zkf21S0r1VRDFvGYeFLh1V
 ZJLuhXWxAxp22qIfc0iYfJug9t+Lb0/d2BZFTer5RtqzTfa0NbeqhV+wpW+Iy3xsxuTS
 AJt/l685oBXfFsMy3cAL5oMl9ALRW5r4Dz6FDDHnoKvV1yMiVN0zeUWI1YklTKGRLTop
 7wOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698642924; x=1699247724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y61p5FMMcfWvvqbRqBr1GjNfFP2hj2byDlX9tvC0bnM=;
 b=v8pGAogJ4aHWtLkFx0t0dAS7aOVYp3MUN8d3wSCdutjsPXzWVo6jQEcdqL5cmkUAiF
 4X4FbjlzF2W81PRhi8rTOjYlr4uerIaOrEvEvtU8bSjYwoqJgzmtyWb973d3YsOYEyKG
 8JOAJ26MMA8MhkqIHPwlqeKbu85QvInI2FgTh8WdAgR3kPnR+0eqZ7sTB4euaaa/IEIC
 88oHT7UPggr/FjeB8evV3ssDn+04s79XAydUgPJovdnVu/Tam1QHD6QfYGyJUsslESWd
 NmTvr7T1iXhBpcEU2C5/pPnT8lgHza4DGAlDNHHNnh6j8gE8m+J/sBCgT+kvpA8+EQjl
 DT5A==
X-Gm-Message-State: AOJu0Ywbdjhpxl9uiZyUN1hMgubyozqgmZo3DpN9NOCTxhzfeMUbY7Pc
 n1ARw4y4SEQ2aRZPKgVnQqYcD4irERcqrhv/DwSOpg==
X-Google-Smtp-Source: AGHT+IEFAS1Gy3jMdGMnn3HqFrKAmvnAWuTQS2Vtmz8IrFyK1TAI7v6NH4toS5OSclF0f5nlzbfhwQ==
X-Received: by 2002:a05:6a21:a108:b0:17d:ed85:541e with SMTP id
 aq8-20020a056a21a10800b0017ded85541emr6533818pzc.45.1698642924453; 
 Sun, 29 Oct 2023 22:15:24 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 i12-20020a170902c94c00b001c726147a46sm3146180pla.234.2023.10.29.22.15.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 22:15:24 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v6 20/21] ebpf: Refactor tun_rss_steering_prog()
Date: Mon, 30 Oct 2023 14:12:41 +0900
Message-ID: <20231030051356.33123-21-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231030051356.33123-1-akihiko.odaki@daynix.com>
References: <20231030051356.33123-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52e.google.com
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

This saves branches and makes later BPF program changes easier.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tools/ebpf/rss.bpf.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/tools/ebpf/rss.bpf.c b/tools/ebpf/rss.bpf.c
index 22c75d5912..012af38df1 100644
--- a/tools/ebpf/rss.bpf.c
+++ b/tools/ebpf/rss.bpf.c
@@ -544,27 +544,23 @@ int tun_rss_steering_prog(struct __sk_buff *skb)
     config = bpf_map_lookup_elem(&tap_rss_map_configurations, &key);
     toe = bpf_map_lookup_elem(&tap_rss_map_toeplitz_key, &key);
 
-    if (config && toe) {
-        if (!config->redirect) {
-            return config->default_queue;
-        }
+    if (!config || !toe) {
+        return 0;
+    }
 
-        if (calculate_rss_hash(skb, config, toe, &hash)) {
-            __u32 table_idx = hash % config->indirections_len;
-            __u16 *queue = 0;
+    if (config->redirect && calculate_rss_hash(skb, config, toe, &hash)) {
+        __u32 table_idx = hash % config->indirections_len;
+        __u16 *queue = 0;
 
-            queue = bpf_map_lookup_elem(&tap_rss_map_indirection_table,
-                                        &table_idx);
+        queue = bpf_map_lookup_elem(&tap_rss_map_indirection_table,
+                                    &table_idx);
 
-            if (queue) {
-                return *queue;
-            }
+        if (queue) {
+            return *queue;
         }
-
-        return config->default_queue;
     }
 
-    return 0;
+    return config->default_queue;
 }
 
 char _license[] SEC("license") = "GPL v2";
-- 
2.42.0


