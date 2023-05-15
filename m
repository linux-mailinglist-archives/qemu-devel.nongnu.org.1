Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8919703073
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 16:47:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyZOw-0007gH-8E; Mon, 15 May 2023 10:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1pyZOn-0007WX-8n
 for qemu-devel@nongnu.org; Mon, 15 May 2023 10:42:05 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1pyZOk-0006zV-SH
 for qemu-devel@nongnu.org; Mon, 15 May 2023 10:42:04 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1aaf2ede38fso124359665ad.2
 for <qemu-devel@nongnu.org>; Mon, 15 May 2023 07:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684161721; x=1686753721;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3XMl/4hE9MVAxodhxUQfas2HkhWZAFZbnfixZTTNXFI=;
 b=KFEtzwaSFvXOQAI5uqHvvInIb+m7SobCQTuXzqz8v9ibxrJ3YbJ8TwwU3XDxcVtDAs
 v+WWZ6nx93rs1uSZDtDqLLH5p4vcROZQ6Y1NM5dg3BmN8JS10fMpXREJnL+RHG237rN1
 7TbdIy0CEZlMDJRNEVT0Nd2rSqOiiFYEJxGof0hDZIIkCUGtviGFBzHNm0hKvaQSSjDS
 7O1z/AVB7B0QV2vjU95kWD6pRm6QWZFLwL63NQoSR2cDgnBXR7Iahdn7G8g2goyS0mMp
 JGSVVrz/dMvICAs117d/1wSXt+loQJxiTdxU9vh1lfoTCaLSa9ENoY2qoTKHUHdNh7Av
 x5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684161721; x=1686753721;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3XMl/4hE9MVAxodhxUQfas2HkhWZAFZbnfixZTTNXFI=;
 b=hFo6qCHxjJfuJ1QgEydbLiZiZbJuqmRz/dwEAUnqw2hB8okFZh9TB7IxtniOaCabrf
 kM7Q6Zd9SeOQXuw370uFdYUy7ny4T7QL6x+K4nlOYG0TUeHCsGw90NL07d5K3Iw2F/rO
 YvhXZON5THwkIg3OneTIaqZDKQ+ba3F2HqjBIFMRiZi2XkgQ3seTLx0EvheCEWwNvQO5
 WW1IwyPGWfzI/cZD9z7RE+5QntSj9g14UB9zoKsej5SZLjbSwZMjqmPgZrHu5Ne9NswS
 0fzxNuu+uJuWHLrViWTKhzhCfDKpV481I1l5gy4eH+xt7kOBBoZ8+zCEEsUMTU4AVoE+
 nlcA==
X-Gm-Message-State: AC+VfDx8wi9p9TfzjSlZJrJSUXseKAX5DK0Ms1+ETP56HPtUPZBwOYzg
 oYeZxkKtthuVschJNIRJuRQ=
X-Google-Smtp-Source: ACHHUZ4ZJoqerGRH0a5uZQ9j+g3XnEF09R5I5+0hGgS2xaUYW2zD0OScg4eWx8L9LIsa9bu84fGJoQ==
X-Received: by 2002:a17:902:d304:b0:1a9:21bc:65f8 with SMTP id
 b4-20020a170902d30400b001a921bc65f8mr35534852plc.11.1684161721030; 
 Mon, 15 May 2023 07:42:01 -0700 (PDT)
Received: from [192.168.0.115] ([113.173.119.15])
 by smtp.gmail.com with ESMTPSA id
 p15-20020a1709027ecf00b001a1a07d04e6sm13700246plb.77.2023.05.15.07.41.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 May 2023 07:42:00 -0700 (PDT)
Message-ID: <3cee23fd-fae1-458b-2b8b-656a2ff3195b@gmail.com>
Date: Mon, 15 May 2023 21:41:55 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [REPOST PATCH v3 5/5] amd_iommu: report x2APIC support to the
 operating system
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, David Woodhouse <dwmw2@infradead.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20230411142440.8018-1-minhquangbui99@gmail.com>
 <20230411142440.8018-6-minhquangbui99@gmail.com>
 <20230512102159-mutt-send-email-mst@kernel.org>
 <252a0071-2ffa-87c6-a72e-d27975ddecd5@gmail.com>
 <20230514164040-mutt-send-email-mst@kernel.org>
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20230514164040-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-3.811,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 5/15/23 03:44, Michael S. Tsirkin wrote:
> On Sun, May 14, 2023 at 03:55:11PM +0700, Bui Quang Minh wrote:
>> On 5/12/23 21:39, Michael S. Tsirkin wrote:
>>> On Tue, Apr 11, 2023 at 09:24:40PM +0700, Bui Quang Minh wrote:
>>>> This commit adds XTSup configuration to let user choose to whether enable
>>>> this feature or not. When XTSup is enabled, additional bytes in IRTE with
>>>> enabled guest virtual VAPIC are used to support 32-bit destination id.
>>>>
>>>> Additionally, this commit changes to use IVHD type 0x11 in ACPI table for
>>>> feature report to operating system. This is because Linux does not use
>>>> XTSup in IOMMU Feature Reporting field of IVHD type 0x10 but only use XTSup
>>>> bit in EFR Register Image of IVHD 0x11 to indicate x2APIC support (see
>>>> init_iommu_one in linux/drivers/iommu/amd/init.c)
>>>>
>>>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>>>
>>> I'm concerned that switching to type 11 will break some older guests.
>>> It would be better if we could export both type 10 and type 11
>>> ivhd. A question however would be how does this interact
>>> with older guests. For example:
>>> https://lists.linuxfoundation.org/pipermail/iommu/2016-January/015310.html
>>> it looks like linux before 2016 only expected one ivhd entry?
>>
>> Export both type 0x10 and 0x11 looks reasonable to me. Before the above
>> commit, I see that Linux still loops through multiple ivhd but only handles
>> one with type 0x10. On newer kernel, it will choose to handle the type that
>> appears last corresponding the first devid, which is weird in my opinion.
>> +static u8 get_highest_supported_ivhd_type(struct acpi_table_header *ivrs)
>> +{
>> +	u8 *base = (u8 *)ivrs;
>> +	struct ivhd_header *ivhd = (struct ivhd_header *)
>> +					(base + IVRS_HEADER_LENGTH);
>> +	u8 last_type = ivhd->type;
>> +	u16 devid = ivhd->devid;
>> +
>> +	while (((u8 *)ivhd - base < ivrs->length) &&
>> +	       (ivhd->type <= ACPI_IVHD_TYPE_MAX_SUPPORTED)) {
>> +		u8 *p = (u8 *) ivhd;
>> +
>> +		if (ivhd->devid == devid)
>> +			last_type = ivhd->type;
>> +		ivhd = (struct ivhd_header *)(p + ivhd->length);
>> +	}
>> +
>> +	return last_type;
>> +}
> 
> Yes I don't get the logic here either.
> Talk to kernel devs who wrote this?
> 
> commit 8c7142f56fedfc6824b5bca56fee1f443e01746b
> Author: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Date:   Fri Apr 1 09:05:59 2016 -0400
> 
>      iommu/amd: Use the most comprehensive IVHD type that the driver can support
>      
>      The IVRS in more recent AMD system usually contains multiple
>      IVHD block types (e.g. 0x10, 0x11, and 0x40) for each IOMMU.
>      The newer IVHD types provide more information (e.g. new features
>      specified in the IOMMU spec), while maintain compatibility with
>      the older IVHD type.
>      
>      Having multiple IVHD type allows older IOMMU drivers to still function
>      (e.g. using the older IVHD type 0x10) while the newer IOMMU driver can use
>      the newer IVHD types (e.g. 0x11 and 0x40). Therefore, the IOMMU driver
>      should only make use of the newest IVHD type that it can support.
>      
>      This patch adds new logic to determine the highest level of IVHD type
>      it can support, and use it throughout the to initialize the driver.
>      This requires adding another pass to the IVRS parsing to determine
>      appropriate IVHD type (see function get_highest_supported_ivhd_type())
>      before parsing the contents.
>      
>      [Vincent: fix the build error of IVHD_DEV_ACPI_HID flag not found]
>      
>      Signed-off-by: Wan Zongshun <vincent.wan@amd.com>
>      Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>      Signed-off-by: Joerg Roedel <jroedel@suse.de>

I've sent a email to talk to kernel developers about this function. Here 
is the link to the email: 
https://lore.kernel.org/all/e8a87c2b-a29a-ccf9-49c6-3cfceaa208bb@gmail.com/

