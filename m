Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2268C5C00
	for <lists+qemu-devel@lfdr.de>; Tue, 14 May 2024 21:59:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6yIL-0000vR-HV; Tue, 14 May 2024 15:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6yI7-0000my-NY
 for qemu-devel@nongnu.org; Tue, 14 May 2024 15:58:29 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6yI6-0007so-15
 for qemu-devel@nongnu.org; Tue, 14 May 2024 15:58:27 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 02D9860ECB;
 Tue, 14 May 2024 19:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66470C2BD10;
 Tue, 14 May 2024 19:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715716703;
 bh=dtp9mNMPDGMEohUmVW1yZdEgKyM4W452IQ1peNmJBPw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qRO9yKnM0Ppwnejk9h/1hMeGa6j58XKx3WXYXSEeQ5+d4GZYxLAAEw9H3b9dqC5TW
 D9m9hIPk6ivZuwsJlyU2ePU6Q8/SrGt3a2AtZX8UPmvP2EWXKY3cTNKS4S5xIC3Wod
 ffXoppSmlVwDIx7L5UYplC/F8vJ+YhxM3dDJ3amL7wuiVPtcQ4g4Ouz3HeZtRV3BKQ
 3rqw5sZ0KwHCqcywsoIzS2o/0EI8rhWOAcU9AI82SYnfPY7z3pHYSGJFyN21GUCEaB
 wB+TlLdFPIMrPJJ9LSwOeZR8nXXLSx9ahaisGbV5k6EQAi0EWcJ3iBs+39A34zfA96
 39rVmlKPRFttw==
Date: Tue, 14 May 2024 21:58:19 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH v2 31/45] linux-user/hppa: Force all code addresses to
 PRIV_USER
Message-ID: <ZkPCW6RZQBUZC1gK@carbonx1>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-32-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513074717.130949-32-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
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
> The kernel does this along the return path to user mode.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>

>  linux-user/hppa/target_cpu.h |  4 ++--
>  target/hppa/cpu.h            |  3 +++
>  linux-user/elfload.c         |  4 ++--
>  linux-user/hppa/cpu_loop.c   | 14 +++++++-------
>  linux-user/hppa/signal.c     |  6 ++++--
>  target/hppa/cpu.c            |  7 +++++--
>  target/hppa/gdbstub.c        |  6 ++++++
>  target/hppa/translate.c      |  4 ++--
>  8 files changed, 31 insertions(+), 17 deletions(-)

