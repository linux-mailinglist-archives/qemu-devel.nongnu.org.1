Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1E27DA68E
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 12:42:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwgkn-0003eX-FH; Sat, 28 Oct 2023 06:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qwgki-0003cB-8v
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 06:41:12 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qwgkg-00057p-MO
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 06:41:11 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-408382da7f0so21539655e9.0
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 03:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698489669; x=1699094469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7CFsfj+V7ArZMzvtMSrBkmxzQkTGIb36bEletW4AhPo=;
 b=VALZNGwsqUvf9PLGZ+SQAblV4T/mnAd6d4Kk0Jr3eT2uv8ZUls9qjl1sIw6UWOck8U
 Bw1o/BlDrXtC+tlLg4kcLP5hq2AHaeBNVjvx+xV75vCxbaoc3/2uPkw7q6NVRplca72q
 d8R1wwqBKZgCLFmOd61vr9pkkGKyZvxIk1Itmk9o+u5OYcOFcwHLNt+PDRmri8rzW7n5
 9YbucKN8VCSXsv49LtFPG7q9YQ453mW0GJGnoAckdTqpCsbwTL8dx6dYSXXPMTr9Ue9S
 zzWEOo0NjY1mkRzEZS8oPQb7TZbU4sD5dTU75u8VOgW50EtP3P2zlj8bMEi1uxr9fEIK
 MUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698489669; x=1699094469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7CFsfj+V7ArZMzvtMSrBkmxzQkTGIb36bEletW4AhPo=;
 b=H1VyEaTUvOr+cRhHIukX08ReLX+uCh17gbo8T7JneV3wUP9cLVRnET0eJ22BwyQPdP
 Bgth6aGy+9vNeCTeKj/MBsvfp3C1Uxrcp22zABpULEM/39DvLujMpCx9IE4pgIarSJ+d
 lxqEDwI2rskRE5291u5Be16Fyo+jcGmM0Hqg0bZwIkDCul276HtzhL1UmSRoRqLqFxRp
 GKBJLunNkgDYTqDf3bfLDS/crysdJRI/ceZIFZ3l4ddH0juEiklZ9NLPfh4Fm8EAFes/
 HBVXWvdAiu0rTAa1HA4InAS8PKc87ih4O4P+ybkaFIkZ7vgan5DKsLFVnGO3gQWbJ9ry
 VkXg==
X-Gm-Message-State: AOJu0YwDk7K77GhpdHDUKHhWQRTGDR2HC3w2MKw6K5oBacus7oAwut2N
 3gWQP8qya/gTzGTrU5kivVY6LQ==
X-Google-Smtp-Source: AGHT+IGc1gBbFYvddSNkbfN6IG72wUPWquV1/pLl8iHTHmnXUXaq5/7jgFeKefqoWvC9Huppwk3Kgg==
X-Received: by 2002:a05:600c:d6:b0:3fe:1232:93fa with SMTP id
 u22-20020a05600c00d600b003fe123293famr4115956wmm.22.1698489668805; 
 Sat, 28 Oct 2023 03:41:08 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 j7-20020a05600c1c0700b003fefb94ccc9sm3752213wms.11.2023.10.28.03.41.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 03:41:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A74A25F839;
 Sat, 28 Oct 2023 11:33:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Brian Cain <bcain@quicinc.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Warner Losh <imp@bsdimp.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alexandre Iooss <erdnaxe@crans.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Brad Smith <brad@comstyle.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Huth <thuth@redhat.com>,
 Cong Liu <liucong2@kylinos.cn>
Subject: [PATCH 17/17] contrib/plugins: Close file descriptor on error return
Date: Sat, 28 Oct 2023 11:33:11 +0100
Message-Id: <20231028103311.347104-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231028103311.347104-1-alex.bennee@linaro.org>
References: <20231028103311.347104-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Cong Liu <liucong2@kylinos.cn>

This patch closes the file descriptor fd on error return to avoid
resource leak.

Fixes: ec7ee95db909 ("contrib/plugins: fix coverity warning in lockstep")
Signed-off-by: Cong Liu <liucong2@kylinos.cn>
Message-Id: <20231018025225.1640122-1-liucong2@kylinos.cn>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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


