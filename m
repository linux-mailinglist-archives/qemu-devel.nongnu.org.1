Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AE776EB2B
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 15:49:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRYgz-0006uF-R3; Thu, 03 Aug 2023 09:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRYgx-0006tc-Su
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 09:48:39 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRYgw-00063p-2R
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 09:48:39 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-51e429e1eabso1237306a12.2
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 06:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691070516; x=1691675316;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7cXQKAoQ9gPtilfvSShJ+uw1HrqysYKaRs9JKUWogBw=;
 b=mVvDmcbMbmzO7+eBqsXivCM2eemcFsALBHbiaBaKjatDu3mgde5ki0TFmN23xfN0fh
 fTEyytIAA97stDq7XiQz6KDDzqe4ntI9KlOG2UqEkH3opB0n1E4NdGShm22xxKU2jSUQ
 q6sWKSDH6HDMrvoENR0skkWUFzRiNtRpqvIdeqyYv3rkNwKrwpSTAZ5VqdS8ylZeHJcZ
 kQaL6o6PeoHUBtvmjMmkU+8KBWPzq9sljSpqSa0/hW5DMtCRTkyYTHSIoMiJKGj+6i9f
 5vnS8hhAxVDOgGVQNFRwp0rkKVh9GYGpFLp7scX9IQb1AJsyN03cxER0R4upwe2X9lGZ
 dSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691070516; x=1691675316;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7cXQKAoQ9gPtilfvSShJ+uw1HrqysYKaRs9JKUWogBw=;
 b=PRw3gAyYYucDMN20aXCN49l60paAnbEYDk3cxOUmoeLFHk/C989us+/v7+Plq47wNg
 Vl0ComoWMJRhE2P6IMkbXDVNF/FcPfrDqwegNOPnDNrx34ij/If3JBRmCxi4eXQvk7Qp
 lVJZVzPrPZZpD+6Vr3pRM3GE0wOSOgRH0ZwRHN0oyHfZ9Sd9ZLeeEkpiI/yWgSiexL3x
 xzaaVipUkOJbyqbCk6A4RlpdTmkAjrXXU3tQmYUnkVx4FCJ/qoEBp/BTvMAYuQpoLYt0
 D3O5kKl+K9JmfngQNO4ovt1TXDd3tqAbsDMc44a3QoIOJP6KImwbHHizFc4zaayIe38u
 Vggw==
X-Gm-Message-State: ABy/qLZPApVO7WyGkxT7DGfh/CEb97K7QVSw7lAQI9TMMPWp2v3KH/IW
 GYQ7oxdFFuQTgkuOAT5/SjuqJfMicLUHB6ppgtHs+g==
X-Google-Smtp-Source: APBJJlFRh9SLWmLx/OJul1yweq+C0/kV7Jzc2G/6xRZxVnHu/bmBqc7zjtn04lvKj0cJr5D9ZfFlx7CP8BDNZt0oI7c=
X-Received: by 2002:a05:6402:2d8:b0:51e:52bd:68c8 with SMTP id
 b24-20020a05640202d800b0051e52bd68c8mr7742995edx.14.1691070516239; Thu, 03
 Aug 2023 06:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230710140249.56324-1-francisco.iglesias@amd.com>
 <20230710140249.56324-4-francisco.iglesias@amd.com>
In-Reply-To: <20230710140249.56324-4-francisco.iglesias@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Aug 2023 14:48:25 +0100
Message-ID: <CAFEAcA9Qpeh4anC64FBDdqry=H4-sNTZpRfuwqog51LnADtiCQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/8] hw/misc/xlnx-versal-cfu: Introduce a model of
 Xilinx Versal CFU_FDRO
To: Francisco Iglesias <francisco.iglesias@amd.com>
Cc: qemu-devel@nongnu.org, frasse.iglesias@gmail.com, alistair@alistair23.me, 
 edgar.iglesias@gmail.com, fkonrad@amd.com, sai.pavan.boddu@amd.com, 
 tong.ho@amd.com, vikram.garhwal@amd.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Mon, 10 Jul 2023 at 15:03, Francisco Iglesias
<francisco.iglesias@amd.com> wrote:
>
> Introduce a model of Xilinx Versal's Configuration Frame Unit's data out
> port (CFU_FDRO).
>
> Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
> ---
>  hw/misc/xlnx-versal-cfu.c         | 105 ++++++++++++++++++++++++++++++
>  include/hw/misc/xlnx-versal-cfu.h |  11 ++++
>  2 files changed, 116 insertions(+)
>
> diff --git a/hw/misc/xlnx-versal-cfu.c b/hw/misc/xlnx-versal-cfu.c
> index cbd17d2351..528090ef1b 100644
> --- a/hw/misc/xlnx-versal-cfu.c
> +++ b/hw/misc/xlnx-versal-cfu.c
> @@ -257,6 +257,26 @@ static void cfu_stream_write(void *opaque, hwaddr addr, uint64_t value,
>      }
>  }
>
> +static uint64_t cfu_fdro_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    XlnxVersalCFUFDRO *s = XLNX_VERSAL_CFU_FDRO(opaque);
> +    uint64_t ret = 0;
> +
> +    if (s->fdro_data->len) {
> +        ret = g_array_index(s->fdro_data, uint32_t, 0);
> +        g_array_remove_index(s->fdro_data, 0);

This is pretty expensive because everything in the GArray
after element 0 must be copied downwards. Are you sure you
don't want a different data structure ?

What actually is this, and what are the operations we want
to do on it ?

> +    }
> +
> +    return ret;
> +}
> +
> +static void cfu_fdro_write(void *opaque, hwaddr addr, uint64_t value,
> +                           unsigned size)
> +{
> +    qemu_log_mask(LOG_GUEST_ERROR, "%s: Unsupported write from addr=%"
> +                  HWADDR_PRIx "\n", __func__, addr);
> +}
> +
>  static const MemoryRegionOps cfu_stream_ops = {
>      .read = cfu_stream_read,
>      .write = cfu_stream_write,
> @@ -267,6 +287,16 @@ static const MemoryRegionOps cfu_stream_ops = {
>      },
>  };
>
> +static const MemoryRegionOps cfu_fdro_ops = {
> +    .read = cfu_fdro_read,
> +    .write = cfu_fdro_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +};
> +
>  static void cfu_apb_init(Object *obj)
>  {
>      XlnxVersalCFUAPB *s = XLNX_VERSAL_CFU_APB(obj);
> @@ -298,6 +328,24 @@ static void cfu_apb_init(Object *obj)
>      sysbus_init_irq(sbd, &s->irq_cfu_imr);
>  }
>
> +static void cfu_fdro_init(Object *obj)
> +{
> +    XlnxVersalCFUFDRO *s = XLNX_VERSAL_CFU_FDRO(obj);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +
> +    memory_region_init_io(&s->iomem_fdro, obj, &cfu_fdro_ops, s,
> +                          TYPE_XLNX_VERSAL_CFU_FDRO, KEYHOLE_STREAM_4K);
> +    sysbus_init_mmio(sbd, &s->iomem_fdro);
> +    s->fdro_data = g_array_new(FALSE, FALSE, sizeof(uint32_t));
> +}
> +
> +static void cfu_fdro_cfi_transfer_packet(XlnxCfiIf *cfi_if, XlnxCfiPacket *pkt)
> +{
> +    XlnxVersalCFUFDRO *s = XLNX_VERSAL_CFU_FDRO(cfi_if);
> +
> +    g_array_append_vals(s->fdro_data, &pkt->data[0], 4);
> +}
> +
>  static Property cfu_props[] = {
>          DEFINE_PROP_LINK("cframe0", XlnxVersalCFUAPB, cfg.cframe[0],
>                           TYPE_XLNX_CFI_IF, XlnxCfiIf *),
> @@ -344,6 +392,41 @@ static const VMStateDescription vmstate_cfu_apb = {
>      }
>  };
>
> +static int cfdro_reg_pre_save(void *opaque)
> +{
> +    XlnxVersalCFUFDRO *s = XLNX_VERSAL_CFU_FDRO(opaque);
> +
> +    if (s->fdro_data->len) {
> +        s->ro_data = (uint32_t *) s->fdro_data->data;
> +        s->ro_dlen = s->fdro_data->len;
> +    }

I think we need to initialise ro_data and ro_dlen in
the else case here as well. Otherwise they might have old
stale stuff in them that then goes into the migration stream.

> +
> +    return 0;
> +}
> +
> +static int cfdro_reg_post_load(void *opaque, int version_id)
> +{
> +    XlnxVersalCFUFDRO *s = XLNX_VERSAL_CFU_FDRO(opaque);
> +
> +    if (s->ro_dlen) {
> +        g_array_append_vals(s->fdro_data, s->ro_data, s->ro_dlen);
> +    }
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_cfu_fdro = {
> +    .name = TYPE_XLNX_VERSAL_CFU_FDRO,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .pre_save = cfdro_reg_pre_save,
> +    .post_load = cfdro_reg_post_load,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_VARRAY_UINT32_ALLOC(ro_data, XlnxVersalCFUFDRO, ro_dlen,
> +                                    0, vmstate_info_uint32, uint32_t),

This kind of _ALLOC vmstate will cause the migration core
code to g_malloc() you a buffer for the data. We don't
free that anywhere (and if we have a subsequent vmsave
then we will overwrite the ro-data pointer, and leak the
memory).

It might be better to avoid the GArray and just directly
work with a g_malloc()'d buffer of our own, to fit better
with how the _ALLOC vmstate wants to work.

> +        VMSTATE_END_OF_LIST(),
> +    }
> +};
> +
>  static void cfu_apb_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -353,6 +436,15 @@ static void cfu_apb_class_init(ObjectClass *klass, void *data)
>      device_class_set_props(dc, cfu_props);
>  }
>
> +static void cfu_fdro_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    XlnxCfiIfClass *xcic = XLNX_CFI_IF_CLASS(klass);
> +
> +    dc->vmsd = &vmstate_cfu_fdro;
> +    xcic->cfi_transfer_packet = cfu_fdro_cfi_transfer_packet;
> +}

Missing reset method ?

thanks
-- PMM

