Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7015479199B
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 16:23:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdAU3-0004wK-8t; Mon, 04 Sep 2023 10:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qdATn-0004tf-Ab
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:23:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qdATl-00054u-7E
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693837379;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lM7tAmp7WirRKEbi/4X/FhmWHX4s5l0P4f3vWHYNmlk=;
 b=iaerRvy3L0l4Xg9ugVNybUHw5t59SC6TUucf7mLNYjFS0Sg7Fc5Ap/ooMYDUwW9j+eo8+J
 zgJ/ckes+MkIOaj1ue15C26J4nv4xAXhqXjD/uk9FUAMH2HscwjGllukuAO/XbO0Da9bE0
 HavUOv3PkcPO27YviTubus00BLUgYHg=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-roC8K1scNDai0fU1mL35Ng-1; Mon, 04 Sep 2023 10:22:58 -0400
X-MC-Unique: roC8K1scNDai0fU1mL35Ng-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3a7292a2a72so1736772b6e.1
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 07:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693837378; x=1694442178;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lM7tAmp7WirRKEbi/4X/FhmWHX4s5l0P4f3vWHYNmlk=;
 b=dKyUUBvYTxR9fJOe6ieJ5Ef8ToYO9fO+CR9QcZYT2nHE49gsNueADRjaUTg/Iy3Uw2
 DPpq4SMrhfzC9mcjm+JVBg3ib/vWrBErUT4Ak9qWeprvIFX/a1ANs9qW1llKlobfR6b/
 e9VpjG0xta6M5dTz2BuB87JKAbopPtd3/6U4yR3Jx20qjb8sIDtbLUTIRaJwDm2IPffg
 YJTZXO53SOVis4zW/WvqcWpJ/tdKAYgJkrHSSFqWexY8ApzUGgNCOgb8Hx8C1dXEsAbt
 PbCpfLT6FzQ3pXHTdsyrFdgSNCcOxFBInAi27qgnaB0wvlCZGaralb+O2Ng4a3YnfmX7
 Q23A==
X-Gm-Message-State: AOJu0Yyv3mkPxXqXYnaxWZVzLzt+SSqIiefBygfs+V7u6zUQzaO1wyUt
 xM+nRXmY71gnvHV4AKtmv0iNUYWbzBJy8LGC+suZsEjTJYVKQKubD9Mq2OGhtorC4qK3IU26YmB
 8yCZyvalUcbXz4mE=
X-Received: by 2002:a05:6808:1441:b0:3a4:91a:224a with SMTP id
 x1-20020a056808144100b003a4091a224amr14037499oiv.34.1693837378051; 
 Mon, 04 Sep 2023 07:22:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCojgFHAAzhIIy8arCvrf+hEuawDKZq/AOlCkPGATQJbXr3kjvaUHGucA0M/mdjNAKqbsBNQ==
X-Received: by 2002:a05:6808:1441:b0:3a4:91a:224a with SMTP id
 x1-20020a056808144100b003a4091a224amr14037483oiv.34.1693837377835; 
 Mon, 04 Sep 2023 07:22:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 h3-20020a05620a13e300b0076d9f2d4fabsm3375025qkl.15.2023.09.04.07.22.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 07:22:57 -0700 (PDT)
Message-ID: <508d32cb-9d3c-848b-4ed2-0ca0d8a203a8@redhat.com>
Date: Mon, 4 Sep 2023 16:22:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 01/13] memory: Let ReservedRegion use Range
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 alex.williamson@redhat.com, clg@redhat.com, jean-philippe@linaro.org,
 mst@redhat.com, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, peterx@redhat.com, david@redhat.com
References: <20230904080451.424731-1-eric.auger@redhat.com>
 <20230904080451.424731-2-eric.auger@redhat.com>
 <231e23c0-e5a5-be2b-ccb6-77e24c2c1f55@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <231e23c0-e5a5-be2b-ccb6-77e24c2c1f55@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



On 9/4/23 10:12, Philippe Mathieu-Daudé wrote:
> On 4/9/23 10:03, Eric Auger wrote:
>> A reserved region is a range tagged with a type. Let's directly use
>> the Range type in the prospect to reuse some of the library helpers
>> shipped with the Range type.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>   include/exec/memory.h            | 4 ++--
>>   hw/core/qdev-properties-system.c | 9 ++++++---
>>   hw/virtio/virtio-iommu.c         | 6 +++---
>>   3 files changed, 11 insertions(+), 8 deletions(-)
>
> TIL "qemu/range.h" :)

I did as well and on top of that I learnt "TIL" :)
>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks!

Eric


