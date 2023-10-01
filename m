Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AE07B493A
	for <lists+qemu-devel@lfdr.de>; Sun,  1 Oct 2023 20:40:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qn1LI-0002lc-4b; Sun, 01 Oct 2023 14:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dxu@dxuuu.xyz>) id 1qn1LF-0002lJ-Mo
 for qemu-devel@nongnu.org; Sun, 01 Oct 2023 14:38:58 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dxu@dxuuu.xyz>) id 1qn1LD-0006IR-Sj
 for qemu-devel@nongnu.org; Sun, 01 Oct 2023 14:38:57 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 876633200EB8;
 Sun,  1 Oct 2023 14:38:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Sun, 01 Oct 2023 14:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
 :content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to; s=fm1; t=1696185529; x=1696271929; bh=uCMOBU5kEN
 Fhu9UtcgwbXHyvIjdPNSE4Ns0IokdqALE=; b=YxRxwP1u6e07oxYSEr6uHPS/ML
 krb2AbH1jmlM8eztjwyztJAkFmcZJbAc1AB6MqK8IR6Ur2H2dl57ucou2dBp3LGq
 6UKJFDM6ku71Anl9Wcc3Y0Sp2Hd3lpj9P969CMeyeVgowKuAiLJ8Z9zU8034Mm5C
 PIBp4vOUC3JlOF1QQNdKASO5Hvxnfy44QpfhOebVeLudUWQYzWfYoV+BO3uErh5e
 7KKbLaDUbA+Rr7gxr/PW1i0T3uqcAAwnGdHxMCvYs/sYu3qexsBVyMR87eCoNyUu
 lNE3wkXyg+vHHKwtX/3o2PyMNzGeAxvHjlELKyuNrFzLTS5gWk+X09e1ZMPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:date:feedback-id:feedback-id:from:from:in-reply-to
 :message-id:mime-version:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1696185529; x=1696271929; bh=uCMOBU5kENFhu9UtcgwbXHyvIjdP
 NSE4Ns0IokdqALE=; b=feLC9e9JaVuNN/K9akuwYcTmfXStoi+avlpfcBcU9fK5
 lFvRz4+pKdVcViWMuIff23TXrbhYX8V8N/T9FPPHQB0pbMv63J0zdhCgsX/7AoGj
 ukzeS9BY2DBcMJS9somucOWj8v3V5biZfUTV3l2yhDWpaa+T5Gm3g5D0ZXHw436f
 mRtD2P4cOm6M25aargxFM9j5BrJGkeS4Ey9vR5pBufML43+Z2ejgxMV7eHrJTCBf
 7z2disKMMykDIDAAQgeQN+k5tWJOUtpUbSR4+J7Utj56oO/p0bPy1skrWkRHZwCY
 v8MvJeGGRLz9rBqcIr7s8fVhOtG94iYD2AGCgToI9A==
X-ME-Sender: <xms:uLwZZQIKNlfhIBZUcRQeg-TMqdjXIsI5max5rNhLKOuK5lw6Ic1OVg>
 <xme:uLwZZQIrzuxkRv90Niv7cDQgCbpY9ggRdWt5AcwJ8lKtEg3eFKuxcqDe42nKH45zK
 wGoAJGhoJZJ-nz4Eg>
X-ME-Received: <xmr:uLwZZQt0pGd6kOUwXnEDhJeU5J1T96aCgy-tMwPpC82r17pDcTIASp9L2RKlsBaPJ_XGqmqQWVdO5QyXSe2U9grN0xitnxGTHt1pZkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefucetufdoteggodetrfdotffvucfrrh
 hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvffufffkof
 gggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihu
 uhhurdighiiiqeenucggtffrrghtthgvrhhnpeetfeehtedvueegtdeitdefudehudefje
 etfeejffejuefghedtheevleevudefjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhg
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguh
 esugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:uLwZZda2Tqo3xUh39FUOtfgwXPKUx8tKmARDjgElgRgW-fMf4F_bkw>
 <xmx:uLwZZXbhU5n7tIlHx3GPuvoFCuTO5_cJb5EFUqUEecg5yVF-D2VzqA>
 <xmx:uLwZZZCf9VJ0oy9z3a4JxnisLLWdJLLDuA9WCkw-_LyxpADqi4fYwA>
 <xmx:ubwZZWlnsXlG-ZIZNTW9zvA8GjVqty86Z5Nq8Hq7BF8LFn0z_Ma_xQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Oct 2023 14:38:48 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com,
 kkostiuk@redhat.com
Subject: [PATCH 0/2] Small fixes for qga
Date: Sun,  1 Oct 2023 12:38:24 -0600
Message-ID: <cover.1696185261.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.20; envelope-from=dxu@dxuuu.xyz;
 helo=wout4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

These are two small fixes that fell out of [0]. Since we are not moving
forward with that patchset, I thought it would be good to at least send
the fixes that came out of it.

See commits for more details.

[0]: https://lore.kernel.org/qemu-devel/cover.1695034158.git.dxu@dxuuu.xyz/

Daniel Xu (2):
  qga: Fix memory leak when output stream is unused
  qapi: qga: Clarify when out-data and err-data are populated

 qga/commands.c       | 4 ++--
 qga/qapi-schema.json | 8 +++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

-- 
2.42.0


