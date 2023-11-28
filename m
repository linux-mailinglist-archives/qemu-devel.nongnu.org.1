Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1431E7FAF33
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 01:43:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7mBY-0008Oy-Cv; Mon, 27 Nov 2023 19:42:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <42.hyeyoo@gmail.com>)
 id 1r7mBW-0008Om-J1
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 19:42:42 -0500
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <42.hyeyoo@gmail.com>)
 id 1r7mBT-0004bl-Py
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 19:42:41 -0500
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-7c45bee5fdaso1169485241.1
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 16:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701132158; x=1701736958; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ixnvRozqVr7yR9TdpFybIUNj9FbAtPZ72yGbbald71w=;
 b=nPEByfqlvElFa+kovPZ0xAdFBnUE+SgDDsPRrRhkmvdRcXRVni0Z2ugujug9X3Wgj2
 6bKeiz054Z20E3LPe5SzVqUUohLnlqF0rpDxJWxrIpqsxn1Y4yFC5duZH5FGtiHKLOpR
 +OJEEWhxsOXfkOkaJ/eufp5pX5hFrhQ/H9fDSaKjOEgyFWWPpD4ru2ej8teX2wjfpwBV
 C+f4ZPgTQpL0Ao9L8NV4kqzzqs3vxOfXnHK5dI2cI4Tq6kAPN7/5Wo6O02a8i0LrCej/
 BCezbd3q6C9QSVWpW3JYNOr5BFq5Z76UbJm8U2UzLM1NivJPdoCShK/hlq+b76PtZshS
 LUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701132158; x=1701736958;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ixnvRozqVr7yR9TdpFybIUNj9FbAtPZ72yGbbald71w=;
 b=GwncdBce0fDBGy2wmihy04IWjKBpJBuQDdeSWBudfKqclm07Cc8BHZ/KlcClDrwaaa
 unK5/UHptnw1f5xFijrWBeInHv1CGI8upw9X0dkLGhvGY2EsXq5jVyMyePG77r67FGID
 vLhWlZ4HMQtZNzFILWS21ULXwQP3Pl87AR3EDPXFK3ahLAq81YoVmZLTl9pdAJTgoeTa
 Xfqaua1PKaBQlhCAvbMB4NmHExXsPXUNLQztzczK+6ZUJ8k/2q88F59gMNXbK9UqB9RS
 GNI4Qr5qthvHZfvseGrX7WMAA4NkBQeKXvLWtQdjtwyksfvePBA0rjew76K0pid2Gn6R
 xsXA==
X-Gm-Message-State: AOJu0Ywk3tmISVOWOyAeWYGIWVsclbqFbiwcXqww3/7eWC0w3zsYa/+O
 rS4O7IerSZPDWidTtToZuuBc+DLvQpYOvRgCh0Y=
X-Google-Smtp-Source: AGHT+IFPNEqxd7w4hoAMIyuqa6kuK7PAHjKb5kfxMzpEHMpKvOaTlNCFgHU60DsVp1oYXOGmWdSVZ0b6QyMhbeGRD1c=
X-Received: by 2002:a67:fa57:0:b0:462:fe7f:676d with SMTP id
 j23-20020a67fa57000000b00462fe7f676dmr3723843vsq.35.1701132158478; Mon, 27
 Nov 2023 16:42:38 -0800 (PST)
MIME-Version: 1.0
References: <20231127105830.2104954-1-42.hyeyoo@gmail.com>
 <20231127105830.2104954-2-42.hyeyoo@gmail.com>
 <20231127202702.zkqomoapz2iprpra@offworld>
In-Reply-To: <20231127202702.zkqomoapz2iprpra@offworld>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Tue, 28 Nov 2023 09:42:27 +0900
Message-ID: <CAB=+i9Q4rwM9vqO262GS6BAcDHuRmeKVCVroj1-iR3X5wwL9ig@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] hw/cxl/device: read from register values in
 mdev_reg_read()
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, linux-cxl@lore.kernel.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=42.hyeyoo@gmail.com; helo=mail-ua1-x92c.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
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

On Tue, Nov 28, 2023 at 5:27=E2=80=AFAM Davidlohr Bueso <dave@stgolabs.net>=
 wrote:
>
> On Mon, 27 Nov 2023, Hyeonggon Yoo wrote:
>
> >In the current mdev_reg_read() implementation, it consistently returns
> >that the Media Status is Ready (01b). This was fine until commit
> >25a52959f99d ("hw/cxl: Add support for device sanitation") because the
> >media was presumed to be ready.
> >
> >However, as per the CXL 3.0 spec "8.2.9.8.5.1 Sanitize (Opcode 4400h)",
> >during sanitation, the Media State should be set to Disabled (11b). The
> >mentioned commit correctly sets it to Disabled, but mdev_reg_read()
> >still returns Media Status as Ready.
> >
> >To address this, update mdev_reg_read() to read register values instead
> >of returning dummy values.
> >
> >Fixes: commit 25a52959f99d ("hw/cxl: Add support for device sanitation")
> >Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>
> Looks good, thanks.
>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
>
> In addition how about the following to further robustify?
>    - disallow certain incoming cci cmd when media is disabled
>    - deal with memory reads/writes when media is disabled
>    - make __toggle_media() a nop when passed value is already set
>    - play nice with arm64 uses little endian reads and writes (this
>      should be extended to all of mbox/cci of course).

All of them make sense to me. I will adjust, thanks!

But I'm not confident enough to write a single description for all the
changes so will
split it into a few patches. May I add your Suggested-by (or
Signed-off-by) in v2
as it will contain some part of your idea and code?

> ----8<-----------------------------
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 6eff56fb1b34..9bc5121215c9 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -1314,6 +1314,7 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t se=
t, uint8_t cmd,
>       int ret;
>       const struct cxl_cmd *cxl_cmd;
>       opcode_handler h;
> +    CXLType3Dev *ct3d =3D CXL_TYPE3(cci->d);
>
>       *len_out =3D 0;
>       cxl_cmd =3D &cci->cxl_cmd_set[set][cmd];
> @@ -1334,8 +1335,8 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t se=
t, uint8_t cmd,
>           return CXL_MBOX_BUSY;
>       }
>
> -    /* forbid any selected commands while overwriting */
> -    if (sanitize_running(cci)) {
> +    /* forbid any selected commands when necessary */
> +    if (sanitize_running(cci) || cxl_dev_media_disabled(&ct3d->cxl_dstat=
e)) {
>           if (h =3D=3D cmd_events_get_records ||
>               h =3D=3D cmd_ccls_get_partition_info ||
>               h =3D=3D cmd_ccls_set_lsa ||
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 72d93713473d..e0a164fde007 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -899,7 +899,8 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_=
addr, uint64_t *data,
>           return MEMTX_ERROR;
>       }
>
> -    if (sanitize_running(&ct3d->cci)) {
> +    if (sanitize_running(&ct3d->cci) ||
> +        cxl_dev_media_disabled(&ct3d->cxl_dstate)) {
>           qemu_guest_getrandom_nofail(data, size);
>           return MEMTX_OK;
>       }
> @@ -925,6 +926,11 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr hos=
t_addr, uint64_t data,
>           return MEMTX_OK;
>       }
>
> +    /* memory writes to the device will have no effect */
> +    if (cxl_dev_media_disabled(&ct3d->cxl_dstate)) {
> +        return MEMTX_OK;
> +    }
> +
>       return address_space_write(as, dpa_offset, attrs, &data, size);
>   }
>
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 873e6d6ab159..007d4169df7c 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -349,14 +349,26 @@ REG64(CXL_MEM_DEV_STS, 0)
>       FIELD(CXL_MEM_DEV_STS, MBOX_READY, 4, 1)
>       FIELD(CXL_MEM_DEV_STS, RESET_NEEDED, 5, 3)
>
> +static inline bool cxl_dev_media_disabled(CXLDeviceState *cxl_dstate)
> +{
> +    uint64_t dev_status_reg;
> +
> +    dev_status_reg =3D ldq_le_p(cxl_dstate->mbox_reg_state64 + R_CXL_MEM=
_DEV_STS);
> +    return FIELD_EX64(dev_status_reg, CXL_MEM_DEV_STS, MEDIA_STATUS) =3D=
=3D 0x3;
> +}
> +
>   static inline void __toggle_media(CXLDeviceState *cxl_dstate, int val)
>   {
>       uint64_t dev_status_reg;
>
> -    dev_status_reg =3D cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS];
> +    dev_status_reg =3D ldq_le_p(cxl_dstate->mbox_reg_state64 + R_CXL_MEM=
_DEV_STS);
> +    if (FIELD_EX64(dev_status_reg, CXL_MEM_DEV_STS, MEDIA_STATUS) =3D=3D=
 val) {
> +        return;
> +    }
> +
>       dev_status_reg =3D FIELD_DP64(dev_status_reg, CXL_MEM_DEV_STS, MEDI=
A_STATUS,
>                                   val);
> -    cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS] =3D dev_status_reg;
> +    stq_le_p(cxl_dstate->mbox_reg_state64 + R_CXL_MEM_DEV_STS, dev_statu=
s_reg);
>   }
>   #define cxl_dev_disable_media(cxlds)                    \
>           do { __toggle_media((cxlds), 0x3); } while (0)

