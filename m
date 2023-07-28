Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA439767182
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 18:08:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPPkO-0006BN-VC; Fri, 28 Jul 2023 11:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qPPkN-0006B8-78
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 11:51:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qPPkL-0006kQ-Px
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 11:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690559476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NfF/L/makyYvrpqwn/bSxqqTJwU7QoEoo16tPovq5Ag=;
 b=DgI8B/olXBtfMZWazqfu3hIhAiMHYHP7Ql0x/LyqVtcQARYbbJHAwSgnBt+1t5/gdR4ywd
 bRVv5XS3k2G7aqSkbsywoUJE6BinwllUHsINg0RW0AAQwWjrS1doMEFoEZRd45BYPt/+ng
 V6+2IedpRhbRZcDDvIy63FD8RnnHhaA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-dcUjiax6PQWPEb14JNFmFg-1; Fri, 28 Jul 2023 11:51:15 -0400
X-MC-Unique: dcUjiax6PQWPEb14JNFmFg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3176fe7b67bso1162645f8f.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 08:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690559474; x=1691164274;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NfF/L/makyYvrpqwn/bSxqqTJwU7QoEoo16tPovq5Ag=;
 b=bi3WzBg2n/0nW+1A9mqYnEUVLKhi2G4YGhvW4/9Avj+ucnmPyXWQCu95l69cgSjU1a
 XfdTrw6G2DjSy+aeWg5O9jqHua8MzT4gavCR2SwZMC2I2ndutAfB9A7cAy8g4mfZjOb3
 pICdbu/mMDNtdb6aiUy8N2y45qV3rrNr6Ura4vsD6zIYLgmsA+YYRMiSGgbVGUFxt+/t
 IgpTznlHoQCZVVszT4FZQm/keJbT6XBwuSmqAyWEIJtzSRaCiwkkFTAYz38wYmjQO0FF
 4XfNnaPEO4Di2sl1V387/pZhvEGkDly0aq3zF1LGs8VOsN36stbxq5Wi8COvoloiA8dj
 SVJA==
X-Gm-Message-State: ABy/qLb5tndgilI+r2p343CHZjhzFBa0bctyyTyngF7YT0h490FXN1gZ
 Gub91ruBdmAnXh8KEHvQ5EVQGa+xRNWvWwN76A615BG3ZKEcYPNTQtpnXhOHmIilwYJnSCnGn33
 0fbp8rl+b3SeIyY0=
X-Received: by 2002:a5d:6289:0:b0:317:4755:9e3f with SMTP id
 k9-20020a5d6289000000b0031747559e3fmr1831402wru.62.1690559473852; 
 Fri, 28 Jul 2023 08:51:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFxGuzg3XFwlnmhZJacX5x4M07Da36XVUwHxl0iKWK8MJVp1SDhGnLwh6mfE+Q6w9Jh9RmujQ==
X-Received: by 2002:a5d:6289:0:b0:317:4755:9e3f with SMTP id
 k9-20020a5d6289000000b0031747559e3fmr1831389wru.62.1690559473431; 
 Fri, 28 Jul 2023 08:51:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 m14-20020adffa0e000000b003177e9b2e64sm5059089wrr.90.2023.07.28.08.51.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jul 2023 08:51:13 -0700 (PDT)
Message-ID: <4bf68630-7951-becf-2645-f8db36a8c6bb@redhat.com>
Date: Fri, 28 Jul 2023 17:51:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RFC v1 1/3] vfio/pci: detect the support of dynamic MSI-X
 allocation
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "Liu, Jing2" <jing2.liu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>,
 "Chatre, Reinette" <reinette.chatre@intel.com>
References: <20230727072410.135743-1-jing2.liu@intel.com>
 <20230727072410.135743-2-jing2.liu@intel.com>
 <20230727112457.1422f285.alex.williamson@redhat.com>
 <DS0PR11MB8114C864A2D55951DD621214A906A@DS0PR11MB8114.namprd11.prod.outlook.com>
 <e6d47754-9d2b-20bc-55b0-ed6685f7b3b2@redhat.com>
 <20230728094120.6c809cfb.alex.williamson@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230728094120.6c809cfb.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.094, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

[ ... ]

>>>>> --- a/hw/vfio/pci.h
>>>>> +++ b/hw/vfio/pci.h
>>>>> @@ -113,6 +113,7 @@ typedef struct VFIOMSIXInfo {
>>>>>        uint32_t table_offset;
>>>>>        uint32_t pba_offset;
>>>>>        unsigned long *pending;
>>>>> +    uint32_t irq_info_flags;
>>>>
>>>> Why not simply pull out a "noresize" bool?  Thanks,
>>>>   
>>> Will change to a bool type.
>>
>> I would simply cache the KVM flags value under VFIOMSIXInfo as you
>> did and add an helper. Both work the same but the intial proposal
>> keeps more information. This is minor.
> 
> TBH, I'd still prefer that we only store the one field we care about
> and avoid an extra helper, regardless of how simple it might be.  Even
> if we eventually add masking for MSI-X, we can store it in less space
> and more accessibly decoded in the VFIOMSIXInfo struct vs helpers to
> access a cached flags value.  Thanks,

Let's use a bool then. np.

Thanks,

C.


