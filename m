Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4314D7EE138
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 14:14:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3cB4-0006dO-3x; Thu, 16 Nov 2023 08:13:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3cAw-0006aV-LW
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 08:12:54 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3cAt-0001p9-PC
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 08:12:54 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9bf86b77a2aso118078666b.0
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 05:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700140369; x=1700745169; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CTN5nhM8Tx7uYm7STWff6UxgS7isKGpgJKfWN0i6ZM8=;
 b=zs095gRLMOHO9/NGw3eyhTohJdKsFsWRcyoTKrINwiGXLol8L43mAb/Rqv2LTzhq5a
 JvBA3YjxIhIgEv/1ed3fLZy3gwcySVLNzPV4lCHRVnXPJaOAyFMB8d+kxqwRQwnt/osS
 ld5uBA3MxmnONG6BC0P1vOu8uPjmtb+k758ee+niZ/1hC0bLyRm0gOKRII7hsou+uF1z
 R5Ke3uiREgHOfJHDQRtxAig93EsIh49nZYFHmLAOWDZDYsBMqvbhiGR88AXk6C30uAaB
 9EsEoAsBY3NtZZC+h/z5ImBri6OzrPU20BUIPQJBdLdY4JfLioUo0CnEjFbOBV0raPx2
 JVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700140369; x=1700745169;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CTN5nhM8Tx7uYm7STWff6UxgS7isKGpgJKfWN0i6ZM8=;
 b=cqhrjJ6Rs2d5FWfgF/oZBNzN6KHhr15vAZAkUHxwmDxG3+thc6ICGuc44LzJkXthOA
 PJCnm+20h2h1mg+a/Z1vhReSHLoo61qloy7Zju1RDI8lvId3c5yEmkgmOO/lEHC7uHe/
 65ltyMag1pZMmTJM005SZnesA9YCLBkHbB2rUd2BiIUMLSUJhsuZl6rtJ5hGLcn7GD4f
 Y5qTRFQrQi6GOjSnuxEMexG6wEMJNC+765OWLPEtwUeKvQmn7Soj0LqqJuK3bxNNwi1a
 WYe7Yb3f35BJfGLLdcaz6irVXySpQPD42qN+2oZBHckVxG756qftlF3nymsv7cFiIBDl
 2oow==
X-Gm-Message-State: AOJu0YxRq8hdfe8bj9ggIeXJLJ8heBjuQEta5FMLYB8I/ewEON6+cXys
 bjg69D9thCe6QP8Egz1lPP0JBA==
X-Google-Smtp-Source: AGHT+IEsjSvhurH28ATnjblxuM2K52lQUmu4nN9E7XkNMWvDa1fNIb7uAnna8Aceko0yE1qjdxujdw==
X-Received: by 2002:a17:906:494b:b0:9dd:c54d:1ee9 with SMTP id
 f11-20020a170906494b00b009ddc54d1ee9mr10720540ejt.53.1700140369377; 
 Thu, 16 Nov 2023 05:12:49 -0800 (PST)
Received: from [192.168.69.100] ([176.187.220.205])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a170906080a00b009a193a5acffsm8415558ejd.121.2023.11.16.05.12.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 05:12:48 -0800 (PST)
Message-ID: <da8f8d1c-581f-4d22-9a47-b6d15f87daa0@linaro.org>
Date: Thu, 16 Nov 2023 14:12:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] avocado: fix Python invalid escape sequence
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 "open list:S390 Virtio-ccw" <qemu-s390x@nongnu.org>
References: <20231116130022.1270356-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231116130022.1270356-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

Hi Marc-André,

On 16/11/23 14:00, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> This is an error in Python 3.12; fix it by using a raw string literal.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   tests/avocado/machine_s390_ccw_virtio.py | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/avocado/machine_s390_ccw_virtio.py b/tests/avocado/machine_s390_ccw_virtio.py
> index e1f493bc44..74a52c506d 100644
> --- a/tests/avocado/machine_s390_ccw_virtio.py
> +++ b/tests/avocado/machine_s390_ccw_virtio.py
> @@ -36,7 +36,7 @@ def wait_for_crw_reports(self):
>       dmesg_clear_count = 1
>       def clear_guest_dmesg(self):
>           exec_command_and_wait_for_pattern(self, 'dmesg -c > /dev/null; '
> -                    'echo dm_clear\ ' + str(self.dmesg_clear_count),
> +                    r'echo dm_clear\ ' + str(self.dmesg_clear_count),
>                       'dm_clear ' + str(self.dmesg_clear_count))
>           self.dmesg_clear_count += 1
>   
> @@ -121,14 +121,14 @@ def test_s390x_devices(self):
>                                       'cat /sys/bus/ccw/devices/0.1.1111/cutype',
>                                       '3832/01')
>           exec_command_and_wait_for_pattern(self,
> -                    'cat /sys/bus/pci/devices/0005\:00\:00.0/subsystem_vendor',
> +                    r'cat /sys/bus/pci/devices/0005\:00\:00.0/subsystem_vendor',
>                       '0x1af4')
>           exec_command_and_wait_for_pattern(self,
> -                    'cat /sys/bus/pci/devices/0005\:00\:00.0/subsystem_device',
> +                    r'cat /sys/bus/pci/devices/0005\:00\:00.0/subsystem_device',
>                       '0x0001')
>           # check fid propagation
>           exec_command_and_wait_for_pattern(self,
> -                        'cat /sys/bus/pci/devices/000a\:00\:00.0/function_id',
> +                        r'cat /sys/bus/pci/devices/000a\:00\:00.0/function_id',
>                           '0x0000000c')
>           # add another device
>           self.clear_guest_dmesg()
> @@ -235,7 +235,7 @@ def test_s390x_fedora(self):
>                           'while ! (dmesg | grep gpudrmfb) ; do sleep 1 ; done',
>                           'virtio_gpudrmfb frame buffer device')
>               exec_command_and_wait_for_pattern(self,
> -                'echo -e "\e[?25l" > /dev/tty0', ':/#')
> +                r'echo -e "\e[?25l" > /dev/tty0', ':/#')
>               exec_command_and_wait_for_pattern(self, 'for ((i=0;i<250;i++)); do '
>                   'echo " The  qu ick  fo x j ump s o ver  a  laz y d og" >> fox.txt;'
>                   'done',

Isn't it commit 0b2af475e9 ("tests/avocado/machine_s390_ccw_virtio.py: 
Fix SyntaxWarnings from python 3.12")?


