Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8077C5047
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 12:36:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqWXG-0001Wo-Ja; Wed, 11 Oct 2023 06:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWX6-0001Kv-3W
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:33:41 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWX2-0005BB-En
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:33:39 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40675f06f1fso4533005e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 03:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697020414; x=1697625214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CEso1qQHTLbjmT+JXyeDiL7UkgO6kpzpKkYLgvNLU18=;
 b=AqqODY49Eh6wrPt5NNSd/6eHGcVqqw0hitGUwge3jvSpBRE3tXMFI2gx2D0mVag1EX
 m89A9CyZtucNCTACfN0Ubh3mIhFy9mre2NlbyrhwZYdlTY4wwDBpEPQ2UMf57VewDFDZ
 T5erT1Hq4lBAH2e1DsgYrAJp9t+CzJfXFqrLU++hoje/TvqKExCJDD0mR5tLWQa6TqiC
 0llv4qdtjsfIV5RMUu8Hj6l1rGLVLhiaUMsJfci+DpjQJ/OzViFaOfwaX0arARSQsB8S
 N0BE5Zkucfcx1/mAzpOJJGUrGzQ6LWmU6zALfrD6vqIQChbegW8Z5l4Ub9EORwtQjCoX
 oAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697020414; x=1697625214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CEso1qQHTLbjmT+JXyeDiL7UkgO6kpzpKkYLgvNLU18=;
 b=tlfUxj6V1yYTkI3Us+o3bxzVnJaCuIisn0D4O5FlWxfgP4Z0SD1M8S1kJ5AIXFAmw6
 MNMTHFlEtVE54D70hWktKl1JD6O7Bh0WFyf/YNCLuiWk8g3uskoqJR9hsVLxnki0w/TT
 LnAWKDnvD19IZgGn4QraaWq5qUoj3Sp5GEeIY7VzsCJITwWV7qAQjUCmU/iBh4mw7GHF
 HUPOcGx8jhNnrggwwJsN1OjJlY4w1n6i0lkgz7AUZkFa8m/PR0XsSdZQ1HOwJlc4jk+/
 o1cWQ+abfSZTOJEwgptOTcsPwFOVGXXkx+sLgBVtMBvzh20W2HfDiR/mboG5o6GnTcwN
 Sycw==
X-Gm-Message-State: AOJu0YyL9wgiG8eGEqQf9VhPUeGyQOsulsdGfUAgZ3JYg2r9OepBZBBn
 tlPQGdHWztFUunp9BdwE45T0RQ==
X-Google-Smtp-Source: AGHT+IGmdrsxQPWINcdVLuv5EnQa+5M7B/Ou9sDkJ9OJDp9PUGVNnj8Xua4mRrbSKDu6+mksPzrCvw==
X-Received: by 2002:a05:6000:3c3:b0:32c:d29c:2f77 with SMTP id
 b3-20020a05600003c300b0032cd29c2f77mr4520292wrg.1.1697020414092; 
 Wed, 11 Oct 2023 03:33:34 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 s11-20020a5d424b000000b003248a490e3asm15135027wrr.39.2023.10.11.03.33.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 03:33:32 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2062D1FFC3;
 Wed, 11 Oct 2023 11:33:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/25] gdbstub: Fix target.xml response
Date: Wed, 11 Oct 2023 11:33:13 +0100
Message-Id: <20231011103329.670525-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011103329.670525-1-alex.bennee@linaro.org>
References: <20231011103329.670525-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

It was failing to return target.xml after the first request.

Fixes: 56e534bd11 ("gdbstub: refactor get_feature_xml")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230912224107.29669-3-akihiko.odaki@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231009164104.369749-10-alex.bennee@linaro.org>

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 8eea21450c..4f3762fccf 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -396,8 +396,8 @@ static const char *get_feature_xml(const char *p, const char **newp,
             g_string_append(xml, "</target>");
 
             process->target_xml = g_string_free(xml, false);
-            return process->target_xml;
         }
+        return process->target_xml;
     }
     /* Is it dynamically generated by the target? */
     if (cc->gdb_get_dynamic_xml) {
-- 
2.39.2


