Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0C0781640
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 03:04:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXAML-0008Sg-Fi; Fri, 18 Aug 2023 21:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXAMI-0008Qw-Pm
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:02:30 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXAMG-0007Lz-JY
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:02:30 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bf1935f6c2so10615435ad.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 18:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692406947; x=1693011747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m/tLt6CaJsWtmfAucUsswRTzLCX37AmxqBCjKQhyCi4=;
 b=bNuLoAkMvsnk7IlF5GA67UzN/sLQwe5Mpxe9SIjU1F9mpw46gaCysXmsTmVYXCWXP8
 7BHZ9Crmq0DU6u4FTw/XYneQGMirkwXGhorTKEvs03efRPFkR8M6IwCC4jXf0JK9haMN
 RLOXKXr/comzzR4dp2nnxrONt5FAry34zXlihy7/Mmip2oQKN8IylOSqdadgftI718Sm
 0qkxkVZmokAioB6Y5PW9JGuzy2VWxZZLhJS0ksZV8q3ifGLiLFvvJKjGEME1bkR1NimU
 Bp5lzSivTHkXrDDyVx9xs/BS+RA7Z/p0P2F+eZa1jlxoJ3EhCPtBHZvHRghHULU7nlSJ
 9dVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692406947; x=1693011747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m/tLt6CaJsWtmfAucUsswRTzLCX37AmxqBCjKQhyCi4=;
 b=My/7vNv+ACl3ZCmVAznlWtswDHevJJeUqnONIjoUVxFMmqQ1hy3a4v1g8qUD1BIeiR
 cuU7JN1Em/fit/EOLS3j3l3RXdRvvGFxhhXFp6Th8RvPqe1ga5w375IXizUkB8OEjlwr
 c/Q5qKzohf5uja84mif1lsYE+H5FYTw88u94evzLIhHsz2aSRfmmzWbjNMODYTSNR0G7
 VbtLcwh1UFCPVwlVKe4w/o9VPIGRilVjnjCj6Ov6J9NC9KxtpJPKEpiTDLhEdSx+fU3/
 KgnRfEQrNAvnkohMTlvfqWOIws0HbkF9qtyvitSw+Bk52S7nv3JS22+ij5eZXvPDLJgV
 cZ0g==
X-Gm-Message-State: AOJu0YwKV+TgEBMmFxAWc2Xq86xJ2MIUjuoamPokGZQlEkOtzC7J1Tnz
 uM2H3QSplUb061AWj+GXnGX0gq0EzYfJDCbgxNo=
X-Google-Smtp-Source: AGHT+IFSL/G9Rhil57Mu0n73+7SEg7sd/+gIx6ciRHnSw64VNtZO749bJaxQJ2lqalb6fDwQjGr+8Q==
X-Received: by 2002:a17:902:e847:b0:1bc:7e37:e832 with SMTP id
 t7-20020a170902e84700b001bc7e37e832mr1257594plg.19.1692406947432; 
 Fri, 18 Aug 2023 18:02:27 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 b13-20020a170902d50d00b001b87bedcc6fsm2372019plg.93.2023.08.18.18.02.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 18:02:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH v2 08/18] target/ppc: Use clmul_16* routines
Date: Fri, 18 Aug 2023 18:02:08 -0700
Message-Id: <20230819010218.192706-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230819010218.192706-1-richard.henderson@linaro.org>
References: <20230819010218.192706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Use generic routines for 16-bit carry-less multiply.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/int_helper.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 343874863a..10e19d8c9b 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1438,6 +1438,14 @@ void helper_vpmsumb(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
     }
 }
 
+void helper_vpmsumh(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+{
+    for (int i = 0; i < 2; ++i) {
+        uint64_t aa = a->u64[i], bb = b->u64[i];
+        r->u64[i] = clmul_16x2_even(aa, bb) ^ clmul_16x2_odd(aa, bb);
+    }
+}
+
 #define PMSUM(name, srcfld, trgfld, trgtyp)                   \
 void helper_##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)  \
 {                                                             \
@@ -1458,7 +1466,6 @@ void helper_##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)  \
     }                                                         \
 }
 
-PMSUM(vpmsumh, u16, u32, uint32_t)
 PMSUM(vpmsumw, u32, u64, uint64_t)
 
 void helper_VPMSUMD(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
-- 
2.34.1


