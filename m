Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FED37D9BB6
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:41:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO0S-0007Mq-9b; Fri, 27 Oct 2023 10:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0D-0007Gp-1l
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:57 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0A-00089k-Lu
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:56 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-32f5b83f254so1475582f8f.3
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417593; x=1699022393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ujFzQLltW2Suocxr+GhD/2DbHmU0GTzQwzP5CygPT38=;
 b=HE77PfqFvLGJVdVTcymwZK+DLweHIe6Wg/Jc0Lfv5z62vTJmlMSgQRPCLBz32v0jdR
 +2WuDAD5GQvpSCTnqn1gZQ1noK+5yrp9Hvc46LGq1eZJl9qZt8vY8hMzA5oZ98iueuRm
 bBA2jSMKcaUInRySgyeFjNJJMNAAqiUgcjMSark/PJSXt4PUB4zUDfMalRCcXQa4z0mG
 EyKFdgv6pwkP61boPDpuiWmfzXrjmkmyxwQhz5Gihcm34GOoE2MH2n5q3pBMAErHqC+A
 YV7hLbH3JfOfLxh3mnL/DEwFxx5I7ZXW2301gY2n5grhGN4WJIKMb529+L4X89CSsqMl
 ALxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417593; x=1699022393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ujFzQLltW2Suocxr+GhD/2DbHmU0GTzQwzP5CygPT38=;
 b=rk1VpksCK9q6ysnT0jAjHLLOq/bPwwjk6TH0QXIQKy/R94Xw6JfKFZkxIosEwQMiGq
 2Xj8CcL0P0cfaK2th4tQSqqm+bHIvuRUQNxnD63AhwbsSpHAglzTRpNx2Zh1l23fcQ6s
 mbR9GtnJ8frdzm+x8Gm9L9zuylUhxoJDQl66cKrpzOACIMiahyzvICuqdQKrvyLY9duT
 x+JraEpuGbIDNNDPW7AjlRY1aoAA22cQmgdab50xC8I9XhauxrM8Sn6dM/lUT79Ip1Fk
 bfFKjlmG18DTcwzMKRylG8vye01y79VB7PkU4MOXVf4aGxefZev/Cqw2Yb2ci2IGVJn5
 QqaA==
X-Gm-Message-State: AOJu0YzPe8DjSfOR337JS6Jzgo5JPpuLDpOYpqV8y2bC1NAoykmXuk/t
 y7WwUcRMdGutbaU9+BPaJ+FWvpPQoZJCShszGHc=
X-Google-Smtp-Source: AGHT+IG99Ci7wIvi9k4Fgmu3DtpsB1Fnj7c2fgNKWWyY6Qg8rCgzbhRrxPb7gBUQ91y+iyzPsFk2lQ==
X-Received: by 2002:a05:6000:c8:b0:32d:9cf2:f82 with SMTP id
 q8-20020a05600000c800b0032d9cf20f82mr2254960wrx.45.1698417593177; 
 Fri, 27 Oct 2023 07:39:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.39.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:39:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/41] hw/arm/xlnx-zynqmp: Remove 'hw/arm/boot.h' from header
Date: Fri, 27 Oct 2023 15:39:20 +0100
Message-Id: <20231027143942.3413881-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

"hw/arm/boot.h" is only required on the source file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Luc Michel <luc.michel@amd.com>
Message-id: 20231025065316.56817-11-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-zynqmp.h | 1 -
 hw/arm/xlnx-zcu102.c         | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
index 687c75e3b03..96358d51ebb 100644
--- a/include/hw/arm/xlnx-zynqmp.h
+++ b/include/hw/arm/xlnx-zynqmp.h
@@ -18,7 +18,6 @@
 #ifndef XLNX_ZYNQMP_H
 #define XLNX_ZYNQMP_H
 
-#include "hw/arm/boot.h"
 #include "hw/intc/arm_gic.h"
 #include "hw/net/cadence_gem.h"
 #include "hw/char/cadence_uart.h"
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index c5a07cfe195..4667cb333ca 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -18,6 +18,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/arm/xlnx-zynqmp.h"
+#include "hw/arm/boot.h"
 #include "hw/boards.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
-- 
2.34.1


