Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 630107E1ACD
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:11:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztf4-00045q-0h; Mon, 06 Nov 2023 02:04:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztd7-0000xl-Fg
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:44 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztcu-00021T-L8
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:36 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1cc3bb32b5dso37782495ad.3
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 23:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699254143; x=1699858943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9H5O9Zda+vpUUqZvbTNZUrv7Fbtfcl7R0BVTLI0MHJY=;
 b=XeyU8vDEzV6eSf3eMIfgRp5bT/+7aQ/ZQzNdKHSNLsrenFQtBJUpQ7A2HKpBQ0hr+E
 Mgmb9RvxCxgayUGtx06kxeUNtr9EuGxw+KmXBxVgb6cX4j6j+vZfpmyI14BoCMjtkJYQ
 XZQmBIDMB0/gSeu5Gw6A+e6ma/aUeLash7e/1nP5bCglrRIc6yH97OJ3Yq0ZcNoOegI5
 36y+QNSrzWxmp38SmQgqo+OXv/bm68hVH+YsiczRvZ3k7Qox8DizJ5iqalqvjkakmdpE
 oUGZtdYQ4fLRc0ZRunaxBsNaHANHmc37forw8d89hlHBntlK0ZqWBit+iih/C+8zl1C2
 Xl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699254143; x=1699858943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9H5O9Zda+vpUUqZvbTNZUrv7Fbtfcl7R0BVTLI0MHJY=;
 b=SvjsHRblm4hSheisCMOhpFXeLYl70U5J+oMCaoS21G2cIqSIjMckxPTDU6hgsgUS7g
 3Kx5Zq5M0HTUUXfioGbOF6nf21fIR/NxP/Lbki0JgZXWlJuSvVpWgZbIPVAje7hjBSmd
 jY19i5p67iOB13gMC9lb+4F/aCsNL4H+y7qjppMkHyh3Q9M4PFiPV3tFPkHnr0UqNAwi
 L4LcF4nZ7UhIS0OuPZ2qZf5npqSRRC5AE185hfuLmIVreBwLSIXIaR3XNTTp2Rv9UpgX
 HoRPQ7Kj5BOARZffaxthkbIaOql0wOelzF/x9fOuY6yxwoVzA+zgtQyq9W+fN2CcLCa3
 Jl/w==
X-Gm-Message-State: AOJu0Yz1DCof5rKf6U0riO1ab+QnMSvY6gLJJ7CGZX1e2qgd7AckPdbE
 F4YrPKgVt23oNu6rXkeZr4dFToDc283Yu1n9/9I=
X-Google-Smtp-Source: AGHT+IH6tFeje9p2o3FFx0gNtJhgZXZfJMz9zoS3coLKF2GhCNrswmhJLfricX6Ml608Rz3lMMUQkw==
X-Received: by 2002:a17:90a:b88d:b0:27d:5964:4ef0 with SMTP id
 o13-20020a17090ab88d00b0027d59644ef0mr25218187pjr.10.1699254143174; 
 Sun, 05 Nov 2023 23:02:23 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 8-20020a17090a194800b0027d88387287sm5319650pjh.51.2023.11.05.23.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 23:02:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 63/71] audio: Constify VMState
Date: Sun,  5 Nov 2023 22:58:19 -0800
Message-Id: <20231106065827.543129-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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
 audio/audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/audio/audio.c b/audio/audio.c
index f91e05b72c..efb6cc0a01 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1683,7 +1683,7 @@ static const VMStateDescription vmstate_audio = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = vmstate_audio_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.34.1


