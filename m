Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3191D7EFEB7
	for <lists+qemu-devel@lfdr.de>; Sat, 18 Nov 2023 10:28:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4Hb6-0006Di-4h; Sat, 18 Nov 2023 04:26:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4Hb4-0006DX-Tn
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:26:38 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r4Hb3-0003ig-HJ
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 04:26:38 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6c4cf0aea06so2756730b3a.0
 for <qemu-devel@nongnu.org>; Sat, 18 Nov 2023 01:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1700299595; x=1700904395;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jDHUkFeUiZ95sNfG9WI8P/VDBC1XV4qMk7GmcffU3mw=;
 b=H09KqmrVXlyUrfVcZ05XFqu5lAiEkwvTQHK4DyI16b7AFZJkmFGnmqhN+OqZf1x9Cw
 4NbEdujl07PiKvR5KOL1phBAuKS4g/mtAUg9csR22wI3oAQboOz5R3LCval47M+reA9E
 NsCCXzoVuZkLiZJkhEzz3Gz/1oC0J67qwib9qZ/Fh7T+jfQxFY2jWwDQ+88aDgwIbWEy
 t+tRuCP+mS6PECwLiNWvR9Gj+hcesVUN5KVU/gHqj07sJyDH+uxVq6JZxVKNnox6fEei
 1hPz4nzZHfo5D/Cexa8pDIfGEzO6bta9KTQSFpYPtoh4U+Ht8bGzC1aYU8ROkzu9Fk2o
 dCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700299595; x=1700904395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jDHUkFeUiZ95sNfG9WI8P/VDBC1XV4qMk7GmcffU3mw=;
 b=us/uyerMNlgVoBhKcXu/S+VFizpsnwfI+Ihcjlfs+p0z0QwOlQz5FZAP/D/Qh1Qsaz
 S8TkhRum/6qGJTaQ+GiSA3d3/hZwnwcfCW9Nm8sojDfM/0ob1lvy0/ZtZCasbw0Krza+
 wP4E0In7wkBfQanQ1FQS8Wo2ObFy7zB8bHH+semnO3yDcEhCCoDmM38qRuV/MH82ikWZ
 Tc5emP/iW67up2QTUBr8h5YZs4aZkL2SUR4XFQhv3ZvMoVz63X1NROsbw2e1Bvrcit15
 ZXADnKxK9GsOafb43tUSfiyFRgoXgyGte5VempbXGKWJFdA0ZKmAurgEXgVe/hojuTBf
 suOg==
X-Gm-Message-State: AOJu0YynOEF/ZjayUcgBhyAZrBTMdBwHoqpwjhWKILIyjwB3cehx43B7
 fh5Irvou9CZIyuzYm4RgrFJZ+JJTyCiqqkQNTPo=
X-Google-Smtp-Source: AGHT+IEGYXUch+ckHJLagcaFiOarK2Uu7xlFqNKyIwqAFiFSW4Y3mCSnvCteY5sVWDMmg904mcaRbg==
X-Received: by 2002:a05:6a00:1951:b0:6c2:c8d2:94de with SMTP id
 s17-20020a056a00195100b006c2c8d294demr2659461pfk.3.1700299595586; 
 Sat, 18 Nov 2023 01:26:35 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 y10-20020a62f24a000000b006c69851c7c9sm2607398pfl.181.2023.11.18.01.26.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Nov 2023 01:26:35 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Zhang, Chen" <chen.zhang@intel.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH RESEND v7 06/19] tap: Shrink zeroed virtio-net header
Date: Sat, 18 Nov 2023 18:25:46 +0900
Message-ID: <20231118092601.7132-7-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231118092601.7132-1-akihiko.odaki@daynix.com>
References: <20231118092601.7132-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42d.google.com
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

tap prepends a zeroed virtio-net header when writing a packet to a
tap with virtio-net header enabled but not in use. This only happens
when s->host_vnet_hdr_len == sizeof(struct virtio_net_hdr).

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 net/tap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tap.c b/net/tap.c
index 4d450d2972..7666ada8d9 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -119,7 +119,7 @@ static ssize_t tap_receive_iov(NetClientState *nc, const struct iovec *iov,
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
     const struct iovec *iovp = iov;
     g_autofree struct iovec *iov_copy = NULL;
-    struct virtio_net_hdr_mrg_rxbuf hdr = { };
+    struct virtio_net_hdr hdr = { };
 
     if (s->host_vnet_hdr_len && !s->using_vnet_hdr) {
         iov_copy = g_new(struct iovec, iovcnt + 1);
-- 
2.42.1


