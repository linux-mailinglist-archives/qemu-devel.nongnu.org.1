Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6217B81AD22
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:18:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9Yv-0007IA-7x; Wed, 20 Dec 2023 22:17:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9Yt-0007I2-NT
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:17:27 -0500
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9Ys-0003hI-CE
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:17:27 -0500
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7811dba1d5dso18134485a.3
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703128645; x=1703733445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oboVQOi6EvjisHoCt0AjEUt8Log6Mds8YaieNrV812g=;
 b=XxJu+oNZAbUkj+GwWxAEiIhOvUXXhraxXZ0nrW4vVsOXsqg0QrRcAEHQOE2hH5XJBf
 ZIu+tT8XCxkWtRLjqbhbJdRjorqmguV8ou0I3SX1uHLZYG9WC2+ZGGQiDPdmBkwyyNwx
 lXt+3BYfUkiBYxjSUM7vBsFr+U/81QmUrIC4J3Wgh/OubOc5c8uwEcgSNYEiKRdCjY5C
 b+GxAYOHKnqQVG+u6eC9mo5CI/pUkvkuvteHg3kb/YalQpqZqF4HPAaONMFbyTXNbxdc
 tiBeRdEkbczWgE2wepa6h/R5o8R65UO/5E4phQYOwcMqpNzqS3+jjhllBs7QvxjSedww
 onMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703128645; x=1703733445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oboVQOi6EvjisHoCt0AjEUt8Log6Mds8YaieNrV812g=;
 b=LScCwVo4Ct8VRvNLiLJErEoInQ0auAiYgDhZDye2R0TXBtuQ44PdbybDI/MzNHbVwF
 tJBKg8OLGyir79EBqH9UCr4K2ZP29nbCnSi6lRfHQK5pahPU2gXKI3BmIfuYrNSVNnzq
 PIuD1Qdm+JUXcx7aDtJIRTxLAkG5BfkXISxhqXwK7aORzEuNaXFMbA5JVafWJhqiCCXt
 q9Ks3TRcae+zwASi5NbrkSxY9OiJPQrxHPLJL/PyczcRtRO++ks3e7Ww8w9VCVNrygwB
 omDG8qLqWtCKEzphB2Cl/hi1DJDLgPmNOLp9tW7MTwGiDNQAXFn1siE4/ZvUiqDEya1Y
 HFgg==
X-Gm-Message-State: AOJu0Yw7sjzx/zpn3QtIvQpz2UWHXwr0b1WipAZdORWR7safZxSLGMDD
 5S0f+zxmeILxx2WvNt72B3zzhCwDXTueNvwcmVh7HV8E
X-Google-Smtp-Source: AGHT+IHB/K0XvYdb6KyF2oQ+f8UZkhjqib3CmavMTx1oXdNHRPBLQxyAO3xxz0a5hEpSFfA2QzCHAw==
X-Received: by 2002:a05:620a:1244:b0:77f:3126:c016 with SMTP id
 a4-20020a05620a124400b0077f3126c016mr23762988qkl.124.1703128645450; 
 Wed, 20 Dec 2023 19:17:25 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 n8-20020a05620a294800b0078116d55191sm360808qkp.130.2023.12.20.19.17.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:17:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/71] target/alpha: Constify VMState in machine.c
Date: Thu, 21 Dec 2023 14:15:45 +1100
Message-Id: <20231221031652.119827-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72a.google.com
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
 target/alpha/machine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/alpha/machine.c b/target/alpha/machine.c
index 2b7c8148ff..f09834f635 100644
--- a/target/alpha/machine.c
+++ b/target/alpha/machine.c
@@ -24,7 +24,7 @@ static const VMStateInfo vmstate_fpcr = {
     .put = put_fpcr,
 };
 
-static VMStateField vmstate_env_fields[] = {
+static const VMStateField vmstate_env_fields[] = {
     VMSTATE_UINTTL_ARRAY(ir, CPUAlphaState, 31),
     VMSTATE_UINTTL_ARRAY(fir, CPUAlphaState, 31),
     /* Save the architecture value of the fpcr, not the internally
@@ -73,7 +73,7 @@ static const VMStateDescription vmstate_env = {
     .fields = vmstate_env_fields,
 };
 
-static VMStateField vmstate_cpu_fields[] = {
+static const VMStateField vmstate_cpu_fields[] = {
     VMSTATE_CPU(),
     VMSTATE_STRUCT(env, AlphaCPU, 1, vmstate_env, CPUAlphaState),
     VMSTATE_END_OF_LIST()
-- 
2.34.1


