Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B7C787CB7
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 03:04:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZLEU-0007Wt-3q; Thu, 24 Aug 2023 21:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qZHVZ-0002dw-TF
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 17:04:49 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qZHVX-0001fL-EI
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 17:04:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 906576618D;
 Thu, 24 Aug 2023 21:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10937C433C7;
 Thu, 24 Aug 2023 21:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692911078;
 bh=wFABjGITAxyb2UWqOPzzjoyLyQifoC1dqaAO1lQSzt8=;
 h=From:To:Cc:Subject:Date:From;
 b=hgKgKkkP+j1fdVT3o2VbLcayDzEJABqtF7S3yeZWlRWR3lkMI1dcShjMMCp8B4JuR
 +MCqqy4/CbCRpvWfmOC/d8+Rr5VmK0Tg1Ve3+grFk/yHVvPM9rCVcZ95OTqmxKdlRH
 ZCfxDBVshoTdkN/lI4B5udm/cqyXtmKTvHGet33h/o72+y+XSfEj271eUxJKHgmCGM
 nFdgqh9TRTdB7PUmMLEsMmcCbFqmQrZGm8G0ejrtXcwv7ruxf/wX6bHHc5n5KEDQAa
 hq/ol8USWYUEg98hLKk3EoTbk5V20KMBZ+/57uwWIxFHh4tUXCNOo2GaNJNC3IjrXS
 53nojGji+ZlDg==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 0/5] target/hppa: Clean up conversion from/to MMU index and
 priviledge level
Date: Thu, 24 Aug 2023 23:04:29 +0200
Message-ID: <20230824210434.151971-1-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 24 Aug 2023 21:03:17 -0400
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

From: Helge Deller <deller@gmx.de>

Make the conversion between priviledge level and QEMU MMU index
consitent, and afterwards switch to MMU indices 11-15.

Signed-off-by: Helge Deller <deller@gmx.de>

Helge Deller (5):
  target/hppa: Add missing PL1 and PL2 priviledge levels
  target/hppa: Add priviledge to MMU index conversion helpers
  target/hppa: Do not use hardcoded value for tlb_flush_*()
  target/hppa: Use privilege helper in hppa_get_physical_address()
  target/hppa: Switch to use MMU indices 11-15

 target/hppa/cpu.h        | 19 +++++++++++++++----
 target/hppa/helper.c     |  2 +-
 target/hppa/mem_helper.c | 16 ++++++++--------
 target/hppa/translate.c  |  9 +++++----
 4 files changed, 29 insertions(+), 17 deletions(-)

-- 
2.41.0


