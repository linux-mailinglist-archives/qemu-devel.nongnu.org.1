Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F267EFEC2
	for <lists+qemu-devel@lfdr.de>; Sat, 18 Nov 2023 10:30:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4Hb2-0006DR-HZ; Sat, 18 Nov 2023 04:26:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4Hb0-0006D4-BQ
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:26:34 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4Hay-0003iT-Uf
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:26:34 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5b8f68ba4e5so2048056a12.1
 for <qemu-devel@nongnu.org>; Sat, 18 Nov 2023 01:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700299591; x=1700904391;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xzliMeH7ucLi+5KlHbqTM6VmGafQ4Ql4J7jH/gf4kF0=;
 b=jxvYL/GrKparnqkeTszKyZLm0oitUDwJAFazCO/Jk7QqbmB28szutcnb2jrocxVVWA
 +DNWNqQg4vwEBfnw+zqoSCImZotjZ5+zSitkjHmo7vFtxvOk9iqxL7HV37aXPTqkmkyk
 UiGdTy1RQZGs5g5WlqX3qjtnMF5qH6SuSMQz7RvzdsYlaFDS6CXAh7a33o/9l7ViKheA
 17RO+WKo3tF5dPasIfzjspFi3HRVPSywZ9n50htk07IjofLZ1g6U4XzGKD1aodliKJbf
 6re1jPUt+tME6B1J1FZOwdmbyXrB9+nhLcyMxlJQQ8EoQBmuOeFc8pBi6jmLJgGp2iRw
 isFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700299591; x=1700904391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xzliMeH7ucLi+5KlHbqTM6VmGafQ4Ql4J7jH/gf4kF0=;
 b=Sd75xzxlXPP30tvpxjHRZ/onq+pKK//mY45Ju8smJS9sePS25ggv4dGBLfBKob3m5q
 YcAhuaN7hMeEsVaNwguhdq4kcq/K2CebtpTlbqIjPWh6+V6uUxKAac+V3y5f+OZjhJ+h
 Of8vtGloxs8wlnChW+rel+/revuu4jbKInx7Pnimtyq6IlTFpjAV0mSu2XkwfP5L8sei
 dNUvF+YmKfhDFOZqM0nDa9DnMZDY0Po0drhgfFdXTuyQB/T8M4w9Cu49BPnULvQW+sGv
 2w5C7nu04l9G4Iq7k7Vfaky53mZ0P3jZlxFIR6M34593ux5ZrzFf21TRiL+RGmmMsjYn
 5ffg==
X-Gm-Message-State: AOJu0YxzZFuXEiyFVXup9jWXBDqx/tPha6abRWlmRfqGKjCyrzkHKeO9
 +rHGEiCwku+pYbdgG+3d/XSEW0asMVYhnUXfBbk=
X-Google-Smtp-Source: AGHT+IH3RcI//cpbXHlTwdcpLFs3V+n9uQ1Tb1qIUPDPUO4LwCzhasoVuPFWHURMXoX7jIGlLP/zBg==
X-Received: by 2002:a17:903:22cb:b0:1cc:e76e:f216 with SMTP id
 y11-20020a17090322cb00b001cce76ef216mr2305074plg.24.1700299591488; 
 Sat, 18 Nov 2023 01:26:31 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 p4-20020a170902bd0400b001b850c9d7b3sm2616635pls.249.2023.11.18.01.26.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Nov 2023 01:26:30 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Zhang, Chen" <chen.zhang@intel.com>, Akihiko Odaki <aodaki@redhat.com>
Subject: [PATCH RESEND v7 05/19] tap: Call tap_receive_iov() from tap_receive()
Date: Sat, 18 Nov 2023 18:25:45 +0900
Message-ID: <20231118092601.7132-6-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231118092601.7132-1-akihiko.odaki@daynix.com>
References: <20231118092601.7132-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52c.google.com
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

From: Akihiko Odaki <aodaki@redhat.com>

This will save duplicate logic found in both of tap_receive_iov() and
tap_receive().

Suggested-by: "Zhang, Chen" <chen.zhang@intel.com>
Signed-off-by: Akihiko Odaki <aodaki@redhat.com>
---
 net/tap.c | 35 +++++------------------------------
 1 file changed, 5 insertions(+), 30 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 09ad8ae255..4d450d2972 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -133,39 +133,14 @@ static ssize_t tap_receive_iov(NetClientState *nc, const struct iovec *iov,
     return tap_write_packet(s, iovp, iovcnt);
 }
 
-static ssize_t tap_receive_raw(NetClientState *nc, const uint8_t *buf, size_t size)
-{
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
-    struct iovec iov[2];
-    int iovcnt = 0;
-    struct virtio_net_hdr_mrg_rxbuf hdr = { };
-
-    if (s->host_vnet_hdr_len) {
-        iov[iovcnt].iov_base = &hdr;
-        iov[iovcnt].iov_len  = s->host_vnet_hdr_len;
-        iovcnt++;
-    }
-
-    iov[iovcnt].iov_base = (char *)buf;
-    iov[iovcnt].iov_len  = size;
-    iovcnt++;
-
-    return tap_write_packet(s, iov, iovcnt);
-}
-
 static ssize_t tap_receive(NetClientState *nc, const uint8_t *buf, size_t size)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
-    struct iovec iov[1];
-
-    if (s->host_vnet_hdr_len && !s->using_vnet_hdr) {
-        return tap_receive_raw(nc, buf, size);
-    }
-
-    iov[0].iov_base = (char *)buf;
-    iov[0].iov_len  = size;
+    struct iovec iov = {
+        .iov_base = (void *)buf,
+        .iov_len = size
+    };
 
-    return tap_write_packet(s, iov, 1);
+    return tap_receive_iov(nc, &iov, 1);
 }
 
 #ifndef __sun__
-- 
2.42.1


