Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E80785A42
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 16:19:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYogS-0006BR-5O; Wed, 23 Aug 2023 10:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qYogD-00068N-KB
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:17:53 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qYogC-0000OK-7l
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MGwUQus6T47Sod6QWn0LpTVooThdVAU0+RQhWKBZSn0=; b=N47KUyF2b8yg7rxxJD+ceFI2nI
 6Lf2YKa3zT5k6WmxDMOhKm022Hk3BbdxtoT4wll+CipDyq99MzxKGCQRQgPzOfjgkcy2rksdnrx8r
 JuzLY2fLKaKeZUSZIXwDO1FKxWQXv7bOWnADp/dGyw9P0DkBYjuluI2xHOhM23gd3XgjvUFbuDBxn
 t524dPjVp63EBZE7FSgaMQ1BtQxZ+ejJVWJdiA3zkmi3k1Le3y8NnLnItk8xxVlr4CRxh3OuzTMRK
 m+3jIb7M9ml7RWOwV9urV/TPZE0jZrum/8qD3kFJiT4lH9FIhWoutejH8T6K0Rv1pA+gg/nPqRU29
 zp6ayaeNPwWvXBN5Vh0qRUl4HKccRHV1nwXsCswe8mHCvtrYYz0uPOsSKmapGXMVnVwGC+tFEf1mE
 Jsn/KUgLhcAKWDj7pmF2+HZyovyttRBqHr4JkSBQ9wN4MyKziLSzI5OuoCiKS/MkKUGHoMkTT2YA4
 Zc9AzK7gKo//xejT9c+fWYbF7+L8eXV87X4fCcK5EYk21DE34uZ41QJDQWPcpH3qNNSYjO/Xg2yrT
 Pz1sDAP/ZURHr01ry0qAdhAQy0PUVcIQtXMolyBQc9XqDenY2PlXrREUv05RJ59G7c1hpK8SVKlLR
 yu2/MJte9yHtLBQFjAifbMwprFFVQWEjvrMoHvgN0=;
Received: from host81-158-188-207.range81-158.btcentralplus.com
 ([81.158.188.207] helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qYofc-0008IQ-B9; Wed, 23 Aug 2023 15:17:20 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	philmd@linaro.org
Date: Wed, 23 Aug 2023 15:17:40 +0100
Message-Id: <20230823141740.35974-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 81.158.188.207
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH] docs/devel/tcg-ops: fix missing newlines in "Host vector
 operations" section
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

This unintentionally causes the mov_vec, ld_vec and st_vec operations to appear
on the same line.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 docs/devel/tcg-ops.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 6a166c5665..4bbd6db2c6 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -712,7 +712,9 @@ E.g. VECL = 1 -> 64 << 1 -> v128, and VECE = 2 -> 1 << 2 -> i32.
 .. list-table::
 
    * - mov_vec *v0*, *v1*
+
        ld_vec *v0*, *t1*
+
        st_vec *v0*, *t1*
 
      - | Move, load and store.
-- 
2.39.2


