Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CF4718F6C
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 02:13:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Vuz-0003U2-FE; Wed, 31 May 2023 20:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@samsung.com>)
 id 1q4Vux-0003T1-JW
 for qemu-devel@nongnu.org; Wed, 31 May 2023 20:11:51 -0400
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@samsung.com>)
 id 1q4Vus-0000KA-9C
 for qemu-devel@nongnu.org; Wed, 31 May 2023 20:11:50 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20230601001135epoutp03a159192694a85070aa0f674fd26c2a53~kYIdodLaL2961729617epoutp03j
 for <qemu-devel@nongnu.org>; Thu,  1 Jun 2023 00:11:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20230601001135epoutp03a159192694a85070aa0f674fd26c2a53~kYIdodLaL2961729617epoutp03j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1685578295;
 bh=bgaAF0kjRb0WOkhyn5jacdcyK5G1L8nui1I/ImhHFb0=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=eBxtYdpknrw5SHue/kdxIMhvO1wNwXY252kVWJg6YPS65SxHyY57C6c7Dyypn2unh
 YJyNrsGluOdlofgngli9983Rjfaf/yiDnVqUJPGcDlIqwhZcpn0tXojSr8N+hgPRwy
 WgbyTgPqtYaJ+ivCZV9gpg242t0dSyTf6AiV9Bi8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTP id
 20230601001134epcas2p2ac1771e1a3be78b9b59ebbd899335285~kYIdNM-iv0633606336epcas2p2v;
 Thu,  1 Jun 2023 00:11:34 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.69]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4QWml96Bvsz4x9Q5; Thu,  1 Jun
 2023 00:11:33 +0000 (GMT)
X-AuditID: b6c32a45-1dbff70000022cba-63-6477e2354758
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 38.68.11450.532E7746; Thu,  1 Jun 2023 09:11:33 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH 1/3] hw/ufs: Initial commit for emulated
 Universal-Flash-Storage
From: Jeuk Kim <jeuk20.kim@samsung.com>
To: =?UTF-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kwolf@redhat.com"
 <kwolf@redhat.com>, "hreitz@redhat.com" <hreitz@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "thuth@redhat.com"
 <thuth@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Klaus
 Birkelund Jensen <k.jensen@samsung.com>, Alistair Francis
 <alistair@alistair23.me>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <84132f05-f676-aa3b-ec5b-549e1724c671@linaro.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230601001133epcms2p1eb0908748db59eb7521e1a01338b549c@epcms2p1>
Date: Thu, 01 Jun 2023 09:11:33 +0900
X-CMS-MailID: 20230601001133epcms2p1eb0908748db59eb7521e1a01338b549c
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmqa7po/IUg7kv9S0+r7zFbvHmzRom
 i5eHNC0e3O1ntDjZuIfVYsnFVIsFbe2sFi/bTzBb/P/1itVi/7Z/rBZrVghbzHrXzmZxvHcH
 i8XKYzYOfB4T3lxm9dg56y67x51re9g8nlzbzOTxft9VNo++LasYA9iism0yUhNTUosUUvOS
 81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgG5VUihLzCkFCgUkFhcr6dvZ
 FOWXlqQqZOQXl9gqpRak5BSYF+gVJ+YWl+al6+WlllgZGhgYmQIVJmRnHGo3KZhuXfFl+Xr2
 BsapOl2MnBwSAiYSvz49Z+xi5OIQEtjBKHG3Yz1zFyMHB6+AoMTfHcIgNcICYRKHTp1lBrGF
 BBQk5mzrYIeIa0pMXz+RCaScTUBd4vRCc5CwiICLxL+nx1lBRjIL7GKRuNK2nB1iF6/EjPan
 LBC2tMT25VsZQWxOATuJs3db2CDiGhI/lvUyQ9iiEjdXv2WHsd8fm88IYYtItN47C1UjKPHg
 526ouKTEqW+PWSHs6YwSC/6bghwhIbCAUeJX83SoBn2Jax0bwY7gFfCVuHTpOVgDi4CqxPun
 U6FqXCQWHLoDZjMLyEtsfzsHHCbMQA+v36UPYkoIKEscucUCUcEn0XH4L9yLDRt/Y2XvmPeE
 CcJWkVjcfJh1AqPyLERAz0KyaxbCrgWMzKsYxVILinPTU4uNCgzhUZucn7uJEZxotVx3ME5+
 +0HvECMTB+MhRgkOZiURXqGw8hQh3pTEyqrUovz4otKc1OJDjKZAX05klhJNzgem+rySeEMT
 SwMTMzNDcyNTA3MlcV5p25PJQgLpiSWp2ampBalFMH1MHJxSDUyNa+ZkcuvZPfSccWdnelLd
 McYjKr2f14fnV0fM2C2zNa5Xumoqi9MEocaV+5e+LGlPzdy3riGkU/nmuxfWcwsvPeCc4Oq+
 8/NXidnKp5YfkFnQsHqzXsOh41P7N1rVSW11FnB6J7VzgYiO/oyPMi1PNu0TXPam4uCptL+h
 K6ate5ufI7ghQ2K6GJt+V9C6FWJf3u1eay1w+NS7h0FvZMIbvpzf39R3w6zu6SV1OTHuNzWL
 HwUt/N8xUVXy1Ol/n/ZaZCzf94BJbEVE4+11GV/WVnHWK/Hc/++seO+LmIba7z/f9l4zeLxZ
 0oVpTclk38efb4fMn7L/bbJTlFRsV4P9ivnh3myXDBT/Tbn0MsXvuxJLcUaioRZzUXEiAKyt
 Kb89BAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230526050555epcms2p287be772002cd941cc79226968c319036
References: <84132f05-f676-aa3b-ec5b-549e1724c671@linaro.org>
 <20230526050555epcms2p287be772002cd941cc79226968c319036@epcms2p2>
 <CGME20230526050555epcms2p287be772002cd941cc79226968c319036@epcms2p1>
Received-SPF: pass client-ip=203.254.224.33;
 envelope-from=jeuk20.kim@samsung.com; helo=mailout3.samsung.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-To: jeuk20.kim@samsung.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Philippe,

>Hi Jeuk,
>
>[+Alistair]
>
>On 26/5/23 07:05, Jeuk Kim wrote:
>> Universal Flash Storage (UFS) is a high-performance mass storage device
>> with a serial interface. It is primarily used as a high-performance
>> data storage device for embedded applications.
>> 
>> This commit contains code for UFS device to be recognized
>> as a UFS PCI device.
>> Patches to handle UFS logical unit and Transfer Request will follow.
>> 
>> Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
>> ---
>>   MAINTAINERS              |    6 +
>>   hw/Kconfig               |    1 +
>>   hw/meson.build           |    1 +
>>   hw/ufs/Kconfig           |    4 +
>>   hw/ufs/meson.build       |    1 +
>>   hw/ufs/trace-events      |   33 +
>>   hw/ufs/trace.h           |    1 +
>>   hw/ufs/ufs.c             |  305 ++++++++++
>>   hw/ufs/ufs.h             |   42 ++
>>   include/block/ufs.h      | 1251 ++++++++++++++++++++++++++++++++++++++
>>   include/hw/pci/pci.h     |    1 +
>>   include/hw/pci/pci_ids.h |    1 +
>>   meson.build              |    1 +
>>   13 files changed, 1648 insertions(+)
>>   create mode 100644 hw/ufs/Kconfig
>>   create mode 100644 hw/ufs/meson.build
>>   create mode 100644 hw/ufs/trace-events
>>   create mode 100644 hw/ufs/trace.h
>>   create mode 100644 hw/ufs/ufs.c
>>   create mode 100644 hw/ufs/ufs.h
>>   create mode 100644 include/block/ufs.h
>
>
>> diff --git a/include/block/ufs.h b/include/block/ufs.h
>> new file mode 100644
>> index 0000000000..0ce3a19bc0
>> --- /dev/null
>> +++ b/include/block/ufs.h
>> @@ -0,0 +1,1251 @@
>> +#ifndef BLOCK_UFS_H
>> +#define BLOCK_UFS_H
>> +
>> +#include "hw/registerfields.h"
>
>Since you use the registerfields API, ...
>
>> +typedef struct QEMU_PACKED UfsReg {
>> +    uint32_t cap;
>> +    uint32_t rsvd0;
>> +    uint32_t ver;
>> +    uint32_t rsvd1;
>> +    uint32_t hcpid;
>> +    uint32_t hcmid;
>> +    uint32_t ahit;
>> +    uint32_t rsvd2;
>> +    uint32_t is;
>> +    uint32_t ie;
>> +    uint32_t rsvd3[2];
>> +    uint32_t hcs;
>> +    uint32_t hce;
>> +    uint32_t uecpa;
>> +    uint32_t uecdl;
>> +    uint32_t uecn;
>> +    uint32_t uect;
>> +    uint32_t uecdme;
>> +    uint32_t utriacr;
>> +    uint32_t utrlba;
>> +    uint32_t utrlbau;
>> +    uint32_t utrldbr;
>> +    uint32_t utrlclr;
>> +    uint32_t utrlrsr;
>> +    uint32_t utrlcnr;
>> +    uint32_t rsvd4[2];
>> +    uint32_t utmrlba;
>> +    uint32_t utmrlbau;
>> +    uint32_t utmrldbr;
>> +    uint32_t utmrlclr;
>> +    uint32_t utmrlrsr;
>> +    uint32_t rsvd5[3];
>> +    uint32_t uiccmd;
>> +    uint32_t ucmdarg1;
>> +    uint32_t ucmdarg2;
>> +    uint32_t ucmdarg3;
>> +    uint32_t rsvd6[4];
>> +    uint32_t rsvd7[4];
>> +    uint32_t rsvd8[16];
>> +    uint32_t ccap;
>> +} UfsReg;
>> +
>> +enum UfsRegOfs {
>> +    UFS_REG_CAP = offsetof(UfsReg, cap),
>> +    UFS_REG_VER = offsetof(UfsReg, ver),
>> +    UFS_REG_HCPID = offsetof(UfsReg, hcpid),
>> +    UFS_REG_HCMID = offsetof(UfsReg, hcmid),
>> +    UFS_REG_AHIT = offsetof(UfsReg, ahit),
>> +    UFS_REG_IS = offsetof(UfsReg, is),
>> +    UFS_REG_IE = offsetof(UfsReg, ie),
>> +    UFS_REG_HCS = offsetof(UfsReg, hcs),
>> +    UFS_REG_HCE = offsetof(UfsReg, hce),
>> +    UFS_REG_UECPA = offsetof(UfsReg, uecpa),
>> +    UFS_REG_UECDL = offsetof(UfsReg, uecdl),
>> +    UFS_REG_UECN = offsetof(UfsReg, uecn),
>> +    UFS_REG_UECT = offsetof(UfsReg, uect),
>> +    UFS_REG_UECDME = offsetof(UfsReg, uecdme),
>> +    UFS_REG_UTRIACR = offsetof(UfsReg, utriacr),
>> +    UFS_REG_UTRLBA = offsetof(UfsReg, utrlba),
>> +    UFS_REG_UTRLBAU = offsetof(UfsReg, utrlbau),
>> +    UFS_REG_UTRLDBR = offsetof(UfsReg, utrldbr),
>> +    UFS_REG_UTRLCLR = offsetof(UfsReg, utrlclr),
>> +    UFS_REG_UTRLRSR = offsetof(UfsReg, utrlrsr),
>> +    UFS_REG_UTRLCNR = offsetof(UfsReg, utrlcnr),
>> +    UFS_REG_UTMRLBA = offsetof(UfsReg, utmrlba),
>> +    UFS_REG_UTMRLBAU = offsetof(UfsReg, utmrlbau),
>> +    UFS_REG_UTMRLDBR = offsetof(UfsReg, utmrldbr),
>> +    UFS_REG_UTMRLCLR = offsetof(UfsReg, utmrlclr),
>> +    UFS_REG_UTMRLRSR = offsetof(UfsReg, utmrlrsr),
>> +    UFS_REG_UICCMD = offsetof(UfsReg, uiccmd),
>> +    UFS_REG_UCMDARG1 = offsetof(UfsReg, ucmdarg1),
>> +    UFS_REG_UCMDARG2 = offsetof(UfsReg, ucmdarg2),
>> +    UFS_REG_UCMDARG3 = offsetof(UfsReg, ucmdarg3),
>> +    UFS_REG_CCAP = offsetof(UfsReg, ccap),
>> +};
>> +
>> +enum UfsCapShift {
>> +    CAP_NUTRS_SHIFT = 0,
>> +    CAP_RTT_SHIFT = 8,
>> +    CAP_NUTMRS_SHIFT = 16,
>> +    CAP_AUTOH8_SHIFT = 23,
>> +    CAP_64AS_SHIFT = 24,
>> +    CAP_OODDS_SHIFT = 25,
>> +    CAP_UICDMETMS_SHIFT = 26,
>> +    CAP_CS_SHIFT = 28,
>> +};
>> +
>> +enum UfsCapMask {
>> +    CAP_NUTRS_MASK = 0x1f,
>> +    CAP_RTT_MASK = 0xff,
>> +    CAP_NUTMRS_MASK = 0x7,
>> +    CAP_AUTOH8_MASK = 0x1,
>> +    CAP_64AS_MASK = 0x1,
>> +    CAP_OODDS_MASK = 0x1,
>> +    CAP_UICDMETMS_MASK = 0x1,
>> +    CAP_CS_MASK = 0x1,
>> +};
>> +
>> +#define UFS_CAP_NUTRS(cap) (((cap) >> CAP_NUTRS_SHIFT) & CAP_NUTRS_MASK)
>> +#define UFS_CAP_RTT(cap) (((cap) >> CAP_RTT_SHIFT) & CAP_RTT_MASK)
>> +#define UFS_CAP_NUTMRS(cap) (((cap) >> CAP_NUTMRS_SHIFT) & CAP_NUTMRS_MASK)
>> +#define UFS_CAP_AUTOH8(cap) (((cap) >> CAP_AUTOH8_SHIFT) & CAP_AUTOH8_MASK)
>> +#define UFS_CAP_64AS(cap) (((cap) >> CAP_64AS_SHIFT) & CAP_64AS_MASK)
>> +#define UFS_CAP_OODDS(cap) (((cap) >> CAP_OODDS_SHIFT) & CAP_OODDS_MASK)
>> +#define UFS_CAP_UICDMETMS(cap) \
>> +    (((cap) >> CAP_UICDMETMS_SHIFT) & CAP_UICDMETMS_MASK)
>> +#define UFS_CAP_CS(cap) (((cap) >> CAP_CS_SHIFT) & CAP_CS_MASK)
>> +
>> +#define UFS_CAP_SET_NUTRS(cap, val)                       \
>> +    (cap = (cap & ~(CAP_NUTRS_MASK << CAP_NUTRS_SHIFT)) | \
>> +           ((uint32_t)val & CAP_NUTRS_MASK) << CAP_NUTRS_SHIFT)
>> +#define UFS_CAP_SET_RTT(cap, val)                     \
>> +    (cap = (cap & ~(CAP_RTT_MASK << CAP_RTT_SHIFT)) | \
>> +           ((uint32_t)val & CAP_RTT_MASK) << CAP_RTT_SHIFT)
>> +#define UFS_CAP_SET_NUTMRS(cap, val)                        \
>> +    (cap = (cap & ~(CAP_NUTMRS_MASK << CAP_NUTMRS_SHIFT)) | \
>> +           ((uint32_t)val & CAP_NUTMRS_MASK) << CAP_NUTMRS_SHIFT)
>> +#define UFS_CAP_SET_AUTOH8(cap, val)                        \
>> +    (cap = (cap & ~(CAP_AUTOH8_MASK << CAP_AUTOH8_SHIFT)) | \
>> +           ((uint32_t)val & CAP_AUTOH8_MASK) << CAP_AUTOH8_SHIFT)
>> +#define UFS_CAP_SET_64AS(cap, val)                      \
>> +    (cap = (cap & ~(CAP_64AS_MASK << CAP_64AS_SHIFT)) | \
>> +           ((uint32_t)val & CAP_64AS_MASK) << CAP_64AS_SHIFT)
>> +#define UFS_CAP_SET_OODDS(cap, val)                       \
>> +    (cap = (cap & ~(CAP_OODDS_MASK << CAP_OODDS_SHIFT)) | \
>> +           ((uint32_t)val & CAP_OODDS_MASK) << CAP_OODDS_SHIFT)
>> +#define UFS_CAP_SET_UICDMETMS(cap, val)                           \
>> +    (cap = (cap & ~(CAP_UICDMETMS_MASK << CAP_UICDMETMS_SHIFT)) | \
>> +           ((uint32_t)val & CAP_UICDMETMS_MASK) << CAP_UICDMETMS_SHIFT)
>> +#define UFS_CAP_SET_CS(cap, val)                    \
>> +    (cap = (cap & ~(CAP_CS_MASK << CAP_CS_SHIFT)) | \
>> +           ((uint32_t)val & CAP_CS_MASK) << CAP_CS_SHIFT)
>
>... could it be worth add the FIELD_SET32() macro once in that header?

I realized that hw/registerfields.h has FIELD_DP32(), which is the same function as FIELD_SET32().
Instead of defining a new macro in my code, I will modify it to utilize the macros in hw/registerfields.h.
Thanks!

