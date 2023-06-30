Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 613987441FF
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 20:17:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFIcj-0005Pb-D2; Fri, 30 Jun 2023 14:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFIcg-0005Nb-Hd
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:13:34 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFIcc-0003Vp-VE
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:13:34 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3113da5260dso2418991f8f.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 11:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688148809; x=1690740809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xR5/t5x9pG5u9j5MsPviyFWbyRXcbAYZ+kVu5BRUcF8=;
 b=CWYCfDjoWFn5LOXEL4IUnzJeVYCxoZiFOY76PNqN2I2UXkVzC4FHqmb0fqXGa6lIC8
 Ne/5/J6CWo+qZ3yLDneHii1wTtzRnohO8othGeND2rpzUc4l+AW7VbdZUY0wweXMCfT/
 xwZDrftVNiB/hBgkByh05i4mHX8W0K3z3NQl75haDXECyOFJkvoOb89AFAdYBfB8KDmG
 ntNMsni79X+P0SYk1/7F4lX8yJycGL/6H+M/2m+lVxD82vBVuxk158e2qEcfUimDH+L/
 qyirYwXKmcryN8SO4bttAphRD9yPihu5YSa73Mkyy/xNA8bi5hrQTv8AbSTGJOuVmqA2
 6M7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688148809; x=1690740809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xR5/t5x9pG5u9j5MsPviyFWbyRXcbAYZ+kVu5BRUcF8=;
 b=VUy1BZFhfvNUCc/dLynBjTh501iPXfgE5/LLyV9QSGGCh+CND0Ms6mbhi1nvWfN/6S
 nomfkwXSAg/LoahHmuJa+iAdyaBNp5p3oWBuLPyXRcaOZdx5C/ePc2DGZL3fZQOz5N1E
 qsRBzT86btGM+zLnA+GgRQZf516EpkgoUrKGdgr+oq+nkIXx73oP7F88EO8U5ztqUgkD
 so6GAK+PJC+bmb7ZT7rR9H3NV0Qxka6GhHafzKUne/iAkno5nS9VBT2ty88vKK3GP6mY
 0ZbqOt+KcKm/yrZ/dMBRT7PL+hNas/izQ5wWzfQacUBUT9wb86yoCKGKtWhg+Agkoo2y
 kq6A==
X-Gm-Message-State: ABy/qLYkztwq6m06nyiD25045Wy6K+0vMt55jKdG52aDfmaggrDuHp1Q
 DDyjD1QUKFxWeFs5Yp3/sLY6ag==
X-Google-Smtp-Source: APBJJlHxTWMacI8e6IiujnyPEAWSVN4i19EpDRpNrlYm+yHAZiV5Gftr8IoOhRLQhyHJJCduv6Ifjg==
X-Received: by 2002:a5d:6a49:0:b0:314:7c0:c406 with SMTP id
 t9-20020a5d6a49000000b0031407c0c406mr2771790wrw.40.1688148809452; 
 Fri, 30 Jun 2023 11:13:29 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 a16-20020adfdd10000000b00313ef2150dcsm15111904wrm.45.2023.06.30.11.13.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 11:13:28 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6C88B1FFCC;
 Fri, 30 Jun 2023 19:04:26 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Riku Voipio <riku.voipio@iki.fi>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Bandan Das <bsd@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-arm@nongnu.org,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>
Subject: [PATCH v4 21/38] plugins: update lockstep to use g_memdup2
Date: Fri, 30 Jun 2023 19:04:06 +0100
Message-Id: <20230630180423.558337-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230630180423.558337-1-alex.bennee@linaro.org>
References: <20230630180423.558337-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230627160943.2956928-20-alex.bennee@linaro.org>
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


