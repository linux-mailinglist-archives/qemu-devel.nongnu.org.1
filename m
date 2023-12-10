Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D75480B91C
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 06:34:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCCPd-0003iD-Pe; Sun, 10 Dec 2023 00:31:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCCPS-0002tr-D4
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 00:31:23 -0500
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCCPQ-0003Ls-TO
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 00:31:22 -0500
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-35d3b220b64so13926125ab.2
 for <qemu-devel@nongnu.org>; Sat, 09 Dec 2023 21:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702186279; x=1702791079;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hmg932BETBNUeMnLy0gOwsIUVaSQ0c5UekSV9LHea00=;
 b=dtYz/EOrLrAYW2m62zsLsMJ7YwABArus1JTj912rnOMjf4OVCTck0ouP5Uej+PzkiB
 ajSWMLb5Ov0p0IQyuHvoGvX92S0421CKszgUHll7K/I2dGPaKBsVnLgMUnPb4wiCex+5
 XsRBIebVY87miZhAj7iZ9EGssLm2EGjhyvd4WQd+G8kWP0BGNwJEMnsrBLd/c2hEpW//
 viMT3ZFujEMaAVMqhsvTh2ajKg6vEg7Y87b+izpWH45f0dBZYrhd7Tv9XRVyZ9pcSNsk
 uTr5fu0L1fFpV0diig7vvQiXB/wpb9MlCsiXCnYzT+Epq2Pv3QDVsU2m0YW5NScIWyv+
 NjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702186279; x=1702791079;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hmg932BETBNUeMnLy0gOwsIUVaSQ0c5UekSV9LHea00=;
 b=T4AOcngLBwUzBuHrtwPa+MgV4g8IBrO2oXWxoRRNefm8cyCtJ6KRpsI4QO9yON7x4i
 P2xjY+GnXc3Hks6huri1YexEsEVw6j3ytlzseoZRbI9QRUsyqQFefhNuQEIdeL3oDFkv
 vdeY0wrPnrAgjpQmHruBjefd21wbveQv/5nIThKWzfHYO6MSvKD8suErZNkWezO5fV0n
 EzGDSQYFMcafHlh24pMYN/auzbY/U6m6wH6aryweCMMX686zobuG2XHGKRW4VSfrrIG7
 InzpKRXSOdvyyu7eTA4LK2C8LVZiCctj8FRpYQ/UW1CYfrFHMrADOyip8kMdHiegypb0
 SGgA==
X-Gm-Message-State: AOJu0YwrlHwabLIKC2OcjetV98ZxR8H5Do5Zj/J3qcojpq0yymOSciAH
 JrGuiCaFMIBCCVNPLN0IZZkqvw==
X-Google-Smtp-Source: AGHT+IGtVZifyak+FbsMmAtxnZWbO4CJFwxdsk0Dex699hJTRLtJBRfqgV8Q59h9cQpbsGcd/uW41Q==
X-Received: by 2002:a05:6e02:1b8d:b0:35d:60bf:7848 with SMTP id
 h13-20020a056e021b8d00b0035d60bf7848mr3469210ili.47.1702186279439; 
 Sat, 09 Dec 2023 21:31:19 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 w29-20020a63161d000000b005c6eb4bc75esm3962803pgl.35.2023.12.09.21.31.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Dec 2023 21:31:19 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 10 Dec 2023 14:29:56 +0900
Subject: [PATCH v8 18/19] ebpf: Refactor tun_rss_steering_prog()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231210-rss-v8-18-9553ee714d38@daynix.com>
References: <20231210-rss-v8-0-9553ee714d38@daynix.com>
In-Reply-To: <20231210-rss-v8-0-9553ee714d38@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::134;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-il1-x134.google.com
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
2.43.0


