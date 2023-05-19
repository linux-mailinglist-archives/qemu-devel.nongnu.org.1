Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F036C709EBB
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 20:04:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q04SV-00012E-CI; Fri, 19 May 2023 14:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q04ST-000116-39
 for qemu-devel@nongnu.org; Fri, 19 May 2023 14:04:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q04SR-0007F2-F8
 for qemu-devel@nongnu.org; Fri, 19 May 2023 14:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684519442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MfNEPA255UvNC/uHjSqpDELH9Hq+ohd2X5AGJbCSces=;
 b=XbI7G8v5UYmHV7LtoxvMRwE/1333NjKZe7P9Z2SGoABlDLLcDlk5dHUpOkQFLYT8RB44In
 jt3NmSQTjjkky6Zd5W1OwsRlMFC5mpK6ctY4/Coc9eETxk45piveNQq8oxDANAnJx/8Fwv
 LYKZXkTKGhjlA8q5QekQ3sNZgYOIQU8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-67sa9ek-Nr2g1k_R5v6oKg-1; Fri, 19 May 2023 14:04:01 -0400
X-MC-Unique: 67sa9ek-Nr2g1k_R5v6oKg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5118fc8abd0so758734a12.1
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 11:04:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684519440; x=1687111440;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MfNEPA255UvNC/uHjSqpDELH9Hq+ohd2X5AGJbCSces=;
 b=LamS8gaM0vZ7cVC8kYa+TN8WiiiF0JsTGM2chVSR+L+SfTaVRBmXC4QBpKGCf5O3xQ
 SfW0EwJsHDY9rZnV31raBYPFQN2fLuboM08JGGJ+XcfnsdCjnzc4SPhxSJgyUIkVM5OK
 brEzOVHCwhUFBLvEfFpdQvlZ0C1iJ8KEciDTpyZE5XU5MnDrwoz1VYzUELslFv+gm2q/
 EYaQHCHYNbWpaLj8uHnjYmXOS8OuEihAC8VmwwwvSEy766oJWPzFOidGnM4OMn2gr7zR
 IAmcPdJWRFmYaL4tdY+T3hyxOBsSRKtBr/woTQwBDEUrpkhkdIqsosoeOG5jDkYEtouX
 Kmgg==
X-Gm-Message-State: AC+VfDxKjXKfaoH1TkuPVRz9gnyT3CdZ1zTemlarbufqoGklSGndjnSw
 4azAmWn0wRMISzjRKeHMHEDM6rVG/SWEcf/jgMqio0AHywiys0Q9UD2EGGwh1VvYAdy57F5gd0k
 azleQcfRyxFFe1eo=
X-Received: by 2002:aa7:d295:0:b0:510:ee0f:1eab with SMTP id
 w21-20020aa7d295000000b00510ee0f1eabmr1974898edq.41.1684519440072; 
 Fri, 19 May 2023 11:04:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4jwBkrs30ljZ3XsHKewjbrCuYV6ISxDD6XXsZrOUXNgp+Rsm9OP0+4DFB70I6Hopa7SVvzZA==
X-Received: by 2002:aa7:d295:0:b0:510:ee0f:1eab with SMTP id
 w21-20020aa7d295000000b00510ee0f1eabmr1974885edq.41.1684519439659; 
 Fri, 19 May 2023 11:03:59 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89?
 ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.googlemail.com with ESMTPSA id
 n2-20020a50c202000000b005067d6b06efsm16883edf.17.2023.05.19.11.03.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 11:03:59 -0700 (PDT)
Message-ID: <c2eed4ee-18e5-19b4-0a11-168fad0618b1@redhat.com>
Date: Fri, 19 May 2023 20:03:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PULL v3 00/68] i386, build system, KVM changes for 2023-05-18
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <20230518114025.1006732-1-pbonzini@redhat.com>
 <CAFEAcA-ZtAHC2frNzVymYf9pufyi6Y1wHeLnKLrne7NaTeqNfw@mail.gmail.com>
 <CABgObfbk=8Uq3gN1dThxq3jJOAEk_cGu0Y4bvRtvdR9xZ2xtxw@mail.gmail.com>
 <CAFEAcA_4_JD46CxkT2dcXSLHKNsa7kKYPYJkqEzZERDTK_wx-A@mail.gmail.com>
 <379845d1-7a4e-a0eb-345c-451b17e77638@redhat.com>
 <CAFEAcA-cWzw-heK7y83=ZnSG7Kd_NUiayOrm6Zz6jRADB1-Nfg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CAFEAcA-cWzw-heK7y83=ZnSG7Kd_NUiayOrm6Zz6jRADB1-Nfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.527, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 5/19/23 19:45, Peter Maydell wrote:
> On Fri, 19 May 2023 at 18:31, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 5/19/23 19:01, Peter Maydell wrote:
>>>> Can you send your config-host.mak after a failed rebuild? I think
>>>> what's happening is that the path to meson has changed but Makefile
>>>> still tries the old one (which could be the system meson in
>>>> /usr/bin).
>>>
>>> Attached; it has
>>> MESON=/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/pyvenv/bin/meson
>>>
>>>   That meson says: $
>>> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/pyvenv/bin/meson --version>
>>> 1.1.0 is neither the system meson (which is 0.61.2) nor the version
>>> the build system wants (0.63.0) nor the version that it complains
>>> that it's found (0.61.5), so I'm not sure what's going on there...
>>
>> 1.1.0 must be something you have cached somewhere
> 
> Well, I've never done anything with meson except use whatever
> the QEMU build system provides...
> 
>> but 0.61.5 comes from
>> the old submodule.  You should be able to find it with
>>
>> grep -wA2 'rule REGENERATE_BUILD' ../build.ninja
> 
> Yep:
> 
> $ grep -wA2 'rule REGENERATE_BUILD' build/x86-tgts/build.ninja
> rule REGENERATE_BUILD
>   command = /usr/bin/python3
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/meson/meson.py --internal
> regenerate /mnt/nvmedisk/linaro/qemu-from-laptop/qemu
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts --backend
> ninja
>   description = Regenerating build files.
> 
> $ /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/meson/meson.py --version
> 0.61.5
> 
>> You should be able to unhose the directory with
>>
>> pyvenv/bin/meson setup --reconfigure ../..
>>
>> (where ../.. should be the path to the sources) or even with the patch:
>>
>> diff --git a/Makefile b/Makefile
>> index 3c7d67142f13..08fb6a3b058a 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -115,15 +115,15 @@ Makefile.ninja: build.ninja
>>            $(NINJA) -t query build.ninja | sed -n '1,/^  input:/d; /^  outputs:/q; s/$$/ \\/p'; \
>>          } > $@.tmp && mv $@.tmp $@
>>    -include Makefile.ninja
>> +endif
>>
>> +ifneq ($(MESON),)
>>    # A separate rule is needed for Makefile dependencies to avoid -n
>>    build.ninja: build.ninja.stamp
>>    $(build-files):
>>    build.ninja.stamp: meson.stamp $(build-files)
>> -       $(NINJA) $(if $V,-v,) build.ninja && touch $@
>> -endif
>> +       $(MESON) setup --reconfigure $(SRC_PATH) && touch $@
>>
>> -ifneq ($(MESON),)
>>    Makefile.mtest: build.ninja scripts/mtest2make.py
>>          $(MESON) introspect --targets --tests --benchmarks | $(PYTHON) scripts/mtest2make.py > $@
>>    -include Makefile.mtest
> 
> This patch doesn't work, I'm afraid:
> 
> $ make -C build/x86-tgts/
> make: Entering directory
> '/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts'
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/pyvenv/bin/meson
> setup --reconfigure /mnt/nvmedisk/linaro/qemu-from-laptop/qemu &&
> touch build.ninja.stamp
> WARNING: Regenerating configuration from scratch.
> Reason: Coredata file
> '/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts/meson-private/coredata.dat'
> references functions or classes that don't exist. This probably means
> that it was generated with an old version of meson. Try running from
> the source directory meson setup
> /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts --wipe
> The Meson build system
> Version: 1.1.0
> Source dir: /mnt/nvmedisk/linaro/qemu-from-laptop/qemu
> Build dir: /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/x86-tgts
> Build type: native build
> 
> ../../meson.build:1:0: ERROR: Unknown options: "sphinx_build"

Well, it almost works---notice that now you are running the 1.1.0 from 
pyvenv/bin/meson.  For now you can proceed with

    sed -i /sphinx_build/d meson-private/cmd_line.txt

and I'll try to send a proper patch over the weekend.

Paolo


