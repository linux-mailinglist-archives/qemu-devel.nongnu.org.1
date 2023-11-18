Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2267EFEB1
	for <lists+qemu-devel@lfdr.de>; Sat, 18 Nov 2023 10:27:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4Hbq-00080X-M8; Sat, 18 Nov 2023 04:27:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4Hbh-0007wJ-Sv
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:27:18 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4Hbg-0003mN-4m
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:27:17 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1cc921a4632so25034905ad.1
 for <qemu-devel@nongnu.org>; Sat, 18 Nov 2023 01:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700299635; x=1700904435;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dAX9YwNB2acL/EZNEkUf6KqVF9khE8oXX5NcUOHfVec=;
 b=uVrP/efMD270u4aRQeD64xkdPnK90tCFU51Vr0ZMc5XtrnDMv5vj8k6Cel5Y+jN0YF
 JFG/jS8OSkD45E59hHUAISogczNPwsF+V9J6byrR1lIZRRYdje0s/TUO9fN9yMatb4lE
 Snktdxs/mMvOD1dYSjp2pUrhCMFpZUfTbyvifM5lm2/hVtzn8u/d2+uiLgpiWqrqRRpm
 pTSUdxjFLmPXilwiE1v2UtK48fum5Edq6uAAVtVpyFVdvebM1xZWpk/sAJhQL8/JEWKZ
 vmgcqBsgHFoVe1a6DRmHlmTu5Lbx5oZ4Md+t5WAGHeTT5fW/bAl0rQ/gOOFEU2FgOV8v
 cuvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700299635; x=1700904435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dAX9YwNB2acL/EZNEkUf6KqVF9khE8oXX5NcUOHfVec=;
 b=gKxJ2Hkx7lt8JiZcB3uLRnlP1XpAhW0Pfz3XDtpPlRgyuygDNwIw9exOvM9eMJ+E8q
 hOyDgONHtBRzvtEdHNKKfckfnkRT8Skjt4engRbH5wKxsGGUaBBtzPaFpRms8Jlh24yk
 SzuCYuQs+188qL1Y4Id8DPJSCjEGvs+kHkVm9PndEtHcVUSFbLSiNUoKJbv//JWL7XUj
 QAKZzlTr5/CY1cljMJUfqP6Ykj/7/Zr6VSieBMwXLh+/EFQb6604k1+5AuSA3XUpu0s1
 S7EWhhDS+YYw7xWY+1S17TABb0+kum/5NDIscaBtAID/Uk9bHbVQFpVnXOG75mgxqjVC
 q1mg==
X-Gm-Message-State: AOJu0YxBlmMe8B3GVtOCVh+2LdpBvPIwapWgYgUqcdXO1qOUx+x6SVQB
 iibClX1WhoILP3gKgWHnQ2EE/5RF0S36ShDrS0Q=
X-Google-Smtp-Source: AGHT+IFW4OeUrQXRanL2HkhcRcdfCed2fGNcFMP7BFAcONtS9yUn55eAyNM+TM5Yjj2yd7ZIsfhLrg==
X-Received: by 2002:a17:903:2284:b0:1ce:6669:3262 with SMTP id
 b4-20020a170903228400b001ce66693262mr2886398plh.27.1700299634840; 
 Sat, 18 Nov 2023 01:27:14 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 g15-20020a170902868f00b001cc79f3c60csm2642458plo.31.2023.11.18.01.27.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Nov 2023 01:27:14 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Zhang, Chen" <chen.zhang@intel.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH RESEND v7 16/19] ebpf: Simplify error handling
Date: Sat, 18 Nov 2023 18:25:56 +0900
Message-ID: <20231118092601.7132-17-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231118092601.7132-1-akihiko.odaki@daynix.com>
References: <20231118092601.7132-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
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

The error handling procedures required when rss_bpf__open() and
rss_bpf__load(rss_bpf_ctx) are different so it's better to implement
them separately.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 ebpf/ebpf_rss.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
index 3978333584..2de9e7851f 100644
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
 
 static bool ebpf_rss_set_config(struct EBPFRSSContext *ctx,
-- 
2.42.1


