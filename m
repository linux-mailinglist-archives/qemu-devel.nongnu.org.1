Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5999C782A9D
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 15:35:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY53P-0006ZC-L8; Mon, 21 Aug 2023 09:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qY53N-0006Yo-FY
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 09:34:45 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qY53K-0007ds-B5
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 09:34:45 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4fe61ae020bso4924878e87.2
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 06:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692624879; x=1693229679;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vSgSyOkxqCv7nlZFrRELUHu1cwaa8TTkOGR9a6OvPwc=;
 b=m8qNlwdyYXrtkt1yLh05y4GA8593DTdrFgHa7h45S6hOXmF5QEnZUR5/2D4SS/p5ah
 yKrFagCT2pvxJoN284nxSlorC7/wJRd25xFj2pjDIuYt52Z3Yf6FrYSuSybT0Rr5cIHg
 Lo58PjmygqF7LqdIl0MCNnknHLv7Vuioun0WBW1K3BdHV+j03KbcYNYFdEsa0F8zHy1v
 7oC9qoydT0jPnCpUqy63RNrb7s+YXPIEBV3QQlYn48yhXTbS+WDDRHtesNlJApdqgRLJ
 DxZMl7k++xYORhljA5XlRZETR2NBp0BkZwMugX9VqMcCWUmD6N7mT0it07XaQma/PN+I
 BjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692624879; x=1693229679;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vSgSyOkxqCv7nlZFrRELUHu1cwaa8TTkOGR9a6OvPwc=;
 b=mGbeYvR3Bl0deit73kMkKiPpkiXgDuC2eCogG0st/2j9Qj0qNfBxOUAm7zoNOxDhGq
 ywE6HUQl9HTCio0DquDR5p0vUW+xtXwiW5PksqGq4G+g27Af/x473wKi1Qp0cpIxIIe2
 88ZJV45Se1eGNmLuIL1Hqwrh8eP+WZAa2p6MjR4hR0a8mGXyzqfEyXNYnNJLmALU6Byh
 zZxnbdhrjqR7nP5dH7Uk+tl1//3cKzj0a03IgL7TL6QQnuG08GgivS3m720AJYRWTZbE
 yvdbmpZmp415sn/bjQpiuPfvzMEhoeKwFIgr2TkHNLkLqFF/GN6pajpnRouNs1vKXR37
 GV/w==
X-Gm-Message-State: AOJu0YzRG3IFPmk4Ns1ed8F2dcrUNgIwUaKltV5D2JYWYzsDL+xL8Rhi
 LfUMG5xVJJ79H4D4eTOSxXwUuWsPy8l4oGKLu3mPyg==
X-Google-Smtp-Source: AGHT+IGrfQfM/nQmskK+cPGV1aFT0nuxobYolj+ZkjVdRIppg37vMIxEI+ruQx2dQ5qSrqzW9/ZjsxFbJgHA6LUqc4E=
X-Received: by 2002:a05:6512:ea4:b0:4fb:8c52:611 with SMTP id
 bi36-20020a0565120ea400b004fb8c520611mr5810342lfb.38.1692624878896; Mon, 21
 Aug 2023 06:34:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230810191626.81084-1-francisco.iglesias@amd.com>
 <20230810191626.81084-6-francisco.iglesias@amd.com>
In-Reply-To: <20230810191626.81084-6-francisco.iglesias@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Aug 2023 14:34:28 +0100
Message-ID: <CAFEAcA8tQh=xwndU=jrnn5WAwKfYpBC0Kpwdvoc4UF+Ca-auRw@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] hw/misc: Introduce a model of Xilinx Versal's
 CFRAME_REG
To: Francisco Iglesias <francisco.iglesias@amd.com>
Cc: qemu-devel@nongnu.org, frasse.iglesias@gmail.com, alistair@alistair23.me, 
 edgar.iglesias@gmail.com, fkonrad@amd.com, sai.pavan.boddu@amd.com, 
 tong.ho@amd.com, vikram.garhwal@amd.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 10 Aug 2023 at 20:16, Francisco Iglesias
<francisco.iglesias@amd.com> wrote:
>
> Introduce a model of Xilinx Versal's Configuration Frame controller
> (CFRAME_REG).
>
> Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
> ---
>  MAINTAINERS                              |   2 +
>  hw/misc/meson.build                      |   1 +
>  hw/misc/xlnx-versal-cframe-reg.c         | 753 +++++++++++++++++++++++
>  include/hw/misc/xlnx-versal-cframe-reg.h | 289 +++++++++
>  4 files changed, 1045 insertions(+)
>  create mode 100644 hw/misc/xlnx-versal-cframe-reg.c
>  create mode 100644 include/hw/misc/xlnx-versal-cframe-reg.h

> +static XlnxCFrame *cframes_get_frame(XlnxVersalCFrameReg *s, uint32_t addr)
> +{
> +    for (int i = 0; i < s->cframes->len; i++) {
> +        XlnxCFrame *f = &g_array_index(s->cframes, XlnxCFrame, i);
> +
> +        if (f->addr == addr) {
> +            return f;
> +        }
> +    }
> +    return NULL;
> +}

The handling of this and especially how it turns out in
the migration support still feels quite awkward to me.

The operations we want here seem to be:
 * find a cframe given the 'addr'
 * insert a new cframe for a given 'addr', overwriting any
   old data
 * iterate through n cframes starting at a given 'addr'

You can do this with a GTree
https://developer-old.gnome.org/glib/stable/glib-Balanced-Binary-Trees.html
You can use GUINT_TO_POINTER(addr) as the keys, and use
a Fifo32 as your data. Insert-with-overwrite is
g_tree_replace_node(). Find-a-frame is g_tree_lookup().
Iterate through n cframes is
 for (node = g_tree_lookup(...), i = 0; i < n; node =
g_tree_node_next(node), i++) {
    ...
 }

GTrees are supported by the migration code, there is a
VMSTATE_GTREE_DIRECT_KEY_V() macro, so you don't need to
do any pre-save or post-load hooks. (This to me is one
of the main benefits of using it rather than a GArray.)

Is the data in each cframe fixed-size, or can it vary?
The impression I get is that each cframe is always the
same amount of data, and we use a fifo purely to handle
the "guest writes the frame data a word at a time and
when it's all arrived we put it into the cframe data
structure". If so, it might be simpler to use a fifo32
for the new_f, but have the data in the gtree structure
be a simple fixed-size block of memory.

> +
> +static void cframe_alloc(XlnxCFrame *f)
> +{
> +    f->addr = 0;
> +    fifo32_create(&f->data, FRAME_NUM_WORDS);
> +}
> +
> +static void cframe_move(XlnxCFrame *dst, XlnxCFrame *src)
> +{
> +    fifo32_destroy(&dst->data);
> +    dst[0] = src[0];
> +}
> +
> +static void cfrm_fdri_post_write(RegisterInfo *reg, uint64_t val)
> +{
> +    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(reg->opaque);
> +
> +    if (s->row_configured && s->rowon && s->wcfg) {
> +        XlnxCFrame *new_f = &s->new_f;
> +
> +        if (fifo32_num_free(&new_f->data) >= N_WORDS_128BIT) {
> +            fifo32_push(&new_f->data, s->regs[R_FDRI0]);
> +            fifo32_push(&new_f->data, s->regs[R_FDRI1]);
> +            fifo32_push(&new_f->data, s->regs[R_FDRI2]);
> +            fifo32_push(&new_f->data, s->regs[R_FDRI3]);
> +        }
> +
> +        if (fifo32_is_full(&new_f->data)) {
> +            XlnxCFrame *cur_f;
> +
> +            /* Include block type and frame address */
> +            new_f->addr = extract32(s->regs[R_FAR0], 0, 23);
> +
> +            cur_f = cframes_get_frame(s, new_f->addr);
> +
> +            if (cur_f) {
> +                cframe_move(cur_f, new_f);
> +            } else {
> +                g_array_append_val(s->cframes, new_f[0]);
> +            }
> +
> +            cframe_incr_far(s);
> +
> +            /* Realloc new_f */
> +            cframe_alloc(new_f);
> +        }
> +    }
> +}
> +
> +static void cfrm_readout_frames(XlnxVersalCFrameReg *s, uint32_t start_addr,
> +                                uint32_t end_addr)
> +{
> +    for (uint32_t addr = start_addr; addr < end_addr; addr++) {
> +        XlnxCFrame *f = cframes_get_frame(s, addr);
> +
> +        /* Transmit the data if a frame was found */
> +        if (f) {
> +            Fifo32 data = f->data;
> +
> +            while (!fifo32_is_empty(&data)) {
> +                XlnxCfiPacket pkt = {};
> +
> +                g_assert(fifo32_num_used(&data) >= N_WORDS_128BIT);
> +
> +                pkt.data[0] = fifo32_pop(&data);
> +                pkt.data[1] = fifo32_pop(&data);
> +                pkt.data[2] = fifo32_pop(&data);
> +                pkt.data[3] = fifo32_pop(&data);
> +
> +                if (s->cfg.cfu_fdro) {
> +                    xlnx_cfi_transfer_packet(s->cfg.cfu_fdro, &pkt);
> +                }
> +            }
> +        }
> +    }
> +}
> +
> +static void cfrm_frcnt_post_write(RegisterInfo *reg, uint64_t val)
> +{
> +    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(reg->opaque);
> +
> +    if (s->row_configured && s->rowon && s->rcfg) {
> +        uint32_t start_addr = extract32(s->regs[R_FAR0], 0, 23);
> +        uint32_t end_addr = start_addr + s->regs[R_FRCNT0] / FRAME_NUM_QWORDS;
> +
> +        cfrm_readout_frames(s, start_addr, end_addr);
> +    }
> +}

> +static void cframe_reg_cfi_transfer_packet(XlnxCfiIf *cfi_if,
> +                                           XlnxCfiPacket *pkt)
> +{
> +    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(cfi_if);
> +    uint64_t we = MAKE_64BIT_MASK(0, 4 * 8);
> +
> +    if (!s->row_configured) {
> +        return;
> +    }
> +
> +    switch (pkt->reg_addr) {
> +    case CFRAME_FAR:
> +        s->regs[R_FAR0] = pkt->data[0];
> +        break;
> +    case CFRAME_SFR:
> +        s->regs[R_FAR_SFR0] = pkt->data[0];
> +        register_write(&s->regs_info[R_FAR_SFR3], 0,
> +                       we, object_get_typename(OBJECT(s)),
> +                       XLNX_VERSAL_CFRAME_REG_ERR_DEBUG);
> +        break;
> +    case CFRAME_FDRI:
> +    {
> +        s->regs[R_FDRI0] = pkt->data[0];
> +        s->regs[R_FDRI1] = pkt->data[1];
> +        s->regs[R_FDRI2] = pkt->data[2];
> +        register_write(&s->regs_info[R_FDRI3], pkt->data[3],
> +                       we, object_get_typename(OBJECT(s)),
> +                       XLNX_VERSAL_CFRAME_REG_ERR_DEBUG);
> +        break;
> +    }

The braces here seem to be unnecessary ?

> +    case CFRAME_CMD:
> +        ARRAY_FIELD_DP32(s->regs, CMD0, CMD, pkt->data[0]);
> +
> +        register_write(&s->regs_info[R_CMD3], 0,
> +                       we, object_get_typename(OBJECT(s)),
> +                       XLNX_VERSAL_CFRAME_REG_ERR_DEBUG);
> +        break;
> +    default:
> +        break;
> +    }
> +}

> +static void cframe_reg_reset_enter(Object *obj, ResetType type)
> +{
> +    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(obj);
> +    unsigned int i;
> +
> +    for (i = 0; i < ARRAY_SIZE(s->regs_info); ++i) {
> +        register_reset(&s->regs_info[i]);
> +    }
> +    memset(s->wfifo, 0, WFIFO_SZ * sizeof(uint32_t));

Doesn't reset also need to do something about s->new_f
and the other cframes ?

> +}

> +static int cframes_reg_pre_save(void *opaque)
> +{
> +    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(opaque);
> +    uint32_t *cf_data;
> +
> +    s->cf_dlen = s->cframes->len * MIG_CFRAME_SZ;
> +    s->cf_data = g_new(uint8_t, s->cf_dlen);
> +
> +    cf_data = (uint32_t *) s->cf_data;
> +
> +    for (int i = 0; i < s->cframes->len; i++) {
> +        XlnxCFrame *f = &g_array_index(s->cframes, XlnxCFrame, i);
> +        Fifo32 data = f->data;
> +
> +        *cf_data++ = f->addr;
> +
> +        while (!fifo32_is_empty(&data)) {
> +            *cf_data++ = fifo32_pop(&data);
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static int cframes_reg_post_load(void *opaque, int version_id)
> +{
> +    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(opaque);
> +
> +    if (s->cf_dlen) {
> +        uint32_t num_frames = s->cf_dlen / MIG_CFRAME_SZ;
> +        uint32_t *cf_data = (uint32_t *) s->cf_data;
> +        XlnxCFrame new_f;
> +
> +        for (int i = 0; i < num_frames; i++) {
> +            cframe_alloc(&new_f);
> +
> +            new_f.addr = *cf_data++;
> +
> +            while (!fifo32_is_full(&new_f.data)) {
> +                fifo32_push(&new_f.data, *cf_data++);
> +            }
> +
> +            g_array_append_val(s->cframes, new_f);
> +        }
> +    }
> +
> +    g_free(s->cf_data);
> +    s->cf_data = NULL;
> +    s->cf_dlen = 0;
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_cframe_reg = {
> +    .name = TYPE_XLNX_VERSAL_CFRAME_REG,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .pre_save = cframes_reg_pre_save,
> +    .post_load = cframes_reg_post_load,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32_ARRAY(wfifo, XlnxVersalCFrameReg, 4),
> +        VMSTATE_UINT32_ARRAY(regs, XlnxVersalCFrameReg, CFRAME_REG_R_MAX),
> +        VMSTATE_BOOL(rowon, XlnxVersalCFrameReg),
> +        VMSTATE_BOOL(wcfg, XlnxVersalCFrameReg),
> +        VMSTATE_BOOL(rcfg, XlnxVersalCFrameReg),
> +        VMSTATE_VARRAY_UINT32_ALLOC(cf_data, XlnxVersalCFrameReg, cf_dlen,
> +                                    0, vmstate_info_uint8, uint8_t),
> +        VMSTATE_END_OF_LIST(),

This seems to omit migration of s->new_f.

> +    }
> +};
> +
> +static Property cframe_regs_props[] = {
> +    DEFINE_PROP_LINK("cfu-fdro", XlnxVersalCFrameReg, cfg.cfu_fdro,
> +                     TYPE_XLNX_CFI_IF, XlnxCfiIf *),
> +    DEFINE_PROP_UINT32("blktype0-frames", XlnxVersalCFrameReg,
> +                       cfg.blktype_num_frames[0], 0),
> +    DEFINE_PROP_UINT32("blktype1-frames", XlnxVersalCFrameReg,
> +                       cfg.blktype_num_frames[1], 0),
> +    DEFINE_PROP_UINT32("blktype2-frames", XlnxVersalCFrameReg,
> +                       cfg.blktype_num_frames[2], 0),
> +    DEFINE_PROP_UINT32("blktype3-frames", XlnxVersalCFrameReg,
> +                       cfg.blktype_num_frames[3], 0),
> +    DEFINE_PROP_UINT32("blktype4-frames", XlnxVersalCFrameReg,
> +                       cfg.blktype_num_frames[4], 0),
> +    DEFINE_PROP_UINT32("blktype5-frames", XlnxVersalCFrameReg,
> +                       cfg.blktype_num_frames[5], 0),
> +    DEFINE_PROP_UINT32("blktype6-frames", XlnxVersalCFrameReg,
> +                       cfg.blktype_num_frames[6], 0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void cframe_reg_class_init(ObjectClass *klass, void *data)
> +{
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    XlnxCfiIfClass *xcic = XLNX_CFI_IF_CLASS(klass);
> +
> +    dc->vmsd = &vmstate_cframe_reg;
> +    dc->realize = cframe_reg_realize;
> +    rc->phases.enter = cframe_reg_reset_enter;
> +    rc->phases.hold = cframe_reg_reset_hold;
> +    device_class_set_props(dc, cframe_regs_props);
> +    xcic->cfi_transfer_packet = cframe_reg_cfi_transfer_packet;
> +}
> +
> +static const TypeInfo cframe_reg_info = {
> +    .name          = TYPE_XLNX_VERSAL_CFRAME_REG,
> +    .parent        = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(XlnxVersalCFrameReg),
> +    .class_init    = cframe_reg_class_init,
> +    .instance_init = cframe_reg_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { TYPE_XLNX_CFI_IF },
> +        { }
> +    }
> +};
> +
> +static void cframe_reg_register_types(void)
> +{
> +    type_register_static(&cframe_reg_info);
> +}
> +
> +type_init(cframe_reg_register_types)

thanks
-- PMM

