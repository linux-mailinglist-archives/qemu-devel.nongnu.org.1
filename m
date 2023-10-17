Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8AD7CB99D
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 06:13:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsbQ0-0008NH-WE; Tue, 17 Oct 2023 00:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsbPt-0008GN-V1
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 00:10:50 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsbPs-0004nE-C2
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 00:10:49 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1c9a1762b43so42144955ad.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 21:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697515847; x=1698120647;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y61p5FMMcfWvvqbRqBr1GjNfFP2hj2byDlX9tvC0bnM=;
 b=hWPkSSKldsYKAMATXHDdwLvuQ+fRIaYfnAZbFnj2No1ROQ3FzZcjXXo8p4X22HHnG0
 03RBq6P/u5VzYuBePz9iMsvDxTtSrjyTmfmz2mtityarEtAvIdwb7Wzj/kx6C+kQDls+
 uDroBOtWZL8/vEfIQK+tQ7guYmK4cCD0iacodOo88ZYmON7Cc1xr0vD/w5TGGNLFxLt2
 kqFypXOeRj/BBVp2D1Kjr9j9lKbeNJ7kmAljuV9W9K9OtFo9xJmsEB3pE9XevR6nLg9+
 yYhVWXb80rMxqiWH4gdisBadMrJwQ6SDIq61/zGJxSqTV/pUFG2oa9+Go3T/eQcOhBkt
 2y9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697515847; x=1698120647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y61p5FMMcfWvvqbRqBr1GjNfFP2hj2byDlX9tvC0bnM=;
 b=qvfgxcIPonDI0sxgVEtonSZmEvoDtP4o1rCNu0rlhBuVi4/cv0M8HWskA8xtqkaQB/
 +2Wonjc9imBnLkkTeFD9nx8ZEV/rNzyWy7OQghugtyczO/XRChCFNA7MK9r5ux0YgamZ
 +dDjcS0QrsrNnTQ2qy9tvnCmG5kHk1+4Unfrr2y+7BrKOudwi4gciAaUFMMKW0yO4sL9
 8AoJ8/7ZOhjyNSd0+CDrpZX9cKrvhD7+LqFsw4rcJnyfIG75ZQP6I7N9fmk5GDb3wyB4
 ZjFmelF34MllTuUoR9SMvfe/GkfSXaoHACIzJfsVhnO4ydInj8cXb1MLEgoa8OKhvY6J
 e0gw==
X-Gm-Message-State: AOJu0YwMhDOEPQk6Gn6RxofzoKbG2WAOQ3LeWWYg3fX+EOMFjxk00221
 WIVNd/vI9JpL7SR4ZhRgZmaqKe4jX98ZMeU3YDmvQg==
X-Google-Smtp-Source: AGHT+IFPycPwJ8KrB6e40mw2CJ+U0bElbx5vULFTouu74NqAYKkpnNFwP87WeLzNpydkxcR20jX32w==
X-Received: by 2002:a17:902:ec83:b0:1c3:92de:1b23 with SMTP id
 x3-20020a170902ec8300b001c392de1b23mr1103413plg.59.1697515846787; 
 Mon, 16 Oct 2023 21:10:46 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 u14-20020a170902e5ce00b001c0ce518e98sm387838plf.224.2023.10.16.21.10.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 21:10:46 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 20/21] ebpf: Refactor tun_rss_steering_prog()
Date: Tue, 17 Oct 2023 13:09:26 +0900
Message-ID: <20231017040932.62997-21-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017040932.62997-1-akihiko.odaki@daynix.com>
References: <20231017040932.62997-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
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


