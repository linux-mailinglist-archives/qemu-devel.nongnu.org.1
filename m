Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2288673EE5C
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 00:07:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDuFO-0002jo-IW; Mon, 26 Jun 2023 17:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDuFI-0002dn-Jh
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 17:59:40 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDuFD-0004u9-L6
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 17:59:40 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-313e742a787so2019502f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 14:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687816774; x=1690408774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1/YdtjXXo0e3CzVmNtcCXnVaZZ7ekw+aGjDVemCbNnQ=;
 b=I7E8Pre15es8TOJfJ8KyIvALf9qJfOa+MHJW9yHzib485/MFM1BgPQbkuC1mjnONcW
 aETVXRTWZFT/d1Ho5nVtAHDhLCNhBZwYGOLa4mMPzj994XDkAG7wc/V1JoNfNsODJiK8
 OnygqkjnB5Tjeuj8jDhKqZX4CpXSmlAfN4SfHVXDrUD+qVh3LhL+sEBbEaF6N5JmRNiV
 LmK7THYimzxVLD1KUqIBqTIloLBMI0EjhaC2t52Mj1HvTmX+dwfc7/e6bL2qCB5ui0Hu
 IpYBijvSEgNZ82eYYs16WgBDCTL6Is1/swSAwTI3EH6O1FO5MydJplMm2ABzho+zs+G7
 cktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687816774; x=1690408774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1/YdtjXXo0e3CzVmNtcCXnVaZZ7ekw+aGjDVemCbNnQ=;
 b=W86flBN44j3gbbrRoT0CAHVclH9EjiePdlQELlixmN9KjZGasnyzByW5548vQgWbBR
 c5a2mHxJU8/CJ8+f81v0kXjKeIVKNNd6Zo5enGntuqnCSeM9xmBQYEIzjzOPAxf/P00q
 H4HXqDXrpDsN7z1AE0EQxK1gSgAjE+wjwmBfGkFcKa3zSjmcOmZ+GYLvGz21snR6HvQb
 XfJiqGdQgqycfVSiE50d/Lw2qULXLm8wDYz7BRl9yZmOmR4qYTXz2Q8fe4aDpAkTLIxi
 ORphlCHJ6I/BNzaer0iJXYvZnzaKuD8aw0KwJY3TVolWBlN7c2iMNMrvWXCF29HoaAnj
 PKfQ==
X-Gm-Message-State: AC+VfDyJZFBqHV+XWpJWvp0mo059roeX9Yi9EYvRqEAgkxoWnlvoXpld
 2w/m/mHYg33+wqA6q+kLvlu0Dw==
X-Google-Smtp-Source: ACHHUZ5R6UChdvwddCv4W9OXe00jGjvSGG0bjvW2eiMLWCg5aPFhYLH+/IcEsZr73Ab8A4zYM2rPCQ==
X-Received: by 2002:a5d:428e:0:b0:311:360e:ea3a with SMTP id
 k14-20020a5d428e000000b00311360eea3amr22828082wrq.34.1687816774274; 
 Mon, 26 Jun 2023 14:59:34 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 s8-20020adff808000000b00313e23edbd5sm8053448wrp.102.2023.06.26.14.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 14:59:34 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 39F781FFBE;
 Mon, 26 Jun 2023 22:59:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Riku Voipio <riku.voipio@iki.fi>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-arm@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 19/26] plugins: update lockstep to use g_memdup2
Date: Mon, 26 Jun 2023 22:59:19 +0100
Message-Id: <20230626215926.2522656-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626215926.2522656-1-alex.bennee@linaro.org>
References: <20230626215926.2522656-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

Message-Id: <20230623122100.1640995-21-alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


