Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 474BE7C9950
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 16:04:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs1jL-0003kf-Kc; Sun, 15 Oct 2023 10:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs1jB-0003Go-Rq
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:04:22 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs1j9-0007xD-BW
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:04:20 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6bce254ba56so474057b3a.1
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 07:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697378658; x=1697983458;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y61p5FMMcfWvvqbRqBr1GjNfFP2hj2byDlX9tvC0bnM=;
 b=Q9SVS/5RlpQE7pydFIp4hDVNqXdtFquoI0W2nMRBcvt7AgPlQt1EjQ+xSAt5dAa4pK
 alrCfnlJvOMAFbccPDjnpAuKMZ4qFoRPLxWeewC560BfHCKaDWi1ElrINrFA6Mzt8BgK
 Sj+UA95kvLA5tHxsd/SSL0M1FABHr8sOX5in6jef31euBXtzxd1/wCFCqlbNptikWbPK
 SQTUt39JT0a8oEADMhuh0mlIBgry+cL/SCiDG+B/BrZKie2QkpJ8YmX7ODlJbRYuVkGp
 esD7OlBiWAoIoS8oxEPhamZE2QAnAyoPQ3YFtqDMptEpkWKsGgvXwV/pWiok+LiMvuNX
 332w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697378658; x=1697983458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y61p5FMMcfWvvqbRqBr1GjNfFP2hj2byDlX9tvC0bnM=;
 b=ghy8KYC0DJVcwI7B7g3z8mSAzo603u+veHENBy+BKpLBB8sALb5t88KKzhgDQXovHL
 vULFj+rFYgrHIqmnOdbGBoys4FZgUBOfmDA9DPHQJhw1j5RYwPGaN5LsWoDish0UDzRc
 B1y11R5BzFKux/bByHCZ9N0brykViySRbEmnUP/B68e8UQJBMwKZg7Hqp321anAFLRQM
 7gwL0fZe2q7NAmuYjVm9MjNtTog5qqe0DfFglcyP9KrJr/wj7cdY6QeyAlrF7L1l+bna
 5ozDgSJ+7s+R64plSqP5FDtcmPzNhWWIriUj6gPXvPY+3t9yOFo8ZkTdzPpWXEtM8kWf
 mDqg==
X-Gm-Message-State: AOJu0Ywb9m37z5AE0Qq3D69WE+4F5kW9jj7Is1KTToYt4Tv3/eBUlBik
 anlIHZ1637ebN6+DAMI30TlOW2nO0XmAbYv7Rc3wGQ==
X-Google-Smtp-Source: AGHT+IE21iiXsOgBl+NYQdbf/DQpWDTU8VTVqpw6X9oNi2NuITfR9JWScDrjqwDTZmGOfPpi+uMoXg==
X-Received: by 2002:a05:6a00:a92:b0:68e:399e:70db with SMTP id
 b18-20020a056a000a9200b0068e399e70dbmr31519988pfl.6.1697378657747; 
 Sun, 15 Oct 2023 07:04:17 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 j15-20020aa7800f000000b0068aca503b9fsm16476292pfi.114.2023.10.15.07.04.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 07:04:17 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 19/20] ebpf: Refactor tun_rss_steering_prog()
Date: Sun, 15 Oct 2023 23:02:51 +0900
Message-ID: <20231015140259.259434-20-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015140259.259434-1-akihiko.odaki@daynix.com>
References: <20231015140259.259434-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::435;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x435.google.com
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


