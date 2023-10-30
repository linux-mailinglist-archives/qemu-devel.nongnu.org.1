Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E73C7DB2AD
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 06:16:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxKbg-00024L-Il; Mon, 30 Oct 2023 01:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxKbd-00021x-Ry
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:14:29 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxKbc-0001jO-ED
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:14:29 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-581edcde26cso2586313eaf.1
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 22:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698642867; x=1699247667;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O7MJ4/+I8Igpyaxeivye5QmQBB8JBg1m0RnK9I+H3cM=;
 b=jmWpo9qryPyp8B9uqm7hk2cruK2bQ1aguBLkUTvQtGXG5txFokcufRezU/CmjFvM8L
 MTjU4e+JhOLbToSIC9Y/rRisA4A2PYWkMKZHDBfSo1xPvSAsrYQob/x1lvNzvkJT3NMo
 aToZ71n7StVv56jpwC5uyG3x9nGITK0o4lFyDckx1YlfpFFQDqHFQoxowa8jRlH0iXbn
 UcGiFSgjHlAq/3+aLuLYobr+dVwtxI77akEvrzCvzdOMICzKj6pDy052VQ27r4S4VZmx
 0wI3aXwVnMm5HqLBbr4lcjUGt/q3NihPvPgm4zsj+bpU259liZIh4KXiumVHaGRO46rU
 M/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698642867; x=1699247667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O7MJ4/+I8Igpyaxeivye5QmQBB8JBg1m0RnK9I+H3cM=;
 b=MhWyJ+pBxR6njOcazxcyoCrcqQ7RGunoEdAhjKSEFB7SbvRAb3Z+urFxZbNbRFnzk+
 u7XDzg8GUAxMv7dJs8959TPva0bZEV6RYafsYnCOitxoCTtKBpDoOWh2WCs6vw0bKqtm
 kvEEFd54kODzVjduuoxHAXDARRRwoy/IIlZv+dCUQubGebREpRS94vU0WwN3yRG0oMlA
 wxIGNYR/PFyldsIx4GPAC2qMW8Y3kaG+BZ1d6Jvn73Kc0sNPvbGv3e7q04GRP2r7qgP5
 e1WYSbY1qbTf6Se8yBxlkFnrwRFD1nCcpjgIZ+hPmz/xof6XE/jS4AH8v4qfXSjghZcE
 CskQ==
X-Gm-Message-State: AOJu0YyANAkPeudPPdXtlRvkd2nMsr6q5hIYR03vc5pI82RBxX7W/qPH
 PehO59zqKF17RVkLR+VXpqQ6dWxnQAxi4mVQj495FA==
X-Google-Smtp-Source: AGHT+IGkA38/zvAXXeib39BjrnjqSQtP4viGKZQEPfi/Dn8kweu7EMLnFx8FTTLt75fKCUi7FOKpwQ==
X-Received: by 2002:a05:6870:180d:b0:1e9:c18b:b2da with SMTP id
 t13-20020a056870180d00b001e9c18bb2damr10537381oaf.18.1698642867349; 
 Sun, 29 Oct 2023 22:14:27 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 s194-20020a6377cb000000b0058ac101ad83sm4029481pgc.33.2023.10.29.22.14.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 22:14:27 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v6 05/21] tap: Remove tap_receive()
Date: Mon, 30 Oct 2023 14:12:26 +0900
Message-ID: <20231030051356.33123-6-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231030051356.33123-1-akihiko.odaki@daynix.com>
References: <20231030051356.33123-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c31;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc31.google.com
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

The receive member of NetClientInfo is only for legacy clients and the
receive_iov member is always used when it is set.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 net/tap.c | 36 ------------------------------------
 1 file changed, 36 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index d54e90f184..ab4e5a0e91 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -133,41 +133,6 @@ static ssize_t tap_receive_iov(NetClientState *nc, const struct iovec *iov,
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
-static ssize_t tap_receive(NetClientState *nc, const uint8_t *buf, size_t size)
-{
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
-    struct iovec iov[1];
-
-    if (s->host_vnet_hdr_len && !s->using_vnet_hdr) {
-        return tap_receive_raw(nc, buf, size);
-    }
-
-    iov[0].iov_base = (char *)buf;
-    iov[0].iov_len  = size;
-
-    return tap_write_packet(s, iov, 1);
-}
-
 #ifndef __sun__
 ssize_t tap_read_packet(int tapfd, uint8_t *buf, int maxlen)
 {
@@ -366,7 +331,6 @@ int tap_get_fd(NetClientState *nc)
 static NetClientInfo net_tap_info = {
     .type = NET_CLIENT_DRIVER_TAP,
     .size = sizeof(TAPState),
-    .receive = tap_receive,
     .receive_iov = tap_receive_iov,
     .poll = tap_poll,
     .cleanup = tap_cleanup,
-- 
2.42.0


