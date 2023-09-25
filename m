Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1387AD014
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 08:23:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkezp-0001GS-DE; Mon, 25 Sep 2023 02:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1qkezY-0001Cj-7Y; Mon, 25 Sep 2023 02:22:49 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1qkezV-00052U-R9; Mon, 25 Sep 2023 02:22:47 -0400
Received: from localhost.localdomain
 (ppp118-210-175-231.adl-adc-lon-bras34.tpg.internode.on.net
 [118.210.175.231])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E765920174;
 Mon, 25 Sep 2023 14:22:31 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1695622953;
 bh=SP6r/i/ty5vnsKhToKJGT84ilXlerfNK1h8aBbma2qI=;
 h=From:To:Cc:Subject:Date;
 b=Q6vxALAZMxuepBJPAJBSK6YGbZ5uOAZdJEOSoZFoStPIAjgWiWpYtcQExmjUkGCwS
 dgbWE6+NiEyuHlIgjuqjmbFi7oZE2r0roz0dQ1BHva9vGz2STYxvtyXZfZG3YzkTGH
 Zgtp83kMNoQCbQVAWP/FxoWx8rF7hgHsneHBhYoQD+ywzwS7R3VOCt4I5G7xDI4RL7
 XslY4I0e+/mGTEL6rl671HoG5KHin+Mo8XaHcsTNWk98MQa3sSpLTukmiP2RMz6fng
 gcdmWNAEIzmizwOEp3/woB7KPkStC8hPQfvv4CaTBx0K7ckg4BOgbHroaVM4mHHpoI
 Wc/mtknPmbfLw==
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: clg@kaod.org,
	andrew@aj.id.au
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, joel@jms.id.au,
 peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH] MAINTAINERS: aspeed: Update Andrew's email address
Date: Mon, 25 Sep 2023 15:52:12 +0930
Message-Id: <20230925062212.66112-1-andrew@codeconstruct.com.au>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.29.241.158;
 envelope-from=andrew@codeconstruct.com.au; helo=codeconstruct.com.au
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

I've changed employers, have company email that deals with patch-based
workflows without too much of a headache, and am trying to steer some
content out of my personal mail.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---

Hi Cédric, do you mind including this in your Aspeed queue?

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 355b1960ce46..b142c09628b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1108,7 +1108,7 @@ F: docs/system/arm/emcraft-sf2.rst
 ASPEED BMCs
 M: Cédric Le Goater <clg@kaod.org>
 M: Peter Maydell <peter.maydell@linaro.org>
-R: Andrew Jeffery <andrew@aj.id.au>
+R: Andrew Jeffery <andrew@codeconstruct.com.au>
 R: Joel Stanley <joel@jms.id.au>
 L: qemu-arm@nongnu.org
 S: Maintained
-- 
2.39.2


