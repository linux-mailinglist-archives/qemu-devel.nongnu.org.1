Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2164707D4C
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 11:53:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzaJi-0006q2-I8; Thu, 18 May 2023 05:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzaJe-0006pl-Gx
 for qemu-devel@nongnu.org; Thu, 18 May 2023 05:53:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzaJc-0000Ot-WE
 for qemu-devel@nongnu.org; Thu, 18 May 2023 05:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684403575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bmtO6hfhx/i+LCK4C5RTyu+M2SMSwwCu9r+4e9ysruQ=;
 b=YtMdEQfz5DzlkIbsY782Shf/kQ0lJ/ajaK3WM8Xq4ss+vb0SFUTlG7VEessh+pCnvh/ueZ
 MxdBpdUT00cMRsGk9wifquFf4ztFWI+MJZSSmotVIkscTk3R5vzNvRVtiiusVkNckL/chB
 Yfr3kjXu+4V8Qp/jornsw0eh6RGNaSU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-tQYxCv2vMMyFVkGXRfAJZQ-1; Thu, 18 May 2023 05:52:54 -0400
X-MC-Unique: tQYxCv2vMMyFVkGXRfAJZQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-969d75fec7aso258690866b.2
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 02:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684403572; x=1686995572;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bmtO6hfhx/i+LCK4C5RTyu+M2SMSwwCu9r+4e9ysruQ=;
 b=OUWH98kpLtwhnuJK0pkRouxJz+9/6A3JojjmhSMkqtZAH8kqi73QSvHEcLcagA9Ge4
 aoalPoIC3X0i45ZFYZqZVsrBuzLooRGYbyuy8Cv0vjY8IIplBbt88OG8VbtyDgbshqG1
 C4ifevn4xcg+zPO9n9xC4zxzLlyJpTxba73BhZ7Pokd/uuZ16vultjfSJoyYOG0yJCtW
 2q7KwFrY5PDzM1Tp3bM4buBlu4kK7ZS3ia7xgjjF/+Q98XgWcTo2kSNnK49Y/vdCzRSd
 ybRwWZH00VNG4wQkeJgXKOXF0OsO1lLWi0wtgAHJ0kGViiGiq9J+/XI4xTNDLBNxcges
 hM+w==
X-Gm-Message-State: AC+VfDx5KR0xi1+eUxkMd86QjcsaamXB0A5g2KP3pu6NjdubZfHgMM3u
 gsbRn5u6prLU+jWahD64xeuukk7ZIECVka1+YD6WfVUNJuHO1Zf5NV7qsgZtaB7TDNXUUKligA9
 YGUL4Qy41Gfs+pug=
X-Received: by 2002:a17:907:7fa7:b0:94f:553:6fd6 with SMTP id
 qk39-20020a1709077fa700b0094f05536fd6mr46684345ejc.24.1684403572801; 
 Thu, 18 May 2023 02:52:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5omMlkOJEqaHBScHTvQA7k1VQnlR9BmMhR/EX4giiqvWx2/qFBoTNsBotlQmmuMi3dF/xMQw==
X-Received: by 2002:a17:907:7fa7:b0:94f:553:6fd6 with SMTP id
 qk39-20020a1709077fa700b0094f05536fd6mr46684334ejc.24.1684403572472; 
 Thu, 18 May 2023 02:52:52 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c?
 ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.googlemail.com with ESMTPSA id
 g3-20020a170906868300b009658264076asm733647ejx.45.2023.05.18.02.52.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 May 2023 02:52:51 -0700 (PDT)
Message-ID: <f17b3d28-c5b7-ef69-309a-1b57662729e9@redhat.com>
Date: Thu, 18 May 2023 11:52:51 +0200
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
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.412, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
> On Wed, 17 May 2023 at 21:32, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> Failures:
> 
>> https://gitlab.com/qemu-project/qemu/-/jobs/4304958508#L2551
>>
>> /usr/lib/gcc/aarch64-linux-gnu/11/../../../../aarch64-linux-gnu/lib/../lib/libc.a(init-first.o):
>> in function `__libc_init_first':
>> (.text+0x10): relocation truncated to fit: R_AARCH64_LD64_GOTPAGE_LO15 against symbol
>> `__environ' defined in .bss section in
>> /usr/lib/gcc/aarch64-linux-gnu/11/../../../../aarch64-linux-gnu/lib/../lib/libc.a(environ.o)
>> /usr/bin/ld: (.text+0x10): warning: too many GOT entries for -fpic, please recompile with
>> -fPIC
> 
> This is really a bug in the host libc (more specifically, how
> the libc.a was compiled), isn't it? We've only previously seen
> it when trying to build the system emulation binaries statically,
> but it looks like it's finally reared its head for the usermode
> binaries here. IIRC it basically boils down to how big the final
> executable is and whether you get unlucky with what gets linked
> in and what order such that a reloc in libc ends up wanting to
> access a GOT table entry that gets assigned too high an index.

The patches should introduce no code changes AFAICT, but I noticed that 
they added a '-no-pie' flag that was not there previously in the static 
compilation case.  Maybe that's the source of the breakage (if so it's 
arguably a GCC driver bug, but compiler command lines are hard).

> Side note: why are we linking against -lstdc++ ???

A remnant of libvixl that was never deleted:

    emulator = executable(exe_name, exe['sources'], ...
                          link_language: link_language, ...)

Paolo


