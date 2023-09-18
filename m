Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA43D7A4DC2
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 17:59:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiGdp-0002Jn-GO; Mon, 18 Sep 2023 11:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiGdo-0002Jf-22
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 11:58:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiGdm-00033n-JW
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 11:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695052705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LCCQ1vY427GMtYNLvj+OPAaznsbJmVnsgT5I8sYKAg4=;
 b=EIsgnYGuEBiugfhkdslDUNqu8IplEGrJIfqGIHJDg2MSgZXkNkF8VWJjD60l2Tj9tW1ZdN
 MXHNhWmjZ9TyT7PgQNTjPM4cUNYpjlh1gF94ZrydLkQle3OoIHO8yoXUozL8UtZJzXmAPh
 8tYWIkvqMAnzVC52tA7LgCUl71n/XlI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-_dgLNAstMhKgjOnoys8Vvw-1; Mon, 18 Sep 2023 11:58:24 -0400
X-MC-Unique: _dgLNAstMhKgjOnoys8Vvw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4011f56165eso23966645e9.0
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 08:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695052702; x=1695657502;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LCCQ1vY427GMtYNLvj+OPAaznsbJmVnsgT5I8sYKAg4=;
 b=A+B/nxXNzD/HKZgWPVguH23/xwS95VPduNM7JI1LR/R86lTRngFp3lJlFkdKv2oxSB
 t89i/sB3WLMFM1mXg4S3EOHQSCwB5etyAX/VHEI4tUppZlaf3y09tyfyBAaxI1YbDzlk
 UGYmAU3u4Ro18Mm3L4z0yBn7wDAb8CoV/QXgi70j3fcFhxqa9ZalxJc55XKYMFaLWblO
 YwgUn3Gz84rowP3f7paOcocpsBMf2Mux0YQKVKakngcTUae+PRZC6F7Web4bbvZsFWLu
 ISyS/8AV7YyI+NRC8ajlN0XCT0BsHE59xrg1Uuqv5zMeVn5j5nkPvqbq1EsUZosnkzJj
 zukg==
X-Gm-Message-State: AOJu0YxP4QrJhV4CXxAA8OYR6iFPl9nQwHyZzhhpSOrUltvmWaiioTSG
 pj99KtR6blzbGnt+/UMFlk5CO5eSlv62xTcSdmZPCAiZhem4w52Hq0gM8vX76wDo2FAVsIG0IMZ
 78a5WWFiIMlyjRfs=
X-Received: by 2002:a1c:4c03:0:b0:401:b3a5:ec04 with SMTP id
 z3-20020a1c4c03000000b00401b3a5ec04mr24190wmf.16.1695052702076; 
 Mon, 18 Sep 2023 08:58:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh3ZOkD5o4VSkq8op8OvP/NqIAR2ZZSh6ikthm6RZMztk/oRvT7YdKB3K14dTl25z3/u3raQ==
X-Received: by 2002:a1c:4c03:0:b0:401:b3a5:ec04 with SMTP id
 z3-20020a1c4c03000000b00401b3a5ec04mr24174wmf.16.1695052701591; 
 Mon, 18 Sep 2023 08:58:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:9d00:cf36:8603:a1f5:d07?
 (p200300cbc7029d00cf368603a1f50d07.dip0.t-ipconnect.de.
 [2003:cb:c702:9d00:cf36:8603:a1f5:d07])
 by smtp.gmail.com with ESMTPSA id
 w11-20020a5d608b000000b0031ad5fb5a0fsm4714462wrt.58.2023.09.18.08.58.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Sep 2023 08:58:21 -0700 (PDT)
Message-ID: <3a3b5c4a-afad-8362-088c-a531d6998c23@redhat.com>
Date: Mon, 18 Sep 2023 17:58:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] hw/i386/pc: fix max_used_gpa for 32-bit systems
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, philmd@linaro.org,
 qemu-devel@nongnu.org
References: <20230918135448.90963-1-anisinha@redhat.com>
 <CAK3XEhOMqdfyPBm0ZgkirrcaBhOwQt_eOZ7=bbdW8OJpz3hWHg@mail.gmail.com>
 <ceea0d9d-19d6-29e7-cb84-81f85936b8c2@redhat.com>
 <CAK3XEhNETZBGtzpv2vBzygQtYuzTrsihzQNRdK8kp3+_u590Rg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAK3XEhNETZBGtzpv2vBzygQtYuzTrsihzQNRdK8kp3+_u590Rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
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

On 18.09.23 17:56, Ani Sinha wrote:
> On Mon, Sep 18, 2023 at 8:59 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 18.09.23 17:22, Ani Sinha wrote:
>>> On Mon, Sep 18, 2023 at 7:25 PM Ani Sinha <anisinha@redhat.com> wrote:
>>>>
>>>> 32-bit systems do not have a reserved memory for hole64 but they may have a
>>>> reserved memory space for memory hotplug. Since, hole64 starts after the
>>>> reserved hotplug memory, the unaligned hole64 start address gives us the
>>>> end address for this memory hotplug region that the processor may use.
>>>> Fix this. This ensures that the physical address space bound checking works
>>>> correctly for 32-bit systems as well.
>>>
>>> This patch breaks some unit tests. I am not sure why it did not catch
>>> it when I tested it before sending.
>>> Will have to resend after fixing the tests.
>>
>> Probably because they supply more memory than the system can actually
>> handle? (e.g., -m 4g on 32bit)?
> 
> cxl tests are failing for example.
> 
> $ ./qemu-system-i386 -display none -machine q35,cxl=on
> qemu-system-i386: Address space limit 0xffffffff < 0x1000fffff
> phys-bits too low (32)

CXL with 32bit CPUs ... it might be reasonably to just disable such 
tests. Certainly does not exist in real HW ... :)

-- 
Cheers,

David / dhildenb


