Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8257655B5
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 16:16:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP0y5-0007Da-OI; Thu, 27 Jul 2023 09:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1qP0y3-0007DS-Ej
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 09:23:47 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1qP0y0-0002Kn-Ck
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 09:23:47 -0400
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-686ba29ccb1so582396b3a.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 06:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1690464220; x=1691069020;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qRnwMvOZIRuUFJ6Biq51cRwCE9GKelaYEx3Mhzz1Nis=;
 b=W/78D46bwWZ2ezY1yTxf3Osb3CTbs2jGfx4HdQYTYr0DxirHux5ICuCh5VcQxCdfog
 8UBFqjLMo5DZX9Fto+R45EBLKt5k71U0eUTTeDnHk1uRjgVGRL3XdLOrO3jwSGVXwF66
 EG3ctms/7CR0ZG5YqWNp7V8KPneCPLlWSIFy5jfMaaNGx8wJ43mhRm8JUksEf6YfBLnp
 o82OuPXIrIFu74OtXAt2UmBj1xSjCsGOmVn7FdIPCsPLxE4hgtedWLF4nVz985z/gBFh
 XhZj6dMOcNtMjtuAtJ1Gr/TQTSVVTZcBxQUG+/1+L6oMecS30tpPMKAimr2L2tceTKNm
 Ej2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690464220; x=1691069020;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qRnwMvOZIRuUFJ6Biq51cRwCE9GKelaYEx3Mhzz1Nis=;
 b=jFrlmpX3+9kAJvusVGMT+NSEaN5Lr9M5EoFxX15BEeQAOspp1OfdzfWoI2cCItWjyx
 h66a8b+HST7kw4crq/sOInfaV6c8IkjowYRjW2x/758V/P/NEpxF0VvPk5URf6I/5GL4
 VqfE/dPib2wQhSK5s/PsReYMekT90wz4oHpPy8DYOL0wcVJMVLlb+kMd03JNDe0U6OQT
 N3WDaHDQLX5rAB7ImNXm9crV4gD6aoTaZ+aSUwTnsjkYMJlmfu7jFDcjiMIOBr5hDAAY
 poHnLsa+ZXDqBhqqFsRzmFjIKidgFpZUHBpmLip4bvcNk7T4/XncvVkEnYPRCA4kRSwx
 LDYA==
X-Gm-Message-State: ABy/qLZLH9gf/k4498u5zp1Fe6F1wHn6PZnlaSETmsv61qoCd8E1V7r3
 C1ZJt0d3NTPkQR5/ElDAM9ZDjQ==
X-Google-Smtp-Source: APBJJlFaq3Ws9gPhY/TXlBGtgipLaNtz0jK0wVtsi3K64MGKEPo0XnbOKlXDIuBI6DFssARLNOnegg==
X-Received: by 2002:a05:6a20:441e:b0:133:7ad8:71b5 with SMTP id
 ce30-20020a056a20441e00b001337ad871b5mr3961428pzb.0.1690464219688; 
 Thu, 27 Jul 2023 06:23:39 -0700 (PDT)
Received: from [10.254.120.136] ([139.177.225.229])
 by smtp.gmail.com with ESMTPSA id
 f17-20020a635551000000b00563ea47c948sm1439915pgm.53.2023.07.27.06.23.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 06:23:38 -0700 (PDT)
Message-ID: <9343c790-7fa6-1f1e-ed1c-2f350de44ec9@bytedance.com>
Date: Thu, 27 Jul 2023 21:23:34 +0800
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
 <ZMJoumdi54neHzkC@x1n>
From: hongmainquan <hongmianquan@bytedance.com>
In-Reply-To: <ZMJoumdi54neHzkC@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=hongmianquan@bytedance.com; helo=mail-pf1-x442.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



在 2023/7/27 8:53 下午, Peter Xu 写道:
> On Thu, Jul 27, 2023 at 11:59:43AM +0800, hongmainquan wrote:
>>
>>
>> 在 2023/7/27 1:45 上午, Peter Xu 写道:
>>> On Tue, Jul 25, 2023 at 07:20:37PM +0800, hongmianquan wrote:
>>>> When updating ioeventfds, we need to iterate all address spaces,
>>>> but some address spaces do not register eventfd_add|del call when
>>>> memory_listener_register() and they do nothing when updating ioeventfds.
>>>> So we can skip these AS in address_space_update_ioeventfds().
>>>>
>>>> The overhead of memory_region_transaction_commit() can be significantly
>>>> reduced. For example, a VM with 8 vhost net devices and each one has
>>>> 64 vectors, can reduce the time spent on memory_region_transaction_commit by 20%.
>>>>
>>>> Signed-off-by: hongmianquan <hongmianquan@bytedance.com>
>>>
>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>>
>>> Should be for 8.2, though.  Please always copy Paolo for memory related
>>> patches.  I hope Paolo can see this.
>>>
>> Thanks, I hope so. Also, I'm not quite sure what 'Should be for 8.2' means.
>> Does it imply that there will be changes to this logic after version 8.2?
> 
> See:
> 
> https://wiki.qemu.org/Planning/8.1
> 
> We're already right before 8.1-rc2 release, perf patch isn't normally the
> target of this phase.
> 
> Thanks,
> 
Understood. Hope for some suggestions from you.

Thanks!

