Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51607709D7A
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 19:06:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q03XT-0002Au-Bc; Fri, 19 May 2023 13:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q03XJ-00029v-7I
 for qemu-devel@nongnu.org; Fri, 19 May 2023 13:05:01 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q03XG-0005UH-Hp
 for qemu-devel@nongnu.org; Fri, 19 May 2023 13:05:00 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3f42d937d61so33855725e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 10:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684515897; x=1687107897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BBI1EKXYVa+WMuYu7l3ZX5976guHRdH5nUfqC+4pCho=;
 b=vSmseuVKS6Pcki9dUs+hDKsDj5LH/PEe50J3O453cteuGX9FwoczU5sb9sAllS+CVy
 JdZjpW+/FxfM+LoDPc1MOOQSD6rBqcFC7pnG3Dzqyd7gl4pA/C2cGw33uTjhFYr5F8qa
 klZQP08Z18CMRNTFBmK/3W9aUVqqLm3jmBEb3Pe7tPSAsMXpV/dl9PRTMuImcpoVM/md
 EW+s8dsX3sOkJuVLlk/b2TgvjI0FM5n0/XpWZlBHGh7xiafdwMi/Z5Dpwr0vCMaeAIfH
 148l2CdNleTx+Eis7VWN5wyEyE/IF/KgrVyVCvhd6yLAnetKivz1+NmTDAAIBNi6C0IM
 6Jcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684515897; x=1687107897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BBI1EKXYVa+WMuYu7l3ZX5976guHRdH5nUfqC+4pCho=;
 b=YfriuakDmig8IrkeZCmchVRUJC9LgB1x3TUxSnOkEs7CoOAgMNeVqcITTsJWWv1gAM
 wvLz1PpY5Hfa6J+v0nzZYPPQbzj35Y/ANVkC3EliztN7+MXS9yjCaGj73ylqudyxOtJA
 gefg3PRXZswXW0zwFfVH/l1YJQLB/bTgNqG8FJlSGk5+4/g4Wdb4aXizzhRYlFbijPN0
 dfjlG2E272Rp6PFpPxzIOEEz3lkVPJOOIiR8zixvw/EGZqEFAtfHw2o7RiIaUTvLbGWa
 ZApxpsCchJFd3D9TGFzR4Ysft7VTY3yXG++rWBtRbZf2NwfStfi8jahVCGP072RuwxcH
 lljg==
X-Gm-Message-State: AC+VfDwH5Q0k7/51xHLR7pZCNAXeBW7CA3oKDOkHZeqmh9n6qQ8GcdTQ
 sNP0Il4CMXcZDobtFt0Uzlb6fw==
X-Google-Smtp-Source: ACHHUZ6AZsW9QVuKR3pyOaZXsLrnlVqSTirKilv1SQhyayMtGZt7OgDh1XUuMoMQRvIKfnBMIdZCEA==
X-Received: by 2002:a05:600c:ad2:b0:3f4:294d:8529 with SMTP id
 c18-20020a05600c0ad200b003f4294d8529mr1919989wmr.19.1684515896798; 
 Fri, 19 May 2023 10:04:56 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 h19-20020a05600c28d300b003f427cba193sm2930166wmd.41.2023.05.19.10.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 10:04:55 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 21BD71FFBE;
 Fri, 19 May 2023 18:04:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <lvivier@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marco Liebel <mliebel@qti.qualcomm.com>,
 Mark Burton <mburton@qti.qualcomm.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH 3/8] plugins: update lockstep to use g_memdup2
Date: Fri, 19 May 2023 18:04:49 +0100
Message-Id: <20230519170454.2353945-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230519170454.2353945-1-alex.bennee@linaro.org>
References: <20230519170454.2353945-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The old g_memdup is deprecated, use the replacement.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/plugins/lockstep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
index e36f0b9562..3614c3564c 100644
--- a/contrib/plugins/lockstep.c
+++ b/contrib/plugins/lockstep.c
@@ -130,7 +130,7 @@ static void report_divergance(ExecState *us, ExecState *them)
         }
     }
     divergence_log = g_slist_prepend(divergence_log,
-                                     g_memdup(&divrec, sizeof(divrec)));
+                                     g_memdup2(&divrec, sizeof(divrec)));
 
     /* Output short log entry of going out of sync... */
     if (verbose || divrec.distance == 1 || diverged) {
-- 
2.39.2


