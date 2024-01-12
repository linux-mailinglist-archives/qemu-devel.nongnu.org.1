Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BC082BEFC
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 12:10:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOFQm-0007T7-Sy; Fri, 12 Jan 2024 06:10:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFQg-0007Oe-EJ
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:10:27 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFQa-0003QQ-O6
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:10:23 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3377d45c178so1782139f8f.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 03:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705057815; x=1705662615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gvmqPE1NXM6Q4yWF3pBPWwKopVOUR2hSD3g1l0pkcNk=;
 b=pkpU2f66paUMpiLyiWHn2/LGE5SxndcLf+fahfDpw2GrfgsbfrYgSZT80SWbMCeITc
 fkC5Qg+1mwxXPBwjblm2d30LTkdntuZ+Ich/SCDfFARgFGVwplQskUKCi19dK3kopLmg
 C+XDDGOFwmM1OGnXu8Q1UWydGwHrQxjA9O9UQPfeo7EYD+SoUOidNYGGXL67Xq15vx9p
 OaCXSWK+Xwej0ZW+g1GLSdX18G1HLOV+RXQXZjTIw4nPolqyAQeojPBtuwqipZ92Cxe9
 ov9RrLidnw/+6nx0DrNgYc5fZ0U3HP9v7f9AJSTXccnxRepWv4I664wvF6HxEE6Hy8BN
 IEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705057815; x=1705662615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gvmqPE1NXM6Q4yWF3pBPWwKopVOUR2hSD3g1l0pkcNk=;
 b=hCxo1S+5K0yeBAd2xU3iKp8zgHJi1H4V+nY2GJ0oJgihP06H/EWAz7XzEEji7ffQIP
 8D6m0aKMcvp2tkuvNQZzZVtjYoG2DEmoy4OURp+vFzz2ohcUvy09xe3LPBzEnaGf6HGQ
 WD99GTDlN4kKXzWWB40ena8/8is32x8QrvvQ76ZmCyxRpeT08NDYDsjLl483AioeHAeT
 YwO/8xZsOsmcCJKKplBP2/mc0CI6/TnPmLe51lrpnjI9C//FmIHkPAKZZaLImBVbLSpX
 SuwZ2cAxH3iQfdHhm36qb8wi1wmChmDIhcJXuhEteLJr24sxdxcnIa/gP//ao10JBtog
 l9EA==
X-Gm-Message-State: AOJu0YwJD4obIBVsjbJc3Ndro24Zo1YMpTeb1HNUNq/w2BgdFHAztmYD
 +zasVa8YfR7clCiza3dor+mz2bJJRJLdS2riWEO/CfHwV9U=
X-Google-Smtp-Source: AGHT+IHfW9cY2BI3EkVnkqbiLyw7DvIFWx38jDrkzR670xR+yvBELCbH24Hfv64C+JiDlznhnD5Ahg==
X-Received: by 2002:adf:fa8e:0:b0:337:5d86:96f1 with SMTP id
 h14-20020adffa8e000000b003375d8696f1mr708690wrr.96.1705057815225; 
 Fri, 12 Jan 2024 03:10:15 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 dr18-20020a5d5f92000000b0033677a4e0d6sm3622173wrb.13.2024.01.12.03.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 03:10:14 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A1BF05F95C;
 Fri, 12 Jan 2024 11:04:36 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 18/22] tests/unit: Bump test-crypto-block test timeout to 5
 minutes
Date: Fri, 12 Jan 2024 11:04:31 +0000
Message-Id: <20240112110435.3801068-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112110435.3801068-1-alex.bennee@linaro.org>
References: <20240112110435.3801068-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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
--enable-debug, the test-crypto-block can take longer than 4 minutes.
Bump the timeout to 5 minutes to make sure that it also passes in
such situations.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231215070357.10888-15-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 937e1ebd356..06595321223 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -173,6 +173,7 @@ test_env.set('G_TEST_BUILDDIR', meson.current_build_dir())
 
 slow_tests = {
   'test-aio-multithread' : 120,
+  'test-crypto-block' : 300,
   'test-crypto-tlscredsx509': 45,
   'test-crypto-tlssession': 45
 }
-- 
2.39.2


