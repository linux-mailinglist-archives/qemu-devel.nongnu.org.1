Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58832769134
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 11:12:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQOvm-0007nD-La; Mon, 31 Jul 2023 05:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qQOvj-0007ld-Bh
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 05:11:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qQOvh-0001Qk-Fh
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 05:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690794664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GGoVuVG7ZuOM4DH0hNbNkRIC0O+nhsHK+NioI+xb5Ik=;
 b=ORZJCHT4Yi9zrkNxU9ygTM+xwbOSFqQb/f2szMpVctT6tayxXa9xbXt+Hln5h2wK/dUk7N
 9+e0DyUHCQ0nqFDWC40PVx7KwHbQTu2eLP7PMwcsrzmfF8uFitNhUnw9lIcEfs+H9B4SCa
 IVLong5g1XYeF6tULi4d3Nq65bXRN1k=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-pYPVUhb8OeGQ3ZL4-jLAdQ-1; Mon, 31 Jul 2023 05:11:01 -0400
X-MC-Unique: pYPVUhb8OeGQ3ZL4-jLAdQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-63d0b65ae89so32265476d6.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 02:11:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690794660; x=1691399460;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GGoVuVG7ZuOM4DH0hNbNkRIC0O+nhsHK+NioI+xb5Ik=;
 b=AMhSTtrYY7x9+Zq7nRoXN0Fp0rweYAzmEoplT1LtRbv/qDL3DOJqXxmV7CjeCt53m+
 e+kmS6kLsnQTfE5FpBjNGJd3L43qi4Lx1RoyaQxnrVZecSfaiL9q0YnR/go9+0AIMR92
 SbmJ7tTsYmuw2CQNZivzjnjsNamWHAnVgg3BXoLnlSRR+uc5vnY1soSvZvZBcEJOKrbY
 gVwU1h7jokoGsn63XmvZIJYL2IEEV13sltDN9zMnD3myCIz7uA2f0lzGON/4W7KoJhJZ
 5bbGoOgpn/jA0vFwXiB3vSXZWdW0ANuKGwyX8FqLTbHYHkEOvS6wkjNaq0v9ot0cnrwc
 TTnw==
X-Gm-Message-State: ABy/qLY7oKTl1Fzz/yDUkrPUBJjd0yJ/EcSrC4OqJHChOHsfp+J4iyI+
 WcwxOMQlh5npCTE+8uPSOthmsJimjkPPvC0SnGObPstAk+LTJzumvL8s6BDOfWflmU+4OvjcmOd
 nx35Id+reB4D0A40=
X-Received: by 2002:a0c:f4c3:0:b0:63c:71bf:f5d1 with SMTP id
 o3-20020a0cf4c3000000b0063c71bff5d1mr13939206qvm.25.1690794660806; 
 Mon, 31 Jul 2023 02:11:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE1T116b0cj0xBJpyelwAVGg+zR17GZrDhOoMY9LHjImlFvVaPuXGwwAm0riFcMyXy/L7OcAw==
X-Received: by 2002:a0c:f4c3:0:b0:63c:71bf:f5d1 with SMTP id
 o3-20020a0cf4c3000000b0063c71bff5d1mr13939190qvm.25.1690794660544; 
 Mon, 31 Jul 2023 02:11:00 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 g7-20020a0cdf07000000b0062df126ca11sm3551311qvl.21.2023.07.31.02.10.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 02:11:00 -0700 (PDT)
Message-ID: <6ca265d4-0dad-3725-1cd5-84da685bc63a@redhat.com>
Date: Mon, 31 Jul 2023 11:10:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Yonggang Luo <luoyonggang@gmail.com>
References: <20230728142748.305341-1-thuth@redhat.com>
 <20230728142748.305341-6-thuth@redhat.com>
 <CAFEAcA9PuwSzaWXJYrF9PTs8Yz9oG6_sUY=p7S5rnx6NiS1HeQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [RFC PATCH 5/6] include/qemu/compiler: Fix problem with
 gcc_struct and Clang
In-Reply-To: <CAFEAcA9PuwSzaWXJYrF9PTs8Yz9oG6_sUY=p7S5rnx6NiS1HeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.101, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 28/07/2023 17.13, Peter Maydell wrote:
> On Fri, 28 Jul 2023 at 15:28, Thomas Huth <thuth@redhat.com> wrote:
>>
>> Clang on Windows does not seem to know the "gcc_struct" attribute
>> and emits a warning when we try to use it. Add an additional check
>> here with __has_attribute() to avoid this problem.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   include/qemu/compiler.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
>> index a309f90c76..5065b4447c 100644
>> --- a/include/qemu/compiler.h
>> +++ b/include/qemu/compiler.h
>> @@ -22,7 +22,7 @@
>>   #define QEMU_EXTERN_C extern
>>   #endif
>>
>> -#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
>> +#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__)) && !defined(__clang__)
>>   # define QEMU_PACKED __attribute__((gcc_struct, packed))
>>   #else
>>   # define QEMU_PACKED __attribute__((packed))
> 
> I'm not sure about this. The idea of QEMU_PACKED is that
> it's supposed to give you the same struct layout
> regardless of compiler. With this change it no longer
> does that, and there's no compile-time guard against
> using something in a packed struct that has a different
> layout on Windows clang vs everything else.
> 
> If it was OK to use plain attribute(packed) we wouldn't
> need the ifdef at all because we could use it on GCC too.

I still haven't quite grasped whether this attribute just affects structures 
with bitfields in it, or whether it could also affect other structures 
without bitfields.

Looking at https://gcc.gnu.org/onlinedocs/gcc/x86-Type-Attributes.html and 
https://gcc.gnu.org/onlinedocs/gcc/x86-Options.html#index-mms-bitfields , it 
sounds like it only affects structs with bitfields, unless you specify an 
"aligned(x)" attribute, too?

Anyway, using bitfields in structs for exchanging data with the guest is 
just way too error-prone, as you can see in the discussion about that 
VTD_IR_TableEntry in my other patch. We should maybe advise against 
bitfields in our coding style and point people to registerfields.h instead 
for new code? ... so that we use QEMU_PACKED mainly for legacy code. Would 
it then be OK for you, Peter, to go on with this approach?

Or do you see another possibility how we could fix that timeout problem in 
the 64-bit MSYS2 job? Still switching to clang, but compiling with 
--extra-cflags="-Wno-unknown-attributes" maybe?

  Thomas


