Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 540E376EBB5
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 16:02:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRYtg-0003yW-JK; Thu, 03 Aug 2023 10:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRYte-0003rQ-U8
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 10:01:46 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRYtY-0006GP-9j
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 10:01:46 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-4fe28e4671dso1813636e87.0
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 07:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691071297; x=1691676097;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5X7700hdHct6vaxJzK5A0soZ22RG3fOPU9zJGZNj07A=;
 b=GAnkYi8w3+oTtV3NT/84m7HuIVKi1kbPu3J/SE60Yg44GQXu/IU7WMyfniNPSvoNYB
 fep1a6ZGtCMxD4bq2sWlXVX4VLO7CDkwvzPS219MT/KPKfzIxgsZBw40ha8lo6QPN59g
 gNTJI6u6z6sNrJ+NYXJU91b9bkkW64XvaEjp99uB9lkHAW9u0J4bJP4B5wMLl7NALMZe
 7heBv8VOHCYJ/MLeJ6JfhB+rFN0/XkMRJLuTswoh2yWBYKJAlrCxtMQqyewfbgvAeVAr
 6CWnXEChUeX2B4nEyCZioTYeDShGkSP0L2uRlYrbPPDmuj2uAhw8UNqc7XF702vL2tkh
 7ZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691071297; x=1691676097;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5X7700hdHct6vaxJzK5A0soZ22RG3fOPU9zJGZNj07A=;
 b=K59wDRa4IFm8yoQyEPpPo+1rXtUQnCKqkNrjpwFw4/MziAwwrI3u5NjYt4CJ5j9k2y
 4rQcd2k4xirdQRhoRSzE9zIfkJxaC42Mj2NHo4Cu5i8618CIduI12FcOJULcIJBFKOCz
 fymHRHUQkn34UCuUzF72G8zVoCCX5isEyBvjrHdSnRYYxFaywcF3bOQp4e0ASfZizs8Z
 UVmWG6xPvvOpvpkMhoh8i84r8+NyE2d05wKrw8Lw5G/c9t1g16MSR0YRRFdqtd6u1/YV
 a6pHu+nRKYyu7JCkDFM+qKtnaMN9Uj7iG8aIrUh1j55ifwGVq/YUV9I5v/mSnet3qe1t
 F+gQ==
X-Gm-Message-State: ABy/qLbYRmh4mehvoNDhh/Uv10oet16MAOr0I3k443ltHFAXtBaMPRkR
 +hs8CqVmL2DXiGA5fshx/bdps5MpgAoQm57MBkuIGQ==
X-Google-Smtp-Source: APBJJlGiIO2Pu7bOS7Nr21/n9jjnkgHgo7Wo/EDjq37OLTsYTToC3R0PB4RxCVwnoI4+ucdu6OOKxH3ZNfznRZfhmAg=
X-Received: by 2002:ac2:5931:0:b0:4fe:af6:5e5 with SMTP id
 v17-20020ac25931000000b004fe0af605e5mr6912814lfi.23.1691071296676; 
 Thu, 03 Aug 2023 07:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230710140249.56324-1-francisco.iglesias@amd.com>
 <20230710140249.56324-6-francisco.iglesias@amd.com>
In-Reply-To: <20230710140249.56324-6-francisco.iglesias@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Aug 2023 15:01:25 +0100
Message-ID: <CAFEAcA8pVmfhrWQM7EjOjRrrY8rwOdXU65+rjcmnT_=LdK372Q@mail.gmail.com>
Subject: Re: [PATCH v1 5/8] hw/misc: Introduce a model of Xilinx Versal's
 CFRAME_REG
To: Francisco Iglesias <francisco.iglesias@amd.com>
Cc: qemu-devel@nongnu.org, frasse.iglesias@gmail.com, alistair@alistair23.me, 
 edgar.iglesias@gmail.com, fkonrad@amd.com, sai.pavan.boddu@amd.com, 
 tong.ho@amd.com, vikram.garhwal@amd.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12a.google.com
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
> Introduce a model of Xilinx Versal's Configuration Frame controller
> (CFRAME_REG).
>
> Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
> ---
>  MAINTAINERS                              |   2 +
>  hw/misc/meson.build                      |   1 +
>  hw/misc/xlnx-versal-cframe-reg.c         | 714 +++++++++++++++++++++++
>  include/hw/misc/xlnx-versal-cframe-reg.h | 288 +++++++++
>  4 files changed, 1005 insertions(+)
>  create mode 100644 hw/misc/xlnx-versal-cframe-reg.c
>  create mode 100644 include/hw/misc/xlnx-versal-cframe-reg.h
>



> +#define KEYHOLE_STREAM_4K 0x1000

You could define this as (4 * KiB) which would then be more
clearly 4K.

> +
> +#define MAX_BLOCKTYPE 6
> +#define MAX_BLOCKTYPE_FRAMES 0xFFFFF
> +
> +enum {
> +    CFRAME_CMD_WCFG = 1,
> +    CFRAME_CMD_ROWON = 2,
> +    CFRAME_CMD_ROWOFF = 3,
> +    CFRAME_CMD_RCFG = 4,
> +    CFRAME_CMD_DLPARK = 5

minor style nit -- leaving the trailing ',' on the last
item in an enum or similar means that the next person
to add another entry doesn't have to edit the previous
line to put the comma in.

> +};

> +static void cfrm_fdri_post_write(RegisterInfo *reg, uint64_t val)
> +{
> +    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(reg->opaque);
> +
> +    if (s->row_configured && s->rowon && s->wcfg) {
> +        XlnxCFrame *new_f = &s->new_f;
> +
> +        new_f->data[new_f->idx++] = s->regs[R_FDRI0];
> +        new_f->data[new_f->idx++] = s->regs[R_FDRI1];
> +        new_f->data[new_f->idx++] = s->regs[R_FDRI2];
> +        new_f->data[new_f->idx++] = s->regs[R_FDRI3];
> +
> +        assert(new_f->idx <= FRAME_NUM_WORDS);

We should assert that we're not overrunning the array
*before* we write the data, not afterwards.

More generally, this kind of "we have a data array and
an index into it and we store stuff in at the index"
is prime territory for bugs resulting in array overruns.
If there's a way to write it that makes it clear that
that can't happen (esp. abstracting out what the operations
on the data structure are, documenting the invariants, etc)
then we should take it.

> +
> +        if (new_f->idx == FRAME_NUM_WORDS) {
> +            XlnxCFrame *cur_f;
> +
> +            /* Include block type and frame address */
> +            new_f->addr = extract32(s->regs[R_FAR0], 0, 23);
> +
> +            cur_f = cframes_get_frame(s, new_f->addr);
> +
> +            if (cur_f) {
> +                /* Overwrite current frame */
> +                cur_f[0] = new_f[0];
> +            } else {
> +                g_array_append_val(s->cframes, new_f[0]);
> +            }
> +
> +            cframe_incr_far(s);
> +
> +            /* Clear out new_f */
> +            memset(new_f, 0, sizeof(*new_f));
> +        }
> +    }
> +}

> +static int cframes_reg_pre_save(void *opaque)
> +{
> +    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(opaque);
> +
> +    if (s->cframes->len) {
> +        s->cf_data = (uint32_t *) s->cframes->data;
> +        s->cf_dlen = s->cframes->len * g_array_get_element_size(s->cframes) / 4;
> +    }
> +    return 0;
> +}
> +
> +static int cframes_reg_post_load(void *opaque, int version_id)
> +{
> +    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(opaque);
> +
> +    if (s->cf_dlen) {
> +        uint32_t num_frames = s->cf_dlen /
> +                              (g_array_get_element_size(s->cframes) / 4);
> +        g_array_append_vals(s->cframes, s->cf_data, num_frames);
> +    }
> +    return 0;
> +}

Same remarks here about handling of GArray vs VMSTATE ALLOC.

(Or we could implement a VMSTATE macro/support for GArrays,
I guess. That would arguably be neater.)

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
> +                                    0, vmstate_info_uint32, uint32_t),
> +        VMSTATE_END_OF_LIST(),
> +    }
> +};
> +
> +static Property cframe_regs_props[] = {
> +    /* Kept for backwards compatibility */

Backwards compatibility with who? This is the first implementation
of this as far as upstream is concerned...

> +    DEFINE_PROP_LINK("cfu", XlnxVersalCFrameReg, cfg.cfu_fdro,
> +                     TYPE_XLNX_CFI_IF, XlnxCfiIf *),
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

thanks
-- PMM

