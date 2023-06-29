Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF477422E3
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 11:07:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEnbI-0001bT-7x; Thu, 29 Jun 2023 05:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qEnb4-0001Vf-US
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 05:05:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qEnay-0008Et-Rc
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 05:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688029541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QfYRFZX/nnT1XmJ2Jdx/+YP3fWT5R+N6mcqbs50tLiE=;
 b=Py3NmTa0LkUHCUI0hfDp2uenPltQTgnsG3h+4HYxP/he8cmiptNOnKWrL4TjpZ6hGCaMF3
 Dnto3FYHit2dDKtAYhdcVDAx2HmJl2N+2d8/iX0dfRrpYgP+G3K/TNDjdYXDEKUDZoZe9b
 Crc8wpxQIjFf057PC44zlRAVSyPlF04=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-1PdkGtGvNPK_ovn-UTRCmw-1; Thu, 29 Jun 2023 05:05:38 -0400
X-MC-Unique: 1PdkGtGvNPK_ovn-UTRCmw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3141325af78so281944f8f.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 02:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688029537; x=1690621537;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QfYRFZX/nnT1XmJ2Jdx/+YP3fWT5R+N6mcqbs50tLiE=;
 b=f/PMSi6kmIU0arve4Q1kIMuu1qThQUgg9Ma6G+AWchlqj/t2M8B9Vh1QI1G0MShuz0
 n1o/Grb2uEAb44iA1RcoElw6W+K6XTeygVBduCjOVYZcXoPWsG4kNZUBQi2F2+s9NeHp
 Ui8Desl9SEzb8eL3lXEmc53lwr94efg2OT7npHW2jF/2ojznKWgEVqCCEct0nH4ML6k5
 2/Vxp0QJ85r2sQ2aqEwm32MpXmb6S4Gdxq0I2GRht5d/M817ETNEuWsZus7yAY9oyT3D
 XuMzn+3iiIc5gQ82fGEMGyySlAryIijyt9bECF39fy1oM8Jv3+uVt+GH4RA1EvlthaD4
 4/SA==
X-Gm-Message-State: AC+VfDwObe5xQchfwI/gtOIrUEdFNFzRxaun6yeLizwXMa5xIM4nKHWe
 Pfd4/lqF0Q1dJyuDkzdYVNMpUedUMZWcrC2BzuKNWbfvvbQiT5vQS21JrGcWSe7mSRprjX3a0OM
 cfcn/whqIsr+L8SU=
X-Received: by 2002:adf:ed88:0:b0:313:ebb0:ca5d with SMTP id
 c8-20020adfed88000000b00313ebb0ca5dmr12478609wro.44.1688029537269; 
 Thu, 29 Jun 2023 02:05:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6T1hJ8MqYcZdmF/Tx70pSEMQCdXPM53orlomrk8hIFzyo9HkOZnstC1GdHWQq4T1o/EEo0AA==
X-Received: by 2002:adf:ed88:0:b0:313:ebb0:ca5d with SMTP id
 c8-20020adfed88000000b00313ebb0ca5dmr12478585wro.44.1688029536958; 
 Thu, 29 Jun 2023 02:05:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a5d5705000000b00313f9a0c521sm7795532wrv.107.2023.06.29.02.05.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 02:05:36 -0700 (PDT)
Message-ID: <1f6e63f1-d17d-c81c-cecb-3d9129c24360@redhat.com>
Date: Thu, 29 Jun 2023 11:05:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/4] target/ppc: Catch invalid real address accesses
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Christophe Leroy <christophe.leroy@csgroup.eu>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230623081953.290875-1-npiggin@gmail.com>
 <CAFEAcA_Brf-R12t+DKNAoygqgC-qjKJ3Wiz4ULjGHOo8_vPovw@mail.gmail.com>
 <47197a73-b106-47d5-9502-393a6bdc9945@redhat.com>
 <966b3fce-512d-f122-e76e-efded0db9731@kaod.org>
 <cefdeb3f-3442-ede4-3e5d-6a4a99b38293@ilande.co.uk>
 <CABLmASF92ux10=D5MJ4Ax3FbCi4digWJajHy4VE1fNUL9bOJxA@mail.gmail.com>
 <8e3010d8-9ca7-c834-3348-e11060c53f8a@ilande.co.uk>
 <CABLmASFsWK9Bg_bo=kC9C_8EnLpoVJKtqg0ca8gv1YdrffQSAw@mail.gmail.com>
 <d9b7499f-f462-79b3-e9e8-25a14a3b538d@redhat.com>
 <840c34e7-0f5c-89fa-2dfa-f8de3da4d643@ilande.co.uk>
 <7e596b48-c631-34d5-2b63-0aac1922de93@kaod.org>
 <2bc2ca94-c1ba-a9de-0b81-6f9d3d4ad333@redhat.com>
 <bfbfafe6-1a28-8514-a3bb-cf289c7b7200@ilande.co.uk>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <bfbfafe6-1a28-8514-a3bb-cf289c7b7200@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/29/23 10:29, Mark Cave-Ayland wrote:
> On 28/06/2023 08:17, Cédric Le Goater wrote:
> 
>>>>>> qemu-system-ppc.exe -M mac99,via=pmu -cdrom C:\mac-iso\9.2.2.iso -boot d -L pc-bios
>>>>>> crashes Mac OS with an address error. (with unpatched and patched builds).
>>>>>
>>>>> Same on Linux. I get an invalid opcode. QEMU 7.2 work fine though.
>>>>>
>>>>> C.
>>>>
>>>> That certainly shouldn't happen, and if it worked in 7.2 then there's definitely a regression which has crept in there somewhere. I'll try and bisect this at some point soon, but feel free to try and beat me ;)
>>>
>>> bisect points to :
>>>
>>> commit e506ad6a05c806bbef460a7d014a184ff8d707a6
>>> Author: Richard Henderson <richard.henderson@linaro.org>
>>> Date:   Mon Mar 6 04:30:11 2023 +0300
>>>
>>>      accel/tcg: Pass last not end to tb_invalidate_phys_range
>>>      Pass the address of the last byte to be changed, rather than
>>>      the first address past the last byte.  This avoids overflow
>>>      when the last page of the address space is involved.
>>>      Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>      Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>>
>>>   include/exec/exec-all.h   |  2 +-
>>>   accel/tcg/tb-maint.c      | 31 ++++++++++++++++---------------
>>>   accel/tcg/translate-all.c |  2 +-
>>>   accel/tcg/user-exec.c     |  2 +-
>>>   softmmu/physmem.c         |  2 +-
>>>   5 files changed, 20 insertions(+), 19 deletions(-)
>>>
>>>
>>> I think the instruction is fnmadds. Needs more digging.
>>
>> the invalid opcode is just a symptom of something bad happening.
>>
>> C.
> 
> Indeed, it appears to be a copy/paste error within that commit. I've just posted a proposed fix for this: https://lore.kernel.org/qemu-devel/20230629082522.606219-1-mark.cave-ayland@ilande.co.uk/T/.

Looks good. I could boot macos 9.2.1 from an iso and 9.2.2 from disk.

> Nick: you may wish to try your series again with this fix applied to see if there are still problems with the CPUs used in the Mac machines.

Looks good too, with these :

  [PATCH v2 1/4] target/ppc: Machine check on invalid real address
  [PATCH v2 2/4] target/ppc: Move common check in machine check
  [PATCH v2 3/4] target/ppc: Make checkstop actually stop the system


Patch 4 (attn) doesn't compile but it's an extra behavior on top of
checkstop.

Thanks,

C.


