Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA3873B744
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:32:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfwd-0001Il-81; Fri, 23 Jun 2023 08:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfwG-00019Z-9A
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:30:57 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCfwB-0000Sq-5L
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:30:55 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-31129591288so571628f8f.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687523449; x=1690115449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3JC9WCIJtw9nwrfN71qlgt4usYXlUperbuOAmE+qnSw=;
 b=R6KhedFtnu6PTl0OitwyK3DAfM3efg2iXiIje2RewhnZ+mwdBelbCd9OJYwTlogS8F
 a56ivXCEDJfdW6irOvsGs6QS/NTNWh9CIKhz0cqDwq55iTKACKBIXdJgEbJDhbQWAaJl
 GUknBFvKFKQiEqyCOW4dJJwoz0fGvm35SD+/j9nzhEF2Jy8UiHUG0pA6CG38Vg4HhTd4
 2BNUgwTLXXEJ37HbqlQOIFOu6VYAch74oFpPSakqxZ+LlsXt8oYfKwmCZbOObMgqrW7Q
 uJpdbvsPiQa5TlEu5NBkckZ5mA2B4PxGYaOWM1PFn3gP+thw5NDCZwe4Job9DzMjEp+s
 KT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687523449; x=1690115449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3JC9WCIJtw9nwrfN71qlgt4usYXlUperbuOAmE+qnSw=;
 b=W828dJGConphMQ9m+veRjlWZJFzUBFf1Xcrnv2MD94XRBm42NqavWjBFq+szgfyQis
 OVmq8CMyvuLiJwmQ0ihM8vFT6nEL3gdgZyuEH6NJoUV6MbnGPKlc/4Iw6L8IeyAIWrd7
 nFIN01wVp7h8Cc5N0WRVHUCejCBG+Pf12UNt5AjiG/WBcyihNQX6pDcmfMWdsj+PCdCV
 RUMp5HHpIvxieF9/FtwrwyrY16P2zqDYDSCdULFIosbi4o3HW7+b78LG1YXlUKl6Pgf1
 N372NmXpoYcgQ7QB1NfZxboKOpYoR4Fnmthk9mU/EStffnBd6aMV3/E//e/xRfi16R+w
 X0DQ==
X-Gm-Message-State: AC+VfDwM8JVlifJnrkx67m5rK4re4sAtPn9dLH1NK+vRMt7IZetC9wav
 hJQMMUCy5yXCvdqulrdJ0C5mUQ==
X-Google-Smtp-Source: ACHHUZ78CG3DwosqIvRQV5XFxcq6woTf9XYBGgonEm56xNVqCexy/mjbrfND1m2edY/7b/WhSJwGjA==
X-Received: by 2002:a5d:591c:0:b0:311:1a9d:98e with SMTP id
 v28-20020a5d591c000000b003111a9d098emr13786973wrd.58.1687523449071; 
 Fri, 23 Jun 2023 05:30:49 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 o10-20020a5d58ca000000b003111fd2e33dsm9419650wrf.30.2023.06.23.05.30.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:30:48 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 69DF71FFCE;
 Fri, 23 Jun 2023 13:21:03 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Xu <peterx@redhat.com>,
 qemu-arm@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Riku Voipio <riku.voipio@iki.fi>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Bulekov <alxndr@bu.edu>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 24/26] docs/devel/qom.rst: Correct code style
Date: Fri, 23 Jun 2023 13:20:58 +0100
Message-Id: <20230623122100.1640995-25-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623122100.1640995-1-alex.bennee@linaro.org>
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Per commit 067109a11c ("docs/devel: mention the spacing requirement
for QOM"):

  For a storage structure the first declaration should always be
  called “parent_obj” and for a class structure the first member
  should always be called “parent_class”

Adapt the QOM rST document accordingly.

Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230622101717.70468-1-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/qom.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/qom.rst b/docs/devel/qom.rst
index c9237950d0..2828843058 100644
--- a/docs/devel/qom.rst
+++ b/docs/devel/qom.rst
@@ -26,7 +26,7 @@ features:
    typedef DeviceClass MyDeviceClass;
    typedef struct MyDevice
    {
-       DeviceState parent;
+       DeviceState parent_obj;
 
        int reg0, reg1, reg2;
    } MyDevice;
@@ -147,7 +147,7 @@ will also have a wrapper function to call it easily:
 
    typedef struct MyDeviceClass
    {
-       DeviceClass parent;
+       DeviceClass parent_class;
 
        void (*frobnicate) (MyDevice *obj);
    } MyDeviceClass;
-- 
2.39.2


