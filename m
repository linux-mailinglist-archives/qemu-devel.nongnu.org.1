Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF74AA89639
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Apr 2025 10:15:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4bQx-0008Pl-Lc; Tue, 15 Apr 2025 04:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u4bQB-00083a-U3
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 04:13:32 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u4bQ9-0001z6-Af
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 04:13:31 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-224341bbc1dso46532065ad.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 01:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744704807; x=1745309607; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=31sA8ZoJNIVGckIUDC4jt2xxe297otB918AQ9sayA4k=;
 b=OVsaGVVET81oJmLFfdrhd0IamxYzr1PhdWstz5TOA5vb8HjERaApGMn8T/Pox+ki5F
 zK5ySesKkPLALxmw/zEIFiS0g5MAtxSTYe4GiL0tMLaks3HGGr1ANChZrSpebh0X7sMs
 gjDYYrKTIy/4T1TSIXJw3vdVhCS0o/fx4NzCf4Owr+120tfrel9N7uI+1FlObfbhTSvM
 YNlu5WFkDWaE7pykqBYLkhqCLJk9SObcZuRyyCpwwSLNz1fHuBCYjvIcBopYPvFcq+jP
 6i6ipdLYwRZLffS525aEB/IY1hOqG5gOidaxKdHeMQMPfNDsBqWkAyz8SrKlhAvEqEdi
 /c7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744704807; x=1745309607;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=31sA8ZoJNIVGckIUDC4jt2xxe297otB918AQ9sayA4k=;
 b=SI1AL2k5+/fLlTjpo727Qp3nfpoqmb8NbMYdiyVJnd6rHLz6QnFl0WKv9ah60TDUR6
 IP1J1jinWx91BCjQFA/VKKoOT6M3FDWZ9PcKOTOeSv9ANd9tbW75p/h173EYQU8lDifk
 zDxMIRJoXbgiw2La4zXTBjtKZFBntiE08JEJaYGRX2XDiArXPJ3mHY+ggs59n712Sf3s
 YmIqWmWVskagjIFk8pRgP2mnvadgBSIVW5N6gTg4nm6I6J4YBYwONOkOfhHET/c7mP9J
 bXoNB1cxooFQatLIC+AVRHHt+qrTqgGO0cc5dhO3fZwhw80Lyv+o657lz8ropDtC6p14
 O9bQ==
X-Gm-Message-State: AOJu0YyeTB/z2NCQvXld5i3sqKZOCXKoSBYH32MlxM/zeyGGOvBmzYPF
 RxKMZd/GvPIY01n9NMusJ1nDtZR3tFgb3MBO9OfGGh9w2sArSFKHIZ+bTQjS2lZWRofxynTJCMo
 XVBNfExWvOh5JxQ5jnDdosFWSW587oKurQhMThEI+Kpgxu6GP117JtH7CjhH8NQbXwmCRTrPTEz
 V/xyvaTFUChUVYaHoFLbPtEYmaNMSejoFeO6r1
X-Gm-Gg: ASbGncv0IrCEZWLkQIwHa6Xe3mdgJabERiztotdMnyVrKZ0CBz2PN0Ktla1RtIBDQ0O
 CsyBj3RdUQ+sf6F7gVbpRwQgq4RH9XVsVlFiVhH06W6HrO5Phd1R7j9VUxiNN00iR32p/R0S/Cj
 iK3MFzIm8Vw1FLONfndKV0pkZTu3iZgWMpSCNKbs8jQoPS/NsWJFhbqrt+Uns92Fp94agdl/IaB
 sFcC5GYq4HgB87LFb+3AXYrjKV0VH1c61QD1AzqKJpVPoguQer+XVNOok5el1TrNfSa9noxk/qY
 YiBlfkQkE267LEB+4VWrZF143CnrZuQqXaMo7r24WXpw0ke31SnbsBFnSgSX/Kc=
X-Google-Smtp-Source: AGHT+IG1cDOvUSZkXXjAg0Xikt2bJZC7MEeIsa5oZbWEIVSLT/jrN+9koPPH1yIIfjHY2bCEAnzAxQ==
X-Received: by 2002:a17:902:d550:b0:224:1ec0:8a0c with SMTP id
 d9443c01a7336-22bea4bd74dmr236155105ad.29.1744704806989; 
 Tue, 15 Apr 2025 01:13:26 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c95cd1sm111082335ad.150.2025.04.15.01.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 01:13:26 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 07/17] target/riscv: Add defines for WorldGuard CSRs
Date: Tue, 15 Apr 2025 16:12:21 +0800
Message-Id: <20250415081231.21186-8-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250415081231.21186-1-jim.shu@sifive.com>
References: <20250415081231.21186-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x634.google.com
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

Add CSRs for 3 WG extensions: Smwg, Smwgd, and Sswg.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 target/riscv/cpu_bits.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index a30317c617..7705c6995e 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -408,6 +408,11 @@
 #define CSR_DPC             0x7b1
 #define CSR_DSCRATCH        0x7b2
 
+/* RISC-V WorldGuard */
+#define CSR_MLWID           0x390
+#define CSR_SLWID           0x190
+#define CSR_MWIDDELEG       0x748
+
 /* Performance Counters */
 #define CSR_MHPMCOUNTER3    0xb03
 #define CSR_MHPMCOUNTER4    0xb04
-- 
2.17.1


