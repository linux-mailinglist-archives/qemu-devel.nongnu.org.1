Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9BC711B10
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 02:25:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2LF9-0002We-Pg; Thu, 25 May 2023 20:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2LF7-0002UT-C8
 for qemu-devel@nongnu.org; Thu, 25 May 2023 20:23:41 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2LF4-00028Z-Mr
 for qemu-devel@nongnu.org; Thu, 25 May 2023 20:23:41 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5144a9c11c7so141619a12.2
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 17:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685060617; x=1687652617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=grxtGqzdDW3pij35DCIXzbwm/3Rbmj2aBugCYZSOGiE=;
 b=tvlUdHzCVoKaXX6W+KUro9LXb56GERYrvgfmOtyN/SPD7y5pi7t8KaitkKm+bDNYEl
 cj+DSCtXDMW70tVMoAEtEEmWQH960aPnid+TuoWwTdFcVc17ZzX36ELy+MYogEzb6/V4
 Z2YrhSB1uUl++RDQmLl9es9wb00sG1vcDroCSx1mayVdcvi00uAGqXYiBiaL105k1xLz
 Je8JxKVMBuvegTF+M2I9xRPcga1yp3xanjq9QppKmBIjkDu1bICFJPYrKuPLogyRJwqa
 iLXCX6j0r+zTygUFxem7kCzy5niP0P7r67R33HAgbryhkiLXt+bMrH7pkWNUcSjmTxbp
 SO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685060617; x=1687652617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=grxtGqzdDW3pij35DCIXzbwm/3Rbmj2aBugCYZSOGiE=;
 b=P9vaOXFMEbrH6gYVKVGDVEYh2izrdtvXbSINAIThY7meheeHFNJl25+b/w94ss1Rmo
 LbXPlWFOu7FMmCvBruFU2A5OvEZ37QAr6pSRCUo4MBN93lVXyYC1cIK+vG3WhjMmJ9ns
 rsTKGlaj8bKzGc4T34bOHnbGugeDoILFHgRMMwYdsHvyhlq730OaZ0pBo22H7v6ufDHx
 gK8PnW4uabcRk4FFwXmjQA+qM7K0ASSbD39GQapbtD8nz4fPwcArqJZEBZwrf0Qs5/6I
 WBG0ECodk+bp/ZxfOkzi1ZBw7nZuMPmPXx9XYgPKjSgW3J44WcFDrIhYj2QJponjyDdX
 h5EQ==
X-Gm-Message-State: AC+VfDxpO9MpFE1NCkWFioNZw5rzVV1NKNk6VL/cR5UW5MvDdCzJTfrz
 kGz+fgm4N6JeWHufgmf9b9Y8XWz7XlvmNljQjtg=
X-Google-Smtp-Source: ACHHUZ58Dq0/lxU51Lo27Ngqt0NEPFuGZwZ6IVcX1ybs5AO0//48mby5g9CK2J1HfmIk90sQ4mx9kw==
X-Received: by 2002:a05:6a20:7287:b0:10c:3cf3:ef7e with SMTP id
 o7-20020a056a20728700b0010c3cf3ef7emr14678608pzk.42.1685060617076; 
 Thu, 25 May 2023 17:23:37 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 s188-20020a635ec5000000b0053491d92b65sm1675593pgb.84.2023.05.25.17.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 17:23:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 02/16] accel/tcg: Fix check for page writeability in
 load_atomic16_or_exit
Date: Thu, 25 May 2023 17:23:20 -0700
Message-Id: <20230526002334.1760495-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526002334.1760495-1-richard.henderson@linaro.org>
References: <20230526002334.1760495-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

PAGE_WRITE is current writability, as modified by TB protection;
PAGE_WRITE_ORG is the original page writability.

Fixes: cdfac37be0d ("accel/tcg: Honor atomicity of loads")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/ldst_atomicity.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
index 0f6b3f8ab6..57163f5ca2 100644
--- a/accel/tcg/ldst_atomicity.c.inc
+++ b/accel/tcg/ldst_atomicity.c.inc
@@ -191,7 +191,7 @@ static Int128 load_atomic16_or_exit(CPUArchState *env, uintptr_t ra, void *pv)
      * another process, because the fallback start_exclusive solution
      * provides no protection across processes.
      */
-    if (!page_check_range(h2g(p), 16, PAGE_WRITE)) {
+    if (!page_check_range(h2g(p), 16, PAGE_WRITE_ORG)) {
         return *p;
     }
 #endif
-- 
2.34.1


