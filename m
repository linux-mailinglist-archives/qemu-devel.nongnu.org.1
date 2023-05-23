Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE31270D1A6
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:48:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I21-0006SC-I1; Mon, 22 May 2023 22:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I1r-0006Be-3O
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:45:40 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I1o-0004bY-Dz
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:45:38 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1ae4d1d35e6so48988385ad.0
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809935; x=1687401935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LGnQE1ZhusP6AKK5Ux8Vrjgs1RYienY0y7ga8BQlUi8=;
 b=t6wjEouC92UaRWuO0nmyN0zXZik7MYpJgqtQJ9zUJDLqss5rrkV6/EUPzPZFXh/ys7
 VhqXAJYBFGnJ/HcCYKcY9meGpgxlazCxmb8naiNUlaU6BlCt0xy3Qvgs0XrC/rNBhZUc
 TObcFgDEAcQ6c0w7/cCXfhhu6M0ZfcmFyd9d9s0hlek4Q41ljN/ZrLIWiirQxN9gFuSZ
 txQzkTBHfKN52HO/WXyQVxCVoX25lResN5gq2QUsucELMX0hHU9UT+epkBelUhjRW7Oa
 4WwVQpX6zFx4BPEOKq4kKoALOAtFrF4J4gbTL9Y3O5DpWkygLR4aIuguYleRYJueEoCH
 KeQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809935; x=1687401935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LGnQE1ZhusP6AKK5Ux8Vrjgs1RYienY0y7ga8BQlUi8=;
 b=eHBGAl6rulgxwDiyM8O8cpzXNriI7h3BsW72MUUXd1eirGBb+R9qRnL76/rWmITMqU
 s/agrQgMphukNv+1g4qa7hTSNKDtgch/2/cXVb0RkSrJqTCcPNXmHNILxseaySOrMPei
 /uD/ZqSe0pLnbMtEiZPIpZWZwaijMLg+yT+0QS6YXvXvp3BNeUUlhMYWsWBEkb1/SqSg
 ZOtIE2QIEGfadHMAJVYu0lrApVD7mx6kehIQTZ4N6wB7kUr8VuMV3XM4H2Isarr5VrZv
 YQl2CZjzH/pAfuzjT2w/IoUTvSFq4Jzfke7wbBglALNde384F7+jyFayrrx+p8sbqGe8
 jLqQ==
X-Gm-Message-State: AC+VfDyEJnb9mJwFlJu2aBXVieu9PCorFHcHuhp5jbRqNCC0uyUdIH1J
 en82+V7+RZ0qFnwdwHNuoDX+Sg==
X-Google-Smtp-Source: ACHHUZ5gn4FWkgz/XDoJWaywmuU857I0vb8BGNrosX19KFf/YaBlhrEvOZBYJ34P9S3BZU4b8097DQ==
X-Received: by 2002:a17:903:11c9:b0:1ac:63ac:10a7 with SMTP id
 q9-20020a17090311c900b001ac63ac10a7mr14749152plh.68.1684809935107; 
 Mon, 22 May 2023 19:45:35 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.45.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:45:34 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Tomasz Dzieciol <t.dzieciol@partner.samsung.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 30/48] net/eth: Use void pointers
Date: Tue, 23 May 2023 11:43:21 +0900
Message-Id: <20230523024339.50875-31-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
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

The uses of uint8_t pointers were misleading as they are never accessed
as an array of octets and it even require more strict alignment to
access as struct eth_header.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/net/eth.h | 4 ++--
 net/eth.c         | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/eth.h b/include/net/eth.h
index 05f56931e7..95ff24d6b8 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -342,12 +342,12 @@ eth_get_pkt_tci(const void *p)
 
 size_t
 eth_strip_vlan(const struct iovec *iov, int iovcnt, size_t iovoff,
-               uint8_t *new_ehdr_buf,
+               void *new_ehdr_buf,
                uint16_t *payload_offset, uint16_t *tci);
 
 size_t
 eth_strip_vlan_ex(const struct iovec *iov, int iovcnt, size_t iovoff,
-                  uint16_t vet, uint8_t *new_ehdr_buf,
+                  uint16_t vet, void *new_ehdr_buf,
                   uint16_t *payload_offset, uint16_t *tci);
 
 uint16_t
diff --git a/net/eth.c b/net/eth.c
index b6ff89c460..f7ffbda600 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -226,11 +226,11 @@ void eth_get_protocols(const struct iovec *iov, size_t iovcnt, size_t iovoff,
 
 size_t
 eth_strip_vlan(const struct iovec *iov, int iovcnt, size_t iovoff,
-               uint8_t *new_ehdr_buf,
+               void *new_ehdr_buf,
                uint16_t *payload_offset, uint16_t *tci)
 {
     struct vlan_header vlan_hdr;
-    struct eth_header *new_ehdr = (struct eth_header *) new_ehdr_buf;
+    struct eth_header *new_ehdr = new_ehdr_buf;
 
     size_t copied = iov_to_buf(iov, iovcnt, iovoff,
                                new_ehdr, sizeof(*new_ehdr));
@@ -276,7 +276,7 @@ eth_strip_vlan(const struct iovec *iov, int iovcnt, size_t iovoff,
 
 size_t
 eth_strip_vlan_ex(const struct iovec *iov, int iovcnt, size_t iovoff,
-                  uint16_t vet, uint8_t *new_ehdr_buf,
+                  uint16_t vet, void *new_ehdr_buf,
                   uint16_t *payload_offset, uint16_t *tci)
 {
     struct vlan_header vlan_hdr;
-- 
2.40.1


