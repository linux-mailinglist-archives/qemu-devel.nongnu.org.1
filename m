Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BD170F951
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 16:55:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1pt9-0000EQ-2b; Wed, 24 May 2023 10:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1pt3-0000Cc-SY
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:54:49 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1pt2-0003m7-Aq
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:54:49 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3094910b150so938525f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 07:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684940086; x=1687532086;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9f6o8mLqQnxOh6vgR38BZJ8OPkTvpAnTkJylvoS4PnQ=;
 b=cOMZ9Qz7l8NvyPzK/Ugm+LRmo/I99A1hMA1L4XnYUhItD2fVoAzcvhNn2UY3diRqf/
 8NZs6yc6D9zztLsSIbi4g8SndsQh48OBpMGquOQKT5bxCZcpjGOOIDaptQ2xY/Y9wi+c
 aultUELRvrNKnC5DB6lcy5bZAJ23Cj+NbVyDKbuq+qBWw4EckfUi9voA1P8+PXUunhh/
 ECeO5/bLq4r76amwK2AI2VijWxi07gLqsZCzMNZHdoZCxpkIsY77gr3SlUHgP51c8caI
 PMsj+RbSS7cUJDW+JCoVoieYk2d/hiBoxhfhvw877auxWJP/VlJVwN56pDyaPPBytXdu
 P/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684940086; x=1687532086;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9f6o8mLqQnxOh6vgR38BZJ8OPkTvpAnTkJylvoS4PnQ=;
 b=PLT6hueTQddacu9gmYROmFdQTcvoF/AuEAnEgYZ6mdUjn52FxgFCSVlVryRhwoQ9Kd
 tt3uu+yzP3D56GWMw8bA9HgvuVJTGCyPr94ulXHBmStLEN7H7cu87cERoxWf51BYF+Y0
 Mas6TLgcccZk84XSWRLljyD8iKdf00CFiJom8VdOcNjVDtn03V9YlnB8Y6LHAiZJt91R
 D1cI4HeEMo3D8s60d2pYk/ir+w3ET9gLyzsRI2/IE1ajVHq4TlDh1z/gPa1WuZ4f1VgW
 ZfY/mr9unXDwxR0i3Uy+XxHCUwPKGmm68bsNr/NZ3K3walDoDifzMeys5IFkF8ScKV4g
 wT+A==
X-Gm-Message-State: AC+VfDw8xloeKKGa6t/Aw2/tXd62kSJKBax//+ZMk/Ekj5VwNW0T+LH1
 NuF1EFlIZjgGAGiTMLIUgcUdn8ZI4J4p2K/efUwy3g==
X-Google-Smtp-Source: ACHHUZ5iosOS5Jg50ACgLCe3DyJ2p8aXXuUifq7OQmRL+wbQxtMCu+uKE0N8Nq+aBZd1QFMmGEYPRw==
X-Received: by 2002:a5d:564e:0:b0:307:7e68:3a47 with SMTP id
 j14-20020a5d564e000000b003077e683a47mr32453wrw.37.1684940086340; 
 Wed, 24 May 2023 07:54:46 -0700 (PDT)
Received: from localhost.localdomain
 (fac34-h02-176-184-31-193.dsl.sta.abo.bbox.fr. [176.184.31.193])
 by smtp.gmail.com with ESMTPSA id
 w4-20020adfee44000000b0030785b864f1sm14704997wro.65.2023.05.24.07.54.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 May 2023 07:54:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH] checkpatch: Prefer DEFINE_TYPES() over type_init /
 type_register_static
Date: Wed, 24 May 2023 16:54:43 +0200
Message-Id: <20230524145444.32820-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

When multiple QOM types are registered in the same file, it
is clearer and simpler to use the the DEFINE_TYPES() macro.

Add a rule to checkpatch.pl to suggest using DEFINE_TYPES()
instead of type_init() / type_register_static().

Suggested-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index eeaec436eb..db8029635c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2877,6 +2877,12 @@ sub process {
 		if ($line =~ /^module_init\s*\(/) {
 			ERROR("please use block_init(), type_init() etc. instead of module_init()\n" . $herecurr);
 		}
+
+# recommend DEFINE_TYPES() over type_init()/type_register_static()
+		if ($line =~ /\b(type_init|type_register_static)\(/) {
+			WARN("consider using DEFINE_TYPES() in preference to type_init()\n" . $herecurr);
+		}
+
 # check for various ops structs, ensure they are const.
 		my $struct_ops = qr{AIOCBInfo|
 				BdrvActionOps|
-- 
2.38.1


