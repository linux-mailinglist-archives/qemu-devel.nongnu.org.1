Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCEE81F808
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 13:07:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIp8t-0007Rx-3T; Thu, 28 Dec 2023 07:05:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rIp8o-0007QV-ED
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 07:05:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rIp8m-0007AF-OK
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 07:05:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703765130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=J90BPuxMSl79jNqcjlt+D3exX9raMG4xqYLeNSxbdVs=;
 b=dFTSRP3EoagGvIFDVurBZfEZKCikTONV2EUqNCv4tqSpI8pn4/Kb6LV5OGoMm1rbmWewrt
 OUNvaRpV8PgsZccptl355T9NEw1O7CS1zM4nms8XKqhui835nihQXhMQUWyJYO1hSFnzer
 yFYA6ZQJztPVw+Uzydp1oQjyVBhZ7A4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423--LJYpxiGP06fw88vjtsaow-1; Thu, 28 Dec 2023 07:05:29 -0500
X-MC-Unique: -LJYpxiGP06fw88vjtsaow-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a018014e8e5so319440766b.2
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 04:05:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703765127; x=1704369927;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J90BPuxMSl79jNqcjlt+D3exX9raMG4xqYLeNSxbdVs=;
 b=FQsz7s3IM1qxJm8OC58TkQ+iqAIdCUMcNJHNlTkaq6dywG6VOd70CSYhvxNBpxgzC2
 sMcwJ7SOaUSri+I39TZT5/ppMJU4286SmGZ5ipxHK3KjUU8n5DbYmlfamQRt/q1gQIK8
 Hu67nPrOB/h63l3CWcutOk6wRnGC5nHRTKMiDBzGFt4zkK11/mOLrDHPiETtEpDMrtyn
 vzDHYngHiuOE49sZEEOnUy1pkfrJFPF8nynj+/KQt9hvtuZD0Yd7qw1+/+YKMXc8cYWB
 xU2tSb2fHhmBU6BTQOT1dGI3riv0ERZo9T+qvlfKpxNRrdlRP00KrJ3tN6A+Pj611lv7
 MzPw==
X-Gm-Message-State: AOJu0YyDxn1jVGH+HnKBr9LTpGueorpbOamVyMqX/uv0crKTnpQUsx3/
 o1XsSIWFzip1M2kc8+KvprkR77IMpAHtFp+NGCDqzVZkO/siCTkaEtw7lETFJcdm/mvsK5LUn9j
 v0oR24q6znO+pw0iBzTb751BwCntVoxJIOVTgCZ2wQBCwldgjE8r9QGRq1Sowmu1i5fNr6tuEeA
 kUiWPA7B4=
X-Received: by 2002:a17:906:73c7:b0:a26:97fe:b8cc with SMTP id
 n7-20020a17090673c700b00a2697feb8ccmr5088593ejl.66.1703765127120; 
 Thu, 28 Dec 2023 04:05:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmxOpbpwqKTsH1PQLZXymRQxnVp3ElT2zH/rlER06+D4CTnb3HQeQwkOAs0ls+GEa+Ml9Rqg==
X-Received: by 2002:a17:906:73c7:b0:a26:97fe:b8cc with SMTP id
 n7-20020a17090673c700b00a2697feb8ccmr5088586ejl.66.1703765126790; 
 Thu, 28 Dec 2023 04:05:26 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 vp16-20020a17090712d000b00a26f6b420b6sm3202721ejb.88.2023.12.28.04.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 04:05:26 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH] tcg/i386: use 8-bit OR or XOR for unsigned 8-bit immediates
Date: Thu, 28 Dec 2023 13:05:24 +0100
Message-ID: <20231228120524.70239-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.755,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

In the case where OR or XOR has an 8-bit immediate between 128 and 255, we can
operate on a low-byte register and shorten the output by two or three bytes
(two if a prefix byte is needed for REX.B).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tcg/i386/tcg-target.c.inc | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 1791b959738..a24a23f43b1 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -244,6 +244,7 @@ static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
 #define P_VEXL          0x80000         /* Set VEX.L = 1 */
 #define P_EVEX          0x100000        /* Requires EVEX encoding */
 
+#define OPC_ARITH_EbIb	(0x80)
 #define OPC_ARITH_EvIz	(0x81)
 #define OPC_ARITH_EvIb	(0x83)
 #define OPC_ARITH_GvEv	(0x03)		/* ... plus (ARITH_FOO << 3) */
@@ -1366,6 +1367,12 @@ static void tgen_arithi(TCGContext *s, int c, int r0,
         tcg_out8(s, val);
         return;
     }
+    if (val == (uint8_t)val && (c == ARITH_OR || c == ARITH_XOR) &&
+        (r0 < 4 || TCG_TARGET_REG_BITS == 64)) {
+        tcg_out_modrm(s, OPC_ARITH_EbIb + P_REXB_RM, c, r0);
+        tcg_out8(s, val);
+        return;
+    }
     if (rexw == 0 || val == (int32_t)val) {
         tcg_out_modrm(s, OPC_ARITH_EvIz + rexw, c, r0);
         tcg_out32(s, val);
-- 
2.43.0


