Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F0378E8DA
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 10:54:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbdQv-0006RE-Ir; Thu, 31 Aug 2023 04:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qbdQs-0006ON-Ue
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 04:53:42 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qbdQq-0005Yb-C6
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 04:53:42 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c22103bce7so3920345ad.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 01:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1693472019; x=1694076819;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nccofICTcpy8vRW011/RXLWH6APMxo9jTHGtz1Ll/qo=;
 b=IlGLwddlTdcryRsNuVtbmvut9O1lZIijIEyko1Bn1xcvKwN4O+3oqwSb2oWwYhD70a
 MM+70BDqzOUD5ipCP/XQyNxEZVf2dsUIJm9oNm/TSDQftESbY0c3zozgcSooWfCxb+Eg
 6ly0GC0bziiQqy1LDqwhThag5VNUCiEFE7ut/z7pzwDKVvttNeUL3/5pV3lr8/th+o5R
 Gt0qaZU3wZrtMx/bwdIQcGnMN2AqbTOYoICOOEqBbCI3MfOTlcsQ5LpMUYTuv9qXJmv4
 ICQOHGWoUFKmHke4YSdcrgNBWy9i5h8gL65FQBc7eTWbYcLGAJb7omRYAlDP9bTR4LM6
 W76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693472019; x=1694076819;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nccofICTcpy8vRW011/RXLWH6APMxo9jTHGtz1Ll/qo=;
 b=IKmNgxu/PM7XwzIvUGb5KfeGdKNkM3tAHEYcw5i9xvzezmcs6YMZ3+cNQmuJQJs0nH
 z/tLu5aOZEhJ+pVRTHyeTHM25/fG520FHtVzEkFzawbGlCnj7HFxUiC7nGT9Xd5hu+DJ
 PWfJhpM1lUfGIp67hdVB7lYMKs/wARNoKYn8rbHmRG+EGqlXOr427pqbrj6RN3QFOmcu
 zWsXEtAEP/PkP6+g/zkzNZ3uqO0oZIuLWrl7pP5ugkyeEu1OlgHosgGd+N4JgvMihIRf
 gCX3j6WPnyWyVkuAvkeT+yLclVd3g/w5pQSjpS9ZsAzDlJ8ecWduG7jZjAsJQvfrv1aG
 biBg==
X-Gm-Message-State: AOJu0YyugbYYqqQCyR9PgK5EHDLgwRaBZnIMTj3KaFQ5aogFo7oEv292
 Rd30d1BT9XBBls2AVFP2ZGB9Nw==
X-Google-Smtp-Source: AGHT+IFErtKSgxMID2r9Ej3XfKwIO80lGjbP2qypQotH+5dy9p1usl0DPCFKZa8XPw7UdB7DrDUAiw==
X-Received: by 2002:a17:90a:8a81:b0:26d:20ef:1d32 with SMTP id
 x1-20020a17090a8a8100b0026d20ef1d32mr4518862pjn.38.1693472018644; 
 Thu, 31 Aug 2023 01:53:38 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:d54:e521:8bac:7bed?
 ([2400:4050:a840:1e00:d54:e521:8bac:7bed])
 by smtp.gmail.com with ESMTPSA id
 p11-20020a17090adf8b00b002696bd123e4sm862407pjv.46.2023.08.31.01.53.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 01:53:38 -0700 (PDT)
Message-ID: <c933da5b-92fe-47f6-ade1-9c1e2770aa23@daynix.com>
Date: Thu, 31 Aug 2023 17:53:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] build: Only define OS_OBJECT_USE_OBJC with gcc
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20230830161425.91946-1-graf@amazon.com>
 <20230830161425.91946-2-graf@amazon.com>
 <996b4057-6d64-3803-792b-f6c49dd9f3bf@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <996b4057-6d64-3803-792b-f6c49dd9f3bf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/08/31 17:12, Philippe Mathieu-Daudé wrote:
> On 30/8/23 18:14, Alexander Graf wrote:
>> Recent versions of macOS use clang instead of gcc. The OS_OBJECT_USE_OBJC
>> define is only necessary when building with gcc. Let's not define it when
>> building with clang.
>>
>> With this patch, I can successfully include GCD headers in QEMU when
>> building with clang.
>>
>> Signed-off-by: Alexander Graf <graf@amazon.com>
>> ---
>>   meson.build | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/meson.build b/meson.build
>> index 98e68ef0b1..0d6a0015a1 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -224,7 +224,9 @@ qemu_ldflags = []
>>   if targetos == 'darwin'
>>     # Disable attempts to use ObjectiveC features in os/object.h since 
>> they
>>     # won't work when we're compiling with gcc as a C compiler.
>> -  qemu_common_flags += '-DOS_OBJECT_USE_OBJC=0'
>> +  if compiler.get_id() == 'gcc'
>> +    qemu_common_flags += '-DOS_OBJECT_USE_OBJC=0'
>> +  endif
>>   elif targetos == 'solaris'
>>     # needed for CMSG_ macros in sys/socket.h
>>     qemu_common_flags += '-D_XOPEN_SOURCE=600'
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 

Defining OS_OBJECT_USE_OBJC does not look like a proper solution. 
Looking at os/object.h, it seems OS_OBJECT_USE_OBJC is defined as 0 when:
!defined(OS_OBJECT_HAVE_OBJC_SUPPORT) && (!defined(__OBJC__) || 
defined(__OBJC_GC__))

This means OS_OBJECT_USE_OBJC is always 0 if Objective-C is disabled. I 
also confirmed os/object.h will not use Objective-C features when 
compiled as C code on clang with the following command:

clang -E -x -c - <<EOF
#include <os/object.h>
EOF

If compilation fails with GCC when not defining OS_OBJECT_USE_OBJC, it 
probably means GCC incorrectly treats C code as Objective-C and that is 
the problem we should solve. I cannot confirm this theory however since 
I have only an Apple Silicon Mac that is incompatible with GCC.

Regards,
Akihiko Odaki

