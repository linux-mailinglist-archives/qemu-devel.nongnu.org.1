Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC02800CC5
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 15:01:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r943c-00020u-RH; Fri, 01 Dec 2023 08:59:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r943Q-0001xh-KH
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 08:59:40 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r943O-0003v5-HO
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 08:59:40 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-50abbb23122so3010917e87.3
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 05:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701439177; x=1702043977; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZoDrotQ/U2UikiecDBIyj1zFrN2+3Zyl5wDgz7ChxoE=;
 b=UMfvl5rmHQniw9tc260pD9F+jmHsQ1eQBiyPBJbJRq11dfccRjZZWx6wi83ooGbUc7
 MYmw9PeJA8gBKqN04B3GEoZDu+vVAgR3DDlR8wPGW+WmvtI+HS5Kom2vbJnS/mYh54O/
 L45aJPPzrBRhHPRVJIWrtd7yaWKcGl8XqUfUXrLJjrZMsLXfVyuTfuqSAMM42wikQ9DR
 w1DgJk+4SM9tqPKBO03ajiBdTzFg8pZzttHjyz9ZIuV2XHYxICgud+F1SltnjTXNE57z
 wuT7tutvn16i1GvMJIyoHM19X7m+YoSxzWoGpMGlMXpDF1KF891qlxnrL+x7rW/V5ZXv
 BC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701439177; x=1702043977;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZoDrotQ/U2UikiecDBIyj1zFrN2+3Zyl5wDgz7ChxoE=;
 b=JxVm9Grh+ovYANOwhXMDqeHbp+G2GIsnMrCCdsy3twthj0Je5PcU9IXwB+STQmUrLo
 BzozPGsIfilXGNTraeFfqAUH3GDRybzYrwPvzXUfWF9uwTS0vcJOB5vRNEbRu/TAWnqr
 kadu7+rXd9sXevrAWrFAga1hFmX3qYtV3DODAyNmuX2gBh6ZAo5YimnT6eQ6BHJeJMRJ
 yrUZ8/0ClHU0Aqws9kHjqRUpC31oExOJsbow2r61hR+tgUsap7LOgTN+pfjeBJJXnuGr
 g6YgiEaTl4tpnE4b4g97vvc+NR8xLjcH2zS6T2uuut1cSQKoeLYGru0t5qYZsN7cERfU
 5qeQ==
X-Gm-Message-State: AOJu0Yx7mgFUp88CoXDMbZXspTNWCYB79CmueETEfHBLkTcd2sXKWT6Y
 DxV+YQP88WAcUWZVw3wCmWEpNg==
X-Google-Smtp-Source: AGHT+IELHviIikteIdX912jWo9Ef6/9CSx0lzTWd+9Y+d/9hZdu/KrhuBHx14nxOG9/UZezMeNHQAQ==
X-Received: by 2002:ac2:555e:0:b0:50b:e06a:f23b with SMTP id
 l30-20020ac2555e000000b0050be06af23bmr32287lfk.71.1701439176959; 
 Fri, 01 Dec 2023 05:59:36 -0800 (PST)
Received: from [192.168.69.100] ([176.176.160.225])
 by smtp.gmail.com with ESMTPSA id
 fb13-20020a05600c520d00b0040b3e7569fcsm9108015wmb.11.2023.12.01.05.59.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Dec 2023 05:59:36 -0800 (PST)
Message-ID: <5a3a91d7-7e0f-4bea-b8e2-ccfab0bbd283@linaro.org>
Date: Fri, 1 Dec 2023 14:59:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] tests/avocado: drop
 BootLinuxConsole.test_mips_malta_cpio test
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Beraldo Leal <bleal@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Eric Auger <eric.auger@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Cleber Rosa <crosa@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20231201093633.2551497-1-alex.bennee@linaro.org>
 <20231201093633.2551497-4-alex.bennee@linaro.org>
 <cbcdea98-4fc2-4952-9f7b-b3db242ad8b6@linaro.org>
 <1f9eb253-0346-4264-8817-11cf079e8f07@linaro.org>
In-Reply-To: <1f9eb253-0346-4264-8817-11cf079e8f07@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 1/12/23 14:57, Philippe Mathieu-Daudé wrote:
> On 1/12/23 14:45, Philippe Mathieu-Daudé wrote:
>> On 1/12/23 10:36, Alex Bennée wrote:
>>> The assets are no longer archived by Debian so we can't run this on
>>> CI. While some people may still have the test in their cache we do
>>> have more recent images from tuxrun so this isn't a great loss.
>>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>>> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   tests/avocado/boot_linux_console.py | 22 ----------------------
>>>   1 file changed, 22 deletions(-)
>>>
>>> diff --git a/tests/avocado/boot_linux_console.py 
>>> b/tests/avocado/boot_linux_console.py
>>> index 231b4f68e5..5d978f6dd0 100644
>>> --- a/tests/avocado/boot_linux_console.py
>>> +++ b/tests/avocado/boot_linux_console.py
>>> @@ -116,28 +116,6 @@ def test_x86_64_pc(self):
>>>           console_pattern = 'Kernel command line: %s' % 
>>> kernel_command_line
>>>           self.wait_for_console_pattern(console_pattern)
>>> -    def test_mips_malta(self):
>>> -        """
>>> -        :avocado: tags=arch:mips
>>> -        :avocado: tags=machine:malta
>>> -        :avocado: tags=endian:big
>>> -        """
>>> -        deb_url = ('http://snapshot.debian.org/archive/debian/'
>>> -                   '20130217T032700Z/pool/main/l/linux-2.6/'
>>> -                   'linux-image-2.6.32-5-4kc-malta_2.6.32-48_mips.deb')
> 
> This link still works for me, what am I missing?
> 
> $ wget 
> http://snapshot.debian.org/archive/debian/20130217T032700Z/pool/main/l/linux-2.6/linux-image-2.6.32-5-4kc-malta_2.6.32-48_mips.deb
> --2023-12-01 14:55:31-- 
> http://snapshot.debian.org/archive/debian/20130217T032700Z/pool/main/l/linux-2.6/linux-image-2.6.32-5-4kc-malta_2.6.32-48_mips.deb
> Resolving snapshot.debian.org (snapshot.debian.org)... 185.17.185.185, 
> 193.62.202.27
> Connecting to snapshot.debian.org 
> (snapshot.debian.org)|185.17.185.185|:80... connected.
> HTTP request sent, awaiting response... 200 OK
> Length: 30231730 (29M)
> Saving to: ‘linux-image-2.6.32-5-4kc-malta_2.6.32-48_mips.deb’
> 
>     linux-image-2.6.32-5-4kc-ma  12%[=>    ]   3,71M  1,23MB/s    eta 20s

Sharing HTTP headers:

$ curl -v 
http://snapshot.debian.org/archive/debian/20130217T032700Z/pool/main/l/linux-2.6/linux-image-2.6.32-5-4kc-malta_2.6.32-48_mips.deb
*   Trying 193.62.202.27:80...
* Connected to snapshot.debian.org (193.62.202.27) port 80 (#0)
 > GET 
/archive/debian/20130217T032700Z/pool/main/l/linux-2.6/linux-image-2.6.32-5-4kc-malta_2.6.32-48_mips.deb 
HTTP/1.1
 > Host: snapshot.debian.org
 > User-Agent: curl/8.1.2
 > Accept: */*
 >
< HTTP/1.1 200 OK
< Date: Fri, 01 Dec 2023 13:54:55 GMT
< Server: Apache
< X-Content-Type-Options: nosniff
< X-Frame-Options: sameorigin
< Referrer-Policy: no-referrer
< X-Xss-Protection: 1
< Permissions-Policy: interest-cohort=()
< Last-Modified: Sun, 17 Feb 2013 03:34:37 GMT
< ETag: "1cd4cb2-4d5e349b3403e"
< Accept-Ranges: bytes
< Content-Length: 30231730
< X-Clacks-Overhead: GNU Terry Pratchett
< Cache-Control: max-age=31536000, public
< X-Varnish: 383440315
< Age: 0
< Via: 1.1 varnish (Varnish/6.5)
< connection: close

>> Anyway, the lesson is we can't rely on Debian snapshot mirror
>> anymore, so more need to be cleaned:
>>
>> $ git grep url.*snapshot.debian.org
>> tests/avocado/boot_linux_console.py:127:        deb_url = 
>> ('http://snapshot.debian.org/archive/debian/'
>> tests/avocado/boot_linux_console.py:160:        deb_url = 
>> ('http://snapshot.debian.org/archive/debian/'
>> tests/avocado/boot_linux_console.py:203:        deb_url = 
>> ('http://snapshot.debian.org/archive/debian/'
>> tests/avocado/boot_linux_console.py:513:        deb_url = 
>> ('https://snapshot.debian.org/archive/debian/'
>> tests/avocado/boot_linux_console.py:1129:        deb_url = 
>> ('http://snapshot.debian.org/archive/debian/'
>> tests/avocado/boot_linux_console.py:1255:        deb_url = 
>> ('https://snapshot.debian.org/archive/debian-ports'
>> tests/avocado/boot_linux_console.py:1299:        deb_url = 
>> ('http://snapshot.debian.org/archive/debian/'
>> tests/avocado/machine_s390_ccw_virtio.py:50:        kernel_url = 
>> ('https://snapshot.debian.org/archive/debian/'
>> tests/avocado/machine_s390_ccw_virtio.py:56:        initrd_url = 
>> ('https://snapshot.debian.org/archive/debian/'
>> tests/avocado/replay_kernel.py:110:        deb_url = 
>> ('http://snapshot.debian.org/archive/debian/'
>> tests/avocado/replay_kernel.py:139:        deb_url = 
>> ('http://snapshot.debian.org/archive/debian/'
>> tests/avocado/replay_kernel.py:287:        deb_url = 
>> ('https://snapshot.debian.org/archive/debian-ports'
>> tests/avocado/replay_kernel.py:445:        deb_url = 
>> ('http://snapshot.debian.org/archive/debian/'
> 


