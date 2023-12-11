Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D014380C427
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 10:15:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCcMS-0001R3-Tc; Mon, 11 Dec 2023 04:14:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCcMQ-0001QF-KC
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 04:13:58 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCcMO-0004Lq-3g
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 04:13:57 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40c3ceded81so18124625e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 01:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702286034; x=1702890834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E2A0FLXIYa1xWSm3FkBRraMt/ZpNKUbc3z2ZyKK25Ps=;
 b=dgitHBsCPkspl70F46KS3FdG82lW1SsV/ePAGXJVxxAxE9Ql7DrllAHFPGLdQJ/bV0
 jlXJAWsEWtiOgfY8jhZitRQLcnq47OM6SMW2h51z9qLYfmpKYeyzZgKyBRkwHWNNw7HE
 zXCEBZxds3aulyjt4TDiiDwvElXCNMLcaPx7nhD+2kkQ9c9m1LgNVvIYlcS4zQQL5jAH
 rw2wyOOciVVE8+f7fJ623UD9qlEof98OtBVbG5KC/iGaUzJBP4B35VL231HnrLRA24Dn
 0tf8j27rgbksmeHh5/3e7Mbz8WXt2Uv7ZMsZ8mxRKZxxR6e65mAexCDNjBxpyp3tUi+Q
 CaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702286034; x=1702890834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E2A0FLXIYa1xWSm3FkBRraMt/ZpNKUbc3z2ZyKK25Ps=;
 b=jlbFhLRt2ZioTwHQYdnuXDzJI6bsQEKeTBVrqhlTrT1N8YE81UndJhJN1DzU9vu4Ag
 AxGzlAMmDNxTb3t1JqsA8dXYUzhwB/rNKK8AB6YoYH8w2wRvA5t7Ba1fbcJwROhjPoWA
 ZvajHwD2im/Wa7jxePYekIZy0eKjpqmNZzxt0qHA9GTBRceysUzosd8Z87JJEJQYIDYI
 /IpRHj+agHTbgES5zdHPOrdjFzfKVbYuizhdUfIm6ijKeVATPUl7MrWurOCYYRt3BBj6
 RrYKdaMLHFeaFKX3+16WsT/DBn1WSU2fxmQRFe31tAcypas7FbGvTJYpnSRXrAW7zJu+
 SHZA==
X-Gm-Message-State: AOJu0YxcRkMw8jIv2xRjAg4rRqURAPJfj/RSR7U+Cmwzz1woByZAH8hY
 BC5XaYb8KyYwLPpIpZjaw+Wvgw==
X-Google-Smtp-Source: AGHT+IGnd8Zqx8sWj8dX5dnyLTGHoG8FsXMa0bc6nPAiysq6o488r9qLougC9ZnMsUe3J+ove5NyhA==
X-Received: by 2002:a05:600c:4e07:b0:40b:5e21:ec3e with SMTP id
 b7-20020a05600c4e0700b0040b5e21ec3emr2014081wmq.112.1702286034612; 
 Mon, 11 Dec 2023 01:13:54 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 e12-20020a05600c4e4c00b0040b398f0585sm12484433wmq.9.2023.12.11.01.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 01:13:51 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 993285FBE7;
 Mon, 11 Dec 2023 09:13:46 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Subject: [PATCH v2 06/16] replay: remove host_clock_last
Date: Mon, 11 Dec 2023 09:13:35 +0000
Message-Id: <20231211091346.14616-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231211091346.14616-1-alex.bennee@linaro.org>
References: <20231211091346.14616-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Fixes: a02fe2ca70 (replay: Remove host_clock_last)
Message-Id: <20231205204106.95531-6-alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 replay/replay-internal.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index b6836354ac..516147ddbc 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -80,8 +80,6 @@ typedef struct ReplayState {
         This counter is global, because requests from different
         block devices should not get overlapping ids. */
     uint64_t block_request_id;
-    /*! Prior value of the host clock */
-    uint64_t host_clock_last;
     /*! Asynchronous event id read from the log */
     uint64_t read_event_id;
 } ReplayState;
-- 
2.39.2


