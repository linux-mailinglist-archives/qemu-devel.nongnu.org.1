Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 290DC78C640
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 15:39:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qayvx-0001JH-6k; Tue, 29 Aug 2023 09:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qayvu-0001Iz-SM
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:39:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qayvs-0001t6-Ee
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 09:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693316339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9MV5QN/nwwTwVGMgLxuZe9W17MTFllI2rrQb4dxnmNY=;
 b=LP8aOtomF60m2Egu7tjSq4bvlB/pHy1+KX+4ihMf/MTp08m/MjhYP0Q80IUO5of+Z4b1YG
 p0kbrrpyUEohpk92fEAOUKu7FWArA11/YR6+pYkXqoBGd1RdciwNG6M5YbJ+5ZDf3iyyU0
 rpKeWLswx4Sr+WaKfCpA1qH6fFPs9O4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-7qCjeDCvOMefIjzfVp_l-Q-1; Tue, 29 Aug 2023 09:38:57 -0400
X-MC-Unique: 7qCjeDCvOMefIjzfVp_l-Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-401db2550e0so1365355e9.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 06:38:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693316337; x=1693921137;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9MV5QN/nwwTwVGMgLxuZe9W17MTFllI2rrQb4dxnmNY=;
 b=h9lkngklxCso7Ed30EhF6wYg0ynqspZQPp7cPpl1yPq98xhRWYPtfAxPFpT8/Z+3ni
 dsXnvWxKykumebA9SoXbKk5rDJlJxSU8pc95QvDloOnTx3TSEY9X+wVURRhAZpb8UAUI
 FNX6MG/Z3Y14v2J8XPRbivQr7Gu+MoDigF7RogaFg9q/iFiqrZ1Z4jCyOrxC+Zn1qLJI
 tzt625tQpFFXkcaWXX18YWdzn72GgrN5YuaQZamZuBPb/3uiu+3Kp1FzXKzldF+FF7XH
 pN80OCmzIGqjAPisuzdh4rsQDDsgCB4wx+xJ9g1mWIwP2Ri5xbO14yyyxq6yqz/Qb3/R
 syGA==
X-Gm-Message-State: AOJu0YzA5m8Ebsjnjl1IvpjWoIH1UUf6l4nXWETFVp6+lVpPVhurrpsC
 H1r3cpjINChxfl3lludd03tvTsbm17l73FxYcjab5rUqLw4orZHra7FF4CeygHwwt3N/9ujJ0Jj
 IdqM27my23BFW7bc=
X-Received: by 2002:a7b:c7c3:0:b0:3fe:795:712a with SMTP id
 z3-20020a7bc7c3000000b003fe0795712amr21742802wmk.27.1693316336832; 
 Tue, 29 Aug 2023 06:38:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPnYlijn90mwJ1IR9efPDX7yROmw4z1bwqw6nkv6v1OQIWNgadHk7M1C8DKoGIJKHTG0yWNw==
X-Received: by 2002:a7b:c7c3:0:b0:3fe:795:712a with SMTP id
 z3-20020a7bc7c3000000b003fe0795712amr21742776wmk.27.1693316336486; 
 Tue, 29 Aug 2023 06:38:56 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-58.web.vodafone.de.
 [109.43.179.58]) by smtp.gmail.com with ESMTPSA id
 l12-20020a7bc44c000000b003fbc0a49b57sm14054470wmi.6.2023.08.29.06.38.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 06:38:55 -0700 (PDT)
Message-ID: <6b0374d7-a950-8f11-caae-c80ac7fe7b3c@redhat.com>
Date: Tue, 29 Aug 2023 15:38:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH-for-8.1] accel: Remove HAX accelerator
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 libvir-list@redhat.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20230623230837.4194-1-philmd@linaro.org>
 <94bbfa23-836c-5e8c-db3b-2b040f3326a6@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <94bbfa23-836c-5e8c-db3b-2b040f3326a6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.242, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 24/06/2023 01.12, Philippe Mathieu-Daudé wrote:
> On 24/6/23 01:08, Philippe Mathieu-Daudé wrote:
>> HAX is deprecated since commits 73741fda6c ("MAINTAINERS: Abort
>> HAXM maintenance") and 90c167a1da ("docs/about/deprecated: Mark
>> HAXM in QEMU as deprecated"), released in v8.0.0.
>>
>> Per the QEMU deprecation policy, we shouldn't remove it before
>> QEMU release v8.2.0. However per the latest HAXM release (v7.8),
>> the latest QEMU supported is v7.2:
>>
>>    Note: Up to this release, HAXM supports QEMU from 2.9.0 to 7.2.0.
>>
>> (https://github.com/intel/haxm/releases/tag/v7.8.0)
>>
>> The next commit (https://github.com/intel/haxm/commit/da1b8ec072)
>> added:
>>
>>    HAXM v7.8.0 is our last release and we will not accept
>>    pull requests or respond to issues after this.
>>
>> As of commit b455ce4c2f, it became very hard to build and test
>> HAXM. Its previous maintainers made it clear they won't help.
>> It doesn't seem to be a very good use of QEMU maintainers to
>> spend their time in a dead project. Save our time by removing
>> this orphan zombie code before the QEMU v8.2 release.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
> 
> 
>> diff --git a/docs/about/removed-features.rst 
>> b/docs/about/removed-features.rst
>> index 5b258b446b..cc8a1e38a9 100644
>> --- a/docs/about/removed-features.rst
>> +++ b/docs/about/removed-features.rst
>> @@ -659,15 +659,18 @@ Use ``Icelake-Server`` instead.
>>   System accelerators
>>   -------------------
>> -Userspace local APIC with KVM (x86, removed 8.0)
>> +Userspace local APIC with KVM (x86, removed in 8.0)
>>   ''''''''''''''''''''''''''''''''''''''''''''''''
> 
> Oops I didn't mean to commit this line. The doc won't build with padding.

  Hi Philippe,

now that 8.1 has been released, could you please update your patch by 
removing this bad hunk and by updating the commit description?

  Thanks,
   Thomas


