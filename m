Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA8087866E
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Mar 2024 18:42:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjeb-0002Z9-3j; Mon, 11 Mar 2024 13:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjeY-0002Z0-Qf
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:41:34 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjeW-0007NI-8f
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:41:34 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e627596554so2250876b3a.2
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 10:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710178891; x=1710783691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N4Cx0ZaTSrFNoq7rJ39FkSsZPS8YFhgH7P+2DPv9QN4=;
 b=H/BnlesQf31DiRT2ZExe7QrAHDLSN1Go++WoiI5as4EcgXWKJaXyZwAlmpR37Ojuf8
 yLSwjZXmZGox9+G9sY5I10ggmKK/woZLMQgbc2lbvJNV8jZmf5YLvHYvLACx/N46CNVI
 460GbP0OMDWww1SlpYlU+WWxFWmkjWISk2mlILfaCbTqUj/8etiFwiJGTs36tjQTYwGl
 3QUXs5qAYBMqggXdIdJugKM4iNS5eNNp8EvQt8BvFkYqTmhXsAGkCdz+xtCJTF4tYkTo
 kZJUXE/AQZ+AeN2Yvbz70znu/GHNPgpCrcbfK2qDF6tkLsuc7eGjW862yejgNhaCzcGv
 XC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710178891; x=1710783691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N4Cx0ZaTSrFNoq7rJ39FkSsZPS8YFhgH7P+2DPv9QN4=;
 b=YpAexDsd95E7IptR/4N4Hl5pMGkMPz9vcmug1B0pqHLltLql0Obq7aXgOKkGT2Bo2L
 1Q61PtQNhAXdYdzTPKyyEP5Kq7OAt8TXlDGBZU9ia5PMJdAvKYHR+FrzcTb9+OO/bQNB
 Irn0KU8G0U7bFD5fFWGbFbKQE/Je6LRZcFCQ/ouuHiGGvZJYCIzjFWk1ZA6Eyxe/PeZe
 f7gVLsRLNEpPuvCU1tWP5+YcXXiyMKfItD+K/MbruHvO+RhlKRr19eGPHjtw2bLjVa3q
 n6ACBk8FdphlF1zAWlDRhEdIzl1O73+PaJcpML7C/1DWc3Nk2kjjevF56j+29dLGmmMx
 HCUw==
X-Gm-Message-State: AOJu0YxO6x1EyAyYKokkHZdPpz75QhDpBDlJ4YBqAIJSkrKVjjFB8O9E
 P8CUM7G1034AAjfr13LftI2uYA4tJmFHJdiOXSTz8ZG3PD67/rGXw6M/tMoVwcc=
X-Google-Smtp-Source: AGHT+IE4OFlSOLVpgo5Wr4qd3RiOLb6X6AswktBcaG+MRqpCmwEUSoa8uBJv0Xe78ihuMIFNF241GA==
X-Received: by 2002:a05:6a20:6a1d:b0:1a1:72ea:2da9 with SMTP id
 p29-20020a056a206a1d00b001a172ea2da9mr5835258pzk.19.1710178890752; 
 Mon, 11 Mar 2024 10:41:30 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a62d412000000b006e67b4d7b74sm4593187pfh.197.2024.03.11.10.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 10:41:30 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v4 10/24] virtio-net: Use virtual time for RSC timers
Date: Tue, 12 Mar 2024 03:40:12 +1000
Message-ID: <20240311174026.2177152-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311174026.2177152-1-npiggin@gmail.com>
References: <20240311174026.2177152-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Receive coalescing is visible to the target machine, so its timers
should use virtual time like other timers in virtio-net, to be
compatible with record-replay.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/net/virtio-net.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index ad12d80677..2ce1d53a0f 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2120,7 +2120,7 @@ static void virtio_net_rsc_purge(void *opq)
     chain->stat.timer++;
     if (!QTAILQ_EMPTY(&chain->buffers)) {
         timer_mod(chain->drain_timer,
-              qemu_clock_get_ns(QEMU_CLOCK_HOST) + chain->n->rsc_timeout);
+              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + chain->n->rsc_timeout);
     }
 }
 
@@ -2356,7 +2356,7 @@ static size_t virtio_net_rsc_do_coalesce(VirtioNetRscChain *chain,
         chain->stat.empty_cache++;
         virtio_net_rsc_cache_buf(chain, nc, buf, size);
         timer_mod(chain->drain_timer,
-              qemu_clock_get_ns(QEMU_CLOCK_HOST) + chain->n->rsc_timeout);
+              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + chain->n->rsc_timeout);
         return size;
     }
 
@@ -2594,7 +2594,7 @@ static VirtioNetRscChain *virtio_net_rsc_lookup_chain(VirtIONet *n,
         chain->max_payload = VIRTIO_NET_MAX_IP6_PAYLOAD;
         chain->gso_type = VIRTIO_NET_HDR_GSO_TCPV6;
     }
-    chain->drain_timer = timer_new_ns(QEMU_CLOCK_HOST,
+    chain->drain_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                       virtio_net_rsc_purge, chain);
     memset(&chain->stat, 0, sizeof(chain->stat));
 
-- 
2.42.0


