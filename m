Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8463E82BEEF
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 12:08:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOFLh-0005kQ-Nd; Fri, 12 Jan 2024 06:05:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFLC-0005eM-B2
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:04:46 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFL8-0008UB-3b
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:04:45 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40e68d836bcso643625e9.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 03:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705057480; x=1705662280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HDpPpXHE+cxrKkq5bcvXCztF/jzGyXWFZAR7dT0lly0=;
 b=yD/tM/1EsFNq0IKcBWgCzXQKxyq6AqWmnq/NZ6Ops6f0TthAchHhqLqjiYmdjEJgXE
 +Gk1wi+hxC4uMW4QCI5zJxmGJyDc3MwOFQNYZ511OEyp7J7b+QzpVIsETfnfBPu2H7ch
 plcpLZuRRwYVDa6b6Js6wXScpApnrTFY4RNnOl37C/l1lCMZhpRmmotfi9dZuC107uii
 eHuZI1cPJGVbi64xm9OpWPS3Ns6hDDP30GR7/CVtIkR1hSXCadGrIy/FjW591/XALW0K
 6QkqLtvFmZg/F0h74xnx/4/YmHtwFUE9a4yuv3UK/tyCBMcmTe16jA+xNKdUDPNhfdXN
 iE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705057480; x=1705662280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HDpPpXHE+cxrKkq5bcvXCztF/jzGyXWFZAR7dT0lly0=;
 b=wAs8p9ynLUB69Q/BtpQabdHLCUK/v6V0Yv1EOTRyzo/lPrPL4lyoTEuBgJjKtIDGB2
 vz+dXvMXz0DK61Vz0kbmVbRCrVzJ/9J2y4BdYDgLyt2MxFaliAXa+1shCLXCnbVHK6OW
 6BseO8OgOcJl3b1wCnUx+LPhLNqFJzTXTbEa+GPK4sPfwWOYeKnNJyyjS2D/ZwOyQEQI
 zeHlXAsyjlJYZqKDqJpmkG9Mo+AQ3edTEiJ+KtaN/TxNZol+yM07a1iPnTYmY9hY4TQf
 vlmSXuwVsxpjPK23GsZvzQHcx+cU1pcDIvY+AVb8BqYP7G7frUb/6VvnfJuQCjVUrmjC
 bkng==
X-Gm-Message-State: AOJu0YzpPJu1Y6JKLziFbtk8JufRYNMLSUhD3a8G6Fq5Dcj89KdCKFB+
 kC085uSBCVWEw/ljJ5c/RPBTM+5HdAoytA==
X-Google-Smtp-Source: AGHT+IHJNMYc6oV4oWb6g9rZ4KBDu9vJMQHrV4K2LADYHlYWWhB7Nu3ElxxcmlMAlSKOeWO5JhhbFQ==
X-Received: by 2002:a05:600c:3b87:b0:40e:6275:e6be with SMTP id
 n7-20020a05600c3b8700b0040e6275e6bemr683976wms.43.1705057480650; 
 Fri, 12 Jan 2024 03:04:40 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 k16-20020a5d6d50000000b00336a0c083easm3550848wri.53.2024.01.12.03.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 03:04:38 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 94DEC5F949;
 Fri, 12 Jan 2024 11:04:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 06/22] qtest: bump migration-test timeout to 8 minutes
Date: Fri, 12 Jan 2024 11:04:19 +0000
Message-Id: <20240112110435.3801068-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112110435.3801068-1-alex.bennee@linaro.org>
References: <20240112110435.3801068-1-alex.bennee@linaro.org>
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

From: Daniel P. Berrangé <berrange@redhat.com>

The migration test should take between 1 min 30 and 2 mins on reasonably
modern hardware. The test is not especially compute bound, rather its
running time is dominated by the guest RAM size relative to the
bandwidth cap, which forces each iteration to take at least 30 seconds.
None the less under high load conditions with multiple QEMU processes
spawned and competing with other parallel tests, the worst case running
time might be somewhat extended. Bumping the timeout to 8 minutes gives
us good headroom, while still catching stuck tests relatively quickly.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20230717182859.707658-3-berrange@redhat.com>
[thuth: Bump timeout to 8 minutes to make it work on very loaded systems, too]
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231215070357.10888-3-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index df013a36b32..2d2b37c2a78 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -1,6 +1,6 @@
 slow_qtests = {
   'bios-tables-test' : 120,
-  'migration-test' : 150,
+  'migration-test' : 480,
   'npcm7xx_pwm-test': 150,
   'qom-test' : 300,
   'test-hmp' : 120,
-- 
2.39.2


