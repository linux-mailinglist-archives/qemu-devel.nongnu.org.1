Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5AF8681D7
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Feb 2024 21:19:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rehPs-0001cd-EA; Mon, 26 Feb 2024 15:17:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rehPq-0001c7-OI
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 15:17:34 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rehPp-000803-6F
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 15:17:34 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3bb9b28acb4so2482073b6e.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 12:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708978651; x=1709583451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yMW6AxjBVDIdk1/2CbavQRJvPc+W233QtqwWnqwEGOg=;
 b=Q+GPhQXabJHbTeYOOvQ6og0ZmVRWMYJiKpmzEoRMEoyYHNPzXaN9UjaQ0dtGb6ZdPE
 dNtn78X+t7SlpdKyvZCA8Lms/s5/9pZ7c3UzlUAqWjkWEbOndOgMoIWoMcuRWHQ1kMuH
 LZSQ5ORm0K9WK/r75rc2Q+JHNZbsJhZNlV9exhSydZR9swKmJwX/EjXKx3xaPdIrstju
 J4xchHopFKfwlwWvSW/rCKA/TeuIEuhq2LIZh7Qsm3jrVSsAGwkIOXd0rEXp+wCSLwzs
 +xs9A3NNdmuoZUA2AssG8h5rTAW+C1p1Q1Bh9/in/535L8nwUtEPQsVacRb/mWTOt2h9
 VV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708978651; x=1709583451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yMW6AxjBVDIdk1/2CbavQRJvPc+W233QtqwWnqwEGOg=;
 b=I8za7lbo7B/Nf2spn1iTRB8U0pTgIzZTrPlldE0fZ/+lEpkh6irprh1rRtVRy+lw+S
 rq56qVar/5SqBeZ/P6PBkisYstr1BLZBgX1PhT8EciYtZdOtLC5sOrrkyEvJewuEzgAt
 Us75m94YGCFLYPiJjgrik9xs+KNtbMioRx5qlaB1Dp4K0kwSrk3ThIZMDXofwdZtdcu5
 2+N0pzf99O69Y3gnJXZtQxqEU5MBrToA4dsHuyoGnkptoSLTl2dQ7Oahbxt/NIwC2fCB
 fYdqTIeQrOng3ThjRPBiNBi8+TvOgGjvWucLTywMALzFSvW8pTDa7uBjINt/xRsarWDD
 QDSw==
X-Gm-Message-State: AOJu0YzbejoLXl4pdOs5d51pV7BwyolnQf40HQ6IPW+WI7E2Bk7WFqWX
 WtOBD04v9ui/kmxhuWI0rGT5lu/ZxzOH4PFINLkbCjfH4BkbQtskWHG6Iz7DsR4=
X-Google-Smtp-Source: AGHT+IFVNxavW8N79nMnwL4jbkbBBZwkCjd/ENpRKu/qPCb6zKA1BLcU061IcUoOJMMb6FSXD0QmdQ==
X-Received: by 2002:a05:6808:2189:b0:3bf:fdb2:ca5b with SMTP id
 be9-20020a056808218900b003bffdb2ca5bmr222894oib.3.1708978651490; 
 Mon, 26 Feb 2024 12:17:31 -0800 (PST)
Received: from taylor-ubuntu.austin.rr.com (068-203-008-061.res.spectrum.com.
 [68.203.8.61]) by smtp.gmail.com with ESMTPSA id
 by11-20020a056808340b00b003c1a4a9ad17sm330594oib.46.2024.02.26.12.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 12:17:30 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH 4/9] Hexagon (target/hexagon) Mark has_pred_dest in trans
 functions
Date: Mon, 26 Feb 2024 13:17:17 -0700
Message-Id: <20240226201722.391879-5-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226201722.391879-1-ltaylorsimpson@gmail.com>
References: <20240226201722.391879-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Check that the value matches opcode_wregs

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/insn.h             | 1 +
 target/hexagon/decode.c           | 3 +++
 target/hexagon/gen_trans_funcs.py | 4 ++++
 3 files changed, 8 insertions(+)

diff --git a/target/hexagon/insn.h b/target/hexagon/insn.h
index a770379958..24dcf7fe9f 100644
--- a/target/hexagon/insn.h
+++ b/target/hexagon/insn.h
@@ -41,6 +41,7 @@ struct Instruction {
     uint32_t new_value_producer_slot:4;
     int32_t new_read_idx;
     int32_t dest_idx;
+    bool has_pred_dest;
 
     bool part1;              /*
                               * cmp-jumps are split into two insns.
diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
index a4d8500fea..84a3899556 100644
--- a/target/hexagon/decode.c
+++ b/target/hexagon/decode.c
@@ -366,6 +366,9 @@ static void decode_shuffle_for_execution(Packet *packet)
         for (flag = false, i = 0; i < last_insn + 1; i++) {
             int opcode = packet->insn[i].opcode;
 
+            g_assert(packet->insn[i].has_pred_dest ==
+                     (strstr(opcode_wregs[opcode], "Pd4") ||
+                      strstr(opcode_wregs[opcode], "Pe4")));
             if ((strstr(opcode_wregs[opcode], "Pd4") ||
                  strstr(opcode_wregs[opcode], "Pe4")) &&
                 GET_ATTRIB(opcode, A_STORE) == 0) {
diff --git a/target/hexagon/gen_trans_funcs.py b/target/hexagon/gen_trans_funcs.py
index 07292e0170..f1972fd2dd 100755
--- a/target/hexagon/gen_trans_funcs.py
+++ b/target/hexagon/gen_trans_funcs.py
@@ -86,6 +86,7 @@ def gen_trans_funcs(f):
 
         new_read_idx = -1
         dest_idx = -1
+        has_pred_dest = "false"
         for regno, regstruct in enumerate(regs):
             reg_type, reg_id, _, _ = regstruct
             reg = hex_common.get_register(tag, reg_type, reg_id)
@@ -96,6 +97,8 @@ def gen_trans_funcs(f):
                 new_read_idx = regno
             if reg.is_written() and dest_idx == -1:
                 dest_idx = regno
+            if reg_type == "P" and not reg.is_read():
+                has_pred_dest = "true"
 
         if len(imms) != 0:
             mark_which_imm_extended(f, tag)
@@ -119,6 +122,7 @@ def gen_trans_funcs(f):
         f.write(code_fmt(f"""\
             insn->new_read_idx = {new_read_idx};
             insn->dest_idx = {dest_idx};
+            insn->has_pred_dest = {has_pred_dest};
         """))
         f.write(textwrap.dedent(f"""\
                 return true;
-- 
2.34.1


