Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD457D0FF9
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 14:56:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtp2H-0004oQ-I9; Fri, 20 Oct 2023 08:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtp2F-0004mH-8R
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 08:55:27 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtp2B-0002Am-9O
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 08:55:26 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4083dbc43cfso5945935e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 05:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697806521; x=1698411321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ah3WKGt0I4J6MGqXZ6iDMJbohTp8VA+zrxGknDCvKfI=;
 b=b3KlTbz5AnJg1Ee/nInZ/tOzF3ttv4g3n1Qp2Tvj8opuM3NR4Pcc/MpdaYX4JZnOMD
 9qU0PiUrowC4vG7qeUwX9HQKWMwSB+bGMC57wQbhkH1gBwmRfdqhUropAwIYSDz7GvxS
 9GzX3rEqtPHGWttFut1g1z2hndnv0nLIiJ6z5XjqDf4JKX36jmjQ4W4rjazXeUfdVSW4
 6UpbNx8ZnMWav1Nhv68epoN8R1/MwKsDMVOUiQUA2ilUayqzJnX/bk2u971okezycMBd
 6oxfbW1vPEWXulHIyX51hwExsb1jzJ4qlSaSKu/b5p8xCRjdUn3mV9tRYleh0TIix39P
 vwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697806521; x=1698411321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ah3WKGt0I4J6MGqXZ6iDMJbohTp8VA+zrxGknDCvKfI=;
 b=pw0hrfpIJ0DdozmFLVqjwnXqFulIdFhblIKRo4M2SO+7nGolHAYNt3NFTnxDAcMAyR
 1M+iM25j935SGy/WDQF3Nq2oaMO90cKwcqn+ZcX9Nw2M6C5N1WUFM6GxVDZwOzXtEiaw
 vSOzXArv4BbJ1eyMKtQkOB0HShcwsf2rsu2aKxzhUZr/4Rs/F7rS8FnkjjadyplQ5BqK
 nSUjCDtJ/sA11q9GTWKeumuuc/YfvQh/i+OKzPSBZCakB3RZ91exZvYuegymbeNXtLTb
 YmFGvwHuNmqHkXrKM/1EIEArvnoj/S5vOtmtXuqd81pR22DaScmCFjfZ1Ig5Sk9Fq3Oa
 /BlA==
X-Gm-Message-State: AOJu0YzhAfosdlkdEYCQR5yNnfus1H37Akl0xpOEfpRQ2GUOr/Q5Vg8K
 ytap5gDJktjffd5GuGdZ1fQOQA6TsZlUeCVu8mw=
X-Google-Smtp-Source: AGHT+IGep+/LesKEbpX148z/2UsNAvEX7RQrUa034oP+V/jXJyDovz57LL7pOloe7TNBtpI5sV/Nxg==
X-Received: by 2002:a05:600c:4f91:b0:3f6:58ad:ed85 with SMTP id
 n17-20020a05600c4f9100b003f658aded85mr1587399wmq.10.1697806521310; 
 Fri, 20 Oct 2023 05:55:21 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 6-20020a05600c230600b004083bc9ac90sm2079272wmo.24.2023.10.20.05.55.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 05:55:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v3 06/46] MAINTAINERS: Extend entry to cover
 util/qemu-timer-common.c, too
Date: Fri, 20 Oct 2023 14:55:09 +0200
Message-ID: <20231020125509.49440-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020125509.49440-1-philmd@linaro.org>
References: <20231020125509.49440-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

We already cover util/qemu-timer.c in MAINTAINERS - change this entry
to util/qemu-timer*.c so that it covers util/qemu-timer-common.c, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231020062142.525405-1-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe11c98669..1b2c5b9e76 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2937,7 +2937,7 @@ F: include/qemu/main-loop.h
 F: include/sysemu/runstate.h
 F: include/sysemu/runstate-action.h
 F: util/main-loop.c
-F: util/qemu-timer.c
+F: util/qemu-timer*.c
 F: system/vl.c
 F: system/main.c
 F: system/cpus.c
-- 
2.41.0


