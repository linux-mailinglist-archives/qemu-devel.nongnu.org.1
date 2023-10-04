Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C207B7E9C
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:03:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo0aw-0001uI-BM; Wed, 04 Oct 2023 08:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo0ZC-0000Jz-66
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:01:33 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo0Ys-00012m-KC
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:01:24 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-406609df1a6so20681565e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 05:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696420865; x=1697025665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6gKDMfa7dSai1h/sgemtp7pr068K3EYlzpE9zbZdHuU=;
 b=mo8FY6sUjvXEI+5WT3rHqjr27ipxS/Lyohoh/ucQp3aePWMB+9BoVReAoao4i2Frc6
 LyZyWBNxTNZXo1+VBNMyXCOHbc/3d1dAwm4s7CoRB0ljYLUpjXKfdGQu6fWZpeoIBT9R
 XN9+I85rlIbjUFdn2mH+HTDCxwWGiD8Tv+ea9WhFejOHtCcnNxzyFr/TGAgFCdWsELP/
 NRcp19LHyAlJ7zncwyQ8xDUFhlxpkr0y+Of1xiEtRqfCnPTXi+eK0X7lQqFUCsp/XN+V
 6UIpJYpH8JAg6phGVm2EFxazHWGyvhvONyynIBC9f1PuzAaPB4XmdKf36D4a6NmZFpKA
 MszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696420865; x=1697025665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6gKDMfa7dSai1h/sgemtp7pr068K3EYlzpE9zbZdHuU=;
 b=UtsvYD0QpP9yT68iUVUAkI8fFtC1v7MXD7xRIDAOsxavpCH658pXaJxfwySzyXlydN
 7FcuD7MOHf28HGxD6lFGYvL3G5rGe04yLr2hutstPmArgZTv7iFU07OOBgIeRJND8H4k
 LxRJd1C70mDMy3ivKK9VHM5/pp1r+FT90j9lQBi0rtTZ1Lc5+R9Rs9HxJfXAl2w0PjOF
 ywVwgC72kgJAsLQWKy5PwEcR4XTxDxo86LCLYcgYezhw08kTGueHu3LxsgsryAUDEoiJ
 3FD8BBD7FvKunoQ9qD84C62BAokmtDy3L69hNzbEcbeIqj+6bbbyjZKMgDehvcrL3dSi
 y1/Q==
X-Gm-Message-State: AOJu0Yz5K1kBeYo8wm++eADLV99XxNIVniYLrtEv6rqYeZnlT661U7MN
 BcdICeckHpbo2L5Kf737fbZThmzvPdNUG53d4o8=
X-Google-Smtp-Source: AGHT+IEPMlqsQ/w4grTD1Hcrw0TJCSty32loqCY8HwMPahqXshgVyQ/9ugHvWlZjOKchvkAn8xPV1Q==
X-Received: by 2002:a05:600c:2287:b0:400:57d1:4911 with SMTP id
 7-20020a05600c228700b0040057d14911mr2041971wmf.16.1696420864999; 
 Wed, 04 Oct 2023 05:01:04 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 r2-20020a05600c320200b0040641ce36a8sm1453822wmp.1.2023.10.04.05.01.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 05:01:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v3 07/16] qemu-io: Clean up global variable shadowing
Date: Wed,  4 Oct 2023 14:00:10 +0200
Message-ID: <20231004120019.93101-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004120019.93101-1-philmd@linaro.org>
References: <20231004120019.93101-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Fix:

  qemu-io.c:478:36: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  static void add_user_command(char *optarg)
                                     ^
  /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/getopt.h:77:14: note: previous declaration is here
  extern char *optarg;                    /* getopt(3) external variables */
               ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qemu-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-io.c b/qemu-io.c
index 2bd7bfb650..050c70835f 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -475,10 +475,10 @@ static int command_loop(void)
     return last_error;
 }
 
-static void add_user_command(char *optarg)
+static void add_user_command(char *user_cmd)
 {
     cmdline = g_renew(char *, cmdline, ++ncmdline);
-    cmdline[ncmdline-1] = optarg;
+    cmdline[ncmdline - 1] = user_cmd;
 }
 
 static void reenable_tty_echo(void)
-- 
2.41.0


