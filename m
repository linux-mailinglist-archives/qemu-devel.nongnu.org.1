Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB2474C743
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:38:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZEA-0004Qn-74; Sun, 09 Jul 2023 14:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDp-0003Rd-24
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:26 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDm-0004Cw-Am
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:23 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3142a9ff6d8so4027673f8f.3
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927600; x=1691519600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=viFchcHGsP+nKMHrpwcA4jNmykwjrSvjDrmv/nDVIvw=;
 b=S16XyXELblcr/OMp2WDghERS+Hx24cT4ia1sFMrsT6JejvWOKCMcXU+N9NL5hrHhaB
 Tv1PW8e91jrnAl01ykA95weOuKrWqLPGvqFngTLJgcJmPQOfq4WXPcAWZXCb2lP26sG1
 GFA3TIk6wkGn0afFrAI8v5d+FBrQ2zBySnYSXy+g6t476O7m/LoaNCZUOVnH6U2pS6dD
 MduoFYovHaAiNkCgWz9x/XlAcDeEIwreED1d98Ezmr0lZhxr0HCPyhMCd06JHhl0tVWa
 dE4rNZ6I6xKdNMtfgYnx0AiRp4W/UitYyx49I3cLdtRwRYQdyrFXcXhzha0dU590lrm4
 3QQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927600; x=1691519600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=viFchcHGsP+nKMHrpwcA4jNmykwjrSvjDrmv/nDVIvw=;
 b=Gx7b75J5dV0uWHwn25l9PUNpoo53vT1NKwgnW+LxpShYKfmY/8eGE5aQUjVbosjvLG
 qx880HvcdLrjzzw9M4e6zpyOw5Bc8pFjbAX0j/d4NFqc4i+/iYeQuFehzIlSVgO4JRTT
 jrhDl3f2t3wwZrj4epzqLtwRD0X4MX3wfLIot9Hm+WYKmxu7VrE/o6caZmgIHLSTPyzi
 wvdHMz9ZBqrFsMlq/PZePDimDqPOfHY/Bs1z8tQ86AL2hBTQbQE6iGr0LER8XHmjFj+F
 e/mi36wf7H9RapYDqbuPWCZr89Gvuzn5l76rB9HlIMxnYPl5Uh9ZIEsTCgnh35hvyCWJ
 uvYw==
X-Gm-Message-State: ABy/qLY/go4IBoowhc7khkaG+VnJFXXVLz0sSjnVlJgQPZIRx+d3bpTV
 vC5xM0N0+owe9DjI/MA0Km3nwfay8G6V9oY0sC9hgg==
X-Google-Smtp-Source: APBJJlGSlWj16aqrnUmlV+OEYz7SPbcqkKC6IPrXDXjFMPzTVDRdpj9odiFEI6beDh/EYF2arxqDqQ==
X-Received: by 2002:a5d:6601:0:b0:314:10c1:881d with SMTP id
 n1-20020a5d6601000000b0031410c1881dmr9949103wru.68.1688927600623; 
 Sun, 09 Jul 2023 11:33:20 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 e17-20020a5d4e91000000b0031433760a92sm9635256wru.115.2023.07.09.11.33.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:33:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 26/45] accel/tcg: Introduce page_check_range_empty
Date: Sun,  9 Jul 2023 19:29:03 +0100
Message-Id: <20230709182934.309468-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x430.google.com
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

Examine the interval tree to validate that a region
has no existing mappings.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230707204054.8792-10-richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 12 ++++++++++++
 accel/tcg/user-exec.c  |  7 +++++++
 2 files changed, 19 insertions(+)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 472fe9ad9c..94f828b109 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -224,6 +224,18 @@ void page_set_flags(target_ulong start, target_ulong last, int flags);
 void page_reset_target_data(target_ulong start, target_ulong last);
 int page_check_range(target_ulong start, target_ulong len, int flags);
 
+/**
+ * page_check_range_empty:
+ * @start: first byte of range
+ * @last: last byte of range
+ * Context: holding mmap lock
+ *
+ * Return true if the entire range [@start, @last] is unmapped.
+ * The memory lock must be held so that the caller will can ensure
+ * the result stays true until a new mapping can be installed.
+ */
+bool page_check_range_empty(target_ulong start, target_ulong last);
+
 /**
  * page_get_target_data(address)
  * @address: guest virtual address
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index d95b875a6a..ab684a3ea2 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -598,6 +598,13 @@ int page_check_range(target_ulong start, target_ulong len, int flags)
     return ret;
 }
 
+bool page_check_range_empty(target_ulong start, target_ulong last)
+{
+    assert(last >= start);
+    assert_memory_lock();
+    return pageflags_find(start, last) == NULL;
+}
+
 void page_protect(tb_page_addr_t address)
 {
     PageFlagsNode *p;
-- 
2.34.1


