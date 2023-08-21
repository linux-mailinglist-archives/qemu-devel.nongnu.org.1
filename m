Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7A0782E4B
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 18:23:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY7cp-0001jD-OR; Mon, 21 Aug 2023 12:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cQ-0001UY-W5
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:19:07 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cO-0005cP-HP
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:19:06 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bdc243d62bso20707575ad.3
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 09:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692634743; x=1693239543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m/tLt6CaJsWtmfAucUsswRTzLCX37AmxqBCjKQhyCi4=;
 b=ehAokeZtPiM/VMZkTTjopbJALWIlTO1Pt+Dh8O0CIM8jfuFAZ+04Rz/tViQkx8AeaI
 7mIB3hQ/78SKdfz9r5gwZQU8fFS4UELHCGjEzViQVO/tdqYO5PIU28SMWn2VbeQoU+Cb
 X8B/NLvCEnOuEvmiy7CjYv1hlzgiBlbPPKie2Rl38fD3Sb81uhA/KlLigoTAW6db8lNI
 H0HhXRUNmLzxOBoSx5riqaF96uMQLeERpaBJUu3GQ7Y8Qdyn+rlwjItYOIQtlqqowl+R
 DgXZYIJBRqVvUm3zaPR0ehZxoLQmW9kzXC0G4HaIETAqbBosfLDKSyZzUj5GzjcTU7E3
 q91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692634743; x=1693239543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m/tLt6CaJsWtmfAucUsswRTzLCX37AmxqBCjKQhyCi4=;
 b=ikV8/yOhf+g11TUPMuNIEwrjXsgqSfZN+1+iDWJD2A45FW+BAarEZ2eqsNQOlRdhlS
 adg/SxGAUC8uNNOJxY8i/Di7ANsdCNWDtz/ZlcSWiP8ZDeXC8F6xICovbE8SUzAbU1NX
 H4IvI6Z6jH7W4MEqKXA2ssm/H7jSUiO18KHa+o04PylOMFOWgkv8fNNXBr65HGIkte1j
 CrWWLZG9M0GN1PhUMTzcZC60avCuAAIKf6QRrpeXrKwABGlhX2c2fp/Vsw6EBUWgcNii
 E7TSQbkGiJGUeqdA0id4k5B7z+Ba9l/H/z8C2p9OmeufnBOEN9je3SMolRC1wm0AeXgM
 +qyw==
X-Gm-Message-State: AOJu0YxeIGF0By0yp6zA6uMuqpAbRKDPOyidfiLawnEwycIklHRAzrhu
 r3btuq74HzF07jB0Mc55FIQJQhd7tbBSTDtgH5M=
X-Google-Smtp-Source: AGHT+IHGzJkCStv5yeB1vugG5OhJupkkZFjnVYJcZOLgOAdWcRpWn3ShrtfFW0qSXcUL3SDq+KfbrQ==
X-Received: by 2002:a17:903:491:b0:1bd:ccee:8f26 with SMTP id
 jj17-20020a170903049100b001bdccee8f26mr4099677plb.15.1692634743161; 
 Mon, 21 Aug 2023 09:19:03 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:2c08:e710:4459:46f1])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a17090301d000b001ab2b4105ddsm7234549plh.60.2023.08.21.09.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 09:19:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH v3 08/19] target/ppc: Use clmul_16* routines
Date: Mon, 21 Aug 2023 09:18:42 -0700
Message-Id: <20230821161854.419893-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821161854.419893-1-richard.henderson@linaro.org>
References: <20230821161854.419893-1-richard.henderson@linaro.org>
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


