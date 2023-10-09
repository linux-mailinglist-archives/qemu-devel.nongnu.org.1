Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD5A7BD3BD
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 08:48:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpk3A-0005Vs-Te; Mon, 09 Oct 2023 02:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qpk39-0005Ve-2a
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:47:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qpk36-00076m-IP
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696834048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cNPjp6SjqiXg8Vm1SqWuujQTg4DesoO3nJvMyvtRxhU=;
 b=FOY6K2dTQGZ7ycu3DCv0PiM3pMTDs9opzXO/Cg5uj5f5TXSMXup2QRMyxhZytBLlparfu7
 SzaJNf8E41fyVj7nDeXrva8cVIi/lBIOB5zq3hiCrcrjjYnUy4hmUC8V1wn++mCOz+qe1d
 6cQCMSeWyDTiXRoFXIWYK/FJetV2L2o=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-BxlzXzXzNy6PkWQQwX2o1g-1; Mon, 09 Oct 2023 02:47:26 -0400
X-MC-Unique: BxlzXzXzNy6PkWQQwX2o1g-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-77435bbb71dso434123585a.1
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 23:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696834046; x=1697438846;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cNPjp6SjqiXg8Vm1SqWuujQTg4DesoO3nJvMyvtRxhU=;
 b=NNEv8fWyr2D+dbRZ4XGa6VR74Azgl9NliF52ai29LBmk+k+UCABhMXicebLD/Tytgs
 bsUFHJYVJRIvFTrZFAyDxHnTqxZYm00nKlFt6yTV+jH09DqM3vTrgx5Fv6S2jUE2dNf/
 PmejK7WpZhH/6JOfhx6ojUONbjC1DuaoKDQ+fKHZjXEfP91dB0zMXTNQWeORKFWki9FP
 rOfjLnj2mMivsPGAtNQmH5MkDveP70BS9VqczYH4vPZ0hPKgszIve8cYw9puSy/Yh6kG
 R+ngHw6ao883QgJwBRJBNZjA1cxDpiJFhp4AdrjEvyOZuqDg+u7s99phCrvsTXlGNk0W
 xFEg==
X-Gm-Message-State: AOJu0Yw0S3liajk37heqRxoqGBmHlVNwjP3hjhdPVAjM/ZAjj70E2SUY
 B6hVWlEsYRu3HOPYB/pXokhqrSc+EP5YIw/c8qaiOKWizdJAMn7Tta67l8Rfc9iVUeKZfLuoqhi
 03hxWgVLFtYe/aP5UaPFxgRuwmA5vnwr4pGlxdHw47zuF+d6NHCDQ18oQbCMkNM7xTo3f
X-Received: by 2002:a05:620a:6228:b0:76e:fea2:cc79 with SMTP id
 ou40-20020a05620a622800b0076efea2cc79mr11391009qkn.67.1696834045838; 
 Sun, 08 Oct 2023 23:47:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjuDPrCVfAZpNKzHTHH1dO5948io+9wZlllVv+fLbmhB8b7tTgDOkc1K4PqbSQFtZuhpBMgw==
X-Received: by 2002:a05:620a:6228:b0:76e:fea2:cc79 with SMTP id
 ou40-20020a05620a622800b0076efea2cc79mr11390997qkn.67.1696834045449; 
 Sun, 08 Oct 2023 23:47:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 k26-20020a05620a143a00b007758b25ac3bsm3323779qkj.82.2023.10.08.23.47.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Oct 2023 23:47:24 -0700 (PDT)
Message-ID: <87ca334c-9aa3-22f7-a7f6-57b405fca8e4@redhat.com>
Date: Mon, 9 Oct 2023 08:47:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PULL 00/21] vfio queue
Content-Language: en-US
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eauger@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>
References: <20231006062005.1040296-1-clg@redhat.com>
 <1e2652d6-c10b-9b65-6e2c-7903574d501a@redhat.com>
In-Reply-To: <1e2652d6-c10b-9b65-6e2c-7903574d501a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.818, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
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

On 10/6/23 12:33, Cédric Le Goater wrote:
> On 10/6/23 08:19, Cédric Le Goater wrote:
>> The following changes since commit 2f3913f4b2ad74baeb5a6f1d36efbd9ecdf1057d:
>>
>>    Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2023-10-05 09:01:01 -0400)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/legoater/qemu/ tags/pull-vfio-20231006
>>
>> for you to fetch changes up to 6e86aaef9ac57066aa923211a164df95b7b3cdf7:
>>
>>    vfio/common: Move legacy VFIO backend code into separate container.c (2023-10-05 22:04:52 +0200)
>>
>> ----------------------------------------------------------------
>> vfio queue:
>>
>> * Fix for VFIO display when using Intel vGPUs
>> * Support for dynamic MSI-X
>> * Preliminary work for IOMMUFD support
> 
> Stefan,
> 
> I just did some tests on z with passthough devices (PCI and AP) and
> the series is not bisectable. QEMU crashes at patch  :
> 
>    "vfio/pci: Introduce vfio_[attach/detach]_device".
> 
> Also, with everything applied, the guest fails to start with :
> 
>   vfio: IRQ 0 not available (number of irqs 0)
> 
> So, please hold on and sorry for the noise. I will start digging
> on my side.

We found a couple of issues after further testing. Fixes are under way.
Let's drop this PR. I will send a reduced one today.

Thanks,

C.


