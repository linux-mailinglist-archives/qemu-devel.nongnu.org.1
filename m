Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B22C72F1B5
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:24:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FBm-0004YE-Ju; Tue, 13 Jun 2023 21:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FBk-0004Xq-ML
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:20:44 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FBi-0004SN-QV
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:20:44 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6665f5aa6e6so41891b3a.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705640; x=1689297640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OjBr8AyuXGgPTSJyCdvEt7U931yj4CNEKJLti8Ey21M=;
 b=JgXnCzEpmN0ZRvIV4/6h/KTJbXZ1tNdQM0/Wyl+1h2IKJu92n4Tv81DB40UT3Idx/h
 6z06SAnHclwAlGhDdr1FYAI1SMXm4OZJSx/47E7+FQRxSX1dh97cRwdC9alci0aZCkta
 E100pRncFWlVXhxr2I3RjllO930x8mapC/2mR8fzp7byzFFYF7mb4/U7bytX9ALUszgp
 pxIhtopBoA428ROuFnu2OO/vcZOOnkLBVsGunJtzoGp9fr9e67S30gRC/vIRHZ1wsezV
 UCaZXSryBUF5IAIwOt5fJvjaHPZ7IQZP0Rel6GCzwsDKnATR9NfoXW+hBKeu89MDu/my
 9bGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705640; x=1689297640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OjBr8AyuXGgPTSJyCdvEt7U931yj4CNEKJLti8Ey21M=;
 b=ajcMFw1aKv5sr8uij8lxeak7wCO6ORuSvVRuuUaluXZPxUdnGGhYxUqDT7IBfQfPPk
 8iykWW0hZVZczFciPTSiTymUDHiWCUjWbIJsWMOT8NEuDJXjk4aAbuJ3TPLwe6KarOEz
 8KljPxYfyO9Jv4H1fT/+ByCqc/bSzE6ilARUH04v6NNyhOpPiegV3x5tR5GWHK2wo8vY
 rdffdIB0yKBrrSv0Qrlq6p2VJnd1Kh3jI3lfMQUosP8BaF+tQTZlGq3sHtuPQLHio59u
 GufMDUJGZzowm5wL+tYBtqn/0bXYx7iiytkjV2Y75+uwQ+oQ5Cg4tKEGLzkDGcIoRkwA
 xq5Q==
X-Gm-Message-State: AC+VfDxO+Ie3zd++nbfKrpYJRIRb4MUBN1pjAX2crTlrFyAM6hwjUwPW
 fc7ABB6SM/JcptyZWt+/u9lxYGymvYpHVw==
X-Google-Smtp-Source: ACHHUZ546QAWG620tM0DrL7pIkD7dTBUOyNEbnZd87r8qDnEvQScGIE/IMSvDe2fAAwjHSL+uB0JRQ==
X-Received: by 2002:a05:6a00:2346:b0:662:def9:dc31 with SMTP id
 j6-20020a056a00234600b00662def9dc31mr474488pfj.3.1686705639705; 
 Tue, 13 Jun 2023 18:20:39 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:20:39 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@rivosinc.com>, Weiwei Li <liweiwei@iscas.ac.cn>
Subject: [PULL 01/60] target/riscv/vector_helper.c: skip set tail when vta is
 zero
Date: Wed, 14 Jun 2023 11:19:18 +1000
Message-Id: <20230614012017.3100663-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x431.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

The function is a no-op if 'vta' is zero but we're still doing a lot of
stuff in this function regardless. vext_set_elems_1s() will ignore every
single time (since vta is zero) and we just wasted time.

Skip it altogether in this case. Aside from the code simplification
there's a noticeable emulation performance gain by doing it. For a
regular C binary that does a vectors operation like this:

=======
 #define SZ 10000000

int main ()
{
  int *a = malloc (SZ * sizeof (int));
  int *b = malloc (SZ * sizeof (int));
  int *c = malloc (SZ * sizeof (int));

  for (int i = 0; i < SZ; i++)
    c[i] = a[i] + b[i];
  return c[SZ - 1];
}
=======

Emulating it with qemu-riscv64 and RVV takes ~0.3 sec:

$ time ~/work/qemu/build/qemu-riscv64 \
    -cpu rv64,debug=false,vext_spec=v1.0,v=true,vlen=128 ./foo.out

real    0m0.303s
user    0m0.281s
sys     0m0.023s

With this skip we take ~0.275 sec:

$ time ~/work/qemu/build/qemu-riscv64 \
    -cpu rv64,debug=false,vext_spec=v1.0,v=true,vlen=128 ./foo.out

real    0m0.274s
user    0m0.252s
sys     0m0.019s

This performance gain adds up fast when executing heavy benchmarks like
SPEC.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
Message-Id: <20230427205708.246679-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index f4d0438988..8e6c99e573 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -268,12 +268,17 @@ static void vext_set_tail_elems_1s(CPURISCVState *env, target_ulong vl,
                                    void *vd, uint32_t desc, uint32_t nf,
                                    uint32_t esz, uint32_t max_elems)
 {
-    uint32_t total_elems = vext_get_total_elems(env, desc, esz);
-    uint32_t vlenb = riscv_cpu_cfg(env)->vlen >> 3;
+    uint32_t total_elems, vlenb, registers_used;
     uint32_t vta = vext_vta(desc);
-    uint32_t registers_used;
     int k;
 
+    if (vta == 0) {
+        return;
+    }
+
+    total_elems = vext_get_total_elems(env, desc, esz);
+    vlenb = riscv_cpu_cfg(env)->vlen >> 3;
+
     for (k = 0; k < nf; ++k) {
         vext_set_elems_1s(vd, vta, (k * max_elems + vl) * esz,
                           (k * max_elems + max_elems) * esz);
-- 
2.40.1


