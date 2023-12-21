Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F7681B851
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 14:44:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGJLI-0005pT-RP; Thu, 21 Dec 2023 08:44:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGJLH-0005pK-DK
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 08:44:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGJLF-0007Ch-Vg
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 08:44:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703166240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JpkyJJq7oTwrPtWtR69ASiNFzLqvTbP7ciMS6rApFwA=;
 b=Rp/yg4p4YokQ9NnoMBSUvfodLyRxBuZgaPn/hgUZSuN2T5lqTPDaDkf0ZTh8GWayuLYiW3
 AU6eSFcd0kaooMKQn4a5UQITG1hD3tmhjlBoUvZyUCdG684TLQCS3HUXIedo9/j5qhLBCU
 7+t6Rj8MWfDI1ZG6WXySaeIQcV+Z7N4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-gnTNQN66MeC0BrnRTjUp2A-1; Thu, 21 Dec 2023 08:43:59 -0500
X-MC-Unique: gnTNQN66MeC0BrnRTjUp2A-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3368698f0caso503942f8f.1
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 05:43:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703166237; x=1703771037;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JpkyJJq7oTwrPtWtR69ASiNFzLqvTbP7ciMS6rApFwA=;
 b=EcV2shujGsyIv2ET1VCUYiZ3IJdWYV1SXL97C9+gGA+TXdKmvciwoLKYhlMwfnb2i4
 lvgdgdyAA/LJJQTMQ4GIsROCXbtP18ffCNiRqnf11KEjP0cW9+49o68B+68SBMD593WW
 Ffiek413aLD7p9oN/YJp4fw9cCYmGGraoSpaY07I91Ny8U1y03Lq4Akj7LQ2uRZRYw5p
 dv57TvC/JYgZeqTYEx8ZyT0u6B8FzhWZr02bKfGpOmX+kS4cQvjJBSVQtkV4jsnKP/G0
 4xfs1+iAkgKENIvPl62jClVOFwBMIxwclHyrX98r/vfdpkiEWjKsQvdHLE3wCSQZl0vm
 cADA==
X-Gm-Message-State: AOJu0Yw0z3zt6nukOz42UKzm+SSm+ok1Lm0TU8bzWGc5Gso+ODDtTMpx
 SJNVk0JV//qAlm9Nuut0qHOBFLbrl6bMet1Og/j3gPI6/0l+sVSJCV8I7xHP9rp5rRJj3IH7mmC
 H5VtGceq2b5NQ6yURYljCX9g0b/04fjemLKdHzPig8QUaqvzD+V2NFnvKTVjLtY7pyyyCA8SnwJ
 M=
X-Received: by 2002:a5d:4989:0:b0:336:4e1d:bff1 with SMTP id
 r9-20020a5d4989000000b003364e1dbff1mr383708wrq.180.1703166237634; 
 Thu, 21 Dec 2023 05:43:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgMNm6sJUY18qTEwhXnEtDB7+1BzB6/bm82ybrRV/eMREqYhTshg35a3S4qfyVF1u2EHz0NA==
X-Received: by 2002:a5d:4989:0:b0:336:4e1d:bff1 with SMTP id
 r9-20020a5d4989000000b003364e1dbff1mr383703wrq.180.1703166237228; 
 Thu, 21 Dec 2023 05:43:57 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a5d49d2000000b00336751cd4ebsm2070022wrs.72.2023.12.21.05.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 05:43:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH] tcg/i386: convert add/sub of 128 to sub/add of -128
Date: Thu, 21 Dec 2023 14:43:55 +0100
Message-ID: <20231221134355.35304-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tcg/i386/tcg-target.c.inc | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index a83f8aab304..4e9f372d4fd 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1332,7 +1332,11 @@ static void tgen_arithi(TCGContext *s, int c, int r0,
         return;
     }
 
-    if (c == ARITH_AND) {
+    if ((c == ARITH_ADD || c == ARITH_SUB) && val == 128) {
+        /* Facilitate using an 8-bit immediate.  */
+        c ^= ARITH_ADD ^ ARITH_SUB;
+	val = -128;
+    } else if (c == ARITH_AND) {
         if (TCG_TARGET_REG_BITS == 64) {
             if (val == 0xffffffffu) {
                 tcg_out_ext32u(s, r0, r0);
-- 
2.43.0


