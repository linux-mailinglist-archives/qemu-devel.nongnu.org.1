Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8D6756A08
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 19:20:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLRtr-0002VU-1b; Mon, 17 Jul 2023 13:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qLRto-0002QL-Ii
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 13:20:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qLRtj-0004w1-An
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 13:20:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689614433;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2FCeJ+7KynFTMO/O0iRhfTcan3cnx8pvXJ00BsYCVJY=;
 b=QmxlRA2Bm6h60H0UqigiNTOvPK9sXIkIL9FQ825lOkOvm5FNnrF2qYRoCSybo7Qw+BsAdn
 C1o8rMy5S4s0R4TbxzTPuBc22UbASAFd6g2CIrNC5jsqT0xTtCN3Y3QHM2CDGoVFX4j3Ik
 6OJPoi+FXO3478AN3axL4Ahm/tYptUo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-aWXgT8K3OwGwXCz0ecq1Fg-1; Mon, 17 Jul 2023 13:20:32 -0400
X-MC-Unique: aWXgT8K3OwGwXCz0ecq1Fg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3143c9a3519so2999229f8f.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 10:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689614431; x=1690219231;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2FCeJ+7KynFTMO/O0iRhfTcan3cnx8pvXJ00BsYCVJY=;
 b=gTYDC0U+Djual8t3Rb3CS1cs8cbS9WB9wnfTFXBR7zX2/n8FvDbp+XG96Snv4je7LN
 mxY1Oavq0KwxNcBWIobZUJbh/rHSZBGwgfFKwhYA/zYMSb143SaS28DkRSiG5MW1Gg2r
 CxGEowCP1TgFSI0Wk9GKo5ABG1lEKJbnDqQ0xlgofP3B3pdP4dKhehEropapflZP6Sct
 1VX+A4zEQBmmo2iPH+t9DJmlveOcJtWOInhy3THtSHdrO4BwdV/VfJN7MJ2yzrzax+an
 9t3v4JmcvU2vHTCtbZECGZFSzikOgxA57RTjN1zOdg13bolItrxJIDvaAHBPiZO/dkT1
 5uwA==
X-Gm-Message-State: ABy/qLYRsSInwnCJYIKK9fTeNrOY+Eo5EJnX5QIxJoYb+qTC5vUITOEs
 sQ9VPhU6hMT5Sgg0amnPhvCERN7YpHPiQnxH8AsmGq6pgQmwxeevZPwjaQ8aWn9Bv2WWN9w/A9G
 CSitfR93/PMc55fs=
X-Received: by 2002:adf:f588:0:b0:314:2faa:a23 with SMTP id
 f8-20020adff588000000b003142faa0a23mr13031102wro.43.1689614431100; 
 Mon, 17 Jul 2023 10:20:31 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFxovVqYYF4VTIxp9TIA6y8hjRkB6p806wDglOLRu0y7GbVLN/YWg8m6iMrCvhtwG1gGE6Egg==
X-Received: by 2002:adf:f588:0:b0:314:2faa:a23 with SMTP id
 f8-20020adff588000000b003142faa0a23mr13031080wro.43.1689614430725; 
 Mon, 17 Jul 2023 10:20:30 -0700 (PDT)
Received: from [192.168.43.95] ([37.168.249.127])
 by smtp.gmail.com with ESMTPSA id
 l7-20020a1ced07000000b003fbe561f6a3sm8443897wmh.37.2023.07.17.10.20.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 10:20:29 -0700 (PDT)
Message-ID: <3f3d1bd8-6fab-fcca-d5bf-9c660c3717b1@redhat.com>
Date: Mon, 17 Jul 2023 19:20:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PULL 46/66] virtio-iommu: Fix 64kB host page size VFIO device
 assignment
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <cover.1689030052.git.mst@redhat.com>
 <94df5b2180d61fb2ee2b04cc007981e58b6479a9.1689030052.git.mst@redhat.com>
 <CAFEAcA9JAZrxpcfjyEj8Hj1eYb+9PUxV2i05JTZwe0u+gVSBPg@mail.gmail.com>
 <e59937b4-6965-2ff3-cc9f-a44ba589a5a3@redhat.com>
 <CAFEAcA-f_e0pKQ8fx5_ELd_snBo55DQ6BO8naBUazZ=nP3KHnA@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CAFEAcA-f_e0pKQ8fx5_ELd_snBo55DQ6BO8naBUazZ=nP3KHnA@mail.gmail.com>
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
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



On 7/17/23 19:07, Peter Maydell wrote:
> On Mon, 17 Jul 2023 at 17:56, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> Hi Peter,
>> On 7/17/23 12:50, Peter Maydell wrote:
>>> On Tue, 11 Jul 2023 at 00:04, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>> From: Eric Auger <eric.auger@redhat.com>
>>>>
>>>> When running on a 64kB page size host and protecting a VFIO device
>>>> with the virtio-iommu, qemu crashes with this kind of message:
>>>>
>>>> qemu-kvm: virtio-iommu page mask 0xfffffffffffff000 is incompatible
>>>> with mask 0x20010000
>>>> qemu: hardware error: vfio: DMA mapping failed, unable to continue
>>>>
>>>> This is due to the fact the IOMMU MR corresponding to the VFIO device
>>>> is enabled very late on domain attach, after the machine init.
>>>> The device reports a minimal 64kB page size but it is too late to be
>>>> applied. virtio_iommu_set_page_size_mask() fails and this causes
>>>> vfio_listener_region_add() to end up with hw_error();
>>>>
>>>> To work around this issue, we transiently enable the IOMMU MR on
>>>> machine init to collect the page size requirements and then restore
>>>> the bypass state.
>>>>
>>>> Fixes: 90519b9053 ("virtio-iommu: Add bypass mode support to assigned device")
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> Hi; Coverity complains about this change (CID 1517772):
>> thank you for reporting the issue
>>>> +static void virtio_iommu_freeze_granule(Notifier *notifier, void *data)
>>>> +{
>>>> +    VirtIOIOMMU *s = container_of(notifier, VirtIOIOMMU, machine_done);
>>>> +    int granule;
>>>> +
>>>> +    if (likely(s->config.bypass)) {
>>>> +        /*
>>>> +         * Transient IOMMU MR enable to collect page_size_mask requirements
>>>> +         * through memory_region_iommu_set_page_size_mask() called by
>>>> +         * VFIO region_add() callback
>>>> +         */
>>>> +         s->config.bypass = false;
>>>> +         virtio_iommu_switch_address_space_all(s);
>>>> +         /* restore default */
>>>> +         s->config.bypass = true;
>>>> +         virtio_iommu_switch_address_space_all(s);
>>>> +    }
>>>> +    s->granule_frozen = true;
>>>> +    granule = ctz64(s->config.page_size_mask);
>>>> +    trace_virtio_iommu_freeze_granule(BIT(granule));
>>> Specifically, in this code, it thinks that ctz64() can
>>> return 64, in which case BIT(granule) is shifting off
>>> the end of the value, which is undefined behaviour.
>>> This can happen if s->config.page_size_mask is 0 -- are
>>> there assertions/checks that that can't happen elsewhere?
>> To me this cannot happen. The page_size_mask is initialized with
>> qemu_target_page_mask(), then further constrained with
>> virtio_iommu_set_page_size_mask() which would call error_setg if the new
>> mask is 0 or (cur_mask & new_mask) == 0
>>
>> What can I do to give coverity a hint that page_size_mask cannot be NULL?
> You can assert() it if you believe it to be true and you
> think an assert() would help a human reader,
> or we could just say "this is a false positive" and
> mark it that way in the Coverity UI. We don't need to
> change things purely to make Coverity happy.
OK
>
>>> Secondly, BIT() only works for values up to 32, since
>>> it works on type unsigned long, which might be a 32-bit
>>> type on some hosts. Since you used ctz64()
>>> you probably want BIT_ULL() which uses the ULL type
>>> which definitely has 64 bits.
>> agreed.
> Looking more closely at this, the file is not entirely
> consistent about how it handles the page_size_mask:
>  * in virtio_iommu_translate() we call ctz32()
>    and then use an open-coded 1 << n on that
>  * in virtio_iommu_set_page_size_mask() we call
>    ctz64() and use BIT()
>  * in virtio_iommu_freeze_granule() we call ctz64()
>    and then use BIT()
>
> So I suspect it's actually true (or at least assumed)
> that the granule value can never be 32 or higher, as
> well as it being non-zero.
yes I don't expect the granule to be >= 32 but I agree this is a mess in
the current implementation and this would deserve some alignment

I will work on a patch ...

Thanks

Eric
>
> thanks
> -- PMM
>


