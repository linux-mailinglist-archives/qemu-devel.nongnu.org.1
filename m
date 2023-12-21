Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D203481AD68
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:25:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9g1-0004Ee-Ll; Wed, 20 Dec 2023 22:24:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9fz-00047i-Gw
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:24:47 -0500
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9fv-00011N-AR
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:24:47 -0500
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-67f7bd86cafso2323946d6.0
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703129082; x=1703733882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=W7VJPAoa0z4xCQmXZrm1hRkX2bwGlhHw1y5NMWV4Vs8=;
 b=cPrpH2bdivVsyItrR328Egv/5sDK4789drVwQ6IU48W3O4hiKalUKIh2VrNyaezoPK
 vM3AKclW8tzpP8A/Md3IqVRJnLcaYCfEvoayV14RJhFAigE2utTM6ON0KFN49nJpz0AF
 QDwEw1m6tLAt/UHE3w2zDK2sezY4oW2ojdXpxhe62IrA+23GG3nGNRC8gjNJehXfmWju
 JAzdc6ElHQcgUIS2sImkiWp+nLYVFRtJdJ1BqafLUPr9+BkkxCjwaNC9uL9pvGP32g06
 3lLEEpmMkJgcvyE1vNxFIFpVu47AN+rlh2w/mN7O3Qjj5v90viNwiBPzvL4U3JfOV9k5
 ydMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703129082; x=1703733882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W7VJPAoa0z4xCQmXZrm1hRkX2bwGlhHw1y5NMWV4Vs8=;
 b=tDQlQPyIPd3+9eik/EGHl0Z3HKGgqC9IYHp4Aamm3a7SL7GPE/G0+q2/37hB3PJfvU
 kvdGvV/kSZkZu4XQjy22jAsfDXbY2lquUj2tnrh/QkPAo9IpWQZgQF3HgqYPuHY29ppN
 XnKEwEdZsQ/5OGsscIEj9e/9h0uWCLPncUGIZBbxyswf4SXWdcArkq5HXzVwbdG3Evyx
 95d/Kz/3ecG4ijzWV1662SNXcK49qSiZ2te7nYr9br+/iOR/DPYLlCek6wS7dkWJEYpN
 kuQA+xBK2a2JREb2/Iz+e4aw7jXZ7GWwd4nabXC4U0KSPV74vlP5+LMh4x9ID1ogABWV
 TLLQ==
X-Gm-Message-State: AOJu0YxfyGI0e749AU0iq8i2Xsf0kcbYVKlszXUyn92iF/T01ATE/Tqf
 fys6+ge2RsrQfezc/k9wra5SmYWmmBdSTvllVTV+4mVY
X-Google-Smtp-Source: AGHT+IE4Z0xGmXztniruWFksEnH2UVJOBaVSEEo5/IN62HJLr90QbxvgJvpCnD3++NgQRc9jgImYuA==
X-Received: by 2002:a05:6214:c6b:b0:67f:1bff:ed34 with SMTP id
 t11-20020a0562140c6b00b0067f1bffed34mr13090787qvj.129.1703129082322; 
 Wed, 20 Dec 2023 19:24:42 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 l16-20020ad44d10000000b0067f7b6318b9sm347257qvl.10.2023.12.20.19.24.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:24:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 68/71] replay: Constify VMState
Date: Thu, 21 Dec 2023 14:16:49 +1100
Message-Id: <20231221031652.119827-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f33;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf33.google.com
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


