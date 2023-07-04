Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD72746C71
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 10:55:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGboG-000304-4u; Tue, 04 Jul 2023 04:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qGboE-0002zw-VZ
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:54:54 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qGboC-0004qS-SY
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:
 Cc:To:Subject:Reply-To:MIME-Version:Date:Message-ID:Sender:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=r3oOVVPgUoxpJiTfMLMr8sOc9a9nusM6m8jPgpZZsao=; b=DFAQX4dlRgKGAAQTeTOC7ngXA0
 I+cCJPZ6Rk7AhWl3WGvnbU+SwwV/KexFnj33VhOWRyrHpwRvxde54sEg/DenMGqifcdYYnCDMKWp6
 kr88Bg6whfJEnbyMAElq1Bgc+MEFuFLz9CTx9XupG6yavm4/+yFwCKhi1r4ZwQ9JyJic=;
Message-ID: <02d69bfb-27ee-26a6-26b4-e702a57cf699@rev.ng>
Date: Tue, 4 Jul 2023 10:54:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/9] Collapse CPUNegativeOffsetState into CPUState
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org, eduardo@habkost.net,
 philmd@linaro.org, marcel.apfelbaum@gmail.com, peter.maydell@linaro.org,
 wangyanan55@huawei.com
References: <20230630122551.21766-1-anjo@rev.ng>
 <6e7f39df-1ad4-d155-6d80-37dd89a28f6a@redhat.com>
Organization: rev.ng
In-Reply-To: <6e7f39df-1ad4-d155-6d80-37dd89a28f6a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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


On 7/1/23 11:21, Paolo Bonzini wrote:
> On 6/30/23 14:25, Anton Johansson via wrote:
>> CPUNegativeOffsetState is a struct placed immediately before
>> CPUArchState in the ArchCPU struct.  Its purpose is to ensure that
>> certain fields (CPUTLBDescFast, IcountDecr) lay within a small negative
>> offset of CPUArchState in memory.  This is desired for better
>> code-generation on arm[32|64] and riscv hosts which has addressing
>> modes with 12- and 11 bits of displacement respectively.
>
> The purpose is also to ensure that general purpose registers stay 
> close to the beginning of the CPUArchState and thus can also be 
> accessed with a small displacement.
>
> Can you check if this becomes worse for any architecture?  On some 
> 64-bit targets, 8 bytes * 32 registers is 512 bytes and it's a 
> substantial part of the 11 bits that are available.
>
> Paolo
>
I'm dropping the CPUNegativeOffsetState changes, but the fields would 
still have had
a negative displacement from the beginning of env, so the positive 
offset of the gprs from env
wouldn't be affected.

-- 
Anton Johansson,
rev.ng Labs Srl.


