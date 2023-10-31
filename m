Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1649F7DCFA6
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:51:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxq4y-0003Fe-3a; Tue, 31 Oct 2023 10:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxq4w-0003FM-85
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:50:50 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxq4u-0003Q2-GB
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:50:50 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40839807e82so34526355e9.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 07:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698763846; x=1699368646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MskYzFDc1y3cPl8dtH4nowGz7t8WHCsbi7Qu2fzhCJY=;
 b=B8VsjAaQNj9odKgWhUV6v41LMvAJ/FDX6GTdIW6DkoTVf66+ClEQhqfGMlaoMY7Q76
 EOSK/owVNu5STa0P2444Xukj9w/cM/UeKJabhdrDUfNNJKYTTjs3tnLxnSBv+oFvZxZ5
 bDXVuC0aVKWoMgtbHR2jVJn8A7dfWdo9rKMflM0jsdQftUdwTU9bD2ohLG/sRtHmQJ/6
 9TeT1J/3ptOnJ7MCf1VEFdpQb0macQkf8sWbAC+MLRgrftOhF9vZjUvvxMaV7PGQYGQ5
 w/FYOguzle6XDcnBMc1PYqnEQYm3yNLFl3zP/7OXCjb9XKQ4U5Pw/Zx9XrXcdgIF6sFk
 dB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698763846; x=1699368646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MskYzFDc1y3cPl8dtH4nowGz7t8WHCsbi7Qu2fzhCJY=;
 b=E+zjL2ihAbfcB2Ul/BoEmjAufLFEnkDxXiqeL6lsxzbHrVwYabyl3zI/b3Kd0vzthK
 noCKF6XIIu3gYRCv3sunsxbdw/OGB8Mbfu5b3WizqB2jP43rh0qfCsmO002Y+cvuDReO
 1Xl9IOEBteK9xpFJiUp9J+G1eCX05z9fFgNePuG61FwDDrheMJKJLidZYT8mRTozVpmt
 Z2SSrcBoN212T4xIO4Jgg6QWqabu4eEzz6D4WZsRGFCROvlADc7ZelPtMNwPxSXAmnmj
 QHGyBswvUY5A2LwpIb5pUfWkkUb1u0WbPFBIxD7MwJWRjtPJqXD5RgXDVStRuWD4hMx7
 bVaw==
X-Gm-Message-State: AOJu0Ywzk8VmsLPlZkpjmOUNXkmnKabLPTHHcjkQpT8rynOoxfiKyVwR
 hsYK2NLsLV8brEiJ6+geXtorIQ==
X-Google-Smtp-Source: AGHT+IFPz1ZSnKPg1Nas83nM8GIXizbUlRxKYVAFYErvNNDiXOVzowSDjg7QyRHQvXdnaSWd0V6gLA==
X-Received: by 2002:a05:600c:5387:b0:408:33ba:569a with SMTP id
 hg7-20020a05600c538700b0040833ba569amr3584550wmb.8.1698763846521; 
 Tue, 31 Oct 2023 07:50:46 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 p15-20020a05600c468f00b003fe1c332810sm1965418wmo.33.2023.10.31.07.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 07:50:46 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8FD6665732;
 Tue, 31 Oct 2023 14:44:03 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cong Liu <liucong2@kylinos.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 19/19] contrib/plugins: Close file descriptor on error return
Date: Tue, 31 Oct 2023 14:44:01 +0000
Message-Id: <20231031144401.1238210-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031144401.1238210-1-alex.bennee@linaro.org>
References: <20231031144401.1238210-1-alex.bennee@linaro.org>
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

From: Cong Liu <liucong2@kylinos.cn>

This patch closes the file descriptor fd on error return to avoid
resource leak.

Fixes: ec7ee95db909 ("contrib/plugins: fix coverity warning in lockstep")
Signed-off-by: Cong Liu <liucong2@kylinos.cn>
Message-Id: <20231018025225.1640122-1-liucong2@kylinos.cn>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231029145033.592566-20-alex.bennee@linaro.org>

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


