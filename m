Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAEA81CE59
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 19:18:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGk4H-0000wa-3W; Fri, 22 Dec 2023 13:16:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4F-0000v5-5j
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4B-00068D-Sr
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703268971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KSZgnkQOSDsvsxwBp6IHkTcVed37E7lyaiV41jh+rsk=;
 b=dKRBHxFDURMz7oJs8fytf9SrGQm2/WZdVNO99Z1zdAkKqCmBPDOJu7+PbFv1Sjj6iZ1Bcp
 4FV+iCfLHU0Jdbo4d0rmuuH7HULQbIKxZr8VtfnFU9D0p6RtgXxZFrugyO49rU+luF1X9z
 8aa1CL4i1VT5nGfLzWfw/zKxMTsgLbQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-QpkMCOF8MQ6KLOc6UvoQqw-1; Fri, 22 Dec 2023 13:16:09 -0500
X-MC-Unique: QpkMCOF8MQ6KLOc6UvoQqw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40c348e529fso18286035e9.2
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 10:16:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703268967; x=1703873767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KSZgnkQOSDsvsxwBp6IHkTcVed37E7lyaiV41jh+rsk=;
 b=EhVFcynkNU2sAr+aK9HwK8zj3MtxS6fY4BmgbmEjh+XwJwoeQRWNDgUygGzjhxdMSH
 lvGoprJvtDIVpGQ38zk5nGQEbo6wWVjxNHnO4dDFon623hzwlFTMZU4f0Xqwsv4+ix1/
 8J1Sz6EentCq+v+nb3yO5hjccWKJRTcPahHkx47+5B2jD8xm4VKlMRrr6mYDbtUl2OYo
 Im2HHmlyqyY77qammWoC700VlmczdfBt/lp+v1I3gh/A1C/Nobki2HjeLo1YIY7OC8WH
 hDtDq64lr2XiFwr009SOmWvLEexjaCoIzszvVyyvcJiIcw7m7gemUwnclYvZmV9jxQWN
 7/CA==
X-Gm-Message-State: AOJu0YyDBq52cKfdfeXvZPzy7tPkH0i/S3K1GpOi01TjJQ83QRZlYMlb
 LGKBEPmWimi4M2xnjHVdx7xk6AjtmP2t3XdOkgAysDcpXJgJje07AOT+y9xnvW9OhGe+yIWqtys
 6RAzWod+7AiEof6jYtfd8lXgQ71IOtRE+IBpvbNuA11O7UzIsX5ZQ9FUgPdgXLhx/y+EQ628ObU
 F52taZfsw=
X-Received: by 2002:a7b:c3c8:0:b0:40d:421e:ddb with SMTP id
 t8-20020a7bc3c8000000b0040d421e0ddbmr959485wmj.227.1703268967681; 
 Fri, 22 Dec 2023 10:16:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHf6IUzoTtq0YCFqEibgSZ5q3x1ClNiwcDFuYhCzu+Mb5h7/nJaGYzW6xClyGnXqcI4cSZSRg==
X-Received: by 2002:a7b:c3c8:0:b0:40d:421e:ddb with SMTP id
 t8-20020a7bc3c8000000b0040d421e0ddbmr959479wmj.227.1703268967337; 
 Fri, 22 Dec 2023 10:16:07 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 s23-20020adf9797000000b00336813bb588sm4914309wrb.111.2023.12.22.10.16.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 10:16:05 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/22] target/i386: optimize computation of JL and JLE from
 flags
Date: Fri, 22 Dec 2023 19:15:42 +0100
Message-ID: <20231222181603.174137-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222181603.174137-1-pbonzini@redhat.com>
References: <20231222181603.174137-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.082,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


