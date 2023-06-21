Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC58738E2A
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 20:08:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC2Dm-0000IW-7J; Wed, 21 Jun 2023 14:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qC2Dg-0000FN-CV
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 14:06:16 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qC2Dd-0006xG-JF
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 14:06:16 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4f8735ac3e3so5235129e87.2
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 11:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687370772; x=1689962772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AtiGMpM+dMDBs2toBdU5kukvz6RBLqrZkBucsSJ4j+Y=;
 b=F2HsNNFVzCMB95nBQ/N2fIAqQelnze1+sYQwGPDcMg2D6m2rCeAwTJhtlu1wdruNSS
 NZ965BPwB4L9m8UsnP5Iuv09yN4WVZzDSp3OGpnnI2LixZqjg8zIGTprNkfUikl7Vaaf
 ukImBXPfiptiW7ifgrAICgmt6GfYo+7CL26K0y2MeT61icQJpr44HA8ccF6p8ySFHKVE
 DPC0JqG8h7gZIykaw1uEYNyXj/l/OHcwic2L/2JWarfWuo7hiJrFOXgs6C0tVFXaNqqo
 QGqM4wr3OXKGayH7MA2zgWdOuhNiaq8a+Eei8ujTaj34r2zBOqhD2GT+WLO+nWpMlNtU
 Xqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687370772; x=1689962772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AtiGMpM+dMDBs2toBdU5kukvz6RBLqrZkBucsSJ4j+Y=;
 b=GuxZTTRO0wqnqwpkT2IbwfS6gsJldNy3b7DkcyWMg539C2w8kXVzTBMzmxdpHtI2T/
 7iMyN7tW7GtBCTbuoJZCxxC5k2G2RMvh0FB4ty77CSWZ/Tk7ze0J/EIcKGvEg/apoLHr
 KzygDsJFnBWzW5+G+Y7OwjPaA82rVL1lPfBBXqsyYXA83FEhSl3PfDdFl3Sf+g+E8A3S
 N0riycLek/iYgTIi3pocc6YvjVI2xeI8/qJJM7ca8JHil9P7x8eDr2sLpcqEYSiOdHcb
 psC4BBciCNgGNdbbqLloBSWBTk/9H+KruA0FeXRz6dJNTGdPUdKGLmdIR6ilSUtz+WLS
 1CQw==
X-Gm-Message-State: AC+VfDwv4GEbiWARbvrZhyQ1zJ9U7nEcN55znw9ieN6zz1ujUfVHiO32
 cRA1oN4JwPtVNeosIpLzcNrxftCiW3POyA0C19C6WPMF
X-Google-Smtp-Source: ACHHUZ63QSTGGWn0Bc3RJ/aDRdecykGTAQj3Bajfouq9F/qfp68cZnhaX5lxoiKKYF1nGm6L4mpkJg==
X-Received: by 2002:a19:4f46:0:b0:4f8:767d:9b98 with SMTP id
 a6-20020a194f46000000b004f8767d9b98mr4705691lfk.37.1687370771896; 
 Wed, 21 Jun 2023 11:06:11 -0700 (PDT)
Received: from stoup.lan ([176.176.128.70]) by smtp.gmail.com with ESMTPSA id
 g9-20020aa7d1c9000000b0051495ce23absm2910944edp.10.2023.06.21.11.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 11:06:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 2/8] target/sparc: Fix npc comparison in sparc_tr_insn_start
Date: Wed, 21 Jun 2023 20:06:01 +0200
Message-Id: <20230621180607.1516336-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621180607.1516336-1-richard.henderson@linaro.org>
References: <20230621180607.1516336-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12e.google.com
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

During translation, npc == address, DYNAMIC_PC, or JUMP_PC.
It is only the encoding between here and sparc_restore_state_to_opc
that considers JUMP_PC to be a bit within a larger value.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 28d4cdb8b4..eec6f9ca67 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5594,7 +5594,7 @@ static void sparc_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
-    if (dc->npc & JUMP_PC) {
+    if (dc->npc == JUMP_PC) {
         assert(dc->jump_pc[1] == dc->pc + 4);
         tcg_gen_insn_start(dc->pc, dc->jump_pc[0] | JUMP_PC);
     } else {
-- 
2.34.1


