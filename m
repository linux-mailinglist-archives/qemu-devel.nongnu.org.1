Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BA4ABB3D3
	for <lists+qemu-devel@lfdr.de>; Mon, 19 May 2025 06:10:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGroP-0007ci-TO; Mon, 19 May 2025 00:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrnv-0006fi-2T; Mon, 19 May 2025 00:08:46 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrns-0004FD-DP; Mon, 19 May 2025 00:08:42 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b07d607dc83so3084091a12.1; 
 Sun, 18 May 2025 21:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627717; x=1748232517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8cJLeWkLvWM5bp/XTdTKM2Obf1dResa+TT2yrKZ8tT4=;
 b=c2G9qOxFUT4RnhPbWz0gOKlrIoq9/FsnsNh8epPU39lXnuy17hr2VUW1YVz22iYK1E
 aEHtlVKsA5LX9Qn46W9bnk3HehNvNWE0qEFLyvQHujH20jxrzFb5LvjuUBtvQgIPdXrc
 c1JL7c/mKW8C0z95C+c8y2s0dc14MQrY/dCoZwVZXgYLLEPOmYU3+ucvzpoFSkHN3nic
 0JpEG/rru3zTXs4yTVe/nxTXV7Eol/6u0DnLGU7knHiITeLXyw7HN91LqZt/+eg31al8
 zTeU9qk1llHptFxTVJew32McMabQvks9ra5oqgaRn1ZKo0yfwqKgTuByGDcNqfVgNza7
 ZYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627717; x=1748232517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8cJLeWkLvWM5bp/XTdTKM2Obf1dResa+TT2yrKZ8tT4=;
 b=lMhpUDyV4gzvREN0i1GuGBq/qgsBwx13qk5aTxbkuyeTBOTC7bYRPNCn7iis3/FvFs
 YzlkMsNQ9a6OqxyPo7dwUXQoKqunrpgRiTk2kynbTG3ADlCdVq8O35m7LlWMLcrb1aTS
 O6bE5b06cvLhtYyXfuJKOcKj7jxZynk/GVLR/iVudTKGKaY0Cy2hVoSa2rkvzPRbFgT9
 rlkibcsjVIItMZnde7juBXHuHVUEwkg2RjbOxE9hvkq8AUz5Ro0Ke6CQF26rutLoP3cI
 r7JR9rEwQmJ8j3AFsNZMv7Bq/QjLjSNo9sbvPaZNEw8K7OLceg+rOJZ1p6nrtcDd93zZ
 rIxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPlzKWKqZkAZhFf9CcyT1P+laRnpVs91V/w8EGkgG4k5fmfZHZDADBLGtd9CkprZYHpk2GNh+dD77hTQ==@nongnu.org
X-Gm-Message-State: AOJu0YzzzxO8pFDR9g/Ny6SVpQF4Ie5Echn4Ci1G00szoGc2hSOveIvw
 d8pVsbVhNSNcIGg4C0LZKXI/6t56lykwckedLfcgUv6jef8DfEbmTQ5JJ01R9A==
X-Gm-Gg: ASbGncuqTeRoepFw7LO1tNU/So3751zvkrxrd91Rtp05jBpOWU+LrHarAyyruwzGaFn
 LJfukb3QGlO8867fiDrIVfv2eUyaYgYCT83Tp5oxyDw+JvFeG1OM+8QQqMvCLJjNf25jYOLVFKj
 9HE+0baEj6JOOZLzNwGiP9i1nIYfWuG/hsqP0tDG8vIpD6xsW7UbhYwwb5iy4DTyklIOJdAPiTE
 K3A70kwGGHCAcSztib8SxYgR2S6i+Skv3QDTYao/w4dFCTQ5MLIq9FPlNs6KafHN3FX+Ye8rN1U
 bH/Lvq1+sKTk8QpzPy+/mYTlIrpz9/SP15tz3HOcn16p7JQpyETOVIeQkJKrepfWX2+c+RY5iet
 +szQhINTumCXzjQKo3tnjTnj1VYEUei5OSNgS85+r1QDKqDGeQ/fJWaMl
X-Google-Smtp-Source: AGHT+IF6cNdX5wyBEkgsCf0EevByfmD8f9zID1w9ELJcURPTDsTrxDE3rgdfh94gbzrYxnClt0ZxIQ==
X-Received: by 2002:a17:902:f785:b0:22e:4c98:cd8b with SMTP id
 d9443c01a7336-231d43d9a46mr147368805ad.3.1747627717586; 
 Sun, 18 May 2025 21:08:37 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:08:37 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Anton Blanchard <antonb@tenstorrent.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-stable@nongnu.org
Subject: [PULL 28/56] target/riscv: rvv: Apply vext_check_input_eew to vector
 indexed load/store instructions
Date: Mon, 19 May 2025 14:05:25 +1000
Message-ID: <20250519040555.3797167-29-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Handle the overlap of source registers with different EEWs.

Co-authored-by: Anton Blanchard <antonb@tenstorrent.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
Message-ID: <20250408103938.3623486-10-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
---
 target/riscv/insn_trans/trans_rvv.c.inc | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 1d2b46fc44..2b6077ac06 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -1277,7 +1277,8 @@ static bool ld_index_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
 {
     return require_rvv(s) &&
            vext_check_isa_ill(s) &&
-           vext_check_ld_index(s, a->rd, a->rs2, a->nf, a->vm, eew);
+           vext_check_ld_index(s, a->rd, a->rs2, a->nf, a->vm, eew) &&
+           vext_check_input_eew(s, -1, 0, a->rs2, eew, a->vm);
 }
 
 GEN_VEXT_TRANS(vlxei8_v,  MO_8,  rnfvm, ld_index_op, ld_index_check)
@@ -1329,7 +1330,8 @@ static bool st_index_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
 {
     return require_rvv(s) &&
            vext_check_isa_ill(s) &&
-           vext_check_st_index(s, a->rd, a->rs2, a->nf, eew);
+           vext_check_st_index(s, a->rd, a->rs2, a->nf, eew) &&
+           vext_check_input_eew(s, a->rd, s->sew, a->rs2, eew, a->vm);
 }
 
 GEN_VEXT_TRANS(vsxei8_v,  MO_8,  rnfvm, st_index_op, st_index_check)
-- 
2.49.0


