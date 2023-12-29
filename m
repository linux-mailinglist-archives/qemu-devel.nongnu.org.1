Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 618C681FECF
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 11:02:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJ9gc-00024h-TM; Fri, 29 Dec 2023 05:01:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rJ9gH-00023Z-Of
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 05:01:32 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rJ9gF-0005j4-3S
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 05:01:29 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40d5aefcc2fso28039115e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 02:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703844084; x=1704448884; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vAcsaRSJppL03/HEF9I5dT92G/wE0uptLV9ex6K6+vI=;
 b=dW99vB2YdYbAUIL1aYoDUcN+N+jdCVqktlEBLRejxqTe2+kN+gWPQukBTodBg5ZJXb
 QvdMhe3FPQYVHP1GLiF+z0AbQyIjcpQqXlIsGWCpkKAuD57Al7GHV7kRHYUc5nM8L2mU
 3N4tROXX6qhR2EQv89H1GbpAIoXbUip7BM1nyauYuMHgLnALFFh/wySJl7BICNAKaGE4
 7PI710z470T83wQ1+THX912oJwN4d/TyakQfE77JAMxzAPIMu3Zyzp3clYrkWUoWlxc0
 nl4bH3z2IzUzUJNUj99uq5titVT0y76xVmSLh22tvPTxeNXTTJDmz3OVSujlmZBX1kYD
 BsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703844084; x=1704448884;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vAcsaRSJppL03/HEF9I5dT92G/wE0uptLV9ex6K6+vI=;
 b=Am+3iAI+OaS+E71WS1Ff9ZJCF7Y+TLvQozPGWG+LwzrP+/B+vkSUlQnxbob47tgoXV
 pQvr6AbqjwTRrYhDKcSTud7sMxHq20fFtN4iLMYl4TSsclieiCiMz5d+WiGOtIsY4N1j
 rGDk+U1wLLw4wJN1zPPwH+QgKlrtsWrWuk6957NFMybNYCrEXMs41lTeWJJT+5848wfC
 SdlQOZC7ZkNSnxO6VJcPysJodLKQ6M7M5WTyHwGd9bsPvco6lC+r7H0KiL33KA/cnCVX
 wCLS2Uawp3f+3UjKcfKMhGsECVVfRAlJXr4jwvi80akwI6DWqWR51gkP7/P8mVQLdGMJ
 VEWw==
X-Gm-Message-State: AOJu0Yzgn0wzANjSor3qfzHIVY1ErLhJAGmIf/o6K27ohQI24OqLZg61
 dEv/9JYDUmxggWSNbWMA++17/r9A36xpuK7hpM/Q6xPmVsM=
X-Google-Smtp-Source: AGHT+IEromwcF9Vxb37DppnAuHtxRyTBnQ9Vi12g9MEUGjvIm766tF5Q2QZcj7Hi4VmoLDV959aDxQ==
X-Received: by 2002:a05:600c:ac6:b0:40c:2c6d:a810 with SMTP id
 c6-20020a05600c0ac600b0040c2c6da810mr6487436wmr.32.1703844083836; 
 Fri, 29 Dec 2023 02:01:23 -0800 (PST)
Received: from [192.168.69.100] ([176.187.202.55])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a05600c348500b0040d597abf05sm12712160wmq.42.2023.12.29.02.01.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Dec 2023 02:01:23 -0800 (PST)
Message-ID: <e5683e3c-31c5-4365-9d96-27fb02fea4b3@linaro.org>
Date: Fri, 29 Dec 2023 11:01:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/21] configure, meson: rename targetos to host_os
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231221171958.59350-1-pbonzini@redhat.com>
 <20231221171958.59350-22-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231221171958.59350-22-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 21/12/23 18:19, Paolo Bonzini wrote:
> This variable is about the host OS, not the target.  It is used a lot
> more since the Meson conversion, but the original sin dates back to 2003.
> Time to fix it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   accel/tcg/meson.build                |   2 +-
>   backends/meson.build                 |   4 +-
>   block/meson.build                    |   4 +-
>   bsd-user/meson.build                 |   2 +-
>   chardev/meson.build                  |   4 +-
>   configure                            |  58 ++++----
>   contrib/ivshmem-client/meson.build   |   2 +-
>   contrib/ivshmem-server/meson.build   |   2 +-
>   contrib/vhost-user-blk/meson.build   |   2 +-
>   contrib/vhost-user-input/meson.build |   2 +-
>   contrib/vhost-user-scsi/meson.build  |   2 +-
>   docs/devel/kconfig.rst               |   2 +-
>   fsdev/meson.build                    |   2 +-
>   hw/9pfs/meson.build                  |   4 +-
>   hw/display/meson.build               |   2 +-
>   hw/ppc/meson.build                   |   2 +-
>   hw/usb/meson.build                   |   4 +-
>   meson.build                          | 206 +++++++++++++--------------
>   net/can/meson.build                  |   2 +-
>   net/meson.build                      |   8 +-
>   plugins/meson.build                  |   4 +-
>   qga/meson.build                      |  16 +--
>   scsi/meson.build                     |   2 +-
>   system/meson.build                   |   4 +-
>   tests/fp/meson.build                 |   2 +-
>   tests/meson.build                    |   2 +-
>   tests/plugin/meson.build             |   2 +-
>   tests/qemu-iotests/meson.build       |   2 +-
>   tests/qtest/meson.build              |  10 +-
>   tests/unit/meson.build               |   8 +-
>   ui/dbus-display1.xml                 |  10 +-
>   ui/meson.build                       |   8 +-
>   util/meson.build                     |   8 +-
>   33 files changed, 197 insertions(+), 197 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


