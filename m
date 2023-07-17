Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 329C47569B9
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 18:57:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLRWj-0008Cx-A8; Mon, 17 Jul 2023 12:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qLRWg-0008CZ-Nk
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 12:56:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qLRWf-0007PY-2K
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 12:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689613003;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zA0Te0uNeSRZWXKofGmIIaBiq2WQPAd7mGbbqGT+CQw=;
 b=XU1CM9yZDM49fvWfucO4hsAYFLqR0vcvwBkGzX/H3TIT1SWBEw++t2dng/S9/OORumorxO
 fLYJ+ZtaRPpT5qe2raVy+rro5BXptVETOJJCG5uBXFxvW8EK5hhqnfEUgV3tFaS6cZCInk
 R9aHrZqr463IrgDH2rYonDTcjysLHZ8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-1ha8vA3UPA2AZezyND2iIQ-1; Mon, 17 Jul 2023 12:56:41 -0400
X-MC-Unique: 1ha8vA3UPA2AZezyND2iIQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-635dd236b63so38814706d6.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 09:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689613001; x=1690217801;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zA0Te0uNeSRZWXKofGmIIaBiq2WQPAd7mGbbqGT+CQw=;
 b=XNHNz/QzvzQUqzXDEtsdMkis2w6CzZqQCSIcHj1/zHiT1DVKrrCfznHLdlQsvFCauf
 WoNBVyFHGvvCgtGoymaUtQv+ZU+udevQHE90OVrL8MdpoA9wTsO/UyXsijo2gQozXbTg
 G0PkbBfRAixNKx7Y4AjTuC+3EBibbSFs1axetlnia0pqqoVA3CVSoixt/JhlZrhupqBY
 Exbs0paOYi4bolczsYW6b4glMoLu/Jw0H9gii1PW/iCOGoc83q9kkF5qc39bUXUvSGqt
 EwXvWqh75tWDQgtqb/6UBqrCliJoDyIhrYta1Nd1GLI+16z9VS6586Raircg6fiuhBxl
 xdiQ==
X-Gm-Message-State: ABy/qLaPAYWq01NckRbMcTGi9Dd2DrpnLikICpssLv7AX4WVkZuKXDdk
 2GmrH/JY9Iw21vLQHAVv5zQCQgf2l1p2d+8UmRXpN4SmRhSmhh/RRKqGxgAB+jaW3cY24k57DS8
 HymqhBLnEyvepU2w=
X-Received: by 2002:a05:6214:2128:b0:637:b20d:899d with SMTP id
 r8-20020a056214212800b00637b20d899dmr15135691qvc.10.1689613001344; 
 Mon, 17 Jul 2023 09:56:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF2CMGgEHV1FWFp8+rg9HNut3Cz437Ecky3u+rMz8gUrO/co3qPL0xEGUW5ztgZvoIyrURicw==
X-Received: by 2002:a05:6214:2128:b0:637:b20d:899d with SMTP id
 r8-20020a056214212800b00637b20d899dmr15135674qvc.10.1689613001059; 
 Mon, 17 Jul 2023 09:56:41 -0700 (PDT)
Received: from [192.168.43.95] ([37.168.249.127])
 by smtp.gmail.com with ESMTPSA id
 4-20020a05620a070400b00767dba7a4d3sm6206764qkc.109.2023.07.17.09.56.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 09:56:39 -0700 (PDT)
Message-ID: <e59937b4-6965-2ff3-cc9f-a44ba589a5a3@redhat.com>
Date: Mon, 17 Jul 2023 18:56:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PULL 46/66] virtio-iommu: Fix 64kB host page size VFIO device
 assignment
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <cover.1689030052.git.mst@redhat.com>
 <94df5b2180d61fb2ee2b04cc007981e58b6479a9.1689030052.git.mst@redhat.com>
 <CAFEAcA9JAZrxpcfjyEj8Hj1eYb+9PUxV2i05JTZwe0u+gVSBPg@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CAFEAcA9JAZrxpcfjyEj8Hj1eYb+9PUxV2i05JTZwe0u+gVSBPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.097, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


Hi Peter,
On 7/17/23 12:50, Peter Maydell wrote:
> On Tue, 11 Jul 2023 at 00:04, Michael S. Tsirkin <mst@redhat.com> wrote:
>> From: Eric Auger <eric.auger@redhat.com>
>>
>> When running on a 64kB page size host and protecting a VFIO device
>> with the virtio-iommu, qemu crashes with this kind of message:
>>
>> qemu-kvm: virtio-iommu page mask 0xfffffffffffff000 is incompatible
>> with mask 0x20010000
>> qemu: hardware error: vfio: DMA mapping failed, unable to continue
>>
>> This is due to the fact the IOMMU MR corresponding to the VFIO device
>> is enabled very late on domain attach, after the machine init.
>> The device reports a minimal 64kB page size but it is too late to be
>> applied. virtio_iommu_set_page_size_mask() fails and this causes
>> vfio_listener_region_add() to end up with hw_error();
>>
>> To work around this issue, we transiently enable the IOMMU MR on
>> machine init to collect the page size requirements and then restore
>> the bypass state.
>>
>> Fixes: 90519b9053 ("virtio-iommu: Add bypass mode support to assigned device")
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Hi; Coverity complains about this change (CID 1517772):

thank you for reporting the issue
>
>> +static void virtio_iommu_freeze_granule(Notifier *notifier, void *data)
>> +{
>> +    VirtIOIOMMU *s = container_of(notifier, VirtIOIOMMU, machine_done);
>> +    int granule;
>> +
>> +    if (likely(s->config.bypass)) {
>> +        /*
>> +         * Transient IOMMU MR enable to collect page_size_mask requirements
>> +         * through memory_region_iommu_set_page_size_mask() called by
>> +         * VFIO region_add() callback
>> +         */
>> +         s->config.bypass = false;
>> +         virtio_iommu_switch_address_space_all(s);
>> +         /* restore default */
>> +         s->config.bypass = true;
>> +         virtio_iommu_switch_address_space_all(s);
>> +    }
>> +    s->granule_frozen = true;
>> +    granule = ctz64(s->config.page_size_mask);
>> +    trace_virtio_iommu_freeze_granule(BIT(granule));
> Specifically, in this code, it thinks that ctz64() can
> return 64, in which case BIT(granule) is shifting off
> the end of the value, which is undefined behaviour.
> This can happen if s->config.page_size_mask is 0 -- are
> there assertions/checks that that can't happen elsewhere?
To me this cannot happen. The page_size_mask is initialized with
qemu_target_page_mask(), then further constrained with
virtio_iommu_set_page_size_mask() which would call error_setg if the new
mask is 0 or (cur_mask & new_mask) == 0

What can I do to give coverity a hint that page_size_mask cannot be NULL?
>
> Secondly, BIT() only works for values up to 32, since
> it works on type unsigned long, which might be a 32-bit
> type on some hosts. Since you used ctz64()
> you probably want BIT_ULL() which uses the ULL type
> which definitely has 64 bits.
agreed.

Thanks

Eric
>
> thanks
> -- PMM
>


