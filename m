Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D813779DCB
	for <lists+qemu-devel@lfdr.de>; Sat, 12 Aug 2023 08:55:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUiVO-0004sk-5R; Sat, 12 Aug 2023 02:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisyuu@B-L8MBMD6R-2342.local>)
 id 1qUiVK-0004rw-A9
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 02:53:42 -0400
Received: from [106.11.34.246] (helo=B-L8MBMD6R-2342.local)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <francisyuu@B-L8MBMD6R-2342.local>)
 id 1qUiVD-0006cr-Nm
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 02:53:42 -0400
Received: by B-L8MBMD6R-2342.local (Postfix, from userid 502)
 id A71793992E5; Sat, 12 Aug 2023 14:53:15 +0800 (CST)
From: Hang Yu <francis_yuu@stu.pku.edu.cn>
To: qemu-devel@nongnu.org
Cc: komlodi@google.com,
	peter@pjd.dev,
	Hang Yu <francis_yuu@stu.pku.edu.cn>
Subject: [PATCH v3 0/3] hw/i2c/aspeed: Fix Tx and Rx error
Date: Sat, 12 Aug 2023 14:52:27 +0800
Message-Id: <20230812065230.8839-1-francis_yuu@stu.pku.edu.cn>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 106.11.34.246 (failed)
Received-SPF: none client-ip=106.11.34.246;
 envelope-from=francisyuu@B-L8MBMD6R-2342.local; helo=B-L8MBMD6R-2342.local
X-Spam_score_int: 25
X-Spam_score: 2.5
X-Spam_bar: ++
X-Spam_report: (2.5 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NO_DNS_FOR_FROM=0.001, RCVD_IN_PBL=3.335,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Hi!Thanks for your advice! I made the following changes from v2 to v3:
1. Merge the submissions of patch1 and patch2 in v2, and add the fixes tag
2. Fixed typos
3. patch3:
  3.1 Simplified the judgment logic of buffer organization.
  3.2 Change the buffer organization field to a shared field, and move it 
  from I2CC_POOL_CTRL to I2CD_POOL_CTRL.

Hang Yu.

Hang Yu (3):
  hw/i2c/aspeed: Fix Tx count and Rx size error in buffer pool mode
  hw/i2c/aspeed: Fix TXBUF transmission start position error
  hw/i2c/aspeed: Add support for buffer organization

 hw/i2c/aspeed_i2c.c         | 39 ++++++++++++-------------------------
 include/hw/i2c/aspeed_i2c.h |  5 +++--
 2 files changed, 15 insertions(+), 29 deletions(-)

-- 
2.39.2 (Apple Git-143)


