Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 516397782AF
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 23:29:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUDDT-0002Se-K6; Thu, 10 Aug 2023 17:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qUDDR-0002S3-Cw
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 17:29:09 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qUDDO-0008Qn-MM
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 17:29:09 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bda9207132so6903235ad.0
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 14:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691702945; x=1692307745;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fdaAjU7eu7/6zjq9wYdV7oXA7Fcrn6qUknenq/F/BCA=;
 b=SeqUB7EIBMS6LOHPLBEU/TfaZKx7p0lEfSOxqtlbVkEKAE5cqei9ECIa/JKP4/ef8A
 mpIyK5VWPzgB7zuD+m00jhcEQhpg1IzIOILXmIRnmptzK0zLouDyNRY+l7kTCt2MYZH+
 ocuI8NX+kWzVtMqwlZZyZYlkn5rzwSgFvQE7RH5LxWleUe3tUwX9e4sd8d6hCRCFvgs7
 QonDeJzuRswJgkAJlHemMsD3PBOxEfVnx86RRC9tOmeredZMZVm7mEwrZpu/7K8jaIOb
 j2tkmqL4moRDnzgaaabJYkQXJnHzwhrUijaGp27CiKJ0nlaqv9/1mdwZHP3QrFsADlyd
 kFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691702945; x=1692307745;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fdaAjU7eu7/6zjq9wYdV7oXA7Fcrn6qUknenq/F/BCA=;
 b=izin+QUlsucsREaxlV+Qc8qsOqIxnNET50f9nz9O1mR5FhiSCT9HqGcnqbaBUxlLuZ
 3PDtNDrMaBgtzJ/XAnVkNG4jGy7Oq8QpsUzVQ+2LhNGljA1LegY9dFTYh0MMBWbZdzzN
 giA//bzshazuUXelnjnc9qoleaGg533Uh98QDwEuXElbakokpOWmy697G6nMp0fXP2gF
 VIrzb1p9NSUoGtH4aZ/NEx0AABqQ6QEL2UtnPAn+Hak9OIsdJkIP7rGi9tRCuU5fgJdO
 jljZ/c0R4/K0tBuQed29Gaf9dg2UgFBglnZKeNY7fPP8knV6hueURGr8F1vrH8SAOZR8
 sgnw==
X-Gm-Message-State: AOJu0Yxc0B28D7jl4VcAG0iOuqWff+zr+qFUvLVCXx/T1Yi1cy8WA71a
 n7YISrfXpkalbwGCOgvZtklqnA==
X-Google-Smtp-Source: AGHT+IG0SSx2O61rI5h49aMBb+2UJYezyHYRbBQRhEC8+JwLg0AeH8om1ehazPLP1RnpMzf58rUapw==
X-Received: by 2002:a17:902:ce84:b0:1b8:971c:b7b7 with SMTP id
 f4-20020a170902ce8400b001b8971cb7b7mr4366054plg.56.1691702944982; 
 Thu, 10 Aug 2023 14:29:04 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 w18-20020a170902e89200b001bb9f104330sm2245273plg.240.2023.08.10.14.29.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 14:29:04 -0700 (PDT)
Message-ID: <00d65683-47ea-44dc-889b-130cd6d1483e@daynix.com>
Date: Fri, 11 Aug 2023 06:29:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thunk: Delete checks for old host definitions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 deller@gmx.de, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pbonzini@redhat.com, laurent@vivier.eu, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>
References: <20230808152314.102036-1-akihiko.odaki@daynix.com>
 <f61ff7ff-44a2-14c3-da08-755c290c75b7@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <f61ff7ff-44a2-14c3-da08-755c290c75b7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
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

On 2023/08/10 19:56, Philippe Mathieu-Daudé wrote:
> Helge and myself sometime run the tests on a HPPA host
> (testing the QEMU tools). I guess remember John Paul
> also runs some on Alpha (so Cc'ing him).
> 
> Helge, what is your take on this?

This file is only used in userspace emulation so it's not a problem for 
Alpha, which does no longer have userspace emulation.

The story is different for HPPA. HPPA has userspace emulation code and 
there are also references for HOST_HPPA in coroutine code 
(util/async-teardown.c and util/os-posix.c). Probably HPPA support is 
broken both for userspace and system emulation. I think it's time to 
think of dropping HPPA support for both of userspace and system emulation.

> 
> On 8/8/23 17:23, Akihiko Odaki wrote:
>> Alpha, IA-64, and PA-RISC hosts are no longer supported.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   include/exec/user/thunk.h | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/include/exec/user/thunk.h b/include/exec/user/thunk.h
>> index 300a840d58..d9c131ec80 100644
>> --- a/include/exec/user/thunk.h
>> +++ b/include/exec/user/thunk.h
>> @@ -111,8 +111,7 @@ static inline int thunk_type_size(const argtype 
>> *type_ptr, int is_host)
>>           if (is_host) {
>>   #if defined(HOST_X86_64)
>>               return 8;
>> -#elif defined(HOST_ALPHA) || defined(HOST_IA64) || defined(HOST_MIPS) 
>> || \
>> -      defined(HOST_PARISC) || defined(HOST_SPARC64)
>> +#elif defined(HOST_MIPS) || defined(HOST_SPARC64)
>>               return 4;
>>   #elif defined(HOST_PPC)
>>               return sizeof(void *);
> 

