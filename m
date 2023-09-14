Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D49579FF44
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 10:59:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgiBA-0000aq-AW; Thu, 14 Sep 2023 04:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgiB7-0000a9-Sy
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 04:58:25 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgiAx-0000QN-1r
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 04:58:25 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-99bdeae1d0aso92289166b.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 01:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694681890; x=1695286690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZY6bj8pOEE53hD8eYsi1398NGKLgp3tvJXGrO7CzlGk=;
 b=QZtRePtUv+0bfm+30yypjMKBQzzrFSLm+0r2fHn9zIsDGWfbkPdwbxG5mMklpOJYgn
 Km/P8PK9Cednqk51tkpyrJEZwyIc7Rhj77Ik/IeU0VuuyKDdVW674JiNJnUfbaR7B39c
 lxbeZcDPnT5apTmigoipwT1EqkwtuifjpKe2dOtXKOWh0bt4o/SprJInZUPGHI93jhY+
 EMovIKCwzKCyOOllyIitF64dJws17lGWGkSqo0UgWClDC2A1e2FOPLv+3+71z1cXgVSD
 dptYgz4r4QE/HqSDG3/EBc19FIytrd6TF0rq04Ux3dT/N+9KRDWaaL1GcMN95MhpWKWJ
 ReCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694681890; x=1695286690;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZY6bj8pOEE53hD8eYsi1398NGKLgp3tvJXGrO7CzlGk=;
 b=ovcdJaCQ0+ibaSqvmZ0PcWRTpX47+I8SwY88tjGYBexk1jzO1985wnmitzV38xmsT0
 bpUn3Ya8Xg3XGArtxOqQeDZYi+aN1Ylb2CHPzDuYM6cHcZN/2ABGuDzdwGtNfLWevhLU
 uQ7vyuNcEURwpWjVWGK44HMI/0PQTn1u+xz/0c5JO207p/u//3rTvf0y7t9p295PfIdG
 dghBccucJHsOfNPhWgjwus7R4ODXnLvKcvecDXTsvr8uwc8V+XPu33F0/vVQGm0j3obG
 fV9hDjjr+Lv5KyQZ0+EfYITQqc7UkR/dsTkNPiZcAGQyvLjwZbbjEu3KGUt4nlDjnWbh
 E8dA==
X-Gm-Message-State: AOJu0YxeacnpVJ02nMMATbTZ2tFkxAlzwtgucbR1S4CubpcILY/Rb6xw
 Cji10jB+Xqw4ZAv6NikzgbNkUfSy6AoKFC4Rtv8=
X-Google-Smtp-Source: AGHT+IE/PF0s7w2sm4x/aCHnZLCxE0fM5Dp6EvcAMgDVjVhWfPpt4awgsdfDZv6A1gpnKfosy6bZ0w==
X-Received: by 2002:a17:906:8a41:b0:9a5:c49e:7145 with SMTP id
 gx1-20020a1709068a4100b009a5c49e7145mr3943612ejc.69.1694681889987; 
 Thu, 14 Sep 2023 01:58:09 -0700 (PDT)
Received: from m1x-phil.lan (sem44-h01-176-172-56-29.dsl.sta.abo.bbox.fr.
 [176.172.56.29]) by smtp.gmail.com with ESMTPSA id
 mj12-20020a170906af8c00b009a1c05bd672sm692518ejb.127.2023.09.14.01.58.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Sep 2023 01:58:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ni Hui <shuizhuyuanluo@126.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-stable@nongnu.org, Sergey Evlashev <vectorchiefrocks@gmail.com>
Subject: [PATCH] target/mips: Fix MSA BZ/BNZ opcodes displacement
Date: Thu, 14 Sep 2023 10:58:06 +0200
Message-ID: <20230914085807.12241-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

The PC offset is *signed*.

Cc: qemu-stable@nongnu.org
Reported-by: Sergey Evlashev <vectorchiefrocks@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1624
Fixes: c7a9ef7517 ("target/mips: Introduce decode tree bindings for MSA ASE")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/msa.decode | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/tcg/msa.decode b/target/mips/tcg/msa.decode
index 9575289195..4410e2a02e 100644
--- a/target/mips/tcg/msa.decode
+++ b/target/mips/tcg/msa.decode
@@ -31,8 +31,8 @@
 
 @lsa                ...... rs:5 rt:5 rd:5 ... sa:2 ......   &r
 @ldst               ...... sa:s10 ws:5 wd:5 .... df:2       &msa_i
-@bz_v               ...... ... ..    wt:5 sa:16             &msa_bz df=3
-@bz                 ...... ...  df:2 wt:5 sa:16             &msa_bz
+@bz_v               ...... ... ..    wt:5 sa:s16            &msa_bz df=3
+@bz                 ...... ...  df:2 wt:5 sa:s16            &msa_bz
 @elm_df             ...... .... ......    ws:5 wd:5 ......  &msa_elm_df df=%elm_df n=%elm_n
 @elm                ...... ..........     ws:5 wd:5 ......  &msa_elm
 @vec                ...... .....     wt:5 ws:5 wd:5 ......  &msa_r df=0
-- 
2.41.0


