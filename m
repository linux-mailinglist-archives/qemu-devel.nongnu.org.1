Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB80F7A984F
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 19:39:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjNcI-0001z3-3U; Thu, 21 Sep 2023 13:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcF-0001yo-PP
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:27 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcC-0007ec-T6
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:26 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4050bd2e33aso13258845e9.2
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 10:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695317843; x=1695922643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cjcMhrWP1zUiCzEV4lG0uJngonIBEvy+btrPgJEisu0=;
 b=ZmT4WFRMk7QcaJROC4mRgvp9Uot9EFcCVW51NP03HbpW6QUcQDHsFaMcw0Vp6CC3th
 WoW2ZOunKQUcyXXGs8G5vWqEwWbBRbpisE/+9dFwc6zwRp376h9Eh2N48b0aG4IynjKN
 ZhAAqxYI/GDn9CeY6Y1tEcT3mMyZcpMh194BTOVTA//j5R7UGziOaywHYAMafcEv8ebU
 W+FH+IWH8Lx6gS2Fp0mpVW9QYPJ2qpZTpYTgbpqFf8+WIB4+u8LbWXWdguHRNfOpIos2
 nqO0WaWMfHtFoYQtegocMn2kP7jaec/3K2XWsltFmnAWi959++yKO7Sn/woD//OSxswE
 XuQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695317843; x=1695922643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cjcMhrWP1zUiCzEV4lG0uJngonIBEvy+btrPgJEisu0=;
 b=rMXg770+hgEWe5nd+OlfcHBSdtznLav6R9jGp8Ksnl0fsu6VqImQXflUqyw4TyOKg2
 Gvwti1KMyCXLF1hj6zUaKzvoE/hXOBE0zSuLW4SK2Ky/HNLIV3ulDre27F2NGXr1qiJq
 Gbdqe6LocV7p37WErcIuCcWVcO++NS2KZodtnJbwAlf1Ph0kYAPuw9UfWeEr4oFFo3A5
 up926mkOHDjDzI2LD3KJKQM/jE3hMa2DTd7ksqrmgw/9+ppiN0j9Gnxfz4Q56D8zdwrH
 EbRbUk+c7NJIoZdUeNRWHw1BNi+4xEWsOcZt6nffZDT3HDual4k3j6VpAzK0cIRDVrGa
 Nd+A==
X-Gm-Message-State: AOJu0Yxv9i50R28QFhV7mCyrc+k8CzWQE9E2I36oFughCmlw6XFNH2wt
 K+ftdSSn2DZSerfiFUZfz5ubN6ai9pIxm4tcOzY=
X-Google-Smtp-Source: AGHT+IGoRRQbp1anf43RadeToNyDDEb3kow7gx947Qod20fFwTxM0H4/MgrccE6FuS1oxCR2RGCiQQ==
X-Received: by 2002:a7b:ca5a:0:b0:402:bda9:74d1 with SMTP id
 m26-20020a7bca5a000000b00402bda974d1mr5967870wml.8.1695317843084; 
 Thu, 21 Sep 2023 10:37:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a7bce0e000000b003feff926fc5sm2464122wmc.17.2023.09.21.10.37.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 10:37:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/30] target/m68k: Add URL to semihosting spec
Date: Thu, 21 Sep 2023 18:36:51 +0100
Message-Id: <20230921173720.3250581-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921173720.3250581-1-peter.maydell@linaro.org>
References: <20230921173720.3250581-1-peter.maydell@linaro.org>
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

The spec for m68k semihosting is documented in the libgloss
sources. Add a comment with the URL for it, as we already
have for nios2 semihosting.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230801154451.3505492-1-peter.maydell@linaro.org
---
 target/m68k/m68k-semi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/m68k/m68k-semi.c b/target/m68k/m68k-semi.c
index 239f6e44e90..80cd8d70dbb 100644
--- a/target/m68k/m68k-semi.c
+++ b/target/m68k/m68k-semi.c
@@ -15,6 +15,10 @@
  *
  *  You should have received a copy of the GNU General Public License
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ *  The semihosting protocol implemented here is described in the
+ *  libgloss sources:
+ *  https://sourceware.org/git/?p=newlib-cygwin.git;a=blob;f=libgloss/m68k/m68k-semi.txt;hb=HEAD
  */
 
 #include "qemu/osdep.h"
-- 
2.34.1


