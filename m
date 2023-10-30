Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7227DB2AB
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 06:16:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxKca-0002T4-Mo; Mon, 30 Oct 2023 01:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxKcV-0002Se-UW
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:15:23 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxKcQ-0001zC-GC
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:15:22 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c9b7c234a7so35820025ad.3
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 22:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698642917; x=1699247717;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S2csIrRG0Cf2zYSUpf3Xcfmr5f78RVFEWpUaJ6HefMQ=;
 b=eExEn8qG1fGRWbBUMVA1BAZK4mvB1yrH2a0PFqoNNMQMGRYC/pCwClXyyE6SMIu6Iw
 9/Fr8AHjd/0jbqA5xes9GsDNORaVqBwDDjVsnXRrgMRQAKJLNPV9HLajIlkAn6JE3m2+
 K0sHr9Cg0yB2k+isNevL9/aUN/ufMflsHFiIcbzovbpC3A2r92taU70Nw7E+xomCZyUL
 2WLNYCXhe22QCyDKJn8CNDqmoSYFBXveFtBhGYXKuy2rs1kg/voGY/8WUAntgZXLClVr
 2FNmfABQvO3dQ6Zq0np/XxkuO1N75O7fgSvO2EiB8f1ql2OdHqUKFwbHRS9ZR/JcbBqT
 FbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698642917; x=1699247717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S2csIrRG0Cf2zYSUpf3Xcfmr5f78RVFEWpUaJ6HefMQ=;
 b=TcFEJJdvHjmL+dgyln2qDfWy5i4el775+1CIwoA6peYWugs/tSLhPYPdo4+wrqoyGb
 rOfEvCj0G+aLa/T0Xn8VU+NjEGrimJPCMYOKw0wzRsTG/dGdEYflycDkg1DKNoSVnovX
 hmhFhBgfezh2JT9/QP6T+tFIuTv/DOKYk5/1/J02aNxC5hFZZ4jX4O8pe2kXo+8KAMh7
 QUFBH5wNWerYz8DmJuQGNLW63hmUUBNaw8XgSEsonzlv2RaowKQMi/nNKlsq+76Dz9kT
 MQmZfSTOG8oxGhtlKLvjG9pz4/C9qQPIE3n2TK0PPjxrIvIqYAq/hdIUQ7bAvehwEw5o
 oaoQ==
X-Gm-Message-State: AOJu0YxXnq67hXvKTjOwAlcvRHrnn6jZ3Z7g2PcayHKoHluIIcO5/7co
 nrDK/0QoTtp3UQVS60Z6+9qSsjbxJccUyn2mrY9XTQ==
X-Google-Smtp-Source: AGHT+IGyiZGwGRkdhkLX0O28ZDijYF9604/aJC3aJ3LlVnhp8Ul+oBLBJvGFYOOMLcmP2gEN+9/KRg==
X-Received: by 2002:a17:903:246:b0:1ca:2743:bf79 with SMTP id
 j6-20020a170903024600b001ca2743bf79mr12003745plh.39.1698642917082; 
 Sun, 29 Oct 2023 22:15:17 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 ja18-20020a170902efd200b001bb892a7a67sm3556711plb.1.2023.10.29.22.15.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 22:15:16 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v6 18/21] ebpf: Simplify error handling
Date: Mon, 30 Oct 2023 14:12:39 +0900
Message-ID: <20231030051356.33123-19-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231030051356.33123-1-akihiko.odaki@daynix.com>
References: <20231030051356.33123-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
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
2.42.0


