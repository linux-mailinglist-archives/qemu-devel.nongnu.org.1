Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EAB8CD2EB
	for <lists+qemu-devel@lfdr.de>; Thu, 23 May 2024 14:59:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA814-0005hU-7F; Thu, 23 May 2024 08:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1sA80w-0005fb-R5
 for qemu-devel@nongnu.org; Thu, 23 May 2024 08:57:47 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1sA80o-0004Kf-VV
 for qemu-devel@nongnu.org; Thu, 23 May 2024 08:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=Y5pyG65tJiq90K0/mGanTVUNJK8xdi87+bm1Cn6QTU4=; b=YkBxw8NG5mrzley
 96e2Ba3ovZSt+tZmX8p+CC4un7KSFcywZuPD6UDVMDKxBfv8EDaTp8NdI//cTQ6zvNpTQUDQ9cIsw
 GEAZBKu1kiBMvSkGxp2MzSj4ln4oAmDRzFOY9X1YW1pdZOHm1WWc+KDhBE8BQBiWtwV1eUBJclGUR
 0U=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng,
	ltaylorsimpson@gmail.com,
	bcain@quicinc.com
Subject: [PATCH v4 0/4] target/hexagon: Minor idef-parser cleanup
Date: Thu, 23 May 2024 14:58:57 +0200
Message-ID: <20240523125901.27797-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Was running idef-parser with ASAN and noticed we were leaking the
init_list GArray, which is used to hold instruction arguments that may
need initialization.  This patchset fixes the leak, removes unused
macros and undefined functions, and simplifies gen_inst_init_args() to
only handle predicate values.

Changes in v2:
  * Update comment in 3rd patch
  * Follow style guide in 4th patch

Changes in v3/v4:
  * Added reviewed-bys

Anton Johansson (4):
  target/hexagon: idef-parser remove unused defines
  target/hexagon: idef-parser remove undefined functions
  target/hexagon: idef-parser fix leak of init_list
  target/hexagon: idef-parser simplify predicate init

 target/hexagon/idef-parser/idef-parser.h    | 10 ------
 target/hexagon/idef-parser/idef-parser.y    |  2 --
 target/hexagon/idef-parser/parser-helpers.c | 35 +++++++++++++--------
 target/hexagon/idef-parser/parser-helpers.h | 13 --------
 4 files changed, 22 insertions(+), 38 deletions(-)

-- 
2.45.0


