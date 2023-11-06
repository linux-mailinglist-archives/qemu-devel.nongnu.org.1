Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF077E1AE9
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:14:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztg4-0006RO-TK; Mon, 06 Nov 2023 02:05:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztdD-0001C1-J4
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:46 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztd1-00022Y-Tl
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:41 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5b8c39a2dceso2260013a12.2
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 23:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699254147; x=1699858947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W7VJPAoa0z4xCQmXZrm1hRkX2bwGlhHw1y5NMWV4Vs8=;
 b=HV7hmgzKRK4BC+NJPtX9o9Nd9V0s90YEJ1tfZ+oLnxT1SC0Ajf6a1qr1H5LgntJiCh
 WmYd6ylq9gpOeNZzcjaMQQfz5Et9jUubTpdf6AjORvczMODhGMs3MmWgPkb0Q7rTaTeJ
 +0zvG0SJepX8ODIUz/p+nQIGvK2kRrxmp5ET0JT/vCeKzH2sifXaaKipqOoLGrTbOABz
 VmBuus5r6gi886Qk5Ix1i6brELmYVRGHIGI2LlmI6VQl1f1k2xM64SI2GKjw+kKFw9Cx
 LyIKz6qakNQzZlS49z1A76ch39fjt1wm7O0P86OPqPho7vk5mJ1a26Av685/pEqc1oKZ
 96xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699254147; x=1699858947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W7VJPAoa0z4xCQmXZrm1hRkX2bwGlhHw1y5NMWV4Vs8=;
 b=pXw9NAgyzt7TNqEHNx7Gd3uLNtMvEtHROR2et4rWfIb8FFMqjsxvPYtwxorX3ZmBnc
 bB2n3TT17pOSpGIsoTdvw4XurGy2O/1iuKQ2pWRY2LIP1k/Fh1/WKVw8lYeRw9mUWMxF
 +X7ePJlOdh+ysGdWrfd+QHMZFdMtYxtlX9DPWX9v+Mc6SeaPIPHDu/E2yM3X9If68Nf6
 s9hDHMg725kSe0U8Jw/97jg2JquVJNtDnaac/Xg4PEh0jJ6wvndkzPHu7LbGXT3p+DaZ
 g6K50pwhUEkDfZsfXP9cBCTnc4tcbMzWWYKi/0+M5JDGaNCiqsw/Fayd7KeUwLR8Abyv
 jXLQ==
X-Gm-Message-State: AOJu0Ywb48VYwftZztyBmAecxTERK5k+n0ZVMTEXcATEjxI/H0dDwq3J
 a8DqvEuCT1leSqA30ndlRwodkfTQraJPOlo42hE=
X-Google-Smtp-Source: AGHT+IElhmTF2Bgq8iY8a1lweijFSCUtz97gzjNtN1lgnQtrlNLae7gd6TdD1e9UpJOvU8owmOFhFg==
X-Received: by 2002:a05:6a21:a594:b0:163:9f1d:b464 with SMTP id
 gd20-20020a056a21a59400b001639f1db464mr30149850pzc.5.1699254147322; 
 Sun, 05 Nov 2023 23:02:27 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 8-20020a17090a194800b0027d88387287sm5319650pjh.51.2023.11.05.23.02.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 23:02:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 68/71] replay: Constify VMState
Date: Sun,  5 Nov 2023 22:58:24 -0800
Message-Id: <20231106065827.543129-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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


