Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A2BB33A1E
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Aug 2025 11:06:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqT82-0004rh-3c; Mon, 25 Aug 2025 05:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uqT7y-0004rN-HM
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 05:04:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uqT7w-000514-2o
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 05:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756112668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BBvFE65eDwyMrldJTlua8wpijMlUN/WfjXwRsGA6aY0=;
 b=dr32ixZKiFzw+GRwIzmSCbRQ219FFouVlxfb1zYjaUsu/rwI4Wk/1+6zIzadEpJouTVvkZ
 Vr32yYYfF+Xqg9zJShjt5IyEVIKIa91sOJUICE52pr7tJA+1dd1YL1CMCBcfYgiidAaD3S
 iXoR0/P+x4tmBiXi9CG/IW4xwU7n5wg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-jZwx7IpSNS2e5HMVxMHUKw-1; Mon, 25 Aug 2025 05:04:06 -0400
X-MC-Unique: jZwx7IpSNS2e5HMVxMHUKw-1
X-Mimecast-MFC-AGG-ID: jZwx7IpSNS2e5HMVxMHUKw_1756112646
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-afcb7a3771bso353451266b.2
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 02:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756112645; x=1756717445;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BBvFE65eDwyMrldJTlua8wpijMlUN/WfjXwRsGA6aY0=;
 b=ZToLhFdHZZ1HDrL+lwjNLpGEKqsaItFJmoMUFk7SCAzerdKP1K+2mw+z8Jg7c2Lcwv
 F8StUMAn/sGI+san5f9q4AGRMHREmtTBZbqRueVIZXgSpt0/Cg+dC/W/NVxMB9Qvqlh2
 Pk8mk0rOi0xTZBT2NBpyRxgPNheLoJYQZSpjMIfD6w5lxA1Hp+y+Jfc9qhb3FeTmB73Z
 n0vzUQb0YaB18F2axWt2iTqEXuARKEvYGRXA0f/u6AmLbPba0F8ycL3W9GrdWvKPgv1c
 rAZ4+h5+M6EkQzanxtncw8VAI6XXFFVI+jXY9P6NE3kZnt616O3moaCnNl3pSigpwQpD
 PBjw==
X-Gm-Message-State: AOJu0YzIV68w7CrvcaWG+F6Q0av93G+4Ys/5zdj+PJqxhYjD+cCRtdwg
 THBX/nVVXsp6Aeu+CSe5D3IvXhgSIdTGIr+5qvJWD3Vpsm7ef94xweBSm9/8P8xqiMvNU8t0AsX
 3LPmJDHer/SfCyzYExl/nIb9UZdLkdRWrKS9rM9+wKO11BrV/H0ovQLrJ
X-Gm-Gg: ASbGnctHrUnf0QCsmNHpXBcROggW+xH5pa6DYWLAiPThiL0ttFryZD5V3gY7KM1Nol3
 hGaRaHBfl5DIfR1r3GnITj6btl4LvwLzdaYUqYcPSp+YhEXS2HeoWj8WEZln8nAckAqWoZJscNg
 aGAY8Z/MVO13Ivuyn5x3pClSMUy3bPu6G3/gISa8uYyRDbKRvjxyC31mtYXJ1zv/u9Sr6s8quKU
 dTNyORKWr/ke6FbUcFckZ/vVlvltt5oeY7xRPqzrtIAtWKWL2soWI6LGdON62YUr7gMqN2Hq8Iv
 6lkVcKvfaRpZPskNHn3lR/E+Q/IlaFFmfBlCPW4e2+9aTbtfcc6NSCQt/EbrYooJ9CfcJ59W0Nq
 IML4=
X-Received: by 2002:a17:906:6c1:b0:afe:94ca:1681 with SMTP id
 a640c23a62f3a-afe94ca2fc6mr11857166b.63.1756112645417; 
 Mon, 25 Aug 2025 02:04:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxVuVtBhF3j7g8I9EDdoMhXtMhbPOvpcM0Kl4f1dg7iq+oOQ4Y5Bdp8iLymOgyx6AS0c0F3g==
X-Received: by 2002:a17:906:6c1:b0:afe:94ca:1681 with SMTP id
 a640c23a62f3a-afe94ca2fc6mr11854766b.63.1756112644999; 
 Mon, 25 Aug 2025 02:04:04 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-112-084.pools.arcor-ip.net.
 [47.64.112.84]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-afe7f59b14bsm172381466b.104.2025.08.25.02.04.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Aug 2025 02:04:04 -0700 (PDT)
Message-ID: <c6b38976-6fbc-41e4-a051-36025cb9c297@redhat.com>
Date: Mon, 25 Aug 2025 11:04:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Use more fine-grained locking when
 looking for free ports
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20250821094735.804210-1-thuth@redhat.com>
 <CAAjaMXYt4UBS-2wB2OiSCE_DA77STWAjWvPdv=NtEGsUoSyFPA@mail.gmail.com>
 <b60a9e7e-6f79-442d-8a4c-2acfbbf0688b@redhat.com>
 <CAAjaMXY1fcTZ517dmrd+nAt4WUEcR3U2bbmM3ZytDkXREEX6TA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAAjaMXY1fcTZ517dmrd+nAt4WUEcR3U2bbmM3ZytDkXREEX6TA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 25/08/2025 10.51, Manos Pitsidianakis wrote:
> On Mon, Aug 25, 2025 at 11:47 AM Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 25/08/2025 09.30, Manos Pitsidianakis wrote:
>>> On Thu, Aug 21, 2025 at 12:49 PM Thomas Huth <thuth@redhat.com> wrote:
>>>>
>>>> From: Thomas Huth <thuth@redhat.com>
>>>>
>>>> Currently, we have one lock that is held while a test is looking for
>>>> free ports. However, we are also using different ranges for looking
>>>> for free ports nowadays (PORTS_START is based on the PID of the process),
>>>> so instead of using only one lock, we should rather use a lock per
>>>> range instead. This should help to allow running more tests in parallel.
>>>>
>>>> While we're at it, also create the lock files without executable bit
>>>> (mode is 0o777 by default).
>>>>
>>>
>>> (Unrelated to this patch but the file itself)
>>>
>>> Hm. AF_INET supports binding to port 0 to connect to any available
>>> port (see man 7 ip). Is this not portable?
>>
>> No clue ... but in that case, we'd need to go back to only use one lock for
>> all tests that are running in parallel, so it might cause some more contention?
> 
> IIUC there would be no need for locking, since the kernel would return
> a free port for each process.

That only works within a process, doesn't it? The problem here is that the 
test itself does not open the port, it just first needs to figure out a free 
port that will be used later.
The test then launches QEMU with that port number, which will then open this 
port. Then the test connects to that port number (which it must know) to 
interact with QEMU.
If QEMU is using port 0 for that, the test might not have a way to retrieve 
the final port number from QEMU in all cases.

  Thomas


