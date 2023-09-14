Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD45B7A01E1
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 12:44:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgjpE-0001fl-67; Thu, 14 Sep 2023 06:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qgjpB-0001fc-Ki
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 06:43:54 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qgjp9-00075z-9K
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 06:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:
 Cc:To:Subject:Reply-To:MIME-Version:Date:Message-ID:Sender:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ktxnxQxZya5r/Zr3whX9cTeQDLL6iBiQ0HFkssnlDic=; b=U5rdlYgsGAAoFCtdJt0lIAoYZP
 /LZ22JEEwB3O1SRp4GPWQP5ijTC0328mPv4GcMGLM8BloCJhIUcu1at8clYIXPEcaKuDBG7uYuFa1
 b6zRqMB1jF7bUj3AVgt+U71zLD5zYKqWIpisNQaeW7rUfpke2EBgcZv5RCTMVvg9AxqE=;
Message-ID: <70c7020f-a6e4-4bea-b340-bfc10b9423d3@rev.ng>
Date: Thu, 14 Sep 2023 12:43:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/24] tcg: Remove TCGContext.tlb_fast_offset
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
 <20230914024435.1381329-17-richard.henderson@linaro.org>
Organization: rev.ng
In-Reply-To: <20230914024435.1381329-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Reply-to:  anjo@rev.ng
X-ACL-Warn: ,  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


On 9/14/23 04:44, Richard Henderson wrote:
> Now that there is no padding between CPUNegativeOffsetState
> and CPUArchState, this value is constant across all targets.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg.h         |  1 -
>   accel/tcg/translate-all.c |  2 --
>   tcg/tcg.c                 | 13 +++++++------
>   3 files changed, 7 insertions(+), 9 deletions(-)
Reviewed-by: Anton Johansson <anjo@rev.ng>

