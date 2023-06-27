Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD4074006C
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:10:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBDr-0000HU-8s; Tue, 27 Jun 2023 12:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBDl-0000C4-0s
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:07:13 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBDe-00058P-F7
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:07:11 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-313f58d6652so2161065f8f.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687882024; x=1690474024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cf5ti9xDtG3D2s3Jcs/OJus8Ga0lob29HRcRChdiZSs=;
 b=Z4hB2YpIukhxvgKaUhkpQm8Pr4d70+dTWAqOHNF1IY2yCSYxFUGEO+XwBIA3D70827
 Hej9VFYP2g7/GJaNRuG2DdOaqXk5DbRnNBrTiNfWHis02V66KC3cWRJf9jUQ9FMQhqTF
 gyA8+dyLe9eKzwJYzMT1ECTW1v88sninlMbEzt+nr46MnAsd/JvisHkjo5xb43StJm/T
 cM9NZzmiydzWiwKfRCZKCLHRpepdf9dHBThojtWMVoRvtZ7g7JkDlJestUAfcFEls0F/
 3hi1vMKnDIX8ePS6g7+cilWxdbj7hCc6dctZ7wAvrCBOIS01WDv9umfNIqdF9BeEe27E
 Q2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687882024; x=1690474024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cf5ti9xDtG3D2s3Jcs/OJus8Ga0lob29HRcRChdiZSs=;
 b=HPehzzh8FUGYGAABV9kcouWU4HmGpdGxBiVhMb/MXakR1vlplpAqj51S7Mp3BWBF3t
 tWuzqNJLU+0sE7YcEHiEOvBTdEe06CgaXqv4oGQp0DiXIwmEu7WwgVWVNkPqrwOc4ofH
 bJrPY1BnPOJUFObkWB6bjWVteLPu4xLR7ge6vA+SONlgL83P04OTLZ84zxG/VEJEVprL
 BPrgc9a/9EETJhB/8fEeRyn72oATZkXpPKynxpUePButVfXEGlc0IUHJLh/LMLizfeRl
 MbMFkxTWQjcRX4oi4+IPyUq3wjyTENgpFyD5icNlrk4Q5srwCVPLPwRtQzvxcTGXIFgm
 CjkQ==
X-Gm-Message-State: AC+VfDzWpk23eURHO5pyd58CmYJkEXAkf+07S0bJhbLV9+vr0GWZSVBY
 mspO7QuLR8PjyNaz/rL7R+vAgg==
X-Google-Smtp-Source: ACHHUZ7r6rF1W6wkVeqHn/by9Vm34S4R9FPP4aRClBLGlhdCdL40WdulpIiU0DaQF6pyHWehXwqvwg==
X-Received: by 2002:a05:6000:c5:b0:314:12c:4322 with SMTP id
 q5-20020a05600000c500b00314012c4322mr1472102wrx.4.1687882024778; 
 Tue, 27 Jun 2023 09:07:04 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 da16-20020a056000197000b0031274a184d5sm10900882wrb.109.2023.06.27.09.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:07:03 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D74361FFC4;
 Tue, 27 Jun 2023 17:07:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 Leonardo Bras <leobras@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Bandan Das <bsd@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Juan Quintela <quintela@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Bulekov <alxndr@bu.edu>
Subject: [PATCH v3 10/36] Makefile: add lcitool-refresh to UNCHECKED_GOALS
Date: Tue, 27 Jun 2023 17:06:34 +0100
Message-Id: <20230627160700.2955547-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627160700.2955547-1-alex.bennee@linaro.org>
References: <20230627160700.2955547-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

This is yet another make target you usually run in the top level of
the source directory.

Message-Id: <20230623122100.1640995-12-alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 804a5681e0..5d48dfac18 100644
--- a/Makefile
+++ b/Makefile
@@ -28,7 +28,7 @@ quiet-command = $(quiet-@)$(call quiet-command-run,$1,$2,$3)
 
 UNCHECKED_GOALS := TAGS gtags cscope ctags dist \
     help check-help print-% \
-    docker docker-% vm-help vm-test vm-build-%
+    docker docker-% lcitool-refresh vm-help vm-test vm-build-%
 
 all:
 .PHONY: all clean distclean recurse-all dist msi FORCE
-- 
2.39.2


