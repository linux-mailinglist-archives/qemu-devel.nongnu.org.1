Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1E47E1F98
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:09:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxRy-0003u1-4H; Mon, 06 Nov 2023 06:07:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxRo-00038V-4f
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:07:14 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxRj-0004bB-Cz
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:07:11 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-409299277bbso30571595e9.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699268826; x=1699873626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GyckcOuF1Bcu5rrRcor+Uzyh2YOL0vEJEmdAm/ud3/A=;
 b=XXchG9uinSaSNBsq+eynnl/NeEh+o4Cqa/IGVup0SrQCMTjMy441TEZomKX5QpFsPn
 4it7aLf3FNJ4JTZyAdPi1xuh7xY7tIaaHZCjv+qBBAmGSWG0dx2gr4E4hztSyyC3v46b
 /p2YdA3HjrBTywt1hJRZWjMzZ4rpt7L/+Q0RQ7hUpbj1cQwABuFIhMFxx9Kt+47OiBzY
 rVaCO/RvQHB15lbfOwGnj39Ll5g7VlCKmkdDxMMkZ0Q9/V7EGA7UmJMX32q2qkCoBZEV
 h9dNUKlJbZTri3jjm28A5F+o+5bX0KKAd2GyYfv/ECerVC95OHOYaEloam8IB9P+Auzu
 /Iiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699268826; x=1699873626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GyckcOuF1Bcu5rrRcor+Uzyh2YOL0vEJEmdAm/ud3/A=;
 b=WLRNz/oi6tfBC7SBDfmAc8Ju0emKpJ+6yABJRsUwL5Wfa3H2o8vu+3djbjNU3Tins/
 QhGi84lCorjqUuXQi0dbzDlYdCLFFQsJ3u8Y+1oC+SHVIJdl0Bn0/vKup1eQCp75aqWW
 cDLAH9mWMBzq2aKMHjoxUk0t88EszqBoTsgd4Vl6dVtdMzK/wHtryUyE2MSag8Cucn7p
 3b8igrJ7KnFA8wFwqeWtaZ9dQ+kgqanNo8htu89J61vV37VhafgbGt+H/sL7G8TZDIlk
 ZLZ6mWOJsHSQoJp3ky/dDYwOWLZjw7P7bQvZOOQ4inx8+liR+U7I3PIQ+wX2cqPPURgG
 OFkg==
X-Gm-Message-State: AOJu0Ywy7f6OAJI5XaPTZO9Nc5y/bCZRDxM+p4GZtKZkK617geigWWcf
 LRzcx9eXU3sFF7tG17TG7ijV34wEvuh2HqqnC/U=
X-Google-Smtp-Source: AGHT+IFFKKaoUyusuMn43SnLhory9traUNVPbmAEOKUR6lhSW54LBkg8wsQBYrYSz3Gl8EhHfaGVqQ==
X-Received: by 2002:a05:600c:4f02:b0:405:3885:490a with SMTP id
 l2-20020a05600c4f0200b004053885490amr23785982wmq.0.1699268825836; 
 Mon, 06 Nov 2023 03:07:05 -0800 (PST)
Received: from m1x-phil.lan (176-131-220-199.abo.bbox.fr. [176.131.220.199])
 by smtp.gmail.com with ESMTPSA id
 k18-20020a5d6d52000000b0032da4f70756sm9120501wri.5.2023.11.06.03.07.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Nov 2023 03:07:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Sergey Evlashev <vectorchiefrocks@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [PULL 30/60] target/mips: Fix MSA BZ/BNZ opcodes displacement
Date: Mon,  6 Nov 2023 12:03:02 +0100
Message-ID: <20231106110336.358-31-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106110336.358-1-philmd@linaro.org>
References: <20231106110336.358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230914085807.12241-1-philmd@linaro.org>
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


