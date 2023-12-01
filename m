Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6169B800C80
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 14:48:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r93qR-0007Pd-FD; Fri, 01 Dec 2023 08:46:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r93qG-0007Om-7S
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 08:46:04 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r93qC-00069s-WA
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 08:46:03 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2c9cb021d5bso23794311fa.0
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 05:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701438359; x=1702043159; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+8FQNEvKVuFkOWSlTmUrLptwTjryOPUHWpWwITiZVdQ=;
 b=DT1o2ig47vHzv4Y8pOHSkleiwr+dWMlEcZB+tWL4tW+JPhfZmFNY6I8GY805P4J/zG
 5IiDxJ1JKgy/Atl+H9FropigIklxqRncPlFEZzbDsj+DEFJ6mie3CvvI6WR2F6e59v3w
 rhh+VsJlrF079GmOw1H54p2ZwcIPVqRkjktIFyoxaQmtvPFP+xiNOXNgs3hrQ5CpAe0A
 kNKaO5Ji2qoTTEOEv4y8VsldU/JNNz7WNrmEXs/Svru1iMl1YO6MoZtE0QjFT/IALG9n
 AjEWeMD8WzbUDTq164XO26KF+hnpwVhF85SixNld0egbj2cKimTcWaDWCDFi7HK4Q3bs
 n3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701438359; x=1702043159;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+8FQNEvKVuFkOWSlTmUrLptwTjryOPUHWpWwITiZVdQ=;
 b=HnjaFDXryerxgvSdUlsS8CGyDdSM5cx5muCLOTWjPF/f4EuT56siB+q7pbbJkKtGmj
 UIauhrrtAZY1oh+o6Ga+y4fcMltobQP0GLjC9ziYAVri7QKLteLGXRV00HniKG7sqhPM
 j0YUZU07NPXdQIu3U9wcdTncvRGBSwMG1xf48LZhf0nHts1Cj3F5ZP1PKw8U8aSPqmhw
 dwtru3raMkwfsvbnlj9Qt4InTS/TwtsxnCIvEk6h7/Yo0nqOJQnR/CurwQ7nSH6jBD3f
 0+UxZdks8Adl40010gfBlZbmf1zbafKa1qztyxi95vGf1yO5RKQUTLDibvRxj1wevYKE
 tp1A==
X-Gm-Message-State: AOJu0YyZGqKVAGn4uFYafaPItLtk7dRZlnmg+tUVsRExPonaLO/2y7KZ
 PJoGRUBHcS+CPTta4GXNZK6zPw==
X-Google-Smtp-Source: AGHT+IH5rSOqoFY6tENoGmly+YEBnEf2aD72A00kIEgYHhwWRaWQsNVIzk8Ii7y7qnxqT8gXL5gjEQ==
X-Received: by 2002:a2e:3518:0:b0:2c9:954b:7249 with SMTP id
 z24-20020a2e3518000000b002c9954b7249mr823527ljz.4.1701438358975; 
 Fri, 01 Dec 2023 05:45:58 -0800 (PST)
Received: from [192.168.69.100] ([176.176.160.225])
 by smtp.gmail.com with ESMTPSA id
 pj20-20020a170906d79400b009fd2028e62csm1914408ejb.71.2023.12.01.05.45.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Dec 2023 05:45:58 -0800 (PST)
Message-ID: <cbcdea98-4fc2-4952-9f7b-b3db242ad8b6@linaro.org>
Date: Fri, 1 Dec 2023 14:45:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] tests/avocado: drop
 BootLinuxConsole.test_mips_malta_cpio test
Content-Language: en-US
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
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231201093633.2551497-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/12/23 10:36, Alex Bennée wrote:
> The assets are no longer archived by Debian so we can't run this on
> CI. While some people may still have the test in their cache we do
> have more recent images from tuxrun so this isn't a great loss.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/avocado/boot_linux_console.py | 22 ----------------------
>   1 file changed, 22 deletions(-)
> 
> diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
> index 231b4f68e5..5d978f6dd0 100644
> --- a/tests/avocado/boot_linux_console.py
> +++ b/tests/avocado/boot_linux_console.py
> @@ -116,28 +116,6 @@ def test_x86_64_pc(self):
>           console_pattern = 'Kernel command line: %s' % kernel_command_line
>           self.wait_for_console_pattern(console_pattern)
>   
> -    def test_mips_malta(self):
> -        """
> -        :avocado: tags=arch:mips
> -        :avocado: tags=machine:malta
> -        :avocado: tags=endian:big
> -        """
> -        deb_url = ('http://snapshot.debian.org/archive/debian/'
> -                   '20130217T032700Z/pool/main/l/linux-2.6/'
> -                   'linux-image-2.6.32-5-4kc-malta_2.6.32-48_mips.deb')

You are dropping test_mips_malta() while the subject says
"test_mips_malta_cpio" which uses:

         deb_url = ('http://snapshot.debian.org/archive/debian/'
                    '20160601T041800Z/pool/main/l/linux/'
                    'linux-image-4.5.0-2-4kc-malta_4.5.5-1_mips.deb')

Anyway, the lesson is we can't rely on Debian snapshot mirror
anymore, so more need to be cleaned:

$ git grep url.*snapshot.debian.org
tests/avocado/boot_linux_console.py:127:        deb_url = 
('http://snapshot.debian.org/archive/debian/'
tests/avocado/boot_linux_console.py:160:        deb_url = 
('http://snapshot.debian.org/archive/debian/'
tests/avocado/boot_linux_console.py:203:        deb_url = 
('http://snapshot.debian.org/archive/debian/'
tests/avocado/boot_linux_console.py:513:        deb_url = 
('https://snapshot.debian.org/archive/debian/'
tests/avocado/boot_linux_console.py:1129:        deb_url = 
('http://snapshot.debian.org/archive/debian/'
tests/avocado/boot_linux_console.py:1255:        deb_url = 
('https://snapshot.debian.org/archive/debian-ports'
tests/avocado/boot_linux_console.py:1299:        deb_url = 
('http://snapshot.debian.org/archive/debian/'
tests/avocado/machine_s390_ccw_virtio.py:50:        kernel_url = 
('https://snapshot.debian.org/archive/debian/'
tests/avocado/machine_s390_ccw_virtio.py:56:        initrd_url = 
('https://snapshot.debian.org/archive/debian/'
tests/avocado/replay_kernel.py:110:        deb_url = 
('http://snapshot.debian.org/archive/debian/'
tests/avocado/replay_kernel.py:139:        deb_url = 
('http://snapshot.debian.org/archive/debian/'
tests/avocado/replay_kernel.py:287:        deb_url = 
('https://snapshot.debian.org/archive/debian-ports'
tests/avocado/replay_kernel.py:445:        deb_url = 
('http://snapshot.debian.org/archive/debian/'

