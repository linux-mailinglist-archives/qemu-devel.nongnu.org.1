Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CA87BD85D
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 12:17:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpnJ9-0006Vs-Hk; Mon, 09 Oct 2023 06:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qpnIU-0006QA-Dr
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 06:15:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qpnIS-0002Rl-OD
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 06:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696846531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HeK/vN9i7iLTiy9XhZqQ1Rwner7hXxkvjNX13Raukhk=;
 b=Eep3utm5WAruV6gJfmNcDuVx1ThM0sztuz9BYo7GWj8QVp+emvhFgKuP4jRiMKArUKOWZM
 sqaMJ20kaAGxxSs7IRckfxkvgzD4AmfyWWBDG6riVX8TK5p/TZHfVl4RpyGKO3Sh4z3bX4
 08CBE5pxs+clhi192LbCnLUv7xrsTLk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-Hs6kybmeMpWVQGVjpmkchw-1; Mon, 09 Oct 2023 06:15:20 -0400
X-MC-Unique: Hs6kybmeMpWVQGVjpmkchw-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-419393cfde9so48939671cf.2
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 03:15:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696846520; x=1697451320;
 h=content-transfer-encoding:in-reply-to:subject:references:cc:to:from
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HeK/vN9i7iLTiy9XhZqQ1Rwner7hXxkvjNX13Raukhk=;
 b=GyFD8Tm+SV5tPmSSP7/tdinBmBeMEAFZmFtwmGHTn1Caf1oe0YGQXyqA/O3xw/xk0D
 1lGVU32+G4v9zJeL/9ggzcfNyhW2nTt/dsD+c2rXHGlZzoOanMKLJ3Z2j+UT80KSflEF
 fMfMIczXDS/QteLlKK6pz+GIE2O2BUCOKXvCZGb5ouHNyWuc68dbPJmjIuIXUgc3Y5Pn
 RRSRAgCzZ6C2btM+L0PARriWPtAdq+6+GwFRuo5rdQGwb93rGNun+UhzEBcqJgVqIygF
 0ZuoJoye5qq2AJHni9dfLgdV2fecm538fKfk4fuZ5tjuRIeirxH9E1aebVUfOQsdKgyD
 7CnA==
X-Gm-Message-State: AOJu0Yykfbf/8qq+cLU50POiud+/rtTr6n5RpQEho+hOf8RB8I9TPc6y
 iyubUWIkVWgL8XACUENotF1UWtL8zVJVUokSYeQACrn5z+wVeM2XcJoqYpLHkdDuo7HcF0LHhj4
 XpswKpxtHSnOk87I=
X-Received: by 2002:a05:622a:199d:b0:418:ff8:3833 with SMTP id
 u29-20020a05622a199d00b004180ff83833mr18681679qtc.52.1696846519970; 
 Mon, 09 Oct 2023 03:15:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4kgZlnaSaFDeLyFJU83E+n3+K+hksMb+XwckjHeixLDolPCUz3GkCQLZNu7FfgEzPhI+13g==
X-Received: by 2002:a05:622a:199d:b0:418:ff8:3833 with SMTP id
 u29-20020a05622a199d00b004180ff83833mr18681661qtc.52.1696846519694; 
 Mon, 09 Oct 2023 03:15:19 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-27.web.vodafone.de.
 [109.43.176.27]) by smtp.gmail.com with ESMTPSA id
 h5-20020ac85685000000b004198f67acbesm3524320qta.63.2023.10.09.03.15.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 03:15:19 -0700 (PDT)
Message-ID: <e49485e5-c75a-27f1-7ad3-899b1c208077@redhat.com>
Date: Mon, 9 Oct 2023 12:15:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20231005173812.966264-1-berrange@redhat.com>
 <20231005173812.966264-3-berrange@redhat.com>
 <c28a1d44-8e7e-a351-8efa-28566e9fc306@redhat.com>
Subject: Re: [PATCH 2/2] meson: mitigate against use of uninitialize stack for
 exploits
In-Reply-To: <c28a1d44-8e7e-a351-8efa-28566e9fc306@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.818, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 09/10/2023 09.44, Thomas Huth wrote:
> On 05/10/2023 19.38, Daniel P. Berrangé wrote:
>> When variables are used without being initialized, there is potential
>> to take advantage of data that was pre-existing on the stack from an
>> earlier call, to drive an exploit.
>>
>> It is good practice to always initialize variables, and the compiler
>> can warn about flaws when -Wuninitialized is present. This warning,
>> however, is by no means foolproof with its output varying depending
>> on compiler version and which optimizations are enabled.
>>
>> The -ftrivial-auto-var-init option can be used to tell the compiler
>> to always initialize all variables. This increases the security and
>> predictability of the program, closing off certain attack vectors,
>> reducing the risk of unsafe memory disclosure.
>>
>> While the option takes several possible values, using 'zero' is
>> considered to be the  option that is likely to lead to semantically
>> correct or safe behaviour[1]. eg sizes/indexes are not likely to
>> lead to out-of-bounds accesses when initialized to zero. Pointers
>> are less likely to point something useful if initialized to zero.
>>
>> Even with -ftrivial-auto-var-init=zero set, GCC will still issue
...
>> +    '-ftrivial-var-auto-init=zero',
>>   ]

There is something fishy here: In the commit description, you write about 
"-ftrivial-auto-var-init" but in the code you use "-ftrivial-var-auto-init" 
... that looks wrong to me, please fix!

> I was a little bit torn about using =zero when I first read your patch, but 
> after looking at [1], I tend now also tend to agree that =zero is likely the 
> best choice.

Thinking about this twice: What about using -ftrivial-var-auto-init=pattern 
for --enable-debug builds, and only use the "zero" init for non-debug 
builds? ... that would prevent that people blindly rely on this "language 
extension".

  Thomas



