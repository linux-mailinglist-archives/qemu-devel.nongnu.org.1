Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8707847F6
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 18:48:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYUXw-0000uT-Bz; Tue, 22 Aug 2023 12:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYUXu-0000qm-Lm
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 12:47:58 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYUXs-0007aY-2W
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 12:47:58 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-319559fd67dso4348805f8f.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 09:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692722874; x=1693327674;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nhDJBqjiKmEn8OS20y2CrcXS76BIo8bD7ttV1TCMgtk=;
 b=B0QtXBU6Wd35mvnJn2PSBlPK8fkUnQOrIsxGoOinQDj6+rMviYc/FE3KYzdVlcUhpk
 6sOtngo4Cav3N2flw6eMlMtDE54Ld2N0/I2ZxGyFXeo90xV13FsVRDEUo1DMFhAZ7BZO
 +2YokZg9FUqfZe0mNmDZEV3XcrIFxZ9OqJuYZYfMKLQ9ZzN7SSbhOeRPAgG/nXEtQ6AD
 9CymdCrcWRfweW1mWK9l96ixx58Xp9Tk/t0p7KkMfPZKHFukPaeC9Gm2s/j4As39JZyx
 1AB8tzNan1hMqsRXNZRZiWOFqmii8XES8iMNFQzoZ9zDWWBeyp9m8lDjlTlXLCn1qtBr
 UgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692722874; x=1693327674;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nhDJBqjiKmEn8OS20y2CrcXS76BIo8bD7ttV1TCMgtk=;
 b=eTV0iBKoRVNPLOF+tA3YWmdfsN1SVZhqivH4kqNYBmm+Rh/Orrdxtvd42d8yQcWPfx
 Mfni9MtDpg11qVE86RKBieSwobxKtV2QrMonZPDE+E0zKelnccMEVmy4MEbZ7P0kwyIC
 /yl7XJzArEuH68OQp4HAVmqZbGA9Tjo47IUbKyEYCdaOG38mcztalVvng4HvnpADR2Dd
 iZtZCkFUYdYpK5AWyc9dKI7aFtI0CpYHYu2AR/WUtI/7DR+qxinmlGXZ6F0DBHGlFEzT
 0K8/4Iy0bYLfJvNIit/xTKiXWkS+I90OixGxkHde8X/40q45TBefIj0TAetJJUI8QCHX
 M8AQ==
X-Gm-Message-State: AOJu0Yx60NGyi8iQVodA+GBG3ulsT7XF9uIiJUrJFiix17nRjMHZw/2c
 1PhxAi6pWXKB1KnikDA3+fL7L4dq2fuoK92sJ72oyg==
X-Google-Smtp-Source: AGHT+IHSaPJZkioke5WO9lYkv/xZ1AZsFOCKEds/YDrflxtd9dJN+PvWVpewDjP5SRo4XjJnDGvvrw==
X-Received: by 2002:adf:d0c1:0:b0:319:8333:a2d4 with SMTP id
 z1-20020adfd0c1000000b003198333a2d4mr7830556wrh.29.1692722874084; 
 Tue, 22 Aug 2023 09:47:54 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 x9-20020a5d4909000000b0031c5e9c2ed7sm3534036wrq.92.2023.08.22.09.47.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 09:47:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH] target/loongarch: Sign-extend REVB.2H result
Date: Tue, 22 Aug 2023 18:47:50 +0200
Message-ID: <20230822164750.72497-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Per [*]:

  The REVB.2H instruction performs [...] and write the 32-bit
  intermediate result sign extended to the general register 'rd'.

Add the missing sign extension.

[*] https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#_revb_2h4h2wd

Fixes: ad08cb3f97 ("target/loongarch: Add fixed point bit instruction translation")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
RFC: Totally untested, only noticed during code review.
---
 target/loongarch/insn_trans/trans_bit.c.inc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/insn_trans/trans_bit.c.inc b/target/loongarch/insn_trans/trans_bit.c.inc
index 25b4d7858b..a98c46d8cb 100644
--- a/target/loongarch/insn_trans/trans_bit.c.inc
+++ b/target/loongarch/insn_trans/trans_bit.c.inc
@@ -121,7 +121,8 @@ static void gen_revb_2h(TCGv dest, TCGv src1)
     tcg_gen_and_tl(t0, t0, mask);
     tcg_gen_and_tl(t1, src1, mask);
     tcg_gen_shli_tl(t1, t1, 8);
-    tcg_gen_or_tl(dest, t0, t1);
+    tcg_gen_or_tl(t0, t0, t1);
+    tcg_gen_ext32s_tl(dest, t0);
 }
 
 static void gen_revb_4h(TCGv dest, TCGv src1)
-- 
2.41.0


