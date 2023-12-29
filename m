Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EC18201D1
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:31:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKPW-0005Gv-6c; Fri, 29 Dec 2023 16:28:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPH-00059z-MY
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:28:40 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPG-0000Jp-03
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:28:39 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5ce2170b716so2874504a12.1
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885316; x=1704490116; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8qiXeFCQHMfrcvkAhK1aChACVtlmSwMwxlo4rTy0C0U=;
 b=uE97oOV+JCRQJNiJHcKbswSjj2hOz7h4Tkb1DgXgKbMhB5jhof945wzjw10apnDq7B
 oJt71pQTw0QSHPVkdfVREa+lPWNyfCDV3GUovhujUF6NH3ZrsoxUAzELL84vRNKRd5gu
 YJei2he+4aEvt61WXQBlGOw87YEBRfFfYhDMNF/WdLod+LRTcFEhJMLz1BX70Xuv57nr
 TntS1h7EDlTGrhd1ui5OCgB4x5VtaV/+2Zl9ypjnh5oWTrvIoKzrE3ue2lE6KB2AUye6
 eta6ryq7X70OPQhtkGHBO/MM4D5fR4mdVOfDewn22z3I1xQ/eKEtBXEonegHAFMD7nhj
 2SLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885316; x=1704490116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8qiXeFCQHMfrcvkAhK1aChACVtlmSwMwxlo4rTy0C0U=;
 b=J1wlW3B6AuSqjI1hpMWPskzl9ejG74KDRZZHmIuBVIM94Wuy9aiLukTcI8I048B3pV
 swjESHaSsPgwUiTWalTozl2wDJc6GC7agP5u7zgTRTHh/XsrnxXKdw374nkOxa0RVFX1
 FUCDs32yi5PcDZkrqx/zukfWazjZ8mOHSiBuWofWlLoMk7N3OxqeY+VN7EhctJOZTEuY
 Cbn4CjXKc8y+8dB5WjItNVRCZWSFtFcgZriky+fyG9hRv7t/SVDkekqKVuK2AMfgKlNW
 QSEOwZv6LTCSekfSmCA5CL4XGsHwMaB1uitGmRZzvzCN9TitFxM+AVvUdkoPyYOkLyer
 aBOA==
X-Gm-Message-State: AOJu0YyTIgam3kYCsYf/rSndJ1kBpKgjY1mVFQ6jDL7S4vT+y5Yg2kfN
 u0kdEKJdRXE7QEtETQ6QFnEQeZ7OVlsJivVUbhg45ns4KnIeGQ==
X-Google-Smtp-Source: AGHT+IEIUezluwImHiVQxJLuHhKmjDwH0HiQE9hPqkNhN9WvwNHBjc+x/Yb4yB32amf4pySK+vEb4g==
X-Received: by 2002:a05:6a20:8f01:b0:196:4d6a:c88d with SMTP id
 b1-20020a056a208f0100b001964d6ac88dmr3359105pzk.50.1703885316349; 
 Fri, 29 Dec 2023 13:28:36 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 bd33-20020a056a0027a100b006d9a96b7d0dsm11285396pfb.208.2023.12.29.13.28.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:28:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/71] hw/openrisc: Constify VMState
Date: Sat, 30 Dec 2023 08:23:18 +1100
Message-Id: <20231229212346.147149-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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
Message-Id: <20231221031652.119827-44-richard.henderson@linaro.org>
---
 hw/openrisc/cputimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/openrisc/cputimer.c b/hw/openrisc/cputimer.c
index 10163b391b..835986c4db 100644
--- a/hw/openrisc/cputimer.c
+++ b/hw/openrisc/cputimer.c
@@ -145,7 +145,7 @@ static const VMStateDescription vmstate_or1k_timer = {
     .name = "or1k_timer",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(ttcr, OR1KTimerState),
         VMSTATE_UINT64(last_clk, OR1KTimerState),
         VMSTATE_END_OF_LIST()
-- 
2.34.1


