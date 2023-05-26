Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4161D7120A8
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 09:08:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2RWq-0002H8-VJ; Fri, 26 May 2023 03:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q2RWn-0002FJ-VS
 for qemu-devel@nongnu.org; Fri, 26 May 2023 03:06:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q2RWm-0008JX-Be
 for qemu-devel@nongnu.org; Fri, 26 May 2023 03:06:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685084779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jCMIq/aFOTun12kR0ND9J3Hd5XYLj3F9srw7zM8Qh2c=;
 b=DsMbokC0QWBlzoCPySiJSa1wI8xCuFxbBMLBypgz1qEYcBNFEXi+ILW+//nacNgkUG5s9r
 5E8FmHRFOnB59z0aVZ5lWIm/kg3EXgMtHnQaMjDhp2QaC2PnA5j0hkYLt7d7e7NsgNwjD4
 axdnaulu4ipF7rWhSUFfEjdhRgYUtW8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-HwXGrHU9PdS5E8Zbt6BTLg-1; Fri, 26 May 2023 03:06:17 -0400
X-MC-Unique: HwXGrHU9PdS5E8Zbt6BTLg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f4f2f5098bso2993095e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 00:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685084776; x=1687676776;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jCMIq/aFOTun12kR0ND9J3Hd5XYLj3F9srw7zM8Qh2c=;
 b=COL+hqNo4q92GOXAXp0lFayFzP02soTsX7wphGHiDYTTp5io+DhfSPwK+/M6T1tf/d
 Cy8ovXzcdZb9vw52bHzwehKrhoLfOOgM534ABv5kI+qIrLl5ZCxjUOUs4rzkz8IgIRlU
 R9gYW588aA9UfYK9dDP6QbCs8NbnLHq58qPN8efbVuiNdvSDkijqlfAycWxwERt092T3
 GIwE2j31GnQHMFU4upPC1ps1SZnXKTJYNdlEXAcLumeOW3cykR/fX4ANFxIwAfb3seyC
 OsKM66c18xpbWqHOnCP3tChBOR42zakpSRPF1N2dZXDNY1zmZNKVJULGQPTQVGRhA1s4
 TpcQ==
X-Gm-Message-State: AC+VfDzdBk3wAi9sNbQPpTxqjiaBSYkHnuy3xwH8ZCuBKNWbgg9p9rye
 IcFVSnpQDaS5yGpoTGO90XTEExTJdKSuLz4vkWLpD1z4mix9HLvaFi4H3GW1X1uUTS4qbg6rbB4
 wK6+Dolh/R3Zwdyc=
X-Received: by 2002:a05:600c:22c7:b0:3f4:ef34:fbc2 with SMTP id
 7-20020a05600c22c700b003f4ef34fbc2mr622407wmg.24.1685084776456; 
 Fri, 26 May 2023 00:06:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ZVLXa/LQJdpxXblOzU0gJPamXq3UvJ+eh1cudfv12gryvBzLI0ktmVrsZnDOkwtzIInQ4pQ==
X-Received: by 2002:a05:600c:22c7:b0:3f4:ef34:fbc2 with SMTP id
 7-20020a05600c22c700b003f4ef34fbc2mr622396wmg.24.1685084776179; 
 Fri, 26 May 2023 00:06:16 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-189.web.vodafone.de.
 [109.43.176.189]) by smtp.gmail.com with ESMTPSA id
 u9-20020a05600c00c900b003f182a10106sm4286156wmm.8.2023.05.26.00.06.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 00:06:15 -0700 (PDT)
Message-ID: <3199d28a-722e-9f17-80df-628caebd32d8@redhat.com>
Date: Fri, 26 May 2023 09:06:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] pnv_lpc: disable reentrancy detection for lpc-hc
Content-Language: en-US
To: Frederic Barrat <fbarrat@linux.ibm.com>, Alexander Bulekov
 <alxndr@bu.edu>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org,
 "open list:PowerNV Non-Virtu..." <qemu-ppc@nongnu.org>
References: <20230511085337.3688527-1-alxndr@bu.edu>
 <3102db7a-bbaa-f394-b739-23950fe81be0@kaod.org>
 <20230511091509.nypeyd5fhzxlvo47@mozz.bu.edu>
 <71f07442-f4be-4efe-db1a-49f59b7bdbcb@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <71f07442-f4be-4efe-db1a-49f59b7bdbcb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

On 15/05/2023 14.48, Frederic Barrat wrote:
> 
> 
> On 11/05/2023 11:15, Alexander Bulekov wrote:
>> On 230511 1104, Cédric Le Goater wrote:
>>> Hello Alexander
>>>
>>> On 5/11/23 10:53, Alexander Bulekov wrote:
>>>> As lpc-hc is designed for re-entrant calls from xscom, mark it
>>>> re-entrancy safe.
>>>>
>>>> Reported-by: Thomas Huth <thuth@redhat.com>
>>>> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
>>>> ---
>>>>    hw/ppc/pnv_lpc.c | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
>>>> index 01f44c19eb..67fd049a7f 100644
>>>> --- a/hw/ppc/pnv_lpc.c
>>>> +++ b/hw/ppc/pnv_lpc.c
>>>> @@ -738,6 +738,8 @@ static void pnv_lpc_realize(DeviceState *dev, Error 
>>>> **errp)
>>>>                                    &lpc->opb_master_regs);
>>>>        memory_region_init_io(&lpc->lpc_hc_regs, OBJECT(dev), 
>>>> &lpc_hc_ops, lpc,
>>>>                              "lpc-hc", LPC_HC_REGS_OPB_SIZE);
>>>> +    /* xscom writes to lpc-hc. As such mark lpc-hc re-entrancy safe */
>>>> +    lpc->lpc_hc_regs.disable_reentrancy_guard = true;
>>>>        memory_region_add_subregion(&lpc->opb_mr, LPC_HC_REGS_OPB_ADDR,
>>>>                                    &lpc->lpc_hc_regs);
>>>
>>> The warning changed :
>>>
>>>    qemu-system-ppc64: warning: Blocked re-entrant IO on MemoryRegion: 
>>> lpc-opb-master at addr: 0x8
>>>
>>> I will take a look unless you know exactly what to do.
>>>
>>
>> That does not show up for me with "./qemu-system-ppc64 -M powernv8"
>> Do I need to boot a kernel to see the message?
>>
>> I was worried that there might be other re-entrant IO in this device.
>> Maybe there should be a way to just mark the whole device re-entrancy
>> safe.
> 
> Hello,
> 
> I was also started hitting it, with machine powernv10. And indeed, disabling 
> the check on both lpc_hc_regs and opb_master_regs should be all we need (and 
> it's working fine for me).

Alexander, could you please respin your patch to fix the opb_master_regs, too?

  Thomas



