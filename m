Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF2981CE63
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 19:19:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGk4n-00014H-E4; Fri, 22 Dec 2023 13:16:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4N-0000y2-7K
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4I-0006Ae-Kx
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703268977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hMgCYkMSChTxWgsOsJ7pbZi3k2H6rsfqHMxXx+MaqbY=;
 b=E8d/1BaygetFib4+z0kvu/DeyMXEnPruP5BQ9F2QOoqIow4pM9p+M24vOjPfvVIGmoAr1j
 KPsBODyKZ9Gf19CUOMPI6DR2222pwEernGQittUIAdjdlQhwGXtOB0yJFi+VvovTnH0wzM
 77HrEaKNIFkUY+7wzGfAeYpCh8vuYOo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-Sv_ZktSUMViCLF6-iFhZCQ-1; Fri, 22 Dec 2023 13:16:15 -0500
X-MC-Unique: Sv_ZktSUMViCLF6-iFhZCQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3369382a524so665009f8f.1
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 10:16:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703268974; x=1703873774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hMgCYkMSChTxWgsOsJ7pbZi3k2H6rsfqHMxXx+MaqbY=;
 b=RS7nn2nqZmtjE5peUcKLhLyp8j1ZrUXQHMz2RwhK/rVxoKkmyzHaIH6PP/kBW1kuVS
 TbIhdCQXXO/5ORZv3bEyiuTjD3WcM/9yl+ZHTF0VYlJrt0oNxCPYHWTT304KW+WRt5Gq
 IaEBK9Su4IZjXrI2nnvdMOPfpLUsHr9xnQ+w0Y+quKSntOpwoP1lbW8UphYdGUSg/L7T
 S4f9PWCv1Z6Sotd8OJYMOuIjkf+hRmdnVooiNVTaCUzjMPdO5qiByrEV58qxMq8YbENy
 +WzKKalCRN0cCq3eZesDjTtSX466HvX7Njkvk+PqkLz47Doa6rXkuNujLH9Y7KBRY65A
 KKPg==
X-Gm-Message-State: AOJu0YyV/SlnSz6THL4yakNCq1K3ynO6J+SkS/WBqiqcUHRKT6yzrQ17
 MfoCk2hf/V95zH4JEBC5YSFQrgF4xbeY7YSqsT3hSZ6YzsB//M1UbhCYB7cgt72F24fltysynU7
 pibSo7EdWIb8qu4ltLgHm+zXSlVSdrA5mW81Ma0cm9qPqDZhB0wjokGM7krBOcCHREbdZqTbGZQ
 RmfZrGqsk=
X-Received: by 2002:adf:eac3:0:b0:333:5247:be11 with SMTP id
 o3-20020adfeac3000000b003335247be11mr1173086wrn.119.1703268974353; 
 Fri, 22 Dec 2023 10:16:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrDnhQaw1nbqCpu26T4b42rz69tH5mOtU1y3bruWyL6eEaKNC+G19Eq7FiJiIDBuP6dNVrIA==
X-Received: by 2002:adf:eac3:0:b0:333:5247:be11 with SMTP id
 o3-20020adfeac3000000b003335247be11mr1173078wrn.119.1703268974038; 
 Fri, 22 Dec 2023 10:16:14 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 w11-20020adfcd0b000000b003367e35abd4sm4879394wrm.71.2023.12.22.10.16.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 10:16:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/22] target/i386: remove unnecessary truncations
Date: Fri, 22 Dec 2023 19:15:45 +0100
Message-ID: <20231222181603.174137-5-pbonzini@redhat.com>
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

gen_lea_v_seg (called by gen_add_A0_ds_seg) already zeroes any
bits of s->A0 beyond s->aflag.  It does so before summing the
segment base and, if not in 64-bit mode, also after summing it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/emit.c.inc  | 4 +---
 target/i386/tcg/translate.c | 2 --
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 82da5488d47..d444d83e534 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1242,9 +1242,7 @@ static void gen_LDMXCSR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
 
 static void gen_MASKMOV(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
-    tcg_gen_mov_tl(s->A0, cpu_regs[R_EDI]);
-    gen_extu(s->aflag, s->A0);
-    gen_add_A0_ds_seg(s);
+    gen_lea_v_seg(s, s->aflag, cpu_regs[R_EDI], R_DS, s->override);
 
     if (s->prefix & PREFIX_DATA) {
         gen_helper_maskmov_xmm(tcg_env, OP_PTR1, OP_PTR2, s->A0);
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index a16eb8d4008..73b83e07e23 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -4183,7 +4183,6 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         tcg_gen_mov_tl(s->A0, cpu_regs[R_EBX]);
         tcg_gen_ext8u_tl(s->T0, cpu_regs[R_EAX]);
         tcg_gen_add_tl(s->A0, s->A0, s->T0);
-        gen_extu(s->aflag, s->A0);
         gen_add_A0_ds_seg(s);
         gen_op_ld_v(s, MO_8, s->T0, s->A0);
         gen_op_mov_reg_v(s, MO_8, R_EAX, s->T0);
@@ -5835,7 +5834,6 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             gen_update_cc_op(s);
             gen_update_eip_cur(s);
             tcg_gen_mov_tl(s->A0, cpu_regs[R_EAX]);
-            gen_extu(s->aflag, s->A0);
             gen_add_A0_ds_seg(s);
             gen_helper_monitor(tcg_env, s->A0);
             break;
-- 
2.43.0


