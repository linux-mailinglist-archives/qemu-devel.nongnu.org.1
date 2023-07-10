Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA3D74D5B0
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:36:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq4v-0001qf-Lh; Mon, 10 Jul 2023 08:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq4t-0001eQ-29
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:33:19 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq4r-0004B9-Dg
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:33:18 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6b7279544edso3448776a34.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992396; x=1691584396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nx6zy7/g+funZBuInErBC+VGh4fTRJeT9B6wyaMsPCw=;
 b=Usw95/KUI1GEfSFpkV+GUDT2yQnVRB8JtIK7VvoFChYCg3utsjOyPp8KhAYSIOJCRY
 oiGFumq2F+Suih/ihDFgFiX/Ebc3MUhq+/cFLXEkMonYANblIlFOzsSN0PH550RXqdjn
 Z242yf2E/boAxpzYFDzd83Jh4jEpK4NS7u89XeBh+HGvWTzw8V7LhJbgiTnu4gTpkVa4
 yYPnMGAKuucSYlF85sm7BbVy6prcmTiBQ7S6qV7/A6lagOyAJv89b1hMYOKjO2rUnpGT
 u+Wxn4xsoWjObVtwD7yHF66wHo0fr7JbjtA0KZFNTswFlPPN95qHvn/KSOhY61KJ9YLo
 z7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992396; x=1691584396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nx6zy7/g+funZBuInErBC+VGh4fTRJeT9B6wyaMsPCw=;
 b=AyGmkgrxRgwiqqof03pI2sibhxYdph8akPGzm8VSLRCxvbna+kYtw24heH+N1eHBP/
 Aq+1PxipBTOUD0+qX3Yi+UepoLdMx0QbeHDDfLDYOJtaqJ5O5PPWz50mppnBQbYOEoWe
 zkj60Ehyp4MWUxKJkfsSw+49yjJZxxuX4bmLS0lqjEO4AjaFUWlVVt/2jyz034c4z8xp
 IAvvVbCnIRuy8xNJgf8ABvA3fu4mTiriqARgTp01pSS5bOoJRY/JmtzHNKnh/jXImZIi
 zndrINxWFGwh9jCKc/ozPXHkf9L0INL5/N4AY04+jW+MDAj4cn5S+UtZ+ud4pF9eDDR1
 QRWw==
X-Gm-Message-State: ABy/qLbxRvjmcGQJcvuAuBCOLmq1ZPA+QTMxsLJAHp59ztWvxKbN7MOk
 gx1mWGvzn8Z2C82KOZfhxlMW2BZI735huQ==
X-Google-Smtp-Source: APBJJlERIKTlH1lcaKo63952PZNNGzAxopTTbt7RRUHjY/20XbaFY2aUhKLpOyaCt0xmHNbNl8jqOw==
X-Received: by 2002:a05:6830:1550:b0:6af:a0d7:1819 with SMTP id
 l16-20020a056830155000b006afa0d71819mr10791248otp.28.1688992395802; 
 Mon, 10 Jul 2023 05:33:15 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:33:15 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Bin Meng <bmeng@tinylab.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 16/54] tests/avocado: riscv: Enable 32-bit Spike OpenSBI boot
 testing
Date: Mon, 10 Jul 2023 22:31:27 +1000
Message-Id: <20230710123205.2441106-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=alistair23@gmail.com; helo=mail-ot1-x336.google.com
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

From: Bin Meng <bmeng@tinylab.org>

The 32-bit Spike boot issue has been fixed in the OpenSBI v1.3.
Let's enable the 32-bit Spike OpenSBI boot testing.

Signed-off-by: Bin Meng <bmeng@tinylab.org>
Message-Id: <20230630160717.843044-2-bmeng@tinylab.org>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/avocado/riscv_opensbi.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tests/avocado/riscv_opensbi.py b/tests/avocado/riscv_opensbi.py
index e02f0d404a..bfff9cc3c3 100644
--- a/tests/avocado/riscv_opensbi.py
+++ b/tests/avocado/riscv_opensbi.py
@@ -6,7 +6,6 @@
 # later.  See the COPYING file in the top-level directory.
 
 from avocado_qemu import QemuSystemTest
-from avocado import skip
 from avocado_qemu import wait_for_console_pattern
 
 class RiscvOpenSBI(QemuSystemTest):
@@ -21,7 +20,6 @@ def boot_opensbi(self):
         wait_for_console_pattern(self, 'Platform Name')
         wait_for_console_pattern(self, 'Boot HART MEDELEG')
 
-    @skip("requires OpenSBI fix to work")
     def test_riscv32_spike(self):
         """
         :avocado: tags=arch:riscv32
-- 
2.40.1


