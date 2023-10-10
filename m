Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1FC7BF129
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 05:01:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq2yc-0004AB-FF; Mon, 09 Oct 2023 23:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qq2ya-00049z-Ih
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 23:00:04 -0400
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qq2yZ-00080a-1d
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 23:00:04 -0400
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-4577c1259c6so547399137.3
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 20:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696906801; x=1697511601;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4suv/BvTtFCyaarl96M7QPK/UCb253pLYJ0sJd7urgg=;
 b=G79BdpKGMPEYHjUdIo5weQw+XT6/1n7o9JVWyF7Ol0j06uOXdiTZ9wh26PPSh5kybs
 eTeQ6aOwE3g2RdL8ZxaGcrGra3DVUpEho9sJD78A3iYTLtEmWz781VLwG/VdL8f9PUuJ
 CRPG0r7O03F3barAjhRpYJyCmsZj+rOuqBJmo/tFgJaJqOpFlE5MmppuI061PzgaAWBD
 skPRRZLyq85vU2yCsJuyf3nPKXftN6zffYRnx91Fsxh3xAP6KIR1bcnFeDFLCS7EaMx+
 R8AFp/ZmKrzqme8hnQ7CAtp41aiGYbb/SdwpsVJpQfT8XsIlF+SIXZPVsA682eFgOWjc
 fjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696906801; x=1697511601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4suv/BvTtFCyaarl96M7QPK/UCb253pLYJ0sJd7urgg=;
 b=ftZ0AsjPSssFkck6Nsz9167ubO24s7A+vT+IJhTYYrq37L6xiExmOr9nJmh1RlETX+
 dpt3Rd+Qj7PKGmIH+k7QWhlWmoyzbH41Kh8pcWXjdA/gLF/ZU/ySL9St0KobrX46KHAO
 kI9dZHiiK67lAoHWOkhkHLzIsNtSqKDU2AG7GkTuiuz4Rx9DDR2+DOG06YGVZODasq+L
 WrYECuDc1TzSDT0uC5ocIS1XRnzjnkA4UZscgZ7+iQ5NvzFiO8VlPegYFT6s0Rmje8/t
 LSMeeO8tOHJIcJjMcAMlDzx2JgeJR9LszdEq0hi2sX7L5v1UABsbaLijk1KJ/N7lkQz2
 hTGQ==
X-Gm-Message-State: AOJu0YybQxOoax0j30UVn+Z9Sgunjz2Dseb691KL7828XbwFUOJxpAOB
 UwRNpQWdBj9vq/vBR0m60aaxwRPqskmLzVYscRX0gQ==
X-Google-Smtp-Source: AGHT+IGSYnq8H3XKdBvjmkkoPqB1eD1gHs+0e8bonWJNjg0WJkiR//Q0muxSow6K/rLddQ6o41Opow==
X-Received: by 2002:a05:6102:34f1:b0:44e:8353:e86a with SMTP id
 bi17-20020a05610234f100b0044e8353e86amr11109398vsb.24.1696906801356; 
 Mon, 09 Oct 2023 20:00:01 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 s6-20020a63b406000000b0058dc763f449sm4291467pgf.1.2023.10.09.19.59.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 20:00:01 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 7/7] ebpf: Fix RSS error handling
Date: Tue, 10 Oct 2023 11:59:21 +0900
Message-ID: <20231010025924.14593-8-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231010025924.14593-1-akihiko.odaki@daynix.com>
References: <20231010025924.14593-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::e2d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-vs1-xe2d.google.com
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


