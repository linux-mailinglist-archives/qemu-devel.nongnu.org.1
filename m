Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76619779E72
	for <lists+qemu-devel@lfdr.de>; Sat, 12 Aug 2023 11:17:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUkji-0000ev-0I; Sat, 12 Aug 2023 05:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qUkjg-0000eW-FH
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 05:16:40 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qUkje-0007ch-Jc
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 05:16:40 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6bca5d6dcedso2555890a34.1
 for <qemu-devel@nongnu.org>; Sat, 12 Aug 2023 02:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691831797; x=1692436597;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fppUk3q7ZyUNtuisd5QuM7JLN5jwNpZy0Yh5ebQVRKI=;
 b=AOeuv3Wy1bp77uQIeEgApXaiukhqXRZ9PY4sWQXw6XgGg+DHr7F2HavyTgmyADcWkH
 VryxRxOV6vBs2KlY0WMQ0syJJxS9caM4VFgejXTvneibrp7T3kUDjJa2jZ5gPb07ouIv
 gwOiU9JescXOJvXiS9KQsf8a1f6UMqkgcv2Jnwi6LCfvcDylD53r+buZqlp8tUpHeDHn
 gyvCtgNU9ngPnf6HphpuLU9BAhWnwiiSGvNj7x3BVuqk3wIhZUzELTUi5NOob0sz8f0i
 dKvHytDUYOkkZR8EwcLlIPPvSX9eGHDBBEXFIqZ29zQLhMKTYxOwc9IKtjH02R4M1FcG
 /wBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691831797; x=1692436597;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fppUk3q7ZyUNtuisd5QuM7JLN5jwNpZy0Yh5ebQVRKI=;
 b=Wdm0EKgnazINg3TBbNsUsFhoRLvs/SOChSxkzYxdtjEBkdaVQxdtQna7Zj5Vx9ulVm
 dW7Il966vXXMIdk61WhJwAl+lrvhEidCUlHAjJvsfS5je5+HS77S7uvlytgGYiTq2p03
 F7F4vVYgaSruf+0bJVV/NGR6AAY+qovLUsaim/SeLZ34OSIcnrguQQZdJE7Wrkuej+k9
 1AJ8p6OE2lY506mQc7A+sqsJHUZqGhSK3q4JBBv1znMMzD+V1XgCtdr4iyUESZf259QZ
 uFd5fYaQKgxA5BIHsSN2c0rOTWA8ZLx5L4FT6VkCjuUQalkqJKATHh6T+0SfmFrTiMPt
 ww2Q==
X-Gm-Message-State: AOJu0Yx0ulNxLAblVUwxGdsn1KEJwDm6Yo+B4DKmIpxYVHLCT2HaAs2x
 0FM3ZnoWkCpENMpJ8ytTGzNMgw==
X-Google-Smtp-Source: AGHT+IGeMmjCD15Y4UQnuNnSHs5BO6In6b220i1uCt2wpzkYX6kbLlaSmolFMiih6SfMOrXws0TsQg==
X-Received: by 2002:a05:6871:6a5:b0:19f:4dc2:428e with SMTP id
 l37-20020a05687106a500b0019f4dc2428emr5197609oao.14.1691831797195; 
 Sat, 12 Aug 2023 02:16:37 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 c6-20020a17090a674600b0026b25c05495sm2610001pjm.20.2023.08.12.02.16.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Aug 2023 02:16:36 -0700 (PDT)
Message-ID: <c9f3232c-5103-410c-a158-e56d26331968@daynix.com>
Date: Sat, 12 Aug 2023 18:16:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: Fix MESONINTROSPECT parsing
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
References: <20230812061540.5398-1-akihiko.odaki@daynix.com>
 <8bb503c3-5b45-f686-a0d8-24799d69f6b1@tls.msk.ru>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <8bb503c3-5b45-f686-a0d8-24799d69f6b1@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::334;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x334.google.com
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

On 2023/08/12 17:01, Michael Tokarev wrote:
> 12.08.2023 09:15, Akihiko Odaki wrote:
>> The arguments in MESONINTROSPECT are quoted with shlex.quote() so it
>> must be parsed with shlex.split().
>>
>> Fixes: cf60ccc330 ("cutils: Introduce bundle mechanism")
>> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   scripts/symlink-install-tree.py | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/scripts/symlink-install-tree.py 
>> b/scripts/symlink-install-tree.py
>> index 8ed97e3c94..b72563895c 100644
>> --- a/scripts/symlink-install-tree.py
>> +++ b/scripts/symlink-install-tree.py
>> @@ -4,6 +4,7 @@
>>   import errno
>>   import json
>>   import os
>> +import shlex
>>   import subprocess
>>   import sys
>> @@ -14,7 +15,7 @@ def destdir_join(d1: str, d2: str) -> str:
>>       return str(PurePath(d1, *PurePath(d2).parts[1:]))
>>   introspect = os.environ.get('MESONINTROSPECT')
>> -out = subprocess.run([*introspect.split(' '), '--installed'],
>> +out = subprocess.run([*shlex.split(introspect), '--installed'],
>>                        stdout=subprocess.PIPE, check=True).stdout
>>   for source, dest in json.loads(out).items():
>>       bundle_dest = destdir_join('qemu-bundle', dest)
> 
> This fixes one of the two issues, - the script is being run
> now without failures.
> 
> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
> Tested-by: Michael Tokarev <mjt@tls.msk.ru>
> 
> There's one more possible problem which is worth to fix, I'd say:
> it is the fact that script failure is not detected in any way.
> Shouldn't subprocess.run raise an exception in case of failure?
> I think it needs check=True (since python 3.5 iirc).

I missed that you noted this failure is not detected by configure. It is 
certainly better to fix.

It does have check=True but it's rather a obfuscated way to say that 
when you can just use subprocess.check_output(). I sent another patch to 
use subprocess.check_output().

The reason why configure does not detect the failure is that Meson 
ignores postconf script failures. I opened a pull request upstream:
https://github.com/mesonbuild/meson/pull/12115

Regards,
Akihiko Odaki

