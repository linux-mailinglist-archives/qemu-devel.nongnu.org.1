Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E58B73B70D
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:23:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfo9-0005Dm-VV; Fri, 23 Jun 2023 08:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfn3-0003pX-Pr
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:21:27 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfmw-0003hs-D7
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:21:23 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-311275efaf8so549939f8f.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687522865; x=1690114865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vcsfGHCbHul0oRYFUr8ghI+TCa734UZNBqW4hxmvJxY=;
 b=SPXvYd4mezSEBv2WTGSrqRuK5vR7EsXrkhq6oDt5Etwps8/sZErBQBySRlOc/jlbUH
 DF5Qvug2f+tsTXz3kysAx4doLVT0czNq+gwPrpdqWQHvKMDRgQWcvXXgAlJ3lSWjRfjO
 n7mww229m42mNtHusQTXB3ReStHglLIUCKT6HYBYbjjL58zOLkaCttetqaZr9f3Qd00F
 Cc99/OoIcQVf6TEVrk57LbkG9XWA2o8MuodxItVqMMd7TdVGQzM3J4jsSlR5TLIdj4Lb
 eCJQEKcluha0a2aKOtjQIVLiRK9clNNQBDtcyI4f0GmUjXvouRErZ5mH3Vxv0HdMLpqy
 dNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687522865; x=1690114865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vcsfGHCbHul0oRYFUr8ghI+TCa734UZNBqW4hxmvJxY=;
 b=a7FkHncYwQsbfTRgki0Yo7nqXgsGnPRLePkviE9ZZ8aJ0PipQ/npMG6IwBOAuavOfy
 CMbLn1jCTUjaG4MOCZIRyz/1ar2C1oo2ahv1G34lTr/WQPsGuzfTpUDbj55SYYx0Bx2b
 nqc28A9wLyXRkXAgIFabpPrSj6WTMm8Rf2KfKc9iPIbvVBXu8ipuCc0557gRi2oABoDP
 zuB4cq9ZGwtZ9/T+tCNByAzlTBEyItTTwrTODaw5GQvA1sKH21DKOWHtoIqfV+hXeIGa
 hb5qOGXog04OJhKYUVYWf28Y3K6V0OB4YYgm4LneYSLfW4/psldyGKOhK42II9pKKBHB
 YzzA==
X-Gm-Message-State: AC+VfDw3cv3SjMdydL95Qb+i/o1lPgavSfMfCC73TPSzywCOrF9REI7n
 OKfo6SC3nKroJK0D4wvTEpJoPw==
X-Google-Smtp-Source: ACHHUZ5aG39P4uQMRjNFgyhxWC6ERQmCkZdwsMCqk+lBg5N0swivHkUB5hRXOjfqY0mO/ONANzId6w==
X-Received: by 2002:a5d:4905:0:b0:311:1677:a2a9 with SMTP id
 x5-20020a5d4905000000b003111677a2a9mr14375641wrq.71.1687522865540; 
 Fri, 23 Jun 2023 05:21:05 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f4-20020a5d58e4000000b00311299df211sm9485684wrd.77.2023.06.23.05.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:21:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AEA7D1FFC4;
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
Subject: [PATCH 11/26] Makefile: add lcitool-refresh to UNCHECKED_GOALS
Date: Fri, 23 Jun 2023 13:20:45 +0100
Message-Id: <20230623122100.1640995-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623122100.1640995-1-alex.bennee@linaro.org>
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index b22bf6fba1..56f165c0b2 100644
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


