Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCB478C9D8
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 18:45:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb1pv-0006da-KX; Tue, 29 Aug 2023 12:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qb1pj-0006XZ-2g
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:44:51 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qb1pg-0001Uj-CF
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:44:50 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2bcb50e194dso70659351fa.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 09:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693327486; x=1693932286;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TgQwfMF9wRv3f5hpfe8wth4gls5dTBKkwZqRIZ0IVkE=;
 b=VCocjj0cIOVLE2+7jGHHORk4uaLBTHr6C1fN4ikyFmihYxHfJh1ZAdBaPAg2wcICgE
 fdx6OQsUqEHUOq+USvHZKCRAWC+whZhwAyeFd06anM2XDFu8dZ3CXRtU2HxO4mQ7GEF6
 s0Su7BJ8lBHSN4wAeQZNfwnSfgBdp+tOFIrrkIEqiD9butuD8VCPDqTjAavjCCChhF6J
 b7hPGhKWPFAlHsZO9+2FyJZyVb4mYWXSqTEkIoKW2ucdMe0BKiDaveoc8bl6LnmpNbw9
 UDr87ACG1hI3qD+tCgxjRBSpzQk/KV4Wq36uBs8M2rJAXWKZp0HA83AdfFUOb/3WdSKn
 7puw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693327486; x=1693932286;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TgQwfMF9wRv3f5hpfe8wth4gls5dTBKkwZqRIZ0IVkE=;
 b=G0gjlLx5HAkmMJQQdUnCrO9E7tn7FL42ShaVc7Wciq8dppkoSbuhhVebzFWBxgv/0S
 ooQF35/oBFzVHzv5iFP49VakQkT4UQnP3dYWd0Nz7bKD7110xSWwgSMtLkvT3i5c5L4T
 pYbmkQ9AwmR3BoBi6eH2jeFz06YBxgVhLRxh7+QfxxVKLM/HYHCATvegg11ROsAhNhYK
 OhCnBBl9sI00lfpdLW5UD6R+3T/SpdSmZR6yjpF7I9Ca7er9fwvNab8136gryETVv2AH
 djA4C0nJ57QvZ2jzCzYgdl0vUkLVOhHdJrHSf62YHsoj2OsgKTeQOInRdyBGi6Bu8uB8
 2j1Q==
X-Gm-Message-State: AOJu0YwIbtpJjKQXvs7bFfJPA4ABDpe/tCf1CqznVBXBqKFf09S7eLGA
 3aiqhxaY4phx6TRvbJyo3UBgA9qmRIYhCQoalKE/DA==
X-Google-Smtp-Source: AGHT+IFYm/DOqO1kAa+fGtAxM7gACuz9ReHEG82uD1Dn0l71ML7I178UB1F9TllVLaccvOTp6uHFQg5qkdiT5a8bDa8=
X-Received: by 2002:a05:6512:2307:b0:500:bddc:56d5 with SMTP id
 o7-20020a056512230700b00500bddc56d5mr3857063lfu.37.1693327486508; Tue, 29 Aug
 2023 09:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230824183448.151738-1-francisco.iglesias@amd.com>
 <20230824183448.151738-6-francisco.iglesias@amd.com>
In-Reply-To: <20230824183448.151738-6-francisco.iglesias@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Aug 2023 17:44:35 +0100
Message-ID: <CAFEAcA_Es_sX4O-oqX9E49LTWUMDzv6sao2i3Fb-YCqg9M8WXA@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] hw/misc: Introduce a model of Xilinx Versal's
 CFRAME_REG
To: Francisco Iglesias <francisco.iglesias@amd.com>
Cc: qemu-devel@nongnu.org, frasse.iglesias@gmail.com, alistair@alistair23.me, 
 edgar.iglesias@gmail.com, fkonrad@amd.com, sai.pavan.boddu@amd.com, 
 tong.ho@amd.com, vikram.garhwal@amd.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x229.google.com
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

On Thu, 24 Aug 2023 at 19:35, Francisco Iglesias
<francisco.iglesias@amd.com> wrote:
>
> Introduce a model of Xilinx Versal's Configuration Frame controller
> (CFRAME_REG).
>
> Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>

> +static void cfrm_fdri_post_write(RegisterInfo *reg, uint64_t val)
> +{
> +    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(reg->opaque);
> +
> +    if (s->row_configured && s->rowon && s->wcfg) {
> +
> +        if (fifo32_num_free(&s->new_f_data) >= N_WORDS_128BIT) {
> +            fifo32_push(&s->new_f_data, s->regs[R_FDRI0]);
> +            fifo32_push(&s->new_f_data, s->regs[R_FDRI1]);
> +            fifo32_push(&s->new_f_data, s->regs[R_FDRI2]);
> +            fifo32_push(&s->new_f_data, s->regs[R_FDRI3]);
> +        }
> +
> +        if (fifo32_is_full(&s->new_f_data)) {
> +            uint32_t addr = extract32(s->regs[R_FAR0], 0, 23);
> +            XlnxCFrame *f = g_new(XlnxCFrame, 1);
> +
> +            memcpy(f->data, s->new_f_data.fifo.data, sizeof(f->data));

This works, but it's going under the hood of the Fifo32 abstraction
and makes the assumptions that (a) if you only push to the fifo
and never pop then the data is going to be contiguous from the
start of the fifo internal buffer and (b) that fifo32_push()
pushes the bytes of the 32 bit value in little endian order.
Those are both true at the moment, but fifo32 doesn't explicitly
guarantee either of them...

> +
> +            g_tree_replace(s->cframes, GUINT_TO_POINTER(addr), f);
> +
> +            cframe_incr_far(s);
> +
> +            fifo32_reset(&s->new_f_data);
> +        }
> +    }
> +}
> +
> +static void cfrm_readout_frames(XlnxVersalCFrameReg *s, uint32_t start_addr,
> +                                uint32_t end_addr)
> +{
> +    for (uint32_t addr = start_addr; addr < end_addr; addr++) {
> +        XlnxCFrame *f = g_tree_lookup(s->cframes, GUINT_TO_POINTER(addr));

You don't need to g_tree_lookup() for every address. If
you use g_tree_lookup_node() you get a GTreeNode* back,
and you can then iterate through the tree from that point using
g_tree_node_next(), something like this:

     for (node = g_tree_lookup_node(s->cframes, GUINT_TO_POINTER(addr));
          node && GPOINTER_TO_UINT(g_tree_node_key(node)) < end_addr;
          node = g_tree_node_next(node)) {
         XlnxCFrame *f = g_tree_node_value(node);  // definitely not NULL
         /* Transmit the data */
         for (int i = 0; i < FRAME_NUM_WORDS; i += 4) {
             ... etc ...
         }
     }



> +
> +        /* Transmit the data if a frame was found */
> +        if (f) {
> +            for (int i = 0; i < FRAME_NUM_WORDS; i += 4) {
> +                XlnxCfiPacket pkt = {};
> +
> +                pkt.data[0] = f->data[i];
> +                pkt.data[1] = f->data[i + 1];
> +                pkt.data[2] = f->data[i + 2];
> +                pkt.data[3] = f->data[i + 3];
> +
> +                if (s->cfg.cfu_fdro) {
> +                    xlnx_cfi_transfer_packet(s->cfg.cfu_fdro, &pkt);
> +                }
> +            }
> +        }
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
> +    fifo32_reset(&s->new_f_data);
> +
> +    if (g_tree_height(s->cframes)) {

Calculating g_tree_height() requires walking the tree.
Using g_tree_nnodes() is faster because that's just a field
in the GTree struct.

> +        g_tree_destroy(s->cframes);
> +        s->cframes = g_tree_new_full((GCompareDataFunc)int_cmp, NULL,
> +                                      NULL, (GDestroyNotify) g_free);

Faster to do
    /*
     * Take a reference so when g_tree_destroy() unrefs it we keep the
     * GTree and only destroy its contents. NB: when our minimum
     * glib version is at least 2.70 we could use g_tree_remove_all().
     */
    g_tree_ref(s->cframes);
    g_tree_destroy(s->cframes);

> +    }
> +}

> +
> +static void cframe_reg_init(Object *obj)
> +{
> +    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(obj);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> +    RegisterInfoArray *reg_array;
> +
> +    memory_region_init(&s->iomem, obj, TYPE_XLNX_VERSAL_CFRAME_REG,
> +                       CFRAME_REG_R_MAX * 4);
> +    reg_array =
> +        register_init_block32(DEVICE(obj), cframe_reg_regs_info,
> +                              ARRAY_SIZE(cframe_reg_regs_info),
> +                              s->regs_info, s->regs,
> +                              &cframe_reg_ops,
> +                              XLNX_VERSAL_CFRAME_REG_ERR_DEBUG,
> +                              CFRAME_REG_R_MAX * 4);
> +    memory_region_add_subregion(&s->iomem,
> +                                0x0,
> +                                &reg_array->mem);
> +    sysbus_init_mmio(sbd, &s->iomem);
> +    memory_region_init_io(&s->iomem_fdri, obj, &cframe_reg_fdri_ops, s,
> +                          TYPE_XLNX_VERSAL_CFRAME_REG "-fdri",
> +                          KEYHOLE_STREAM_4K);
> +    sysbus_init_mmio(sbd, &s->iomem_fdri);
> +    sysbus_init_irq(sbd, &s->irq_cfrm_imr);
> +
> +    s->cframes = g_tree_new_full((GCompareDataFunc)int_cmp, NULL,
> +                                  NULL, (GDestroyNotify) g_free);

Stray space before 'g_free'.

> +    fifo32_create(&s->new_f_data, FRAME_NUM_WORDS);
> +}

thanks
-- PMM

