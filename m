Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C48F07DBEC9
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 18:24:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxVzH-0005xB-Im; Mon, 30 Oct 2023 13:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qxVzF-0005wS-Ti
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 13:23:37 -0400
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qxVzE-0005A7-C6
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 13:23:37 -0400
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-d8a000f6a51so3995262276.3
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 10:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698686614; x=1699291414; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1VIbmOESTdpCqGUauknvK/uXq2lrtBQkLAynUoS3kuA=;
 b=PKAA7HMF8U43jQBuRj7fRV5jCa7//tCVvCyxQlB+5ZTPa66CwoZo+6nV1rJSeHlfOz
 2umC+6G/nTBkrzJLm+E/BOKL1Z6hlBVDV2SKYjvb2onQCZBCEba4tSvsa5oWqBjSBRBk
 QIlZwxWWZ8+thXoXCAI3rE7awuvvagfk7tVfh8aUQfaUH5Z+ijZ4YEEnX3jD7CDvHfCW
 PiHZtebI36q4XtDJu5Rrxi4ftuNsPG//l+sq1sOKAKf5Dp47w2888WQ27Pm2/A+v2Bjq
 QxMmARf1zyDwkQuevoSFh5P+Pm3K1SGZZK1fMmCTAimH8kEsbDWeGEAyeGuu+z59Te6p
 /8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698686614; x=1699291414;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1VIbmOESTdpCqGUauknvK/uXq2lrtBQkLAynUoS3kuA=;
 b=kA2KPTr6gNG8hPBW+C04Gt+TUGCuHs+Ur+S/vFuLIvymgTi482A6DYmItIRaKQS9b3
 xvpb2/dakjwXgIcyhBpTG4ZIx7Uh/6DePm4cFrYqZdQgDzR4H1jZ656zfGntYjZ9r+qO
 pGGT0AxeojuwWXdRDP6sN14vkl6MFw3OK290xbpUOSqtTBtKBpMbdT6LhZyaA6rR0Kqe
 a9jT1wlXrCj6WZma8YK9hPaDcpNai8Wg6mSi+lVRelcTESy+p+RryU9siEY/OrwM+OlZ
 i7se6ZepWZdJGmcp7SL4R5B+rJDtGR5V8lEMcGIse84q3/tiI1cuQ2mnX71mih5Ifui7
 jl+g==
X-Gm-Message-State: AOJu0YyZ7RT1PeCbvlOhx0Sgk0umaGoBWsb/7RuQBQAetAIj4lcOXWBG
 RZ06fCmxda7PWDCYNK4KsO8za7SRggyKJ3gNHQs=
X-Google-Smtp-Source: AGHT+IFJC5wtlyVCKLmWvtZ/s0/Kaf5zk6CWes65LfE2m/yN+CuyId4odqgXhGjcYSRQ60eXFNVVSA==
X-Received: by 2002:a25:d784:0:b0:d78:f32:5849 with SMTP id
 o126-20020a25d784000000b00d780f325849mr9386977ybg.24.1698686613669; 
 Mon, 30 Oct 2023 10:23:33 -0700 (PDT)
Received: from [192.168.68.107] ([179.193.10.161])
 by smtp.gmail.com with ESMTPSA id
 m65-20020a253f44000000b00d974c72068fsm4074115yba.4.2023.10.30.10.23.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 10:23:33 -0700 (PDT)
Message-ID: <353c66b6-605f-4055-b791-28980c480163@ventanamicro.com>
Date: Mon, 30 Oct 2023 14:23:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/14] target/riscv: Replace Zvbb checking by Zvkb
Content-Language: en-US
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Lawrence Hunter <lawrence.hunter@codethink.co.uk>,
 Nazar Kazakov <nazar.kazakov@codethink.co.uk>
References: <20231026151828.754279-1-max.chou@sifive.com>
 <20231026151828.754279-5-max.chou@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231026151828.754279-5-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yb1-xb32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 10/26/23 12:18, Max Chou wrote:
> The Zvkb extension is a proper subset of the Zvbb extension and includes
> following instructions:
>    * vandn.[vv,vx]
>    * vbrev8.v
>    * vrev8.v
>    * vrol.[vv,vx]
>    * vror.[vv,vx,vi]
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/insn_trans/trans_rvvk.c.inc | 37 +++++++++++++++---------
>   1 file changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvvk.c.inc b/target/riscv/insn_trans/trans_rvvk.c.inc
> index e691519ed78..3801c16829d 100644
> --- a/target/riscv/insn_trans/trans_rvvk.c.inc
> +++ b/target/riscv/insn_trans/trans_rvvk.c.inc
> @@ -112,24 +112,27 @@ GEN_VX_MASKED_TRANS(vclmulh_vx, vclmul_vx_check)
>           return false;                                            \
>       }
>   
> -static bool zvbb_vv_check(DisasContext *s, arg_rmrr *a)
> +static bool zvkb_vv_check(DisasContext *s, arg_rmrr *a)
>   {
> -    return opivv_check(s, a) && s->cfg_ptr->ext_zvbb == true;
> +    return opivv_check(s, a) &&
> +           (s->cfg_ptr->ext_zvbb == true || s->cfg_ptr->ext_zvkb == true);
>   }
>   
> -static bool zvbb_vx_check(DisasContext *s, arg_rmrr *a)
> +static bool zvkb_vx_check(DisasContext *s, arg_rmrr *a)
>   {
> -    return opivx_check(s, a) && s->cfg_ptr->ext_zvbb == true;
> +    return opivx_check(s, a) &&
> +           (s->cfg_ptr->ext_zvbb == true || s->cfg_ptr->ext_zvkb == true);
>   }
>   
>   /* vrol.v[vx] */
> -GEN_OPIVV_GVEC_TRANS_CHECK(vrol_vv, rotlv, zvbb_vv_check)
> -GEN_OPIVX_GVEC_SHIFT_TRANS_CHECK(vrol_vx, rotls, zvbb_vx_check)
> +GEN_OPIVV_GVEC_TRANS_CHECK(vrol_vv, rotlv, zvkb_vv_check)
> +GEN_OPIVX_GVEC_SHIFT_TRANS_CHECK(vrol_vx, rotls, zvkb_vx_check)
>   
>   /* vror.v[vxi] */
> -GEN_OPIVV_GVEC_TRANS_CHECK(vror_vv, rotrv, zvbb_vv_check)
> -GEN_OPIVX_GVEC_SHIFT_TRANS_CHECK(vror_vx, rotrs, zvbb_vx_check)
> -GEN_OPIVI_GVEC_TRANS_CHECK(vror_vi, IMM_TRUNC_SEW, vror_vx, rotri, zvbb_vx_check)
> +GEN_OPIVV_GVEC_TRANS_CHECK(vror_vv, rotrv, zvkb_vv_check)
> +GEN_OPIVX_GVEC_SHIFT_TRANS_CHECK(vror_vx, rotrs, zvkb_vx_check)
> +GEN_OPIVI_GVEC_TRANS_CHECK(vror_vi, IMM_TRUNC_SEW, vror_vx, rotri,
> +                           zvkb_vx_check)
>   
>   #define GEN_OPIVX_GVEC_TRANS_CHECK(NAME, SUF, CHECK)                     \
>       static bool trans_##NAME(DisasContext *s, arg_rmrr *a)               \
> @@ -147,8 +150,8 @@ GEN_OPIVI_GVEC_TRANS_CHECK(vror_vi, IMM_TRUNC_SEW, vror_vx, rotri, zvbb_vx_check
>       }
>   
>   /* vandn.v[vx] */
> -GEN_OPIVV_GVEC_TRANS_CHECK(vandn_vv, andc, zvbb_vv_check)
> -GEN_OPIVX_GVEC_TRANS_CHECK(vandn_vx, andcs, zvbb_vx_check)
> +GEN_OPIVV_GVEC_TRANS_CHECK(vandn_vv, andc, zvkb_vv_check)
> +GEN_OPIVX_GVEC_TRANS_CHECK(vandn_vx, andcs, zvkb_vx_check)
>   
>   #define GEN_OPIV_TRANS(NAME, CHECK)                                        \
>       static bool trans_##NAME(DisasContext *s, arg_rmr *a)                  \
> @@ -188,8 +191,16 @@ static bool zvbb_opiv_check(DisasContext *s, arg_rmr *a)
>              vext_check_ss(s, a->rd, a->rs2, a->vm);
>   }
>   
> -GEN_OPIV_TRANS(vbrev8_v, zvbb_opiv_check)
> -GEN_OPIV_TRANS(vrev8_v, zvbb_opiv_check)
> +static bool zvkb_opiv_check(DisasContext *s, arg_rmr *a)
> +{
> +    return (s->cfg_ptr->ext_zvbb == true || s->cfg_ptr->ext_zvkb == true) &&
> +           require_rvv(s) &&
> +           vext_check_isa_ill(s) &&
> +           vext_check_ss(s, a->rd, a->rs2, a->vm);
> +}
> +
> +GEN_OPIV_TRANS(vbrev8_v, zvkb_opiv_check)
> +GEN_OPIV_TRANS(vrev8_v, zvkb_opiv_check)
>   GEN_OPIV_TRANS(vbrev_v, zvbb_opiv_check)
>   GEN_OPIV_TRANS(vclz_v, zvbb_opiv_check)
>   GEN_OPIV_TRANS(vctz_v, zvbb_opiv_check)

