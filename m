Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 215157CB993
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 06:11:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsbPs-0008E0-Ry; Tue, 17 Oct 2023 00:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsbPp-0008A5-NL
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 00:10:45 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsbPm-0004kk-38
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 00:10:45 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6bd04558784so3729615a34.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 21:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697515840; x=1698120640;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d18/i97hlUr6Onmf2G/5q9eDcQFElLasqCEeRxQVnvg=;
 b=oZiKDpP5XVEzxsiYsk7hxHZZ3eMdGjmhlg+nGF01VPHzRp+fEt84jXdeYq64i3vxaj
 61vRA4X835r0iocfX6YjWZMMP8nFb1FmpDPs6lEtngGgDZTI6KOptLg5SnjHW8+BvK7O
 3yMf5Zy9fP1FDk7czpulcj37/4HH1d0qoDe2daI7kHPaoIoN90DQ927hTBI79WaBVI8L
 v3w3ONpgY6XkVhCW5Aaqh6j+8ngAO1LEz0hTvVZz9n13EWTj8THQyZ6W8mR4Nna0OLvZ
 US0ryiVVuD2YSm8wcMeaMWXuBEdaonrnFq6Oy9Dvqd+YnWdXulnZnHSxDping2U1b355
 XOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697515840; x=1698120640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d18/i97hlUr6Onmf2G/5q9eDcQFElLasqCEeRxQVnvg=;
 b=OzOBj9WF6woxGF5H7tC3oEq7bksTjf6XFh8Ws5Swrb1cepKp6vS9/ZkMkrCGfP88Ys
 gHpUTLfCcJUOyK1ofVHUnqRynULQfWgV7P6p7N+8E7oNsJTavY4BHDS3wGIZKdhkD0AG
 JV794u3dfkzvs0bEs/MifnfMzujdbqH/hEzNnMxuDsnI8vnA74uqHBuexX2wTBfOPWew
 WRcy3CNJNfeeZjJxB82UVZXI4l44Bm9eptC02Nt9m4C+ScZCq2pWwRSLgTtY2Z1TxFvN
 MVzwk3NgIYCbAVWwSIRQ9SbBTYM9RrUXlkyTcE7o51ZBkPbaI6h/okHXd9W52E6VF9tF
 d3VQ==
X-Gm-Message-State: AOJu0Yw0yW5QynD5inHK/upME14U9xd+PtY/zf4RqF7CdifIqw+L4m+4
 xtCuwetbAvBGIvs2aL3+quaCbB63g4bVUgGsobY74w==
X-Google-Smtp-Source: AGHT+IHL6F8DZ+2eqyEQdeMN/RfHbHh34w8tIPAeVte439LwGjTDeXuuHquUmZqBvKRFiy/Ls9Qchw==
X-Received: by 2002:a9d:6284:0:b0:6bd:ba2c:fbbd with SMTP id
 x4-20020a9d6284000000b006bdba2cfbbdmr1274010otk.20.1697515839903; 
 Mon, 16 Oct 2023 21:10:39 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 a5-20020aa79705000000b006b5922221f4sm356269pfg.8.2023.10.16.21.10.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 21:10:39 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 18/21] ebpf: Simplify error handling
Date: Tue, 17 Oct 2023 13:09:24 +0900
Message-ID: <20231017040932.62997-19-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017040932.62997-1-akihiko.odaki@daynix.com>
References: <20231017040932.62997-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::336;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x336.google.com
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

The error handling procedures required when rss_bpf__open() and
rss_bpf__load(rss_bpf_ctx) are different so it's better to implement
them separately.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 ebpf/ebpf_rss.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
index fe3184fed9..56c518c604 100644
--- a/ebpf/ebpf_rss.c
+++ b/ebpf/ebpf_rss.c
@@ -46,12 +46,13 @@ bool ebpf_rss_load(struct EBPFRSSContext *ctx)
     rss_bpf_ctx = rss_bpf__open();
     if (rss_bpf_ctx == NULL) {
         trace_ebpf_error("eBPF RSS", "can not open eBPF RSS object");
-        goto error;
+        return false;
     }
 
     if (rss_bpf__load(rss_bpf_ctx)) {
         trace_ebpf_error("eBPF RSS", "can not load RSS program");
-        goto error;
+        rss_bpf__destroy(rss_bpf_ctx);
+        return false;
     }
 
     ctx->obj = rss_bpf_ctx;
@@ -65,11 +66,6 @@ bool ebpf_rss_load(struct EBPFRSSContext *ctx)
             rss_bpf_ctx->maps.tap_rss_map_toeplitz_key);
 
     return true;
-error:
-    rss_bpf__destroy(rss_bpf_ctx);
-    ctx->obj = NULL;
-
-    return false;
 }
 
 static void ebpf_rss_set_config(struct EBPFRSSContext *ctx,
-- 
2.42.0


