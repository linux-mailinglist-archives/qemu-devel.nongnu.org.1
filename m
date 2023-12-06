Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 390C080755C
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 17:40:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAuwS-0006zm-IC; Wed, 06 Dec 2023 11:40:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rAuwP-0006zV-Ps
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 11:40:05 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rAuwO-0003mm-A9
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 11:40:05 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d045097b4cso35026425ad.0
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 08:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1701880683; x=1702485483;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ME+BuRtXMyZoePaH7F1ht47MskX6EGo+OV1KpUXdVVY=;
 b=QEYTVyI9SRJ8Dw0YchCHVYykXFKyDWrnw3DgBOEmY4ypkfPPgbw0U/E2MT4OW5XcxY
 TsDWx+XNAHHBIeOBIXpkMYY9k1xGkYym9Vs1qA1tw4vdSmwf3QjIiOTZrRj0uvXmULue
 8z/or7DS8TMOXKy7VO+SAHTvkyWjKSdrs342zhUFINWqTJlcOiuA8QtSkl0q6YLr1l+4
 ofXo7nWOQcJSCExCaswAFr6VWxUbHZL+TJa9Q2jT+ObpwNNiIFVakATiq+GMY8cMR2oR
 xyPvaVdAKU/zZ8YWGn5PexBH/nc2jmFumej3RHLFcgigbn952lo7YDmpr+mChubC4ct7
 szAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701880683; x=1702485483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ME+BuRtXMyZoePaH7F1ht47MskX6EGo+OV1KpUXdVVY=;
 b=MIv03xx2OAY8933HIGeA8EA+TLZE5FWCUVdUa+tpimsjyQzRueeU/LcGZyThbQtnzs
 H+KMHiZtG3R7ihoF9aCFoxe+DI3A2U7JB2T01SsA6kczBPdT4yGJqZs8VuZc+le9ePmt
 z5ryMiDLKrNBUnPqBCHK47TpXSC/fw1W8Y9hb8ukyFKUvjjYA0kjQ3jYVuheJze/JvVo
 rWu0JLzdz+6SHPiyAId6FB+G8Wr554T1CBMOL/csMcdG2kMKH5J9tXdr8tEobIz2awdW
 trrgNu0oZkb37iLJUePaFoml/eSvZsMlHSRUf4FYLnZmcVr98oNoPK0GULpoPutqi66L
 ZmoA==
X-Gm-Message-State: AOJu0Yyslckvlm+6I6rsJpWuPKJKchvWFj+ilHXRTSzIu7yOhegR/Y30
 WxhYf217hIZmi9/zu5vBwkpJO+w8bMF3QzFw42ra1pqj
X-Google-Smtp-Source: AGHT+IHMpFR9P/twlo67hGfP/nzWKiLqHvGB1PLDWY/gq6iJIgB0srQIvgOsGN5xpRMDIZ99zeDl6w==
X-Received: by 2002:a17:902:7604:b0:1cf:747e:89c6 with SMTP id
 k4-20020a170902760400b001cf747e89c6mr885872pll.26.1701880682367; 
 Wed, 06 Dec 2023 08:38:02 -0800 (PST)
Received: from localhost.localdomain ([125.71.95.66])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a170902bb8e00b001d04d730687sm42570pls.103.2023.12.06.08.37.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Dec 2023 08:38:02 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 yong.huang@smartx.com
Subject: [v2 2/4] crypto: Introduce payload offset set function
Date: Thu,  7 Dec 2023 00:37:43 +0800
Message-Id: <7130b0b19c38bc4e92071198af54a56f8ba3597c.1701879996.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1701879996.git.yong.huang@smartx.com>
References: <cover.1701879996.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x62c.google.com
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


