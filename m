Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E847F637A
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 16:59:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6C4G-00063I-DR; Thu, 23 Nov 2023 10:56:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r6C4D-00061O-Dn
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:56:37 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r6C47-0002OO-9o
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:56:37 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40a4848c6e1so6828105e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 07:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700754990; x=1701359790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=flBm42QK5sINs8BmnDZzSyUPyoNK1Ek7D1xSwYSnIUI=;
 b=J/U23Oe6aHpu7qX2s4rJ8RFSazLLPj8+ipGoyqcs9PabrZSxHz/tiBh7knsFOaoiY8
 lCV0Dja/OIbsAfGOh72XSjHeKMlqZhOPzupJhLkVwbiPWoVcZJC/JOrH2bOw8W9OyBJ3
 IWFwlrWldMSUqEJsMhFfMPAHBzcrncGM3hzEYtEzwmKHGKwqkXCJRBJaZlfHc49peBKj
 Ot7IquEvHgL4EUM/inrVIPILAfeiqQGvo9pDqElWZ0WWpuX+BA21cluznWsehskYDDgk
 uMMqdWGd7VXFwHo/ZLZHzwN9BZ4zJR91YDNUtGvGloASEkDbP3FRhnH96gMmeEnWaZg9
 Myjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700754990; x=1701359790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=flBm42QK5sINs8BmnDZzSyUPyoNK1Ek7D1xSwYSnIUI=;
 b=oof3W/uUyvgCPN7DstkUIEhP57UG9b008opCP/eOPO1vie81HGzPnKj9izY+Zpk5t5
 abzKnlp4xTz8G/8a3ewjRJJ+3JQsb50Hwj449ZuLHR9s7Wu1wjuhTkjjcvSt4slH8ehJ
 MqoMK1pZ4Fw1DWlkafJHj+ji+DdTE8Zer0rYsZFXvPn0xew0SXisPV6XvfGkM/TnsZba
 aQ6eI5ZEXLgkG5w3nbBexU37pt5iPnV91vIhHg6q1DT8aCKR1lrKUiowZDTdDkihkJde
 1e7AH6PymHGt0XFWW2TI1mtLr/kQIlnOG8SlnNtBg16eAJJOvTIMmQCPl7WvCNLJVzgq
 FCtg==
X-Gm-Message-State: AOJu0YwJiXdOlIVi8ao3iQKnu28wNABdxPGZpZCJPe/qA5euTQgmzzaR
 WbNmnViEV9yAyJcuiE4WXnpvrw==
X-Google-Smtp-Source: AGHT+IFWHQT75/QrC+b4zTP0rr8LQ8kTmf24VTwSsw9/z4ERhRICm4KQPB6tUA1TWAqtfVXXS/H7jQ==
X-Received: by 2002:a05:600c:138e:b0:40b:3605:acda with SMTP id
 u14-20020a05600c138e00b0040b3605acdamr7606wmf.25.1700754989788; 
 Thu, 23 Nov 2023 07:56:29 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 c4-20020a05600c0a4400b003fefaf299b6sm2423243wmq.38.2023.11.23.07.56.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 07:56:24 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5AF36645FC;
 Thu, 23 Nov 2023 15:56:21 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/14] docs/emulation: expand warning about semihosting
Date: Thu, 23 Nov 2023 15:56:13 +0000
Message-Id: <20231123155620.3042891-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123155620.3042891-1-alex.bennee@linaro.org>
References: <20231123155620.3042891-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

A surprising feature of calls like SYS_READC is this can cause QEMU to
indefinitely block as there is no handling for EOF.

Clarifies: https://gitlab.com/qemu-project/qemu/-/issues/1963
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231120150833.2552739-8-alex.bennee@linaro.org>

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 0ad0b86f0d..a2eefe3f3f 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -129,8 +129,9 @@ causing most hypervisors to trap and fault on them.
 .. warning::
    Semihosting inherently bypasses any isolation there may be between
    the guest and the host. As a result a program using semihosting can
-   happily trash your host system. You should only ever run trusted
-   code with semihosting enabled.
+   happily trash your host system. Some semihosting calls (e.g.
+   ``SYS_READC``) can block execution indefinitely. You should only
+   ever run trusted code with semihosting enabled.
 
 Redirection
 ~~~~~~~~~~~
-- 
2.39.2


