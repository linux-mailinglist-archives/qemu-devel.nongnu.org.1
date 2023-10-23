Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0226B7D3B82
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 17:52:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quxEG-00062I-24; Mon, 23 Oct 2023 11:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1quxEA-0005zX-Vd
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:52:27 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1quxE8-0006HH-NI
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:52:26 -0400
Received: from [192.168.1.2] (unknown [223.72.40.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id F1444444D8;
 Mon, 23 Oct 2023 15:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1698076342; bh=zeP9h16VeicCxdgXB8OlZw/pTI7hYEMCDe5dR9HZj8s=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=CHHZ4/USdXWI5u506lxjaQucNNUt/PmB7OmrDHdyaJIAjlUVEx3Igz0voR3qKQjz7
 2ggiucdBCTgzKCK1XeZVwEOcidKAmfwdlGu8UFDndjNTD/nFcefeAEETDmxyGjDAg4
 p68S0MctDUAoTO0TjtiSMyS8zmC7bnu1uOUmpsGY=
Message-ID: <ab59731e-05c6-4334-96cc-c39fae550290@jia.je>
Date: Mon, 23 Oct 2023 23:52:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] include/exec/memop.h: Add MO_TESB
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn, git@xen0n.name,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20231023153029.269211-2-c@jia.je>
 <20231023153029.269211-3-c@jia.je>
 <e50ca999-dd73-476b-8449-b5abeb7c6a79@redhat.com>
From: Jiajie Chen <c@jia.je>
In-Reply-To: <e50ca999-dd73-476b-8449-b5abeb7c6a79@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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


On 2023/10/23 23:49, David Hildenbrand wrote:
>
> Why?
>
> On 23.10.23 17:29, Jiajie Chen wrote:
>> Signed-off-by: Jiajie Chen <c@jia.je>
>> ---
>>   include/exec/memop.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/exec/memop.h b/include/exec/memop.h
>> index a86dc6743a..834327c62d 100644
>> --- a/include/exec/memop.h
>> +++ b/include/exec/memop.h
>> @@ -140,6 +140,7 @@ typedef enum MemOp {
>>       MO_TEUL  = MO_TE | MO_UL,
>>       MO_TEUQ  = MO_TE | MO_UQ,
>>       MO_TEUO  = MO_TE | MO_UO,
>> +    MO_TESB  = MO_TE | MO_SB,
>>       MO_TESW  = MO_TE | MO_SW,
>>       MO_TESL  = MO_TE | MO_SL,
>>       MO_TESQ  = MO_TE | MO_SQ,
>
>
>
> I recall that the reason for not having this is that the target 
> endianess doesn't matter for single bytes.

Thanks, you are right, I was copying some code using MO_TESW only to 
find that MO_TESB is missing... I should simply use MO_SB then.



