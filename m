Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6204B765713
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 17:11:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP2Ua-0005Vb-Ds; Thu, 27 Jul 2023 11:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1qP2UX-0005VR-BD
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 11:01:25 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1qP2UT-0007bv-Mw
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 11:01:25 -0400
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-1bbc87ded50so6604615ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 08:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1690470077; x=1691074877;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iRWK6ygy06rNOEjm7GCUqQ3DCzqL6uSA+9qt1p+cOOc=;
 b=h4YJqzXux+fxWB6uvoVmdB15o60GJSCMTvniJCIaGM4yA/ltLtWqYiP/ScT17eyN1w
 krCQcmFreJqUZxWIF6Ql7PufKVVOzKTWc7qj0mwuQmZJiDdywHaLcaLZ+ABTRemvjCcx
 02gPDzVoFF4NSLhBBJUT8AnvHZa1MAAE+kxey413H/TCFnptxA9emhhQdYGG2ciQqV4c
 YwD60a6p96+wSKCUP5/hsiwBMvplIJER5IccnWmsms/UyJThf7t25jy+ZsBLxQ1h/bMC
 Y8mtpXAwkXBoui/YKoKIyjgbPPlAtlHdCGhMYOK+eGkWsoZ6Xxbk1Eciq7BbDodeJzSz
 igmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690470077; x=1691074877;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iRWK6ygy06rNOEjm7GCUqQ3DCzqL6uSA+9qt1p+cOOc=;
 b=BWMArBKYlFLrTn1te81J0XKADiPTEW0AYIKpiZL0cXkYGsGasaUrup6DLWJff1KAcS
 lTBo54DkQ+6UeqmrpZqRmwWJWcfw2CCwghNwzKUpdDLIYpt9AIzyCkmDJwibe0Otxxoh
 0SVq2r+SkKbulDNT1QDjA8keIe/GOUrD0a/SnVegGrLaEBPWyG+Wa8fhtKJEs5UqBwIw
 UORlRUpMAlMxJh7VDIfAaPcK7olZqt9hxEWfnVWBW77NfyHbnn0kilOyqt99BQM/eVTc
 0XfKzAsWytbErxIm238RpdcC5h61C7L8CC/knNJHI1kMAey4c2fipORg4EqQOWqsHzBU
 7bVQ==
X-Gm-Message-State: ABy/qLaeP5qfWO444EQfv6SPLikcjkhsA3unFJQVRTsXUJfvtCIhrju4
 wcO+HhmM4Xw2dUEqiNeWwkEpww==
X-Google-Smtp-Source: APBJJlGXtnCpyPQulAt0c8IVhHQuwPTauzYivaOCJ20f4SRxsrTgEmIZzyFBdSOgqsQMzrgO0FTVwg==
X-Received: by 2002:a17:903:2305:b0:1b8:1687:b53 with SMTP id
 d5-20020a170903230500b001b816870b53mr6034399plh.26.1690470076491; 
 Thu, 27 Jul 2023 08:01:16 -0700 (PDT)
Received: from [10.254.120.136] ([139.177.225.229])
 by smtp.gmail.com with ESMTPSA id
 jk17-20020a170903331100b001bbce3d4774sm1765292plb.79.2023.07.27.08.01.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 08:01:15 -0700 (PDT)
Message-ID: <7a99b6f6-43ca-6804-3cea-c10f5bce6f8f@bytedance.com>
Date: Thu, 27 Jul 2023 23:01:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH] memory: avoid updating ioeventfds for some
 address_space
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, david@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230725112037.1762608-1-hongmianquan@bytedance.com>
 <ZMFbxFnv82AWlzLD@x1n> <35f53340-dda3-c25d-41c7-b717da6a9121@bytedance.com>
 <ZMJoumdi54neHzkC@x1n> <9343c790-7fa6-1f1e-ed1c-2f350de44ec9@bytedance.com>
 <ZMKA1n+8tmQC4JLA@x1n>
From: hongmainquan <hongmianquan@bytedance.com>
In-Reply-To: <ZMKA1n+8tmQC4JLA@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=hongmianquan@bytedance.com; helo=mail-pl1-x644.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SCC_BODY_URI_ONLY=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



在 2023/7/27 10:36 下午, Peter Xu 写道:
> On Thu, Jul 27, 2023 at 09:23:34PM +0800, hongmainquan wrote:
>>
>>
>> 在 2023/7/27 8:53 下午, Peter Xu 写道:
>>> On Thu, Jul 27, 2023 at 11:59:43AM +0800, hongmainquan wrote:
>>>>
>>>>
>>>> 在 2023/7/27 1:45 上午, Peter Xu 写道:
>>>>> On Tue, Jul 25, 2023 at 07:20:37PM +0800, hongmianquan wrote:
>>>>>> When updating ioeventfds, we need to iterate all address spaces,
>>>>>> but some address spaces do not register eventfd_add|del call when
>>>>>> memory_listener_register() and they do nothing when updating ioeventfds.
>>>>>> So we can skip these AS in address_space_update_ioeventfds().
>>>>>>
>>>>>> The overhead of memory_region_transaction_commit() can be significantly
>>>>>> reduced. For example, a VM with 8 vhost net devices and each one has
>>>>>> 64 vectors, can reduce the time spent on memory_region_transaction_commit by 20%.
>>>>>>
>>>>>> Signed-off-by: hongmianquan <hongmianquan@bytedance.com>
>>>>>
>>>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>>>>
>>>>> Should be for 8.2, though.  Please always copy Paolo for memory related
>>>>> patches.  I hope Paolo can see this.
>>>>>
>>>> Thanks, I hope so. Also, I'm not quite sure what 'Should be for 8.2' means.
>>>> Does it imply that there will be changes to this logic after version 8.2?
>>>
>>> See:
>>>
>>> https://wiki.qemu.org/Planning/8.1
>>>
>>> We're already right before 8.1-rc2 release, perf patch isn't normally the
>>> target of this phase.
>>>
>>> Thanks,
>>>
>> Understood. Hope for some suggestions from you.
> 
> No further suggestion from my side. You can just keep an eye on this patch
> after the 8.1 release - it probably just won't get merged before that.
> 
> Some maintainers prefer a resend after the release, but many don't.  It's
> optional in this case I think.
> 
> Thanks,
> 
Got it, thank you very much!

