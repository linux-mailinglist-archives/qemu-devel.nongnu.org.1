Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFC77EA71E
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 00:37:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2g8E-0004rJ-8I; Mon, 13 Nov 2023 18:14:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <42.hyeyoo@gmail.com>)
 id 1r2g8A-0004rB-T4
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 18:14:11 -0500
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <42.hyeyoo@gmail.com>)
 id 1r2g88-0000z2-Nd
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 18:14:10 -0500
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-4ac4cd60370so2307721e0c.3
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 15:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699917247; x=1700522047; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AhShDJzQQW9QIQOfcf+fc8sG3b5kDEZDTPLHNIis7gI=;
 b=B6fnrXsoJ1B7XzSTvY4FQkFR03/XzyEOEdK1dK5+HR2aLjQWC8t6RZcyo+FlsFwrV+
 LmMOW701yB/1yonDuDk/zJP5jbjxobW+9/Fy6JP9/wlU7WWFsunpjqhFYPgWts3I6cLx
 wuJ+i+bpFux3lmcnx4C3RcxNf5065sdKIBSEjX7iW3zxfmUiN6JAhSDwubxi1G9goMke
 skcpaPu6xymfa679k7x5hZ5qpFf8Bde7YXlL33n6thbQdVvWKre5zE48DqeT2I5tC8rj
 /Fg8lMTEZMIikrNy2/J+8p/P6TDJ4IJShnTacycA+Sscfo13Qn2cS7hO3/74FSeFDTk+
 KXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699917247; x=1700522047;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AhShDJzQQW9QIQOfcf+fc8sG3b5kDEZDTPLHNIis7gI=;
 b=ZmzHRoqVaKaJKy5cjMaizu6muMOyAWYp1WLt1UE4ouqlWuKvIRI4dj6AXrum0fEdyE
 ZO6kzEfElltEnUizoweyh2b0v+81dEpohBONw3px0agOJ+SPtDOr9tLQup6uH8QoabmV
 Cjf/A97b+x1W3nKy7INm7XvEjnFMxFfmf7VTI7OJYkL/xKJ4x2e3f/OjupnP2yRvt16Z
 DUilTwGN4kzwaaw0fMaBb4VpPTuNW4heKoEiLXVdUU8+6okU1ubQnCyr9GECo0DDN2s8
 Yvo5rymntpX3/xH1sN9ozX1waXqK9IZoUOBo144KcztSG8c/xBzVBUlgs7GTD4ud2AL6
 VvZA==
X-Gm-Message-State: AOJu0Yz0Wmu2SN1hef7oPh4qzkzyCIaUosVT3NZ0bGcy/ddnyMz2dQBt
 ts9X7mfU4vtbyYsoJqt+/bzVrDrH2XmVUhfXVXI=
X-Google-Smtp-Source: AGHT+IEb9wazkprNN1f0rb5OY12kboYafKPwTAd7cPjvBSmnb3HjY2ges0UJw1sp9U0uw2LF0evw4WM+P0/S6QuOq2A=
X-Received: by 2002:a05:6122:1d13:b0:49a:36e4:5565 with SMTP id
 gc19-20020a0561221d1300b0049a36e45565mr8559174vkb.16.1699917246997; Mon, 13
 Nov 2023 15:14:06 -0800 (PST)
MIME-Version: 1.0
References: <20231023160806.13206-1-Jonathan.Cameron@huawei.com>
 <20231023160806.13206-14-Jonathan.Cameron@huawei.com>
In-Reply-To: <20231023160806.13206-14-Jonathan.Cameron@huawei.com>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Tue, 14 Nov 2023 08:13:55 +0900
Message-ID: <CAB=+i9T3YUkU1L_yoJHiRkzQsUv0aJLLCrNb2ajLVGLh7mKe1g@mail.gmail.com>
Subject: Re: [PATCH v2 13/17] hw/cxl: Add support for device sanitation
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, 
 Michael Tsirkin <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 linuxarm@huawei.com, Fan Ni <fan.ni@samsung.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gregory Price <gregory.price@memverge.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Klaus Jensen <its@irrelevant.dk>, Corey Minyard <cminyard@mvista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=42.hyeyoo@gmail.com; helo=mail-vk1-xa36.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, Oct 24, 2023 at 1:14=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> From: Davidlohr Bueso <dave@stgolabs.net>
>
> Make use of the background operations through the sanitize command, per C=
XL
> 3.0 specs. Traditionally run times can be rather long, depending on the
> size of the media.
>
> Estimate times based on:
>          https://pmem.io/documents/NVDIMM_DSM_Interface-V1.8.pdf
>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  include/hw/cxl/cxl_device.h |  17 +++++
>  hw/cxl/cxl-mailbox-utils.c  | 140 ++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c          |  10 +++
>  3 files changed, 167 insertions(+)
>
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 2a813cdddd..70aca9024c 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -343,6 +343,23 @@ REG64(CXL_MEM_DEV_STS, 0)
>      FIELD(CXL_MEM_DEV_STS, MBOX_READY, 4, 1)
>      FIELD(CXL_MEM_DEV_STS, RESET_NEEDED, 5, 3)
>
> +static inline void __toggle_media(CXLDeviceState *cxl_dstate, int val)
> +{
> +    uint64_t dev_status_reg;
> +
> +    dev_status_reg =3D FIELD_DP64(0, CXL_MEM_DEV_STS, MEDIA_STATUS, val)=
;
> +    cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS] =3D dev_status_reg;
> +}
> +#define cxl_dev_disable_media(cxlds)                    \
> +        do { __toggle_media((cxlds), 0x3); } while (0)
> +#define cxl_dev_enable_media(cxlds)                     \
> +        do { __toggle_media((cxlds), 0x1); } while (0)

Before this patch, it is assumed that "Media Status" and "Mailbox
Interface Ready" were always 1,
thus mdev_reg_read() always returns 1 for both of them regardless of
register values.

I think changes like below are needed as now the assumption is broken?
Please note that it's only build-tested :)

Thanks,
Hyeonggon

diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 61a3c4dc2e..b6ada2fd6a 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -229,12 +229,9 @@ static void mailbox_reg_write(void *opaque,
hwaddr offset, uint64_t value,

 static uint64_t mdev_reg_read(void *opaque, hwaddr offset, unsigned size)
 {
-    uint64_t retval =3D 0;
-
-    retval =3D FIELD_DP64(retval, CXL_MEM_DEV_STS, MEDIA_STATUS, 1);
-    retval =3D FIELD_DP64(retval, CXL_MEM_DEV_STS, MBOX_READY, 1);
+    CXLDeviceState *cxl_dstate =3D opaque;

-    return retval;
+    return cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS];
 }

 static void ro_reg_write(void *opaque, hwaddr offset, uint64_t value,
@@ -371,7 +368,13 @@ static void
mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
     cxl_dstate->mbox_msi_n =3D msi_n;
 }

-static void memdev_reg_init_common(CXLDeviceState *cxl_dstate) { }
+static void memdev_reg_init_common(CXLDeviceState *cxl_dstate) {
+    uint64_t memdev_status_reg;
+
+    memdev_status_reg =3D FIELD_DP64(0, CXL_MEM_DEV_STS, MEDIA_STATUS, 1);
+    memdev_status_reg =3D FIELD_DP64(memdev_status_reg,
CXL_MEM_DEV_STS, MBOX_READY, 1);
+    cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS] =3D memdev_status_reg;
+}

 void cxl_device_register_init_t3(CXLType3Dev *ct3d)
 {
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 61b7f897f7..61f8f83ddf 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -351,9 +351,9 @@ REG64(CXL_MEM_DEV_STS, 0)

 static inline void __toggle_media(CXLDeviceState *cxl_dstate, int val)
 {
-    uint64_t dev_status_reg;
+    uint64_t dev_status_reg =3D cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV=
_STS];

-    dev_status_reg =3D FIELD_DP64(0, CXL_MEM_DEV_STS, MEDIA_STATUS, val);
+    dev_status_reg =3D FIELD_DP64(dev_status_reg, CXL_MEM_DEV_STS,
MEDIA_STATUS, val);
     cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS] =3D dev_status_reg;
 }
 #define cxl_dev_disable_media(cxlds)                    \

