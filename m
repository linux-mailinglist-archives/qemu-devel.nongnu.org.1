Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECA582BEF8
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 12:10:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOFQh-0007OM-RQ; Fri, 12 Jan 2024 06:10:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFQd-0007O4-L6
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:10:23 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFQY-0003QN-J4
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:10:22 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3368d1c7b23so5448968f8f.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 03:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705057815; x=1705662615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ar4Q0KzDhN6C3ss8iuvWuXCh03LQWU5jnYFmm1I8O8A=;
 b=GbxEYjWkkBT6gZ9pBh+bdi0V6vWEAKXblMqjCbLHf5QUXWYA5jRW3hzULpBLSCvq/x
 d41QVLUqvK53tn4giHwfq6FPgSoJNdziFjPQqXiqrUcLKCgqxlHrm1D8HdulbmYW0z04
 lweoLWuajyhOb64haxATjZWbeDAOXph0SkWdG0osiWvU/ekjVCqIUUNwnYwG86Afjd18
 aXsQ2vOrw8Lbo6eBosMHSiEg/2mFNLYuwn7hIBkzyrZjNpLcLxeJ973PyxHtDYa7hO/R
 2qesX7PHDoQjs4S7Xz/cIZJVUnieqsFhNW8XiX734cipjs814awHg3Q0Swm9l4lt4r5Q
 t2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705057815; x=1705662615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ar4Q0KzDhN6C3ss8iuvWuXCh03LQWU5jnYFmm1I8O8A=;
 b=GYMHYzXW469Pr2HSe6coB0wjcyb3uiWmeB+b3pnGKVQ/nAVt5quKUJ5caXb9pa2goy
 srCWlhDR6vNo1WGjPAyqbRLIN/hfPHYfZI5PjzO826vOam1Hr0THF13h953wFx/fDULu
 rZ8gAW7yyK0gcr++aDwficom7MGNBunejFiDZF7wk6bGGVYw+N2WTuTsDHMx4zxjiqpB
 eUmapcLcnVi4chwznhbunFJVScR4F7BQLqUvG5Sx3G5kI54bHyaiHdDt/Mw65AL8FLH6
 axWj+vroCOifUnIoQfC6e/t+mnsFEm90jIPBWjC6rAC3l/SrtDV8iYR7mCkdCCsEmrWz
 7xQw==
X-Gm-Message-State: AOJu0Yz3jxuABwbqRnkLQnBzaeoLaXiviFdKCQly05xQsW+6o2ucz0qx
 mcZ40gOLrUulDtmqdpvnKsc7PlQka/a+7A==
X-Google-Smtp-Source: AGHT+IGoSY57Ob22gZBDQY/S7NtLYC1F1S0FAM/sbl1UULgbYoyjwi9wsIjSZGeKiW78T/H0L+dqdA==
X-Received: by 2002:a05:6000:1862:b0:333:492b:e5e1 with SMTP id
 d2-20020a056000186200b00333492be5e1mr848333wri.22.1705057814784; 
 Fri, 12 Jan 2024 03:10:14 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 d15-20020adf9c8f000000b00336c43b366fsm3621466wre.12.2024.01.12.03.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 03:10:13 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8AB8E5F95A;
 Fri, 12 Jan 2024 11:04:36 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 17/22] tests/unit: Bump test-aio-multithread test timeout to 2
 minutes
Date: Fri, 12 Jan 2024 11:04:30 +0000
Message-Id: <20240112110435.3801068-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112110435.3801068-1-alex.bennee@linaro.org>
References: <20240112110435.3801068-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Thomas Huth <thuth@redhat.com>

When running the tests in slow mode on a very loaded system and with
--enable-debug, the test-aio-multithread can take longer than 1 minute.
Bump the timeout to two minutes to make sure that it also passes in
such situations.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231215070357.10888-14-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 69f9c050504..937e1ebd356 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -172,6 +172,7 @@ test_env.set('G_TEST_SRCDIR', meson.current_source_dir())
 test_env.set('G_TEST_BUILDDIR', meson.current_build_dir())
 
 slow_tests = {
+  'test-aio-multithread' : 120,
   'test-crypto-tlscredsx509': 45,
   'test-crypto-tlssession': 45
 }
-- 
2.39.2


