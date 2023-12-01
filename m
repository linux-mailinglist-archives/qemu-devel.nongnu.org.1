Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B8080108B
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 17:50:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r96hx-0000nU-UV; Fri, 01 Dec 2023 11:49:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r96hv-0000n9-9o
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 11:49:39 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r96ht-0005Jx-Br
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 11:49:39 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40b2ddab817so22325415e9.3
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 08:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701449375; x=1702054175; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2+4a1mKxwShSXLGOd7TQ/9ZcPWO84u/2/D4NL8XYy2s=;
 b=JycqKDxWHioQ2cEoLDL15FAs56b+zJSUlttA7UCA2rRh9xinBP9NrkYctN/ZRoSZDJ
 bUQTMBqMoGszZ3YHpBYx8AxY9IgIjaJR5rqnHGu5uB2UMEEEiODvvjPULvNN0C/j2/MS
 H1AdlyN2j9/VjNHQAJRVDXUss3Ve6/8P4uhXQhAOG81z39ctwiyd1QR0VVA5uIePVZgf
 qtIOulNBouL/WptuvwraL88zK9KtWN71GgHzsu2KY9+efYE3ZyxGM1rfhNzffknXf6SF
 TCqjFb19NAMWnP4YuE4dA9tbVoP+nUx5kFOsnrlCOaP6BSD1mXKIGfTPYDWXpu3to5sq
 pHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701449375; x=1702054175;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2+4a1mKxwShSXLGOd7TQ/9ZcPWO84u/2/D4NL8XYy2s=;
 b=QEzFQWQG6p+yjzcuoNKWqVwRZKqQWtqJyz1yS1wJJLKhyg92fcHKqkGLp9ZQOnnJS3
 xMrnshGYU/QEbl3V5HUf0QhXQKS3pnMpYcvwECDuNQf6ZTnCRNUJx0vSnf+O/qHxFi4e
 Tsd6RXmC0KRuemV+rYmeRcSR0V2KZM16jRmKtK2+Beqn6tbZ1rd8XjjGdFWPU0RhuxNv
 xwuq6DOq1wlCDvquwcFpuryt55+9aATWQO/No2tcEjtGPgBbuTU2/l2czQBDYhPr01vZ
 fYZ4VFK7Ji0ef6jPyYfxb9RYQTpCuiuao+gDZ33Kvrxa2t83sRb2Nlom3TJpcR9UdOWy
 FG0Q==
X-Gm-Message-State: AOJu0YxSYbidbaI+laAQLQ2UuPU3alkGeyANuipJbLSEJ4O9pHSAd87z
 9/TQvuBZ85YHMiT/bzpZ8jSmxQ==
X-Google-Smtp-Source: AGHT+IH28JSWtzcujCxDd8a2UG0P0HcyNsDZP5PwwM50fDcZ6+kK02cheUOyzvTwLh+dID2p2pNq7Q==
X-Received: by 2002:a05:600c:4449:b0:40b:4b69:b189 with SMTP id
 v9-20020a05600c444900b0040b4b69b189mr503481wmn.26.1701449375271; 
 Fri, 01 Dec 2023 08:49:35 -0800 (PST)
Received: from [192.168.69.100] ([176.176.160.225])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a05600c4f0600b0040b3829eb50sm5950578wmq.20.2023.12.01.08.49.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Dec 2023 08:49:34 -0800 (PST)
Message-ID: <bfec6eb4-ebfe-4f9f-8f48-626e539d1a68@linaro.org>
Date: Fri, 1 Dec 2023 17:49:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 3/6] tests/avocado: drop
 BootLinuxConsole.test_mips_malta_cpio test
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20231201151228.2610209-1-alex.bennee@linaro.org>
 <20231201151228.2610209-4-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231201151228.2610209-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 1/12/23 16:12, Alex Bennée wrote:
> The assets are no longer archived by Debian so we can't run this on
> CI. While some people may still have the test in their cache we do
> have more recent images from tuxrun so this isn't a great loss.
> 
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20231201093633.2551497-4-alex.bennee@linaro.org>
> 
> diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
> index 231b4f68e5..ba2f99b53a 100644
> --- a/tests/avocado/boot_linux_console.py
> +++ b/tests/avocado/boot_linux_console.py
> @@ -191,47 +191,6 @@ def test_mips64el_fuloong2e(self):
>           console_pattern = 'Kernel command line: %s' % kernel_command_line
>           self.wait_for_console_pattern(console_pattern)
>   
> -    def test_mips_malta_cpio(self):
> -        """
> -        :avocado: tags=arch:mips
> -        :avocado: tags=machine:malta
> -        :avocado: tags=endian:big
> -        """
> -        deb_url = ('http://snapshot.debian.org/archive/debian/'
> -                   '20160601T041800Z/pool/main/l/linux/'
> -                   'linux-image-4.5.0-2-4kc-malta_4.5.5-1_mips.deb')

In https://lore.kernel.org/qemu-devel/87o7fa5505.fsf@draig.linaro.org/ 
you mention the linux-4.7 kernel but now you are removing the 4.5 which
also works...

$ wget 
http://snapshot.debian.org/archive/debian/20160601T041800Z/pool/main/l/linux/linux-image-4.5.0-2-4kc-malta_4.5.5-1_mips.deb
--2023-12-01 17:46:49-- 
http://snapshot.debian.org/archive/debian/20160601T041800Z/pool/main/l/linux/linux-image-4.5.0-2-4kc-malta_4.5.5-1_mips.deb
Resolving snapshot.debian.org (snapshot.debian.org)... 185.17.185.185, 
193.62.202.27
Connecting to snapshot.debian.org 
(snapshot.debian.org)|185.17.185.185|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 29893440 (29M)
Saving to: ‘linux-image-4.5.0-2-4kc-malta_4.5.5-1_mips.deb’

linux-image-4.5.0-2-4kc-malta_4  12%[=>   ]   3,52M  1,07MB/s    eta 25s
^C

Can we not rush and figure out what is the problem please?

> -        deb_hash = 'a3c84f3e88b54e06107d65a410d1d1e8e0f340f8'
> -        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
> -        kernel_path = self.extract_from_deb(deb_path,
> -                                            '/boot/vmlinux-4.5.0-2-4kc-malta')
> -        initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
> -                      '8584a59ed9e5eb5ee7ca91f6d74bbb06619205b8/rootfs/'
> -                      'mips/rootfs.cpio.gz')
> -        initrd_hash = 'bf806e17009360a866bf537f6de66590de349a99'
> -        initrd_path_gz = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
> -        initrd_path = self.workdir + "rootfs.cpio"
> -        archive.gzip_uncompress(initrd_path_gz, initrd_path)
> -
> -        self.vm.set_console()
> -        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
> -                               + 'console=ttyS0 console=tty '
> -                               + 'rdinit=/sbin/init noreboot')
> -        self.vm.add_args('-kernel', kernel_path,
> -                         '-initrd', initrd_path,
> -                         '-append', kernel_command_line,
> -                         '-no-reboot')
> -        self.vm.launch()
> -        self.wait_for_console_pattern('Boot successful.')
> -
> -        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
> -                                                'BogoMIPS')
> -        exec_command_and_wait_for_pattern(self, 'uname -a',
> -                                                'Debian')
> -        exec_command_and_wait_for_pattern(self, 'reboot',
> -                                                'reboot: Restarting system')
> -        # Wait for VM to shut down gracefully
> -        self.vm.wait()
> -
>       @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
>       def test_mips64el_malta_5KEc_cpio(self):
>           """


