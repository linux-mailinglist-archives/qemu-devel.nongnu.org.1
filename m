Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7797C5849
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 17:41:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqbKb-0003e4-OZ; Wed, 11 Oct 2023 11:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqbK8-0002s5-3e
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 11:40:37 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqbK6-0002Cp-Kr
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 11:40:35 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1c5ff5f858dso49424905ad.2
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 08:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697038833; x=1697643633;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4suv/BvTtFCyaarl96M7QPK/UCb253pLYJ0sJd7urgg=;
 b=o1BFGaFmEK/G5Zt0p2/ubx+LAAOhcDxyLBdlbDXLXntMbmNk6Q5N/o+Gb2sNh5clsK
 1lxh+jb0l0iRwtqrsVxyIQN7GeUabRmokvVx1VRNatNBMfgxpbTaMavDdGpA67WJjOyw
 8rhCRA1Gosf3dHWq8uqadBcL3Cjn6Dt7auAo0qDtJpQwzJoHkFYTH9bVevJSz0qEZZab
 1D5Nzkufnix5eKBskNdTZc3rZCCFYNIA6mFV2bTuRVEffeQL1ZHLJyd7Lr16s57l4hQP
 /f3wnKtYNriGr5mj+n5BRBQIxD4szpAqrppA90GldCnlUa2LzmDDZWlvQ5mW3h95WWgw
 UX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697038833; x=1697643633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4suv/BvTtFCyaarl96M7QPK/UCb253pLYJ0sJd7urgg=;
 b=Lj02lktz+kT4ViBDaKzTRGTPteYLwMN6yMa+C55VC/wvo5970TpFc5G+6ADcHsOXNp
 OLFVbdz4kenMBJPqPmp9TuhAgr1VNdwAK2Gvwlsob4WYev5/Hh47DWr7qt85h71/2ZRt
 5MhV5MdxEAXmzaiV6QrW51Bno9B5TpXL26Kxnu/puqO88OZeG+Ahp7aMy1/0lJKyNaf6
 buE7LZF1mnIQwGo7/UTkXNvXz4HK93dehJfEFIqeesjI/D5UPW45+g8VdjZAAbaoTLuO
 WHfgO8RywUlzJ/U1P2T5Uxle5/9JGrau9wiplH2QsZFdus4FnhPVZredQIZZN3SW74NV
 GTgA==
X-Gm-Message-State: AOJu0YyjtHLR461D4Ex9gvtRgp8QE02H0n0H/iSyRXkNm5lKaoImd1dW
 bKjTvUoXtcdaoXjyha5cHivhVCx0QL7mFAJjZNTvaw==
X-Google-Smtp-Source: AGHT+IFFhRztHtozF2SynWFwmx/PiFYCETGkGfFvjInkFh9GkrnWwwPYKpYjoa9JYSqOm9sg2ZjD6Q==
X-Received: by 2002:a17:903:230b:b0:1c7:3558:721a with SMTP id
 d11-20020a170903230b00b001c73558721amr25911677plh.58.1697038832867; 
 Wed, 11 Oct 2023 08:40:32 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 13-20020a170902c10d00b001bc68602e54sm14127309pli.142.2023.10.11.08.40.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 08:40:32 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 11/11] ebpf: Fix RSS error handling
Date: Thu, 12 Oct 2023 00:39:42 +0900
Message-ID: <20231011153944.39572-12-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231011153944.39572-1-akihiko.odaki@daynix.com>
References: <20231011153944.39572-1-akihiko.odaki@daynix.com>
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


