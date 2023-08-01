Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B5776B8F5
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 17:46:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQrYd-0001R1-9I; Tue, 01 Aug 2023 11:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQrYQ-0001JZ-Rf
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 11:45:00 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQrYN-0003kO-UJ
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 11:44:58 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3174aac120aso5357983f8f.2
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 08:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690904693; x=1691509493;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iIRxuOKcFciFwq9ZheHm9rMS67KZcThQh2psN+QTh3o=;
 b=bSkSe8ujoVoBAyEYZp3Y+p257HYUSSRPde2NMCW14NTmsrrG00HT/HJV2mR0PLefmU
 XuGE3TnYYHiRcKJHPGIu5UtBNG1w2usdJANl3OruJv7ZUdURTAaUWy8Qe86cKsklKuea
 +Ag3M8kqdZQtFeyg4inNXoCrZriOJfClmNg5z+B6FFc11pDEhUvqjER+0BYD/CxEYe3G
 zb2PF/Ga+LvR692mYuMjCJJr+1h6t5hcYTXrVHOmk8/Y2HVog94O3WgtyEeNncvjd85y
 V5iZgLRXoW77wlFz75GAcTpn18JqNA7VkpQQ9ld0+Aeqrc/cdrwmSaN6A2qlU9KHzwh+
 SXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690904693; x=1691509493;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iIRxuOKcFciFwq9ZheHm9rMS67KZcThQh2psN+QTh3o=;
 b=c3wPtD4vGGISJsXqQjYv1ma9sVWthzaT457k4SYfrIYDYOaGgTlJGrPF0gT9O9D3Kl
 kx8x4ny5nqm87eYQRBCys8ddI6MQ6HXMUqtREFfR8tS7tXP7cWy1OYkj+c0rAqzCYWNK
 OYtlEap0/Z2jaI5aJqBMJHVgwPGnZxHZyCa9rpnr0za0BzO2FiViRbKWeRtxWxj/3y2k
 ht0TcBI0ItU7vWALihOFYV9L62QuMGP96JSZ5fVi6ZgtLx1qJOkFuNw7S7FKK7pBcMWA
 +bHQoq4SaEf0MaGCxBTbxLwim2/IF/eUPPqm0kqEeB+TdaB7f03Ni4SwNHZVfevGZ96o
 ziQA==
X-Gm-Message-State: ABy/qLaJw/tRwNacCCr5dp9l6XHFago2y7D4TIZd4pyR0+MSjquT7lwE
 LjgflEvoUPvfEPRbKJCM90JiC4VxkfYkj8irE5U=
X-Google-Smtp-Source: APBJJlGFBd+PysvC4NoI7m3GN+C41tN6yVacmW3teI6jzSLLx9GMIlYUj3vz0F2/89xpOSrcEMRjAg==
X-Received: by 2002:a5d:4fcd:0:b0:30f:af19:81f3 with SMTP id
 h13-20020a5d4fcd000000b0030faf1981f3mr2566249wrw.41.1690904693088; 
 Tue, 01 Aug 2023 08:44:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 k8-20020a056000004800b003141a3c4353sm16526883wrx.30.2023.08.01.08.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Aug 2023 08:44:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] target/m68k: Add URL to semihosting spec
Date: Tue,  1 Aug 2023 16:44:51 +0100
Message-Id: <20230801154451.3505492-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

The spec for m68k semihosting is documented in the libgloss
sources. Add a comment with the URL for it, as we already
have for nios2 semihosting.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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


