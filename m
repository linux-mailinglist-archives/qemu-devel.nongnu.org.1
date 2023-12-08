Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61212809EAC
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 09:59:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBWgd-0006O8-T6; Fri, 08 Dec 2023 03:58:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1rBWgY-0006MQ-1N
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 03:58:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1rBWgW-0007sa-B4
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 03:58:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702025889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=daPE9ufOoCbMA2Elth6gqht5LTgge+9KXcX19van4tY=;
 b=RszR/98JfPg4BTPhtOq2pLKcjI5v+3Ly3WCm2Om22ZOeyyDuSY2lafBJoUXqJRy+8YHT0k
 XCYRdnEr/5UfsHjtopRRQOK/39Sdx8NHv5DCQpOTIAoCy7x3KiMCA3y2cwfF1EO3EIE40p
 O106R1frWmoOWN8Xym6RPvhkIFIigcc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-Tkt8PamRNDqSVdpvW0p-ZA-1; Fri, 08 Dec 2023 03:58:07 -0500
X-MC-Unique: Tkt8PamRNDqSVdpvW0p-ZA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33349915da3so1457852f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 00:58:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702025886; x=1702630686;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=daPE9ufOoCbMA2Elth6gqht5LTgge+9KXcX19van4tY=;
 b=GR1IlTSP/aSoGdLXqviQmlupzuXK+UpRG06bl1U6RycRIY9SlWCpzHbw2wI3Y5FmEE
 8032KRoslr6OxRJAWiPGpu0Pn6b/ILFzhWL3RYUSCb5OEuYbh3/g/VH0fBBvl68RpSJr
 R5LpjvA3mS3ozZ471amzuN46RknaQS+GSUkGD4dS/KvRvbkaTRQgKyWaCwyORswQLOWG
 G5ZZfuIl2+Mf+yC3NnDrm2qESPYRSX90LstwkDrvmKIhD1f1MS/oZNQ7FLM/iGe165H1
 gfWVZN7yd6SZTWhvG2ZIiia/aIKavkgSkFHAPi5XuTLsxoD1ypavTM2kxSztY1yYu3vu
 7YMg==
X-Gm-Message-State: AOJu0YyoLLhlKvfjTH30LXjbAwjQCRNKlhIb8wJORZADoT5dwYrx9Y9p
 x/U+lrE0p/RGQSCbUCwCir2zc4PryPh2INf7t8I2JCgKvD4/hLg+r4YQIVi03Cy5b5HFjHGzedZ
 34aAfNtILbkXSLZc=
X-Received: by 2002:a05:600c:2147:b0:40b:5e1e:fb9c with SMTP id
 v7-20020a05600c214700b0040b5e1efb9cmr1653543wml.81.1702025886398; 
 Fri, 08 Dec 2023 00:58:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmyk0AaGLsH8iHm6A2T+d4DayhgyoIonmdrDpNPxTJ6t4muHXNPOF5y7QG2eRWGrTqFojVKg==
X-Received: by 2002:a05:600c:2147:b0:40b:5e1e:fb9c with SMTP id
 v7-20020a05600c214700b0040b5e1efb9cmr1653541wml.81.1702025886067; 
 Fri, 08 Dec 2023 00:58:06 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 n18-20020a05600c501200b0040b37f1079dsm4534205wmr.29.2023.12.08.00.58.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Dec 2023 00:58:05 -0800 (PST)
Message-ID: <5a58cc19-d73f-4961-8998-a88dea4ece01@redhat.com>
Date: Fri, 8 Dec 2023 09:58:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Request for New PPC Machine Supporting Multiple SMP Cores
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, aziz tlili <aziztlili2222@gmail.com>
Cc: qemu-devel@nongnu.org
References: <CAHwHw5A6g428uTpMEQ=NCkXP7sXVfCWv5QSUw3pHfncmG-2gPA@mail.gmail.com>
 <5f2068a4-955a-9d16-347d-4d2771b78aa8@eik.bme.hu>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <5f2068a4-955a-9d16-347d-4d2771b78aa8@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 12/7/23 18:39, BALATON Zoltan wrote:
> On Thu, 7 Dec 2023, aziz tlili wrote:
>> Dear QEMU Team,
>>
>> I hope this message finds you well. I've been a user of QEMU for well over
>> a year.
>>
>> I wanted to share an idea for a potential enhancement that I believe could
>> benefit many users, including myself. It would be fantastic to have a new
>> PPC machine model similar to the existing mac99, but with support for
>> multiple SMP cores for both qemu-system-ppc and qemu-system-ppc64.
> 
> There are several machines in qemu-system-ppc64 that support SMP such as pseries and powernv I think. For qemu-system-ppc maybe only ppce500. The mac99 may create multiple CPUs (G4 when ron with qemu-system-ppc or G5 with qemu-system-ppc64) but not sure if there's an OS that can actually use that. Linux support for mac99 may not be the best.

64bit :

pseries machines support SMP and SMT
powernv machines support SMP, SMT and multisocket.
ppce500 machines (e6500 and e5500 CPUs) support SMP

32bit :

ppce500 machines (e500mc) have SMP support but there is an issue when
bringing up the secondaries.
It has never been done for the other machines AFAIK

Thanks,

C.

>> The ability to simulate multiple SMP cores within a PPC machine environment
>> would significantly enhance the capabilities of QEMU for various
>> applications, testing scenarios, and development purposes. This addition
>> could greatly benefit the community working on PowerPC architecture.
> 
> Sure. Contributions are welcome.
> 
>> I understand the complexities involved in such developments but wanted to
>> express the potential advantages and how this enhancement could contribute
>> to expanding QEMU's capabilities.
> 
> Problem is not in understanding the potential advantages but the lack of people interested in working on that so progress depends on somebody doing it and sending patches.
> 
> Regards,
> BALATON Zoltan
> 
>> Thank you for considering my suggestion. I would be more than happy to
>> provide further details or collaborate in any way that could assist in
>> making this idea a reality.
>>
>> Best regards,
>> Aziz Tlili
>>
> 


