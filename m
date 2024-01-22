Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 776B9836E26
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 18:46:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRyNe-0002jD-Ca; Mon, 22 Jan 2024 12:46:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rRyNc-0002iQ-Da
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:46:40 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rRyNa-0005Dr-SJ
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:46:40 -0500
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6dc36e501e1so3127707a34.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 09:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705945596; x=1706550396; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6tJKN90fYoTF+wPqjbzqzOdyVCh676j3Po9ZwYKNXDk=;
 b=UuwdD/b/O5+EQFGHXmXYJH7dk7LPTE3GACu/Jz/dg4OX40cHqBP9MaSult3oXmTUHM
 xsuR/edftK8L09WGasJ8qF6tp8IKmhLIEsAXzS6ZbPN60f0rOdsaBHeGrA+Qx4TJ86km
 mhOaS5PMp/pwrOKKNPe75wKOP7uaBu8JMV0B+gR4ymeVXijtx835mP9lJ7aQF4fhOkps
 Kb9JVZAED27V5OQaztFNzX6ouXUWm+miIO0OZWclQKIIM+vetzzfp+grmjMWjRTew9ZE
 GnDiPJBfoQYJMvd5WcvqDB5JTHf8VYZ2oNNxmqviSvOIGnt0K4BVSkisima/gps5OqeW
 diFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705945596; x=1706550396;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6tJKN90fYoTF+wPqjbzqzOdyVCh676j3Po9ZwYKNXDk=;
 b=wmhnnt1YPAWxyoreGoQZhDpT2XIfZp1nld+C2eRIuP6fDPVa0MdPpBfg8GUaQOPYaV
 kWJBUKh33MjuWyg3Kg2Yhou32btatJkpIFFAktNO97OUHSIz/QlLu+W/NgbVVsiMO2gI
 ex9eGQxWJZrnEYyQth543A5XBNEwOngFDaMJt4QOEGVFEDCvR1o3PSUggvhIV7/SYGsC
 XoG2bhyer0+G/tAw4dK3eM1LKUkgh741JXzK2WXKmzeinX1OB6V214GXjtYrGcszJk92
 BDtpE+iEYhP2bgj6idMrOYnubR5rubGonl1MLPl7+NCc9+HdI9YqFaX/09OnHk1vLshD
 EAuQ==
X-Gm-Message-State: AOJu0Yz7c3QIezruGB2wd5Kx6aQoYnjkMm5Gl+WQKD04Cp5A2am5QARt
 fM0f1068BMe/AEp4rhSnwziDSuYetSiywrYm6hIUcPRNdpX47FLCFA3Uc/YrwCU=
X-Google-Smtp-Source: AGHT+IGDg/WaIgPPFZMIeRvbYYb9xONLYdj1pbo/qGLSade2y258uqLJnovbdrVMK/rPCzQRPGlVTQ==
X-Received: by 2002:a9d:5c0c:0:b0:6dc:224:21ca with SMTP id
 o12-20020a9d5c0c000000b006dc022421camr5340840otk.73.1705945596419; 
 Mon, 22 Jan 2024 09:46:36 -0800 (PST)
Received: from [192.168.69.100] ([176.187.194.57])
 by smtp.gmail.com with ESMTPSA id
 y9-20020a9d5189000000b006e0d91a32b9sm1451427otg.0.2024.01.22.09.46.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 09:46:35 -0800 (PST)
Message-ID: <ceb451fd-c7c6-4ddd-861f-df8e4d897dc5@linaro.org>
Date: Mon, 22 Jan 2024 18:46:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] qemu-options.hx: Improve -serial option documentation
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-stable@nongnu.org, Bohdan Kostiv <bogdan.kostiv@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240122163607.459769-1-peter.maydell@linaro.org>
 <20240122163607.459769-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240122163607.459769-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-ot1-x32a.google.com
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

Hi,

On 22/1/24 17:36, Peter Maydell wrote:
> The -serial option documentation is a bit brief about '-serial none'
> and '-serial null'. In particular it's not very clear about the
> difference between them, and it doesn't mention that it's up to
> the machine model whether '-serial none' means "don't create the
> serial port" or "don't wire the serial port up to anything".
> 
> Expand on these points.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   qemu-options.hx | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index ced82848637..d8c3fe91de1 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4129,7 +4129,8 @@ SRST
>       This option can be used several times to simulate up to 4 serial
>       ports.
>   
> -    Use ``-serial none`` to disable all serial ports.
> +    You can use ``-serial none`` to suppress the creation of default
> +    serial devices.
>   
>       Available character devices are:
>   
> @@ -4151,10 +4152,17 @@ SRST
>           [Linux only] Pseudo TTY (a new PTY is automatically allocated)
>   
>       ``none``
> -        No device is allocated.
> +        No device is allocated. Note that 

>          for machine types which
> +        emulate systems where a serial device is always present in
> +        real hardware, this may be equivalent to the ``null`` option,
> +        in that the serial device is still present but all output
> +        is discarded.

Should we deprecate this broken case, suggesting to use ``null``
instead?

>          For boards where the number of serial ports is
> +        truly variable, this suppresses the creation of the device.
>   
>       ``null``
> -        void device
> +        A guest will see the UART or serial device as present in the
> +        machine, but all output is discarded, and there is no input.
> +        Conceptually equivalent to redirecting the output to ``/dev/null``.
>   
>       ``chardev:id``
>           Use a named character device defined with the ``-chardev``

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


