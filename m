Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CD4708208
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 15:05:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzdIp-0001YA-JU; Thu, 18 May 2023 09:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzdIo-0001Xu-19
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:04:18 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzdIm-0001nU-9I
 for qemu-devel@nongnu.org; Thu, 18 May 2023 09:04:17 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-64d18d7738dso477509b3a.3
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 06:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684415053; x=1687007053;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nzZYtfkcZRws2M/l9EIIG6noEaMWrg374XPMxh+WHTA=;
 b=S8+foUSy/QkTyO0ENa5BTgUOhW2FqLeIXEN8qdpHj7cbBkPt1JtXzFiX0zVg/BcB3N
 gFwkgBBYM8FnKV/5PAHCPMmifHzMPbzxBR7/2vFZYS73qBNJRNgXHRrvIH6+yjwMhCYe
 VOzUBejD8Rstr9V57Stlp16D91jzEt9vG4Eb3WTsrId6fnU5PWjLUBmpJ9dewgfd2nGI
 xAYXT462Pe2tyizY7MxAt3PercrLLXkzozaiTHTmEFWUJzgfeELcWDHUqqoDMhue+fBA
 mgdySVx6j3YkbYSsTBp05zoRaAA08tzl2jNfPdmqTQEslnDWYfbESt4yE+ajUaE4AtqE
 to+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684415053; x=1687007053;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nzZYtfkcZRws2M/l9EIIG6noEaMWrg374XPMxh+WHTA=;
 b=IWEBrQZcj7O+Ts1mZjmCnJrmjS8L+GB1YZWdCYmVwSFSuZs0DtSaasBZhttI5OoW3k
 XvndgVt9O9nzwqNfrepdIL4dt1PsCxDnkAuCcHpi84YD/iLju1M3CnA6h39l56DeWM0N
 GVxKfFGoXGPQpVVe8pF3L7yW51Sc3iyWsMf+L9lvknF7yVeqhoEUYqm8ln+Es1oma2ok
 4FOnXRQXdgOEJFXDDZY8AXYvWQC6MgxSHXMvHzyeK7W3HL0OvkIa3HSuYlM/9cq5XIzF
 WnGfZMgDURFVdAmGiW4bl5///8N3B3Owq2agIA3h/JYCO2Q5+Nvv+iE17BG4c3gP8XHS
 C3nQ==
X-Gm-Message-State: AC+VfDxM6UTMe5EHra/NV4tKZqNmBAh5gZO1oVxMSus8ltP7UgV0G9rP
 YlY7TjtEmPjxDfsKvEcHJnSf1w==
X-Google-Smtp-Source: ACHHUZ6OoyDuQdoKaDytJA73o1YjBgBFN9zkjQijeb8sUx+wmYcCFtfbGRJXOgy1tzUFkCxjULaUrw==
X-Received: by 2002:a05:6a20:7fa8:b0:100:8258:1679 with SMTP id
 d40-20020a056a207fa800b0010082581679mr2385439pzj.0.1684415053182; 
 Thu, 18 May 2023 06:04:13 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:5dd2:c230:399b:cdc1?
 ([2602:ae:1598:4c01:5dd2:c230:399b:cdc1])
 by smtp.gmail.com with ESMTPSA id
 t5-20020aa79385000000b0064d1d8fd24asm1192144pfe.60.2023.05.18.06.04.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 May 2023 06:04:12 -0700 (PDT)
Message-ID: <276441f2-eb7b-6e29-a138-c4dd8937cef1@linaro.org>
Date: Thu, 18 May 2023 06:04:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/68] i386, build system, KVM changes for 2023-05-18
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230517174520.887405-1-pbonzini@redhat.com>
 <a7f23b7c-879f-36db-dabd-1891bda766e5@linaro.org>
 <CAFEAcA93JsM+XkWnQ=SzR94k9eHVvfV_NnFeOtpdv70TLpUa9w@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA93JsM+XkWnQ=SzR94k9eHVvfV_NnFeOtpdv70TLpUa9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.544,
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

On 5/18/23 02:22, Peter Maydell wrote:
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
> Still, given the prevalence of libc that's been compiled -fpic
> rather than -fPIC, we probably need to deal with it somehow.

Yes, this looks like the same --static-pie issue we saw before.

I thought we'd been working around this in CI by testing --static --disable-pie.  Given 
Paolo moves --static handling to meson in this patch set, I assume that's the culprit.

> Side note: why are we linking against -lstdc++ ???

Missed c++ purging?


r~


