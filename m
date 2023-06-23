Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5947873B8A7
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 15:19:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCgfL-0004Xk-IC; Fri, 23 Jun 2023 09:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCgfI-0004Wm-EA
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:17:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCgfF-0005aP-Gz
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687526245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5DXiNsuxJ9qVbt80PCL9CHIXh4r/PuClI93uiH00w3U=;
 b=fsg+Rb+ol/SDG9dktIBX+EvANGYduRfs7RyaG8nn6IvfNsqZkq9upO8hmMuEwaYpamiDW1
 xEsHCe65IhMzRwADMU4cWZKfzlyDjfxHE4fWQMT89ldnGHscR0bk0QUw79kw5GjyMA+sNg
 RcQG3bs8/SwcqqLfvH99ctCaP+8SdJQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-tWiV_5W6MBm67b4WAhu4Ag-1; Fri, 23 Jun 2023 09:17:22 -0400
X-MC-Unique: tWiV_5W6MBm67b4WAhu4Ag-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b4577e34fbso6573291fa.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 06:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687526240; x=1690118240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5DXiNsuxJ9qVbt80PCL9CHIXh4r/PuClI93uiH00w3U=;
 b=dHGCEmr5zHW8tUrAh/I3NYj6sAxaIAn/Arr6wv87DqUMP/5SPrWWGNf9Gf9IZ67Jeb
 VLy8Wy9VuxutuW18miZ7Ng/cxLvj+eM7RJsOZ9PXw9W4tlbu6t1TLm4xCMRWt8PChyCu
 TlPkoUbVoaHAqpXDeXYtAtXnmeKP2YOftmhg0qNvqPznt2UNGpYVX3otnDyS9Skg8RXq
 6qeklX04LfU1gTc76vSHWpJl8Vs79/XgPrZxr20cz/pP5Ox47HWKI5p/sy7uvc3Lx7sI
 u22FnldR/RfaKh16rRvn5pOgWW26LgIYl6aYNmZFAJjj05kqY9t7K607GQ7nO1y47SJg
 lMLg==
X-Gm-Message-State: AC+VfDxAHOnBKTnCRcaHAISLWLFk7av9X2xVeNsN6TzHCgqAYIaYYtUI
 8/KTNSm/VuExDz6lgOJp/HyXjUXuFxq1ycMm+w21Je4ell76oSs/4rcp2MMY4u53qO5sQbJ/t7X
 GAj7wt8pPpqPSEYZPiLIXTe7Zc0uNgtiuJZHSqVLpwjEBNF9cDwm0kyno1x41gdzeqycDiYzqpZ
 M=
X-Received: by 2002:a2e:b60f:0:b0:2b5:8bc3:95c9 with SMTP id
 r15-20020a2eb60f000000b002b58bc395c9mr4766595ljn.31.1687526240533; 
 Fri, 23 Jun 2023 06:17:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5v2bLSHNklNH67oZ5mWcHVwgHRKfNm+Yj0qXZR7HBXV3gPBpTjpXlsqB8UN4q0OLaPA5HjPA==
X-Received: by 2002:a2e:b60f:0:b0:2b5:8bc3:95c9 with SMTP id
 r15-20020a2eb60f000000b002b58bc395c9mr4766581ljn.31.1687526240158; 
 Fri, 23 Jun 2023 06:17:20 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 l9-20020aa7c309000000b005187a57fba1sm5251824edq.77.2023.06.23.06.17.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 06:17:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v3 04/11] target/i386: do not accept RDSEED if CPUID bit absent
Date: Fri, 23 Jun 2023 15:17:04 +0200
Message-ID: <20230623131711.96775-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230623131711.96775-1-pbonzini@redhat.com>
References: <20230623131711.96775-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 0de068d4b79..4ef45bbd71e 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3925,12 +3925,20 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             break;
 
         case 7: /* RDSEED */
+            if (mod != 3 ||
+                (s->prefix & (PREFIX_LOCK | PREFIX_REPZ | PREFIX_REPNZ)) ||
+                !(s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_RDSEED)) {
+                goto illegal_op;
+            }
+            goto do_rdrand;
+
         case 6: /* RDRAND */
             if (mod != 3 ||
                 (s->prefix & (PREFIX_LOCK | PREFIX_REPZ | PREFIX_REPNZ)) ||
                 !(s->cpuid_ext_features & CPUID_EXT_RDRAND)) {
                 goto illegal_op;
             }
+        do_rdrand:
             translator_io_start(&s->base);
             gen_helper_rdrand(s->T0, cpu_env);
             rm = (modrm & 7) | REX_B(s);
-- 
2.41.0


