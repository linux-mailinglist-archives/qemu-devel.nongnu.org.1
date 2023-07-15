Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CD0754911
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 16:00:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKflf-00018A-OT; Sat, 15 Jul 2023 09:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKflV-00012Q-La
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:56:54 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKflU-0003Sv-26
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:56:53 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57ddso26493365e9.1
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 06:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689429410; x=1692021410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+u+6sqOJ5iK1/8L4kug7OWcFShgptBBIOzAjdLQUcYU=;
 b=DPBwGA4ccsQTRo8BKtrDj302fkjletRdaai5a2Xo4Hpu2BFUOKCnGiOTazMZlDIyLR
 pmP8N/Uu15QenSIZKpUPw5B7xZkvy2opUk1lPLDwk+SW+Lr7sFwd7Of/pSLSnK8Dmq3I
 HK4pMOtVI6l20fkfk0rra2NA4Tj6kW8Na6IhwOlwQtdryNMx/fnwWVWdDIwEMmDETtWD
 e6WZvpK04VaLeF+fCdc/1C3sQ2UX9P8BpzNxI6wpK9OYZ8y9Fr2Ubh3bIUwZnZLBkfUg
 tdl5h/gJWYMgH49sPzxpyFYM4YI2oB9SRF/j//+9I2gKlKJvX3gJ951ECj1q6/h6O2Qq
 jURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689429410; x=1692021410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+u+6sqOJ5iK1/8L4kug7OWcFShgptBBIOzAjdLQUcYU=;
 b=kG9CqRvkds/8EDeiU7H4e64lJYe/yIkqpkH/r8qYQt2sVmMwXn7rXvwCze+tpyLB8l
 +hfVwBAIce4uni1/EMzw9jHQE/yE4/jY3mDDCQZMwj+LwW2Vw84MTWLBT8PCeMfK5RKL
 S0mN9EFmoKw/TCTxApKR6MNV3KQ4EPKsLhB5FeTCPvCnBygHQMoniQVjNWVFHITh4pex
 FjMQawslemN4qDOK4fVRRR/+7Tl6Fw7jiWv3E4n6D9AD+aqmAOm+H02j6N8DjnmnXVlA
 FcZ1mWR+g2viHK3WPwK4O7cx8dLjF5XTFA0r6uPed7fZePOiWDR5BTBn8xM3IPtiw+d0
 fgFg==
X-Gm-Message-State: ABy/qLbnKoJMYJbozpxAQD+3K08oi0W0MC0Le0jYgmXri/qwWtIsGD9x
 Ovqv/w1l4JeeZ0QwxILqWJsDBqwt6/H1Qvqmr5QueQ==
X-Google-Smtp-Source: APBJJlF0J090zJ6FPOkKfDl6oAnXAZBCmSz+XhRYdeDPQqGdFhWF223528Dv8JwZL25+extDZBKSsg==
X-Received: by 2002:adf:dcca:0:b0:313:ed1d:39d5 with SMTP id
 x10-20020adfdcca000000b00313ed1d39d5mr5749577wrm.35.1689429410475; 
 Sat, 15 Jul 2023 06:56:50 -0700 (PDT)
Received: from stoup.lan ([51.219.12.49]) by smtp.gmail.com with ESMTPSA id
 r8-20020a056000014800b0030fa3567541sm13866651wrx.48.2023.07.15.06.56.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 06:56:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 40/47] accel/tcg: Accept more page flags in page_check_range
Date: Sat, 15 Jul 2023 14:53:10 +0100
Message-Id: <20230715135317.7219-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715135317.7219-1-richard.henderson@linaro.org>
References: <20230715135317.7219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230707204054.8792-24-richard.henderson@linaro.org>
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


