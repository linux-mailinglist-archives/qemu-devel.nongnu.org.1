Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7B0828737
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 14:37:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNCHI-0004oh-3o; Tue, 09 Jan 2024 08:36:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNCHD-0004iz-LJ
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 08:36:19 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNCHB-0001aP-9Y
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 08:36:19 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40b5155e154so38442165e9.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 05:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704807375; x=1705412175; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BHC2kUTrpWJtNveirkWhsXgIu86cSKpU/ODpGiqaIjs=;
 b=oa6G91aads7KZTWJl5PFTs3x7s/MNFA6vXKkiq6gh9Zd0F20Lr6XZhma2QZ07AGuOT
 CdL9e5uXutX5kUme27B0PNve61vnmz747nboSMBqA3WGTIRrJ5Hy3yzpH2W3isgMGsQP
 H2fcPGV3fpmi3H29CapVucFu1L4YWIFHZ8VBddW+v1IczxrJv7IwvLGXQe6prkzmNJ8s
 mGgTQ3vYfqpJQ3Aig/OdUQ4cMUDOpex/+PpyVH1170zCsYBvumNATldXqCtWFg38bkYF
 /FHDQbgtYa6XPzvk5HHmtS3wE5eqP2LkRZ0WiTX3gXs86nDenLGNO1uLY+gurMuYtvAe
 A65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704807375; x=1705412175;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BHC2kUTrpWJtNveirkWhsXgIu86cSKpU/ODpGiqaIjs=;
 b=WppGIpcBnJCnj71mQdfzmG8im48F6+KMpIhGp5Usy20kBRIfVuCIigh7xq6LuyOR0o
 8E39kjel1RGPmOU8weYLKt0zyHwBE0EydPkeWbwt5aRGuyYv19psovz3ZOQbPBFa36V8
 fWS6emiXpQ9PKAftcs1fR6C6ewZSk94PpwywnGcpcVVBPJS+DTWTp3Mnqw4oyA1Q3ANc
 HsSrlm1wE2cF5rTAaASNG3Q03O/NSmw7WAM/WbPbNs00S+ro5W/0iWrepkbR0UA29XJD
 bPyuwPNcMs9WDvvLtLCwJ2/Bd+L+Q6NXNX2DIw1exW2RHkyU8hm8gbwknUIBCxajgVDZ
 Y+RQ==
X-Gm-Message-State: AOJu0YxTEsCSxok88LVMet3n9MmCgrkecVjZBOH0MqgddMTpH37JG/7x
 lDE6MNF7AlAR8RWv4rAI+Aat0Web2yU3vg==
X-Google-Smtp-Source: AGHT+IH7yj31/loIT+7tYmw3gewwKIbySeRmVS4Sa3VhOiWKFc39eFO4qMdYcn4tKQ3u0/8DGwJcXw==
X-Received: by 2002:a05:600c:ca:b0:40e:4710:b33a with SMTP id
 u10-20020a05600c00ca00b0040e4710b33amr1491441wmm.45.1704807375098; 
 Tue, 09 Jan 2024 05:36:15 -0800 (PST)
Received: from [192.168.69.100] (rsa59-h02-176-184-32-47.dsl.sta.abo.bbox.fr.
 [176.184.32.47]) by smtp.gmail.com with ESMTPSA id
 h4-20020a05600c314400b0040d7c3d5454sm14756870wmo.3.2024.01.09.05.36.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 05:36:14 -0800 (PST)
Message-ID: <282dc91e-0f56-4a74-9110-ea4824e6d61d@linaro.org>
Date: Tue, 9 Jan 2024 14:36:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/PATCH v1 07/11] gunyah: Specify device-tree location
Content-Language: en-US
To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>, peter.maydell@linaro.org, 
 alex.bennee@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: quic_tsoni@quicinc.com, quic_pheragu@quicinc.com,
 quic_eberman@quicinc.com, quic_yvasi@quicinc.com, quic_cvanscha@quicinc.com,
 quic_mnalajal@quicinc.com
References: <20240109090039.1636383-1-quic_svaddagi@quicinc.com>
 <20240109090039.1636383-8-quic_svaddagi@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240109090039.1636383-8-quic_svaddagi@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 9/1/24 10:00, Srivatsa Vaddagiri wrote:
> Specify the location of device-tree and its size, as Gunyah requires the
> device-tree to be parsed before VM can begin its execution.
> 
> Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
> ---
>   MAINTAINERS               |  1 +
>   accel/stubs/gunyah-stub.c |  5 +++++
>   hw/arm/virt.c             |  6 ++++++
>   include/sysemu/gunyah.h   |  2 ++
>   target/arm/gunyah.c       | 45 +++++++++++++++++++++++++++++++++++++++
>   target/arm/meson.build    |  3 +++
>   6 files changed, 62 insertions(+)
>   create mode 100644 target/arm/gunyah.c


> diff --git a/target/arm/gunyah.c b/target/arm/gunyah.c
> new file mode 100644
> index 0000000000..73c1c2a88a
> --- /dev/null
> +++ b/target/arm/gunyah.c
> @@ -0,0 +1,45 @@
> +/*
> + * QEMU Gunyah hypervisor support
> + *
> + * Copyright(c) 2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "sysemu/gunyah.h"
> +#include "sysemu/gunyah_int.h"
> +#include "linux-headers/linux/gunyah.h"
I'm getting on macOS:

In file included from ../../target/arm/gunyah.c:13:
linux-headers/linux/gunyah.h:13:10: fatal error: 'linux/types.h' file 
not found
#include <linux/types.h>
          ^~~~~~~~~~~~~~~
1 error generated.

Maybe we need the following change?

-- >8 --
diff --git a/meson.build b/meson.build
index 6ded60063e..fb20ca04d1 100644
--- a/meson.build
+++ b/meson.build
@@ -712,5 +712,5 @@ endif

  gunyah = not_found
-if get_option('gunyah').allowed()
+if get_option('gunyah').allowed() and host_os == 'linux'
      accelerators += 'CONFIG_GUNYAH'
  endif
---


