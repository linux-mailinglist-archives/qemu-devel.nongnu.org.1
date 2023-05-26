Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 211F0712145
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 09:38:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2S1D-0006Yp-Fn; Fri, 26 May 2023 03:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q2S1B-0006YQ-4N
 for qemu-devel@nongnu.org; Fri, 26 May 2023 03:37:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q2S19-0005dh-M9
 for qemu-devel@nongnu.org; Fri, 26 May 2023 03:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685086662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YTsLrGZ3oT10xqNRrHX0xKkyyV2rzcO8zg9PuD/qOWI=;
 b=Ge+z9IhDjuUtsww0x2gZK1zfFmBOXig1ZQ3QRpY0UG8XQ98WZW6Tq0a4udl3TF7kXnzDUk
 8TQQDZKvRqXWftMcASNanvXW4bQZGeE6XeoKcR00CSHfeyrTy6khWfZ0ljfMNPFp2LD7Tg
 lep9SLiXC9/jHhfaoG+c5VlwF/dyikk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-Q5s-k29hNlmfU5sSRbVq1A-1; Fri, 26 May 2023 03:37:41 -0400
X-MC-Unique: Q5s-k29hNlmfU5sSRbVq1A-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30793c16c78so273699f8f.3
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 00:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685086660; x=1687678660;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YTsLrGZ3oT10xqNRrHX0xKkyyV2rzcO8zg9PuD/qOWI=;
 b=Q//A8bncyAcwmdh4PaIYyiXCEaEYLjDRcrsC1Rrd5JhRYMLTebtNqA1mZByy9OKU0J
 aDIsmm9WL1/yqXdwrJfzS6i6/dn98cLJtPcQRk2OGNfDyP1bp+rvCuU6DJEpbKE8bv5n
 NaeyyajtdGEfd7BPyoJnkW/hS3Jg408/++a1cwtyE7z48lhDYeBDNfBKAmh9iv3cqZeQ
 Cm0+dzrApFsfJar9yrkQwUNex3o+RSPxPuj6YrjtG7XH4cPvZWcfNPhzm30XWpPfP4Q8
 BHMXY/CwF40pr8Nrbfgx7eEIGiOlNJ69ZiSEibgQ3uGplMoBcaCiXYPFbAnTWEqRodFc
 QSBA==
X-Gm-Message-State: AC+VfDzrTkEkXVXR50JA1i5koRUYt3o4Zo9oSL1ASUIQ/vRJ35kFJEo+
 aw40UC+OcQiiWBKwPTgch4tDqBoE+Y2F4paaFYHpB1rhgXGqAhZeIiY6nW2HsqzQBjbSON75O1r
 ajFMq5/fAaDCdaM4=
X-Received: by 2002:adf:ec44:0:b0:30a:af0c:3105 with SMTP id
 w4-20020adfec44000000b0030aaf0c3105mr780302wrn.53.1685086659986; 
 Fri, 26 May 2023 00:37:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5FFKd45RKUDiQ6pHuRFxW95cLaMupj0TqmPJdI57XiLAcXvR8tWsfM7pMV9pXLZLTR0Svnag==
X-Received: by 2002:adf:ec44:0:b0:30a:af0c:3105 with SMTP id
 w4-20020adfec44000000b0030aaf0c3105mr780288wrn.53.1685086659650; 
 Fri, 26 May 2023 00:37:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 o2-20020a5d4082000000b002feea065cc9sm4142419wrp.111.2023.05.26.00.37.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 00:37:39 -0700 (PDT)
Message-ID: <b7a83811-d5d9-6f10-ee0e-17972ed4ee7d@redhat.com>
Date: Fri, 26 May 2023 09:37:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] pnv_lpc: disable reentrancy detection for lpc-hc
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Frederic Barrat <fbarrat@linux.ibm.com>,
 Alexander Bulekov <alxndr@bu.edu>
Cc: qemu-devel@nongnu.org,
 "open list:PowerNV Non-Virtu..." <qemu-ppc@nongnu.org>
References: <20230511085337.3688527-1-alxndr@bu.edu>
 <3102db7a-bbaa-f394-b739-23950fe81be0@kaod.org>
 <20230511091509.nypeyd5fhzxlvo47@mozz.bu.edu>
 <71f07442-f4be-4efe-db1a-49f59b7bdbcb@linux.ibm.com>
 <3199d28a-722e-9f17-80df-628caebd32d8@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <3199d28a-722e-9f17-80df-628caebd32d8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/26/23 09:06, Thomas Huth wrote:
> On 15/05/2023 14.48, Frederic Barrat wrote:
>>
>>
>> On 11/05/2023 11:15, Alexander Bulekov wrote:
>>> On 230511 1104, Cédric Le Goater wrote:
>>>> Hello Alexander
>>>>
>>>> On 5/11/23 10:53, Alexander Bulekov wrote:
>>>>> As lpc-hc is designed for re-entrant calls from xscom, mark it
>>>>> re-entrancy safe.
>>>>>
>>>>> Reported-by: Thomas Huth <thuth@redhat.com>
>>>>> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
>>>>> ---
>>>>>    hw/ppc/pnv_lpc.c | 2 ++
>>>>>    1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
>>>>> index 01f44c19eb..67fd049a7f 100644
>>>>> --- a/hw/ppc/pnv_lpc.c
>>>>> +++ b/hw/ppc/pnv_lpc.c
>>>>> @@ -738,6 +738,8 @@ static void pnv_lpc_realize(DeviceState *dev, Error **errp)
>>>>>                                    &lpc->opb_master_regs);
>>>>>        memory_region_init_io(&lpc->lpc_hc_regs, OBJECT(dev), &lpc_hc_ops, lpc,
>>>>>                              "lpc-hc", LPC_HC_REGS_OPB_SIZE);
>>>>> +    /* xscom writes to lpc-hc. As such mark lpc-hc re-entrancy safe */
>>>>> +    lpc->lpc_hc_regs.disable_reentrancy_guard = true;
>>>>>        memory_region_add_subregion(&lpc->opb_mr, LPC_HC_REGS_OPB_ADDR,
>>>>>                                    &lpc->lpc_hc_regs);
>>>>
>>>> The warning changed :
>>>>
>>>>    qemu-system-ppc64: warning: Blocked re-entrant IO on MemoryRegion: lpc-opb-master at addr: 0x8
>>>>
>>>> I will take a look unless you know exactly what to do.
>>>>
>>>
>>> That does not show up for me with "./qemu-system-ppc64 -M powernv8"
>>> Do I need to boot a kernel to see the message?
>>>
>>> I was worried that there might be other re-entrant IO in this device.
>>> Maybe there should be a way to just mark the whole device re-entrancy
>>> safe.
>>
>> Hello,
>>
>> I was also started hitting it, with machine powernv10. And indeed, disabling the check on both lpc_hc_regs and opb_master_regs should be all we need (and it's working fine for me).
> 
> Alexander, could you please respin your patch to fix the opb_master_regs, too?

I will do it.

C.


