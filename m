Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E68372FF50
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 15:02:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9Q8T-0003L9-TQ; Wed, 14 Jun 2023 09:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q9Q8Q-0003J0-WE; Wed, 14 Jun 2023 09:02:03 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q9Q8O-0007N3-SU; Wed, 14 Jun 2023 09:02:02 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-652d1d3e040so5044156b3a.1; 
 Wed, 14 Jun 2023 06:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686747718; x=1689339718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jSTfupaJmeylraF4oYf/P3ZHmZ381T9yyApmhR97ahI=;
 b=MaiOnbcvF4Ie/6bqjDZ72Q7+QCh1nfJwlMHc4MWYWTJetJ39C/ZIO90r40VyWVzQez
 AnHOollCMaye+QrFu0vt/RMMdZbxcEtW5AdEiEdhFbcZmYfqhyabnQqRD1QLtDAfm1/k
 +KSMEKKfbdP/GMiX5vCPaTH3afG2/Mvh1XJ6pywcDc3NzKFMANadcQrASlmlAfEzuUGc
 VsZZ8Bars8VxoLLjCeCUKrqpjiu2jxnYI8Lt49zAKfhbnx58cFsiffy4CUjNQ5xfcmeZ
 9OFnva4reSv23dkAXzfjKNlCgqLKHUxNz7mftxfl+USg18Lo6mXK6CE4zTpjTPZcq6O4
 YNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686747718; x=1689339718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jSTfupaJmeylraF4oYf/P3ZHmZ381T9yyApmhR97ahI=;
 b=fsyFumHh+jr1OuEbxORSBgjNii184eUtJ2veMKeh6rpfzKR30JtxvspoCeq7pO8ysn
 KLJ/xu5bn0Lg+d4N4JZN78BnNHyL176Hpb9ZCKvIvghWlDTNMT8UGrDwuzWXzJs5Iivv
 LmPtpDReiQkM6NJC2uwaUplL1WGGtnjvfdZ/4sSCOWHh5QyRAGT1U+wRP52RZbBTvbk3
 wLgjMGjXgwOCf2RxjSwHhnD3IpYbGacw5sFhk1kQlb9NFhHl1skn6TWc9BBp/jKgRW+G
 EEvGXlQQbP4fNQGYvp1PJKaE7iyN6524E+w+SgzHhtYDV+t93nJ/uQFv0ST9fYRKvgYn
 h15w==
X-Gm-Message-State: AC+VfDxvE1TYs9MaaXGg3P4+hmqPGjESwHj/Oo/QebCbrCW7sKjFgytx
 wYvhs6IwQEWaAs+IyxNic4Zk/gA+6eFpSw==
X-Google-Smtp-Source: ACHHUZ4/HqycrmXQjI0df/FnmWyfTaDyAGG6MBQ1jAB242e8EJPL7hOYRv1uXaFQL+i0omHulGprHQ==
X-Received: by 2002:a05:6a21:980d:b0:111:366:eea0 with SMTP id
 ue13-20020a056a21980d00b001110366eea0mr1029393pzb.57.1686747717988; 
 Wed, 14 Jun 2023 06:01:57 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 k13-20020a63ff0d000000b0053f2037d639sm878173pgi.81.2023.06.14.06.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jun 2023 06:01:57 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, yin31149@gmail.com,
 18801353760@163.com
Subject: [PATCH RFC 1/1] vdpa: Return -EINVAL if device's ack is VIRTIO_NET_ERR
Date: Wed, 14 Jun 2023 21:01:47 +0800
Message-Id: <07a1133d6c989394b342e35d8202257771e76769.1686746406.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1686746406.git.yin31149@gmail.com>
References: <cover.1686746406.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=yin31149@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

According to VirtIO standard, "The class, command and
command-specific-data are set by the driver,
and the device sets the ack byte.
There is little it can do except issue a diagnostic
if ack is not VIRTIO_NET_OK."

Therefore, QEMU should stop sending the queued SVQ commands and
cancel the device startup if the device's ack is not VIRTIO_NET_OK.

Yet the problem is that, vhost_vdpa_net_load_x() returns 1 based on
`*s->status != VIRTIO_NET_OK` when the device's ack is VIRTIO_NET_ERR.
As a result, net->nc->info->load() also returns 1, this makes
vhost_net_start_one() incorrectly assume the device state is
successfully loaded by vhost_vdpa_net_load() and return 0, instead of
goto `fail` label to cancel the device startup, as vhost_net_start_one()
only cancels the device startup when net->nc->info->load() returns a
negative value.

This patch fixes this problem by returning -EINVAL when the device's
ack is not VIRTIO_NET_OK.

Fixes: f73c0c43ac ("vdpa: extract vhost_vdpa_net_load_mac from vhost_vdpa_net_load")
Fixes: f64c7cda69 ("vdpa: Add vhost_vdpa_net_load_mq")
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 net/vhost-vdpa.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 37cdc84562..630c9bf71e 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -651,8 +651,9 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n)
         if (unlikely(dev_written < 0)) {
             return dev_written;
         }
-
-        return *s->status != VIRTIO_NET_OK;
+        if (*s->status != VIRTIO_NET_OK) {
+            return -EINVAL;
+        }
     }
 
     return 0;
@@ -676,8 +677,11 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
     if (unlikely(dev_written < 0)) {
         return dev_written;
     }
+    if (*s->status != VIRTIO_NET_OK) {
+        return -EINVAL;
+    }
 
-    return *s->status != VIRTIO_NET_OK;
+    return 0;
 }
 
 static int vhost_vdpa_net_load(NetClientState *nc)
-- 
2.25.1


