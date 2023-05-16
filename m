Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A471705B5F
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 01:35:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz4Ar-0007ea-BA; Tue, 16 May 2023 19:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1pz4Ap-0007eL-Eo
 for qemu-devel@nongnu.org; Tue, 16 May 2023 19:33:43 -0400
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1pz4Ao-000421-0q
 for qemu-devel@nongnu.org; Tue, 16 May 2023 19:33:43 -0400
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-44fc48d993fso86733e0c.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 16:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684280020; x=1686872020;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9jvGmBLyo8pIoHvtncQypO9VBm17/51MxUk8A1UYCGU=;
 b=KueyrdwbAUyKpqZia25FC0/jSaoir9j+EnWVi/MfeaPS3AlOllQypOxYlTHaRoLhHl
 +Sh6Ut4Yd09LIARu+yarwj7jirPzzw/QQyQsxJke4J4UY2njc90EiC774uSgkAOzm3QU
 glxgAsMFI6BYwgYEp+uHGL1Zy06l9t31OlcPq9jcm7NLZECWzB4N0OyzBfZyHT5vdawK
 9AR2uBQfB3wrP0QJ0fMh+apT2LqVagbu12kxvvetfEVzCXCQ7CUnvO8hdS9QqgJpnmKa
 ev7xTPHHlvx33OXRGbGEz9Sq7xW8I2rRleZcQCLohfliIUV6T3B+wfJvUKfsYGAnze20
 ME0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684280020; x=1686872020;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9jvGmBLyo8pIoHvtncQypO9VBm17/51MxUk8A1UYCGU=;
 b=TI/+JSshaTeAVjwUB0bigH+xmyiaxr19fDNeIolcjGJzwm3fyeGobF3YLnzfF163GV
 FNwq0ct/R5pI6DpJ7gFQXQk4zEseN+4CJnlsPJ/DEzIpVQItW01Xk3C6yd9Bzd1FoGuy
 5Bbc9KkvQP/Q8JMxrA+MLtzLGJYROKvQpkuxDNSG5OD9m8pG4i57pion+tCZRyk3QnEL
 m2Etp8lOZ35CgOYL05kP+EGaxrK3dSSzEeF1WTY1Shrfjl48otSBHpeGHsfqrp76jnMq
 k3rL8/sHrZm4VFakgZgkZwr0SPutMqcFE75Jcq/hLdnJ7r7runVPBeFNydZlFFbqVUyG
 exmA==
X-Gm-Message-State: AC+VfDyjSFsKh1InlqQdQvquA1tfZxMDXOfD0H4y0QWLlSUd1puDhP1Z
 Rn4URJ+0vAzYtcuNr/p4TrtAmjm5QLlPduO1XGk=
X-Google-Smtp-Source: ACHHUZ4JL3R2Cx3sM8nZxUGCegmvZVV/4WKZbFbljAh2JLXssOY2031rdQmTbL898s2TSZVVJV6rmRugMY7WaiybmoI=
X-Received: by 2002:a1f:5e56:0:b0:43f:cadf:9ef3 with SMTP id
 s83-20020a1f5e56000000b0043fcadf9ef3mr13149435vkb.8.1684280020567; Tue, 16
 May 2023 16:33:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230503085657.1814850-1-richard.henderson@linaro.org>
 <20230503085657.1814850-2-richard.henderson@linaro.org>
In-Reply-To: <20230503085657.1814850-2-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 17 May 2023 09:33:14 +1000
Message-ID: <CAKmqyKPeKSF12gSchSDKepXK=Po8=3Lup8qwua9RVBJD8D9NrA@mail.gmail.com>
Subject: Re: [PATCH 01/11] disas/riscv: Decode czero.{eqz,nez}
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, dbarboza@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa32.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, May 3, 2023 at 6:59=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  disas/riscv.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/disas/riscv.c b/disas/riscv.c
> index d6b0fbe5e8..c0a8b1006a 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -935,6 +935,8 @@ typedef enum {
>      rv_op_vsetvli =3D 766,
>      rv_op_vsetivli =3D 767,
>      rv_op_vsetvl =3D 768,
> +    rv_op_czero_eqz =3D 769,
> +    rv_op_czero_nez =3D 770,
>  } rv_op;
>
>  /* structures */
> @@ -2066,7 +2068,9 @@ const rv_opcode_data opcode_data[] =3D {
>      { "vsext.vf8", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, rv_op_vsext_vf8=
, rv_op_vsext_vf8, 0 },
>      { "vsetvli", rv_codec_vsetvli, rv_fmt_vsetvli, NULL, rv_op_vsetvli, =
rv_op_vsetvli, 0 },
>      { "vsetivli", rv_codec_vsetivli, rv_fmt_vsetivli, NULL, rv_op_vsetiv=
li, rv_op_vsetivli, 0 },
> -    { "vsetvl", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, rv_op_vsetvl, rv_op=
_vsetvl, 0 }
> +    { "vsetvl", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, rv_op_vsetvl, rv_op=
_vsetvl, 0 },
> +    { "czero.eqz", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
> +    { "czero.nez", rv_codec_r, rv_fmt_rd_rs1_rs2, NULL, 0, 0, 0 },
>  };
>
>  /* CSR names */
> @@ -2792,6 +2796,8 @@ static void decode_inst_opcode(rv_decode *dec, rv_i=
sa isa)
>              case 45: op =3D rv_op_minu; break;
>              case 46: op =3D rv_op_max; break;
>              case 47: op =3D rv_op_maxu; break;
> +            case 075: op =3D rv_op_czero_eqz; break;
> +            case 077: op =3D rv_op_czero_nez; break;
>              case 130: op =3D rv_op_sh1add; break;
>              case 132: op =3D rv_op_sh2add; break;
>              case 134: op =3D rv_op_sh3add; break;
> --
> 2.34.1
>
>

