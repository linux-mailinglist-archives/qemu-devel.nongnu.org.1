Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F6C709367
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 11:37:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzwXP-0005Bh-Qq; Fri, 19 May 2023 05:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzwXM-0005B3-JZ
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:36:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzwXL-0006nx-1x
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684488994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OPUNKLZa1SfgMKgjOM3a+vPnm1aRJ/OmU8bTkV7oFh8=;
 b=EcFtLIXdC2F00zs9iIDAsL5A0M/oklbsS1yaCgHNjjkK1pWatjEGd9b7/4UXCgI4oDkz6v
 wuJThs+ph7GhWVDU/fZNEKOIxo9CCW/rROnRxqilF+zea/PbgXPwI1yNEE5zLn8sfF8Xac
 7GlWXZ+7cocoT8pMnZscs/uFQG90+h4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-c8nO6zG1OgOFKvQPdiANRg-1; Fri, 19 May 2023 05:36:32 -0400
X-MC-Unique: c8nO6zG1OgOFKvQPdiANRg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-50dfa390825so1831071a12.3
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 02:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684488990; x=1687080990;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OPUNKLZa1SfgMKgjOM3a+vPnm1aRJ/OmU8bTkV7oFh8=;
 b=DbuOdOmaDNw14N43bwXPAf1/DD/7Mhy00amXmIfO9gB2VcXKqweI/hf8qfTuS1IFbJ
 ptFLpfEuN4qW1JkG8dehsCXLnMfxADtoB0S3YS89AO2gJ2uw1bwXjS94FFmNdgQ69CDA
 Ku9O7Qgt1kmEbaLfi32B694p7DA3Ht1bUMVqsiJhGb/kd054LJg0KFSWX/Vm2ydiGY+O
 wlrkQCplrQF0BvsoyCxnfRzeg8RMpi5PZlYceV7+AiYZrO/gOFvj9TdnX6AHoi8lyHdI
 66Puotvftg76hND/n3v9nDoFUvyKUG43a1ih5gBslUTDmUrJRTuqlG151KikvTQitB3r
 Tjmw==
X-Gm-Message-State: AC+VfDyXwtQcR2jh3/6VVPKDdLS/wNOclz4HTFNDtS7eooCzoth3dqY9
 mF/XRv/WykRinrGE/MOetzRgXf+hxdZmiYpEySvxnu+NWxBRVcx1we5Bpq5rqyoICxzu2rzDY7y
 a53gQ6aunvaIeUGwXhU314Ic=
X-Received: by 2002:aa7:dac6:0:b0:510:d003:3dee with SMTP id
 x6-20020aa7dac6000000b00510d0033deemr1187729eds.16.1684488990629; 
 Fri, 19 May 2023 02:36:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7eAsIPu8NX5hC3a51lLmohaWBHYxHzHbD85qcHmrQDQSLkvxUC5a5Sh6Axfa/H8pBLpM8TEQ==
X-Received: by 2002:aa7:dac6:0:b0:510:d003:3dee with SMTP id
 x6-20020aa7dac6000000b00510d0033deemr1187715eds.16.1684488990334; 
 Fri, 19 May 2023 02:36:30 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045?
 ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.googlemail.com with ESMTPSA id
 l16-20020aa7d950000000b0050bc9ffed66sm1506137eds.53.2023.05.19.02.36.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 02:36:29 -0700 (PDT)
Message-ID: <c2318be1-e69f-afde-2959-11728c81c79f@redhat.com>
Date: Fri, 19 May 2023 11:36:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 6/6] meson: subprojects: replace submodules with wrap files
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com,
 richard.henderson@linaro.org, peter.maydell@linaro.org
References: <20230519085647.1104775-1-pbonzini@redhat.com>
 <20230519085647.1104775-7-pbonzini@redhat.com> <ZGdAezBL/QBX2DzX@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <ZGdAezBL/QBX2DzX@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.544, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 5/19/23 11:25, Daniel P. Berrangé wrote:

>   * dtc - the distro should always have it anyway
>   * libvfio-user - don't think this has found its way
>                    into any distros yet. So if we don't
> 		  bundle it, distros have to pacakge it
> 		  or re-bundle with their QEMU bulds

I think it's not ABI-stable either.

>   * keycodemapdb - has always been intended to be a copylib,
>                    not packaged separately by distros. In
> 		  retrospect I think this wa probably a
> 		  mistake. None the less today, it will
> 		  need to be re-bundled by distros if we
> 		  omitted it.
> 
> I think there's a decent case to be made for 'dtc' to be dropped
> from 'make-release', but keep the other two.

Sure.

>>
>>    script:
>>      - scripts/git-submodule.sh update
>>          $(sed -n '/GIT_SUBMODULES=/ s/.*=// p' build/config-host.mak)
>> +    - meson subprojects download $(cd build/subprojects && echo *)
> 
> Why is this addition needed ?  Isn't meson supposd to automatically
> download the wrapped subprojects it needs without explicit user
> action ?

Because this is the script for the test jobs; they don't get 
subprojects/ from the build artifacts, and they don't rerun "meson 
setup" either.  So "build/subprojects" is already populated but the 
source tree does not have the downloads.

"meson test" also runs submodule tests, and they fail.  See 
https://gitlab.com/bonzini/qemu/-/jobs/4309651149#L305 for an example.

>> @@ -296,6 +296,7 @@ option('capstone', type: 'feature', value: 'auto',
>>          description: 'Whether and how to find the capstone library')
>>   option('fdt', type: 'combo', value: 'auto',
>>          choices: ['disabled', 'enabled', 'auto', 'system', 'internal'],
>> +       deprecated: { 'git': 'internal' },
>>          description: 'Whether and how to find the libfdt library')
> 
> Do we need to deprecate this, as opposed to removing it ?
> 
> We've considered build time options to not be subject to a deprecation
> process, just documenting changes in the release notes.

No issue with that.  In this case it's so easy that I didn't bother.

Paolo


