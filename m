Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E890D7E1AA9
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:03:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztaB-0005Ys-2R; Mon, 06 Nov 2023 01:59:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZS-0004WK-Ay
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:53 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZQ-0001PT-Qp
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:50 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1cc3bc5df96so27808745ad.2
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 22:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699253927; x=1699858727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Kp3LdJQ+0DDW7fRbDra81qjp63RB68lSrd0D+4IAlw=;
 b=XKRHKl4pLB4LSXSWoqY6Icyr6N5Ui/BAArWHMWDtaIsDiWJaCur5rAn6B2M8g8CZXE
 csSUG/i3LymRulklLbdjg1OXrLZJGTHh1W9BaibLegygbDvpGO58EMet1mSQ1VUTyyuG
 fPn+Isw0B6RwgGbrkOLXRnyTZryJVM1WH2A+ojZbW34bJkd6z5oWH14GS74CD+Dum5sp
 2cbsgqasQm7377mVL6hyqaoQcQQQqDxeS2ZtCYj+IAq13ggQM0J1GrBiGqkpZDtlSDWY
 DnZO9SlAytOfGN3hlAFeLPYwv7Fd423ibdwLE3yJtmjiHmnIos1qUnnf6uCWOuHTahxy
 6RzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699253927; x=1699858727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Kp3LdJQ+0DDW7fRbDra81qjp63RB68lSrd0D+4IAlw=;
 b=gxTSpivVe1YKxBzMROItLw1l2e4FCJvMAMIv2s8UFuSAabhFS7yzTwEkHW+r+loKD8
 KgsmUWgW93FneB2YHEJ/Lxb3nb/9Px0ExH0rNbzZnA/PEEiaEkXPwW960TeMuvsfMid8
 9sVdt6fi+xlLA6Ai6XnneWfJX4Fc5tJ1yhVsVg2nAKQmy/nomHeV/aF7GnJzy3xch7dS
 y0cn2Ng2XiI5eAWBT5ftJGXxfPIiiZLCXqU1tKeSKsAz9OC7Lqdq0Zhr/Ru83L++C+k9
 sfHb3fgFlIQvrvld/6j8xWILilM/cmfLGWjZQFLHRE2yjzQ+bViZK2wU0Mf0QsOtkwzn
 Sxew==
X-Gm-Message-State: AOJu0Yz12PnrzGlYcvbwIGfMF3j6d8jN4OsFougUkErrOCwaDmAI3Xw5
 X35u+L3Q2hHQHBCGhQYh14y8c1L5vM1kVjWGAjA=
X-Google-Smtp-Source: AGHT+IEyJSplOCEY7FficHeOsHW+b6rcysXGZ29GQZdruOF6R0ARgpHnUC5QCALZpkCfUxBK7OkqYg==
X-Received: by 2002:a17:902:da8d:b0:1cc:548d:423b with SMTP id
 j13-20020a170902da8d00b001cc548d423bmr20427837plx.60.1699253926595; 
 Sun, 05 Nov 2023 22:58:46 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c3-20020a170902d48300b001c62e3e1286sm5167130plg.166.2023.11.05.22.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 22:58:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 20/71] hw/9pfs: Constify VMState
Date: Sun,  5 Nov 2023 22:57:36 -0800
Message-Id: <20231106065827.543129-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
 hw/9pfs/virtio-9p-device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 5f522e68e9..efa41cfd73 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -237,7 +237,7 @@ static const VMStateDescription vmstate_virtio_9p = {
     .name = "virtio-9p",
     .minimum_version_id = 1,
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
-- 
2.34.1


