Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D024B770960
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 22:08:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS155-0005DD-JO; Fri, 04 Aug 2023 16:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qS152-0005C6-Vi
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 16:07:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qS151-0005gw-Ib
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 16:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691179642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uw9+27h17Bn5iqViYL2WdXZm/t+7BfRm+0uwHaFZX94=;
 b=AZuwzkRa4qB/ZbJu3I6nnCS/bP4OKIgxz35NTvVkNl2AF7tE+FWv/STKi/n1bMDwmWDGqz
 DTKRtDL3JGyrgN4hwIhYND1YVGBhyUuv/8+ancT9szW8b3MYfF4HbHlAgpkdxSRnvrZqsa
 U7YYwTSsS7fgz7DIv+hjyKWYxRl/1x0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-SZ_Px4oBMOSctVvo2EwD_Q-1; Fri, 04 Aug 2023 16:07:21 -0400
X-MC-Unique: SZ_Px4oBMOSctVvo2EwD_Q-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4fb87c48aceso2577299e87.3
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 13:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691179639; x=1691784439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uw9+27h17Bn5iqViYL2WdXZm/t+7BfRm+0uwHaFZX94=;
 b=C7CfAM2ajiIzEYZMttqA9JrjZiyKVm68vKvc5PhvOBIqZM7EG3HLzXxQ+H0VVtkJf5
 04+4jhPdi+dwlJWtrKCdYIAXGAtj5gh30BghiDDwUJWBK1mkFCQ5Cmjy3i+GKU0VjAR+
 fUnlyus5BK6gXtT3B/YCKwztCUcVpfZezwgNQ+ZrVlSBZhEzreyHKHh9+SZwub0Ii2q4
 MKHl/fbHI7lzUxeuse+qd8mfsJLU09MqndcEuKaSxVtv9y+kcw15/0uie4W9RLcg+m81
 duRxdNPTL5ZzHURNFR1p3sXxVrFtf9d65BBNqz+DjeDLt4mWDBX2RyoirbXb2sWyGpWP
 9QbQ==
X-Gm-Message-State: AOJu0Yxhz+E2218DJsuas+EMc5FKuUjvZzGO7xUbP8WPwUlUH2Kuwp8B
 J0abYavW8v8TWkny3zd9sZzQmELNWlws/SQkFalNYxT+8AiYplHdkLQygA9OfzNAn7zzoiXXWdU
 RK1lJ/27A1xgccj/Yd2McZSqs4mHFTcSAnhKc8o/XO0E8cNYPc9dDmC5/Oyn00Lns44tZzrty6I
 g=
X-Received: by 2002:a05:6512:32b3:b0:4f8:66e1:14e8 with SMTP id
 q19-20020a05651232b300b004f866e114e8mr1855316lfe.69.1691179639200; 
 Fri, 04 Aug 2023 13:07:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPcPlWjfOlHneC9B+AeW5JMHMvY3K4mGxmb2lay8THtdUqu898k+de1EIVKoqoe4ystnR2Gw==
X-Received: by 2002:a05:6512:32b3:b0:4f8:66e1:14e8 with SMTP id
 q19-20020a05651232b300b004f866e114e8mr1855302lfe.69.1691179638685; 
 Fri, 04 Aug 2023 13:07:18 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 r14-20020aa7da0e000000b0052286e8dee1sm1677319eds.76.2023.08.04.13.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 13:07:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Matt Borgerson <contact@mborgerson.com>,
	qemu-stable@nongnu.org
Subject: [PULL 1/2] target/i386: Check CR0.TS before enter_mmx
Date: Fri,  4 Aug 2023 22:07:14 +0200
Message-ID: <20230804200715.430592-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804200715.430592-1-pbonzini@redhat.com>
References: <20230804200715.430592-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Matt Borgerson <contact@mborgerson.com>

When CR0.TS=1, execution of x87 FPU, MMX, and some SSE instructions will
cause a Device Not Available (DNA) exception (#NM). System software uses
this exception event to lazily context switch FPU state.

Before this patch, enter_mmx helpers may be generated just before #NM
generation, prematurely resetting FPU state before the guest has a
chance to save it.

Signed-off-by: Matt Borgerson <contact@mborgerson.com>
Message-ID: <CADc=-s5F10muEhLs4f3mxqsEPAHWj0XFfOC2sfFMVHrk9fcpMg@mail.gmail.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 46afd9960bb..8f93a239ddb 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1803,16 +1803,18 @@ static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
         }
         break;
 
-    case X86_SPECIAL_MMX:
-        if (!(s->prefix & (PREFIX_REPZ | PREFIX_REPNZ | PREFIX_DATA))) {
-            gen_helper_enter_mmx(cpu_env);
-        }
+    default:
         break;
     }
 
     if (!validate_vex(s, &decode)) {
         return;
     }
+    if (decode.e.special == X86_SPECIAL_MMX &&
+        !(s->prefix & (PREFIX_REPZ | PREFIX_REPNZ | PREFIX_DATA))) {
+        gen_helper_enter_mmx(cpu_env);
+    }
+
     if (decode.op[0].has_ea || decode.op[1].has_ea || decode.op[2].has_ea) {
         gen_load_ea(s, &decode.mem, decode.e.vex_class == 12);
     }
-- 
2.41.0


