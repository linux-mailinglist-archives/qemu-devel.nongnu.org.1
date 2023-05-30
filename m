Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 956DF715B51
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 12:18:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3wQB-0007mW-AB; Tue, 30 May 2023 06:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3wQ8-0007lx-To
 for qemu-devel@nongnu.org; Tue, 30 May 2023 06:17:40 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3wQ6-0001Qs-Rw
 for qemu-devel@nongnu.org; Tue, 30 May 2023 06:17:40 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f6ef9a928fso26154805e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 03:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685441857; x=1688033857;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nt+vI+5dClACb2c3QfVBOESFB/kx3wPR9oRcc4u+ETI=;
 b=KJc2Ah6cAYCSYJ1sLWilKKACR9PQ20OLSJrDl8MCqbuaj73naHAzSEJjzrybkuN2/7
 kF0HbdKGPWcpWdO2MJHh9aYI2fI1G42aSH2H/8jAsR3zzXNLKzV7KFThTtTRve8AYLtH
 hDI0qjD7q9FjrCycdJl3DOtijA5wdZG/paKIuLZKtwz1mSOvam5QIXBe7kvbxTXivu84
 72q8GBEbK1KH/VJvDKpFSI2NOiUKujsdSu49asuf5naEeWD00AUp02zsCk6CyUCxTb75
 zPR6X9Ws2u9HjDOYelSlmQh0vOs7cp54GvNR+MrhtX66/rASvsRCDvvu2wgrF6dopVri
 pDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685441857; x=1688033857;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nt+vI+5dClACb2c3QfVBOESFB/kx3wPR9oRcc4u+ETI=;
 b=BQdJRqmtEmoi+tCnQ45Uv0+48RIY6h89wSUUVLJfxSDu3IES/AqWjXLTAyFKpOmO65
 /PWUe7KFSnXcPU5JIIsvB0ujmWujdNabAHVSC0LGcdROzWOA7GpdS972D//3R9Dh/w05
 8qfi+PCO1i1JoCNwTU1LWUeQ6gQuRIHwoDuCs2N5b/8fGVgyVVTUZuwfTd7jJQQ5a663
 9OK1UkbcSdNBhZT0ho3gbv3NqJQYxkDuM9jtyFQx/Em0s+/AgwaQ8s21y0514rjEHb17
 geM2sKeQDbkmhqrb3iqWgaA/kwlesW2zyiCMv2I5I66Vl7KuHJYr371T4RKw1jNO9ZJO
 aR3g==
X-Gm-Message-State: AC+VfDylu1l6BihpJpt+MHhpFNhSjdw5SBvYD6tQ75+x0JzypCOzA+HG
 xEKxTo6WQcTfctNOYhNIdoN4ww==
X-Google-Smtp-Source: ACHHUZ6jKukqD0G1tgvDrlc1NpbZI84oYWih/42W0PrmZTTaBl0LIABXTuAFrzI6/rT7kqdwUNU2Yg==
X-Received: by 2002:a5d:6084:0:b0:307:8c47:a266 with SMTP id
 w4-20020a5d6084000000b003078c47a266mr1157883wrt.61.1685441857244; 
 Tue, 30 May 2023 03:17:37 -0700 (PDT)
Received: from [192.168.203.175] (77.red-88-29-183.dynamicip.rima-tde.net.
 [88.29.183.77]) by smtp.gmail.com with ESMTPSA id
 a27-20020a5d457b000000b002f103ca90cdsm2715638wrc.101.2023.05.30.03.17.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 03:17:36 -0700 (PDT)
Message-ID: <84132f05-f676-aa3b-ec5b-549e1724c671@linaro.org>
Date: Tue, 30 May 2023 12:17:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] hw/ufs: Initial commit for emulated
 Universal-Flash-Storage
Content-Language: en-US
To: jeuk20.kim@samsung.com, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "hreitz@redhat.com" <hreitz@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Klaus Birkelund Jensen <k.jensen@samsung.com>,
 Alistair Francis <alistair@alistair23.me>
References: <CGME20230526050555epcms2p287be772002cd941cc79226968c319036@epcms2p2>
 <20230526050555epcms2p287be772002cd941cc79226968c319036@epcms2p2>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230526050555epcms2p287be772002cd941cc79226968c319036@epcms2p2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

Hi Jeuk,

[+Alistair]

On 26/5/23 07:05, Jeuk Kim wrote:
> Universal Flash Storage (UFS) is a high-performance mass storage device
> with a serial interface. It is primarily used as a high-performance
> data storage device for embedded applications.
> 
> This commit contains code for UFS device to be recognized
> as a UFS PCI device.
> Patches to handle UFS logical unit and Transfer Request will follow.
> 
> Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
> ---
>   MAINTAINERS              |    6 +
>   hw/Kconfig               |    1 +
>   hw/meson.build           |    1 +
>   hw/ufs/Kconfig           |    4 +
>   hw/ufs/meson.build       |    1 +
>   hw/ufs/trace-events      |   33 +
>   hw/ufs/trace.h           |    1 +
>   hw/ufs/ufs.c             |  305 ++++++++++
>   hw/ufs/ufs.h             |   42 ++
>   include/block/ufs.h      | 1251 ++++++++++++++++++++++++++++++++++++++
>   include/hw/pci/pci.h     |    1 +
>   include/hw/pci/pci_ids.h |    1 +
>   meson.build              |    1 +
>   13 files changed, 1648 insertions(+)
>   create mode 100644 hw/ufs/Kconfig
>   create mode 100644 hw/ufs/meson.build
>   create mode 100644 hw/ufs/trace-events
>   create mode 100644 hw/ufs/trace.h
>   create mode 100644 hw/ufs/ufs.c
>   create mode 100644 hw/ufs/ufs.h
>   create mode 100644 include/block/ufs.h


> diff --git a/include/block/ufs.h b/include/block/ufs.h
> new file mode 100644
> index 0000000000..0ce3a19bc0
> --- /dev/null
> +++ b/include/block/ufs.h
> @@ -0,0 +1,1251 @@
> +#ifndef BLOCK_UFS_H
> +#define BLOCK_UFS_H
> +
> +#include "hw/registerfields.h"

Since you use the registerfields API, ...

> +typedef struct QEMU_PACKED UfsReg {
> +    uint32_t cap;
> +    uint32_t rsvd0;
> +    uint32_t ver;
> +    uint32_t rsvd1;
> +    uint32_t hcpid;
> +    uint32_t hcmid;
> +    uint32_t ahit;
> +    uint32_t rsvd2;
> +    uint32_t is;
> +    uint32_t ie;
> +    uint32_t rsvd3[2];
> +    uint32_t hcs;
> +    uint32_t hce;
> +    uint32_t uecpa;
> +    uint32_t uecdl;
> +    uint32_t uecn;
> +    uint32_t uect;
> +    uint32_t uecdme;
> +    uint32_t utriacr;
> +    uint32_t utrlba;
> +    uint32_t utrlbau;
> +    uint32_t utrldbr;
> +    uint32_t utrlclr;
> +    uint32_t utrlrsr;
> +    uint32_t utrlcnr;
> +    uint32_t rsvd4[2];
> +    uint32_t utmrlba;
> +    uint32_t utmrlbau;
> +    uint32_t utmrldbr;
> +    uint32_t utmrlclr;
> +    uint32_t utmrlrsr;
> +    uint32_t rsvd5[3];
> +    uint32_t uiccmd;
> +    uint32_t ucmdarg1;
> +    uint32_t ucmdarg2;
> +    uint32_t ucmdarg3;
> +    uint32_t rsvd6[4];
> +    uint32_t rsvd7[4];
> +    uint32_t rsvd8[16];
> +    uint32_t ccap;
> +} UfsReg;
> +
> +enum UfsRegOfs {
> +    UFS_REG_CAP = offsetof(UfsReg, cap),
> +    UFS_REG_VER = offsetof(UfsReg, ver),
> +    UFS_REG_HCPID = offsetof(UfsReg, hcpid),
> +    UFS_REG_HCMID = offsetof(UfsReg, hcmid),
> +    UFS_REG_AHIT = offsetof(UfsReg, ahit),
> +    UFS_REG_IS = offsetof(UfsReg, is),
> +    UFS_REG_IE = offsetof(UfsReg, ie),
> +    UFS_REG_HCS = offsetof(UfsReg, hcs),
> +    UFS_REG_HCE = offsetof(UfsReg, hce),
> +    UFS_REG_UECPA = offsetof(UfsReg, uecpa),
> +    UFS_REG_UECDL = offsetof(UfsReg, uecdl),
> +    UFS_REG_UECN = offsetof(UfsReg, uecn),
> +    UFS_REG_UECT = offsetof(UfsReg, uect),
> +    UFS_REG_UECDME = offsetof(UfsReg, uecdme),
> +    UFS_REG_UTRIACR = offsetof(UfsReg, utriacr),
> +    UFS_REG_UTRLBA = offsetof(UfsReg, utrlba),
> +    UFS_REG_UTRLBAU = offsetof(UfsReg, utrlbau),
> +    UFS_REG_UTRLDBR = offsetof(UfsReg, utrldbr),
> +    UFS_REG_UTRLCLR = offsetof(UfsReg, utrlclr),
> +    UFS_REG_UTRLRSR = offsetof(UfsReg, utrlrsr),
> +    UFS_REG_UTRLCNR = offsetof(UfsReg, utrlcnr),
> +    UFS_REG_UTMRLBA = offsetof(UfsReg, utmrlba),
> +    UFS_REG_UTMRLBAU = offsetof(UfsReg, utmrlbau),
> +    UFS_REG_UTMRLDBR = offsetof(UfsReg, utmrldbr),
> +    UFS_REG_UTMRLCLR = offsetof(UfsReg, utmrlclr),
> +    UFS_REG_UTMRLRSR = offsetof(UfsReg, utmrlrsr),
> +    UFS_REG_UICCMD = offsetof(UfsReg, uiccmd),
> +    UFS_REG_UCMDARG1 = offsetof(UfsReg, ucmdarg1),
> +    UFS_REG_UCMDARG2 = offsetof(UfsReg, ucmdarg2),
> +    UFS_REG_UCMDARG3 = offsetof(UfsReg, ucmdarg3),
> +    UFS_REG_CCAP = offsetof(UfsReg, ccap),
> +};
> +
> +enum UfsCapShift {
> +    CAP_NUTRS_SHIFT = 0,
> +    CAP_RTT_SHIFT = 8,
> +    CAP_NUTMRS_SHIFT = 16,
> +    CAP_AUTOH8_SHIFT = 23,
> +    CAP_64AS_SHIFT = 24,
> +    CAP_OODDS_SHIFT = 25,
> +    CAP_UICDMETMS_SHIFT = 26,
> +    CAP_CS_SHIFT = 28,
> +};
> +
> +enum UfsCapMask {
> +    CAP_NUTRS_MASK = 0x1f,
> +    CAP_RTT_MASK = 0xff,
> +    CAP_NUTMRS_MASK = 0x7,
> +    CAP_AUTOH8_MASK = 0x1,
> +    CAP_64AS_MASK = 0x1,
> +    CAP_OODDS_MASK = 0x1,
> +    CAP_UICDMETMS_MASK = 0x1,
> +    CAP_CS_MASK = 0x1,
> +};
> +
> +#define UFS_CAP_NUTRS(cap) (((cap) >> CAP_NUTRS_SHIFT) & CAP_NUTRS_MASK)
> +#define UFS_CAP_RTT(cap) (((cap) >> CAP_RTT_SHIFT) & CAP_RTT_MASK)
> +#define UFS_CAP_NUTMRS(cap) (((cap) >> CAP_NUTMRS_SHIFT) & CAP_NUTMRS_MASK)
> +#define UFS_CAP_AUTOH8(cap) (((cap) >> CAP_AUTOH8_SHIFT) & CAP_AUTOH8_MASK)
> +#define UFS_CAP_64AS(cap) (((cap) >> CAP_64AS_SHIFT) & CAP_64AS_MASK)
> +#define UFS_CAP_OODDS(cap) (((cap) >> CAP_OODDS_SHIFT) & CAP_OODDS_MASK)
> +#define UFS_CAP_UICDMETMS(cap) \
> +    (((cap) >> CAP_UICDMETMS_SHIFT) & CAP_UICDMETMS_MASK)
> +#define UFS_CAP_CS(cap) (((cap) >> CAP_CS_SHIFT) & CAP_CS_MASK)
> +
> +#define UFS_CAP_SET_NUTRS(cap, val)                       \
> +    (cap = (cap & ~(CAP_NUTRS_MASK << CAP_NUTRS_SHIFT)) | \
> +           ((uint32_t)val & CAP_NUTRS_MASK) << CAP_NUTRS_SHIFT)
> +#define UFS_CAP_SET_RTT(cap, val)                     \
> +    (cap = (cap & ~(CAP_RTT_MASK << CAP_RTT_SHIFT)) | \
> +           ((uint32_t)val & CAP_RTT_MASK) << CAP_RTT_SHIFT)
> +#define UFS_CAP_SET_NUTMRS(cap, val)                        \
> +    (cap = (cap & ~(CAP_NUTMRS_MASK << CAP_NUTMRS_SHIFT)) | \
> +           ((uint32_t)val & CAP_NUTMRS_MASK) << CAP_NUTMRS_SHIFT)
> +#define UFS_CAP_SET_AUTOH8(cap, val)                        \
> +    (cap = (cap & ~(CAP_AUTOH8_MASK << CAP_AUTOH8_SHIFT)) | \
> +           ((uint32_t)val & CAP_AUTOH8_MASK) << CAP_AUTOH8_SHIFT)
> +#define UFS_CAP_SET_64AS(cap, val)                      \
> +    (cap = (cap & ~(CAP_64AS_MASK << CAP_64AS_SHIFT)) | \
> +           ((uint32_t)val & CAP_64AS_MASK) << CAP_64AS_SHIFT)
> +#define UFS_CAP_SET_OODDS(cap, val)                       \
> +    (cap = (cap & ~(CAP_OODDS_MASK << CAP_OODDS_SHIFT)) | \
> +           ((uint32_t)val & CAP_OODDS_MASK) << CAP_OODDS_SHIFT)
> +#define UFS_CAP_SET_UICDMETMS(cap, val)                           \
> +    (cap = (cap & ~(CAP_UICDMETMS_MASK << CAP_UICDMETMS_SHIFT)) | \
> +           ((uint32_t)val & CAP_UICDMETMS_MASK) << CAP_UICDMETMS_SHIFT)
> +#define UFS_CAP_SET_CS(cap, val)                    \
> +    (cap = (cap & ~(CAP_CS_MASK << CAP_CS_SHIFT)) | \
> +           ((uint32_t)val & CAP_CS_MASK) << CAP_CS_SHIFT)

... could it be worth add the FIELD_SET32() macro once in that header?

