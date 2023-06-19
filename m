Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D6A73587E
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 15:27:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBEtR-0000Ry-3F; Mon, 19 Jun 2023 09:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBEtF-0000RS-UP
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 09:25:54 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBEtE-0007nA-D6
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 09:25:53 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9741caaf9d4so420943666b.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 06:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687181150; x=1689773150;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EzMr6N2DSG+x4yjs5VDDLx4neEvdpghxE9jkpPNpTyo=;
 b=gHToEPu2Z/siSiboNWwDUvVGiDszlXZcz0qTSpL72zggDnDOeY5e58OQxXWBsgs3ha
 V2DtSng+VDJ7N7IMiFS6p2Ae7PkdoEHJdLBq8EB5w/X/y7oeJ9oeygjlFoLnfaqEQu1l
 ZfJSeUoqzRCFyKQM6IO8GJ+m5h0mY0ABuApvUoxtDzfqm6kFVWq3T1UwM8It/Rvr88cv
 5wZ+yVX436eI3rV8LKHus6tGnV6fiWZAmqkEFIyN0w3EJ645y/xxHE9XfjovVx7Ero3+
 5lC/EoNUcN6AR+zVixuUeGSiY3BH4dD+Yoy5p2mv9XIvIKL59wJMIhg85yOqtYxUg6HJ
 2qoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687181150; x=1689773150;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EzMr6N2DSG+x4yjs5VDDLx4neEvdpghxE9jkpPNpTyo=;
 b=S9p9TJi/45bcySDNkeuacxAED3JXe/KWs/VIUx5/9ghPMQT+6Zcu/8tZIRGDVLCOav
 fCRggf99OE1ghvRGyKJP3xzKO7NWQUlOlKjENB/SIrfNSiuXGaWbrP55QBoXh7JSRaBi
 4wqXAOwVT1WSrJ8NxF4u0pfboBl78ZaHV+/WJ9qSwIlaWypj15eRBj9Rv39v7pZ70IrN
 m+wcq3ivAy49Hpid9/DbYkA4M5tULV7Dx9ENL0Q6n6/W83qjUmXgYZeLx5n5Xl92xyu3
 dXNfyl14J496u977+nYI6o2eiBT2xW13POi0LH9IFKBebG9vwWEyWEYIJ7wv/Od+Rgsy
 ifew==
X-Gm-Message-State: AC+VfDwvaIj1X041TulSnl36sTHb8w/DcqZ4yu1M5fFrb15CMhD/l3yZ
 gkZlGpESybeicOlpYIEPVEI3b9XiE/0fSiIFFtES35rD
X-Google-Smtp-Source: ACHHUZ640yG4JGi0WNtHkRWKN135ZPFolP+otvC2P/KbzzTRwHzUAhnUQge9n+v7e6TzyvFX4PiCHg==
X-Received: by 2002:a17:906:ef06:b0:961:be96:b0e7 with SMTP id
 f6-20020a170906ef0600b00961be96b0e7mr7160504ejs.48.1687181150554; 
 Mon, 19 Jun 2023 06:25:50 -0700 (PDT)
Received: from stoup.lan (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 f25-20020a1709062c5900b0098866a94f14sm2495315ejh.125.2023.06.19.06.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 06:25:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH] accel/tcg: Handle MO_ATOM_WITHIN16 in do_st16_leN
Date: Mon, 19 Jun 2023 15:25:48 +0200
Message-Id: <20230619132548.400875-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x630.google.com
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

Otherwise we hit the default assert not reached.
Handle it as MO_ATOM_NONE, because of size and misalignment.
We already handle this correctly in do_ld16_beN.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

Fixes an abort booting debian11 with -cpu max.

r~

---
 accel/tcg/cputlb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 5e2ca47243..14ce97c33b 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2727,6 +2727,7 @@ static uint64_t do_st16_leN(CPUArchState *env, MMULookupPageData *p,
          * and so neither is atomic.
          */
     case MO_ATOM_IFALIGN:
+    case MO_ATOM_WITHIN16:
     case MO_ATOM_NONE:
         stq_le_p(p->haddr, int128_getlo(val_le));
         return store_bytes_leN(p->haddr + 8, p->size - 8,
-- 
2.34.1


