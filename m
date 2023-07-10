Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3298174CD54
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 08:41:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIkaA-0000p1-0c; Mon, 10 Jul 2023 02:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIka4-0000iI-BC
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 02:41:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIka1-0000ve-MM
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 02:41:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688971262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/TmdGdncJnnM9h/zhSZ1pC4j+BsFgGEGwlB+ngGyjUQ=;
 b=OrQ6/G2UVqkGrTYeog9gDG7q1mBdv8GPEl0kC/nzbzy7XsPFiiBgIheOZVTVy8kaWdhKfX
 RL08mPsbIFmy4wCC4bcQGXGZESYgtXR++cRsaJsPdN6E+m2O7U0MDqkdcykprin5dXyoV9
 ZEhfM37r/Mt2Lxn1Ih3+0wUH4/axnwU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-VDJW6rIGNQCg6HzZFT1Uqg-1; Mon, 10 Jul 2023 02:41:01 -0400
X-MC-Unique: VDJW6rIGNQCg6HzZFT1Uqg-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7675fc3333eso284026985a.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 23:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688971261; x=1691563261;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/TmdGdncJnnM9h/zhSZ1pC4j+BsFgGEGwlB+ngGyjUQ=;
 b=hWVuEaz6Np/OoNpdPwmKMxxW/clWJMpgbQMtJAxNnQ8uVnFMITF6O0eWqawbDLXyAa
 Up9WC3JYx+wPADRqrP7HlPwQLGvgSEgyZkuui0lrYIp49lkiXxOCwOshiPExTa5wwb6p
 hnENHKqI9VOmIz18l5YQZ2o7wiEAdaV8uEpaZnp/ZJjnhnfo1Y6+wLzA1fT2Uw9AHcGX
 M+NhyldGipFzhOkE5+CWVdYVYqHQ64VibJT2H4NWU75zWCaGLRE5tVcJHnLtMYnOrs2T
 ND+zM6PxkjBnOjzskOGvfAl3puy1P5soqSY8Gz28Rupcwo1Bek+4s9leXsorxGQXNVQD
 kO2w==
X-Gm-Message-State: ABy/qLakkJZWQkmLHX5LjpjL6gwkU/IEcrrywb0TLBwxuD+L4fHt6Z3L
 pzPe+axdlDpXUROTlY7OiCyuV4dHFIfNSpnhALS4ByndCB4jwBhwUPF4LZbrrmBNxIgI4Hs3npi
 kjfgrBgsm3ArN4xY=
X-Received: by 2002:a05:620a:4092:b0:765:591d:9d22 with SMTP id
 f18-20020a05620a409200b00765591d9d22mr18736152qko.0.1688971260918; 
 Sun, 09 Jul 2023 23:41:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlECyHUay21Vpo/vbn+L48ZK8s9CNwVt3rpKqQ3R3qMm85xbSz+PRh1WnVnG1oGY1OzQUlvKJA==
X-Received: by 2002:a05:620a:4092:b0:765:591d:9d22 with SMTP id
 f18-20020a05620a409200b00765591d9d22mr18736143qko.0.1688971260660; 
 Sun, 09 Jul 2023 23:41:00 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-116.web.vodafone.de.
 [109.43.179.116]) by smtp.gmail.com with ESMTPSA id
 b6-20020ac86786000000b003f9b9d7f319sm4656865qtp.70.2023.07.09.23.40.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Jul 2023 23:41:00 -0700 (PDT)
Message-ID: <3c9ced25-4886-1a4a-c711-fe538752495c@redhat.com>
Date: Mon, 10 Jul 2023 08:40:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/4] QGA VSS: Add wrapper to send log to debugger and
 stderr
To: Konstantin Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Eric Blake <eblake@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230707092258.768420-1-kkostiuk@redhat.com>
 <20230707092258.768420-2-kkostiuk@redhat.com>
 <c540330e-0adb-52a2-ab12-ba098212ce6f@linaro.org>
 <CAPMcbCrr6DxbNYRxm1uztaA7GG2A_MDb49VHuy26Cs7XA3bAuw@mail.gmail.com>
 <20f5fded-a486-c184-9ee0-1e91c178d5fd@linaro.org>
 <CAPMcbCrnM=1P7rjp+D_ei_R+e3QYSWDwfpJg2=ooC307p_qbBQ@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <CAPMcbCrnM=1P7rjp+D_ei_R+e3QYSWDwfpJg2=ooC307p_qbBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
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

On 07/07/2023 22.22, Konstantin Kostiuk wrote:
> 
> 
> On Fri, Jul 7, 2023 at 6:36 PM Philippe Mathieu-Daudé <philmd@linaro.org 
> <mailto:philmd@linaro.org>> wrote:
> 
>     On 7/7/23 16:24, Konstantin Kostiuk wrote:
>      >
>      >
>      > On Fri, Jul 7, 2023 at 1:33 PM Philippe Mathieu-Daudé
>     <philmd@linaro.org <mailto:philmd@linaro.org>
>      > <mailto:philmd@linaro.org <mailto:philmd@linaro.org>>> wrote:
>      >
>      >     On 7/7/23 11:22, Konstantin Kostiuk wrote:
>      >      > Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com
>     <mailto:kkostiuk@redhat.com>
>      >     <mailto:kkostiuk@redhat.com <mailto:kkostiuk@redhat.com>>>
>      >      > ---
>      >      >   qga/vss-win32/meson.build   |  2 +-
>      >      >   qga/vss-win32/vss-debug.cpp | 31 +++++++++++++++++++++++++++++++
>      >      >   qga/vss-win32/vss-debug.h   | 25 +++++++++++++++++++++++++
>      >      >   3 files changed, 57 insertions(+), 1 deletion(-)
>      >      >   create mode 100644 qga/vss-win32/vss-debug.cpp
>      >      >   create mode 100644 qga/vss-win32/vss-debug.h
>      >
>      >
>      >      > diff --git a/qga/vss-win32/vss-debug.cpp
>      >     b/qga/vss-win32/vss-debug.cpp
>      >      > new file mode 100644
>      >      > index 0000000000..5d6f37944b
>      >      > --- /dev/null
>      >      > +++ b/qga/vss-win32/vss-debug.cpp
>      >      > @@ -0,0 +1,31 @@
>      >      > +/*
>      >      > + * QEMU Guest Agent VSS debug declarations
>      >      > + *
>      >      > + * Copyright (C) 2023 Red Hat Inc
>      >      > + *
>      >      > + * Authors:
>      >      > + *  Konstantin Kostiuk <kkostiuk@redhat.com
>     <mailto:kkostiuk@redhat.com>
>      >     <mailto:kkostiuk@redhat.com <mailto:kkostiuk@redhat.com>>>
>      >      > + *
>      >      > + * This work is licensed under the terms of the GNU GPL, version
>      >     2 or later.
>      >      > + * See the COPYING file in the top-level directory.
>      >      > + */
>      >      > +
>      >      > +#include "qemu/osdep.h"
>      >      > +#include "vss-debug.h"
>      >      > +#include "vss-common.h"
>      >      > +
>      >      > +void qga_debug_internal(const char *funcname, const char *fmt,
>      >     ...)  {
>      >      > +    char user_sting[512] = {0};
>      >
>      >     "user_string"
>      >
>      >      > +    char full_string[640] = {0};
>      >      > +
>      >      > +    va_list args;
>      >      > +    va_start(args, fmt);
>      >      > +    vsnprintf(user_sting, 512, fmt, args);
>      >
>      >     ARRAY_SIZE(user_string)
>      >
>      >
>      > I have a problem with ARRAY_SIZE define.
>      >
>      > ../qga/vss-win32/vss-debug.cpp: In function 'void
>      > qga_debug_internal(const char*, const char*, ...)':
>      > /src/include/qemu/compiler.h:70:12: error: types may not be defined in
>      > 'sizeof' expressions
>      >     70 |     struct { \
>      >        |            ^
>      > /src/include/qemu/compiler.h:78:43: note: in expansion of macro
>      > 'QEMU_BUILD_BUG_ON_STRUCT'
>      >     78 | #define QEMU_BUILD_BUG_ON_ZERO(x)
>      > (sizeof(QEMU_BUILD_BUG_ON_STRUCT(x)) - \
>      >        |                                          
>     ^~~~~~~~~~~~~~~~~~~~~~~~
>      > /src/include/qemu/osdep.h:474:24: note: in expansion of macro
>      > 'QEMU_BUILD_BUG_ON_ZERO'
>      >    474 |                      
>       QEMU_BUILD_BUG_ON_ZERO(!QEMU_IS_ARRAY(x)))
>      >        |                        ^~~~~~~~~~~~~~~~~~~~~~
>      > ../qga/vss-win32/vss-debug.cpp:23:32: note: in expansion of macro
>      > 'ARRAY_SIZE'
>      >     23 |     if (vsnprintf(user_string, ARRAY_SIZE(user_string), fmt,
>      > args) <= 0) {
>      >        |                                ^~~~~~~~~~
>      > /src/include/qemu/osdep.h:470:57: error: expected primary-expression
>      > before 'typeof'
>      >    470 | #define QEMU_IS_ARRAY(x)
>      > (!__builtin_types_compatible_p(typeof(x), \
>      >        |                                                         ^~~~~~
>      > /src/include/qemu/compiler.h:71:14: note: in definition of macro
>      > 'QEMU_BUILD_BUG_ON_STRUCT'
>      >     71 |         int:(x) ? -1 : 1; \
>      >        |              ^
>      > /src/include/qemu/osdep.h:474:24: note: in expansion of macro
>      > 'QEMU_BUILD_BUG_ON_ZERO'
>      >    474 |                      
>       QEMU_BUILD_BUG_ON_ZERO(!QEMU_IS_ARRAY(x)))
>      >        |                        ^~~~~~~~~~~~~~~~~~~~~~
>      > /src/include/qemu/osdep.h:474:48: note: in expansion of macro
>      > 'QEMU_IS_ARRAY'
>      >    474 |                      
>       QEMU_BUILD_BUG_ON_ZERO(!QEMU_IS_ARRAY(x)))
>      >
>      > Can you help with this?
> 
>     Eh no clue, maybe not C++ compliant?
> 
>     Fall back to sizeof() ¯\_(ツ)_/¯
> 
> 
> You are right, When I rename the file to vss-debug.c the error disappears.
> What is the better solution:
> 1) use vss-debug.c and extern "C" { #include "vss-debug.h" } in CPP files
> 2) just use sizeof() in CPP

I recently sent a patch to drop the logic for linking C code with C++ code:

  https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg01553.html

So please go with option 2 ;-)

  Thomas


