Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 792987C9949
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 16:04:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs1ik-0001xH-Md; Sun, 15 Oct 2023 10:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs1ij-0001rW-BE
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:03:53 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs1ih-0007mM-PX
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:03:53 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6b709048f32so1143450b3a.0
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 07:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697378630; x=1697983430;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=66Wq6nwp6JKCW7FgLUM3GGIozoOuRE9kC20BLESWHY4=;
 b=ecg3aNzUeuylKZ3CGvCe6tuftROakMgeqKaIp27TV5LgKCAsz9fL3W25NDmNGZ/Hp6
 IC3miX4PY7Dmjmc3UlWpfSNytJnBJqrS+FbQ/WYIrtMHDjT29O8xg+K6RNNYeob/gn1T
 FrimVnRhDWp1/sj/dS4Q6r4tnAMTv62i8Mwqze48QvZvZBkW+djEQ35/nGJJLPUKBw4W
 dBXZuPl93xDxdaQAhEjujBAuW4SVTlDXgnw6vrCAOaoyOy+wiEzF8cvkaUwmok0jK8ga
 4zTi7edl0f4HkS5gHHVPyoOGsUg5IFcM3xHLonCcccvhN9Wtm/MJysHQaH70oJ77dV9S
 i0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697378630; x=1697983430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=66Wq6nwp6JKCW7FgLUM3GGIozoOuRE9kC20BLESWHY4=;
 b=RW1wsOO2ker8Q6jImb9VzTsnCw543azprsXGzTCZ6dTjgyS/ehnrabJh0AWOn6Q7Pi
 MivItG9XcjbWH15rP9Mw3LVhtInAEdTI8BH49mf7S4B0Y5U9nH7nO8i9FxHDHqZmd5ue
 AcuDw2nXKYnLK7GMf7ahm9zx0GENxbX/Fxb5EwMlb86HnIHNhcAF9Vj2+gSkNbsGXFsm
 P4tbes0j0yrAIYU4VTN+4DKMJ3MZ21LaA8pCzJIxNHCtdjWvWr/xcqM07+oNMETwjRjp
 a015AVCgDGL6dbdCsxJvrDsTSqCcdoR6gCnMRdfvbJ4vc491+Qx0qFb05dY3zlz3dTNd
 xIvA==
X-Gm-Message-State: AOJu0YxKHN/O9T9BUbzxqp3gaI14hFtdg/O6jRvhxPcpGz2TABPvLzqe
 QgfBPvDlqkZ7EKZio5ElcBtwL3gaiAgAAdkDBdx1WA==
X-Google-Smtp-Source: AGHT+IFLts7Nly9ZYjZurWTVgz28eXGlrkZVum73PfUA9dvZubbhczNu4ksRQ3160o2H44U4bgbJuw==
X-Received: by 2002:a05:6a21:62a:b0:164:e94b:d3ae with SMTP id
 ll42-20020a056a21062a00b00164e94bd3aemr26866684pzb.54.1697378630416; 
 Sun, 15 Oct 2023 07:03:50 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 jx17-20020a17090b46d100b0027ce7ee8859sm3058657pjb.13.2023.10.15.07.03.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 07:03:50 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 12/20] virtio-net: Always set populate_hash
Date: Sun, 15 Oct 2023 23:02:44 +0900
Message-ID: <20231015140259.259434-13-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015140259.259434-1-akihiko.odaki@daynix.com>
References: <20231015140259.259434-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::436;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x436.google.com
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

The member is not cleared during reset so may have a stale value.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 20feb20bb1..6eb206f297 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -643,6 +643,7 @@ static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
         n->guest_hdr_len = n->mergeable_rx_bufs ?
             sizeof(struct virtio_net_hdr_mrg_rxbuf) :
             sizeof(struct virtio_net_hdr);
+        n->rss_data.populate_hash = false;
     }
 
     for (i = 0; i < n->max_queue_pairs; i++) {
-- 
2.42.0


