Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E299E739DB8
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 11:51:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCGxv-0002Cc-Ok; Thu, 22 Jun 2023 05:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCGxt-0002CO-KR
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 05:50:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCGxs-000429-2O
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 05:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687427455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Npk9UCzJ8vF1IZdoWvvaD8mW24I9tVTaVLrBtwTR/4=;
 b=iTKtI/HR0vo4LeKdAmJP8Ex6RaNLG12naGSQkLgdkm8Bi3LFrFhV1oL/1VwDWOU4EI+MR5
 hpsonGKFrZfwh6PW71OOks6XG1PDRSP4LO0qoMsvcj4zmtKtnPUgvr+SN2uzENQ+pwnxrx
 Kzm+oTH11OGKd1lqrr5opxKgratHaAU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-3V1u4GEYMYGNR7-ZuHBvdw-1; Thu, 22 Jun 2023 05:50:53 -0400
X-MC-Unique: 3V1u4GEYMYGNR7-ZuHBvdw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-51a49eb6000so4057753a12.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 02:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687427452; x=1690019452;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+Npk9UCzJ8vF1IZdoWvvaD8mW24I9tVTaVLrBtwTR/4=;
 b=ketTdx5dpcpsQoGc4tLODlhmpCkXvYhclWxh7k6/3magpb7KZGePbq/eaUoUgc4AbU
 VJ5ot5u68IkxjTXChgVrE3LCyCkPd3fbf0wsf0ZqWv+2TakNgcNhlW8lN58COFVoLv51
 caZnhw6Trp3wxjHnpkYhV0Wpfdlx8vzBhndbd7Rp7t6MYg0Jvt1dnsH0KHngYYjgW4mF
 NDzusACTE4qMsl9zd7mPW9zgRC/JqqMbDg5KJZTCDI+NPFUZYiqQyUP+hd/s73jXoIfk
 7MHnF2shbNF+crzNzMCVO+5GppeOQtV3SJPP5I8pYPFD2TJGbF7m9tYzxHsLSsZ8FGZW
 Y0bA==
X-Gm-Message-State: AC+VfDymgVTypqSnVxOeoKMBZyuRwlEY8aAY4jA8ioSWiOrDT6yADm8e
 GB9QyzWfz5aYcc5+62tFfmCHeNCrlnfflElDzV9GV10tPhtMOC8kEkbyWXOqDKTGJMnKL0WExrZ
 Cp5axjOiqKLU9kEqXyFeQhbo=
X-Received: by 2002:aa7:d292:0:b0:51b:dfce:1a49 with SMTP id
 w18-20020aa7d292000000b0051bdfce1a49mr2386268edq.37.1687427451868; 
 Thu, 22 Jun 2023 02:50:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4yococCIciwl2ViVY6lEEPO1Fzda129IIPTFQcqAl+5+/nCY7cFMojzOTjXy/uCsOwlI8JIA==
X-Received: by 2002:aa7:d292:0:b0:51b:dfce:1a49 with SMTP id
 w18-20020aa7d292000000b0051bdfce1a49mr2386255edq.37.1687427451603; 
 Thu, 22 Jun 2023 02:50:51 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89?
 ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.googlemail.com with ESMTPSA id
 s6-20020a056402014600b0051bdf152295sm1751393edu.76.2023.06.22.02.50.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 02:50:50 -0700 (PDT)
Message-ID: <d560c659-32e3-1610-6a81-2aa54e94a814@redhat.com>
Date: Thu, 22 Jun 2023 11:50:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] git-submodule.sh: allow running in validate mode without
 previous update
Content-Language: en-US
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <20230618212039.102052-1-pbonzini@redhat.com>
 <d6a79a1d2159e0659cd0ed6ff545bf577c05bad3.camel@linux.ibm.com>
 <CABgObfa8kEiG22MAdsuhgpuWrzWq9yWMeRaFgvWA5x_eoROPUw@mail.gmail.com>
 <31e1b43a026886e08ed48dcebbd27626eede872e.camel@linux.ibm.com>
 <bc41fa85012d7eaf1534016f17308f9b50f35f27.camel@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <bc41fa85012d7eaf1534016f17308f9b50f35f27.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 6/21/23 16:20, Nina Schoetterl-Glausch wrote:
> On Wed, 2023-06-21 at 16:07 +0200, Nina Schoetterl-Glausch wrote:
>> On Tue, 2023-06-20 at 22:44 +0200, Paolo Bonzini wrote:
>>> Il mar 20 giu 2023, 19:35 Nina Schoetterl-Glausch <nsg@linux.ibm.com> ha scritto:
>>>>> +            modules="$modules $m"
>>>>> +            grep $m $substat > /dev/null 2>&1 || $GIT submodule status $module >> $substat
>>>>> +        else
>>>>> +            echo "warn: ignoring non-existent submodule $m"
>>>>
>>>> What is the rational for ignoring non-existing submodules, i.e. how do the arguments to
>>>> the script go stale as you say in the patch description?
>>>
>>> For example when a Makefile calls the script before the Makefile itself is rebuilt.
>>
>> Ah thanks. Can this still happen, roms/SLOF being the only
>> remaining build time user of submodules,
>> as per 1f468152fb ("build: remove git submodule handling from main
>> makefile")? pc-bios/s390-ccw/Makefile explicitly names roms/SLOF,
>> so if that were removed, the Makefile would
>> need to be fixed anyway.

Yeah it cannot happen but I'm thinking it's sensible behavior in 
principle.  It also matches "git submodule update", which doesn't return 
an error if the required path is not a submodule.

>>> You mean it succeeds even if roms/SLOF is empty?
>>
>> Yeah, it does:
>>
>> %prep
>> %autosetup -n qemu-%{version}%{?rcstr} -S git_am
>>
>> Which I does a git init, git add ., git commit, so no submodules exist
>> and git-submodule.sh ignores every maybe_module.
> 
> Also the official source tar does include roms/SLOF, so they won't run into problems.
> I used the spec file with a tar generated by archive-source.sh which doesn't package roms/SLOF.
> How is the official tar generated?

It's generated with scripts/make-release.

Paolo


