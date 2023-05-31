Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E24718B55
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:39:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4SYo-0007ro-Mq; Wed, 31 May 2023 16:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4SYn-0007rG-82
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:36:45 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4SYl-0003Ki-Nc
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:36:44 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-30af56f5f52so54687f8f.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 13:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685565402; x=1688157402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bxI8oOMi+OTgw+TcZSVgrTxV90PbWEXNzhwY3LKFlJ0=;
 b=w14v5IeB4aFlnV+gVzbxiX9fKxJQ8doL0ZdQ8mTnyHdU2JtCi2MnUX4uQOYYvBL0jJ
 IT9n3wjpilxQHV4kEyy9+sP2PS+3P8QDqXKY3grBXysI11EWUs8LPWtwQYNTwtsB+jib
 ABzt8+prwsgGpHEdyAp357eecu7Ft8HiWX28vKmku0fBwADJFbu/Oatf1k11pEed5Fvf
 gwb/MG0xxb8dfSrqKeYECcQ7A73VBsiYTS+9SHzBlxt/7C7YAX9LAAo4Li4/xJewcoWj
 xRfBwh4gzCBB7vgx6Jj0a8dNLovuhZ1umr2cK57dqp/jJYgj4kDWJsdWCPIQn5V3UcOl
 hqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685565402; x=1688157402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bxI8oOMi+OTgw+TcZSVgrTxV90PbWEXNzhwY3LKFlJ0=;
 b=TUoY+Lm93fhR91eWlv+m2RuAYik6FxrWDIDzCAuu0kUeB8lXE5QC7Phs2ulD3LcYEH
 e0Ky5hFOpvMWwNEoyDEQqDYdQT03woaMOREJVy0Z4p8MLtX0STvot+p9V0CXAQ5Qy8CQ
 KomwKvuJg8uGRDYBxSyVsrdpqXwq7cNNG2anZOtpdFwVNPOA4/fW/oBqlK7Zr6Ew3cBU
 qoQ7TfVMk5a2nThbyhG9HGhiS1Mbh6XbgSOX+dEqNDq24k1c3CUFR4UvUF1/p6aTsIPl
 NiDaV2K0DSHrG3Pxav6qE6FfQrdoXkrvfVoJavrsjecA2qgKddZCrsJXis6vjU4AKHPO
 dTNw==
X-Gm-Message-State: AC+VfDzpaeW4oxxSz+m3zauHkT5kfGSkxc+SKCsvPbMuNg+U82VvLN2D
 xVie6t3mO2z3WOsdiWxEnJPrDH5q9OSuuz1i+s8=
X-Google-Smtp-Source: ACHHUZ5D6VksYp3cDxusKzD5RZt+J8n4dcFprX65y2zFu3pBRdn5FmiwL+lLValRHK6WGiKgfU1hrA==
X-Received: by 2002:a5d:65d2:0:b0:30a:bf2b:e03c with SMTP id
 e18-20020a5d65d2000000b0030abf2be03cmr162255wrw.23.1685565402265; 
 Wed, 31 May 2023 13:36:42 -0700 (PDT)
Received: from localhost.localdomain ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 u15-20020a05600c210f00b003f42d8dd7d1sm25676262wml.7.2023.05.31.13.36.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 31 May 2023 13:36:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Sergey Kambalin <serg.oker@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 07/15] hw/timer/arm_timer: Extract arm_timer_reset()
Date: Wed, 31 May 2023 22:35:51 +0200
Message-Id: <20230531203559.29140-8-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230531203559.29140-1-philmd@linaro.org>
References: <20230531203559.29140-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Extract arm_timer_reset() before converting this model to QOM/QDev
in few commits. This will become our DeviceReset handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/timer/arm_timer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index 2cd8c99b4e..54318d0a57 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -172,13 +172,18 @@ static const VMStateDescription vmstate_arm_timer = {
     }
 };
 
+static void arm_timer_reset(ArmTimerState *s)
+{
+    s->control = TIMER_CTRL_IE;
+}
+
 static ArmTimerState *arm_timer_init(uint32_t freq)
 {
     ArmTimerState *s;
 
     s = g_new0(ArmTimerState, 1);
     s->freq = freq;
-    s->control = TIMER_CTRL_IE;
+    arm_timer_reset(s);
 
     s->timer = ptimer_init(arm_timer_tick, s, PTIMER_POLICY_LEGACY);
     vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY, &vmstate_arm_timer, s);
-- 
2.38.1


