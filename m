Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F7CA4F892
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Mar 2025 09:18:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpjwU-0006dk-RK; Wed, 05 Mar 2025 03:17:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tpjwR-0006cd-4d
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 03:17:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tpjwP-0004Wk-1W
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 03:17:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741162640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lCS1o7wFnfMW+Zqg8GFXuEo/T96XtVvKMwlOwSEiPSc=;
 b=EFD4EXy0HrSFqKpIi9+pSejnUG31NCLzXNNx/pK1O+0IRzPqCxPflFTpRxtxuII/MFltzt
 Yw6tqR3DvS2+KC0NWuYJ0kprp+NvjpRQ5VFccSBXd8QZjoVteGuxK1/sY1+wWUEUXVufFx
 NRD2bpi6IaWAPgKmmU6wt6y0p+7YUfk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-zabqgi1GMiajVYs-6cNIVA-1; Wed, 05 Mar 2025 03:17:14 -0500
X-MC-Unique: zabqgi1GMiajVYs-6cNIVA-1
X-Mimecast-MFC-AGG-ID: zabqgi1GMiajVYs-6cNIVA_1741162634
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43bcc04d2ebso12256705e9.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 00:17:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741162633; x=1741767433;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lCS1o7wFnfMW+Zqg8GFXuEo/T96XtVvKMwlOwSEiPSc=;
 b=iBxBzlm69FV1FAUFnOX7BA4fbl9Le1+js01ZWQwXAHzInD0my6yaQmF60w5R3dY3CT
 gKkIPXyEzs1ZdYPNAVuiOPf/cwTtl07Bx/iBvVuBRDFNnoYBCctxgi+z29VkTIW4o90+
 ZjF2b8UPfrIqSUzSJeS7ApCUCtATgWTPIBO859V3NyZtOsEqWFSv59ggqE0m4EgZcswj
 TjnMptpOLc8qMEyMRMiAmb+SsYsyqo7NqKUPbUhBwFg5JRleMGF+l1WSvzhH8QCoL0n8
 b9AKSUP26CRd0b1JreLPKutsJiu+P/JThl1qRYUc9tWjC9jw1cg5RPVFVLq2c5jQLcfu
 dXAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgIUqbIY6jmgDAaXcDafsUqiM1g3jhABX4gGNQ0Y9zEk6cUF5dMKpMiIfmsgi7vXTDcPuLUJe/Sj/Z@nongnu.org
X-Gm-Message-State: AOJu0Yw3I8eLr0MqFYB9MBYo765ycQorFV+8gEvTP+VqzRVxN35Pvcb5
 zuGSD0qFHZvKhyPo+pzdAiPx8WopHaV7MgCMyMmYoHrc1CWhr3MSIimvyBDpJYiHAp/GXHj4LxR
 zy7tXrGhbdBn8rb1IIQijh2jEBYtTtQo5BkIySzOs/9WB3PlivDTt
X-Gm-Gg: ASbGncssRaDplOdEBOkeyWwAAQm/JbHJJV0PbeVifDExF+mjNaFaEQYcT/GeXY+4Zku
 BhmSo9VpJzmwM8hVd1Kml/G2kYBcccGtd50LPagd/8cPz7JxPDgX5qUNsj124aZPVbMKmJEln8u
 M8eLWFznf1exwfZDqJ1TlWv7KINS9B+h2pj9uMmau6lOH8cN3gp+WHrO+wC0F6eH3yo7bSWvF/5
 T/F21q3C0TcINC/OSG6L2zKSScFxkq0W8VKo/eoKcIrdA02on/vBlQvaM58plLx6YYGTlqKun8c
 emRVFIZdVSQX1MJchxBK+LKf53kk3wmb72rpUtn20mRdrkY=
X-Received: by 2002:a05:600c:4f83:b0:43b:cfc2:fff with SMTP id
 5b1f17b1804b1-43bd2979938mr14900285e9.12.1741162633657; 
 Wed, 05 Mar 2025 00:17:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7VJRQUUDak8Yyj2Xs5NZUj9+zIcOpgAsROZO2tdM0KV/GC2GvLrDEb3OwLJgMj403F1df/Q==
X-Received: by 2002:a05:600c:4f83:b0:43b:cfc2:fff with SMTP id
 5b1f17b1804b1-43bd2979938mr14899955e9.12.1741162633159; 
 Wed, 05 Mar 2025 00:17:13 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-231.web.vodafone.de.
 [109.42.51.231]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd435c592sm9765395e9.35.2025.03.05.00.17.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 00:17:12 -0800 (PST)
Message-ID: <58227a15-801c-4190-999a-b5f896ad6505@redhat.com>
Date: Wed, 5 Mar 2025 09:17:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/32] tests/functional: move aarch64 GPU test into own
 file
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier
 <laurent@vivier.eu>, qemu-arm@nongnu.org, Alexandre Iooss
 <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
 <20250304222439.2035603-2-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250304222439.2035603-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 04/03/2025 23.24, Alex Bennée wrote:
> I want to expand the number of tests to cover a wide range of
> configurations. That starts with splitting off from the normal virt
> test from which it doesn't really share much code. We can also reduce
> the timeout of the original virt test now it is now longer burdened
> with testing the GPU.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
...
> diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/test_aarch64_virt_gpu.py
> new file mode 100755
> index 0000000000..616e6ed656
> --- /dev/null
> +++ b/tests/functional/test_aarch64_virt_gpu.py
> @@ -0,0 +1,94 @@
> +#!/usr/bin/env python3
> +#
> +# Functional tests for the various graphics modes we can support.
> +#
> +# Copyright (c) 2024, 2025 Linaro Ltd.
> +#
> +# Author:
> +#  Alex Bennée <alex.bennee@linaro.org>
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu.machine.machine import VMLaunchFailure
> +
> +from qemu_test import QemuSystemTest, Asset
> +from qemu_test import exec_command, exec_command_and_wait_for_pattern
> +from qemu_test import skipIfMissingCommands
> +
> +from qemu_test.linuxkernel import LinuxKernelTest
...
> +
> +if __name__ == '__main__':
> +    QemuSystemTest.main()

You could call LinuxKernelTest.main() instead, then you don't have to import 
QemuSystemTest anymore.

Anyway,
Reviewed-by: Thomas Huth <thuth@redhat.com>


