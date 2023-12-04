Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 345048039C4
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 17:10:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rABVL-0006sq-Sf; Mon, 04 Dec 2023 11:09:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rABVK-0006sX-F6
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:09:06 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rABVH-0005Ij-S6
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:09:06 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6cb74a527ceso3263592b3a.2
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 08:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1701706022; x=1702310822;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dBpAjTXt7ctAaHcqbiNioxefPHK0eHAWmtGb+772ldc=;
 b=cwDshzxW/ZakmLRNGti5JYkx5n/VKc92H1PT6wmX77iLynEIgyxmIT5Pb+Cxw86jDW
 a89+hqbB2qYPJ+lZgsCDluXqW4goe+Q1HBbGaeICEDEXmEQgqzsx1p0i6Lf4r8BBZ+xz
 gzOSQGuqG8XcPwHa4g+uxUa/BYga4mnhIsFBt28wW01CjS5CQBGiGBwOe1uBgTQ3JNsf
 XI+n+FeqCLbK+Bqtp+BXd9SCQan9HQaBtww85F34SK3CV3vfwIXJ3yeZeCQA8qXfebGy
 SpOTPY6mxdeSfIHWtqtJWBE65av42PHqJq3fDDuQuD21tGrhhvFu4O9REsrOgxgSCpVK
 vHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701706022; x=1702310822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dBpAjTXt7ctAaHcqbiNioxefPHK0eHAWmtGb+772ldc=;
 b=lYimtJAv90sZou0jtY18qcyA76q59pWD2rAWWVjYbBNARKkAGbo2hRnybEOeSJsaZr
 B0PACK44bBg8J2RFRQT21wyoHPyeLXnF3zagucneVO1H35/enTx9uXFst1YXJVq6bty6
 1eYS62zeqfKA/v7ABlu3DD8bB9vqLL3Wi6tnTZ5xfPB/EUBiXjNdW3jShZohh8Gsas66
 JMZkBdQA3cfMSG/Xex1Iy4iFYAS+wpW7l2Uy7ePOeUvaF2ZvELYQolBGC+ZTweEJdkZV
 J/kcbiirvhyGDwon9YG6JUAmZO1nJiT76sSA0xIYaNZBSj6M/KnSupcupZIhqPiYvMql
 NMBg==
X-Gm-Message-State: AOJu0YxCaHxSPeXGZiMbW6B7vSMogyRqsC8Cyy64VjZZxQQgGQi2z4QX
 6MIzOh2rHAZ0FSAZiIcF6onXORn+hCD7UjeL7FulLuCq
X-Google-Smtp-Source: AGHT+IF/iF39mUbJyVW230AwrwMvDurk5qEhqfiEn6sYlLr8Gfn5PjzFt90U7IRxokhohLAZTq1koQ==
X-Received: by 2002:aa7:8893:0:b0:6ce:7d6:c317 with SMTP id
 z19-20020aa78893000000b006ce07d6c317mr4757527pfe.15.1701706021959; 
 Mon, 04 Dec 2023 08:07:01 -0800 (PST)
Received: from localhost.localdomain ([125.71.95.66])
 by smtp.gmail.com with ESMTPSA id
 m17-20020aa78a11000000b006be4bb0d2dcsm7993064pfa.149.2023.12.04.08.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 08:07:01 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 yong.huang@smartx.com
Subject: [RFC 6/8] crypto: Provide the Luks crypto driver to Gluks
Date: Tue,  5 Dec 2023 00:06:23 +0800
Message-Id: <4ff114944abe5e1d90933e715ee245cea5d619fd.1701705003.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1701705003.git.yong.huang@smartx.com>
References: <cover.1701705003.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42d;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x42d.google.com
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

Hooks up the Luks crypto driver for Gluks.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 crypto/block.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/block.c b/crypto/block.c
index 3dcf22a69f..7e695c0a04 100644
--- a/crypto/block.c
+++ b/crypto/block.c
@@ -27,6 +27,7 @@
 static const QCryptoBlockDriver *qcrypto_block_drivers[] = {
     [Q_CRYPTO_BLOCK_FORMAT_QCOW] = &qcrypto_block_driver_qcow,
     [Q_CRYPTO_BLOCK_FORMAT_LUKS] = &qcrypto_block_driver_luks,
+    [Q_CRYPTO_BLOCK_FORMAT_GLUKS] = &qcrypto_block_driver_luks,
 };
 
 
-- 
2.39.1


