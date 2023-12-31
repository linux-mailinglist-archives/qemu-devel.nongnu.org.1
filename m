Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3820F820A93
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:52:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrRn-00049X-HR; Sun, 31 Dec 2023 03:45:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrRd-00048I-GR
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:45:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrRc-0000ay-3k
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:45:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=577ehjCa3CYZDGELm5IMyoPCHuxXEQQPas4m9OQeLVs=;
 b=XBCwRcC8usGVaCASeiqf4Hh3Gxy9TbFNAyH175GCkIDvEfn/bYuzxYKmMIjcegmGstqkTW
 KOKqRYkq9maoD152u3ORSrNx0EUiZUP5VQMpCVuqj/BOjbOOnBnSQU1Un//TIeH3LvPQsV
 2/YBXoXFidYH+N9TbLI71X0JTMeQl0U=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-noi50e25MS2FUv3qvDz-oQ-1; Sun, 31 Dec 2023 03:45:13 -0500
X-MC-Unique: noi50e25MS2FUv3qvDz-oQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-554a4d7390cso3161646a12.3
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:45:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012311; x=1704617111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=577ehjCa3CYZDGELm5IMyoPCHuxXEQQPas4m9OQeLVs=;
 b=Oo3Q0n/hnYTRZLTUaBPxpwL2P+bTtilUWbim+NWG/s/3oyywaqZl2DER4R+tOPrwhy
 yZf4obYwGS7nCzkEeg6VFyaN5Zi+ck+w5My+Nyw5Le3QFyvadYRTDkPiOR6uhb/V7Rxq
 T7z1DjEDYdvnlg6xenlCSjJq11BmZOs7iOP24/gI2gecwydB8ky/wibjjGw1Vt+WSVxB
 ZEDE2Mqt6e+h42YFh4+ESaNrn3HxqIIgI78EbhqujTWsiV8mgDkKGKKp4vunza2gzvQZ
 ApnUzhzTN2TTMk5W1FebQQPdI8Ul2yvXHTpX8rSj/E0K9oj2j3XbNr9zTAMrvNEK++3C
 /VZA==
X-Gm-Message-State: AOJu0YxXwDI+i3BIi3CAMmr29vyQlXw8pTqAK5I6f/L2rBofYE8hi64M
 O1awL/ptPFpEuTltDHcYEtcw3SCZZRWoXjG8QLqGRUF9tSNQhSepDtdqLwDpqL2TY/zDOudoF9R
 vGQ5nZlGghOLf8V0vKxhJDtbOMiBk/j3oFmea+/FWWF7wrS1f0ZINVrTpYjbRY5STwWd44KjmYR
 r9hAtdlOo=
X-Received: by 2002:a50:954f:0:b0:552:809e:5a9 with SMTP id
 v15-20020a50954f000000b00552809e05a9mr5569784eda.0.1704012311410; 
 Sun, 31 Dec 2023 00:45:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbiiT6Iig3Z1xunqewtttQ1pg4He80Lhz9KR0je6gNXBkahgsxENoUZID8rVUWnj5czdPK0A==
X-Received: by 2002:a50:954f:0:b0:552:809e:5a9 with SMTP id
 v15-20020a50954f000000b00552809e05a9mr5569781eda.0.1704012311006; 
 Sun, 31 Dec 2023 00:45:11 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 x7-20020a50ba87000000b005527cfaa2dfsm13676541ede.49.2023.12.31.00.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:45:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 02/46] target/i386: optimize computation of JL and JLE from
 flags
Date: Sun, 31 Dec 2023 09:44:18 +0100
Message-ID: <20231231084502.235366-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231084502.235366-1-pbonzini@redhat.com>
References: <20231231084502.235366-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
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

Take advantage of the fact that there can be no 1 bits between SF and OF.
If they were adjacent, you could sum SF and get a carry only if SF was
already set.  Then the value of OF in the sum is the XOR of OF itself,
the carry (which is SF) and 0 (the value of the OF bit in the addend):
this is OF^SF exactly.

Because OF and SF are not adjacent, just place more 1 bits to the
left so that the carry propagates, which means summing CC_O - CC_S.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 037bc47e7c2..8fb80011a22 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1126,10 +1126,9 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
             if (reg == cpu_cc_src) {
                 reg = s->tmp0;
             }
-            tcg_gen_shri_tl(reg, cpu_cc_src, 4); /* CC_O -> CC_S */
-            tcg_gen_xor_tl(reg, reg, cpu_cc_src);
+            tcg_gen_addi_tl(reg, cpu_cc_src, CC_O - CC_S);
             cc = (CCPrepare) { .cond = TCG_COND_NE, .reg = reg,
-                               .mask = CC_S };
+                               .mask = CC_O };
             break;
         default:
         case JCC_LE:
@@ -1137,10 +1136,9 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
             if (reg == cpu_cc_src) {
                 reg = s->tmp0;
             }
-            tcg_gen_shri_tl(reg, cpu_cc_src, 4); /* CC_O -> CC_S */
-            tcg_gen_xor_tl(reg, reg, cpu_cc_src);
+            tcg_gen_addi_tl(reg, cpu_cc_src, CC_O - CC_S);
             cc = (CCPrepare) { .cond = TCG_COND_NE, .reg = reg,
-                               .mask = CC_S | CC_Z };
+                               .mask = CC_O | CC_Z };
             break;
         }
         break;
-- 
2.43.0


