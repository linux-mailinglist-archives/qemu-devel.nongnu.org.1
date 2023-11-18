Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0618E7EFEB5
	for <lists+qemu-devel@lfdr.de>; Sat, 18 Nov 2023 10:28:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4Hbc-0007k7-7W; Sat, 18 Nov 2023 04:27:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4Hba-0007bn-MU
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:27:10 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4HbZ-0003lK-2O
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:27:10 -0500
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3b3ec45d6e9so1859635b6e.0
 for <qemu-devel@nongnu.org>; Sat, 18 Nov 2023 01:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700299627; x=1700904427;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KPGCkWypEGlZmK+emTqpLFaeLzVROi5r21LZ/CdRlL8=;
 b=q7j4rB6nrg4N5OZLPgQu1QHJQe03FFKMUP0lwpFVMwDi1+pIUUN/eG5eTHsDbtyZgU
 JmB04TyiTeRT4zdiZPN2MGUX/g36sdbdBW6xQHTYMBr9kwCiYbkBP1v72C3/iauNXtIr
 kAI+/6w3H2dqf3Tu7pEmdV26ePYHy5qEvYpjTFqnxuDRcuOsw/nnYaU/vK6Ig+TDD+37
 SrL1DMzE9L1I6hS96hr6yNSju7vUr+9KiGEBAR6dLnahu1E/Yaw/SdP/xR8tBZHaRkt2
 ddAT8obu5BtIUZinTcs+rmpkk8aURuzta/epEH7EdI6NlaEhhabLheSw/E1c3vSdMO/P
 Aurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700299627; x=1700904427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KPGCkWypEGlZmK+emTqpLFaeLzVROi5r21LZ/CdRlL8=;
 b=Pgw6jnrtExJKggDD356nq11q9mCpw2v8x946JB0GpEgTm+kEnprrbE/Mn0+LeP3qwL
 OJHwULnyxgWSNZ8rdMq77vyRC1vrbFJfLaT9GjUtRtWyKOEjp/j9gNUvFE3OOqKEA+HM
 V1rTLLBH02Nfiewx2+y5P71jSHZyrdwYkIjer4PNUX3sGXTShlSOtH4muk0MYBKW11hV
 zFPyFs9zHxrbNYMyOQ+GKXjL6/N6yVA6XxxbaK5l6Nbek/LBeQpmfA1Pa5v2Kgp5VGrR
 uxBaaq6tdGkwVWtCPa0zrp0te+BaoXZSCBJQg3M6TwJpRFap4TmA/5MEEwcZiLkEAi0d
 RfQw==
X-Gm-Message-State: AOJu0Yw78D+VPeRc46T79V1/fBAgBkNRmgtS8aS24c+VVONvaPNTqKcL
 uxbxKUz7o5l44hTQGKKCKAAaHmW5IkXu5BM9TU0=
X-Google-Smtp-Source: AGHT+IEJ8nmMIhnJgIXHfAosvjxb7xIyCHiGJvLCSXSl4ArzgZtNzw89PwxzTD7Ma1j3YVXmD9AYFQ==
X-Received: by 2002:a05:6808:2f12:b0:3b6:d665:4938 with SMTP id
 gu18-20020a0568082f1200b003b6d6654938mr2337244oib.43.1700299626912; 
 Sat, 18 Nov 2023 01:27:06 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 q20-20020a62e114000000b006c003d9897bsm2646568pfh.138.2023.11.18.01.27.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Nov 2023 01:27:06 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Zhang, Chen" <chen.zhang@intel.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH RESEND v7 14/19] ebpf: Fix RSS error handling
Date: Sat, 18 Nov 2023 18:25:54 +0900
Message-ID: <20231118092601.7132-15-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231118092601.7132-1-akihiko.odaki@daynix.com>
References: <20231118092601.7132-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::233;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x233.google.com
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
2.42.1


