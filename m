Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 692457400AF
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:18:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBMG-0000zx-Oh; Tue, 27 Jun 2023 12:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBME-0000y9-1I
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:15:58 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBM8-00087M-Tk
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:15:57 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4f973035d60so6282343e87.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687882549; x=1690474549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1/YdtjXXo0e3CzVmNtcCXnVaZZ7ekw+aGjDVemCbNnQ=;
 b=NMBk7ziGTqFekAol9iS/ZfDQgdosHXTAj5emIIWYF6BkCrWy282cAY/StBSGAtNcRI
 w2TpYbbA66jFvWkMHeI8JcsP4iDy+yi7QKnhILoVcDEdqaoZ4GTOmUHwh4rd06165+PX
 BwE695mYIq07uU8oP6tTfaeVw9TSGh/OSfRXp1YrIFD2M2sA4FM0T+Sb3D95V9pNeIYv
 wYUV7AgyaAnW5N94fG+r577zQXGk7ufWd9iMcUspKkFLQV58o2DHXLVacBf7Z5dFfBkd
 8Ce8g3+w8LduqDxhRbFWQzMHmGcsRpEOfvFhgh+OH3eNej5azu4/xrMN0+HeUZROxU7f
 /sKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687882549; x=1690474549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1/YdtjXXo0e3CzVmNtcCXnVaZZ7ekw+aGjDVemCbNnQ=;
 b=J09s2hI3Ao7w3ZjZVywIqehUfLuxTIah/6TdwICSIAdFi1SxBu9W+XCWqN9SbVz9vg
 U4j6lZqmd6Zf/utY9eoL/kL3fv3lCitJvlE2i0OxONQGKmZM0XKrqYomtKmWpikTWGfX
 aPGrWW17fb3EYWHOR49p+voKvj8DoZdnk5G2WjbdwtsyU1ZHP6t/HYysUjvbEg30/h6r
 BOB0nuQuGTURAE9noDRb8+/fOuOh+5B2cwXbrVHuk3HGlQQEgb7CLBn4mledbwwVn+ZB
 nMYu2nagMhSfoVPUDPsPswtj6z5FI5FLuQhBa82r2IT8yXxCcgkxxxBmtwP9cPcOQrEv
 hSDQ==
X-Gm-Message-State: AC+VfDxMRhqfv+omq+jx5277u7cfdUvmGrcNdTCsgfvDugtHF2HWIK9z
 OAOvpXprZosXYjPBpFJQZTq2Qg==
X-Google-Smtp-Source: ACHHUZ4fCc/4niMbcLJav+I6bWWkuxWogaXgsA7T6j79z/HVwspYzz5Jt4/k2gxGTk6UFA49DB4LNw==
X-Received: by 2002:a05:6512:3b0b:b0:4fb:81f2:4228 with SMTP id
 f11-20020a0565123b0b00b004fb81f24228mr2704299lfv.31.1687882549560; 
 Tue, 27 Jun 2023 09:15:49 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003faef96ee78sm5067377wmm.33.2023.06.27.09.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:15:49 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3A7141FFCD;
 Tue, 27 Jun 2023 17:09:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bandan Das <bsd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Laurent Vivier <lvivier@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 19/36] plugins: update lockstep to use g_memdup2
Date: Tue, 27 Jun 2023 17:09:26 +0100
Message-Id: <20230627160943.2956928-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627160943.2956928-1-alex.bennee@linaro.org>
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12d.google.com
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


