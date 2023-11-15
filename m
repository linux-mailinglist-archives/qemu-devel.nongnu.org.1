Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F06117EBD06
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 07:23:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r39It-0005Dd-TR; Wed, 15 Nov 2023 01:23:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r39Is-0005D8-78
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 01:23:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r39Iq-00009f-HF
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 01:23:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700029387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=j5uvAtvEWBhjW4ys1toV7amBUG+w9EcA15PmjCtfmVI=;
 b=FnM/VbbnTCwSOpE5trqzsGoJM8kVHZylUScM0fiTqn9/ZHWk9bmMtDxhysgv4ezcvOizZ/
 8r92VvYRSP2sRY7C5Rz2N3a8UAIo0FiG8ZNT+fhasFwYbdKE4ecIpvGqycnaFN1AxyaQuR
 10xAazq4hczo5uGkBXJ0YEdQuCvriQU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-JwvdBQV9MxuMNTvydSzfQQ-1; Wed, 15 Nov 2023 01:23:04 -0500
X-MC-Unique: JwvdBQV9MxuMNTvydSzfQQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32fd8da34fbso2935743f8f.1
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 22:23:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700029383; x=1700634183;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j5uvAtvEWBhjW4ys1toV7amBUG+w9EcA15PmjCtfmVI=;
 b=RsyCtdkaWvtS71KZhudWsfO8ae4jcqWWe8ddSR9lGyph7acO6esjbZZdjdKxXjIlk4
 rLcR2NLQp4H2n2TihXFU/SmD69Hc6RD1CwlF+X+kKIlXPPRsH2JtZv8g3LhJQHMd3WmA
 x1IslWN8a2CGmMvd4K/Et7D6DtDpneJiEPTnL2oN2l1QcqUR2AuDulD7Q5PhIuN8xo+9
 p8pdcloXz1tbzzFNxaGID1By21ABcYApK40L9jrlWkrpDxCBsY34LxefD1psa5SzFrzX
 xiLdB1TN7Q2u6qglZw+rwpBfDJUdZxnmynbvCGelTEWVEu+Z57IoXxKBfVYHoz7mhC9x
 Nj5w==
X-Gm-Message-State: AOJu0YwweSQ8s3K8l4XxnKF/3C+pTCQfyS1y03iav73F9qQ1TxX7LyDq
 h8z5iI9yyJo9Bj0PzyzZ0ZRnAsQposmy6TxMT6gagLaP+4IqenGx6wKF9FRFzFG1vf66Sc+NCnH
 Z400xSmIIpqZEHfQ=
X-Received: by 2002:a5d:4dc1:0:b0:314:15b7:20a5 with SMTP id
 f1-20020a5d4dc1000000b0031415b720a5mr7813558wru.54.1700029383515; 
 Tue, 14 Nov 2023 22:23:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFl5ARGu3dvnB+JFmO+vq0Vgcg9xzRlYhiG3adVEq8UCATAwko56tYa4soFvlog4tHvB+lAtg==
X-Received: by 2002:a5d:4dc1:0:b0:314:15b7:20a5 with SMTP id
 f1-20020a5d4dc1000000b0031415b720a5mr7813546wru.54.1700029383178; 
 Tue, 14 Nov 2023 22:23:03 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-176-122.web.vodafone.de.
 [109.43.176.122]) by smtp.gmail.com with ESMTPSA id
 z14-20020adff74e000000b0032f7865a4c7sm9546624wrp.21.2023.11.14.22.23.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 22:23:02 -0800 (PST)
Message-ID: <6877d6d6-bfbf-4475-8c61-dd537265b278@redhat.com>
Date: Wed, 15 Nov 2023 07:23:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/avocado/reverse_debugging: Disable the ppc64 tests
 by default
Content-Language: en-US
To: John Snow <jsnow@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 John Snow <jsnow@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20231114163115.298041-1-thuth@redhat.com>
 <12b4420e-1440-4516-8276-e0e907003c16@linaro.org>
 <9f6247e4-7e81-44f8-a63b-8ee11f722710@redhat.com>
 <CWYYRW53VEPJ.3UL1X7GB1P4H2@wheely>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CWYYRW53VEPJ.3UL1X7GB1P4H2@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 15/11/2023 02.15, Nicholas Piggin wrote:
> On Wed Nov 15, 2023 at 4:29 AM AEST, Thomas Huth wrote:
>> On 14/11/2023 17.37, Philippe Mathieu-Daudé wrote:
>>> On 14/11/23 17:31, Thomas Huth wrote:
>>>> The tests seem currently to be broken. Disable them by default
>>>> until someone fixes them.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>    tests/avocado/reverse_debugging.py | 7 ++++---
>>>>    1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> Similarly, I suspect https://gitlab.com/qemu-project/qemu/-/issues/1961
>>> which has a fix ready:
>>> https://lore.kernel.org/qemu-devel/20231110170831.185001-1-richard.henderson@linaro.org/
>>>
>>> Maybe wait the fix gets in first?
>>
>> No, I applied Richard's patch, but the problem persists. Does this test
>> still work for you?
> 
> I bisected it to 1d4796cd008373 ("python/machine: use socketpair() for
> console connections"),

Maybe John (who wrote that commit) can help?

  Thomas


> which causes this halfway through the test:
> 
> 2023-11-15 10:37:04,600 stacktrace       L0045 ERROR| Traceback (most recent call last):
> 2023-11-15 10:37:04,600 stacktrace       L0045 ERROR|   File "/home/npiggin/src/qemu/build/pyvenv/lib/python3.11/site-packages/avocado/core/decorators.py", line 90, in wrapper
> 2023-11-15 10:37:04,600 stacktrace       L0045 ERROR|     return function(obj, *args, **kwargs)
> 2023-11-15 10:37:04,600 stacktrace       L0045 ERROR|            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 2023-11-15 10:37:04,600 stacktrace       L0045 ERROR|   File "/home/npiggin/src/qemu/build/tests/avocado/reverse_debugging.py", line 264, in test_ppc64_powernv
> 2023-11-15 10:37:04,600 stacktrace       L0045 ERROR|     self.reverse_debugging()
> 2023-11-15 10:37:04,600 stacktrace       L0045 ERROR|   File "/home/npiggin/src/qemu/build/tests/avocado/reverse_debugging.py", line 173, in reverse_debugging
> 2023-11-15 10:37:04,600 stacktrace       L0045 ERROR|     g.cmd(b'c')
> 2023-11-15 10:37:04,600 stacktrace       L0045 ERROR|   File "/home/npiggin/src/qemu/build/pyvenv/lib/python3.11/site-packages/avocado/utils/gdb.py", line 783, in cmd
> 2023-11-15 10:37:04,600 stacktrace       L0045 ERROR|     response_payload = self.decode(result)
> 2023-11-15 10:37:04,600 stacktrace       L0045 ERROR|                        ^^^^^^^^^^^^^^^^^^^
> 2023-11-15 10:37:04,600 stacktrace       L0045 ERROR|   File "/home/npiggin/src/qemu/build/pyvenv/lib/python3.11/site-packages/avocado/utils/gdb.py", line 738, in decode
> 2023-11-15 10:37:04,600 stacktrace       L0045 ERROR|     raise InvalidPacketError
> 2023-11-15 10:37:04,600 stacktrace       L0045 ERROR| avocado.utils.gdb.InvalidPacketError
> 2023-11-15 10:37:04,600 stacktrace       L0046 ERROR|
> 
> It doesn't always fail the same gdb command
> (I saw a bc on line 182 as well). It seems to be receiving a
> zero length response?
> 
> No idea what's happening or why ppc seems to be more fragile.
> Or why changing console connection affects gdb connection?
> 
> Thanks,
> Nick
> 


