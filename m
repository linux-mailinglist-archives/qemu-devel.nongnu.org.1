Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AED788295
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 10:45:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZSQC-0002eH-7K; Fri, 25 Aug 2023 04:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qZSQ8-0002dt-Ho
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 04:43:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qZSQ6-0002K7-Fh
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 04:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692953033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FMdSIogukHVsbz1GOKtUPqyfRKh37yhWoahabbWmBgQ=;
 b=MBM+JKofVuWMsgzKcuvYzar7zRRQ04E2wZ/swIBtiiRYhO6YV8xLhIhp10NB4yh34RI1R0
 UUX8B9Mb66dM/5kX5vD4Xm2Dix3mqEawXw4MgLmUf7GK/dK82y++vZOJju8NN5Yixv1A0Y
 94hY//+ZA2LlTBUL2ooPsaSajB0gd4k=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-763k5Y6_MWaft0DODeRM_w-1; Fri, 25 Aug 2023 04:43:51 -0400
X-MC-Unique: 763k5Y6_MWaft0DODeRM_w-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2bce272ebdfso7495861fa.1
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 01:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692953030; x=1693557830;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FMdSIogukHVsbz1GOKtUPqyfRKh37yhWoahabbWmBgQ=;
 b=faH/uThLxL5NWy/0dLsoisbm90g5RgbH8XJEwqxCpfvf/1C1srx2QvQjn+SI64FBjf
 nigzdxB5aAcqHYbQupiwkVStL7Tp622E1sa5V33EwMMDncSrKiyqvgaQ6As/ntb8aaRR
 LAySGPkrssJGTKBSgmu3GXwHXgC9G/18s8orYH75TNFKcbAI+c6BmSQH1tkAcSamq40W
 B0aisdf+y/hboa/v2oqFUTE73FSs0UkXQd4ZBz0MN/oJYzvrxQfRIXJI5VERUfZ3E8Jp
 EXVzuI1Ar9p0GZvOAHqp94lY4DIUCE93ofP7BYyiOuPlqYTTMdcCbHrVAZLEDyO2AoxO
 VkxA==
X-Gm-Message-State: AOJu0Yypk/MdLiz26qzro5J0suCZMbaKRIgPYsk9CXOaxGB7J8uvp9hx
 2rycZHaNBOq71AHcWnVwWOGWtgB5FAoH4fXy1zOZSWuu/s007N9xhiYhepLDpSaDjzC+B0GDYXH
 fDZC0oBuaFerZV7U=
X-Received: by 2002:a2e:b053:0:b0:2b9:6810:b333 with SMTP id
 d19-20020a2eb053000000b002b96810b333mr13150673ljl.14.1692953030158; 
 Fri, 25 Aug 2023 01:43:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEb6Ig1RFNps3B3514IHZsyoC2jnaBem3VeT8h4fuONKIZq4zto+p6Zz3EjnDM25hFliXmE1A==
X-Received: by 2002:a2e:b053:0:b0:2b9:6810:b333 with SMTP id
 d19-20020a2eb053000000b002b96810b333mr13150658ljl.14.1692953029812; 
 Fri, 25 Aug 2023 01:43:49 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-97.web.vodafone.de.
 [109.43.176.97]) by smtp.gmail.com with ESMTPSA id
 c12-20020a05600c0acc00b003fee6f027c7sm4735136wmr.19.2023.08.25.01.43.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 01:43:49 -0700 (PDT)
Message-ID: <0f2cd2e2-2524-cc4a-5c3c-42eb083dd7b9@redhat.com>
Date: Fri, 25 Aug 2023 10:43:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 01/12] gitlab: enable ccache for many build jobs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Beraldo Leal <bleal@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-s390x@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-arm@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 David Hildenbrand <david@redhat.com>, Greg Kurz <groug@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20230824163910.1737079-1-alex.bennee@linaro.org>
 <20230824163910.1737079-2-alex.bennee@linaro.org>
 <20abecb3-b330-0303-0f4a-b0b5d0cfade1@tls.msk.ru>
 <97490761-c138-d496-c59a-f71b86e57c3d@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <97490761-c138-d496-c59a-f71b86e57c3d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.919, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 25/08/2023 10.34, Philippe Mathieu-Daudé wrote:
...
> __FILE__ is used by assert() family, some DEBUG_PRINTF(), but mainly
> by "qapi/error.h", so all error_setg*() calls.
> 
> This has been bugging me since quite some time, since if you build
> the same QEMU in different paths (usually on different machines) then
> the output doesn't match.
> 
> GCC 8 & Clang 10 provides -ffile-prefix-map, but
> 
> 1/ Our minimal GCC supported is v7.4,

IIRC we use 7.4 since this was the default GCC on NetBSD 9 ... I guess we 
could bump it once NetBSD 10 gets released.

  Thomas



