Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E456D7BF126
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 05:00:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq2yD-00044s-Je; Mon, 09 Oct 2023 22:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qq2yB-00044d-Gc
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 22:59:39 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qq2y9-0007wK-Ir
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 22:59:39 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c9b95943beso52405ad.1
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 19:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696906776; x=1697511576;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=twpqTDmEOC/NRz9DRk5Z+a1hOnqgGLqPoSz9/FaiSO0=;
 b=dBdXDhRH+1r2B8xMSLIqvYzlPJ48hzZ76kJSbMsZN9gio4GkrO4OcjtiauNptWAqsC
 ZcM2dos1okQ6J2HAICC/KwEznwCQi/Iud2QoS1RkvNNeGyn/PkGbmEdhkhi/GTBfziVm
 +0FB7YZhyj9Ot7gJv74GsPWqZB3Ba+g7orTLtKSLxWGEYeJfMAYqKuWUxCL3CY/LqsJl
 Tp8hDjDnU1wbj/B3FbO97V2talW+3je/A/RuGQav9+FxxOQg69TJCo4m53kajSYGsdag
 +NG2q3GsQT0akgUzV3NnXqcoybphFFh5TDBc7VRmLApTXpraiWVOVCgYugTvimfn2x+w
 5N6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696906776; x=1697511576;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=twpqTDmEOC/NRz9DRk5Z+a1hOnqgGLqPoSz9/FaiSO0=;
 b=QFO+FP1JNNzBGnUfD3175v4CyKlE1Zf8Tv6Xnn/cmPs0ghip2lTs/bKBMA1LcWLUSz
 CNkEwy2WatyAx0K02PQJ1jnsMJKvTbOsUqNONlGxl9s8IGrWjtb+GFYdez1kQth+RooZ
 3hCV3CozlR4sKhIRqTl1e+vsxKuN1dkzC+puFuoOhZj4RoVhFEIoRmAdLQr6nNcsvfPt
 1NZxW5xtAK1Go3Tex3JAZTWOYSGpfo91uForHUqw0XKD4JRJqPYuwNn4urMtycXpEOvG
 3UAzDGd5dNRGPJc/RDLURUHKE1iQEEp2zF5yP1iZ/4tDyL7UUjaoxG0zGXYiaVg82aBU
 CzEg==
X-Gm-Message-State: AOJu0YwN1PhYLO44Tk7oGC+rhHST2CvjpifF3a447ABuCf5Efpu/GGYL
 RP+hqyYJiyvhFgJXSygYJceAAYdYcOkZC48H/wx/dw==
X-Google-Smtp-Source: AGHT+IH5OUQGe7omwEZKiSkyQ75rcXMzCjYdRkBvRO2eAC1fILfUZAmMg6bxB0IH2erfti/PzZJcXQ==
X-Received: by 2002:a17:902:f688:b0:1c6:3228:c2ca with SMTP id
 l8-20020a170902f68800b001c63228c2camr22649583plg.29.1696906775790; 
 Mon, 09 Oct 2023 19:59:35 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 b1-20020a170902ed0100b001b54d064a4bsm10437933pld.259.2023.10.09.19.59.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 19:59:35 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 0/7] virtio-net RSS/hash report fixes
Date: Tue, 10 Oct 2023 11:59:14 +0900
Message-ID: <20231010025924.14593-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
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

This series contains fixes and improvements for virtio-net RSS and hash
reporting feature.

V1 -> V2:
  Added patch "ebpf: Fix RSS error handling".

Akihiko Odaki (7):
  tap: Fix virtio-net header buffer size
  virtio-net: Copy header only when necessary
  virtio-net: Disable RSS on reset
  virtio-net: Unify the logic to update NIC state for RSS
  virtio-net: Return an error when vhost cannot enable RSS
  virtio-net: Do not clear VIRTIO_NET_F_RSS
  ebpf: Fix RSS error handling

 ebpf/ebpf_rss.h      |   2 +-
 ebpf/ebpf_rss-stub.c |   4 +-
 ebpf/ebpf_rss.c      |  68 ++++-------
 hw/net/virtio-net.c  | 277 ++++++++++++++++++++-----------------------
 net/tap.c            |   4 +-
 tools/ebpf/rss.bpf.c |  20 ++--
 6 files changed, 166 insertions(+), 209 deletions(-)

-- 
2.42.0


