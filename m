Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0107C994A
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 16:04:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs1iS-0001Rx-VM; Sun, 15 Oct 2023 10:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs1iQ-0001RL-No
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:03:34 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs1iP-0007kT-Az
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:03:34 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-57b8cebf57dso1973782eaf.0
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 07:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697378612; x=1697983412;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hdRn3xY+r+zZRoAOUO1YfZyC5ZVoV18TeJ1QBbbHIlQ=;
 b=uy3JE+Alu+/Lnx86CTO/o2EWQeeCYpMYwMpKRq2mpQegZqdigqhE0VzZ24GdcRHxC8
 jCixxU7llg/Wachu6D6rumZpyIy04Hcjt6jGTtJv/7l29VLmu8hnFOOlJ5lHJJER2Gaz
 4lKyCvLPoQelRyqnjkgVeBn0HbfTJ4VulwtkC/gPzfX6ILEJFs3c5Db87CX/EKF0UBNg
 lkL9gLqYBGtwG1Ea9o+8BGqveTkF0n5TQsdKmwFPGQE7Z27kpfuXLQdbe+2ivqB1OGfO
 Hww23epMyKyghnNF+YQNme5z3PTgjJiylFTZ2syl+2aPHv+9IA/PDeyCRO+5d3Em7Gjc
 l+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697378612; x=1697983412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hdRn3xY+r+zZRoAOUO1YfZyC5ZVoV18TeJ1QBbbHIlQ=;
 b=JHR+6HlRmUE3LJANLRCMvnSpTJw8G1wXmBulUgbOPKouUWYn6YMluQwD212VLXlP6W
 PTNQ4AmPnGnW+JrYOlFl/LrvkSGAJO7+b2IPxAbTF9rDw7W/YqVFOr0pT0kQYzTwMt5y
 BcT+ArZRN0JfPmNCFlcLB/uwXjFb5aVNFzc4KJPH47dyvZGpppRT/6DkAZVYAI7U1Epk
 mOqJjBexMMw0d/U/r1j2bvLmzD1rvypvDkHRHEQ1vPd8ac3SVSpz5zgAsyfGCdRGpkES
 63PfYKR+QyTnz7Ugbq/HXbf/4OAFCm7aeSVdEvXqJEIQpK14+jasr+f5Ee9Gnx83TduW
 wckQ==
X-Gm-Message-State: AOJu0YwDXpdrtcf4XnpAJmDiIzDXyQlqmcTJKjlOXOcjCuo3KwhaWxUg
 r+ntjSasJKh5/3zkcYZF8zlOCVI2SGnq+MadXaK93Q==
X-Google-Smtp-Source: AGHT+IEKYAyYuFMC6/Ir2UJ4kE1LWPm/EqfAwxvdRlP76WZg4D/GXHZkzpnJs6fJsjMpbNG6Z9zxKQ==
X-Received: by 2002:a05:6358:590a:b0:14c:92ea:b4ff with SMTP id
 g10-20020a056358590a00b0014c92eab4ffmr35963426rwf.6.1697378612265; 
 Sun, 15 Oct 2023 07:03:32 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 f15-20020aa782cf000000b0069102aa1918sm16416405pfn.48.2023.10.15.07.03.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 07:03:31 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 07/20] tap: Shrink zeroed virtio-net header
Date: Sun, 15 Oct 2023 23:02:39 +0900
Message-ID: <20231015140259.259434-8-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015140259.259434-1-akihiko.odaki@daynix.com>
References: <20231015140259.259434-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c29;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc29.google.com
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


