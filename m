Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E877F7065A7
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 12:52:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzEkb-0008R1-6P; Wed, 17 May 2023 06:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1pzEkV-0008P3-JT
 for qemu-devel@nongnu.org; Wed, 17 May 2023 06:51:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1pzEkS-0001pF-2D
 for qemu-devel@nongnu.org; Wed, 17 May 2023 06:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684320671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G3OFtXxRc6EUtn8a7dG3Aj1fCYNAGD26Jo8vWwMNw8A=;
 b=hX1ng9WvUFdawHAOKDaVgO/D6qPZOPpYAQOsC9CfDN4HsnJPkObgx/jXLenFDoxErC7iu0
 6QQ49jVx+01X79c5RrU3Yb1BGHxpME0osLT/MkqPzC+SXKnz0HuByjrbJFWyXh0PiZsIQ6
 6KW+dZM9OVl7SvFNH0w8SyPT6CytOSY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-J-Y3oPAmPxOC431PPIQvtQ-1; Wed, 17 May 2023 06:51:09 -0400
X-MC-Unique: J-Y3oPAmPxOC431PPIQvtQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30640be4fd0so243520f8f.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 03:51:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684320668; x=1686912668;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G3OFtXxRc6EUtn8a7dG3Aj1fCYNAGD26Jo8vWwMNw8A=;
 b=h5+rNjUQ/0ap803w9PI4oPfH4aum7zsLNIM7monQcw5J5vXfbYAwIvWPyeaUvn3hju
 7nCopGBtmnQyUeaxg9VyU+2WsqRJP3ks3TqRaTtrSP430hrGhBO3isyd4pB0BS1X/uQh
 0VIJnp4nrzzryfsXRyKWzK6b68sfRcZaDobdtNX0in05nBlT3atAKx8pa2g8vGUUuzjU
 l/+iqdFg8b68MuEuX6OhrVPoEOXsY6dIGC301WDBksLwaWECXDSqJb4ub+oRhEG4Xcbs
 hA2iPGiMvVphCV8XYYOuT7q7EXf5zi7K90189ENjRNIJS/zXr5BoMblowUgXNsmGftwU
 WOLw==
X-Gm-Message-State: AC+VfDyb569rVA/dSXGJUjncE5oaoNI7yL7i5GgFcxO0sOMPJkC3ZA5c
 I+iAddH0hfo2y2U2PZKDWylaDedGXKp16mHl9tLRcN19WA3YL+8kuIYOx4laVl0h5zDqTjPwwou
 8FAwaHMSwK00BkAY=
X-Received: by 2002:a5d:4389:0:b0:306:2b40:1258 with SMTP id
 i9-20020a5d4389000000b003062b401258mr308921wrq.21.1684320668273; 
 Wed, 17 May 2023 03:51:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4TG1oJL4E5sUDUFfVdgJKUcpJT6QFD6Oea9DFofStz7ajPkpB9PWLOhWaFLXSyb6ujlGN1tA==
X-Received: by 2002:a5d:4389:0:b0:306:2b40:1258 with SMTP id
 i9-20020a5d4389000000b003062b401258mr308900wrq.21.1684320667897; 
 Wed, 17 May 2023 03:51:07 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-218.web.vodafone.de.
 [109.43.177.218]) by smtp.gmail.com with ESMTPSA id
 g6-20020adfe406000000b003093946ea60sm2344564wrm.46.2023.05.17.03.51.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 May 2023 03:51:06 -0700 (PDT)
Message-ID: <496ffe3f-f56e-ab64-37b6-3379b9372669@redhat.com>
Date: Wed, 17 May 2023 12:51:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH-for-8.0 1/3] hw/ppc: Replace tswap32() by const_le32()
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Alistair Francis <alistair@alistair23.me>,
 David Gibson <david@gibson.dropbear.id.au>, Jason Wang
 <jasowang@redhat.com>, Greg Kurz <groug@kaod.org>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org
References: <20221213125218.39868-1-philmd@linaro.org>
 <20221213125218.39868-2-philmd@linaro.org>
 <8d47b826-2011-3203-c682-aa32a76b8dc2@linaro.org>
 <d73fe725-565e-7fcb-e7d3-846189459545@linaro.org>
 <a1f4b5a6-0a8a-5a04-8ab6-f3f08b9d36aa@linaro.org>
 <CAFEAcA_F3Z+UPW-wHs8xedYX3TiV8CRQAom0DhefKLFH_Ejgog@mail.gmail.com>
 <b46e4c40-257f-8a89-85b8-8c2806f395be@linaro.org>
 <10186d7a-2df0-2fcf-8eef-8e34bcc2d8cc@kaod.org>
 <CAFEAcA8WF6GXaPt6+=KbaLSP5w+r1dps6fcc21+Um3VFAPDp5A@mail.gmail.com>
 <b270f7de-a0f1-3b1e-5540-550420acef26@kaod.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <b270f7de-a0f1-3b1e-5540-550420acef26@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.412, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 13/12/2022 19.13, Cédric Le Goater wrote:
> On 12/13/22 18:23, Peter Maydell wrote:
>> On Tue, 13 Dec 2022 at 16:53, Cédric Le Goater <clg@kaod.org> wrote:
>>>
>>> On 12/13/22 17:27, Richard Henderson wrote:
>>>> On 12/13/22 10:21, Peter Maydell wrote:
>>>>> It does seem odd, though. We have a value in host endianness
>>>>> (the EPAPR_MAGIC constant, which is host-endian by virtue of
>>>>> being a C constant). But we're storing it to env->gpr[], which
>>>>> is to say the CPUPPCState general purpose register array. Isn't
>>>>> that array *also* kept in host endianness order?
>>>>
>>>> Yes indeed.
>>>>
>>>>> If so, then the right thing here is "don't swap at all",
>>>>
>>>> So it would seem...
>>>>
>>>>> i.e. just "env->gpr[6] = EPAPR_MAGIC;". But that would imply
>>>>> that the current code is setting the wrong value for the GPR
>>>>> on little-endian hosts, which seems a bit unlikely...
>>>>
>>>> ... unless this board has only been tested on matching hosts.
>>>
>>> But these are register default values. Endianness doesn't apply
>>> there. Doesn't it ?
>>
>> Any time you have a value that's more than 1 byte wide,
>> endianness applies in some sense :-) We choose for our
>> emulated CPUs typically to keep register values in struct
>> fields and variables in the C code in host endianness. This
>> is the "obvious" choice given that you want to be able to
>> do things like do a simple host add to emulate a guest CPU
>> add, but in theory you could store the values the other
>> way around if you wanted (then "store register into RAM"
>> would be trivial, and "add 1 to register" would require
>> extra effort; currently it's the other way round.)
>>
>> Anyway, I think that in the virtex_ml507 and sam460ex code
>> the use of tswap32() should be removed. In hw/ppc/e500.c
>> we get this right:
>>      env->gpr[6] = EPAPR_MAGIC;
>>
>> We have a Linux kernel boot test in the avocado tests for
>> virtex_ml507 -- we really do set up this magic value wrongly
>> afaict, but it seems like the kernel doesn't check it (the
>> test passes regardless of whether we swap the value or not).
>>
>> I think what has happened here is that this bit of code is
>> setting up CPU registers for an EPAPR style boot, but the
>> test kernel at least doesn't expect that. It boots via the
>> code in arch/powerpc/kernel/head_44x.S. That file claims
>> in a comment that it expects
>>   *   r3 - Board info structure pointer (DRAM, frequency, MAC address, etc.)
>>   *   r4 - Starting address of the init RAM disk
>>   *   r5 - Ending address of the init RAM disk
>>   *   r6 - Start of kernel command line string (e.g. "mem=128")
>>   *   r7 - End of kernel command line string
>>
>> but actually it only cares that r3 == device-tree-blob.
>>
>> Documentation/powerpc/booting.rst says the expectation
>> (for a non-OpenFirmware boot) is:
>>                  r3 : physical pointer to the device-tree block
>>                  (defined in chapter II) in RAM
>>
>>                  r4 : physical pointer to the kernel itself. This is
>>                  used by the assembly code to properly disable the MMU
>>                  in case you are entering the kernel with MMU enabled
>>                  and a non-1:1 mapping.
>>
>>                  r5 : NULL (as to differentiate with method a)
>>
>> which isn't the same as what the kernel code actually cares about
>> or what the kernel's comment says it cares about...
>>
>> So my guess about what's happening here is that the intention
>> was that these boards should be able to boot both kernels built
>> to be entered directly in the way booting.rst says, and also
>> kernels and other guest programs built to assume boot by
>> EPAPR firmware, but this bug means that we're only currently
>> supporting the first of these two categories. The reason nobody's
>> noticed before is presumably that in practice nobody's trying to
>> boot the "built to boot from EPAPR firmware" type binary on
>> these two boards.
>>
>> TLDR: we should drop the "tswap32()" entirely from both files.
> Yes. I think so too.

I agree. Philippe, could you please respin this patch 1 here accordingly?

  Thomas


