Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B0B740095
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:13:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBGa-0000kt-DF; Tue, 27 Jun 2023 12:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBGN-0008Hl-QL
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:09:55 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBGH-0005nw-S4
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:09:55 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-313f18f5295so2735943f8f.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687882188; x=1690474188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cf5ti9xDtG3D2s3Jcs/OJus8Ga0lob29HRcRChdiZSs=;
 b=uAA9Wc3BHGhSifP+YwBHCxbLaCw9OF5tJ3c0nSaPINAhkDGACtO6o25z9+fkUr5f84
 fT7Ax1fymNtsXLoFRGfCZwgeaDrfEy9PvNy52CD/beq6BFUugXAw6zQDs50IutX6xPVV
 tCt/r6YWSHCVmSrWhD7NOjIMFkyPdLqe5wW3Yqg4mKS8lPeaHHipb8oBAXJ84LjoWkom
 k1eQI8k3C11T6q/eZpM9KS8qY/rEp/4tEsgNuqURrVBUQ8nxrP6pZdp2yZYq8WImMJCa
 oTue+vRMoYzJqMDhNxxJ9AJdO4EPEOgDODpTT+1fgNvd7+JLOipzLOzgKhg/HdEREFRV
 5ZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687882188; x=1690474188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cf5ti9xDtG3D2s3Jcs/OJus8Ga0lob29HRcRChdiZSs=;
 b=gfYaYNQhZFcX8Aqk8Xa13IKkGX2mfXjQJoYExwi5Bu0R1aOLkrHwRyNOJBRrmlCsOn
 cL15+/Zm/Dt15onSmkxTSweq4/RKKnphgpnZ67dbksrCWk7dSGdOXZSWrQh0WkAYCmxC
 LmkBweAvI7ZpLfN9uy/V8Kdx4getZxMzezXSSC0Tj2MNUJiOaOn212e58E6VqLqWvbAR
 twAsjAOMg23UbemaWHl6OkJgx1LnqB2KyqI/1Gv4JFfrAFmcM9EOBkqdjT3docNRV7vM
 5HUsPibiKcHEfX/0zmHRNksf3KV0YoXgkuFyV678iBPhOE6A+KVIl09MZ6fyTfUbukWm
 DrxA==
X-Gm-Message-State: AC+VfDx+yMGJMZys2wOiu34PDxNStb1RqLB8/oRx356LvqLlwCbvmQar
 oTK878M3uDd3DC7UxpqVgin0EA==
X-Google-Smtp-Source: ACHHUZ62C090FJDDn+BYBmn7eAXqWwYUXs7bXDsWjlGApbu+gQQEQOJHsPCPsdwMmutL9kUOGn43QQ==
X-Received: by 2002:adf:f787:0:b0:311:f77:6a91 with SMTP id
 q7-20020adff787000000b003110f776a91mr26071425wrp.31.1687882188070; 
 Tue, 27 Jun 2023 09:09:48 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 bf11-20020a0560001ccb00b003062b2c5255sm10812234wrb.40.2023.06.27.09.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:09:46 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F25DE1FFBC;
 Tue, 27 Jun 2023 17:09:44 +0100 (BST)
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
Subject: [PATCH v3 10/36] Makefile: add lcitool-refresh to UNCHECKED_GOALS
Date: Tue, 27 Jun 2023 17:09:17 +0100
Message-Id: <20230627160943.2956928-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627160943.2956928-1-alex.bennee@linaro.org>
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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


