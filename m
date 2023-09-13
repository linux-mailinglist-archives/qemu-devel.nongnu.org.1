Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E401779ECB9
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 17:24:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgRir-0006Is-C8; Wed, 13 Sep 2023 11:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qgRio-0006IO-Qe
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 11:24:06 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qgRim-0000y5-98
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 11:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:
 Cc:To:Subject:Reply-To:MIME-Version:Date:Message-ID:Sender:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vXZldfMcrnLZHr6RDODdxCA1BVpu8mtVTcaeDyZQ7mQ=; b=G81agT3Okpk8PfoeMYnUdyCLWD
 A0uw68OmZPHR8JgTvwjC+Z01wKaRtRUJOZrA8IeMcVPg0NbTKcESZ8mOtMFLF7gkkoU9VnKZRSupf
 KX4aF0+0IqFkqHYY5Xsc33n4GQejmu0L2pWIB8aJYd8yxNMYXSDfRqU9ShnmzR1tjVCw=;
Message-ID: <b5b181c2-1e42-4d19-a044-e23a6d1aef03@rev.ng>
Date: Wed, 13 Sep 2023 17:23:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] include: Introduce tlb_ptr field to CPUState
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: ale@rev.ng, pbonzini@redhat.com, philmd@linaro.org,
 peter.maydell@linaro.org
References: <20230912153428.17816-1-anjo@rev.ng>
 <20230912153428.17816-3-anjo@rev.ng>
 <c0049873-fb1c-571d-baf7-ff53b34c2f23@linaro.org>
Organization: rev.ng
In-Reply-To: <c0049873-fb1c-571d-baf7-ff53b34c2f23@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Reply-to:  anjo@rev.ng
X-ACL-Warn: ,  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


> On 9/12/23 08:34, Anton Johansson wrote:
>>       IcountDecr *icount_decr_ptr;
>> +    struct CPUTLB *tlb_ptr;
>
> These are both in CPUNegativeOffsetState.
> We might as well use that pointer instead.
>
>
> r~

Ah, good point.

-- 
Anton Johansson,
rev.ng Labs Srl.


