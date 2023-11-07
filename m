Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9548F7E331D
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:36:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Bt3-0000qe-Ib; Mon, 06 Nov 2023 21:32:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bt1-0000kJ-Qx
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:32:15 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bsz-00031B-Bw
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:32:15 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1cc68c1fac2so47526625ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324332; x=1699929132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QhTFCoom3BDsKVgFXUK14m/YbZpyWLQoCXzNZmoZ+Ps=;
 b=GVa6AADYOvN1rrFfhJnxqeaLCEUm4gvaOEPpttaXJb5DNc+g3EwRmFD+/H3uIefeT0
 PhSJ0LIYRFbQvFaAHCPj8jIscHe+8g506ABvRouA7TBYeq4fDdliQUyEVVqP1e9zymgK
 Up+jaUItYPvAuknJwY7TB32rVA0KKHROcPNp0QTUcv0UJk7M/SD2AHe93kiOOi+V6Ksh
 KT9arIrse/j2x0IpWik5lSdda30J/V0mQi6WCfGcIM3mct4tjFtHDs9bae4QBRoAKnGc
 14GmzItxj9n8PsjkUfHukGWHMrNRgB0GosHUsEYwbli5QUYpQxworofnqWjp7OE/BCBK
 oeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324332; x=1699929132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QhTFCoom3BDsKVgFXUK14m/YbZpyWLQoCXzNZmoZ+Ps=;
 b=fetj3JMHS0ZMNzd+hg+cqx1jXpFbWhNC5UP12TbaP5kS3JWUr+jA+ANiRR79XV5HRw
 aTFRfW/XBNdtXoxXr5styexBC6FB5fAdww+YCokLV0A0sRFIbNujkJB4Q5byuIwruWMk
 DLRKtecIRQmNWbFRS9LxAJwmKgkyMsY3zJEvkQF/L+WWMmi0lGCOL9yJI6/m6VAXs+Ez
 iy9v23JGta9LvIaj8QDuTufhPpZNPox91KgiQ75HLafXLKuZFJgBGAoOZ9Ua5GggypwO
 tuw08Rw252U0YR4rfrdV+baPOi/R6ySCG9OXINA9GWp2cs+Oy9lqQNx/rr9ALDpZRc4Q
 masw==
X-Gm-Message-State: AOJu0Yz7O+ULr6hpIGK8GuhK91c90pWpuprNq7zSWa0BBEph/WHkTnde
 q4k8AUxkW8vSCndk4KbsXBNnZpU3gSTamQ==
X-Google-Smtp-Source: AGHT+IHuvsz5HFSz8x2+hLPLFQGGj2lOYNCd/YI/D7DCraDtiRYiWYsP/P7agxU4vesGbBR311OOHA==
X-Received: by 2002:a17:902:e489:b0:1cc:3c2d:128e with SMTP id
 i9-20020a170902e48900b001cc3c2d128emr23571077ple.7.1699324331736; 
 Mon, 06 Nov 2023 18:32:11 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:32:10 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 39/49] disas/riscv: Add rv_fmt_vd_vs2_uimm format
Date: Tue,  7 Nov 2023 12:29:35 +1000
Message-ID: <20231107022946.1055027-40-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Max Chou <max.chou@sifive.com>

Add rv_fmt_vd_vs2_uimm format for vector crypto instructions.

Signed-off-by: Max Chou <max.chou@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231026151828.754279-12-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/disas/riscv.h b/disas/riscv.h
index 8abb578b51..b242d73b25 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -274,6 +274,7 @@ enum {
 #define rv_fmt_vd_vs2_fs1_vm          "O\tD,F,4m"
 #define rv_fmt_vd_vs2_imm_vl          "O\tD,F,il"
 #define rv_fmt_vd_vs2_imm_vm          "O\tD,F,im"
+#define rv_fmt_vd_vs2_uimm            "O\tD,F,u"
 #define rv_fmt_vd_vs2_uimm_vm         "O\tD,F,um"
 #define rv_fmt_vd_vs1_vs2_vm          "O\tD,E,Fm"
 #define rv_fmt_vd_rs1_vs2_vm          "O\tD,1,Fm"
-- 
2.41.0


