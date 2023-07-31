Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D77E5769708
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 15:03:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQSYd-0001BY-6n; Mon, 31 Jul 2023 09:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qQSYb-0001BI-By
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 09:03:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qQSYZ-0000sb-MG
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 09:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690808607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EZg3dj7fZg1WDALPDyeGDR0/qrHkWE2blrqwfx5+n9M=;
 b=FrgLAFE9RCIc61UIYIlcEBbXbljbXR9+7sAOdPpj2JChGoCiWIyBTkog0kX/bL+/l3BSv6
 +lWBfURRrrqfCTBtRGhBl79LAE0mkTvCksZmbsbS/pP/tfw7aoHGqilEqtU7DzYbXR0zHm
 6an4yb4yOvnJaLgF++XwgepdGv8ymwE=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-er_ClU7oNkubUOOGMQdMsQ-1; Mon, 31 Jul 2023 09:03:25 -0400
X-MC-Unique: er_ClU7oNkubUOOGMQdMsQ-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-686f0c37911so5217359b3a.1
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 06:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690808604; x=1691413404;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EZg3dj7fZg1WDALPDyeGDR0/qrHkWE2blrqwfx5+n9M=;
 b=LU+SG28HdcIYZHl9oaMnbkLcefWs5uVzCW98UbriptXfSuOEUi/H6Rn1r2UgtJuunj
 dMTwh3aGaYX6iOkIKOplKuCGcJkQkFsw0l1jQcVOBsEBBTnX4iozWXtmEKKZilnvl2yd
 8NyKKeGT2OfcQ9/8SNHrGb+b1tSRUM5CuVtlkltFoY5gvVNitZNaR/WLiD8CLFfDuprv
 tkoOE9UdFyYcIcK1VvXj7/5Lgg5KulFUJd+B2MvH3iGnqQMROL6S1eCKvC+/2HMKAK+X
 egxfMJ14OpddRfhc62vHwJC53KG84d0NkTpAhURcrBoUeiPAkWmlxhl6gDMal67XSrY8
 GhTA==
X-Gm-Message-State: ABy/qLZzNDZ7uNn8Y/xuCfAzWMDX6ZauRavkRaeErY/+sKz76igqF15G
 XU8rBVc4IesKQSDM4M8P6uYDGxzWTZzXbYnWFK3QsJVXoaB/UU2v/crwF3yDI2ojHrSD4UqyPN0
 wFnohN3lKF3g8lBs=
X-Received: by 2002:a05:6a20:32aa:b0:137:3b34:93e5 with SMTP id
 g42-20020a056a2032aa00b001373b3493e5mr8347041pzd.59.1690808604167; 
 Mon, 31 Jul 2023 06:03:24 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG2tGTxviPz00+OI3d4S+IrzitZNqwKLTa1I/1z/iE7RfOHF5UJJ2SdTJv4ahJX6JDCanYS7A==
X-Received: by 2002:a05:6a20:32aa:b0:137:3b34:93e5 with SMTP id
 g42-20020a056a2032aa00b001373b3493e5mr8347014pzd.59.1690808603735; 
 Mon, 31 Jul 2023 06:03:23 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 p2-20020a62ab02000000b006826c9e4397sm7601291pff.48.2023.07.31.06.03.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 06:03:22 -0700 (PDT)
Message-ID: <c86779f3-3d27-c67d-efb4-e1a664b2e5c6@redhat.com>
Date: Mon, 31 Jul 2023 23:03:17 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] kvm: Fix crash by initializing kvm_state early
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com,
 philmd@linaro.org, shan.gavin@gmail.com
References: <20230730234840.1989974-1-gshan@redhat.com>
 <af597a7c-5580-ffc5-d435-dd7e0ccc63d2@redhat.com>
 <CAFEAcA8Uc7S4oBzKi_9AGCEkNdeZX1U73bvit6RmQo8_A7QLoA@mail.gmail.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <CAFEAcA8Uc7S4oBzKi_9AGCEkNdeZX1U73bvit6RmQo8_A7QLoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.101, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 7/31/23 22:39, Peter Maydell wrote:
> On Mon, 31 Jul 2023 at 08:18, David Hildenbrand <david@redhat.com> wrote:
>>
>> On 31.07.23 01:48, Gavin Shan wrote:
>>> Runs into core dump on arm64 and the backtrace extracted from the
>>> core dump is shown as below. It's caused by accessing @kvm_state which
>>> isn't initialized at that point due to commit 176d073029 ("hw/arm/virt:
>>> Use machine_memory_devices_init()"), where the machine's memory region
>>> is added ealier than before.
>>
>> s/ealier/earlier/
>>
>>>
>>>       main
>>>       qemu_init
>>>       configure_accelerators
>>>       qemu_opts_foreach
>>>       do_configure_accelerator
>>>       accel_init_machine
>>>       kvm_init
>>>       virt_kvm_type
>>>       virt_set_memmap
>>>       machine_memory_devices_init
>>>       memory_region_add_subregion
>>>       memory_region_add_subregion_common
>>>       memory_region_update_container_subregions
>>>       memory_region_transaction_begin
>>>       qemu_flush_coalesced_mmio_buffer
>>>       kvm_flush_coalesced_mmio_buffer
>>>
>>> Fix it by initializing @kvm_state early. With this applied, no crash
>>> is observed on arm64.
> 
>> As an alternative, we might simply do nothing in
>> kvm_flush_coalesced_mmio_buffer(), in case kvm_state is not setup yet.
>> We don't have any notifier registered in that case.
> 
> Yes, this seems better I think -- conceptually kvm_init()
> probably ought to first set up the accelerator state and
> then set kvm_state last, so that other code that looks
> at the kvm_state global either sees NULL or else a
> completely valid state, not a possibly half-initialised
> one. (We should probably also NULL the global in the
> error-exit path, though I imagine we're about to exit
> in that case.)
> 
> Is somebody able to write/test a patch for that today?
> Ideally we'd fix this for tomorrow's rc...
> 

Thanks for your comments, David and Peter. v2 was posted for a quick merge.

https://lists.nongnu.org/archive/html/qemu-arm/2023-07/msg00702.html

Thanks,
Gavin


