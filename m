Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E27627EFEC0
	for <lists+qemu-devel@lfdr.de>; Sat, 18 Nov 2023 10:29:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4Hc2-0000A3-Hu; Sat, 18 Nov 2023 04:27:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4Hbr-0008ED-Bd
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:27:30 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4Hbo-0003rY-Px
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:27:27 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-28094a3b760so2180120a91.3
 for <qemu-devel@nongnu.org>; Sat, 18 Nov 2023 01:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700299643; x=1700904443;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0bMxXc53w5OZ8Z87TMnvwY5bBiL/RmptQnjEe3mn7CI=;
 b=df7y3aihg5yHhX7lLITxmtkcCzFePJAbGY7hztiKyyDLCPdPgA8yfzABh18wCqXgcm
 KdAH433fKIwIwzInwsUKMrmLYV6ff0Fwu4p5C02jKATSqe1ceOc9smhGQQJTATzblE8c
 OYyDMBwRmBaQ22QmLuRnSW4aLqC2Qz2gS6idPyGxzaqOu0ce+6KDnY+DJmjehyRgErby
 cQchxWWs/GDvvwEb+bCMrtpw7qX64CBVBBT+ZQbYP7tJUWNZahTGj/r0GOlOriRdpdp9
 efXGgzaA4w4fYeVmg93d9jSk3Ke5cV/Vj5tY62PBm0MmDFyLa6QsumyHLUJc2ZlP4Y4h
 NpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700299643; x=1700904443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0bMxXc53w5OZ8Z87TMnvwY5bBiL/RmptQnjEe3mn7CI=;
 b=aaEB+tK0Kmjn4C9zShK+x+KZ+ORF7nDiVGiZhPuJPxls90uEum5UxVkAKw99XDYxUb
 HtMLTOHwJzsPBp88i0t1NUzbfo9Oh+PRU1XP3eqAgDm5cV5QdFmS9HPARRh87dp8eAwH
 kjtnZOG8QIc2xNr6zZ0Yjtdr4jfE2ycRaRlT7kdyUabncARvCRWrD7TRhoi0uoAMYS5m
 X7O3tKHTPvWeB9YiCcvwsrxebnXo2wYYx20TAZSWWLxB0efVpIDuEIInxvtBn3Ys360T
 PK7+EmqF8lUfRh0g7Briqd20xYah/ozN35qpPzwGKUVptiJu/R49QItJOYWoXru2mnpa
 r/LQ==
X-Gm-Message-State: AOJu0YzX6r/NGzoSuXISObp06FbdzyZEpIK2Jo6/fIyaUCVDB34lhJee
 neAs61jqBOsFrdW4F5RwU6AiAWnP23kpi8Tjbsk=
X-Google-Smtp-Source: AGHT+IH9WIp2kTvCJl5aclAn7z8fqEYRRV2w8Ijo2t6XYmb68TlhbWzLfVm29ckVD37XD+JFjXutwA==
X-Received: by 2002:a17:90b:33c7:b0:280:a460:c3b with SMTP id
 lk7-20020a17090b33c700b00280a4600c3bmr1302651pjb.48.1700299642856; 
 Sat, 18 Nov 2023 01:27:22 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 n5-20020a170902e54500b001ce5b881e21sm2619433plf.306.2023.11.18.01.27.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Nov 2023 01:27:22 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Zhang, Chen" <chen.zhang@intel.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH RESEND v7 18/19] ebpf: Refactor tun_rss_steering_prog()
Date: Sat, 18 Nov 2023 18:25:58 +0900
Message-ID: <20231118092601.7132-19-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231118092601.7132-1-akihiko.odaki@daynix.com>
References: <20231118092601.7132-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1034;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1034.google.com
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
2.42.1


