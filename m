Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 902E37C811A
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:58:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDtr-0002cJ-PK; Fri, 13 Oct 2023 04:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsl-00078N-7b
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:50:59 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsj-0001cB-MC
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:50:54 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3226cc3e324so1762731f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697187052; x=1697791852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Foy/uNdQWL4WYCF7IJFmQy3PWuFp8tCnIFLxTwC8lyY=;
 b=BsRVNHvh8XstMRuR/TSmVzjeZMERatYUUv8m+5kI7oC0x5/2ybeSSFezrg8yr1PwE6
 JH7Uh3YbebuEGgUsSL1OxzwOh5stP5Vl14FN2J+JgkFR/XDGmTFN5GgFMBOTpJlmx6Ox
 RrWlywd2l2KsryHuyZLNwe99TgvOzStJv9L5vMx5N48GLKcBox9mdioGsFoBPXXp46VP
 WweQ+uhJ+0jNfyz+0vsw81x0rd2BVZ3hExpQ+RQMZEpD9iEfh7jci3k4hzQ6VayldqLc
 TsO5SR+mM8/Z2Ct013t3i9je1PnIFDVW0fdPeuCtDXToalO/ICD9teVMM41UXF7gbVge
 9Q9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697187052; x=1697791852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Foy/uNdQWL4WYCF7IJFmQy3PWuFp8tCnIFLxTwC8lyY=;
 b=sj5yM/aYFm1SixRE9sbm79coLZoSbW82+BVScwfo6htotjLVCgZ42DKo3Q1xcimzsL
 3abs8zvFx61Wfi4g2tE/DIgWPKAlfnBXNDerOF84TPPj+ZMawJxjPxhx+mKptrxJnzvD
 Zy2akuY0Yrrdr1BJULLtOgd7kEv1qEwcZkJy93+E4E41/ucAwOflHrHsZDzgi5CRKvo1
 +ib1lBRtBrmMziYt9a6e24+T0IZmDQHxViGB/QKXnPACYszEdkDD/Xx/1PQOso0l6DWH
 /DL0aCQpPKCJMPSgmKG7quxZWO/UNLOCGZMeEV+Ui6ylrVutMtj9R+YaffQRKKpO7ZUv
 oA0Q==
X-Gm-Message-State: AOJu0YxtNOodUEkg7KcFtyKMep+MW0R8E3i8LwkVvbtsQvwBSmu23J2s
 2U1IOnt0t2nX2uutUVll3IUIBAWMWziQJZy2+ZQ=
X-Google-Smtp-Source: AGHT+IGvtfMop59sgBRAh9vUDr7c5vM/qdgcDN3QL5ftI7LBNmH2pr6ulbGXtCIim6mpWahpSi5cUg==
X-Received: by 2002:a05:6000:104a:b0:32d:8b1a:31ad with SMTP id
 c10-20020a056000104a00b0032d8b1a31admr4506380wrx.24.1697187052016; 
 Fri, 13 Oct 2023 01:50:52 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:50:51 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [RFC PATCH v3 74/78] hw/cxl/cxl-device-utils.c: add fallthrough
 pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:42 +0300
Message-Id: <b8632566adf1970a35dc750f5a00d388b3deb383.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/cxl/cxl-device-utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index bd68328032..63f009847e 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -80,7 +80,7 @@ static void mailbox_mem_writel(uint32_t *reg_state, hwaddr offset,
 {
     switch (offset) {
     case A_CXL_DEV_MAILBOX_CTRL:
-        /* fallthrough */
+        fallthrough;
     case A_CXL_DEV_MAILBOX_CAP:
         /* RO register */
         break;
@@ -102,7 +102,7 @@ static void mailbox_mem_writeq(uint64_t *reg_state, hwaddr offset,
         break;
     case A_CXL_DEV_BG_CMD_STS:
         /* BG not supported */
-        /* fallthrough */
+        fallthrough;
     case A_CXL_DEV_MAILBOX_STS:
         /* Read only register, will get updated by the state machine */
         return;
-- 
2.39.2


