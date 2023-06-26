Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8372673DC01
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 12:06:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDj6q-0003yg-CZ; Mon, 26 Jun 2023 06:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDj6n-0003xS-OG
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 06:06:09 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDj6l-0000rz-H4
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 06:06:09 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3f9b4bf99c2so40145395e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 03:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687773966; x=1690365966;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dlLwjthouONpgaXWAA3KKTYnL6Q0oRnRMJiKkUv8Rys=;
 b=RSoW8ox1KN/4lnQv4+qv+LVvE8VDo0KMf/UfQAahOBEDQk4yCx9H7HwvspxNakUsoS
 FqZ89ISsChV2WyYa7ac42g0j62/KJM0i9vpv9g+2MGr+mcAuxPWHZRypfik06pUvUUZL
 HuXcSVXsmptkSKl2uDM1HNXjortOMlDogyhL1OT8x7LemEsfQSacLXY1i5DtvIfV4h9f
 z6IzDfBO3ebXzSAPq70LR1iLeIpo66xLJXT2I9xfzR1mrBsPhyhfaPGIzCIIHiobPmBS
 keHdoh/Iifld7f+7D8b9rt8LxZRLWve97hrAESOvtaPHyAfnTGL3rtN9okp4VA0ZlFD6
 Zfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687773966; x=1690365966;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dlLwjthouONpgaXWAA3KKTYnL6Q0oRnRMJiKkUv8Rys=;
 b=cjVbUrOaR1gF3MMFdd7VGKHQ9s0Gbu6ylzjMDs7oybazMJi6DMjuM7sDF+5pg27s4h
 fSmXH4H0rI5e1sbCNTCIM4bSY8LmY8AsKz1KnmiUrhW/LCumIGewELj7AslzlCi8BPgM
 FiC9VH9xtZEA/P63AEjUQbYjY6dIfP5CinOmAG3sKmpKrplqUYNMNKVjyjBBUaWUur96
 oGarCm5KsnHXalwd4/mgezMCiJLu+b5O4wHe17uCf3V683DCzN6gQJ8LRp7dJE2+26Kg
 QdNybY7ovV5K8EYVb8dN6/n4AuMW58e6mpB3wkaSi2loj8LcaMAj05sLcL3WMWnqOHbA
 rA4Q==
X-Gm-Message-State: AC+VfDzzuBnO9+HtfUDZxVmVdOsVaWeWHiZ4XEAuvDaT82F7RUAnl2cT
 bYcC8cx9MSorKBIUBq2ZJhl5rA==
X-Google-Smtp-Source: ACHHUZ4urtxrj4juO5tG7UUeKXT/RixAAPD8KU/zqeHWLAgbzFRnvKdaBesRbfFyC5HIOaGbS+0XaA==
X-Received: by 2002:a1c:7c0f:0:b0:3fa:7ebd:e1ee with SMTP id
 x15-20020a1c7c0f000000b003fa7ebde1eemr6631072wmc.32.1687773965794; 
 Mon, 26 Jun 2023 03:06:05 -0700 (PDT)
Received: from [192.168.157.227] (141.pool92-176-132.dynamic.orange.es.
 [92.176.132.141]) by smtp.gmail.com with ESMTPSA id
 h11-20020a1ccc0b000000b003fa8158135esm7901577wmb.11.2023.06.26.03.06.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 03:06:05 -0700 (PDT)
Message-ID: <39a174a0-a64d-c687-52da-40aeb7179de0@linaro.org>
Date: Mon, 26 Jun 2023 12:06:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/3] target/i386: allow using named CPU modeles with
 user mode emulation
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20230626083317.144746-1-pbonzini@redhat.com>
 <ZJlYbXKwd4SxoaxY@redhat.com>
 <CABgObfa2ft-j0CdDyV78awrKu1nowXDSVxeqtQoFG_+qOp=6tw@mail.gmail.com>
 <ZJlcC0Qd7v71yuJm@redhat.com>
 <CABgObfZTA+Wbnkfz2WESTKbPjttdOM1DeikZJEYMJjs405tvkw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CABgObfZTA+Wbnkfz2WESTKbPjttdOM1DeikZJEYMJjs405tvkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 6/26/23 11:37, Paolo Bonzini wrote:
> On Mon, Jun 26, 2023 at 11:36 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>> If someone wants Nehalem then they should be using qemu-x86_64.
>>>> If someone wants qemu-i386 then they should be using an older
>>>> named CPU model predating 'lm'.
>>>
>>> What you write is true for qemu-system-*, but the problem is that
>>> qemu-user binaries are only able to run one ELF target. qemu-x86_64 is
>>> not able to run i386 binaries, unlike a 64-bit kernel; and that's
>>> really intrinsic in the design of qemu-user because implementing
>>> multiple ABIs (including multiple definitions of structs and syscall
>>> numbers) would require compiling the same files multiple times.
>>
>> Oh, right, yes, ignore my comment.
> 
> By the way it's possible that the above comment would not be true
> anymore with the "one binary" work that is going on (though I'm not
> sure if that applies to system emulation only). However, the effect on
> speed for 32-bit hosts remains true until we ditch them altogether.

Yes, one binary work is system-mode only.
Primarily because of the ABI issues you describe.


r~

