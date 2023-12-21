Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8487581AD34
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:20:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9ap-0005Pi-D0; Wed, 20 Dec 2023 22:19:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9an-0005EN-5H
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:19:25 -0500
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9al-00045q-JW
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:19:24 -0500
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-42588e94019so10924011cf.0
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703128762; x=1703733562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OiP1/Ua4j4jM2DfSNRL0DQxjZJY9wQwNeyA3e93brtI=;
 b=XIURY6zoVNEf8jF5aroY2OalLWQeg1q0wzMeeV+VzcaLOEzoxcbhgft+Mxgfe32Vc7
 uuPUc2bs2YfpJob9rZxAJJPpHDx2m2IvaflzKoG6RlUA71K32571FlMOWr5ObQNB0EmH
 29wqhpPg8q1GhCysLic4pTPlqwt98zJK4z3FDiuvtu2+p2ljHMvU38tI45kL1JRms02M
 hji7RezLBK5wPoM39E3rN+5wn3R3ya6sXO57wx51NMpfnUPPNbiEa74owZ2M7R6LHdPx
 H9355WJPJnpkYqTFMlB4BwXz1UK1gDEROSnA/BAar6OByB3eOUtwk0xPNvQ15FSIghEp
 WNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703128762; x=1703733562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OiP1/Ua4j4jM2DfSNRL0DQxjZJY9wQwNeyA3e93brtI=;
 b=mFpaNd7ItcaItQTg6wdDvbeRvGv4xvk1EpOSW+qIn8AUTGC4XWxYCfXA+kW3deBt63
 sbKX5pnb2un6L+7vkTbmPAxM2jFrY1X2XHvU85q56WYT7MYiGfw78qCEolkoGjNiwiad
 hvOoSnYH4fY5JTpr/Wf2rtNgyRwrUAOg129r5QqL6Mgv3WGtuEU8vLHKuDIHuVg9ehAM
 tvhJ6/R0RGNUjeqjshWE8G5tAkIiDA4ew93tyo2bOkIZeirCk+nAZ6/gcAVzYKqzcWI0
 JeuAYKAKPElTyO7NE3qHHF6Jn6zB+pyEB317smlkDb0va6JcG6doTKwarCHLCJkP8uBh
 FI8Q==
X-Gm-Message-State: AOJu0YyLwKS0cckJ4YiNiOZdfZK059s795Cqt9mKF1r7WtLowVT2S0ba
 TTxRj9U/Fe9x1bx3Qi9Ozs7HP/m7Ca6HybCMHTlwGoHDKLI5/jcG
X-Google-Smtp-Source: AGHT+IFZqh4ihZuRF81QNUCouQJ7PS8G2Pi3TzwyXThN4fKJbHAZhQtkL5kzfU1ucwkZtMMwVqKtcA==
X-Received: by 2002:a05:622a:54a:b0:427:9c78:a2bd with SMTP id
 m10-20020a05622a054a00b004279c78a2bdmr43449qtx.22.1703128762632; 
 Wed, 20 Dec 2023 19:19:22 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 n8-20020a05620a294800b0078116d55191sm360808qkp.130.2023.12.20.19.19.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:19:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 35/71] hw/ipack: Constify VMState
Date: Thu, 21 Dec 2023 14:16:16 +1100
Message-Id: <20231221031652.119827-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/ipack/ipack.c   | 2 +-
 hw/ipack/tpci200.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ipack/ipack.c b/hw/ipack/ipack.c
index ae20f36da6..c39dbb481f 100644
--- a/hw/ipack/ipack.c
+++ b/hw/ipack/ipack.c
@@ -93,7 +93,7 @@ const VMStateDescription vmstate_ipack_device = {
     .name = "ipack_device",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(slot, IPackDevice),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/ipack/tpci200.c b/hw/ipack/tpci200.c
index 6b3edbf017..88eef4b830 100644
--- a/hw/ipack/tpci200.c
+++ b/hw/ipack/tpci200.c
@@ -619,7 +619,7 @@ static const VMStateDescription vmstate_tpci200 = {
     .name = "tpci200",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, TPCI200State),
         VMSTATE_BOOL_ARRAY(big_endian, TPCI200State, 3),
         VMSTATE_UINT8_ARRAY(ctrl, TPCI200State, N_MODULES),
-- 
2.34.1


