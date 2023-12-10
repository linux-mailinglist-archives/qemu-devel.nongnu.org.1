Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F3880B90A
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 06:32:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCCPF-0002in-GZ; Sun, 10 Dec 2023 00:31:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCCPA-0002ZD-2F
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 00:31:04 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCCP7-0003Hh-Qu
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 00:31:03 -0500
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3b9d2b8c3c6so2507566b6e.1
 for <qemu-devel@nongnu.org>; Sat, 09 Dec 2023 21:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702186260; x=1702791060;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Qvzil6Rk6oklx2iI721eED0u1hPwR1TQxrt5QVmBpVY=;
 b=ddH+qPCupfCJuZIue3Jw5I1SpaGglUYrLK8SSi/mwZVGz8poQiDkmnleUdrkhosm3Q
 eoN2nqcbBVVTohj9GfwbLSYPXJg43D/bJyBkKGsRDmIasvPk55e9Y0DN7Y5CsxBTFYp8
 nG8/8ZdF5nCu2fGx25DuL/BlzkkQhPmjn/kdTF1xguqjO7L3fEQyAo5xcy9G4vVbdJl2
 6yNzxcspXf0vxx3im6JmsBQTJGFGfD8u/Wo8YJi2mVGPA3r3cdrAr4m/yOwlDs3f2WSU
 sh5MsHwzOMi2vqOrKpp//3NFfLmnyN+1DWrTrajvGsy1bu5DUhyr/439QVQmYE72Mu/9
 kxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702186260; x=1702791060;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qvzil6Rk6oklx2iI721eED0u1hPwR1TQxrt5QVmBpVY=;
 b=lWBGNTgGKfRcdgfHkyj7w9DaRDpvPR+h+iDCVlKXFPojyISaLLNmp4vocFf/wIbJkz
 SlcBRbGnNP8cA66PoqsLGSOo3XgUF8piVdw5qKuWfdnp6LXIpRWn9HdxFnp1Md2AHXAu
 A0/VaJubCbezI2AonplnKdzxXfiw+KXYdEokBtUG7WfKl1/fNsL/qQ1U+ecKAWuYvHOG
 N8Sb3V76oxBRJsbDuQMWSZWkixl/5n29d0u01Mkn32J4DtrdBzBPgLb0zQwrpUq3h86J
 YGNQ4FdNS0CYK8VgDkLlOzhrqsIHbt9rjYZfIvC2rdDb3NU2jpHnn73fqkDj+j/CeylT
 8zWA==
X-Gm-Message-State: AOJu0YzrsiD/r9bzs40j6C3pNdjOMsVe+YAe0lI6W+RTkBHc/1+7SNxt
 uv7ERucZ/6Ij7a4Ds4nyp0L0Yg==
X-Google-Smtp-Source: AGHT+IHuLRctEot59aVpPsOCYWJJpaBm9kWy3twRpngIcewUeO5jybw0ZVPQP3vbprsU2J193AedmA==
X-Received: by 2002:a05:6808:2225:b0:3b8:bb95:97ef with SMTP id
 bd37-20020a056808222500b003b8bb9597efmr3084867oib.48.1702186260661; 
 Sat, 09 Dec 2023 21:31:00 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 m9-20020a170902db0900b001d06b93c66dsm4206712plx.233.2023.12.09.21.30.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Dec 2023 21:31:00 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 10 Dec 2023 14:29:52 +0900
Subject: [PATCH v8 14/19] ebpf: Fix RSS error handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231210-rss-v8-14-9553ee714d38@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::22d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22d.google.com
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
2.43.0


