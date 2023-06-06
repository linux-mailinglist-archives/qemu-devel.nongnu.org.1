Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18460723E4E
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:51:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TIv-0007nb-45; Tue, 06 Jun 2023 05:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIe-0007aS-OS
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:26 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIb-0004jK-TT
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:24 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-30af86a966eso4816886f8f.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686044899; x=1688636899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o0cFYseQhZqabhKDR5X5GNr6BEkaVeW/23RX2f07Hnc=;
 b=FtxuSVmnt6MhTAIZwjF1ltRaKITCKHDxysBq3Ty3yEjThpJ1hlsDDfvo61M7UHC+f9
 jquHgkQl/oLacmfixuoV/OdK7Sorw35UpJV2VYLMSu4PCRw3h6kvU+EfRP8yOoQZHMSW
 bfwh/imktyt5Ulj/eWRUWO0+/N618+gcOmGlMGccv9NhYQp47FBj3Is9BJrf5IoqrYBH
 XxWaDaHU6RNe+wNMFBuhkHHV5g4oQ2wtqwvmGQgzHckU5RSQDqHNJhDF/CaER7580GPw
 W8g0a4rCF8/VFFsT8Gace929n1Rmt0SSK48DpHYgQ/pYaRqvcM3eHKc6t0jAsuvnDets
 UyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686044899; x=1688636899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o0cFYseQhZqabhKDR5X5GNr6BEkaVeW/23RX2f07Hnc=;
 b=VZyFxTNJtPLKh7FZBrE8F9mkO3t1RQfO/qTw9n4hy3nMppESwsJaAWGge8tZg+Kmg5
 1g3bL+b9DVMynMPg42TYVh2jbm18FcOusq8olOgQmdV1X4oLq8mUKpk0KGlVIS1bRP9F
 Ki+zxZ/Z/F970xkYrpAztM+uCU4PehNBLoX1xx+MiU5kPIWknTDWYWbGDDbaLnN0t+Yk
 fjBQe6DfZfAlDFzgOapVsdpdp9KS6W2/lxFx1HZKA9ebPWZATXUYVuCqRvphUB8jKKCB
 cEznrupb/NQPy9LWs/ZN53TZSjidpzwlUSIgRhXgEV0YqM5+jIC/rGwmGqygJnJwpccX
 40rg==
X-Gm-Message-State: AC+VfDyMlIrb0DKlwl1nETJuciMRzjgXOyjJTCSUCeT8mqpQLWIT4MeE
 LPicUT78ypmnHscp0ViCYg48CYtaoF3SgGvNjbI=
X-Google-Smtp-Source: ACHHUZ7x72unNVL0kQqDiP1v8EKTdHYepLDOhW64PtXsQG2Bd2EjB+Gdf6OAfZ6gBATBkgV+SexnYw==
X-Received: by 2002:a5d:4cc8:0:b0:306:2aa7:2ed2 with SMTP id
 c8-20020a5d4cc8000000b003062aa72ed2mr1263558wrt.61.1686044899730; 
 Tue, 06 Jun 2023 02:48:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm12134017wrq.89.2023.06.06.02.48.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 02:48:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/42] MAINTAINERS: Include canfd tests under Xilinx CAN
Date: Tue,  6 Jun 2023 10:47:39 +0100
Message-Id: <20230606094814.3581397-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606094814.3581397-1-peter.maydell@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Vikram Garhwal <vikram.garhwal@amd.com>

Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 55668d63368..4b2639def6d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1819,7 +1819,7 @@ M: Francisco Iglesias <francisco.iglesias@amd.com>
 S: Maintained
 F: hw/net/can/xlnx-*
 F: include/hw/net/xlnx-*
-F: tests/qtest/xlnx-can-test*
+F: tests/qtest/xlnx-can*-test*
 
 EDU
 M: Jiri Slaby <jslaby@suse.cz>
-- 
2.34.1


