Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFDC707F76
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 13:35:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzbus-0006en-KX; Thu, 18 May 2023 07:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzbup-0006ea-Eo
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:35:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzbuo-0001vw-0v
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684409725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gfmIC8o5G3XINzxexqtvedPBMWqzWIWFIp8AhtuLz6o=;
 b=JjUAym8GLcdMw4G2tEKB0KzVoMdjNW+15F/XlIGc9NAyQ/ZXm1JV6aTzt9B0p4qgy5rpwq
 2c/FB43CRLvK7VX51z/9UwdNJ+2IUyI/imrCMgtitLbcapnAzGGIxoEmJlWli5X0E+9m0K
 wg8Jxh1FGGogNE+DtJb7u8w+SKRAkJk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-Xajw_x-0OB22HiG8-nO3xQ-1; Thu, 18 May 2023 07:35:18 -0400
X-MC-Unique: Xajw_x-0OB22HiG8-nO3xQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-96a0ce9215bso206162766b.2
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 04:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684409717; x=1687001717;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gfmIC8o5G3XINzxexqtvedPBMWqzWIWFIp8AhtuLz6o=;
 b=R5AYuDGV3DB2VSM+cVZaeDuPw3Btc0sq8FYrMxG1XdXHkk6c8U6raaIDZAtMkObfnj
 5TcR/cG0c8lKcucvGK04cWabTtzPX0qa1kW03ZT803TQjTkf33XFoO16mrtu5hfjcJg4
 cRyPslOvsLGQ6voQKxlaUb//vTKJDOVtA2PNAkCpQ9DT+7DRwgIcAc03Lc+e4zORygdn
 gs/S9GEIEp9kxx/HghuIwKygA7mpQ4+B3mtS8esvvgpqLEohn1NK95HQTZzzUnBuN7vu
 wxdU4zR96J9x/VfwnCEe56uH1E2ZMutFMW9oBPnkSbvKiULJbaIh17DCPnb0yGlYqsZV
 +Jmg==
X-Gm-Message-State: AC+VfDxuxVsP5uAIMbn/rWaK7IL1LWq8X4HfAif/IfViHdRCYQFPj6P2
 dUZ4tFkVmSrRKklzsB6S8v/Gl4Bf9OV7lDhLRsEPtimFK11QYB5d+OE8Dh+w1LMq+QLbXtu9bWi
 6EaTq4HPdZNem6+w=
X-Received: by 2002:a17:907:96aa:b0:965:66dd:78ec with SMTP id
 hd42-20020a17090796aa00b0096566dd78ecmr40169495ejc.53.1684409717161; 
 Thu, 18 May 2023 04:35:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ49NnuKbPs3yyAZRj6YurCpUzb3hI8hw0vMCVRmhiv6X92OJFCkQnryVQqmgNj2WksY5niqIg==
X-Received: by 2002:a17:907:96aa:b0:965:66dd:78ec with SMTP id
 hd42-20020a17090796aa00b0096566dd78ecmr40169483ejc.53.1684409716831; 
 Thu, 18 May 2023 04:35:16 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c?
 ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.googlemail.com with ESMTPSA id
 b4-20020a170906d10400b0096650f46004sm859407ejz.56.2023.05.18.04.35.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 May 2023 04:35:16 -0700 (PDT)
Message-ID: <946a9986-8b44-ff2f-5344-c67cd8e1b3b2@redhat.com>
Date: Thu, 18 May 2023 13:35:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PULL 00/68] i386, build system, KVM changes for 2023-05-18
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20230517174520.887405-1-pbonzini@redhat.com>
 <a7f23b7c-879f-36db-dabd-1891bda766e5@linaro.org>
 <CAFEAcA93JsM+XkWnQ=SzR94k9eHVvfV_NnFeOtpdv70TLpUa9w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CAFEAcA93JsM+XkWnQ=SzR94k9eHVvfV_NnFeOtpdv70TLpUa9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.544, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 5/18/23 11:22, Peter Maydell wrote:
>> /usr/lib/gcc/aarch64-linux-gnu/11/../../../../aarch64-linux-gnu/lib/../lib/libc.a(init-first.o):
>> in function `__libc_init_first':
>> (.text+0x10): relocation truncated to fit: R_AARCH64_LD64_GOTPAGE_LO15 against symbol
>> `__environ' defined in .bss section in
>> /usr/lib/gcc/aarch64-linux-gnu/11/../../../../aarch64-linux-gnu/lib/../lib/libc.a(environ.o)
>> /usr/bin/ld: (.text+0x10): warning: too many GOT entries for -fpic, please recompile with
>> -fPIC
>
> This is really a bug in the host libc (more specifically, how
> the libc.a was compiled), isn't it?

Ok, it's a silly typo that caused -fno-pie to be dropped.

Paolo

  We've only previously seen
> it when trying to build the system emulation binaries statically,
> but it looks like it's finally reared its head for the usermode
> binaries here. IIRC it basically boils down to how big the final
> executable is and whether you get unlucky with what gets linked
> in and what order such that a reloc in libc ends up wanting to
> access a GOT table entry that gets assigned too high an index.
> Still, given the prevalence of libc that's been compiled -fpic
> rather than -fPIC, we probably need to deal with it somehow.


