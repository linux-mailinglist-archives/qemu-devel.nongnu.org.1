Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1193173EE30
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 00:01:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDuFH-0002bM-7X; Mon, 26 Jun 2023 17:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDuFD-0002ZS-T0
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 17:59:35 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qDuF9-0004rm-W6
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 17:59:35 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3113dabc549so5498483f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 14:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687816770; x=1690408770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cf5ti9xDtG3D2s3Jcs/OJus8Ga0lob29HRcRChdiZSs=;
 b=ZW1hyw25rSw6AwGknm/Ji86AEJbr2jLB4aBgc0dvjLQW5P5USBo+LE6jf3/V8eU0St
 9uriFdpHzWoKseJmP/azUn5hqYIXVqJH/MzetuWnqLdbaRlCI+fI3gXMXKblq4/XS1Aa
 KmDGCzwKULDYYD63EK0+AA2dGXignfvRIknWvMZa8ydImlLi9HBmPOwkLikWVJ3I+eUY
 mp84SY4d1P91luQI+/YI2LGH1ciU2G2DrOWyyIsijLPuCNthOYgqddV1uG1A8QP4kEwG
 bKr+yt7A/jTKQVOeZg7C8f4jqzGlOtFZGcYfkf9AQrsSebjjpsS9PS4xbowpcMOqgqY/
 Ogiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687816770; x=1690408770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cf5ti9xDtG3D2s3Jcs/OJus8Ga0lob29HRcRChdiZSs=;
 b=iHxup0e93cxK3bt7p0a8GaNMrx4u2bLOsqFzdjEgOeyHz/pAnzzgmQ0Q6Scv8mJsV9
 t18t0mHjgjcUdDnTghLejEJsZ/Gz+iXW74BphMv6pjKgNLyNmvxHXv9NTyfD45JMlCy+
 T9z6UbQgCblijuqKF6N26d2oQKhQhJhAP/yHn/xPiRpRs4N9MD0hg8VySeuLRUn88bRk
 HUfwiLie0GaLyxQ8ux/7KqIDimM2BUxI8Q6BdbyGYpBkvX3B2bG8JjnGUv8B4e1wugKt
 hosyqMsNIkTKu1wD5Q4n17sc7+cy8gl7eO7ek6Rp/PP/P8DnAqxyJZ+q6LEvU1X8f4l5
 Uypg==
X-Gm-Message-State: AC+VfDye5fbz4at8MyCY9Ubw3DCMGQg3jXaMLYF655j6zdQzUsOGEGIX
 jxNNeEmyTL0aweYivgmhrWlKZw==
X-Google-Smtp-Source: ACHHUZ4sgnuQOhYNHB62c3Qgd0xgaQ8cZVU+PCE2wzI6TMvpVDPCzKHzVOauFczfwmsUgLT/L+X2bw==
X-Received: by 2002:a5d:4a42:0:b0:313:f366:2c68 with SMTP id
 v2-20020a5d4a42000000b00313f3662c68mr3836857wrs.26.1687816770527; 
 Mon, 26 Jun 2023 14:59:30 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 t15-20020a0560001a4f00b00313f676832bsm2289262wry.93.2023.06.26.14.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 14:59:29 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EB63D1FFC5;
 Mon, 26 Jun 2023 22:59:27 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Riku Voipio <riku.voipio@iki.fi>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-arm@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 10/26] Makefile: add lcitool-refresh to UNCHECKED_GOALS
Date: Mon, 26 Jun 2023 22:59:10 +0100
Message-Id: <20230626215926.2522656-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626215926.2522656-1-alex.bennee@linaro.org>
References: <20230626215926.2522656-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

This is yet another make target you usually run in the top level of
the source directory.

Message-Id: <20230623122100.1640995-12-alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 804a5681e0..5d48dfac18 100644
--- a/Makefile
+++ b/Makefile
@@ -28,7 +28,7 @@ quiet-command = $(quiet-@)$(call quiet-command-run,$1,$2,$3)
 
 UNCHECKED_GOALS := TAGS gtags cscope ctags dist \
     help check-help print-% \
-    docker docker-% vm-help vm-test vm-build-%
+    docker docker-% lcitool-refresh vm-help vm-test vm-build-%
 
 all:
 .PHONY: all clean distclean recurse-all dist msi FORCE
-- 
2.39.2


