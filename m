Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 639DB770B12
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 23:35:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS2Qy-0006D8-CB; Fri, 04 Aug 2023 17:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2Qw-00068v-6E
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 17:34:06 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2Qs-0001tc-Bi
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 17:34:05 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1b8ad907ba4so18837775ad.0
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 14:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691184841; x=1691789641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Fc9S/4//cSOxgnGncfnlKz99u+sNj+6+KTbB1MnhPw=;
 b=oUaIpjejqdzmuP86aDHlYPIHgrWZMee6PPPn/Ysd7pmrSF52MtItcdD99Rl+nhK1Ol
 NafmdX7KW9ntMJ2u+Q2kcA7JDdcdc14z8FGEuFpN2NLei6hOUyYk/dgCrRowD5kOuFPY
 T2fAce3PmE48cJh8yAofIOgfGepT5DJGdbUgEVohwJsrVw5Dp14WD5E4HTUncwXTX8Is
 le03ss8WxuBOCGIbG1EEasaNjZ4hMSlIavrd0uGenSBn5JqxHC9ZBAAFIr3Xr2ktg9UP
 cHEIUOngYRa0YAyibqtPUqTkjmQvJhRYgDDhqCyAPj2WMWFylV4EIJ7HgQH18CkwO+wF
 lIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691184841; x=1691789641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Fc9S/4//cSOxgnGncfnlKz99u+sNj+6+KTbB1MnhPw=;
 b=ECIgux1tpMAGqL6uzqtWyTAmWd/z/IPDJDNbOJfGnhj86xVRvEstmxhgTFfjISrEEX
 3aAdbVM5T7To7XVFrSN62hK/+fo2RsaV5fyymVOWO0jGHUrcDQbiUdc3ZI2OdH6ngFl5
 j/MeTE7Z5Od2VcBNrFee6CY6JYORfcWixoGSTrcHhUr16Vw6DSOzNr1yZkcA1pQQu/Aj
 JBCvL2N//5KLRvk/EmODI06JTByeFBOr8bL2pq0PcTf3NHjndNwVFlCyyZg1y8yFdcAn
 lrd0bLBEaAVpPL1bsqI+1WndCzaK/xknrjHkUhVfIRUvsGrNFlrEeXNy7VoY+WhsUyA6
 se4Q==
X-Gm-Message-State: AOJu0YxY6lNJzGb3ccqKer32WsNkLfUyru5+noct+7cjU0FxdpYAzdyT
 0VMVGPTQHOrDKO0eCgXmqyH8OYagLfzrjN+gNos=
X-Google-Smtp-Source: AGHT+IGIMBqq+Yai/eaHupCc3Rt1bDka2dKclE2uws8O5+2Xa7VHXDx1oG95yfzoKSXRMLaEY4h2FA==
X-Received: by 2002:a17:902:ef8d:b0:1bb:7927:c1ab with SMTP id
 iz13-20020a170902ef8d00b001bb7927c1abmr2533889plb.48.1691184840883; 
 Fri, 04 Aug 2023 14:34:00 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001ae0152d280sm2188662plg.193.2023.08.04.14.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 14:34:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: jniethe5@gmail.com,
	qemu-ppc@nongnu.org,
	bgray@linux.ibm.com
Subject: [PATCH 5/7] tcg/ppc: Use prefixed instructions in tcg_out_dupi_vec
Date: Fri,  4 Aug 2023 14:33:53 -0700
Message-Id: <20230804213355.294443-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804213355.294443-1-richard.henderson@linaro.org>
References: <20230804213355.294443-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

The prefixed instructions have a pc-relative form to use here.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index a9e48a51c8..e8eced7cf3 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -1191,6 +1191,18 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
     /*
      * Otherwise we must load the value from the constant pool.
      */
+
+    if (have_isa_3_10) {
+        if (type == TCG_TYPE_V64) {
+            tcg_out_8ls_d(s, PLXSD, ret & 31, 0, 0, 1);
+            new_pool_label(s, val, R_PPC64_PCREL34, s->code_ptr - 2, 0);
+        } else {
+            tcg_out_8ls_d(s, PLXV, ret & 31, 0, 0, 1);
+            new_pool_l2(s, R_PPC64_PCREL34, s->code_ptr - 2, 0, val, val);
+        }
+        return;
+    }
+
     if (USE_REG_TB) {
         rel = R_PPC_ADDR16;
         add = tcg_tbrel_diff(s, NULL);
-- 
2.34.1


