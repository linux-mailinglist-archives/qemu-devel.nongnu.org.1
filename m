Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C234980EBFD
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 13:38:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD1zk-0001mx-RR; Tue, 12 Dec 2023 07:36:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD1zQ-0001a4-Gu
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:36:00 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD1z9-0007b8-My
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:35:56 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40c3ceded81so31018875e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 04:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702384537; x=1702989337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/12RdsXJD+64tXWZALzavaBTbOyfNyTOEXXMF3szcR4=;
 b=XXO2y1Q1sTv5RhnlMJ1ucgtmOio7rX34/sMkUnpiYJHKDfPIddWW2t8nmAlY8WfLIg
 /aK8Jkv0VnGBGOxel+m9x6wP/21sDli7p5NOEQBArDK32Hd6VE1TcmTDMC5QuDWRH5Ha
 9nPUteGz6OpDcnhm2oI3/ySQALgKYX9OQBoKePf8653KJEjr6lL4ApqRFlhaueIenkh2
 7dZzMkBpQlr272OzEfYIHAGNV/nz729fAJXMIou7U0+KDbpCWjCP+hOVRnHX4ZNj5v5m
 OADuUkS1SVy34w5hTtAAedhpeNSdyIP+bx6R5gnJMl5PgxUMLHykyWPS25I0OB2fS4Xq
 qz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702384537; x=1702989337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/12RdsXJD+64tXWZALzavaBTbOyfNyTOEXXMF3szcR4=;
 b=J5jeNqNcifRr3CkFh4OIO+qxGIbp8rS66xdz3FxdaJ6bYKbHydcvpHCs0vVmyj5qBV
 yjGU2vTdHalLi6jOxzMZCAmnVcxJKl+Oii3Ny+y+Ttv1Khab8sVEhrtsvm2L2R5/X09R
 FcqkjBa1542Yqpox6tw+ijJXSKGQhrLHMj378ZrvG1bj6V6WsY05A4fUHWjm2qTNaQH+
 84hHaI4ZpsMx+GEwzN/3QTqy+luwopNBg6OV81Y2PLhTEVH+Jfon8JuUgb1JOo6SrVwi
 bRmCSQcrNhZn448A92Wkh8pX/E0vVT4dQuP85M64v9mIn7ZrwqXHddI8ii0cbFUQK6Gc
 1utg==
X-Gm-Message-State: AOJu0YzQrCJhSbyIs/ncmfTxHD6bCV7JLRdsrHafpuAVKTJqTMyWWxi5
 E6WASSG0lk4t/CB3PiJ9B9FwFh/FMOOxqZzrqVzRpA==
X-Google-Smtp-Source: AGHT+IGOeoWxRjMCEpkyEiacQ099JQTeHRWC/+LlP+DCWgH84noTYfUF2HoTqkdyZZ+CcnNSZzND4g==
X-Received: by 2002:a05:600c:1d12:b0:40c:32fe:e123 with SMTP id
 l18-20020a05600c1d1200b0040c32fee123mr3266787wms.167.1702384537429; 
 Tue, 12 Dec 2023 04:35:37 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 tb19-20020a1709078b9300b00a1cd30d06d1sm6338905ejc.14.2023.12.12.04.35.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 04:35:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Claudio Fontana <cfontana@suse.de>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org, Brian Cain <bcain@quicinc.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 13/23] exec/cpu-all: Reduce 'qemu/rcu.h' header inclusion
Date: Tue, 12 Dec 2023 13:33:49 +0100
Message-ID: <20231212123401.37493-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212123401.37493-1-philmd@linaro.org>
References: <20231212123401.37493-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

"exec/cpu-all.h" doesn't need definitions from "qemu/rcu.h",
however "exec/ram_addr.h" does.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h  | 1 -
 include/exec/ram_addr.h | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 26b44ca125..5b5379b94c 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -23,7 +23,6 @@
 #include "exec/memory.h"
 #include "exec/tswap.h"
 #include "hw/core/cpu.h"
-#include "qemu/rcu.h"
 
 /* some important defines:
  *
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 90676093f5..aab7d6c57c 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -25,6 +25,7 @@
 #include "sysemu/tcg.h"
 #include "exec/ramlist.h"
 #include "exec/ramblock.h"
+#include "qemu/rcu.h"
 
 extern uint64_t total_dirty_pages;
 
-- 
2.41.0


