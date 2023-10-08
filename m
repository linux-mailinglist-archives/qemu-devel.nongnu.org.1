Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3837BCC65
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 07:31:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpMMs-0004Fc-Vr; Sun, 08 Oct 2023 01:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qpMMR-00045f-KH
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 01:29:52 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qpMMC-00074b-At
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 01:29:49 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1c77449a6daso30249115ad.0
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 22:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696742974; x=1697347774;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2/drKQsw3H/n//rOXbeBtEedeUYZ8/NjLqaNPEt5EN8=;
 b=JxCbcNDehM3OMMOuJLrwVWgqJqCS5mGDiXX140iGa7JSuMsaEq6DHV1SRrxM5d+r+D
 xLRvoJxRbNGy2HB1r7fr9TZATlIDztYwIoWoxzlh/yjWLtz+4pjKw79dHooDYT8n7dXK
 uFTZePqD1n9SuntmNHDS2q0SP1FaNKP0PrnCvgRHMEh2YeOi/GDk3Msfks//6LNbvx3e
 tHe0Zf4I+KXtFMFZojIvQhJKcAV7XUAUeFU/ZVPCtwBaWvHbTiEoBNkrqQj0c+4DIFmM
 6YmRjo2eH0PuILhAad29s59qES4+nOCVAxTcUps/FPqrV97keOxSvlLCTtp7xsLe1EJl
 Cqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696742974; x=1697347774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2/drKQsw3H/n//rOXbeBtEedeUYZ8/NjLqaNPEt5EN8=;
 b=Z0G8cjvv5jp1LhmPjnnQ+jkf504igYqY34s0MctycNT/Eu8Jl/wAM+fdmrc5Hq3T1Z
 yneuZPGib6vkYA9Hs/wzjdPUdtew2/yY/66S5jAkKX2Qy0YKM0U+xrcp25eguhIsaWRr
 ss0pq9M3iThC6qq2h2cm/+QQOH/qjqS7Lxm5pU5Y889zTwqOM2otmEDloBz555H/vJ2J
 NnHFKqTKOKRW6Rj3sEb3xkEBXcwNMRnf6hGpEMkNNifbdgxW4GTyQJ4Z4Fgci1wmp9wJ
 H73wwZvMayIMp3qye8UbYsqvH8PS7JHn12xho43lWGXSc/et8z3m7W7mGtIr6FE49k3H
 GCMg==
X-Gm-Message-State: AOJu0YyBJWl9x2oPKeZzlxqK86ZiP2ZTZFN+6reahww2nHDzZGHQLq6F
 szFkfg7BelpqBTk1WPzCGHE+V+E1HOBKEkpo00b2nA==
X-Google-Smtp-Source: AGHT+IEQxdetCTUBD1OJuZnJ72hzCK3+yX+anzmZsNun0PZBLFZtRl9woAb4WtId43dE2PEIyE7viA==
X-Received: by 2002:a17:902:eb4c:b0:1bd:bbc3:c87b with SMTP id
 i12-20020a170902eb4c00b001bdbbc3c87bmr11225303pli.41.1696742974688; 
 Sat, 07 Oct 2023 22:29:34 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 p17-20020a170902ead100b001c7373769basm6889383pld.88.2023.10.07.22.29.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Oct 2023 22:29:34 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH 1/6] tap: Fix virtio-net header buffer size
Date: Sun,  8 Oct 2023 14:29:10 +0900
Message-ID: <20231008052917.145245-2-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231008052917.145245-1-akihiko.odaki@daynix.com>
References: <20231008052917.145245-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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

The largest possible virtio-net header is struct virtio_net_hdr_v1_hash.

Fixes: fbbdbddec0 ("tap: allow extended virtio header with hash info")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 net/tap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index c6639d9f20..ea46feeaa8 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -118,7 +118,7 @@ static ssize_t tap_receive_iov(NetClientState *nc, const struct iovec *iov,
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
     const struct iovec *iovp = iov;
     struct iovec iov_copy[iovcnt + 1];
-    struct virtio_net_hdr_mrg_rxbuf hdr = { };
+    struct virtio_net_hdr_v1_hash hdr = { };
 
     if (s->host_vnet_hdr_len && !s->using_vnet_hdr) {
         iov_copy[0].iov_base = &hdr;
@@ -136,7 +136,7 @@ static ssize_t tap_receive_raw(NetClientState *nc, const uint8_t *buf, size_t si
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
     struct iovec iov[2];
     int iovcnt = 0;
-    struct virtio_net_hdr_mrg_rxbuf hdr = { };
+    struct virtio_net_hdr_v1_hash hdr = { };
 
     if (s->host_vnet_hdr_len) {
         iov[iovcnt].iov_base = &hdr;
-- 
2.42.0


