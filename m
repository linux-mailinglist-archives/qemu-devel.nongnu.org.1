Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8CF831916
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 13:25:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQRS5-0004BZ-0p; Thu, 18 Jan 2024 07:24:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQRRs-0003WR-Rp
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:24:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQRRr-0006Gf-7j
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:24:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705580682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IxvX/wxNBwVtKGkT3vFrlSLqiMV2FttRmJQLp4ASRQ0=;
 b=Qci2nQQiXymBQSgHGbhlfBijLqmrqXmm8DG9FMREY5kcWlHBSOysBYrvJZnTqD80Pb2Cjv
 GwuinVL7GlpwhEMLw00yjaEvkt2igpKLWaLbWkTZR4SBX1JoTZHRyNnjUgpQc2/8lIPCdW
 NLJ3h69DrrfzZ+ad0XLbioHmXfAfih8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-5zakvBx-PaCj0SfF05ElkQ-1; Thu, 18 Jan 2024 07:24:40 -0500
X-MC-Unique: 5zakvBx-PaCj0SfF05ElkQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-55926d2bbe2so1467413a12.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 04:24:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705580679; x=1706185479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IxvX/wxNBwVtKGkT3vFrlSLqiMV2FttRmJQLp4ASRQ0=;
 b=KCKcJyV6nBSrYARdn9vB0GWCS/+hb1ut4dKoLYlHTFeNceY6BNK63IgA+nPxEZFwa5
 wVkMj/mVhmrU3uUpQCbnsM52/MAiFHDyfA5zvxowYTxP5lTQEpjjenrFx8+Pz8WiP+FS
 9vyBIhnsx+oOIukcKAVtseofZ4Vbgs5kdum3VODTh+JLSRHsJyXSFj+WwackMB7wmAHi
 CKSmr8cxhd0gbRAP8pOwmjuEN0W7KeQPAQhROv7EzaFIluADPvc8R8r2UKNAwxkUBagx
 DtUKh4ICw4xIDUtvBTbbHn2dsVcEXgXlSkCt/sCyXXADWxXYi2m2xkp4zazTqih/6pmD
 xmYg==
X-Gm-Message-State: AOJu0YxBbipcijzLPJHt3WNq3M9ryPsrCd4l4Bp+DEZSid66bd07Xttz
 vIa+c77mIMFmctVcDLZTsxKKAdSgH0v8Zc46ZVQL3vFDtUEhuUywhKALOeGmaAySvrYtQaOFAIe
 EVeT605vPAKPmskoEmJIKZU1OMJVz4J6nHamBy/A3aM0+tR7hMFVbLfczsfuF7ZZycTY5B++s+F
 V6sGr2vZXzkMP8oeZjTi8PnpyPJu7Y7Tgi7lfH
X-Received: by 2002:a50:9ea4:0:b0:559:b943:c067 with SMTP id
 a33-20020a509ea4000000b00559b943c067mr529664edf.79.1705580679117; 
 Thu, 18 Jan 2024 04:24:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOuLJK78kHdR+iTZkutVu8nI+QN9+sP2yyWn+jd3CgVlwW1NGYJdKEsOpFab4LFVgIhsHD4g==
X-Received: by 2002:a50:9ea4:0:b0:559:b943:c067 with SMTP id
 a33-20020a509ea4000000b00559b943c067mr529659edf.79.1705580678911; 
 Thu, 18 Jan 2024 04:24:38 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 c10-20020a056402100a00b0055974156563sm4142191edu.26.2024.01.18.04.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 04:24:37 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: guoguangyao <guoguangyao18@mails.ucas.ac.cn>, qemu-stable@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 12/16] target/i386: fix incorrect EIP in PC-relative
 translation blocks
Date: Thu, 18 Jan 2024 13:24:12 +0100
Message-ID: <20240118122416.9209-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118122416.9209-1-pbonzini@redhat.com>
References: <20240118122416.9209-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: guoguangyao <guoguangyao18@mails.ucas.ac.cn>

The PCREL patches introduced a bug when updating EIP in the !CF_PCREL case.
Using s->pc in func gen_update_eip_next() solves the problem.

Cc: qemu-stable@nongnu.org
Fixes: b5e0d5d22fbf ("target/i386: Fix 32-bit wrapping of pc/eip computation")
Signed-off-by: guoguangyao <guoguangyao18@mails.ucas.ac.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240115020804.30272-1-guoguangyao18@mails.ucas.ac.cn>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index d4d7e904adb..cadf13bce43 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -567,9 +567,9 @@ static void gen_update_eip_next(DisasContext *s)
     if (tb_cflags(s->base.tb) & CF_PCREL) {
         tcg_gen_addi_tl(cpu_eip, cpu_eip, s->pc - s->pc_save);
     } else if (CODE64(s)) {
-        tcg_gen_movi_tl(cpu_eip, s->base.pc_next);
+        tcg_gen_movi_tl(cpu_eip, s->pc);
     } else {
-        tcg_gen_movi_tl(cpu_eip, (uint32_t)(s->base.pc_next - s->cs_base));
+        tcg_gen_movi_tl(cpu_eip, (uint32_t)(s->pc - s->cs_base));
     }
     s->pc_save = s->pc;
 }
-- 
2.43.0


