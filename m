Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BDF7BB432
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:28:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoh88-0001uf-Gc; Fri, 06 Oct 2023 05:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qoh7j-0001qP-T1
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:27:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qoh7g-0005st-3l
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696584470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zm3pjsUiL5o2yCcoajywFGAcXg/cZ340p7WUqaV9YYk=;
 b=ElJnz9mcCao9gePZPPB/odEcS5LU7Md9+b75VuTK3Q9Z9xwDrbqEQaie8mZRYlih0hi+4B
 qmsc9VkW9RtMaFV2i6w/UoKH2JThSBTIk7yL47KEZp6k9rlSKEOgLPxCZU92N+0LBz0m4u
 9r15zzmkVgVeZKeZUvt+Z1Nv9MXYUwc=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-n2jlG0rrOA2oKme8D0y51g-1; Fri, 06 Oct 2023 05:27:49 -0400
X-MC-Unique: n2jlG0rrOA2oKme8D0y51g-1
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-452933013e8so808657137.2
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 02:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696584468; x=1697189268;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zm3pjsUiL5o2yCcoajywFGAcXg/cZ340p7WUqaV9YYk=;
 b=NNvTFRyeo0qYK996hIeD83malz3el5NO1CUmxaYj3I0/ZfRjw9hZbKGQ3nqO5Z3+bO
 ESmyA5t1VEIl4XQuNjO236k7Mo695oeTVA2XR82neoI83m2oyJ3xV2u5w312+s3YR3TA
 7vXCaTVvn8p+pjGXT8pUqWOu8vzv2Mx7alRyrvWf9Y4Tyy8QAkugKaKKW1H0x+quxSf9
 QJS+at4Za9pAeFmWufcXNhdN0b+FOldB9m6eql+OU3NUDJZyHsZG/G95TuXCc2ToS0G7
 O4YoJD5zCXkV+fCOBzoNZuUlp7lmBte/dIgXWDweOJ4gYCqyS+emUwfv83lD+ELi88E7
 8ATw==
X-Gm-Message-State: AOJu0YxgFQ8QODNwsKgGQPum9StcbEIwZ55SVsRUDsSnPcdlv8B1XSke
 5SCCa1c96GfAwWPDP1dMcDSqw4j2G2GeR58me9VKBgENkPya6qitMC8CxWx/AKV8ODV4/MEfiS6
 JY/oEoJdhv4/8uqc=
X-Received: by 2002:a67:f5c8:0:b0:44e:93f4:3c85 with SMTP id
 t8-20020a67f5c8000000b0044e93f43c85mr6436367vso.12.1696584468466; 
 Fri, 06 Oct 2023 02:27:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwDR4Q5h6cn+QAitsJybiX9/fYKyB2emm6YZls+vZVPmugHtHnWzm/VpurJMSMsDi9lb/xdA==
X-Received: by 2002:a67:f5c8:0:b0:44e:93f4:3c85 with SMTP id
 t8-20020a67f5c8000000b0044e93f43c85mr6436357vso.12.1696584468194; 
 Fri, 06 Oct 2023 02:27:48 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 l26-20020a0c979a000000b0065cffe12ae9sm1235815qvd.36.2023.10.06.02.27.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 02:27:47 -0700 (PDT)
Message-ID: <f5c704df-31bf-c905-7f03-46f7d120513d@redhat.com>
Date: Fri, 6 Oct 2023 11:27:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 01/16] hw/audio/soundhw: Clean up global variable
 shadowing
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20231004120019.93101-1-philmd@linaro.org>
 <20231004120019.93101-2-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20231004120019.93101-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.219, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 04/10/2023 14.00, Philippe Mathieu-Daudé wrote:
> Fix:
> 
>    hw/audio/soundhw.c:86:33: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>    void select_soundhw(const char *optarg, const char *audiodev)
>                                    ^
>    /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/getopt.h:77:14: note: previous declaration is here
>    extern char *optarg;                    /* getopt(3) external variables */
>                 ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/audio/soundhw.h | 2 +-
>   hw/audio/soundhw.c         | 6 +++---
>   2 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


