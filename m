Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 745418272B1
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 16:15:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMrKG-0004Dt-Fn; Mon, 08 Jan 2024 10:14:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rMrKE-0004D9-FQ
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:14:02 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rMrK8-0001Wl-8M
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:14:02 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3367a304091so1894744f8f.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 07:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704726834; x=1705331634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wnYL/+L/m9RcK0IeiSLcPjsAr8XsHeZX4IFVvVVgTiE=;
 b=I+5hDEFvayNb+0q1B+0rEY46a3fhCvdkJnOZ6OfsPnrXuRB0oO2wJLP9giKRkeA5NF
 LQjBvq1QhdIkKvCx/sM0lOCjANp2QQfNo13ImkYPT0g8zwjMWWZqIOFH+r3eThYzXA+i
 ISpYls4QVruv1/4rCTnGITnvqW2rdUp02pqdyNTwJfzUGZHWINmxhsEyB5DMpoczl1fm
 gzayI0mlOfamVHb3UlWidXPI67I24ByJ7WDr8TMVp10/oTeSwiH3FV/Swpw5DSxzNqNy
 1/4YY5gNP4b19Lg1dDIPOPBhjQr2sgeF6WSSoaHB7YVWXQ517tuyzVDZr5vHPppx9I4M
 XsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704726834; x=1705331634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wnYL/+L/m9RcK0IeiSLcPjsAr8XsHeZX4IFVvVVgTiE=;
 b=vINewTDN9fqY0Kmesu3Dr+fX5xmza18JsLtsRs+hjW7GmuvFwmikwALWH293RGkU69
 h8fb+wdd5NaD3DNEyT7mc22sYJ5QFrPWhWZ8KeCwuX0GhhNXYrtZnuocFatI1ZQ3fn0V
 4rqHnu0u2YjO0xkqcIY90qMv6a+UGaWh6UDeMiQiCk4hIvUR3FxRlREdNcHXIZb0JkC2
 G2rrnQ/e+5/CQlvvzFszsfp1eoQhZ0ghSbi7/B/Ct3rjmiKS3sJnvJnL84jFloNV3K3Q
 DMqwtuz5yX55ST0AwwhEJzXjWrWVYmN9b4lGuqwJIqYywAXYtihKFhicE/gadGFHJkIy
 S1ng==
X-Gm-Message-State: AOJu0YwxmhlhkpYXItWSAZiZjEEwmQBynD97Kua3bgMxYBj3uXXJwM16
 vQ+SuW5vnVKXdXhS+nQNk8IXY7N/cV/qhpuKN6Eo61XlAsI=
X-Google-Smtp-Source: AGHT+IFPLsr/MLVbqZp6gNaupYlgFLBDN2NOuiUNxzV6rdqzox7h+KZ5tuJHPUGa2PCCZAEgzpXhsw==
X-Received: by 2002:a05:600c:1e0a:b0:40e:486f:45ac with SMTP id
 ay10-20020a05600c1e0a00b0040e486f45acmr377097wmb.19.1704726833941; 
 Mon, 08 Jan 2024 07:13:53 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 v15-20020adfebcf000000b00336673a4153sm8020931wrn.80.2024.01.08.07.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 07:13:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 12CDB5F940;
 Mon,  8 Jan 2024 15:13:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 02/13] tests/avocado: fix typo in replay_linux
Date: Mon,  8 Jan 2024 15:13:41 +0000
Message-Id: <20240108151352.2199097-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240108151352.2199097-1-alex.bennee@linaro.org>
References: <20240108151352.2199097-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231211091346.14616-3-alex.bennee@linaro.org>

diff --git a/tests/avocado/replay_linux.py b/tests/avocado/replay_linux.py
index 270ccc1eae8..e95bff32999 100644
--- a/tests/avocado/replay_linux.py
+++ b/tests/avocado/replay_linux.py
@@ -94,7 +94,7 @@ def launch_and_wait(self, record, args, shift):
         else:
             vm.event_wait('SHUTDOWN', self.timeout)
             vm.wait()
-            logger.info('successfully fihished the replay')
+            logger.info('successfully finished the replay')
         elapsed = time.time() - start_time
         logger.info('elapsed time %.2f sec' % elapsed)
         return elapsed
-- 
2.39.2


