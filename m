Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E597E1AD1
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:12:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzta7-0005QL-TF; Mon, 06 Nov 2023 01:59:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZf-0004ed-PX
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:59:08 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZd-0001SK-L2
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:59:03 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1cc3bc5df96so27810025ad.2
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 22:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699253940; x=1699858740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OiP1/Ua4j4jM2DfSNRL0DQxjZJY9wQwNeyA3e93brtI=;
 b=gzmAevuzOlBaeU6GkmN3l1nbXRDPncIsfbgylV1WdRg7J0ao2FP24jeZDn63t9BiE+
 5Z/hda9XIJKCyAw5OgK1KrXspEpeprfqxn7za0jE5UwNL30EikVpitV/Av7CaQ7cjTa5
 6KfOtd+sUgCtZl5mw3HvfIgWvGY3lzmAe0Z9D6dE6qmFtuufPqvr4PtTxzPslsUtSNe9
 0dFYfr5D3Htp2aYwcn/gz+yYArOrl6xcqTxOLkcLvC2kfEOkdWK9Izd5d3h1ssjioYhw
 DF376+WHUFbBpiMOWd56tfXZv67DcPBtJO82mlId4qV+fOWT3ijPbiNlC7ajX9SkaRAZ
 EvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699253940; x=1699858740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OiP1/Ua4j4jM2DfSNRL0DQxjZJY9wQwNeyA3e93brtI=;
 b=GO2WwnzVoHbFjO20KdOfSlWtjZf2H2l/x9nsJNFuxHKajBDOFAp8YPTxRh6jzrdT++
 GaS5GcEJ+Rn1EzIYLpTSOAAAjbl7GTvf6sEmiUv5cRzlr+2FACyAHeTUD25bXcTshapH
 ad6aBHFxjaOs9inljUV6/RXyR95M9LqyoQbTkBoawGYpHlOva/GGjx75tvNTFtZRCAwh
 uduGmGNI/JVAPIsbM3b71ZC8JvcsEXXvovSOCYAGnqDr5Y7jv0OtdD/hKrx0w5f8zb2x
 3wmDFhdjFqw+oE0Kps2h3b3HwJ7wmrbHwH0rGfvHMRr2Gsusvp/L/AxyFo7wcSHa2Zx7
 mzpg==
X-Gm-Message-State: AOJu0Yx6dzJkHTt3QWGIVfmSJE1538qsNII2ki8jxHDifBhxKoTIt3lk
 XD/rK2FDqkvXS4TbQ6zAtUaNKd3ZkYMPY6iGQCg=
X-Google-Smtp-Source: AGHT+IF7mBwqP6DH1A97aLxg7ia+DIQDvTPqkVP1S6iEgpgGq+vFZhx4slm2fFVmJXZSQc7651fsUw==
X-Received: by 2002:a17:902:e883:b0:1cc:6dd4:594d with SMTP id
 w3-20020a170902e88300b001cc6dd4594dmr15341454plg.42.1699253940105; 
 Sun, 05 Nov 2023 22:59:00 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c3-20020a170902d48300b001c62e3e1286sm5167130plg.166.2023.11.05.22.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 22:58:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 35/71] hw/ipack: Constify VMState
Date: Sun,  5 Nov 2023 22:57:51 -0800
Message-Id: <20231106065827.543129-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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


