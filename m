Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E90C9EB660
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Dec 2024 17:27:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2w0-0002Rc-Rk; Tue, 10 Dec 2024 11:18:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2vz-0002RP-Gd
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:18:03 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2vw-0006Hp-Pc
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:18:03 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-540254357c8so1117922e87.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847479; x=1734452279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4AznEk9/hIp6KCRRVqDdnFfH0hvsbNa1L/nyYxE6eHM=;
 b=jrBH9JM/AjGV4doli5/PTEefgJFQNIE7/Cu/PBTxyRWrh7VaYfnKy8P4U3DQoGc+d5
 I3NsuTpslroFIGctcvS7hpSRcYQEsD0T1zik+kkc0yPjLlX+HFKDrvrU41lNu5L9MoKc
 ZviJG3XlRaL0a1M1JTs5v/Ek3JhWFt97I64DRuHe46rQjiWAWRFadpianKEfj3iS4sJW
 TLM2rlakQr/Qz/ZM+2KMEAyLazn8dmsLbgKRfAc3eDKZFXKzWvc7vjJiA36CaWJbB7SV
 IGp81awW/JQA21zIIEAoxWZuMInPXuTZdrfDx5YoBbB5eNUPb+H8DLIHiLUjHf0Jk0/O
 8kCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847479; x=1734452279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4AznEk9/hIp6KCRRVqDdnFfH0hvsbNa1L/nyYxE6eHM=;
 b=FBGecKCjJL59QENsUOJyB1NOg3JxNuuaZKu1SIvpPiwNHERpylk1B1Ut42k87y8zzl
 P3JjyEM+UhjWLR9kCZwYwp6GKxESZn2BQxangaOEQDbcAHd+eIyVoNMN1KaCRNNJeyVt
 YPqjQ8M2qM8ZtB6JdbQ54YQvEH+Hzn8aJuv3l52zYwJ1vp8kHFsxlObaIUy+YCIxMB20
 9Lk7kwyq4hHuJ2UF0YA+JUNG4nfK6TSkia1/fG0IncXt8fWP45oBq390mAHgZ0NtYDAo
 vIKcTLluUaIRTNC/5KwLDEM8r2Y++LgMJbTNjQLe8LcOLiEdUIOAMqdyVUoZc8dsrztK
 Il0Q==
X-Gm-Message-State: AOJu0YxOQIAUvsBwMXvKtrnMsHy5uOv2R/tJuQCX9hspmI5E0QMBJwmt
 WEfiEolGa+bCkb6qiBVZjZpBHO9Cym0m4UHI0MXHGUbmuEH466qRAMOtRROBnGgU1lmL5IJ2JEc
 eg8fIjgh3
X-Gm-Gg: ASbGncsbPLLitnlAhIj51ZtGsJdMYPcGm3TMr5Azb/SwfM45/OoXbmYdeDttrY0RMr7
 Keta8HNrHO52ciR/OXyFZyRFCu2kHQ+5NdFwcGuMmEMFlhDLL8BSDvAvAah659lbO5V+3LVSXCs
 2NIXIECOs3kKFiu+xdspJmYBatpc0z8EDufSbpjZEtAfXcvjO3Q5E3AF3bZKuVnaDihTSi9Pcl7
 8o3tBAiOvA04OEuK72tLZqizajr5YqM3yJ/aOe2lfOdDDzlxw5H7xE/M7U=
X-Google-Smtp-Source: AGHT+IFs9+b6r8m/OFd40yXuCpL3j7sB9g0YhwKis+d2zVl/QYAzOmP5l1CmjnmkxuqqVQkbc/G68g==
X-Received: by 2002:ac2:4f0f:0:b0:53d:ed69:a593 with SMTP id
 2adb3069b0e04-540240c24c8mr2002627e87.22.1733847478915; 
 Tue, 10 Dec 2024 08:17:58 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53f93377eefsm1026343e87.67.2024.12.10.08.17.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:17:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 04/69] target/arm: Convert CRC32, CRC32C to decodetree
Date: Tue, 10 Dec 2024 10:16:28 -0600
Message-ID: <20241210161733.1830573-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 101 +++++++++++++--------------------
 target/arm/tcg/a64.decode      |  12 ++++
 2 files changed, 53 insertions(+), 60 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 8b7ca2c68a..22594a1149 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7592,6 +7592,39 @@ TRANS(LSRV, do_shift_reg, a, A64_SHIFT_TYPE_LSR)
 TRANS(ASRV, do_shift_reg, a, A64_SHIFT_TYPE_ASR)
 TRANS(RORV, do_shift_reg, a, A64_SHIFT_TYPE_ROR)
 
+static bool do_crc32(DisasContext *s, arg_rrr_e *a, bool crc32c)
+{
+    TCGv_i64 tcg_acc, tcg_val, tcg_rd;
+    TCGv_i32 tcg_bytes;
+
+    switch (a->esz) {
+    case MO_8:
+    case MO_16:
+    case MO_32:
+        tcg_val = tcg_temp_new_i64();
+        tcg_gen_extract_i64(tcg_val, cpu_reg(s, a->rm), 0, 8 << a->esz);
+        break;
+    case MO_64:
+        tcg_val = cpu_reg(s, a->rm);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    tcg_acc = cpu_reg(s, a->rn);
+    tcg_bytes = tcg_constant_i32(1 << a->esz);
+    tcg_rd = cpu_reg(s, a->rd);
+
+    if (crc32c) {
+        gen_helper_crc32c_64(tcg_rd, tcg_acc, tcg_val, tcg_bytes);
+    } else {
+        gen_helper_crc32_64(tcg_rd, tcg_acc, tcg_val, tcg_bytes);
+    }
+    return true;
+}
+
+TRANS_FEAT(CRC32, aa64_crc32, do_crc32, a, false)
+TRANS_FEAT(CRC32C, aa64_crc32, do_crc32, a, true)
+
 /* Logical (shifted register)
  *   31  30 29 28       24 23   22 21  20  16 15    10 9    5 4    0
  * +----+-----+-----------+-------+---+------+--------+------+------+
@@ -8473,52 +8506,6 @@ static void disas_data_proc_1src(DisasContext *s, uint32_t insn)
 }
 
 
-/* CRC32[BHWX], CRC32C[BHWX] */
-static void handle_crc32(DisasContext *s,
-                         unsigned int sf, unsigned int sz, bool crc32c,
-                         unsigned int rm, unsigned int rn, unsigned int rd)
-{
-    TCGv_i64 tcg_acc, tcg_val;
-    TCGv_i32 tcg_bytes;
-
-    if (!dc_isar_feature(aa64_crc32, s)
-        || (sf == 1 && sz != 3)
-        || (sf == 0 && sz == 3)) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (sz == 3) {
-        tcg_val = cpu_reg(s, rm);
-    } else {
-        uint64_t mask;
-        switch (sz) {
-        case 0:
-            mask = 0xFF;
-            break;
-        case 1:
-            mask = 0xFFFF;
-            break;
-        case 2:
-            mask = 0xFFFFFFFF;
-            break;
-        default:
-            g_assert_not_reached();
-        }
-        tcg_val = tcg_temp_new_i64();
-        tcg_gen_andi_i64(tcg_val, cpu_reg(s, rm), mask);
-    }
-
-    tcg_acc = cpu_reg(s, rn);
-    tcg_bytes = tcg_constant_i32(1 << sz);
-
-    if (crc32c) {
-        gen_helper_crc32c_64(cpu_reg(s, rd), tcg_acc, tcg_val, tcg_bytes);
-    } else {
-        gen_helper_crc32_64(cpu_reg(s, rd), tcg_acc, tcg_val, tcg_bytes);
-    }
-}
-
 /* Data-processing (2 source)
  *   31   30  29 28             21 20  16 15    10 9    5 4    0
  * +----+---+---+-----------------+------+--------+------+------+
@@ -8590,20 +8577,6 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
         gen_helper_pacga(cpu_reg(s, rd), tcg_env,
                          cpu_reg(s, rn), cpu_reg_sp(s, rm));
         break;
-    case 16:
-    case 17:
-    case 18:
-    case 19:
-    case 20:
-    case 21:
-    case 22:
-    case 23: /* CRC32 */
-    {
-        int sz = extract32(opcode, 0, 2);
-        bool crc32c = extract32(opcode, 2, 1);
-        handle_crc32(s, sf, sz, crc32c, rm, rn, rd);
-        break;
-    }
     default:
     do_unallocated:
     case 2: /* UDIV */
@@ -8612,6 +8585,14 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
     case 9: /* LSRV */
     case 10: /* ASRV */
     case 11: /* RORV */
+    case 16:
+    case 17:
+    case 18:
+    case 19:
+    case 20:
+    case 21:
+    case 22:
+    case 23: /* CRC32 */
         unallocated_encoding(s);
         break;
     }
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 3db55b78a6..1664f4793c 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -45,7 +45,9 @@
 @rr_d           ........ ... ..... ...... rn:5 rd:5     &rr_e esz=3
 @rr_sd          ........ ... ..... ...... rn:5 rd:5     &rr_e esz=%esz_sd
 
+@rrr_b          ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=0
 @rrr_h          ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=1
+@rrr_s          ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=2
 @rrr_d          ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=3
 @rrr_sd         ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=%esz_sd
 @rrr_hsd        ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=%esz_hsd
@@ -663,6 +665,16 @@ LSRV            . 00 11010110 ..... 00100 1 ..... ..... @rrr_sf
 ASRV            . 00 11010110 ..... 00101 0 ..... ..... @rrr_sf
 RORV            . 00 11010110 ..... 00101 1 ..... ..... @rrr_sf
 
+CRC32           0 00 11010110 ..... 0100 00 ..... ..... @rrr_b
+CRC32           0 00 11010110 ..... 0100 01 ..... ..... @rrr_h
+CRC32           0 00 11010110 ..... 0100 10 ..... ..... @rrr_s
+CRC32           1 00 11010110 ..... 0100 11 ..... ..... @rrr_d
+
+CRC32C          0 00 11010110 ..... 0101 00 ..... ..... @rrr_b
+CRC32C          0 00 11010110 ..... 0101 01 ..... ..... @rrr_h
+CRC32C          0 00 11010110 ..... 0101 10 ..... ..... @rrr_s
+CRC32C          1 00 11010110 ..... 0101 11 ..... ..... @rrr_d
+
 # Data Processing (1-source)
 # Logical (shifted reg)
 # Add/subtract (shifted reg)
-- 
2.43.0


