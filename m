Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DD8722028
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 09:52:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q650m-0002c6-3L; Mon, 05 Jun 2023 03:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1q650Y-0002b8-TL
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 03:52:09 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1q650R-0007V9-Ql
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 03:52:02 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-657c4bcad0bso319711b3a.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 00:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1685951516; x=1688543516;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qVDTZNdm9TYOhpUiRc7Gqz7STus9Q3p9Jgo6THKuDig=;
 b=U+v0ocTwgOLITQX/bRSBSxpEPQwXAq3ZqrcLRZfeopyS7OfJeehxYcnxbz/KldeXUS
 GCxzoQmRl2yyoqMsFa/bzkYrwYtt3y27OYFhNNqo9xCkxFxcs/0+mBsHEc1d/c8wGJD2
 4s8MdTILIH7Uv1Hmw4m6TRtbuqwLbu/oZz8d+ShYa3p1qyQr//H1Q0MUtMQTCPdZ+phY
 KbxPhnFyxYftxfveYUo5UzMPLwLAkazKqk9rIJRHexKqVQBW2QDSA/vJVxoYrNyaAI69
 Ohq3pKZjunTrCf6YXFlGLEmtwzsMQnbrUv/7P6xvU2/61GZPwvUOf5+rxWd4yE7wNsln
 k3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685951516; x=1688543516;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qVDTZNdm9TYOhpUiRc7Gqz7STus9Q3p9Jgo6THKuDig=;
 b=J1wC8jnZIIAYzrdIE6GdteihOae01ciGVCOxTgf2TOwuIFfA38O57QAcfdBRPFqyd5
 jQukjNdlx5FDNwpTWv6Np196vj8v9UvVJszx7BBQo5W9dxN38NWfruJU65ZNYiuEBA5w
 dgDMv6+et1NjcekUps5RbfiJBKbZ5kKR0tRUF2ONiM5j8DBwIL/oRoh7p6xS6Q7psy/n
 2wC16p6oikjdmtUAUlhMKIAhMknCDEoyVbAjflOQCM8adRGSokcFbfHhYYhFPHLMiCps
 qDMVBrK6++Kw/vDMs6FPu0lBQMUZtMVkYInhoIRzHG19ydFF0+TSyInF2creHktHKDUA
 pcrQ==
X-Gm-Message-State: AC+VfDzZnQls5Z5Lg6ux4CzmQNRZfTCp2Gw0NCpT4tG8xvQ53sibYr+a
 RLE2nzggYl+hOL4VTijB1gO6RA==
X-Google-Smtp-Source: ACHHUZ6hdoRY0HcYU3GqRU8yxLEi3ZGzJGXihoSIN2Nx3Kx9LLLmceyKpobgwBkcNxs1BFzByvqBCA==
X-Received: by 2002:a05:6a20:440d:b0:105:66d3:854d with SMTP id
 ce13-20020a056a20440d00b0010566d3854dmr21115476pzb.6.1685951516425; 
 Mon, 05 Jun 2023 00:51:56 -0700 (PDT)
Received: from saptrishi.. ([2405:201:d019:c279:7394:6066:fed1:a1d])
 by smtp.gmail.com with ESMTPSA id
 b10-20020a63cf4a000000b0050a0227a4bcsm5239366pgj.57.2023.06.05.00.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 00:51:56 -0700 (PDT)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Himanshu Chauhan <hchauhan@ventanamicro.com>
Subject: [PATCH] target/riscv: Smepmp: Return error when access permission not
 allowed in PMP
Date: Mon,  5 Jun 2023 13:21:50 +0530
Message-Id: <20230605075150.367555-1-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=hchauhan@ventanamicro.com; helo=mail-pf1-x42a.google.com
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

On an address match, skip checking for default permissions and return error
based on access defined in PMP configuration.

Fixes: 90b1fafce06 ("target/riscv: Smepmp: Skip applying default rules when address matches")
Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 target/riscv/pmp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 418738afd8..6238528282 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -435,8 +435,8 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
              * defined with PMP must be used. We shouldn't fallback on
              * finding default privileges.
              */
-            ret = true;
-            break;
+            ret = ((privs & *allowed_privs) == privs ? true : false);
+            goto _address_matched;
         }
     }
 
@@ -445,6 +445,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
         ret = pmp_hart_has_privs_default(env, privs, allowed_privs, mode);
     }
 
+ _address_matched:
     return ret;
 }
 
-- 
2.34.1


