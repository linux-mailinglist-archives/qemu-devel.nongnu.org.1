Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C839C82ED37
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 11:56:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPh6g-0007Zw-26; Tue, 16 Jan 2024 05:55:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rPh6e-0007ZK-MG
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 05:55:44 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rPh6d-0008WF-85
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 05:55:44 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40d6b4e2945so109795935e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 02:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705402542; x=1706007342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nQel5yeou8quABkTLKHlqy4VbBA0w+/gHQ29oL18UwQ=;
 b=RvaO+r1tUE9HCp+dDq9GFscK5k7w38PtJoazyynq2Aj9rEENV8DotsT7g3t68ev4Zv
 vyWUHzfDsnkfLy9ZWhLNr8iN/3UmtxUUQOa2GT3+cL8uG+iu1L8FGpi9AEie7+MPEOiV
 Zuj5z7Tqy7C73J5XBb0Dp3XCvYlCemjIPWAxx9FKCpX89KVEQ1jzFs7tGcCowF9HcmEk
 zk9qUHbnLaVY8pc2igPbaKW3CT3V0SAFry5M7VstlBYCIFWSyrl50NM2XQHRvrVnzwuq
 lVwn8ij6Rl0Qq70BV1/mATvOPqTUF0QUtoRVywAvl3at3ANahxK4/m4+2Bki08h8q9SF
 1pYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705402542; x=1706007342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nQel5yeou8quABkTLKHlqy4VbBA0w+/gHQ29oL18UwQ=;
 b=QhTzrYycjJLXKu8RMP6f6fWC2KCfYNivJ8usBRx6Whx7xd5ltNo8Pml1V8DYX81W8R
 Nukae149h2eFLPP7cikmdvc3GGkSHiPjbPohQ9FhTRsNdqM6uP35VeGJN6AukU2iJr0G
 FdTqdC6kul8E7D8gyu8hAp7x7YwVmhI7Z3oWAf6dcZcRUq8Wyt+ssMru11Ha45OTXxds
 Lyk4osVm1SboB+YqYW5nf8LTsUSkJxjWvJrjDqyyO6Ztr0I19FoBI0t/DpKJV2IXwuYr
 vYjgnO2ZY4mpft/5vPhQHNq2UMujTi3AEL+DDctYj+79b365lAqci7QgrVGu1c7sDUsV
 siQA==
X-Gm-Message-State: AOJu0YztNev1rknVyaEDApeyuYVFTrfJLoAMPvYqH2+Q9KoYXUliSp/c
 sEwrUQo3A+7KkBQVYU5kKyXxw1U6zzyGVw==
X-Google-Smtp-Source: AGHT+IF6O/w3CBxi1w7hNJsnMxwcNyovSl5GxCUWEfjTErvLI6DmRvbeEI1bKEq+zt3xH0Eljx4Hgg==
X-Received: by 2002:a7b:cb05:0:b0:40e:4944:9a97 with SMTP id
 u5-20020a7bcb05000000b0040e49449a97mr2517158wmj.96.1705402541411; 
 Tue, 16 Jan 2024 02:55:41 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 f18-20020a05600c155200b0040d87100733sm18997698wmg.39.2024.01.16.02.55.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 02:55:40 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3DF635F904;
 Tue, 16 Jan 2024 10:48:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 18/22] contrib/plugins: fix imatch
Date: Tue, 16 Jan 2024 10:48:05 +0000
Message-Id: <20240116104809.250076-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240116104809.250076-1-alex.bennee@linaro.org>
References: <20240116104809.250076-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

We can't directly save the ephemeral imatch from argv as that memory
will get recycled.

Message-Id: <20240103173349.398526-40-alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index 82dc2f584e2..f262e5555eb 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -199,7 +199,7 @@ static void parse_insn_match(char *match)
     if (!imatches) {
         imatches = g_ptr_array_new();
     }
-    g_ptr_array_add(imatches, match);
+    g_ptr_array_add(imatches, g_strdup(match));
 }
 
 static void parse_vaddr_match(char *match)
-- 
2.39.2


