Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BE1830BAA
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 18:06:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ9N3-0000qm-6H; Wed, 17 Jan 2024 12:06:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ9N1-0000qd-2o
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 12:06:31 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ9Mx-0007Cp-Sw
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 12:06:30 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a2eb5c4dad6so92832966b.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 09:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705511186; x=1706115986; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I2XR4+OM6HVy4aLBIEtukRz2saY/nHlgmHNk8p6bh6s=;
 b=nZDenff09MgvXMH8Ei42R8oZ/DJuAls07Oo8OYJPuk4GfIubw2RUotmv+A4mSFHm93
 bW/inlGfI4tDUSqPV4nWPhSbmmISKgNwLHVbLflBx0fcb+/ive3XJycfzbfaZM/68YjG
 8e8W3qcZjIGgi4c38lGnmPIZEBoP0/l/XoTDX3XWP1ir5NSETeYKsXN43PZFqCcv10Eg
 KyUFqcsD4PnY2GLqPEvSMYmTO2p/2L2SVnJRz87mxes8V+rBPOPOErSj9OyjTZF1atKm
 Ro+u5Ul7qe1hbSXwBjydLoVhG93wWIsTdgvtQoFO9DTdOjzZb5ERjLguACbmu8JKAkpj
 JiIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705511186; x=1706115986;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I2XR4+OM6HVy4aLBIEtukRz2saY/nHlgmHNk8p6bh6s=;
 b=vDyOjVSsjR5W0wmL+fJMobBAxNksrNbV4WUfvSrLadVWp5yH3RPpz0VSm39RKFo8MJ
 KwmG0C7ZGvEgAq/0/eUaRgLlpzmOCOcY6GttAs8MhkPp9Rxr5Dojcx2hK00NIU7IxmbN
 wZLXFhUwPc+UoNVWI+lWRdlVd1Nd+/PkehxkTD9EgPMIhdvzrBBgk4hWi0b5CyPMZM0q
 wDP7hD/kykkuT5JuE2gAdIDU2Ja+cU2oGDmOqoJeraTIomlFgjWCknz/Wahba/ugr3q6
 F4dHzKbWRfxM8VOkcFgFTptWx04r5M2JEBrhJTHhsEJqczIcCrg1Ct2ZTPkOxWv7PLY+
 3z4w==
X-Gm-Message-State: AOJu0Yw0w4ad08MBisA+xDmZff0pku71xEBL/s34DFE/DBwzYygC2lwU
 kfI08bBLUeTemrJ+fwt91STBmh2qgOLflQ==
X-Google-Smtp-Source: AGHT+IG2qASq0kLN+p9Gz8rH5viXbrEGjBSqNWbFNj8ysy4E2bZF1uuQEHCSz5OuePXS3lF/df6w8Q==
X-Received: by 2002:a17:907:93d1:b0:a2c:11f4:d584 with SMTP id
 cp17-20020a17090793d100b00a2c11f4d584mr4090589ejc.52.1705511186278; 
 Wed, 17 Jan 2024 09:06:26 -0800 (PST)
Received: from [192.168.69.100] ([176.187.212.26])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a1709062c4300b00a2af287c6b8sm8099425ejh.16.2024.01.17.09.06.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 09:06:25 -0800 (PST)
Message-ID: <f5b31ef1-4a82-41aa-ab79-f1e4c3dab878@linaro.org>
Date: Wed, 17 Jan 2024 18:06:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] userfaultfd: use 1ULL to build ioctl masks
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com
References: <20240117160313.175609-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240117160313.175609-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

On 17/1/24 17:03, Paolo Bonzini wrote:
> There is no need to use the Linux-internal __u64 type, 1ULL is
> guaranteed to be wide enough.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   migration/postcopy-ram.c                  | 16 +++++++---------
>   subprojects/libvhost-user/libvhost-user.c |  2 +-
>   tests/qtest/migration-test.c              |  4 ++--
>   3 files changed, 10 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


