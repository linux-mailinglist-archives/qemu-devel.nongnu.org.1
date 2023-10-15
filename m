Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 919C97C9959
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 16:08:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs1jH-000347-Cf; Sun, 15 Oct 2023 10:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs1j2-0002tX-Tr
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:04:13 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs1j0-0007tu-Ic
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:04:11 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c9e95aa02dso20406805ad.0
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 07:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697378649; x=1697983449;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d18/i97hlUr6Onmf2G/5q9eDcQFElLasqCEeRxQVnvg=;
 b=TKml3dd6o4cIGYJvc//Qf9Yg6ZNGhpwMTnSp5I9aBM3geosFo6ceFlXrBH6M4D+oXd
 FT2YQXBBSt8qrW64AZJBY0+Qb3q4RkDioSx7UiFJGGY/ObGpuTrpFNA0BUMVggiY8QoY
 xAofTzlmH7itJZWEmn7/xcojdOajYRChWYdBraUt1HmAxAih+3xDlhEnk0Av+UPDMy9c
 Ba8n4GydIkoXnWbRtbrV+91NfDAyoB36ipNSx1p+UXDZmUJhC3J8Eo09dss9WzSzQ6eS
 UvX4Ql4SVtoudYkiR9WRmoB/hKdgb+v3bi3JOaDgDRzfs3rFhYknlgwctI+XOD+nEX54
 SZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697378649; x=1697983449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d18/i97hlUr6Onmf2G/5q9eDcQFElLasqCEeRxQVnvg=;
 b=HamU5RQDcF4D0gwn8XetVeNvte0VrwWbeuRjsI97gN73ydol93bSwkx4XiXUEcN8J0
 iGw8sr52YO5rNIeqAMCrB+Bras5fLOsoV+TTNuavL3pyFFTzRVzqZ2bPKMXWh2jOhT81
 bfe3tdQrLHILs+dlU/ShYyNmCkANjku1L+tWBU1AISR5+7HJu+kQCxIyvXCCt43FmxMj
 pglGourjZctQ0mW/cO/5yDjWjAhFLe0r36uzTIv3TDJG4eycbYu1k+RGj2l1BWEs3/Bw
 k/nPWXUn7TglXODCDAywpjblPBIV6fQXC9OIG6V2wXQpPkM+j/TiuvewH2t2E7ONvdJW
 s75A==
X-Gm-Message-State: AOJu0YyuXKG3QHyyJq9UDjxgjo3LMWfIOIyqRRAxAyhdVA1WoAk0Qz7T
 PD03wbMvO3KpgUykTnAMKjwX8ALvZ50q8QaNK4m/fA==
X-Google-Smtp-Source: AGHT+IHG0fIIBGa6QLUD5MiLykhGTDybdggz4W4auRjekS8GLxpWFqX06EerxgJkn41A8fwlw0OfZg==
X-Received: by 2002:a17:903:434d:b0:1bd:e258:a256 with SMTP id
 lo13-20020a170903434d00b001bde258a256mr6253864plb.32.1697378649225; 
 Sun, 15 Oct 2023 07:04:09 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 x19-20020a170902ea9300b001bf6ea340a9sm6862464plb.159.2023.10.15.07.04.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 07:04:09 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 17/20] ebpf: Simplify error handling
Date: Sun, 15 Oct 2023 23:02:49 +0900
Message-ID: <20231015140259.259434-18-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015140259.259434-1-akihiko.odaki@daynix.com>
References: <20231015140259.259434-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
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


