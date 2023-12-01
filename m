Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B288011FF
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 18:47:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r97bK-0001Ht-KB; Fri, 01 Dec 2023 12:46:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r97bI-0001Hh-JD
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:46:52 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r97bG-000244-Lm
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:46:52 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40b397793aaso15779855e9.0
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 09:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701452808; x=1702057608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OPxps29sFV31BfFgv7ektG4J+wAARFlyn8EY5Iffn2g=;
 b=WDjZ469ihNa5p2GbrwlQdxO4R8aY1c3cN5tVIvpf0lwoBXBTRZe/HaGmITF8dXC6Jm
 8KZtY+jUMY4aqh+fLTpBN/s9Lj2+bO3NzYcUQ45Xl02la34Qjb80jR8bvsubOn+ROqJZ
 Llg/WhuieFoKJeJqgy0ukGpLfttZz6F/cthtDSn/NKeWZhOpptvPYSawzsGdVHxXzPyS
 lqLwtgATgXTccAz6DFt+s47RZgYiW8GvncC2vb29zRp3UA85X/s8tIfajx9R48L+U9ze
 8RM4MKGwMpfsjVE/ZPAkLzzvsYYeACLVJNwCpHOZdXVKLVSoAPWlbhENVGuom5tZXRqj
 VbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701452808; x=1702057608;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OPxps29sFV31BfFgv7ektG4J+wAARFlyn8EY5Iffn2g=;
 b=rwOdi83PugIqExSDH7Ahq2sIPPuUN5K/vezRPRHk1uoGnIjZ7s3k2dO/xoH5fS4FNr
 rBwSwjw6miBdvlSXZJ7Wq9OZOHWtyaUbmEibc8rxMUYCRrUZNHZElYVtRp1opbZDZBST
 vMtU57pXBtiqzFs9uXHpka2GnthceoUHLTDlTXnyWz8idZoglOHt8VwB0FAIS0AhonqR
 GQq3wzeXiFcW3JAcvZowmE8gcrkdJpS8PDZpWckSXX+5hznSclH8r6IFOfbeWkPlYErH
 KesgJ0VbTlflfiAw1tV5QdtnbrkKy1lKcAiufiaRVu5wbo0dD6RRTq1kQrJZqTAVe1JO
 Pg/A==
X-Gm-Message-State: AOJu0YzPzIAwLP48qEzZq1bFbdlpjhleVd4clmR/T2HoTLG4KEeIapHx
 XTnX3WBc8SvgUL3F9mTIrcRN2A==
X-Google-Smtp-Source: AGHT+IHEnQVyiiQwNIwF6B+s4EJ8EfZ70MyucAAfpNOxY6qdBpSmouGxua5BRI5f/je+NA03z1gSBw==
X-Received: by 2002:a05:600c:211a:b0:408:369a:dad1 with SMTP id
 u26-20020a05600c211a00b00408369adad1mr906319wml.4.1701452808461; 
 Fri, 01 Dec 2023 09:46:48 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 h15-20020a05600c314f00b004083a105f27sm9611857wmo.26.2023.12.01.09.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 09:46:47 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7F07F5FB5F;
 Fri,  1 Dec 2023 17:46:47 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Cleber
 Rosa <crosa@redhat.com>,  Wainer dos Santos Moschetta
 <wainersm@redhat.com>,  Beraldo Leal <bleal@redhat.com>,  Jiaxun Yang
 <jiaxun.yang@flygoat.com>
Subject: Re: [PULL 3/6] tests/avocado: drop
 BootLinuxConsole.test_mips_malta_cpio test
In-Reply-To: <bfec6eb4-ebfe-4f9f-8f48-626e539d1a68@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 1 Dec 2023 17:49:33
 +0100")
References: <20231201151228.2610209-1-alex.bennee@linaro.org>
 <20231201151228.2610209-4-alex.bennee@linaro.org>
 <bfec6eb4-ebfe-4f9f-8f48-626e539d1a68@linaro.org>
User-Agent: mu4e 1.11.25; emacs 29.1
Date: Fri, 01 Dec 2023 17:46:47 +0000
Message-ID: <87a5qt6cjc.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 1/12/23 16:12, Alex Benn=C3=A9e wrote:
>> The assets are no longer archived by Debian so we can't run this on
>> CI. While some people may still have the test in their cache we do
>> have more recent images from tuxrun so this isn't a great loss.
>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20231201093633.2551497-4-alex.bennee@linaro.org>
>> diff --git a/tests/avocado/boot_linux_console.py
>> b/tests/avocado/boot_linux_console.py
>> index 231b4f68e5..ba2f99b53a 100644
>> --- a/tests/avocado/boot_linux_console.py
>> +++ b/tests/avocado/boot_linux_console.py
>> @@ -191,47 +191,6 @@ def test_mips64el_fuloong2e(self):
>>           console_pattern =3D 'Kernel command line: %s' % kernel_command=
_line
>>           self.wait_for_console_pattern(console_pattern)
>>   -    def test_mips_malta_cpio(self):
>> -        """
>> -        :avocado: tags=3Darch:mips
>> -        :avocado: tags=3Dmachine:malta
>> -        :avocado: tags=3Dendian:big
>> -        """
>> -        deb_url =3D ('http://snapshot.debian.org/archive/debian/'
>> -                   '20160601T041800Z/pool/main/l/linux/'
>> -                   'linux-image-4.5.0-2-4kc-malta_4.5.5-1_mips.deb')
>
> In https://lore.kernel.org/qemu-devel/87o7fa5505.fsf@draig.linaro.org/
> you mention the linux-4.7 kernel but now you are removing the 4.5
> which
> also works...
>
> $ wget
> http://snapshot.debian.org/archive/debian/20160601T041800Z/pool/main/l/li=
nux/linux-image-4.5.0-2-4kc-malta_4.5.5-1_mips.deb
> --2023-12-01 17:46:49--
>   http://snapshot.debian.org/archive/debian/20160601T041800Z/pool/main/l/=
linux/linux-image-4.5.0-2-4kc-malta_4.5.5-1_mips.deb
> Resolving snapshot.debian.org (snapshot.debian.org)... 185.17.185.185,
> 193.62.202.27
> Connecting to snapshot.debian.org
> (snapshot.debian.org)|185.17.185.185|:80... connected.
> HTTP request sent, awaiting response... 200 OK
> Length: 29893440 (29M)
> Saving to: =E2=80=98linux-image-4.5.0-2-4kc-malta_4.5.5-1_mips.deb=E2=80=
=99
>
> linux-image-4.5.0-2-4kc-malta_4  12%[=3D>   ]   3,52M  1,07MB/s    eta 25s
> ^C
>
> Can we not rush and figure out what is the problem please?

This was the failure on gitlab:

  https://gitlab.com/qemu-project/qemu/-/jobs/5637828476

>
>> -        deb_hash =3D 'a3c84f3e88b54e06107d65a410d1d1e8e0f340f8'
>> -        deb_path =3D self.fetch_asset(deb_url, asset_hash=3Ddeb_hash)
>> -        kernel_path =3D self.extract_from_deb(deb_path,
>> -                                            '/boot/vmlinux-4.5.0-2-4kc-=
malta')
>> -        initrd_url =3D ('https://github.com/groeck/linux-build-test/raw=
/'
>> -                      '8584a59ed9e5eb5ee7ca91f6d74bbb06619205b8/rootfs/'
>> -                      'mips/rootfs.cpio.gz')
>> -        initrd_hash =3D 'bf806e17009360a866bf537f6de66590de349a99'
>> -        initrd_path_gz =3D self.fetch_asset(initrd_url, asset_hash=3Din=
itrd_hash)
>> -        initrd_path =3D self.workdir + "rootfs.cpio"
>> -        archive.gzip_uncompress(initrd_path_gz, initrd_path)
>> -
>> -        self.vm.set_console()
>> -        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE
>> -                               + 'console=3DttyS0 console=3Dtty '
>> -                               + 'rdinit=3D/sbin/init noreboot')
>> -        self.vm.add_args('-kernel', kernel_path,
>> -                         '-initrd', initrd_path,
>> -                         '-append', kernel_command_line,
>> -                         '-no-reboot')
>> -        self.vm.launch()
>> -        self.wait_for_console_pattern('Boot successful.')
>> -
>> -        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
>> -                                                'BogoMIPS')
>> -        exec_command_and_wait_for_pattern(self, 'uname -a',
>> -                                                'Debian')
>> -        exec_command_and_wait_for_pattern(self, 'reboot',
>> -                                                'reboot: Restarting sys=
tem')
>> -        # Wait for VM to shut down gracefully
>> -        self.vm.wait()
>> -
>>       @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted =
code')
>>       def test_mips64el_malta_5KEc_cpio(self):
>>           """

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

