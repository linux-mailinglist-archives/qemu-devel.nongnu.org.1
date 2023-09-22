Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D557AB4C7
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 17:30:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qji6L-0005Hn-6B; Fri, 22 Sep 2023 11:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qji6J-0005HS-Qd
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:29:51 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qji6I-00007O-B3
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:29:51 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40528376459so23327075e9.3
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 08:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695396589; x=1696001389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tfQhaCaoJV4bmK5DuDmiHN4FfP5XPw57DLNfRS7tR5k=;
 b=akXCkgC+kokjTnyKMAgDdXU3euZRS/Fg8BqKZntSHV71W3PxNsx6y4v5A552JFC9WO
 8r/7/BfVA1qeWlMcB/tdxx8F/vrmY5Awh4YGu0uzIRQbkn7FH6ZSNjoeSvb+hDzx6wn4
 wGWJd2l3Qz4QifNhB4xFjwdVCYUrdbjOEl2HwQ0FctLFOkNYn8aflNXRzlhL2D0Fw85Q
 L8LZxrJPn4Q+vYXPf6c5v+ziQeMXINm9aVp1pPHL4k04Z3+yx2VfMgGFfIo5UYsVqnsZ
 QFWpLJD37NdGoEvVGxVBiv2q2c0y1BHa+JMLawZaVWqL+PgxTfpOrRTqz6OSl7cYbnZP
 Kt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695396589; x=1696001389;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tfQhaCaoJV4bmK5DuDmiHN4FfP5XPw57DLNfRS7tR5k=;
 b=wcuqPRbqPfybk2IXmrPPKPB/5LPE2ycpp22b48IzS/Mq5cgT75UA9uvQI9Nn8R6/AS
 8y9//wqGwk7jc9euDfJnYNxR5KlW6Z0wflJzDLFLmP2dSg/MuWBO81ANeKwM0uuhI6Yd
 5ScGYsgsk7+Yjy/ivk3OO5z/rza3yInUYz9+MeGkfYlqEYCD3E/RTrHmztMg2nJE0iQw
 rd/+L2EeQ/10fMcl07+dywZb5P6g3g0FkgzFqdun95hzXXJe3np7cfNj0acalPryV0f3
 I0vVN7avHAIZug4RmrXFwPhz9wuxMZNFzaWwoJRgnlfGyN+RahpDM+FplUlOOGR2peAe
 Q0lA==
X-Gm-Message-State: AOJu0Yws7HqycpcVOwmXksG1BjQzlNtzoFThw8wpEeiSUCwt6xFz+fww
 XO1CXbk9GN5EAVg1AJ2uyC6+NQ==
X-Google-Smtp-Source: AGHT+IG/DHv9sMx7NcUVOAllIhChGMswhR3+rxBwX1Yc0jeznDE5s8MoMMMlDmBcAwUvJcASMLknCw==
X-Received: by 2002:a7b:c5ca:0:b0:404:fc52:a3c6 with SMTP id
 n10-20020a7bc5ca000000b00404fc52a3c6mr8573033wmk.25.1695396588166; 
 Fri, 22 Sep 2023 08:29:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 c22-20020a05600c171600b00405442edc69sm777137wmn.14.2023.09.22.08.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 08:29:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 0/4] arm: fix some -Wshadow warnings
Date: Fri, 22 Sep 2023 16:29:40 +0100
Message-Id: <20230922152944.3583438-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

These patches fix some -Wshadow warnings in arm related code.

-- PMM

Peter Maydell (4):
  hw/intc/arm_gicv3_its: Avoid shadowing variable in
    do_process_its_cmd()
  hw/misc/arm_sysctl.c: Avoid shadowing local variable
  hw/arm/smmuv3.c: Avoid shadowing variable
  hw/arm/smmuv3-internal.h: Don't use locals in statement macros

 hw/arm/smmuv3-internal.h | 41 +++++++++++++---------------------------
 hw/arm/smmuv3.c          |  4 ++--
 hw/intc/arm_gicv3_its.c  |  6 +++---
 hw/misc/arm_sysctl.c     |  6 +++---
 4 files changed, 21 insertions(+), 36 deletions(-)

-- 
2.34.1


