Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DE87509C8
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 15:41:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJa4q-0007l5-0n; Wed, 12 Jul 2023 09:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qJa4n-0007kk-Tb
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 09:40:18 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qJa4g-0000Um-Ar
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 09:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:Reply-To:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=H2dLAzJjrnBx4izSL1Mk8z3VhtukkLcjb1IVhq5o/zE=; b=BNqYqNzQdPxxSEvyF1i6NEJubu
 tDZAQNM15Msxqnr+vpvXQtTOmj4S3QovY53lZmWXKUGn3K2FdM1cUQOU1FZe0O6p30/plR/fSLhj8
 yFPnCscY8xIOMbglbHD5XZcSRdEF6o0Js4UIu1b9lz0FQ6nnJuG6ZjxeRv4PzmbF/ffo=;
Message-ID: <9c7c151e-0c1b-5f5c-ecde-073e059e5d66@rev.ng>
Date: Wed, 12 Jul 2023 15:39:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH-for-8.1] linux-user/arm: Do not allocate a commpage at all
 for M-profile CPUs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Christophe Lyon <christophe.lyon@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230711153408.68389-1-philmd@linaro.org>
Content-Language: en-US
Organization: rev.ng
In-Reply-To: <20230711153408.68389-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.11,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  anjo@rev.ng
X-ACL-Warn: ,  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


On 7/11/23 17:34, Philippe Mathieu-Daudé wrote:
> Since commit fbd3c4cff6 ("linux-user/arm: Mark the commpage
> executable") executing bare-metal (linked with rdimon.specs)
> cortex-M code fails as:
>
>    $ qemu-arm -cpu cortex-m3 ~/hello.exe.m3
>    qemu-arm: ../../accel/tcg/user-exec.c:492: page_set_flags: Assertion `last <= GUEST_ADDR_MAX' failed.
>    Aborted (core dumped)
>
> Commit 4f5c67f8df ("linux-user/arm: Take more care allocating
> commpage") already took care of not allocating a commpage for
> M-profile CPUs, however it had to be reverted as commit 6cda41daa2.
>
> Re-introduce the M-profile fix from commit 4f5c67f8df.
>
> Fixes: fbd3c4cff6 ("linux-user/arm: Mark the commpage executable")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1755
> Reported-by: Christophe Lyon <christophe.lyon@linaro.org>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   linux-user/elfload.c | 21 +++++++++++++++++----
>   1 file changed, 17 insertions(+), 4 deletions(-)
Reviewed-by: Anton Johansson <anjo@rev.ng>

