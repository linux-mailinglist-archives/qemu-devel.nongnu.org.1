Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF8D7DB2AC
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 06:16:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxKcQ-0002Oh-47; Mon, 30 Oct 2023 01:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxKcN-0002KR-22
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:15:15 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxKcK-0001uu-Fu
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:15:13 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-694ed847889so3393397b3a.2
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 22:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698642908; x=1699247708;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4suv/BvTtFCyaarl96M7QPK/UCb253pLYJ0sJd7urgg=;
 b=szA2uYGagyLXtW5f0cyumVJbMnU6kaFJ6nTzUnS9PVwrW31G0mJx2YHh/auM8qcen1
 R8ZZaLM89HF/LJ61IMuLVuP6EZKfo47bQ3N1vfZfn3W2RNZgAywhB5VyjMBDbwAWvQLc
 Ks15Z8mXwMQGFfm7KBDjJJhvzkonju2T2qhEOj3Q0Q/sXJuPRlMUcEQ+JgvyzZDD+z5w
 KRktGZKJLee14BpUSv/yKCl/cTRCPDP5j9W+XmLhkUzoQFtyKxg7VqWcR72e8BKcNmlQ
 FH/+NU7GNQbbRg6NKJK8gI5e3pTydS4sjNS6MQqYL8jb6T0iJ2i/GmrFS1YzcNS4t7ej
 X9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698642908; x=1699247708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4suv/BvTtFCyaarl96M7QPK/UCb253pLYJ0sJd7urgg=;
 b=NKUrclavh1VssA4gdg+OrjMh3mBZMLUIVXBLLVP6OtZfwJJyhUcWYmSHqo+Hw+SMm2
 QNwl+EfsaFBBCm8UPUOtvCLUQ7Y8Na0jaL+Pgp9mxvBZ2Q5HREkMOD/lipVHDlF9ZUxm
 E1K7veyBYFZuhgTN0l+aJHU7Y6sgynBFitFjf9zq0PRQNgqB5vmHpofeFx27it5bzbQI
 XfRyrK1WjCWYefGjGlGmgcpy/aPtg32BDrVSX+H8nMDgAE7e+NAmlQcPU9W6hG09V4WO
 kYFzHqDaRBM2quy/rn3Z1ZwMRk/HSOoM3oROXoqJvFG4/qH9Vn9vXQZ1dHZpKgEd84hU
 4txA==
X-Gm-Message-State: AOJu0YwuNu7NJlTlw72cLDX6Rvo7tUAs/1fVEMBBm7ehU2kKT8y6266B
 GdjO/eoas4DHiBOHMLhT4OF65v1ZCAcC4VbMvC4oBw==
X-Google-Smtp-Source: AGHT+IG+MjQ4VSEwcJfdhxH75Blwcw01DTYRN8GyWVizZwmlMDhewWuUvwX/b0oBhr1DfbGuNxiZfg==
X-Received: by 2002:a05:6a20:2447:b0:134:2b31:e2a9 with SMTP id
 t7-20020a056a20244700b001342b31e2a9mr7958892pzc.0.1698642908641; 
 Sun, 29 Oct 2023 22:15:08 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 u8-20020a170902b28800b001cc2c7a30f2sm3978339plr.155.2023.10.29.22.15.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 22:15:08 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v6 16/21] ebpf: Fix RSS error handling
Date: Mon, 30 Oct 2023 14:12:37 +0900
Message-ID: <20231030051356.33123-17-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231030051356.33123-1-akihiko.odaki@daynix.com>
References: <20231030051356.33123-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::436;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x436.google.com
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


