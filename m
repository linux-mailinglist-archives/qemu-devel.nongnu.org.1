Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39295838BAD
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 11:25:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSDxD-0000NH-99; Tue, 23 Jan 2024 05:24:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSDxC-0000N7-4m
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 05:24:26 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSDxA-0004cc-KL
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 05:24:25 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6db0fdd2b8fso1963398b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 02:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706005463; x=1706610263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0EKsORzhcd/voY/5GCXD+0ZH5a0YI/B7BiYyHrdge+w=;
 b=yxQu3ZyMZCaD2wAE7x4g9Egl2XymqzQr4qaoPXv/KHXEsja4m1QApaZ7pTEcdOFUPV
 wYl2naZkkOsgMB2nYiEJsNYr2OCZYGU4k7VqPeU00Y/RbTfwSns6R8ADYqA7w2BbsAXa
 Y/jYOnF30P0+R+I1Uk5x2G2Nr1KsaS600DJPgXLVLkURViBPZ4T+bTsVRpDWDsAHmoWF
 tPXPjjVCJ4dWXn1x3RcAVjq3burNX9NR6yGgvbxpC0kGRE4JmKrJCQAjmOoKtalboj3T
 hPDvWEjWbFAPRseX43KlL5ENeM/dyaVkTQgDM2K1nZhTnrxfCsZKAw4jPJlimsIlWjuy
 l1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706005463; x=1706610263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0EKsORzhcd/voY/5GCXD+0ZH5a0YI/B7BiYyHrdge+w=;
 b=f3kNjJLRv0SCHR5PZvfT9cK6x3MRHMNWf20ZCBOGYpganuzRN5nPC6JemI0HPYyPHO
 RJuLQam/ZkiA69JyBGS8gCRQIGuaY7hSKRTGyceNAWB6BB2akVKEaiyMYHY25G32+Tgb
 va9PA63UEMlA/FPWQ8B7qz/XlXhM6xtRK09PWY73Sy6/HzMdMYK/uggg/XrP9enTjnml
 v3KBkFlNIzwBpejwE9iALhhjoP9r4FPDTE+ms7ckooOb0OJJg921StnuC/eg1+0mprTv
 ALgqfS4LI9P7PGaE9IDVgKbFIM4+/PhbZyMB+/c+UzLlQyWvonzKvtXuM1D8gvpzBo+o
 wN2A==
X-Gm-Message-State: AOJu0Yz28xISiPtgIfuyNrVagV19oNI2wjI+amUE9qcvzxG/I0ZU15FV
 x6L3Mo11QW9vo4Sc4qL43FTOxWFDUHRAG/eXFPaErfpw7KXbOEBVHMZZ0h3+9u59nt7VtOiOEVf
 7N6k=
X-Google-Smtp-Source: AGHT+IFVTClaWd5fhBg8HC90hAnk276sCKk+j1+k7kVc3nWjf/DSMmUoWL0krVP9DDTZbsn9Zmvi0Q==
X-Received: by 2002:a05:6a00:9281:b0:6dd:7ae5:9dd9 with SMTP id
 jw1-20020a056a00928100b006dd7ae59dd9mr487508pfb.3.1706005463234; 
 Tue, 23 Jan 2024 02:24:23 -0800 (PST)
Received: from stoup.lan
 (2001-44b8-2176-c800-b8a0-0408-58be-7d2e.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:b8a0:408:58be:7d2e])
 by smtp.gmail.com with ESMTPSA id
 d8-20020a62f808000000b006d9ce7d3258sm11072408pfh.204.2024.01.23.02.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 02:24:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Samuel Tardieu <sam@rfc1149.net>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 2/8] tcg: Make the cleanup-on-error path unique
Date: Tue, 23 Jan 2024 20:24:06 +1000
Message-Id: <20240123102412.4569-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123102412.4569-1-richard.henderson@linaro.org>
References: <20240123102412.4569-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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


