Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A44327D718E
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 18:17:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvgYI-0004iR-Bo; Wed, 25 Oct 2023 12:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qvgYE-0004hQ-3c
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 12:16:10 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qvgYC-0007Qg-Gb
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 12:16:09 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5409bc907edso3521488a12.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 09:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698250567; x=1698855367; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=j2ib0fhVeCJUTiOrnrgWdlmaTu/2AusKSY1aBo054ng=;
 b=lv2PMp66P5/iRK8jQ2JyidTfgTjXYik/8m9RSS3IZJBJ9zT0dbZn0DnQU8emseXO87
 FMfgMs4jZYd2FL4LrD9J1Z/UqgsUCsu1zPBab2Sy1I3VWwlG3JPEUYViIHGdNUSSp/I0
 HbazEjF21OLpJLO+GjTcLgL+HKuyoRGh1zjyY8qO9LanhtIcDNHFaeglhuOoOm35SM8i
 jFqdjZsMBEYOkiUx/2kmv97+PNjsTY0h/KXfeTRx2k2ZjRCvhLVIk7Ay467OIcw+oYF1
 tOCLr7ngrb/bvc7kU0yUV+EFQ6aOc3XCbxv/gb1HrgFDFc94gdkUcHY5uAedsp622yHi
 2xuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698250567; x=1698855367;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j2ib0fhVeCJUTiOrnrgWdlmaTu/2AusKSY1aBo054ng=;
 b=MB1+Gllkqw0Qy9m626eUK6qNVsL4Pw7imneu0B5Tn8R+OS+UeVY8uAC00m0f4jcwsa
 7Tt8frg1C24RsG7YduquQRhTuBUMdxeyUu93O+a3rpGw8C39xra3UGlD5yPhjj1oh+kE
 QPb+qF/csMlVw5iVPv4TwHAq3hWVV/HB3s/OSeiPBtU5wpu0lll432sHMKajGtsXD3qW
 RvRwkrKAIfZi6PKx9QnAFTTmUxZkKl62AIq6Avwmtw3/jULDughiEThs/6IYDoyfNOim
 ktVp4jdkh8Gx8lNFrpY14fcSBN5PNp0CZrM/ZdiL5gn457X2K3Sz6euRUcCqewcwkCHW
 WI0w==
X-Gm-Message-State: AOJu0Yxeg5S+xCstOnT7FPdZLRF6k9Q0Jlr3YnPM/gBBFrW3pnzezW2U
 qKnichmFQLK4FCffTnwAsKpPj0RWFDt2CsabVuo=
X-Google-Smtp-Source: AGHT+IFueLOPKrlT5tZ9qiGhlD8jb5dUztrzVdngmnP2DBxEogppubrXqy3goCAFmK/QljcisLrnoA==
X-Received: by 2002:a05:6402:518a:b0:53d:b3c3:57fc with SMTP id
 q10-20020a056402518a00b0053db3c357fcmr12253806edd.3.1698250566777; 
 Wed, 25 Oct 2023 09:16:06 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 co2-20020a0564020c0200b0053ed70ebd7csm9777568edb.31.2023.10.25.09.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 09:16:06 -0700 (PDT)
Date: Wed, 25 Oct 2023 18:16:05 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v4 6/9] target/riscv/tcg: handle profile MISA bits
Message-ID: <20231025-fea5001cf2b2a92b81442b25@orel>
References: <20231025135001.531224-1-dbarboza@ventanamicro.com>
 <20231025135001.531224-7-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025135001.531224-7-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x52d.google.com
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

On Wed, Oct 25, 2023 at 10:49:58AM -0300, Daniel Henrique Barboza wrote:
> The profile support is handling multi-letter extensions only. Let's add
> support for MISA bits as well.
> 
> We'll go through every known MISA bit. If the profile doesn't declare the bit
> as mandatory, ignore it. Otherwise, set or clear the bit in env->misa_ext and
> env->misa_ext_mask depending on whether the profile was set to 'true' or
> 'false'.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
>  target/riscv/tcg/tcg-cpu.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index b2489a5317..57026cfcca 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -804,6 +804,19 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
>      profile->user_set = true;
>      profile->enabled = value;
>  
> +    for (i = 0; misa_bits[i] != 0; i++) {
> +        uint32_t bit = misa_bits[i];
> +
> +        if  (!(profile->misa_ext & bit)) {
> +            continue;
> +        }
> +
> +        g_hash_table_insert(misa_ext_user_opts,
> +                            GUINT_TO_POINTER(bit),
> +                            (gpointer)value);
> +        riscv_cpu_write_misa_bit(cpu, bit, profile->enabled);
> +    }
> +
>      for (i = 0; profile->ext_offsets[i] != RISCV_PROFILE_EXT_LIST_END; i++) {
>          ext_offset = profile->ext_offsets[i];
>  
> -- 
> 2.41.0
> 
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

