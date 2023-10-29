Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A75147DACE3
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 15:56:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qx7DF-00035e-QX; Sun, 29 Oct 2023 10:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx7DC-00035K-1M
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:56:23 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx7D9-0006GZ-9s
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:56:21 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40891d38e3fso28086045e9.1
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 07:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698591376; x=1699196176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1006xl+XCGNGi7Tb1Isf2iUCQhcI8DLGEFBLylxGtCw=;
 b=tYmqkBRNKNU+EPrBRL/O7XtsEeuaKdFWyE0fF1Q5Jk9SHFdJCt6VTPCIVtMOxaosMV
 X1nqxuomjwSazg/ybHF3YamtxD//V2YOKxEp4/3dDpPWfDnGOrOzgOb7yhZU36+MO7IH
 lhHVyD0NFXWzzuyQb2y0K6EiMzRdY/+vNthSCtjwJtGDkowa1cXhcZs1R/8Oh2h9itLr
 v3Dz9VYDa4tHJoldRCeHSs8WmMX4XGbZLaLoD06G3Hb9PgxBvQ90luQJiNxE2Bi/blFf
 qh1ipsmlpGgstXjToXyIrXODcMMcJicEBzD+HKL4a7Ok/W1XBj3A8DpJ7oG5YRSawGz9
 d3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698591376; x=1699196176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1006xl+XCGNGi7Tb1Isf2iUCQhcI8DLGEFBLylxGtCw=;
 b=mnV42DN7+bhB+Hq3syQRUF8KaDsUktgrKU0OkFe4UncRB32IVokTNshiwEi3XfJamx
 wVRa4OXFY3D3hqaYDtleAkuyZJsKjmEZzM9G2K+PBefqFeSw6ndKzXGXmwckDh0RCsf+
 gjkzo9tSeiIkPu82pkJKKAlC0bZwvb+7QBQ8hybFyXAJrzfJ8qwMnB/b8u3YUWp0kBqp
 lwWuofO0goLR+faYe0u+T0R9YufzMblQ6acuOtBX+l3KlwHhm6b4xEr53MG2XOhPD7HS
 tavRsxGgHgBL9bBFfBw5MUDooElZhvw9ZPSYi9g8Q6e8OoFCXYeckp2M1AKBa4Wc7JPs
 ZFlg==
X-Gm-Message-State: AOJu0YypSWJdYF0+RyQX9Jk86Ulg1Cz9iQBJ+wuSvDu/rX0c+IjRGSXB
 WgGcOyHEpzVcqoLbAkxhCxPtnQ==
X-Google-Smtp-Source: AGHT+IHuhjQ66A/l9ALcatjT4odQZXhiD2esM6eeUF0gI7MHWAwCLr4C4Vy0382nPyYdsIH89Nc1bA==
X-Received: by 2002:a05:600c:1c29:b0:401:eb0:a974 with SMTP id
 j41-20020a05600c1c2900b004010eb0a974mr6281873wms.3.1698591376630; 
 Sun, 29 Oct 2023 07:56:16 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 p14-20020adfce0e000000b0032f7e2f4457sm3067938wrn.66.2023.10.29.07.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Oct 2023 07:56:16 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D8D456570C;
 Sun, 29 Oct 2023 14:50:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Brad Smith <brad@comstyle.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Kyle Evans <kevans@freebsd.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Brian Cain <bcain@quicinc.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Cong Liu <liucong2@kylinos.cn>
Subject: [PATCH v2 19/19] contrib/plugins: Close file descriptor on error
 return
Date: Sun, 29 Oct 2023 14:50:33 +0000
Message-Id: <20231029145033.592566-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231029145033.592566-1-alex.bennee@linaro.org>
References: <20231029145033.592566-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

From: Cong Liu <liucong2@kylinos.cn>

This patch closes the file descriptor fd on error return to avoid
resource leak.

Fixes: ec7ee95db909 ("contrib/plugins: fix coverity warning in lockstep")
Signed-off-by: Cong Liu <liucong2@kylinos.cn>
Message-Id: <20231018025225.1640122-1-liucong2@kylinos.cn>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231028103311.347104-18-alex.bennee@linaro.org>
---
 contrib/plugins/lockstep.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
index f0cb8792c6..237543b43a 100644
--- a/contrib/plugins/lockstep.c
+++ b/contrib/plugins/lockstep.c
@@ -257,6 +257,7 @@ static bool setup_socket(const char *path)
     sockaddr.sun_family = AF_UNIX;
     if (g_strlcpy(sockaddr.sun_path, path, pathlen) >= pathlen) {
         perror("bad path");
+        close(fd);
         return false;
     }
 
@@ -303,6 +304,7 @@ static bool connect_socket(const char *path)
     sockaddr.sun_family = AF_UNIX;
     if (g_strlcpy(sockaddr.sun_path, path, pathlen) >= pathlen) {
         perror("bad path");
+        close(fd);
         return false;
     }
 
-- 
2.39.2


