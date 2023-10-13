Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFC87C8624
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 14:52:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrHbK-00011i-Db; Fri, 13 Oct 2023 08:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrHbA-0000vV-DN
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 08:49:03 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrHb6-0000ff-Kx
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 08:49:00 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-323ef9a8b59so1986323f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 05:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697201335; x=1697806135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=dBz9GQdSEU9gKF/QgtOWHkAKu0z5HMjUNwmS10XT57U=;
 b=FBzrAPLya5nXNCA4Tl/1V8gW15ypZWkYW1NS6ieieGWfHByhUYUxuOEmmd5J/ybGO5
 24lkaa5fYAmqC2cr4RY/MgZ0Jed6RzjgcTCUHF+Pu/3ILALUe5bobNXQDCMjtYaKOaNY
 Ppp57MB3onCrw9ViIgWJs/b6KS60EpsVd7ID5e7kthRWbEQek7Y3TisAo/JDy653G/yu
 nFnLDX+McV4gg5CTKq8dEyKbuetCJ0FJsJWv0JX2Q0a5FbuLWH6C+3gGw7fqU6AI3Fzh
 zY1eVzGli5hs3UqePKDySiaMEOfbHKsFcqf9MRlQSUF4JsMpzMm0tezR1Vc2iRbnb2rd
 cUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697201335; x=1697806135;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dBz9GQdSEU9gKF/QgtOWHkAKu0z5HMjUNwmS10XT57U=;
 b=HSY7h2B50J6PADZf5nAcalCM6awrLCjqMFW2KJLb16vg6gzKj/Ira9vhVJ9PbST1kG
 1IJwB4yEJftkdMvBPEITh9WBNOis9S3/8NiYhkVOvSGaydLr7Ee3W6i0sDrHehWeWD0y
 IrziWgGgpXU8OeIe/5tNMWsrjf84d7IjQjcpdE9iwl+NaKqyNyXymRn/ewKTeH5MSY6s
 cHsdLWRsVQ4gnfZhoTRfa3pWi/oJf97ilH6EuQV5GYCxZ92DdJnbnkIHZez2V4KvECW0
 0Ey/ClfVG1y1J74UGn/ZTx9591Cngmq4b42wPkojdT1zm+VwClzdC2CQmiUf8D54IxOd
 AkMw==
X-Gm-Message-State: AOJu0Yyy0tvBc77Jv7iRHzPBliNutieMH8Ec8WuX/VWFKLnqA9ONX5Uk
 BoJbUpk48Oy4B/52wa7XBtlMKg==
X-Google-Smtp-Source: AGHT+IEVH4oa8494n5l6asa5NA3gfSFFYvfe1oalg8Q3+GtfNd8FYtkAVdF4fPHtaA0H3y9chDfuyA==
X-Received: by 2002:a5d:4d06:0:b0:320:824:e3df with SMTP id
 z6-20020a5d4d06000000b003200824e3dfmr22428410wrt.35.1697201334783; 
 Fri, 13 Oct 2023 05:48:54 -0700 (PDT)
Received: from meli.delivery (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 f4-20020a5d4dc4000000b003253523d767sm4275796wru.109.2023.10.13.05.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 05:48:54 -0700 (PDT)
Date: Fri, 13 Oct 2023 15:37:23 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH 01/78] include/qemu/compiler.h: replace
 QEMU_FALLTHROUGH with fallthrough
User-Agent: meli 0.8.2
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
 <2e08cff874b2f9fc4143bdcde87ebba9b70b356c.1697183082.git.manos.pitsidianakis@linaro.org>
 <874jiuiu4w.fsf@pond.sub.org>
In-Reply-To: <874jiuiu4w.fsf@pond.sub.org>
Message-ID: <2gwxg.2pv9ux2894z@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hello Markus,

On Fri, 13 Oct 2023 15:28, Markus Armbruster <armbru@redhat.com> wrote:
>The commit message needs to explain why.

Certainly.

>This is wrong.  docs/devel/style.rst:
>
>    Include directives
>    ------------------
>
>    Order include directives as follows:
>
>    .. code-block:: c
>
>        #include "qemu/osdep.h"  /* Always first... */
>        #include <...>           /* then system headers... */
>        #include "..."           /* and finally QEMU headers. */
>
>Separate patch, please.

I know. spa headers use the `fallthrough` attribute and qemu/compiler.h 
defines it as a macro, so it breaks compilation. If the spa headers go 
after, we'd need to undef fallthrough before including them and 
re-define or re-include qemu/compiler.h after. What do you think would 
be best?

>
>> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
>> index 1109482a00..959982805d 100644
>> --- a/include/qemu/compiler.h
>> +++ b/include/qemu/compiler.h
>> @@ -1,215 +1,231 @@
>
>[...]
>
>>  #define QEMU_ALWAYS_INLINE
>>  #endif
>>  
>> -/**
>> - * In most cases, normal "fallthrough" comments are good enough for
>> - * switch-case statements, but sometimes the compiler has problems
>> - * with those. In that case you can use QEMU_FALLTHROUGH instead.
>> +/*
>> + * Add the pseudo keyword 'fallthrough' so case statement blocks
>
>Pseudo-keyword?  It's a macro.

C calls reserved words that you cannot redefine 'keywords'. Like 
'break', 'continue', 'return'. Hence it's a pseudo-keyword. It's also a 
macro. They are not mutually exclusive.

I did not write this, it was taken verbatim from the linux kernel 
source, see: /include/linux/compiler_attributes.h

>
>> + * must end with any of these keywords:
>> + *   break;
>> + *   fallthrough;
>> + *   continue;
>> + *   goto <label>;
>> + *   return [expression];
>
>These are statements, not keywords.

I'm pretty sure it refers to {break, fallthrough, continue, goto, 
return} by themselves.

>
>> + *
>> + *  gcc: https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html#Statement-Attributes
>
>Not sure we need to point to the docs here.  We have hundreds of
>__attribute__ uses in the tree.

Again, copied from /include/linux/compiler_attributes.h

>
>>   */
>> -#if __has_attribute(fallthrough)
>> -# define QEMU_FALLTHROUGH __attribute__((fallthrough))
>> +
>> +/*
>> + * glib_macros.h contains its own definition of fallthrough, so if we define
>> + * the pseudokeyword here it will expand when the glib header checks for the
>> + * attribute. glib headers must be #included after this header.
>> + */
>> +#ifdef fallthrough
>> +#undef fallthrough
>> +#endif
>
>Why do we need to roll our own macro then?

Glib uses a different name. The problem is when it checks for the 
compiler attribute, which expands into our macro.


--
Manos 

