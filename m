Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B32382BEDE
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 12:06:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOFLz-000678-Oi; Fri, 12 Jan 2024 06:05:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFLE-0005fX-Fz
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:04:48 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOFLC-0008Vr-LZ
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:04:48 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3366e78d872so6593430f8f.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 03:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705057485; x=1705662285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cRMq9TExaOCBusbs+TEUCbu5HfUWlJJjud5ystqGXqo=;
 b=WYByvdYkka7vp/KMt+VlrU04kFOCLZ9emb8MCm17kYyS9HN5g+YQitY16qKh/9zu2X
 eVFRBx1Jc+u31lC40+H+hJp08n/FKN14wYpVuhZ1fXHfA/v0mWiTAbZwjc9IOvkmiRQa
 GPHZFKObX6Djubrl2rTn1uParjrpDrsGybN0zcd/zX/E3pYc/hxHe62YsZxJk+jtkmR3
 toBJcFNFpmuCaU5UMcIxv6UtK8KxoVsG2Xs1bTs8CwX6bogHwxHr1qwGTvr0A6Ov7UKV
 JU8SHYCkbjro+X7s1ifDic7cBZdadxqNOeZHZhfp3lE02OYlD1JAbvv62M30Ouq3tQe9
 +cEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705057485; x=1705662285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cRMq9TExaOCBusbs+TEUCbu5HfUWlJJjud5ystqGXqo=;
 b=bXPYLQhoGgwba5pvhMDox0bj8iBL0KDo7ibSCWU/jG9580AQyccGDk1R83QGGEACyV
 Da1ynVIuLK1dKx6VTtcrONKv7POUyk6XJ5L40iVnKscwKmjnOqkc4e1PKSSSw8oxiLxK
 66styJ5dJRoZ56wxRZOAMo3544uat6OMBZshLELxBz3wZ8nQigV4uB9jphG6Th0Fh4s4
 GyM9DZodxqUK6M4LH0MFWlQ1IzgwHVG15BqD90t1W6wrySevy1QmjX7QXicBhs4AdO4p
 bPADDMc9ySJ073nuaeeUr6/Gesx761iKd8sJkTPCOFLCHn7nIg5o8PKBJLWnMt9qdC1k
 lsVA==
X-Gm-Message-State: AOJu0YxMI1yGhT5sZr2duZEgp5OCmmwNU75z+RxJdtyZCtsksVxS0Fu3
 tTs10x7YTRuFFdXsVXypN5/T39i6e9X5Mg==
X-Google-Smtp-Source: AGHT+IHrSVf22/TWnPtMw56L6psklts+l9xWY1/dirAgrANZj8z4P+TeZCqGRMLlPbDs58Ry+OuMGQ==
X-Received: by 2002:adf:a359:0:b0:336:7d86:113e with SMTP id
 d25-20020adfa359000000b003367d86113emr343316wrb.80.1705057485286; 
 Fri, 12 Jan 2024 03:04:45 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 h18-20020adf9cd2000000b00336a1f6ce7csm3551611wre.19.2024.01.12.03.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 03:04:43 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0F94C5F951;
 Fri, 12 Jan 2024 11:04:36 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 11/22] qtest: bump prom-env-test timeout to 6 minutes
Date: Fri, 12 Jan 2024 11:04:24 +0000
Message-Id: <20240112110435.3801068-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112110435.3801068-1-alex.bennee@linaro.org>
References: <20240112110435.3801068-1-alex.bennee@linaro.org>
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

The prom-env-test can take more than 5 minutes in a --enable-debug
build on a loaded system. Bumping to 6 minutes will give more headroom.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
[thuth: Bump timeout to 6 minutes instead of 3]
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231215070357.10888-8-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 3f56b205181..b3b2e3857bd 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -5,6 +5,7 @@ slow_qtests = {
   'qom-test' : 900,
   'test-hmp' : 240,
   'pxe-test': 600,
+  'prom-env-test': 360,
 }
 
 qtests_generic = [
-- 
2.39.2


