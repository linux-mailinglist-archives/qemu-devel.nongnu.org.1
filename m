Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 259BD7A17A5
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 09:42:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh3T2-0004pT-1s; Fri, 15 Sep 2023 03:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qh3Sz-0004oX-5u
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 03:42:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qh3Sv-0000xq-Pn
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 03:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694763730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WBCVvw/PnLT2A4cvPOet9xgJ9t7DYO8+SGIfxmIWVac=;
 b=X5tpQoSGBuohD7qORS3m/J+4rXMT/WyVNtBtlki+wtuPspgmwGfj8vf/Y50cfiLQw2XLQS
 IMEI+HmwMV8LlOv8T2nsTRyBXisGmG3bzrlGenjD6aN5jaVRG3P9UIXUleJoASCrnvt7Ja
 IgonHQEN5KU/a5yDc+3yvHBBDUzwuIg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-cR8E1KnCNNOzpIUEaFCPew-1; Fri, 15 Sep 2023 03:42:09 -0400
X-MC-Unique: cR8E1KnCNNOzpIUEaFCPew-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40474c03742so9237585e9.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 00:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694763728; x=1695368528;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WBCVvw/PnLT2A4cvPOet9xgJ9t7DYO8+SGIfxmIWVac=;
 b=b7O5qV7IGae00unGTjaodmRtO8c5ihUOkBdEDJJmEruyIjcrd0th6NQtwGkfK5lv1q
 MewEP9XDS/HCTXxA4i+lZRvoIRV3S6YpdQHpTLKjgT6MksGBVo9YF2LXNrXOD0WSkGiW
 /CWRZ19yavyvogGBtWcz3yID9daNQyHomi7msocUiT1Mlenki51pPRYtHUH5BrUpLEZS
 Pf2ziRXRpjJ1okqtRPEbAijfd1PlDtNiNCzZ5BAwLMANxu2y4YABU297zfcPb+08mzN0
 VGWQd4OS/uBGhcxORgrAPo2r+mPOC41JgFR65CgKcNUm8rnj7HDft6tlB4Hvv9cMOaBZ
 kXSA==
X-Gm-Message-State: AOJu0YytyfVnF90VUbhml27J/6dIUHg2K/ibysybgzRpGTYrS4kbCCH4
 uCPGGODtwtdeO5yOTpdgptYVnHdWK+0FKQpKYyGwnA4iT07c7B/pfniZ9XQ8uYziKc4TY28G85g
 /FsvonzHFdVTgnFU=
X-Received: by 2002:a7b:ce08:0:b0:401:d803:624f with SMTP id
 m8-20020a7bce08000000b00401d803624fmr868037wmc.4.1694763728100; 
 Fri, 15 Sep 2023 00:42:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGbPak3e2WQOoyIBoQgd3DLomdcbwWa2hQ4NYenUIw85yRHFLkmClk0zyU4Ie1egmajmlY1w==
X-Received: by 2002:a7b:ce08:0:b0:401:d803:624f with SMTP id
 m8-20020a7bce08000000b00401d803624fmr868027wmc.4.1694763727791; 
 Fri, 15 Sep 2023 00:42:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 z20-20020a7bc7d4000000b003feae747ff2sm6755850wmk.35.2023.09.15.00.42.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 00:42:07 -0700 (PDT)
Message-ID: <022a5065-c1b3-2a02-0f49-67ef886e61a4@redhat.com>
Date: Fri, 15 Sep 2023 09:42:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 0/4] Support dynamic MSI-X allocation
Content-Language: en-US
To: "Liu, Jing2" <jing2.liu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>,
 "Chatre, Reinette" <reinette.chatre@intel.com>,
 "jing2.liu@linux.intel.com" <jing2.liu@linux.intel.com>
References: <20230822072927.224803-1-jing2.liu@intel.com>
 <DS0PR11MB811432F3818402828796CC65A9F6A@DS0PR11MB8114.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <DS0PR11MB811432F3818402828796CC65A9F6A@DS0PR11MB8114.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 9/15/23 09:40, Liu, Jing2 wrote:
> Friendly ping to have your valuable inputs and comments.
> Thanks very much.

I think that was done. We are waiting for the v2.

Thanks,

C.


> 
> BRs,
> Jing
> 
>> On 8/22/2023 3:29 PM, Jing Liu wrote:
>> Changes since RFC v1:
>> - RFC v1: https://www.mail-archive.com/qemu-
>> devel@nongnu.org/msg978637.html
>> - Revise the comments. (Alex)
>> - Report error of getting irq info and remove the trace of failure
>>    case. (Alex, Cédric)
>> - Only store dynamic allocation flag as a bool type and test
>>    accordingly. (Alex)
>> - Move dynamic allocation detection to vfio_msix_early_setup(). (Alex)
>> - Change the condition logic in vfio_msix_vector_do_use() that moving
>>    the defer_kvm_irq_routing test out and create a common place to update
>>    nr_vectors. (Alex)
>> - Consolidate the way of MSI-X enabling during device initialization and
>>    interrupt restoring that uses fd = -1 trick. Create a function doing
>>    that. (Alex)
>>
>> Before kernel v6.5, dynamic allocation of MSI-X interrupts was not supported.
>> Qemu therefore when allocating a new interrupt, should first release all
>> previously allocated interrupts (including disable of MSI-X) and re-allocate all
>> interrupts that includes the new one.
>>
>> The kernel series [1] adds the support of dynamic MSI-X allocation to vfio-pci
>> and uses the existing flag VFIO_IRQ_INFO_NORESIZE to guide user space, that
>> when dynamic MSI-X is supported the flag is cleared.
>>
>> This series makes the behavior for VFIO PCI devices when dynamic MSI-X
>> allocation is supported. When guest unmasks an interrupt, Qemu can directly
>> allocate an interrupt on host for this and has nothing to do with the previously
>> allocated ones. Therefore, host only allocates interrupts for those unmasked
>> (enabled) interrupts inside guest when dynamic MSI-X allocation is supported by
>> device.
>>
>> When guests enable MSI-X with all of the vectors masked, Qemu need match the
>> state to enable MSI-X with no vector enabled. During migration restore, Qemu
>> also need enable MSI-X first in dynamic allocation mode, to avoid the guest
>> unused vectors being allocated on host. To consolidate them, we use vector 0
>> with an invalid fd to get MSI-X enabled and create a common function for this.
>> This is cleaner than setting userspace triggering and immediately release.
>>
>> Any feedback is appreciated.
>>
>> Jing
>>
>> [1] https://lwn.net/Articles/931679/
>>
>> Jing Liu (4):
>>    vfio/pci: detect the support of dynamic MSI-X allocation
>>    vfio/pci: enable vector on dynamic MSI-X allocation
>>    vfio/pci: use an invalid fd to enable MSI-X
>>    vfio/pci: enable MSI-X in interrupt restoring on dynamic allocation
>>
>>   hw/vfio/pci.c        | 126 +++++++++++++++++++++++++++++++++----------
>>   hw/vfio/pci.h        |   1 +
>>   hw/vfio/trace-events |   2 +-
>>   3 files changed, 101 insertions(+), 28 deletions(-)
>>
>> --
>> 2.27.0
> 


