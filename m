Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4347F282F
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 09:57:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5MYl-0002mm-BE; Tue, 21 Nov 2023 03:56:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r5MYi-0002ki-Is
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:56:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r5MYe-0004Ci-MG
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:56:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700556994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FMD9yZVXlxBfZdi7sAmf/3KQxo9SgdSCVMvcnZwJiPo=;
 b=T9VZIfNnU+8qX/QS48JSCoOb7n+SXZFxA9maPeCpf3izMEAGIn28xXxnBIRJB7ubbM5T07
 zzxRYgQtGe7qvJQx7/0el5XDmUI6+p4NA8SSYUzr5lWCrKYnzzW0ouFaZ+gPb7rb+XtECh
 7EMXcjTPDwv6dO28YKZg1fEoq+9K+94=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-e-Ts2zSaOva3PxCsWr_AlQ-1; Tue, 21 Nov 2023 03:56:28 -0500
X-MC-Unique: e-Ts2zSaOva3PxCsWr_AlQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2c53c85e482so49489071fa.1
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 00:56:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700556987; x=1701161787;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FMD9yZVXlxBfZdi7sAmf/3KQxo9SgdSCVMvcnZwJiPo=;
 b=vDjWwvKVGfAeNLW0puZrlVZCe8C5GoHEWTW1FNc2JWWWBLObVNRhgFDXT2+e9kmHQI
 pDIfA/KatITfu1KgN2Iq0EaEBPFIWAW4sQTGNqV47yZJciYMtYK6OwfoXKhBTQloGHBB
 ATnalRWvqQuVbAscmbLnZRh+WO6vSU+rjJxPodP6fFKFG/DhHCaZMSXBUJs2IKpuDAxX
 3Cn+Tppr+g6Vh2Olhxw1+BnQjj0mXDZSvs9k2SrvGL1+Nwux2xb7HGbWhXvdGB94E0wA
 j19UQGQ96Vdtuhea/VJe1/J98Xxjyi5zxI2RCHjzJDb3qfOsRG6nNBNwE3qFFxSjvgES
 NYhg==
X-Gm-Message-State: AOJu0Yz3eZ232eryQshTLID7Iv0PhnU68wNedPhY0LGOz/v2qCeTkMU7
 92VroXNG5hOZJvCNXQ3BknBiOvp3Pi9Q4cR5kbGqqNcQZkI4iMnDka6NOEmSdVZ9uAAQriKr6a/
 nPQ3mD3e5J/qpTP8s4G9idAg=
X-Received: by 2002:a05:6512:aca:b0:50a:a9e1:6c58 with SMTP id
 n10-20020a0565120aca00b0050aa9e16c58mr7112813lfu.32.1700556987149; 
 Tue, 21 Nov 2023 00:56:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0DPOZVfw3yGohsLrbD8IjvZ48kF4ZopYwObEKR0imV6o5VxvX0MTv62Ptqh/xNVeRn03aNA==
X-Received: by 2002:a05:6512:aca:b0:50a:a9e1:6c58 with SMTP id
 n10-20020a0565120aca00b0050aa9e16c58mr7112785lfu.32.1700556986792; 
 Tue, 21 Nov 2023 00:56:26 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-176-233.web.vodafone.de.
 [109.43.176.233]) by smtp.gmail.com with ESMTPSA id
 b8-20020aa7dc08000000b00543597cd190sm4555096edu.47.2023.11.21.00.56.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Nov 2023 00:56:26 -0800 (PST)
Message-ID: <31850f05-7849-402d-b3ae-623e76b52953@redhat.com>
Date: Tue, 21 Nov 2023 09:56:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tests/avocado: Enable reverse_debugging.py tests in
 gitlab CI
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20231116115354.228678-1-npiggin@gmail.com>
 <20231116115354.228678-3-npiggin@gmail.com>
 <24a194bc-81c6-44ae-9113-94ed28cc4f71@redhat.com>
 <CX0WX30H69LM.3MYDJODZ4LQWF@wheely>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CX0WX30H69LM.3MYDJODZ4LQWF@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

On 17/11/2023 08.35, Nicholas Piggin wrote:
> On Fri Nov 17, 2023 at 4:11 AM AEST, Thomas Huth wrote:
>> On 16/11/2023 12.53, Nicholas Piggin wrote:
>>> Let's try enable reverse_debugging.py in gitlab CI.
>>>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> ---
>>> Maybe we could try this again at some point? The bug might have been
>>> noticed sooner.
>>>
>>> They only take a couple of seconds to run so should not take too much
>>> overhead. But my gitlab CI pipeline doesn't run the avocado tests for
>>> some reason, so I can't see if it's still causing problems.
>>>
>>> Thanks,
>>> Nick
>>> ---
>>>
>>>    tests/avocado/reverse_debugging.py | 7 -------
>>>    1 file changed, 7 deletions(-)
>>
>> FYI, I gave it a try, and it survived my CI run:
>>
>>    https://gitlab.com/thuth/qemu/-/jobs/5552213972#L403
>>
>> So I went ahead and put it (together with the first patch) in my current
>> pull request, let's see how it goes...
> 
> Great, thank you.

... and here it's failing again (current master branch):

https://gitlab.com/thuth/qemu/-/jobs/5582657378#L404

According to the debug.log in the artifacts, it's failing here:

08:28:32 DEBUG| [    0.230392217,5] OPAL v7.0 starting...

08:28:32 DEBUG| [    0.230674939,7] initial console log level: memory 7, driver 5

08:28:32 DEBUG| [    0.231048494,6] CPU: P9 generation processor (max 4 threads/core)

08:28:32 DEBUG| [
08:28:32 DEBUG| [    0.231412547,7] CPU: Boot CPU PIR is 0x0000 PVR is 0x004e1202

08:28:32 DEBUG| [
08:28:32 ERROR|
08:28:32 ERROR| Reproduced traceback from: /builds/thuth/qemu/build/pyvenv/lib64/python3.8/site-packages/avocado/core/test.py:770
08:28:32 ERROR| Traceback (most recent call last):
08:28:32 ERROR|   File "/builds/thuth/qemu/build/tests/avocado/reverse_debugging.py", line 262, in test_ppc64_powernv
08:28:32 ERROR|     self.reverse_debugging()
08:28:32 ERROR|   File "/builds/thuth/qemu/build/tests/avocado/reverse_debugging.py", line 178, in reverse_debugging
08:28:32 ERROR|     g.cmd(b'c')
08:28:32 ERROR|   File "/builds/thuth/qemu/build/pyvenv/lib64/python3.8/site-packages/avocado/utils/gdb.py", line 783, in cmd
08:28:32 ERROR|     response_payload = self.decode(result)
08:28:32 ERROR|   File "/builds/thuth/qemu/build/pyvenv/lib64/python3.8/site-packages/avocado/utils/gdb.py", line 738, in decode
08:28:32 ERROR|     raise InvalidPacketError
08:28:32 ERROR| avocado.utils.gdb.InvalidPacketError
08:28:32 ERROR|
08:28:32 DEBUG| Local variables:
08:28:32 DEBUG|  -> self <class 'reverse_debugging.ReverseDebugging_ppc64'>: 79-tests/avocado/reverse_debugging.py:ReverseDebugging_ppc64.test_ppc64_powernv
08:28:32 DEBUG| Shutting down VM appliance; timeout=30
08:28:32 DEBUG| Attempting graceful termination
08:28:32 DEBUG| Closing console socket
08:28:32 DEBUG| Politely asking QEMU to terminate

So unless someone has a clue how to fix that, I guess it's
likely best to revert this enablement patch again...

  Thomas


