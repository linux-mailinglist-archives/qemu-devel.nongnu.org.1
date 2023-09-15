Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9687A1268
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 02:37:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgwom-0005rO-4a; Thu, 14 Sep 2023 20:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qgwoj-0005lO-Mw
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 20:36:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qgwoh-0001ll-N4
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 20:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694738174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o+QpG+hXelNlFLXeCI0bikOJeUujy0EpBnQIiHS+urc=;
 b=BfGDcuCxTkc60worgV0HVmnfHFKCSiKQmdyOQxtiUzhNkhAAur3TuBuCtlnGuYq4zgLQ5g
 Up/fQvWOc8yHis/hARr4hVreOxV2KYPJzIEyPgD4dc0uJOPNz26KRnbqy29WCysRRFpoBP
 dljY+zci0ld+TIFOak+qHX7L+3C62Vc=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-6jp8-7g1PxaEHz-aslwySg-1; Thu, 14 Sep 2023 20:36:12 -0400
X-MC-Unique: 6jp8-7g1PxaEHz-aslwySg-1
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-7a7770e5cd0so544730241.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 17:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694738172; x=1695342972;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o+QpG+hXelNlFLXeCI0bikOJeUujy0EpBnQIiHS+urc=;
 b=scRYnvWOia4rsofODAvFl6S8V3aNzdofr+3h1U/yDmYhr1SdojLsRclPm/6wQfo9QF
 JB1q6UsM2Zn/d8m4w3GjMjSES11eeig7FHEmIxcdFGpPY8n35mbji/Vpj0X64kUIVxQR
 zQmkyhHIpYO66nGtWiS04yzDmJLgnPHjZOkUMml7go4gOuHc6kaZbJWpJEgN3q7juA8P
 B07IpkXw5WPmomfPhBxCjTLXJxd9BYkoVf0tuLW+8u5V/o9mFs17VdOC83OM289l9KfY
 gxIRABNZAa6B7DIBIevisn3VJ6NBaBy272X+cX2SqIF9U87e6a44CzAx6Gai0Cmby79d
 DTvg==
X-Gm-Message-State: AOJu0Yy1Re6iojfDZuqrtfUMLkpH0bwnshfmBqmacOhoF7wcNySkCtVL
 8I/9jlRkSeIng6gAY50iGRAWP1kAKi3VGXD+xuDOK2WneNOp3me11kRwietMUQJMBeu2lE7fWFE
 Fu++hxMFgHt32e2U=
X-Received: by 2002:a05:6102:4ad:b0:44e:adc4:7eba with SMTP id
 r13-20020a05610204ad00b0044eadc47ebamr271457vsa.26.1694738172067; 
 Thu, 14 Sep 2023 17:36:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH70JbJom7I8MGlMZFLbcb/STRfhYuOWCavGZ6O8qC+lxyAcHOLAOkGE1y03m73IcWvEKErrw==
X-Received: by 2002:a05:6102:4ad:b0:44e:adc4:7eba with SMTP id
 r13-20020a05610204ad00b0044eadc47ebamr271446vsa.26.1694738171825; 
 Thu, 14 Sep 2023 17:36:11 -0700 (PDT)
Received: from ?IPV6:2600:4040:7c46:e800:32a2:d966:1af4:8863?
 ([2600:4040:7c46:e800:32a2:d966:1af4:8863])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a0c8bd2000000b0063d1f967268sm869658qvc.111.2023.09.14.17.36.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 17:36:10 -0700 (PDT)
Message-ID: <864e1a0d-207a-bf64-a474-87275dd2f930@redhat.com>
Date: Thu, 14 Sep 2023 20:36:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 0/8] i386/sev: Use C API of Rust SEV library
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, stefanha@redhat.com
References: <20230914175835.382972-1-tfanelli@redhat.com>
 <39f8528a-9f95-3bc4-07c1-91f705c7bb10@linaro.org>
From: Tyler Fanelli <tfanelli@redhat.com>
In-Reply-To: <39f8528a-9f95-3bc4-07c1-91f705c7bb10@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=tfanelli@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 9/14/23 3:04 PM, Philippe Mathieu-Daudé wrote:
> Hi Tyler,
>
> On 14/9/23 19:58, Tyler Fanelli wrote:
>> These patches are submitted as an RFC mainly because I'm a relative
>> newcomer to QEMU with no knowledge of the community's views on
>> including Rust code, nor it's preference of using library APIs for
>> ioctls that were previously implemented in QEMU directly.
>>
>> Recently, the Rust sev library [0] has introduced a C API to take
>> advantage of the library outside of Rust.
>>
>> Should the inclusion of the library as a dependency be desired, it can
>> be extended further to include the firmware/platform ioctls, the
>> attestation report fetching, and more. This would result in much of
>> the AMD-SEV portion of QEMU being offloaded to the library.
>>
>> This series looks to explore the possibility of using the library and
>> show a bit of what it would look like. I'm looking for comments
>> regarding if this feature is desired.
>>
>> [0] https://github.com/virtee/sev
>>
>> Tyler Fanelli (8):
>>    Add SEV Rust library as dependency with CONFIG_SEV
>>    i386/sev: Replace INIT and ES_INIT ioctls with sev library 
>> equivalents
>>    i386/sev: Replace LAUNCH_START ioctl with sev library equivalent
>>    i386/sev: Replace UPDATE_DATA ioctl with sev library equivalent
>>    i386/sev: Replace LAUNCH_UPDATE_VMSA ioctl with sev library 
>> equivalent
>>    i386/sev: Replace LAUNCH_MEASURE ioctl with sev library equivalent
>>    i386/sev: Replace LAUNCH_SECRET ioctl with sev library equivalent
>>    i386/sev: Replace LAUNCH_FINISH ioctl with sev library equivalent
>
> There is still one ioctl use, GET_ATTESTATION_REPORT. No libsev
> equivalent for this one yet?
>
There is an equivalent, however the machine that I'm using currently 
hangs when trying to fetch an attestation report (not a libsev issue, as 
it hangs when I try with latest qemu release as well). When I can either 
update its firmware or get access to another SEV machine, I can test and 
confirm it behaves as intended with the libsev API. Once this is done, I 
can add that API to the patch series.


Tyler


