Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7759F73B72A
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:27:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfoR-00065m-A5; Fri, 23 Jun 2023 08:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfn3-0003pT-Nt
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:21:27 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfmp-0003gz-V5
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:21:20 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4f4b2bc1565so725650e87.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687522863; x=1690114863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FoyMsMYVxFV6o67+0YaZUwlfroq/Nmrav1p8dT4axmo=;
 b=rkmJhJvbLfSBkC6UZiSc4YpDplSh9i5qRgkDdZtpEHreHswl0y/Er9rCKE9zGXUgUp
 58GgPUN0VMbZ3CQiLFzmHzwsvKQ0jevIw+tQbXJydKSXOJONbHm2PCU0nyZ2nuMy1SxF
 PgTZLpd/m/3SRFF3BaZLtraTM8N5lfvRBpM0W8h94CXWi4vAh5CZB0ApXtLabH20j8Gt
 6b48w6SJQGCefb01W9njZMq5MPPn+wbscqEadXPavNC46KEnF1bQAaFV7SEQ17qk4tED
 oGiwFuptxwAU2jIewsxkuEQ+xjW91r85fAmXz5M8P7BwHbZFsTdBQsx+L+JpyQ4dHiwQ
 Cl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687522863; x=1690114863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FoyMsMYVxFV6o67+0YaZUwlfroq/Nmrav1p8dT4axmo=;
 b=Phw3RFNPvTenTnSxBk77g4IT0d9vpTgt4lA+1GPIq6+xi1ZtG2g9inhQf3A0OFbWr6
 enNiC+n0IHkTilqmwKDQMNZolG1zbUwlAZzeWs3AlpIuGAUDvdGLD4udBA0Cq3Nd7g8x
 9xI7agq4MvzPJYaHvidHpCeG3TzUqTK/SD74Gs83OaojKbbagvXO+7dBdFc8GSTjM1D/
 Mh40DdyrzyTp7DxH539PfhjEiaZemASSGJITMR8ntnQ/jZLYUegqs/0PS8qKc3fhXi7V
 bVob4wTfmrhsh7gWJLlyAA2TQ6rjBAQExQNG79l2abyOLqLzjw1wOWPbURp8EeLAg+uG
 ROVg==
X-Gm-Message-State: AC+VfDzHnj1JXUqOiOwxSSxv5a0N73vfta1Ws8iWlimC879lniAezDk0
 8VHuMQf55NO7Is/p3TxQb/rhwg==
X-Google-Smtp-Source: ACHHUZ7VdkewIlvHyP253hy5U1IFrs25E2VQQVYSKU8iLYWpsBA+29W3Z1DXYwI2UNc4izBB2SS8FA==
X-Received: by 2002:a19:6404:0:b0:4f8:680a:68f8 with SMTP id
 y4-20020a196404000000b004f8680a68f8mr9713154lfb.41.1687522863762; 
 Fri, 23 Jun 2023 05:21:03 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 d11-20020a05600c3acb00b003f7f475c3bcsm4073048wms.1.2023.06.23.05.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:21:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3191B1FFC1;
 Fri, 23 Jun 2023 13:21:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Xu <peterx@redhat.com>,
 qemu-arm@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Riku Voipio <riku.voipio@iki.fi>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Bulekov <alxndr@bu.edu>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 06/26] qemu-keymap: use modern name for Arabic keymap
Date: Fri, 23 Jun 2023 13:20:40 +0100
Message-Id: <20230623122100.1640995-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623122100.1640995-1-alex.bennee@linaro.org>
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x134.google.com
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

The very old compatibility alias of "ar" has been removed from more
modern versions of keymap. Lets move with the times.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 pc-bios/keymaps/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/keymaps/meson.build b/pc-bios/keymaps/meson.build
index bff3083313..0bd8ce0077 100644
--- a/pc-bios/keymaps/meson.build
+++ b/pc-bios/keymaps/meson.build
@@ -1,5 +1,5 @@
 keymaps = {
-  'ar': '-l ar',
+  'ar': '-l ara',
   'bepo': '-l fr -v dvorak',
   'cz': '-l cz',
   'da': '-l dk',
-- 
2.39.2


