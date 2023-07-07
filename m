Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A9074B828
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 22:41:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHsGd-00051L-5w; Fri, 07 Jul 2023 16:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGQ-0004qj-Ju
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:15 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGO-0004sS-S3
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:14 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3142860734aso3084824f8f.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 13:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688762471; x=1691354471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JtsN07dASo7micW3VRbXtJ/m5hRykEBCvqHdibzbQc0=;
 b=nBqXifMhdGILcAes+j/eTy+FIfY532P8+LxZ1PoQK5tgqgoePheTFCLqCfrR0ahtyC
 IWt8pu7MTq4G7qAZLBVeYpO7OnGapoP+cYDdXoi4vCMYohT9PprRvvetnaG5RKBU69gJ
 YMltMsKZ7RWcd4QRW+geGyut58iG4oApj/V1GHA7HH1yd9vzmXbGUgpzW9QSl5D2t5bA
 UiK5qv3mIGCxDh1lgRujaaKm+HWFAMwCn5vPpVqkH9j8mVOLjGkuWm/Sv5ZoOnOfuggh
 cpJAuD9MmOWLGhw5xx2Do42b22uj83y999oSR1c4sEzchueRnC5y4kvwHrDlHK3SRBtW
 PerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688762471; x=1691354471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JtsN07dASo7micW3VRbXtJ/m5hRykEBCvqHdibzbQc0=;
 b=TPF5R2d1nKeC5joC9yB4GlLSBCgPtHwgBwg96w23vWRFvaQD18ev6ZzeSwsr7cfYTh
 obgydSFM45dIkyc7Qdb7Ek8JlwqgT2ZkmLUnp74WiZcJYTk484k0YWGy7qkT/5V9IabU
 3PLfayygcnL/qAJ6OUp2ZtxTmA/WBSUC5v+WH17gDaKe01GPiLo7+7te99hFvON/zYMP
 YQWPrmC13t/WT/QpBlbbnV2zyBml3j6DxsTI0yU1YnCLAlewnWd9ZiBDoMg6d0UTSJ+q
 aC/txU+mAPAqIM++nDhHGSWOQpUE2x+oAhnEVQxAncP3noY6UuaCGDMpirwmOcBDFPdq
 zf4w==
X-Gm-Message-State: ABy/qLaLBUb93/dvL1d9Fyw7RjM/a22LXkC4715+1SeNsWirmUWLDKLt
 j/AGcD/HnTj8TQ+V5sA9p+EF/aXnPavna6nVpaQm9w==
X-Google-Smtp-Source: APBJJlHTul5ZwuMZ1GYWJlO4JgpKesVJ8Y3YcQDB8bdwDmsdMIQXPY5R0gkC6GPduj/xmrEoFt0MWw==
X-Received: by 2002:a5d:58c5:0:b0:314:385d:3f32 with SMTP id
 o5-20020a5d58c5000000b00314385d3f32mr9418621wrf.29.1688762471193; 
 Fri, 07 Jul 2023 13:41:11 -0700 (PDT)
Received: from localhost.localdomain (host-92-23-208-66.as13285.net.
 [92.23.208.66]) by smtp.gmail.com with ESMTPSA id
 q10-20020a1ce90a000000b003fbb25da65bsm3337736wmc.30.2023.07.07.13.41.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 13:41:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	mjt@tls.msk.ru
Subject: [PATCH v2 21/24] accel/tcg: Accept more page flags in page_check_range
Date: Fri,  7 Jul 2023 21:40:51 +0100
Message-Id: <20230707204054.8792-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707204054.8792-1-richard.henderson@linaro.org>
References: <20230707204054.8792-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x435.google.com
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

Only PAGE_WRITE needs special attention, all others can be
handled as we do for PAGE_READ.  Adjust the mask.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/user-exec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index e4f9563730..1e8fcaf6b0 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -561,8 +561,8 @@ int page_check_range(target_ulong start, target_ulong len, int flags)
         }
 
         missing = flags & ~p->flags;
-        if (missing & PAGE_READ) {
-            ret = -1; /* page not readable */
+        if (missing & ~PAGE_WRITE) {
+            ret = -1; /* page doesn't match */
             break;
         }
         if (missing & PAGE_WRITE) {
-- 
2.34.1


