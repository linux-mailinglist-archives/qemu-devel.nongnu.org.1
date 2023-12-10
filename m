Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9BE80B918
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 06:33:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCCPU-0002nh-23; Sun, 10 Dec 2023 00:31:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCCPI-0002nS-Q4
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 00:31:12 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCCPH-0003Kq-B8
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 00:31:12 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2866af9d73bso2487216a91.3
 for <qemu-devel@nongnu.org>; Sat, 09 Dec 2023 21:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702186270; x=1702791070;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bkDmy8vwTw8n4/D+XpzgLGXmTVVkQvl/G4oe7OLd84I=;
 b=wBGRnr2Gizrk9/B0TY47Egu01Lwqzvu/8bQqIUqVcmqO/0ndQjm74VLPd/uhlgEYck
 0M3ZN9xI7bzgrbYoDVVfR6qngWYeThnUaPCDE+HyFcInd79vtPFVlYHKQkQX7rb7vfuQ
 dGaFYdae9KRT/eSjZeVrSDbsXsCweB7K5JM9byjDPOwI9A0s75rwhPAjVGfAXDTZht4U
 3s9MhyUsLO8aN4wu8juctsp9yOPXPhsC+XDPvXaWXgmXYk1OdQgZFQRI8ST66Jc+1AJ7
 OYTBnB9PpkszjxQI6D6exCreBHi7orcyWMAqtPtbFESwqAXGmdXGOtJYUaZXVsQoSlV2
 SuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702186270; x=1702791070;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bkDmy8vwTw8n4/D+XpzgLGXmTVVkQvl/G4oe7OLd84I=;
 b=O6SbNFfzHGI/U3C0uED6zjSFvg2QDWVG83KhGRq9JVnRyWgpH/+yrVKlgqDiDgHgB4
 JcRVYhi057fPLFJrU4cbFtehXS5/OdDRYA1N/vv1edB/1eTVmdRmAcbfHTlgsxMJ9RQ4
 TfTr3U+N8EdVxawTtC3YWRR0EMfxhgMmBxN3oYJrCOs6+mu/XLD/OKgWGGp4bCIWEE4W
 cSerAP5okgY+1G2uFXfdqXQkhBqu06Mt36LJDKN3BnqtMNR6OHF8kPrsDjvMYosYcT7A
 4jiYkGwe2HbBpwwvwIZpJbXDY8vCM6mK72NGoCkKKaSIwWtEPbeYamgk+AandxRGdx60
 Aong==
X-Gm-Message-State: AOJu0YzJ6plovCfFuoMWxeDIOXBqp4bNmegeXFSVo1XZskFaFZBaZEPI
 NQXpPtm4oWcFslEBByrCtawMVQ==
X-Google-Smtp-Source: AGHT+IE+ceIqORwzC1rp2+jVs/Ji+oYDEqp4cLkKzZUyRtr6vq+L5g3I5d6ogyNRMLui+UkJXNDtig==
X-Received: by 2002:a05:6a20:f387:b0:190:3d8d:a0bc with SMTP id
 qr7-20020a056a20f38700b001903d8da0bcmr885369pzb.13.1702186269704; 
 Sat, 09 Dec 2023 21:31:09 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 qe7-20020a17090b4f8700b00286dae0ac84sm5872916pjb.46.2023.12.09.21.31.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Dec 2023 21:31:09 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 10 Dec 2023 14:29:54 +0900
Subject: [PATCH v8 16/19] ebpf: Simplify error handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231210-rss-v8-16-9553ee714d38@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::102b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102b.google.com
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
2.43.0


