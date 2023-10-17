Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E5F7CB997
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 06:12:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsbPD-0007S8-75; Tue, 17 Oct 2023 00:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsbPA-0007Qw-Op
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 00:10:04 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsbP9-0004Hz-9B
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 00:10:04 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1ca82f015e4so9881805ad.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 21:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697515802; x=1698120602;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hdRn3xY+r+zZRoAOUO1YfZyC5ZVoV18TeJ1QBbbHIlQ=;
 b=i28XWIQf+z6I4ScCDVe26O7x6HK5XCgw4C8IOWybNTXOl0tVWA93HLp2+z6aYU7R7a
 SSoUkhzQrwgQP29qMmcnM7ox737PbBmEVSZsOneIxAzkEnfqGgYPeUTCJcok4m2Rutw4
 ltd+W85a7SSwwWniXt7mqEPZLm6ZxCQL5KkDlEF6Do0vr6VOjKRJAW10xZxjEqYcTX2M
 /B+Y4QvweljxR31wbqQLkIJldfq3wesG77uWZwU7P0HEhdYgiPtmX+J0aAMYsZfUprhd
 Zwdg3fR6nPevAwZAx0+umYZaAuycA1oCjgR3sfLfteDd1joJ9Ttd+D06Ml3so3Ga6zeC
 vyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697515802; x=1698120602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hdRn3xY+r+zZRoAOUO1YfZyC5ZVoV18TeJ1QBbbHIlQ=;
 b=a/GVmiN7L+MkPaz66a3rN5YeH1RsN4kuxtWFy87uPz4rFXC60QBMgQ6FESbbnsSa5y
 hwn5LNatmVYRdEfr64yscGHVrQcPbd5sbSwNZr0dKS9U1cWvL1BTvxQWxHNiel+Yl8Ml
 OqctL+ZZ3mvB092njafwB4Sp5SttnHvFvoJ8m2PHnrnoGoeTbaEfqKJ/TpCgYSalfXzL
 XQQ5eqACzDBb07e40cDiaDhlt3bxOFIIdLfkiE0qFVyVnm5Rf7s9w26GZOGiqlj75s7c
 FyauRfxms9cLe+g/lDPt8YIlN/0niaiFsqcFbRIm+gv0Ew/JbkxQubJhKNSu9IaaE832
 AR8g==
X-Gm-Message-State: AOJu0Yw+fKG6B7id2flynuO8IumDf5nKHxF44fSIGKIL7WCMF0ogUOJc
 +9M5rpILpu0vWzZP+vtuMZ5HlsmxFD15hrRVRDbqDA==
X-Google-Smtp-Source: AGHT+IGhx8I12fCpBMc+MsaqpHuGMSI9ZdFzh/wTeUchqcX4ZFqazM5ixsliRI8qhlgp6KP2zyMw4g==
X-Received: by 2002:a17:902:c943:b0:1c0:d17a:bfef with SMTP id
 i3-20020a170902c94300b001c0d17abfefmr1219387pla.30.1697515801901; 
 Mon, 16 Oct 2023 21:10:01 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 e13-20020a17090301cd00b001c88f77a156sm390862plh.153.2023.10.16.21.10.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 21:10:01 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 07/21] tap: Shrink zeroed virtio-net header
Date: Tue, 17 Oct 2023 13:09:13 +0900
Message-ID: <20231017040932.62997-8-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017040932.62997-1-akihiko.odaki@daynix.com>
References: <20231017040932.62997-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
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

tap prepends a zeroed virtio-net header when writing a packet to a
tap with virtio-net header enabled but not in use. This only happens
when s->host_vnet_hdr_len == sizeof(struct virtio_net_hdr).

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 net/tap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tap.c b/net/tap.c
index 668d69c0de..4c1eb92076 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -118,7 +118,7 @@ static ssize_t tap_receive_iov(NetClientState *nc, const struct iovec *iov,
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
     const struct iovec *iovp = iov;
     struct iovec iov_copy[iovcnt + 1];
-    struct virtio_net_hdr_mrg_rxbuf hdr = { };
+    struct virtio_net_hdr hdr = { };
 
     if (s->host_vnet_hdr_len && !s->using_vnet_hdr) {
         iov_copy[0].iov_base = &hdr;
-- 
2.42.0


