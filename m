Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E7B81AD25
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:19:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9ZG-0007MZ-NB; Wed, 20 Dec 2023 22:17:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9Z6-0007K1-Gc
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:17:42 -0500
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9Z5-0003jN-2Z
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:17:40 -0500
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-67f09756761so2052046d6.3
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703128658; x=1703733458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9bkE7Nkck8jCVlo3ZfGFis2m/4PuQ5ltx1TxJ8pLrLk=;
 b=ng3jlAWsj+nxjXVGqdMjrAPQ9sZ2OTyP1KV9qifgITKMhTobang2qMvJxKJvzABwaD
 x7gQdi+O7DfvkOQAfU0XpXjWUpUe/7g/T4BmnBIOHHqel/2dxX1NEodUqhr8ye0GckqQ
 CzBaOpT3EDEQfIweAb3Bme5XgCE1rQE50IxgHHBlfBfiqIOpDlcs2YV84ZuWCzBTx/ut
 6CWA6244WMq0L8RZYGbxJHk6Q1n0beCscff+t8F6jo0zrVU8dWZ806bXYdBHT2mEfGNU
 fguE7ZkeEuJb9+BOOXGTe9PPD5Zw2lJ3Q5tcrJQ0HDucfkUTO24RrqBk+FIg43siDNlC
 FWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703128658; x=1703733458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9bkE7Nkck8jCVlo3ZfGFis2m/4PuQ5ltx1TxJ8pLrLk=;
 b=K0fVUbY72qmT/PY9qJv5uRwIjKSmctCbnvJm7TwBdhBIu6FnG5vZy7OUyvMbHwHpN9
 D+oeyptbfHlA6Z802QJXRCK1iRa/XAnIJStTjbrblYQ7K0oWB0VT48RC1a6ex3RlZRBs
 F7wKIFee+9Cnl+LmZbYdGzE7RRsgXAKWr+lMWX1NgMhxUcUcMmLzYbl3ecQqPrL1SN/y
 bvJeXtlQ9ebMrMOpwOYl6HgzX44FxpEXT8+P1UBugU1w48hNOPYdUscV7J4+R1YQCBg1
 2kr+bBZQeErScvnqJdCzRM+HeF2rYpJ+mzQOJk0xnSAXfUkvQRvH+VDtyTIDv9GgnJDK
 gUNA==
X-Gm-Message-State: AOJu0YzoVIRSq41zgsACvx8smk93Ujdon/xeLLzOGS+pHi2hTtqdUuCK
 gTvlWhu4aCyYFxtrUhC6bNVsXGgmZU8B7OZPmY37vs4/
X-Google-Smtp-Source: AGHT+IGVgQHX3CZqRXWoSkarHr9BCbtZE9dLe4UkL8/DHFknOmUGTTcIrxc+xezFy3tgt1G/r2nnGg==
X-Received: by 2002:a05:620a:4722:b0:77d:a29a:de49 with SMTP id
 bs34-20020a05620a472200b0077da29ade49mr30450834qkb.3.1703128657971; 
 Wed, 20 Dec 2023 19:17:37 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 n8-20020a05620a294800b0078116d55191sm360808qkp.130.2023.12.20.19.17.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:17:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/71] target/hppa: Constify VMState in machine.c
Date: Thu, 21 Dec 2023 14:15:48 +1100
Message-Id: <20231221031652.119827-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2c.google.com
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
 target/hppa/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/machine.c b/target/hppa/machine.c
index 15cbc5e6d0..211bfcf640 100644
--- a/target/hppa/machine.c
+++ b/target/hppa/machine.c
@@ -201,7 +201,7 @@ static const VMStateField vmstate_env_fields[] = {
     VMSTATE_END_OF_LIST()
 };
 
-static const VMStateDescription *vmstate_env_subsections[] = {
+static const VMStateDescription * const vmstate_env_subsections[] = {
     &vmstate_tlb,
     NULL
 };
-- 
2.34.1


