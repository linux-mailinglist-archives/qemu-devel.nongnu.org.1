Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D718D833733
	for <lists+qemu-devel@lfdr.de>; Sun, 21 Jan 2024 01:22:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRLaB-0002Vl-P7; Sat, 20 Jan 2024 19:21:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rRLaA-0002VV-8l
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 19:21:02 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rRLa8-0007NJ-Ll
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 19:21:02 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2907a17fa34so321870a91.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jan 2024 16:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705796459; x=1706401259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0EKsORzhcd/voY/5GCXD+0ZH5a0YI/B7BiYyHrdge+w=;
 b=nqalHe+rh82CZBZ1Z/S67KA8JIcjQHp7CLdyJwb1G8HPF6tCcI1DF+Hnv2uyRe8gNu
 q7ggjET41HzG9uutAQKUzdacn9s9CMBTOf4NBXdbe5mv8m5uSC0m+u9JVBDf8WWkdqa+
 zYV6+fFJoQancPRxF50YJjWHBjD+4ev1Zk5KuhS0xxTJsYbn/VBpfV53DTYOHoltzBBK
 vJbVmBR3f8UOHj8vujYo6YbL77yG7mldXfCMa8JDDMzmcfw5VIf77KTAfr6Vcf/XZtR8
 7Te/gFg+bTdjp5i9tcti2qgrdVT5RblfsfMvdo/OqoXsRWHQwPaDKxqhxNOshaGgvHS9
 Gp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705796459; x=1706401259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0EKsORzhcd/voY/5GCXD+0ZH5a0YI/B7BiYyHrdge+w=;
 b=wriyRuX0FdbwcvFLiL4zV1IYrFVys44JzojlCpzcg2F2jLy6vdct4pYGjlpJfsrqzu
 btfh/udgvYsj/xRyV7A6PcCAh3OZXPJ1Oqe9BuTnQH2ZgPzk7f/EIqdhNHqpPzsy853C
 6Cy/PeosrPLN+nlC8VxtZmVwI2bqaMxjf++Q2847Fi+6ImRHjEpz20JtuAPkTO7yOrTW
 3n2PQzrcXe8xoqVVwVJ576/Dv14daLLYKUwJuHAtn3MGV/iq58DcKdooKIBK4QokcmfG
 wQhEpHnsUIg+8/yMocYfNqoH9kGLphPv/VkrOLGrgHOff5WDOpQfZtfoYbouQ6Fm5x0s
 jVog==
X-Gm-Message-State: AOJu0Yw7GapxQbnG9IL5bVA8tXMWQu+sbCVkZA9TitwNv0yUK77EOxvG
 uqY3HjA2zz9aFakXvzPiJ6dUVgC8dbEPVfebyDmRUMsWU51IGo4oYi3BK6xBmLG56qHfxHDlwGY
 CwKI=
X-Google-Smtp-Source: AGHT+IGEiQ4B14hNvlpyw9JSKxin1v4woTMUnTOj3vv4/El2Y/RUz+bQsELjUyQ4YC+2WvPborCYaw==
X-Received: by 2002:a17:902:7601:b0:1d7:4821:b567 with SMTP id
 k1-20020a170902760100b001d74821b567mr151074pll.139.1705796459447; 
 Sat, 20 Jan 2024 16:20:59 -0800 (PST)
Received: from stoup.net ([2001:8004:5170:1e39:1361:3840:4873:7990])
 by smtp.gmail.com with ESMTPSA id
 j4-20020a17090276c400b001d5af7fbda0sm5023546plt.122.2024.01.20.16.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jan 2024 16:20:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Samuel Tardieu <sam@rfc1149.net>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 2/8] tcg: Make the cleanup-on-error path unique
Date: Sun, 21 Jan 2024 11:20:41 +1100
Message-Id: <20240121002047.89234-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240121002047.89234-1-richard.henderson@linaro.org>
References: <20240121002047.89234-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

From: Samuel Tardieu <sam@rfc1149.net>

By calling `error_setg_errno()` before jumping to the cleanup-on-error
path at the `fail` label, the cleanup path is clearer.

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20231219182212.455952-3-sam@rfc1149.net>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/region.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tcg/region.c b/tcg/region.c
index 467e51cf6f..478ec051c4 100644
--- a/tcg/region.c
+++ b/tcg/region.c
@@ -584,7 +584,9 @@ static int alloc_code_gen_buffer_splitwx_memfd(size_t size, Error **errp)
 
     buf_rx = mmap(NULL, size, host_prot_read_exec(), MAP_SHARED, fd, 0);
     if (buf_rx == MAP_FAILED) {
-        goto fail_rx;
+        error_setg_errno(errp, errno,
+                         "failed to map shared memory for execute");
+        goto fail;
     }
 
     close(fd);
@@ -594,8 +596,6 @@ static int alloc_code_gen_buffer_splitwx_memfd(size_t size, Error **errp)
 
     return PROT_READ | PROT_WRITE;
 
- fail_rx:
-    error_setg_errno(errp, errno, "failed to map shared memory for execute");
  fail:
     /* buf_rx is always equal to MAP_FAILED here and does not require cleanup */
     if (buf_rw) {
-- 
2.34.1


