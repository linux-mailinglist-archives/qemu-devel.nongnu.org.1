Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 954F77E6C1A
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 15:08:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15gf-0007td-IS; Thu, 09 Nov 2023 09:07:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15eK-0001FG-DG; Thu, 09 Nov 2023 09:04:52 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15eI-0007M3-HG; Thu, 09 Nov 2023 09:04:47 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7260331BF0;
 Thu,  9 Nov 2023 16:59:58 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7BAEF34527;
 Thu,  9 Nov 2023 16:59:50 +0300 (MSK)
Received: (nullmailer pid 1462949 invoked by uid 1000);
 Thu, 09 Nov 2023 13:59:47 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sergey Evlashev <vectorchiefrocks@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.7 56/62] target/mips: Fix MSA BZ/BNZ opcodes displacement
Date: Thu,  9 Nov 2023 16:59:24 +0300
Message-Id: <20231109135933.1462615-56-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.7-20231109164316@cover.tls.msk.ru>
References: <qemu-stable-7.2.7-20231109164316@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The PC offset is *signed*.

Cc: qemu-stable@nongnu.org
Reported-by: Sergey Evlashev <vectorchiefrocks@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1624
Fixes: c7a9ef7517 ("target/mips: Introduce decode tree bindings for MSA ASE")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230914085807.12241-1-philmd@linaro.org>
(cherry picked from commit 04591b3ddd9a96b9298a1dd437a6464ab55e62ee)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/mips/tcg/msa.decode b/target/mips/tcg/msa.decode
index 9575289195..4410e2a02e 100644
--- a/target/mips/tcg/msa.decode
+++ b/target/mips/tcg/msa.decode
@@ -31,8 +31,8 @@
 
 @lsa                ...... rs:5 rt:5 rd:5 ... sa:2 ......   &r
 @ldst               ...... sa:s10 ws:5 wd:5 .... df:2       &msa_i
-@bz_v               ...... ... ..    wt:5 sa:16             &msa_bz df=3
-@bz                 ...... ...  df:2 wt:5 sa:16             &msa_bz
+@bz_v               ...... ... ..    wt:5 sa:s16            &msa_bz df=3
+@bz                 ...... ...  df:2 wt:5 sa:s16            &msa_bz
 @elm_df             ...... .... ......    ws:5 wd:5 ......  &msa_elm_df df=%elm_df n=%elm_n
 @elm                ...... ..........     ws:5 wd:5 ......  &msa_elm
 @vec                ...... .....     wt:5 ws:5 wd:5 ......  &msa_r df=0
-- 
2.39.2


