Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E4A82BEE3
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 12:06:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOFM1-0006Iu-Dz; Fri, 12 Jan 2024 06:05:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFLG-0005hU-3D
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:04:50 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFLE-0008WK-Cd
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:04:49 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40e68ca8b45so1087525e9.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 03:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705057486; x=1705662286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yJCH3z0LGaT6HBDuhgfdHIX3rT7wtLaz7IyJzPUktos=;
 b=SGF42jfF7UVl4hBjy5MKMObuyrSeq+HiMb+hsOSdrs/KFLdDyTS7/+vV1aU9ppz8a2
 gQ0cZ5PjY1sb0+5pF2IMMIrprOuzB2QTh42SYo44uzyW4yGunuFVSXHEKOS/4LRJdCYn
 cjvSWWXo0Uyv9RcJcTqE5lnhUy/ihjN4IaHeFka/raxQnnaMiIfo7x0AKADhL6HYjZQG
 UP6S5DwZHxd4o+DEnw4EMpBQjZcKekH82fDtAcWlMLFkH+y4Uj5BHxdiAT5bU3E6OPb1
 Ne+FcVGbDmzIGEYqNccuNXpfkElcQHL+N9wbjpOQvVo99F12XXkG3sIgYdT9sOhFgjtj
 zo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705057486; x=1705662286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yJCH3z0LGaT6HBDuhgfdHIX3rT7wtLaz7IyJzPUktos=;
 b=SSouSiQvvVNi7BNHPSPidS7DvykICymaYqrBYdkbq6lHVuTHuu369avaPoLiMYUssc
 wzigNbAgZDXHe7Bvp0Sx8s4/90HOkRsf0fe6oY/GlOFOeYPT15/zNCq83O58W39/YX/m
 UqQpOciBENKZh5krYwyQm4yAsMgQkNlidJwDM3Phe7qu0ugPMQs8JjBZvXLKaiKoveXz
 cRTmfGdgHYgQRZkTjs8lcl+W3DFlIM7JIVFGt5yVutClV6iIjJzsQXrZmZyhlTFAt/Ay
 SHQBS7KkR2FG0HBcx/ksFbk7T8rbPRk6mmERagiW8GnWNxDrnJjKZx9BuoBsufmGmHoR
 AGLQ==
X-Gm-Message-State: AOJu0YwFo89JIUXp/NNbhX71jMIUNN8nSs/r1A8W9fjEp/kmynuCnJmL
 8Izf/bFUP7O534+3Chxo9KNM+1c2EbpIlQ==
X-Google-Smtp-Source: AGHT+IFfr74L1V9Y++qy1bmhkk5usgB0FfZCyp3IXyieO9dJxj7VRZ6MHp4pbd4ZpXFK4dLblF9cMw==
X-Received: by 2002:a05:600c:4f4a:b0:40e:4e65:a6e4 with SMTP id
 m10-20020a05600c4f4a00b0040e4e65a6e4mr711621wmq.122.1705057486797; 
 Fri, 12 Jan 2024 03:04:46 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 q6-20020adf9dc6000000b003378e67fd2asm2919266wre.86.2024.01.12.03.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 03:04:43 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3B2F55F954;
 Fri, 12 Jan 2024 11:04:36 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 13/22] qtest: bump qos-test timeout to 2 minutes
Date: Fri, 12 Jan 2024 11:04:26 +0000
Message-Id: <20240112110435.3801068-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112110435.3801068-1-alex.bennee@linaro.org>
References: <20240112110435.3801068-1-alex.bennee@linaro.org>
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

From: Daniel P. Berrangé <berrange@redhat.com>

The qos-test takes just under 1 minute in a --enable-debug
build. Bumping to 2 minutes will give more headroom.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20230717182859.707658-10-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231215070357.10888-10-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 6d89bac722b..eaa2cf64a3f 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -7,6 +7,7 @@ slow_qtests = {
   'pxe-test': 600,
   'prom-env-test': 360,
   'boot-serial-test': 180,
+  'qos-test': 120,
 }
 
 qtests_generic = [
-- 
2.39.2


