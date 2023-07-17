Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 439BB7569BF
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 18:58:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLRYB-0000FN-BX; Mon, 17 Jul 2023 12:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qLRXa-0008T6-1b
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 12:57:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qLRXY-0007VF-9N
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 12:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689613059;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sD+BWxKczx/SExKD/F2Dflmdqy2coDxiNJw1cPN/pPI=;
 b=ajYXCieb+9bqAK8wGBU0JbUgkNqSo+ejjeMDDT+DLTSf+qNKS2ZmA5RrCmbClIsTNhgz9T
 C4tT8dizuBBouiyiFqFXf7s5mEFlZMeDn4vwM3qBBekF/4ngl3EQUjkBng2U+qKdbMXWE8
 RBmrlfEyYwh1ZjufZOeR7HwlcxomOwM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-Vjez-h8RP0aRe5v1OgVcmQ-1; Mon, 17 Jul 2023 12:57:38 -0400
X-MC-Unique: Vjez-h8RP0aRe5v1OgVcmQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-403aa5cca80so35098271cf.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 09:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689613057; x=1690217857;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sD+BWxKczx/SExKD/F2Dflmdqy2coDxiNJw1cPN/pPI=;
 b=Do00rjIyYfp0u1dp0BUljTJvJjgRJBrD0eVOqk3CZnK5zycHQnbg2EGQyVrTH66/SP
 G64R96phfIhvZ2iNF4KTDyn04X070geFwpyr2caYyfqmfQ/Hak/KoLLhb6yHgYqBdWgw
 HFSQgTLQC2zl99iLUZJvtpRKEhIUV16WG4erlwImXWXEOqq2mJu+LQWMAcD1GWI4mQvU
 HxeaerhrMlAyIcTP/MRt83kx97HF64tQ3mGHKBcJG1R/YjnvNLpfpGDk34t+menFPX3T
 E7xqyJBK/+JhQ91ojqjhZCBzu4xtAb+35UfZYYtiVXiwhodX2IlGOT0wl2QqPF7keMO8
 ryRA==
X-Gm-Message-State: ABy/qLbiewsnNoCkEWcFn+9P4Y9q49xZfPxQ+JepLCxrNWMpOjKjg1Og
 fLXpEcUez84qpLwf1WB4N1X0uMEyJf2S9jdJQtPvkzajBiSWd0u3/VGxoCEupEjELIJrF43maaq
 hT1oh5hz5v9u65Z8=
X-Received: by 2002:a05:622a:1393:b0:403:b10c:8365 with SMTP id
 o19-20020a05622a139300b00403b10c8365mr15880446qtk.62.1689613057663; 
 Mon, 17 Jul 2023 09:57:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF71Qm1sf1Bcc7QZsLDbzuMxBP2inyQJk0vp/olKkn9pV5ls928YIf8BGJVEyJ2KIJFhuuQiA==
X-Received: by 2002:a05:622a:1393:b0:403:b10c:8365 with SMTP id
 o19-20020a05622a139300b00403b10c8365mr15880434qtk.62.1689613057431; 
 Mon, 17 Jul 2023 09:57:37 -0700 (PDT)
Received: from [192.168.43.95] ([37.168.249.127])
 by smtp.gmail.com with ESMTPSA id
 e21-20020ac85995000000b004035b79860dsm6419688qte.81.2023.07.17.09.57.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 09:57:36 -0700 (PDT)
Message-ID: <4e04942f-68a4-9288-c684-968250c19183@redhat.com>
Date: Mon, 17 Jul 2023 18:57:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PULL 46/66] virtio-iommu: Fix 64kB host page size VFIO device
 assignment
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <cover.1689030052.git.mst@redhat.com>
 <94df5b2180d61fb2ee2b04cc007981e58b6479a9.1689030052.git.mst@redhat.com>
 <CAFEAcA9JAZrxpcfjyEj8Hj1eYb+9PUxV2i05JTZwe0u+gVSBPg@mail.gmail.com>
 <20230717075137-mutt-send-email-mst@kernel.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230717075137-mutt-send-email-mst@kernel.org>
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



On 7/17/23 13:51, Michael S. Tsirkin wrote:
> On Mon, Jul 17, 2023 at 11:50:54AM +0100, Peter Maydell wrote:
>> On Tue, 11 Jul 2023 at 00:04, Michael S. Tsirkin <mst@redhat.com> wrote:
>>> From: Eric Auger <eric.auger@redhat.com>
>>>
>>> When running on a 64kB page size host and protecting a VFIO device
>>> with the virtio-iommu, qemu crashes with this kind of message:
>>>
>>> qemu-kvm: virtio-iommu page mask 0xfffffffffffff000 is incompatible
>>> with mask 0x20010000
>>> qemu: hardware error: vfio: DMA mapping failed, unable to continue
>>>
>>> This is due to the fact the IOMMU MR corresponding to the VFIO device
>>> is enabled very late on domain attach, after the machine init.
>>> The device reports a minimal 64kB page size but it is too late to be
>>> applied. virtio_iommu_set_page_size_mask() fails and this causes
>>> vfio_listener_region_add() to end up with hw_error();
>>>
>>> To work around this issue, we transiently enable the IOMMU MR on
>>> machine init to collect the page size requirements and then restore
>>> the bypass state.
>>>
>>> Fixes: 90519b9053 ("virtio-iommu: Add bypass mode support to assigned device")
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Hi; Coverity complains about this change (CID 1517772):
>>
>>> +static void virtio_iommu_freeze_granule(Notifier *notifier, void *data)
>>> +{
>>> +    VirtIOIOMMU *s = container_of(notifier, VirtIOIOMMU, machine_done);
>>> +    int granule;
>>> +
>>> +    if (likely(s->config.bypass)) {
>>> +        /*
>>> +         * Transient IOMMU MR enable to collect page_size_mask requirements
>>> +         * through memory_region_iommu_set_page_size_mask() called by
>>> +         * VFIO region_add() callback
>>> +         */
>>> +         s->config.bypass = false;
>>> +         virtio_iommu_switch_address_space_all(s);
>>> +         /* restore default */
>>> +         s->config.bypass = true;
>>> +         virtio_iommu_switch_address_space_all(s);
>>> +    }
>>> +    s->granule_frozen = true;
>>> +    granule = ctz64(s->config.page_size_mask);
>>> +    trace_virtio_iommu_freeze_granule(BIT(granule));
>> Specifically, in this code, it thinks that ctz64() can
>> return 64, in which case BIT(granule) is shifting off
>> the end of the value, which is undefined behaviour.
>> This can happen if s->config.page_size_mask is 0 -- are
>> there assertions/checks that that can't happen elsewhere?
>>
>> Secondly, BIT() only works for values up to 32, since
>> it works on type unsigned long, which might be a 32-bit
>> type on some hosts. Since you used ctz64()
>> you probably want BIT_ULL() which uses the ULL type
>> which definitely has 64 bits.
>>
>> thanks
>> -- PMM
> Thanks! Eric can you fix pls?

Sure

Eric
>


