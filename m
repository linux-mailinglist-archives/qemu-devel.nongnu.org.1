Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F01C87562C7
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 14:32:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLNO6-0000zg-Rz; Mon, 17 Jul 2023 08:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qLNNr-0000s9-LZ
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:31:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qLNNp-00053d-17
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689597080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OuwLyyrTv8F/fMx9levYOJ65/NTJOqRuNLnjNMo5BuI=;
 b=YEEuXKgLQ2WMht/KH7BN7E5s6DP4RUuRIJHqjiFGUaAX9u8RzQwZa30c8pJBn+RtGN/7tK
 jvom5o2ZPS+aDJYqsWQwC5dtjLnAKUvLTNVlOsI8p8dRcvDnWq88KPwuPML6YJi0J1VJK6
 UH2ozyHFavoszSZvxfWbGPmcsHrQqdA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-F8VedKF1P7Gk-w6AHPd2nw-1; Mon, 17 Jul 2023 08:31:18 -0400
X-MC-Unique: F8VedKF1P7Gk-w6AHPd2nw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-635f12395b5so36382896d6.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 05:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689597078; x=1692189078;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OuwLyyrTv8F/fMx9levYOJ65/NTJOqRuNLnjNMo5BuI=;
 b=eTkdoJLq/X2SYnk0wr1f1R71AG3e6RzN5Bkfejfg/crzaOl90Egmwgq7ldomBRIPvi
 dDzEzxGlCmN3r3DNjEo3kGmk+fi2t+yQoer0VZ4A8yQxrs8hxpDLzmtUt28oWv3B7A3i
 Fpc4Z3s0Ht6vl2zh43A00lR9lvOIhoitrPEdJaK6Gihus6c7u2TiNbB4Sl9dkqrbxd6X
 JVJTiSSswp1U20Diz4M0bt+vdSBFDcGrDWyN4K3AEqnbawmkVOUzNcZoMoZxZEfO7CeE
 8EFV9Yv+JidwhetNTqH3GNhA/ttKfgMvf1JPGiDyJmiBIncUnDuLLS+H+A4rQkW5fDem
 0TgA==
X-Gm-Message-State: ABy/qLYq5F6pytFMQxRSt2wdUgJqlFfWZVQ8jMbgMyxL24Uytu7ImChU
 d+g1yNpBFFWsehrKEaw9msjJ+/3WSdOTnUaNSNL5VLIgEpKMSj7AIuBhsJSFyxoN2fQ6PvOnyGb
 cs7wJb7bKOMq240k=
X-Received: by 2002:a0c:b3ce:0:b0:630:22f7:37a7 with SMTP id
 b14-20020a0cb3ce000000b0063022f737a7mr9274443qvf.36.1689597078360; 
 Mon, 17 Jul 2023 05:31:18 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEdS/N+ny8O5C6dL9kp7zWHs80bVDLboyHm2z1oo3dsNEQxk/yGbCdGruY/WJY2zf2aBG1pyw==
X-Received: by 2002:a0c:b3ce:0:b0:630:22f7:37a7 with SMTP id
 b14-20020a0cb3ce000000b0063022f737a7mr9274432qvf.36.1689597078149; 
 Mon, 17 Jul 2023 05:31:18 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-137.web.vodafone.de.
 [109.43.177.137]) by smtp.gmail.com with ESMTPSA id
 t11-20020a0cb38b000000b00632266b569esm6447836qve.87.2023.07.17.05.31.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 05:31:17 -0700 (PDT)
Message-ID: <84a0c2fd-ea14-5bb4-9e1c-669b51085ab4@redhat.com>
Date: Mon, 17 Jul 2023 14:31:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH][PING] linux-user/elfload: Fix /proc/cpuinfo features: on
 s390x
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
References: <20230627151356.273259-1-iii@linux.ibm.com>
 <f359dae7-e0a3-42cf-c2cd-fff7f9c3a607@linaro.org>
 <a55d41f884e6ff50872d389fa1a7c3dcf61afcc1.camel@linux.ibm.com>
 <13598a41-d17d-4d8f-ef0c-4bd41677c775@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <13598a41-d17d-4d8f-ef0c-4bd41677c775@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.097, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 17/07/2023 09.44, Richard Henderson wrote:
> On 7/14/23 13:16, Ilya Leoshkevich wrote:
>> On Wed, 2023-06-28 at 09:49 +0200, Richard Henderson wrote:
>>> On 6/27/23 17:13, Ilya Leoshkevich wrote:
>>>> elf_hwcap_str() takes a bit number, but compares it for equality
>>>> with
>>>> the HWCAP_S390_* masks. This causes /proc/cpuinfo to display
>>>> incorrect
>>>> hwcaps.
>>>>
>>>> Fix by introducing the HWCAP_S390_NR_* constants and using them in
>>>> elf_hwcap_str() instead of the HWCAP_S390_*. While at it, add the
>>>> missing nnpa, pcimio and sie hwcaps from the latest kernel.
>>>>
>>>> Output before:
>>>>
>>>>          features        : esan3 zarch stfle msa
>>>>
>>>> Output after:
>>>>
>>>>          features        : esan3 zarch stfle msa ldisp eimm etf3eh
>>>> highgprs vx vxe
>>>>
>>>> Fixes: e19807bee357 ("linux-user/elfload: Introduce elf_hwcap_str()
>>>> on s390x")
>>>> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
>>>> ---
>>>>    include/elf.h        | 66 +++++++++++++++++++++++++++++++--------
>>>> -----
>>>>    linux-user/elfload.c | 41 ++++++++++++++-------------
>>>>    2 files changed, 69 insertions(+), 38 deletions(-)
>>>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>>
>>> r~
>>
>> Hi,
>>
>> I noticed that while the other s390x fixes were picked up and are in
>> master, this one wasn't. Is there anything I need to improve here?
>>
> 
> I just missed it while collecting patches.  Sorry about that.
> Queued to tcg-next.

If you like, I can also take this through my s390x branch ... I'm currently 
in progress of assembling a pull request, so if you've got nothing else 
pending right now, I can put it there.

  Thomas


