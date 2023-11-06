Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC9A7E1AAC
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:05:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztZK-0004Rd-Fp; Mon, 06 Nov 2023 01:58:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZF-0004Q3-SG
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:37 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZE-0001NL-Bu
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:37 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1cc68c1fac2so37965565ad.0
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 22:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699253915; x=1699858715; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=44UN78pXnBrTvXHLRJVYTCWtNWEifFGF24ARe8UxBYw=;
 b=QELtkxSzSIslAs2dlBb2ImfQtWE0T5/OhgxMuJa0MXImZ9MD2fXgeYZpP442Ck0Loi
 8Xnk/C5DeqeZWBHXFDYnwbDVDCZoe9C0z/deIyu1/p4X0vca9nVbmhatuTp3UEuXe7aY
 9uM08lzqXZeoz1CbjGAk8iOPVQ9xq1T/o9ep/SLm/ruyLBR+kwv09GDWBLIFRFHi7XTd
 FzCCWjxC3Afbxoi99UR+Pm6csBYzSeAIAIyOcC8jUABE7WoBpCdtdlfXaxENSsSD//ZI
 cRp3ucELAreCHG0fI4uMAnIlUe+mCpTg9Xzipm2x87xgqFNadroGPwq/3YAZB7uvQ4b8
 bQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699253915; x=1699858715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=44UN78pXnBrTvXHLRJVYTCWtNWEifFGF24ARe8UxBYw=;
 b=X8twCn/mjY7VGAy7NmQJI069dcJGrvsdySyBFU6LV+FyUSyalC6/5/becMUyn7whRZ
 a/4yrlbEmcTh445cygb0ZxuHlv2UpLp4KvuxPDwb0/EQYUu4JC7WrIZSnkqLveIQHx3Z
 YkIft3/hW0fe3/FxKGuLPx7zFrRr3OoZzRn9ZtnIgGqiQDagzMPQftcfFCvWGIpLO2wf
 s8op9SA/93oxFVkD5Lfx4InPTXviMQKKTcqvDfaIqaNS+KgV3mFXHWJbVAQdNg+sKBqx
 pgCavUt1wVqXRW440YIfcllKq7grLNGoEv7NaRtyAD8D0MPcy8ukd5hZXB3ig4L3blpj
 5Rnw==
X-Gm-Message-State: AOJu0YydX2VuzGmgVsm1m9lXeE7KrB6VpwVXfm+x1GAZbzSQ7WTHnXhl
 RoJyJpTy3j9dIbdzbtA7vXgMMLbTIF5f3/LgHXI=
X-Google-Smtp-Source: AGHT+IEBUYBHqc5P39vhMz/tuWWwaadJ2UwVwqmnsZAte7zF+U6KpcIsgiQjHJVrwSOTJteN3Ae6jw==
X-Received: by 2002:a17:903:1104:b0:1c9:dfb8:a5a0 with SMTP id
 n4-20020a170903110400b001c9dfb8a5a0mr33593784plh.10.1699253915034; 
 Sun, 05 Nov 2023 22:58:35 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c3-20020a170902d48300b001c62e3e1286sm5167130plg.166.2023.11.05.22.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 22:58:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 07/71] target/hppa: Constify VMState in machine.c
Date: Sun,  5 Nov 2023 22:57:23 -0800
Message-Id: <20231106065827.543129-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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
 target/hppa/machine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/hppa/machine.c b/target/hppa/machine.c
index 905991d7f9..e4b358d038 100644
--- a/target/hppa/machine.c
+++ b/target/hppa/machine.c
@@ -122,7 +122,7 @@ static const VMStateInfo vmstate_tlb = {
     .put = put_tlb,
 };
 
-static VMStateField vmstate_env_fields[] = {
+static const VMStateField vmstate_env_fields[] = {
     VMSTATE_UINTTR_ARRAY(gr, CPUHPPAState, 32),
     VMSTATE_UINT64_ARRAY(fr, CPUHPPAState, 32),
     VMSTATE_UINT64_ARRAY(sr, CPUHPPAState, 8),
@@ -166,7 +166,7 @@ static const VMStateDescription vmstate_env = {
     .fields = vmstate_env_fields,
 };
 
-static VMStateField vmstate_cpu_fields[] = {
+static const VMStateField vmstate_cpu_fields[] = {
     VMSTATE_CPU(),
     VMSTATE_STRUCT(env, HPPACPU, 1, vmstate_env, CPUHPPAState),
     VMSTATE_END_OF_LIST()
-- 
2.34.1


