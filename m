Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CE47CB9AD
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 06:16:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsbPi-0007mB-Aw; Tue, 17 Oct 2023 00:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsbPg-0007k3-Fp
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 00:10:36 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsbPe-0004ei-UM
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 00:10:36 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-53fa455cd94so3431767a12.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 21:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697515833; x=1698120633;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4suv/BvTtFCyaarl96M7QPK/UCb253pLYJ0sJd7urgg=;
 b=K1/ED3Z8JneFZYKFufj4veoZ/RvnfA43KgrAIyhhT/YsaiKx/CG3E7fFtAG/NSKoT6
 j98+RCPRFk4yFE1JO92jFj0LPLQjOJTIJIIj1h2KzvdDJPgLFyuvbKr8zAoMgomhrZzm
 i1Rd45kwg2jQpuTHv/kWSlSiARHNqKqlE/w4Y0I+H0LxN0l+12j/IcG+CAFc3htpbpLu
 E5ek6wXFkt+3B9m3drSc0hwm1nWXbjE3pKhIp//OcwCaYlKzyeNZDKWX9fYkZIlnxcdn
 R6Jq29xmbB4grvtlXPxoj7bBoQgUpNSRv0IbtvEse9KxJEgCLbnxn1ubcJNQSVfidJgp
 h9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697515833; x=1698120633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4suv/BvTtFCyaarl96M7QPK/UCb253pLYJ0sJd7urgg=;
 b=jxT0FmC3pJCUQcb0morfz68zwijPHKurGUOEvv/qU50m5QM1dvuxTPrmIDLsunoiwb
 f1p4j5IlEhVV0KBGLWrkynp2bgyS5lTSkmuWmwdVL4gHgB86xDeGLNW32v4/AN/J3sd7
 DI9cZisMtNV8Vln1tXnMtF1PcHi8D/JmRfRmQ5TWeWXi6fsGWeHEyGa12Vt7jsCOIzCy
 X+ir7LXs7P/PEWk5WSPiqHzHaV1l34gadYPv1/HPndLGCa3Uk+pJSlYkCMXG8djZ7Nob
 QpiIjIgHJubxx1Haw+rVs2qsS02aNe5kfUxyBCHCaUQpt9elkJtjouAS0ihTdhzOefCI
 sroA==
X-Gm-Message-State: AOJu0Ywe7y+o6EXfpqzQ0oxg8DgarhJHAIYoAw2xz5SjyKDPcd2fdEP5
 sHN7lTX//ONMzNJAq2ht8Ue9dNHzkEmJxpowUkLUvg==
X-Google-Smtp-Source: AGHT+IE4U3qmFXJuqsdmim1Nwi6afi8Wc+Hcm4Bh6lE4e4d+/RS+IuPNIWKdHLj/HMkURux9KPC1Rg==
X-Received: by 2002:a05:6a20:4306:b0:174:af85:91fc with SMTP id
 h6-20020a056a20430600b00174af8591fcmr1101396pzk.48.1697515832147; 
 Mon, 16 Oct 2023 21:10:32 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 v7-20020a170902b7c700b001c9ba6c7287sm392543plz.143.2023.10.16.21.10.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 21:10:31 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 16/21] ebpf: Fix RSS error handling
Date: Tue, 17 Oct 2023 13:09:22 +0900
Message-ID: <20231017040932.62997-17-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017040932.62997-1-akihiko.odaki@daynix.com>
References: <20231017040932.62997-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52d.google.com
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


