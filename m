Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 510848272A8
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 16:15:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMrKF-0004DZ-IA; Mon, 08 Jan 2024 10:14:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rMrKD-0004D0-Pu
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:14:01 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rMrKA-0001YS-9j
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:14:01 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40e4ad831b0so3241505e9.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 07:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704726837; x=1705331637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MMV6mhc2gSysrpUH6HPMUt3N81sB5EX397Qla+10sMg=;
 b=JL/NBzuYAFFdo8/Nere2q28B9odOXr5Ls+Vpgc/3bsaw3iHYK+8t0JD72tU9iZjM8j
 rfrJNzBgsZy3AL5mI/Ubyc4lyokKNdnmTOhHkMqmfqVtYIax7qZpFEyHopl5WuczX1yO
 5eEqqaT83Ji3UZXBz5rKcpcU7oH+FPYcOQMdJe2tdDGSpJU3dEmMUHbpB9q+iVzAQTO2
 q7iePPhBI72Mv5fZS4wL6rH5UaVVsKIb5Cs1l6s1BYDN1AuZUQmfDaNoq4ufTgBBv54C
 W8+aXROmSnL74DqerodEivlwAhLizeq0gh6GYSsNeCVU9ZWoezEtxdExTDDvpAnloEIZ
 r9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704726837; x=1705331637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MMV6mhc2gSysrpUH6HPMUt3N81sB5EX397Qla+10sMg=;
 b=Ar0hj5nbdRua5u7hoSD2/jTpefx6m6UEZ0PFBSvm/TlZZYLv2JKU7OqsclZ3jFe4P0
 Xw6ufxdhcKkMPblbby9ejOH3XsDBq8XnMXeHAXMgWjxzo/CEZjxmgW9fFasSIB1uWa3r
 bsoUALiaKZlPtIoon184FqUD1RYNcnXTnTBEWYlD7faUpYfG/2UQlldscJG0LXnHcsz4
 jlwKWpnr+pEIcRHEKuRGrg3rUWJKPkSHJDzIdq9lbfRww5sdkye+ZYyZWXzxjGuX3lCG
 E9aNPRILhafLeXK7l/AbQiyMSlU9A+uSy4N4MNOJlQy3u6PcjdlPm7rj1kMiDAFf1NVe
 5oTw==
X-Gm-Message-State: AOJu0YzBIcTArW0aKIIs0PuM9mWPdzQiw0JUluLjqY2BjeHYweZSomAT
 FYGQ1j9uKB9ZK48gUlFZZPj0Uv/26amwIw==
X-Google-Smtp-Source: AGHT+IHAVCFc/V2TEXHTz1z3YKCvpxHBRBoB3jJvRxiRiRGf6pUf9vB+7FtKUe5r8y3eD5nz1J98bA==
X-Received: by 2002:a05:600c:1f11:b0:40e:49c6:45e0 with SMTP id
 bd17-20020a05600c1f1100b0040e49c645e0mr454314wmb.23.1704726836834; 
 Mon, 08 Jan 2024 07:13:56 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 m21-20020a05600c3b1500b0040d5c58c41dsm140532wms.24.2024.01.08.07.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 07:13:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 63D705F948;
 Mon,  8 Jan 2024 15:13:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 06/13] replay: remove host_clock_last
Date: Mon,  8 Jan 2024 15:13:45 +0000
Message-Id: <20240108151352.2199097-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240108151352.2199097-1-alex.bennee@linaro.org>
References: <20240108151352.2199097-1-alex.bennee@linaro.org>
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231211091346.14616-7-alex.bennee@linaro.org>

diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index b6836354ac5..516147ddbca 100644
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


