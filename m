Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 199207E9F21
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 15:48:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2YDh-0002vn-PE; Mon, 13 Nov 2023 09:47:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2YDV-0002rH-83
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 09:47:11 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2YDT-0003pD-4p
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 09:47:08 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5409bc907edso7059378a12.0
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 06:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699886825; x=1700491625; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=axP2V6aZEfBFE3aUsMo7ooiwHY6/KxiacN887LJz/pE=;
 b=NuRC0YMwhTRtyX1zsLc3PlOeuMqW8pDreDrK/ceKBaLovnAgqJKAYwnQ86OsDgFiiQ
 Rvqu6sDV6SorOm3VisHToNA9mb9BpMhbo02PVvKNKeCEbrDhI9damACwJyI/xCpjsd8q
 7aNXUxqovdjL2V7l1LKTHHEd8Sqi/jbEIEwwPOzKD8cLCgB7itKmlsELlJPz8vAHMcoR
 ZsaOiThWl3wf/olft5A1eehpmOXGuwR7PuXlrHuwKwIHVnhNffqFLh1FS3YgX8KtlQeN
 tzsghcSN/y1FrjAs88SSgwiL7EbGp65TYn/GzEIqYWv1zTfelUpCCKtKlnMKxgU72aDz
 8xjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699886825; x=1700491625;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=axP2V6aZEfBFE3aUsMo7ooiwHY6/KxiacN887LJz/pE=;
 b=gF6zTW8oHC7wBlS6I1wqznTrwlnuMB419WU8G5f9WJO+tsKQrnGhhq69F6QOVGpaZd
 ziIPG9wXEAYJyVRitca6DW7PndJhwyi8jz8uwdznjsO54UhhgQAanj44LqlwWuF27TzO
 ggg5jLeNs3/d0lFtcoXAiR/oSF7TKsvAcDulgPblR1fn4qA7TwTH+hZG38hiQUgDZg5H
 r0Txbx9XpSR1cP2eC8pV8IP/7TxmaO7/H30TnwNoagTeZbYRGbexDMl4M+xIportHOsQ
 AFjorHSnKsuc5uXdzb4G2ZvB1/lWLf0ughTbVjoZbkR12tQbWZPdHvmyz8/aOWTNO0cc
 sQvA==
X-Gm-Message-State: AOJu0YwsWhbYmSm37gznx6nwjQiORdQE49ajOpJqzEyCMWZNrxkHiR6B
 NsQa/NLK0SrkR2q4wXg5Or5UTA==
X-Google-Smtp-Source: AGHT+IF/oZWG4vpm8jdfsPJpkixLcLzCKZ+dd5k/8CKGKZ9tXGyXrfSIoNdNAnyN4wA3dIXTWM4nwg==
X-Received: by 2002:aa7:d510:0:b0:533:520:a5a8 with SMTP id
 y16-20020aa7d510000000b005330520a5a8mr4989652edq.29.1699886824905; 
 Mon, 13 Nov 2023 06:47:04 -0800 (PST)
Received: from [192.168.69.100] ([176.164.221.204])
 by smtp.gmail.com with ESMTPSA id
 dy12-20020a05640231ec00b0053e469f6505sm3739468edb.26.2023.11.13.06.47.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 06:47:04 -0800 (PST)
Message-ID: <2d938d82-d7ca-4cd1-b4eb-a24bc4b6c337@linaro.org>
Date: Mon, 13 Nov 2023 15:47:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/avocado/machine_s390_ccw_virtio.py: Fix
 SyntaxWarnings from python 3.12
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, John Snow <jsnow@redhat.com>
References: <20231113140721.46903-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231113140721.46903-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

On 13/11/23 15:07, Thomas Huth wrote:
> Python 3.12 now warns about backslashes in strings that aren't used
> for escaping a special character from Python. Silence the warning
> by using raw strings here instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/avocado/machine_s390_ccw_virtio.py | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/tests/avocado/machine_s390_ccw_virtio.py b/tests/avocado/machine_s390_ccw_virtio.py
> index e1f493bc44..ffd914ded9 100644
> --- a/tests/avocado/machine_s390_ccw_virtio.py
> +++ b/tests/avocado/machine_s390_ccw_virtio.py
> @@ -36,8 +36,8 @@ def wait_for_crw_reports(self):
>       dmesg_clear_count = 1
>       def clear_guest_dmesg(self):
>           exec_command_and_wait_for_pattern(self, 'dmesg -c > /dev/null; '
> -                    'echo dm_clear\ ' + str(self.dmesg_clear_count),
> -                    'dm_clear ' + str(self.dmesg_clear_count))
> +                    r'echo dm_clear\ ' + str(self.dmesg_clear_count),
> +                    r'dm_clear ' + str(self.dmesg_clear_count))
>           self.dmesg_clear_count += 1
>   
>       def test_s390x_devices(self):
> @@ -121,15 +121,15 @@ def test_s390x_devices(self):
>                                       'cat /sys/bus/ccw/devices/0.1.1111/cutype',
>                                       '3832/01')
>           exec_command_and_wait_for_pattern(self,
> -                    'cat /sys/bus/pci/devices/0005\:00\:00.0/subsystem_vendor',
> -                    '0x1af4')
> +                    r'cat /sys/bus/pci/devices/0005\:00\:00.0/subsystem_vendor',
> +                    r'0x1af4')

Do we really need to escape the hex number?

>           exec_command_and_wait_for_pattern(self,
> -                    'cat /sys/bus/pci/devices/0005\:00\:00.0/subsystem_device',
> -                    '0x0001')
> +                    r'cat /sys/bus/pci/devices/0005\:00\:00.0/subsystem_device',
> +                    r'0x0001')

Ditto,

>           # check fid propagation
>           exec_command_and_wait_for_pattern(self,
> -                        'cat /sys/bus/pci/devices/000a\:00\:00.0/function_id',
> -                        '0x0000000c')
> +                    r'cat /sys/bus/pci/devices/000a\:00\:00.0/function_id',
> +                    r'0x0000000c')

Ditto.

Otherwise,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>           # add another device
>           self.clear_guest_dmesg()
>           self.vm.cmd('device_add', driver='virtio-net-ccw',
> @@ -235,7 +235,7 @@ def test_s390x_fedora(self):
>                           'while ! (dmesg | grep gpudrmfb) ; do sleep 1 ; done',
>                           'virtio_gpudrmfb frame buffer device')
>               exec_command_and_wait_for_pattern(self,
> -                'echo -e "\e[?25l" > /dev/tty0', ':/#')
> +                r'echo -e "\e[?25l" > /dev/tty0', ':/#')
>               exec_command_and_wait_for_pattern(self, 'for ((i=0;i<250;i++)); do '
>                   'echo " The  qu ick  fo x j ump s o ver  a  laz y d og" >> fox.txt;'
>                   'done',


