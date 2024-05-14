Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D20118C5B6F
	for <lists+qemu-devel@lfdr.de>; Tue, 14 May 2024 21:01:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6xNx-0002Cx-GM; Tue, 14 May 2024 15:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6xNt-0002CO-89
 for qemu-devel@nongnu.org; Tue, 14 May 2024 15:00:21 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6xNr-00007k-5H
 for qemu-devel@nongnu.org; Tue, 14 May 2024 15:00:20 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id F3420CE1262;
 Tue, 14 May 2024 19:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A115C2BD10;
 Tue, 14 May 2024 19:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715713214;
 bh=AJOIpt0hkD0is7IWP90n5OSe1sAXY048jSyAga3nTrA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YuCFIjeQxyWCyEKctK/mv5lBpg1NY8W0FiADkulvIKMKeVOl/T4Qv4Zzss6d4XfCX
 rl88RhVNOakh7G+Tfo6KC2GnFQgV2QrMPP89oYlpo1BP/f9mc838d05qBqmtwP3PBy
 FNnCG6QyoJisR0OttxocA3IiDglR6yeyKMyxbkoBFJDrH2PYmZ7ufwuT7TPOzOJL8K
 cAQ97CtptR0ipebujNRahd1Xi1F5xkQSTCwWoJTnNQ6B8QTe/hwi2/frQCIQKLPhG1
 hozHxlbxbfRNw2iNuXKcd+qe6W0uCXFhoIwvU0/ZFZ2bHB+8vdxnKC+vWfvKCB+rgD
 Sm30VDpZEmbrA==
Date: Tue, 14 May 2024 21:00:09 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH v2 30/45] target/hppa: Use delay_excp for conditional
 trap on overflow
Message-ID: <ZkO0uX1a3MxCoLA7@carbonx1>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-31-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513074717.130949-31-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=deller@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

* Richard Henderson <richard.henderson@linaro.org>:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/hppa/helper.h     |  1 -
>  target/hppa/int_helper.c |  2 +-
>  target/hppa/op_helper.c  |  7 -------
>  target/hppa/translate.c  | 21 +++++++++++++--------
>  4 files changed, 14 insertions(+), 17 deletions(-)

Reviewed-by: Helge Deller <deller@gmx.de>

