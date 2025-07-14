Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3FBB04613
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Jul 2025 19:03:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubMXs-0003GB-Nk; Mon, 14 Jul 2025 13:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1ubLcw-0005ZY-9y
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 12:02:09 -0400
Received: from out-174.mta0.migadu.com ([2001:41d0:1004:224b::ae])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1ubLcr-0008OZ-JB
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 12:02:02 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1752508911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=FJNGTruBYMOZoL9jMo/DMmdqaDC+58LmQc7hJiTun9o=;
 b=J6w+iDQRWszJ5hfT3GlkPgUrfO5fybKYywLGScgSsUaxP/482HJCojKwTEy/rMfzHv6bL6
 cyi+E+3NXy92worSFaESz4BmG6Cwmx9GKPPbT3VvQPBqZknpXG7vTiU64Dtq61o8yVtZjS
 mYWP/bBTjj7KuVesbF84KWJXAeuEllQ=
From: Zenghui Yu <zenghui.yu@linux.dev>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: agraf@csgraf.de, mads@ynddal.dk, peter.maydell@linaro.org,
 Zenghui Yu <zenghui.yu@linux.dev>
Subject: [PATCH v2 0/2] hvf: arm: two small GIC sysreg emulation fixes
Date: Tue, 15 Jul 2025 00:01:37 +0800
Message-Id: <20250714160139.10404-1-zenghui.yu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:1004:224b::ae;
 envelope-from=zenghui.yu@linux.dev; helo=out-174.mta0.migadu.com
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

* From v1 [1]:
  - add patch #1, as suggested by Peter

[1] https://lore.kernel.org/r/20250315132030.95209-1-zenghui.yu@linux.dev

Zenghui Yu (2):
  hvf: arm: Add permission check in GIC sysreg handlers
  hvf: arm: Emulate ICC_RPR_EL1 accesses properly

 target/arm/hvf/hvf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.34.1


