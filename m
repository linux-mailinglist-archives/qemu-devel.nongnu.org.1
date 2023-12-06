Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0A28074DB
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 17:22:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAueJ-0008Hs-56; Wed, 06 Dec 2023 11:21:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rAueG-0008HU-L7
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 11:21:20 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rAueF-0000e9-0v
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 11:21:20 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6ce7c1b07e1so1412108b3a.2
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 08:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701879677; x=1702484477; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dqnTXyFOPkR4JKCvtxsjHnCgUuBqksa1R8N5l/8TM0k=;
 b=dTeJ3DVopeHFA5CfNgEMJ9qXQyk3EvIh4qUIP07qkbLRiSretCKZywEuTfHmJGN/v6
 XotTzNFC+nBLdAL1bswf4SM9iT4omfSK6QlmJMWUPRvLA0perj2+l0vcvEo0fJxkp1Dl
 DusXDTczwnFudsu/n42xkWWbtCBpj1WX14Yv16C4ezGDv2P1P8x6jOhjCQG3hms7LtPJ
 ttOCmB6geYF2o/deiv9MC+lHzItKHhqYe3dipMP9MTEiUCBkT0GCtr3gxrxVbZewYpEF
 vMMnQGeqTnyv+TnMPN2wjQVLRp/KTBhNhpH364NuEF5Hll6/4ipDgH1bIL06gyZpEuna
 ZZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701879677; x=1702484477;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dqnTXyFOPkR4JKCvtxsjHnCgUuBqksa1R8N5l/8TM0k=;
 b=VYgq117qQZDBSER4lIOoi7YCZn9ntjQlHUV48hOco9GS2rhkmdVxkpjURoO5jeR/Vh
 F3oUmFjuq91yftns6GRio4G8VpE6gjQ4sHtWhF7Od6hLYJINPxPjm6G+cuyaQbiKTLM5
 ulrBIc3MnDYPSh6fbFFLxb2/9/BV+slercRQH3gNhgaNvasFaxH1wzdDscvDBhRzNPZ9
 Ud2GSEh+I4W65MBuyB+znvDFfHa0V1Y2tHDOL6LDdf5hYesrHYGpGyUZxZ3IDa5ZGYhJ
 ZJ2S5TCxLrblPbZofVEjj3z3t5GSRgtniFSEj2U/szQud3oHTHGu15qbL4gOO6dqKWhF
 Fo4Q==
X-Gm-Message-State: AOJu0YxYMI3pRnYi42NFmtUsMsvKLF5j6naAp6EEkz4IBNS+FmY1Vg9u
 fdPAY9CJivZyCNn25xmUmdfQ6A==
X-Google-Smtp-Source: AGHT+IFYBFjhwH4qmVm5F0WMmPRHbwPxP5oB/vt6G3+CvGbdB6JrT8L9VlNmQ86vxywSDoCqGK8FYw==
X-Received: by 2002:a05:6a00:194c:b0:6c0:4006:4195 with SMTP id
 s12-20020a056a00194c00b006c040064195mr1406308pfk.0.1701879677033; 
 Wed, 06 Dec 2023 08:21:17 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 h24-20020aa786d8000000b006ce350d946csm183692pfo.41.2023.12.06.08.21.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Dec 2023 08:21:16 -0800 (PST)
Message-ID: <272fdaa4-4479-4d07-8f76-40bf6c6e2f9c@linaro.org>
Date: Wed, 6 Dec 2023 08:21:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] tests/avocado: add a simple i386 replay kernel test
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
References: <20231205204106.95531-1-alex.bennee@linaro.org>
 <20231205204106.95531-2-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231205204106.95531-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 12/5/23 12:40, Alex Bennée wrote:
> There are a number of bugs against 32 bit x86 on the tracker. Lets at
> least establish a baseline pure kernel boot can do record/replay
> before we start looking at the devices.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/avocado/replay_kernel.py | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

