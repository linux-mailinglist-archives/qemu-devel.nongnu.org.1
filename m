Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE93F78B527
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 18:13:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaeqC-0008Ql-0x; Mon, 28 Aug 2023 12:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qaeq9-0008QD-Lf
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 12:11:45 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qaeq7-0000r6-2F
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 12:11:45 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3ff1c397405so32879545e9.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 09:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693239100; x=1693843900;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=08PzhBscWwB3w7cD2WkicEwpu0p53gGJQxSqE96Z6QM=;
 b=hMqfqrMLKaZVI70LjpgXlvqCW18shSnjJ5qwbGXrnifsvwf57hHNwjSBKjwPFS3Rtx
 /HV2FEGdV7V0ptLL0XMDxaR0bYx+hop5Fdn9OA5xKaCu2wXv28o8B9QRLfp4IAAcHdtX
 eX1b6zPN4irxzhAYI8dNIiqZDXHOcLjNBOHD4o4aBCd5uneyr1Eod4fUyrlMNQBg2PoM
 Yu8bNWPylRQWFhWvAJNAsk61tISLAMPmzK8NFNHJKMMGLkl3L6Fcvhe9fRB4RSdnAz8K
 vBmfDtjQGEIkx+ewSAJS4ycjg6QE1VhCNQCWLGy55LLf7ANGSNx2Zgk0x1SDpDHS5+H0
 37zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693239100; x=1693843900;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=08PzhBscWwB3w7cD2WkicEwpu0p53gGJQxSqE96Z6QM=;
 b=NfM/I+aQ8dp2Rkj3rEdf0+4LvgomPfJko5rEmXsN+UACf8PzMK93gXJwwfwkGh2LZo
 VyTn6+3Z2eH927o/g5RgKtus4uYJ+ge+I1xuiSvUsG7I8105MMp6Wo1pst5TJX3QQE3+
 uMPYc5EL7QIG1r7VPCqgESL54fQjVpkfwBx7RJLx3pN8lJ1dU7jkqLNsf3TDgFRZsFBe
 Hnq7IHEPXfBbZzRhiaE4xl7G2/2FdTUcYnQ1ahNzFVdczYPXtHBE8ZHha5WBvZcLdOIZ
 YOYo8EuhwC36Q46xoTW6ee3pGRZa3/V8ONQwrdPThjkv/UQol0vElq3zqEPKyqHkguzT
 MGrw==
X-Gm-Message-State: AOJu0Yxgmncr0ytEIaBF+exJ0AAt+1XAiSEGWrQQwTyUE58NLcVQ+eK0
 eLW3SVNAZTVvnfv8YPImBgrCGg==
X-Google-Smtp-Source: AGHT+IEMvoqgZaGq+RwyzcGD/qr3abZbR+/HnKvPtmoLWLuQvxAN+gSanPVMni30C4jvSw0RqQduTw==
X-Received: by 2002:a7b:cc86:0:b0:401:b2c7:34a4 with SMTP id
 p6-20020a7bcc86000000b00401b2c734a4mr8444620wma.11.1693239100152; 
 Mon, 28 Aug 2023 09:11:40 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.201.64])
 by smtp.gmail.com with ESMTPSA id
 25-20020a05600c22d900b00401c944b7adsm4627942wmg.26.2023.08.28.09.11.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 09:11:39 -0700 (PDT)
Message-ID: <ef6a2f21-ebc2-44ae-ea5f-04f960c6d756@linaro.org>
Date: Mon, 28 Aug 2023 18:11:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] hw/net/rocker: avoid NULL pointer dereference in
 of_dpa_cmd_add_l2_flood
Content-Language: en-US
To: Mauro Matteo Cascella <mcascell@redhat.com>, qemu-devel@nongnu.org
Cc: jiri@resnulli.us, jasowang@redhat.com, arayz_w@icloud.com
References: <20220624143912.1234427-1-mcascell@redhat.com>
 <CAA8xKjXvhnAyHDH43xcg9_HRqNqf04QhTpcrB2s4ae1d_WWuxw@mail.gmail.com>
 <CAA8xKjVyqbJrkdL-DF0=DsDWFKOkJqqwUa-5kAyn8n+qp2u8iQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAA8xKjVyqbJrkdL-DF0=DsDWFKOkJqqwUa-5kAyn8n+qp2u8iQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.169,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 27/8/23 13:07, Mauro Matteo Cascella wrote:
> On Sat, Aug 26, 2023 at 4:31 PM Mauro Matteo Cascella
> <mcascell@redhat.com> wrote:
>>
>> On Fri, Jun 24, 2022 at 4:40 PM Mauro Matteo Cascella
>> <mcascell@redhat.com> wrote:
>>>
>>> rocker_tlv_parse_nested could return early because of no group ids in
>>> the group_tlvs. In such case tlvs is NULL; tlvs[i + 1] in the next
>>> for-loop will deref the NULL pointer.
> 
> Looking at the code once again, tlvs is a pointer to a g_new0
> allocated memory, so I don't know how it can be NULL after
> rocker_tlv_parse_nested (unless g_new0 returns NULL in the first
> place). I do not recall the details of this bug. Arayz?

Per <glib.h>:

   If any call to allocate memory using functions g_new(), g_new0(),
   g_renew(), g_malloc(), g_malloc0(), g_malloc0_n(), g_realloc(), and
   g_realloc_n() fails, the application is terminated. This also means
   that there is no need to check if the call succeeded. On the other
   hand, g_try_...() family of functions returns NULL on failure that
   can be used as a check for unsuccessful memory allocation. The
   application is not terminated in this case.


group->l2_flood.group_count is a uint16_t, so up to UINT16_MAX = 0xffff.

So:

   tlvs = g_new0(RockerTlv *, group->l2_flood.group_count + 1);

is at most an malloc(0x10000 * sizeof(void *)) = 0x80000 = 512 KiB.

QEMU use way bigger heap allocations.

I don't know the net/ subsystem enough to have an idea about how many
concurrent packets can be processed by this device model, but I'd be
surprised if this triggers a OOM.

As usual, do you have a reproducer?

>> Someone somehow reserved a new CVE for this bug, published a few days
>> ago here: https://nvd.nist.gov/vuln/detail/CVE-2022-36648.
>>
>> Not only is this not CVE worthy (rocker code does not fall under the
>> KVM virtualization use case [1]) but what's most concerning is that it
>> got a CVSS score of 10 :/
>>
>> I'm going to dispute this CVE. Hopefully, it will be rejected soon. In
>> any case, can we get this patch merged?
>>
>> [1] https://www.qemu.org/docs/master/system/security.html
>>
>> Thanks,
>>
>>> Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
>>> Reported-by: <arayz_w@icloud.com>
>>> ---
>>>   hw/net/rocker/rocker_of_dpa.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/hw/net/rocker/rocker_of_dpa.c b/hw/net/rocker/rocker_of_dpa.c
>>> index b3b8c5bb6d..1611b79227 100644
>>> --- a/hw/net/rocker/rocker_of_dpa.c
>>> +++ b/hw/net/rocker/rocker_of_dpa.c
>>> @@ -2039,6 +2039,11 @@ static int of_dpa_cmd_add_l2_flood(OfDpa *of_dpa, OfDpaGroup *group,
>>>       rocker_tlv_parse_nested(tlvs, group->l2_flood.group_count,
>>>                               group_tlvs[ROCKER_TLV_OF_DPA_GROUP_IDS]);
>>>
>>> +    if (!tlvs) {
>>> +        err = -ROCKER_EINVAL;
>>> +        goto err_out;
>>> +    }
>>> +
>>>       for (i = 0; i < group->l2_flood.group_count; i++) {
>>>           group->l2_flood.group_ids[i] = rocker_tlv_get_le32(tlvs[i + 1]);
>>>       }
>>> --
>>> 2.35.3
>>>
>>
> 


