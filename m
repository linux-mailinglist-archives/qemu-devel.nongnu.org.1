Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A2B8201C6
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:30:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKQL-00011X-Kk; Fri, 29 Dec 2023 16:29:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKQF-0000Gj-25
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:29:39 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKQC-0000RE-Mu
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:29:38 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5ca29c131ebso5612980a12.0
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885373; x=1704490173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tC/HddNi5BEccgo2j6UmM0509lK7SEFQpZ6hYE5pDdY=;
 b=ZZJTk34XenuhspuYRQ5XCpCpenlUpSwjg5/7WSn25MFpQSuv6FfkTRnzuCbM30zfrn
 Q+eJWBjzT9ql1bbNQt9qr7nCm8W687MiJgMavU6pLRLbVxTr0o0IEsovDf5CFhCDMnZ9
 IHTYP3GHk/xXwqY8F6OAGLcYNpBrMRfh9njF2w4L8ONrME06t8n/E57e3st59cr2DYhg
 wAN7alIRKU8zpmO0+pu+ZzdyvpLpZTw9/CUUeMR3unPVUJOnBQhLsfA7YlkwGv7M/EbD
 kN1qpIdJfml9Aby4g0WFtghYilEbBG4rS29CbqTPyEfZOf5zgY5Ms+Vn/ocWeYjjLedO
 RxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885373; x=1704490173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tC/HddNi5BEccgo2j6UmM0509lK7SEFQpZ6hYE5pDdY=;
 b=B90+JmRrdyoSYdztXXTlbwAnUJtyEyGfe1OGjkU2Wh1Hz0OdTR3iYv8fX6C3YaB3qg
 Cz9q2MLcLcez1p3UgsrKtnkds6dh60YnUQyU0sEM6aPWUSeVAs1OgnC9nOHdPuOWDULg
 VXGmm4+Ed32HpqQwcu+0WRtSUUWRmp8Zyu4o7oxpvOA5anCAs5ES+Q9UJxhF73467Q+8
 A8kEHLue1E4x67F0QSDBeD+01erGKBTx7PyFG4P3Bezma38/4/JrbX6lpx7g7x6U9+Fg
 kq3K28/9t/KGaDZnaykbFogEnxBachmqelNnOSF6XiXqGlkwvFqqD6yPe2mzIcSmhu+J
 wC6A==
X-Gm-Message-State: AOJu0Yzt6YA0qo/j43lmHGi54CbU46X3LEYCh/cDuDbxLcg+lJQVtb3M
 ftl/n33A8s9s4lZjhsKK5U5H/Ky3fe9pT74VR8AqZuh2wkulXw==
X-Google-Smtp-Source: AGHT+IEuzRc6DL8ST40rejfL2KBOIc4epCsNQSP9PvOepFYPNIdXsWIVdPYXe+HtcHttII6wdI1wrw==
X-Received: by 2002:a05:6a20:4d84:b0:196:3544:c3b8 with SMTP id
 gj4-20020a056a204d8400b001963544c3b8mr3832102pzb.45.1703885373703; 
 Fri, 29 Dec 2023 13:29:33 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 bd33-20020a056a0027a100b006d9a96b7d0dsm11285396pfb.208.2023.12.29.13.29.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:29:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 68/71] replay: Constify VMState
Date: Sat, 30 Dec 2023 08:23:43 +1100
Message-Id: <20231229212346.147149-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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
Message-Id: <20231221031652.119827-69-richard.henderson@linaro.org>
---
 replay/replay-snapshot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
index 10a7cf7992..e5e39161e3 100644
--- a/replay/replay-snapshot.c
+++ b/replay/replay-snapshot.c
@@ -51,7 +51,7 @@ static const VMStateDescription vmstate_replay = {
     .minimum_version_id = 2,
     .pre_save = replay_pre_save,
     .post_load = replay_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT64_ARRAY(cached_clock, ReplayState, REPLAY_CLOCK_COUNT),
         VMSTATE_UINT64(current_icount, ReplayState),
         VMSTATE_INT32(instruction_count, ReplayState),
-- 
2.34.1


