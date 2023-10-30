Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAFF7DB634
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 10:33:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxOd6-00055S-FJ; Mon, 30 Oct 2023 05:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxOcn-00053D-VL
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 05:31:59 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxOcl-00085f-T6
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 05:31:57 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-507bd64814fso5867995e87.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 02:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698658313; x=1699263113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RWD+Q1YVy6ObxkURlxo4Jv/GQ6fVH1MoEaeLTgb/P7k=;
 b=Et4PfBXfu0eoxKsaW1ShOQz2lwwRaZR1aq8tSj3jF5FGO1/Sb/idUz/C6q+DYNQOeW
 ojSLWet7C0sibU/7Sbe/iZe+x4HJx0pUiBr+HhfhHFk9pPUzwkWXtfkq9Z6IDCoB2Toj
 A6Dg2ZqHDR2ebt/4HYkyP+nO017MVPPPsuJ8oCx9zxEsX4qS3SK9BvqBgLPiNg0AkgN/
 StR/FsuBVbfnuTpA/6yp+uYFfGbUHdiGR1yGI3s7LK6BUhtnJWc3xpt525zqjWcIqSZb
 CHY7rVlbnF9k4D8B/YAOKmbuz9BkvnXYAccgWvt7JS/9rwtuJQgZBXkGAGt7UZglcKgI
 aBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698658313; x=1699263113;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RWD+Q1YVy6ObxkURlxo4Jv/GQ6fVH1MoEaeLTgb/P7k=;
 b=wvkBKGlHf5d8aEKAhhvcE7WlUDhC0jwffgvXizWgaycPtG601VR/QuuVTNMyQnCpi/
 e9gBGV/0xEF083nzczFZyG3it2libAuKDqvliSO/6PFR1YNAKSzN1syNWE65gnwc3e/1
 mHdm3Rl1q/midRd2nmVQrVW/8tH1+OzLRiY1idpSrn4t3trSEvlF2OiZqFyhcS+Ifq4Y
 eJQUB9hSgfiZlETyT/95FxhmfAIWl+kwaOfpFLofws13IHDmyKxtXJ8BNOGeeVXvnrP8
 e/94Stu5CahS3LeeS7jBNohSfFD0el7ak03Ko+1o1dua3JWgXB9I96F8VhX8OcCzFN6n
 fLwA==
X-Gm-Message-State: AOJu0YzDZN5oT8SlLKDj54VPh4Lku+tQxy+Mm7fP2qlTbBgwPsUYg784
 a+GjjweIv7lOOBMgoIPBhL2UGYM3/3M3Th13hS0=
X-Google-Smtp-Source: AGHT+IEVDRG6p71Qw/YxQUmYdfhTM/P3oeBbo+q1sLXwwfVKy+aRVEtzU0QLKBiwr5yctVDPhSWIXA==
X-Received: by 2002:a05:6512:3991:b0:507:b911:6706 with SMTP id
 j17-20020a056512399100b00507b9116706mr8252977lfu.25.1698658313425; 
 Mon, 30 Oct 2023 02:31:53 -0700 (PDT)
Received: from m1x-phil.lan ([176.170.212.50])
 by smtp.gmail.com with ESMTPSA id
 m11-20020a05600c4f4b00b0040651505684sm8730647wmq.29.2023.10.30.02.31.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Oct 2023 02:31:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/s390x/cpu_models: Use 'first_cpu' in
 s390_get_feat_block()
Date: Mon, 30 Oct 2023 10:31:50 +0100
Message-ID: <20231030093150.65297-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
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

We already have a global 'first_cpu' variable storing a pointer
to the first CPU, no need to use a static one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/cpu_models.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 4dead48650..540d445023 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -196,11 +196,7 @@ uint32_t s390_get_ibc_val(void)
 
 void s390_get_feat_block(S390FeatType type, uint8_t *data)
 {
-    static S390CPU *cpu;
-
-    if (!cpu) {
-        cpu = S390_CPU(qemu_get_cpu(0));
-    }
+    S390CPU *cpu = S390_CPU(first_cpu);
 
     if (!cpu || !cpu->model) {
         return;
-- 
2.41.0


