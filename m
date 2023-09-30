Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D08077B43EF
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Sep 2023 23:29:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmhV8-000617-EM; Sat, 30 Sep 2023 17:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmhV6-00060g-AP
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 17:27:48 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmhV4-0007K9-Nb
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 17:27:47 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5859a7d6556so1718276a12.0
 for <qemu-devel@nongnu.org>; Sat, 30 Sep 2023 14:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696109264; x=1696714064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xC37eoqg+2YbZz3c8BLdow0ua6W9XsMYlANpVl/9Uws=;
 b=K7xrpMw83Rq67jvUtkAyNrDh+Ie5o7i/ssTOEQVvQNtmdqY6lIyP49DtEcY31xFxdu
 ZRaH1ELRzwfFa+I6ddFhz6TUSWjOAEaCIwGIeIqypSOj8kV4ur3uegt1OCdb50EfBQia
 7VkenbfQrwFDI2/u+Sxmyg3fkYgcT9Mg1scMHDjaln2fQ1y+f7AxuyEuKwmzUTydI2kY
 WoTdZv7pg4irlF6I7Ft05JRqhziM8v6VJVzLoHo8CWonV4cMxdyYlyOygbAITWuMuI1B
 eS47nwum/pHnE3UknjiZ0rADks9GrP7V6HS+6G1r9xleAtF4fkpjzzCRCrantKVaLHCg
 zXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696109264; x=1696714064;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xC37eoqg+2YbZz3c8BLdow0ua6W9XsMYlANpVl/9Uws=;
 b=ZdsPIeNIyHE3WPR+m4bWqpbguE8Vxo58sEZ3C0MO1VbYcL7AUMM8BrtFEvz/O1ZRS0
 0Ulb6KCxDPZIVIiPXiYUxipOjZzHtdgXmaYnH1w90lTaiWh8thBnzMwzG+r9tin+CN+z
 /FkIgxmOu+Q0TULMzCK/smtOCySekfRuxFkWWF8lPGfoSL7aXlBonCjG3sICqMTngblI
 QrFGJN8ooLfR4qaniWT645EKFSvEeKrelAp67bdAFc8TVNlF/rhi9JbWuOqLw5sRMfPq
 yUvR1skFmI//AYBkaDJiaae7z+Swoyu1G4YM+GndzWrcfj5WhALjgWOEYaAv+fXCiWxV
 43sQ==
X-Gm-Message-State: AOJu0YzZa5zysgsm2YbG4hk8AqXkBWiXz4n2QIJvT7mjVksBsvd0ylYH
 BSqYK+iTLLUm1FUio5MV9XQjamlan3fRSCUaO80=
X-Google-Smtp-Source: AGHT+IE4mmuuaktIlM4NSwxBHHPniAHzuOZNNL/zFTI7A7POMf5y2BHdoGQ7goKlUNDH3hoVfbxGNg==
X-Received: by 2002:a05:6a21:3388:b0:14c:3218:c1bd with SMTP id
 yy8-20020a056a21338800b0014c3218c1bdmr10586882pzb.11.1696109263868; 
 Sat, 30 Sep 2023 14:27:43 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 mv11-20020a17090b198b00b00274a43c3414sm3561532pjb.47.2023.09.30.14.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Sep 2023 14:27:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH] linux-user/hppa: Fix struct target_sigcontext layout
Date: Sat, 30 Sep 2023 14:27:42 -0700
Message-Id: <20230930212742.586468-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use abi_ullong not uint64_t so that the alignment of the field
and therefore the layout of the struct is correct.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/hppa/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/hppa/signal.c b/linux-user/hppa/signal.c
index bda6e54655..ec5f5412d1 100644
--- a/linux-user/hppa/signal.c
+++ b/linux-user/hppa/signal.c
@@ -25,7 +25,7 @@
 struct target_sigcontext {
     abi_ulong sc_flags;
     abi_ulong sc_gr[32];
-    uint64_t sc_fr[32];
+    abi_ullong sc_fr[32];
     abi_ulong sc_iasq[2];
     abi_ulong sc_iaoq[2];
     abi_ulong sc_sar;
-- 
2.34.1


