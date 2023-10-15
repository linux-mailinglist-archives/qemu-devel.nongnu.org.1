Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 680A97C9956
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 16:07:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs1ix-0002P0-87; Sun, 15 Oct 2023 10:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs1iu-0002EC-A5
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:04:04 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs1is-0007oT-ND
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:04:04 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-27d5fe999caso257602a91.1
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 07:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697378641; x=1697983441;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4suv/BvTtFCyaarl96M7QPK/UCb253pLYJ0sJd7urgg=;
 b=Lpphr74cdK2DDU6qG2+OLsPXAst/QZRjl5iG5xtiEraNhVrAVHp9dTut5EHn5RbSGG
 JuXhFPXJE8ZunlroF+KQzuxCtSLpraDWRRCCqY1qtnacRR8/C5ikmdCyuPB4ElpkPjdV
 qt/jJ7ibIPqlDl/CGn+oVANWgvH3NXNt1qqGZsnPpo4os9W//x7LkwUEDCFGGeQNILKX
 80VUHba2uLwlC45c944FToehXxIE4iTO0cfGXyH7s0oboQ2XiU/3lheqlLToidnakerR
 gbNQ/Q7JBA10C5vEKkXIpX73d5x6MXopFacJkc80c9xyiVy6n7J8sGd4J/5SPuo+cEoR
 vCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697378641; x=1697983441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4suv/BvTtFCyaarl96M7QPK/UCb253pLYJ0sJd7urgg=;
 b=d4UdC9n8K0UnFe5A9HE2jfMOHVf3SMbhlNC5GtsDGZI6bl/RmjgtvfyGxQAhTreJMv
 KJslN6TrLJ2cT0x7RK1puYJGCgn0xxhdO2a+MKEijPAjMh7pln8coDsGTHPNybp95KrZ
 0fGOewJ9zy8edPnA/B51Jg3y39rVK2FmWZ4xf2aVNuERysegMRbRdjD++MnLtyDQni4f
 TS9TN9hxpgvy2NCFvxmS7CVDPfT9RCKR1HHpKDGU6QqPp6IsIvVZtorU48TVjzux/B93
 zbcIpuputN/Fz7kn0g5rS7DmMW89nug89VTeX4XVhH30Vho9PLhMbp/Xm61qHO3H9laA
 Up/Q==
X-Gm-Message-State: AOJu0YxxEL03A0A6xWyDOkJ41ytKF8GO7S+ZMi8qA/dQbveFZ8cFY1VT
 d6MLkFvN1YbXmTP3h2G2hWcAPfZZ17HR/PCVGHVjFA==
X-Google-Smtp-Source: AGHT+IHoNnZYdZQEDPPcNMteL0Ys2gU1mn7pchSzsKeXJPgukbviNud1EoBx2HHa14X85OkvtHAS6g==
X-Received: by 2002:a17:90b:1194:b0:27d:2e5b:55ca with SMTP id
 gk20-20020a17090b119400b0027d2e5b55camr5791270pjb.26.1697378641409; 
 Sun, 15 Oct 2023 07:04:01 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 30-20020a17090a199e00b0027d15bd9fa2sm3388696pji.35.2023.10.15.07.03.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 07:04:01 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 15/20] ebpf: Fix RSS error handling
Date: Sun, 15 Oct 2023 23:02:47 +0900
Message-ID: <20231015140259.259434-16-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015140259.259434-1-akihiko.odaki@daynix.com>
References: <20231015140259.259434-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1035;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1035.google.com
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

calculate_rss_hash() was using hash value 0 to tell if it calculated
a hash, but the hash value may be 0 on a rare occasion. Have a
distinct bool value for correctness.

Fixes: f3fa412de2 ("ebpf: Added eBPF RSS program.")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tools/ebpf/rss.bpf.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/tools/ebpf/rss.bpf.c b/tools/ebpf/rss.bpf.c
index 20f227e2ac..667ea6899e 100644
--- a/tools/ebpf/rss.bpf.c
+++ b/tools/ebpf/rss.bpf.c
@@ -377,18 +377,19 @@ error:
     return err;
 }
 
-static inline __u32 calculate_rss_hash(struct __sk_buff *skb,
-        struct rss_config_t *config, struct toeplitz_key_data_t *toe)
+static inline bool calculate_rss_hash(struct __sk_buff *skb,
+                                      struct rss_config_t *config,
+                                      struct toeplitz_key_data_t *toe,
+                                      __u32 *result)
 {
     __u8 rss_input[HASH_CALCULATION_BUFFER_SIZE] = {};
     size_t bytes_written = 0;
-    __u32 result = 0;
     int err = 0;
     struct packet_hash_info_t packet_info = {};
 
     err = parse_packet(skb, &packet_info);
     if (err) {
-        return 0;
+        return false;
     }
 
     if (packet_info.is_ipv4) {
@@ -521,11 +522,13 @@ static inline __u32 calculate_rss_hash(struct __sk_buff *skb,
         }
     }
 
-    if (bytes_written) {
-        net_toeplitz_add(&result, rss_input, bytes_written, toe);
+    if (!bytes_written) {
+        return false;
     }
 
-    return result;
+    net_toeplitz_add(result, rss_input, bytes_written, toe);
+
+    return true;
 }
 
 SEC("tun_rss_steering")
@@ -546,8 +549,7 @@ int tun_rss_steering_prog(struct __sk_buff *skb)
             return config->default_queue;
         }
 
-        hash = calculate_rss_hash(skb, config, toe);
-        if (hash) {
+        if (calculate_rss_hash(skb, config, toe, &hash)) {
             __u32 table_idx = hash % config->indirections_len;
             __u16 *queue = 0;
 
-- 
2.42.0


