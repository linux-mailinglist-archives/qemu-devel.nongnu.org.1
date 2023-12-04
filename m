Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C088039C6
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 17:10:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rABV3-0006j1-NC; Mon, 04 Dec 2023 11:08:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rABV1-0006iG-Mn
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:08:47 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rABV0-0005HN-6C
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:08:47 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6ce5513b727so596816b3a.3
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 08:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1701706004; x=1702310804;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/KbFsOHJJ/ll0h14k1paX0fqVNBTjtrk/tR4NFD8wo4=;
 b=MMzKAm7In7wndw3JZN0IEkItsPZCjZwO7ZhRzI+x4NE/RiF1kKgQ38+bcJs1ADZcyR
 Xkg3yoZa8lB4BhOu0bJgyzmcx1STx+LX3ZPdE5/SuT+cNsGJl1770CcHys8onOnbOL8/
 9KgOEf3t1A1NKfgHcjVreZ+4tJc4wxpwIS2rT5SYBRkx0WTbC/AYchm0LLOGjq4uAVnI
 8fqbjbtZr3LsEw7+T2fD5Uy6ruy+VgFvHBmAFEtBjJYIyvcQDYSnaOpLzT1P+tHJuPnf
 E+G3LpY2BoJbcbZphrvz/ut5M4DOarDyV5qCzTl1gf4NmTq4C/ewumywFPyWeHNSNFim
 CTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701706004; x=1702310804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/KbFsOHJJ/ll0h14k1paX0fqVNBTjtrk/tR4NFD8wo4=;
 b=PAmQ48jjXrXNwJfITOvXnw9dxRN1Kga9s6ESrwfCCotYhBG6YlA3SRbKFDFsmo2zB8
 BjepwLoOgLRFzvYQ88veJXCEvBft3L0DG25yFOc8oDie3pVN9c1scfeJg9XbZz1XAqml
 u4415VRwvgjTiNKF+Qx1/r12biKD7pvtjDwtx0gIzqueHb8oZaOS+8W47loY2nW+ZxGV
 y6M+mNkKVAuvtcYuNIxzvGqnHIcgZbp+JgIp2QnPmKXq2EA+VpN0z4KEgG20XkxTvabo
 lezyg+URxv3NbDvz5A5u10W9IbZCPeiUg8qEHJDY3uv7x0BSeOH5MBXlh+yVlufLktuE
 sAIQ==
X-Gm-Message-State: AOJu0YxT4ifz8we+FC1fUpZopAPWsWTZYC8jhBjdK/tCUwBVLGxEBLSZ
 fkfpJWQttTn15qUQTDyR/roz+2Z4XtvyOxcbPZwW1ku+
X-Google-Smtp-Source: AGHT+IEtft1044g7h5cv0B0ZarKnvXJOUbattWjsKGoqb50fFxNA9SWjd8lXLKgtmhMojJgjrCicIw==
X-Received: by 2002:a05:6a20:7d90:b0:18c:159b:7f9 with SMTP id
 v16-20020a056a207d9000b0018c159b07f9mr2234263pzj.9.1701706004119; 
 Mon, 04 Dec 2023 08:06:44 -0800 (PST)
Received: from localhost.localdomain ([125.71.95.66])
 by smtp.gmail.com with ESMTPSA id
 m17-20020aa78a11000000b006be4bb0d2dcsm7993064pfa.149.2023.12.04.08.06.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 08:06:43 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 yong.huang@smartx.com
Subject: [RFC 2/8] crypto: Introduce payload offset set function
Date: Tue,  5 Dec 2023 00:06:19 +0800
Message-Id: <1741fb5af5602d351d385cbd15394afc154cbc84.1701705003.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1701705003.git.yong.huang@smartx.com>
References: <cover.1701705003.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42c;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x42c.google.com
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

Implement the payload offset set function for Gluks.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 crypto/block.c         | 4 ++++
 include/crypto/block.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/crypto/block.c b/crypto/block.c
index 7bb4b74a37..3dcf22a69f 100644
--- a/crypto/block.c
+++ b/crypto/block.c
@@ -319,6 +319,10 @@ QCryptoHashAlgorithm qcrypto_block_get_kdf_hash(QCryptoBlock *block)
     return block->kdfhash;
 }
 
+void qcrypto_block_set_payload_offset(QCryptoBlock *block, uint64_t offset)
+{
+    block->payload_offset = offset;
+}
 
 uint64_t qcrypto_block_get_payload_offset(QCryptoBlock *block)
 {
diff --git a/include/crypto/block.h b/include/crypto/block.h
index 4f63a37872..b47a90c529 100644
--- a/include/crypto/block.h
+++ b/include/crypto/block.h
@@ -312,4 +312,5 @@ void qcrypto_block_free(QCryptoBlock *block);
 
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(QCryptoBlock, qcrypto_block_free)
 
+void qcrypto_block_set_payload_offset(QCryptoBlock *block, uint64_t offset);
 #endif /* QCRYPTO_BLOCK_H */
-- 
2.39.1


