Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B949B7441CD
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 20:06:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFIUC-0008Q1-9o; Fri, 30 Jun 2023 14:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFITy-0008IQ-58
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:04:35 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFITu-0006zW-Bx
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:04:33 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fba8e2aa52so24001285e9.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 11:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688148269; x=1690740269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cf5ti9xDtG3D2s3Jcs/OJus8Ga0lob29HRcRChdiZSs=;
 b=A9B0umKu17kCfIRcTjlCXjvN428jQJ9E2iSAYiiWybN21JmxjpQIpW71X4jnvbHuNR
 YYVv41/Tz7Qo037SU98diqxZfVf05EFtLDyNEBolr61Eac/MzmHBYr06vb8df4Pj50AS
 qjU4vgGMY+eVB2MID1X56eNsoltOoJGUAKZ2p13wUP3vZ2+g5JG1LAwt/F78fn7ZkQ0h
 7g/L2xeGmNNiJqD9r84OEsys5dEm8V1o7lYJjZ/xEjq5MI8IDSlUPRNfw/MU2jL0WPK2
 nu1Ip9vVRpNgOJjuoINU3co4cnCLlVYTwEWmzHdPObe9Apfhqet3jfiFHw+QufBBDzVK
 O7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688148269; x=1690740269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cf5ti9xDtG3D2s3Jcs/OJus8Ga0lob29HRcRChdiZSs=;
 b=ZTu63LQfXSOVT0GeJ/vRRll50NUVFLbOmZtWPJhZZWellAzUmwCoV3H3+aOmfUacac
 E/djXOG8NrPjkeOX+wExxN4nUSYzfYJmHR1ZbMIB98Sub6bu+/CffcpNs8yvU+LQtxOJ
 a363Erm7k8atpqOsnDBjXODt0fa5cmF4EedLwJw+Yeq+iERm1PM4TPgxkPeWDJfwyo+e
 n22ubK4vi5QN2wb8RLc8lhDk9mVsttQnZ2bIi7QGAENiNtHEyEnkxZhx1SQqtMYzfNX3
 NI92fvDUIvHe0X8tOJ53UAMpSDObsiXXQRO/DsYydAntv6r60ucsbOWhzWDuWyQ/DKCq
 HVKQ==
X-Gm-Message-State: ABy/qLYUYQRPuyLmjn2OtKuAWzjKfhz/slbJGaVQU8umoA740p0TPsuT
 XpHSOJwIc09UZ9WWyxkRJBr2wA==
X-Google-Smtp-Source: APBJJlE0g420/apBhX/CForptyjM13O9cnMv95O7ECwA1a96Iy01svRQdHA8zsB4CCnrtSZrgH+8hg==
X-Received: by 2002:adf:fe02:0:b0:314:1ebc:6e19 with SMTP id
 n2-20020adffe02000000b003141ebc6e19mr2320847wrr.64.1688148268923; 
 Fri, 30 Jun 2023 11:04:28 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 z3-20020a5d4c83000000b0030497b3224bsm18740547wrs.64.2023.06.30.11.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 11:04:26 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F0F111FFC4;
 Fri, 30 Jun 2023 19:04:24 +0100 (BST)
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
Subject: [PATCH v4 10/38] Makefile: add lcitool-refresh to UNCHECKED_GOALS
Date: Fri, 30 Jun 2023 19:03:55 +0100
Message-Id: <20230630180423.558337-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230630180423.558337-1-alex.bennee@linaro.org>
References: <20230630180423.558337-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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


