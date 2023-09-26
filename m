Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F747AED29
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 14:47:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql7Sw-0000fO-5B; Tue, 26 Sep 2023 08:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1ql7Sc-0000UB-83
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 08:46:45 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1ql7Sa-0001RR-3e
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 08:46:41 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6bf2427b947so4272073a34.3
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 05:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695732398; x=1696337198; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nucyqG//c/4g3UAbtFrJhwSkBb6dvu+7faetdU+AY00=;
 b=DkjtGdjnUNBMDv2c51ygnDNWrp8oP92Bm39iOGbyfmd+dzNp5GHk36pTCcVY9MBx5X
 Rbf/12oPMEWEwA1X86Gh4qVINbJqKLNsi3w06zMzj2jXe2OxyXf0enmKO2lmbbxgV5Ul
 PWap54uaM8ELaMhJAsCn0cshtA40r3JHbNM2l+xvwfBY+Qz9V48k0teMGeC/XppZZoqv
 10uWecIHGDJfpgJeE7fO7Fp9FMs1gf1ebuM+CP56LtCngquVAHErDFJ5WAV91+czGXxU
 b4TE20JZ4KYXNHbdHxDd+w2h7jfKlNlwxauSOFODtT991buXkit3iqaG2z1KPnqh/+3w
 Ecow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695732398; x=1696337198;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nucyqG//c/4g3UAbtFrJhwSkBb6dvu+7faetdU+AY00=;
 b=aRChaZn1D27ZZVGEcGgkc+ecT9z5I609hkrrb+gog3g08Cpn8G+EMBO7hlnZBW3r3O
 11sixurhddLN2fQiVntUufamH2ahljyukpcmrJgQVtQqkmn6Hk1M5Nj6xZ4qLd2rxIg5
 iYhCiFe1xKJ/+iwEk0GONinfKub0FTGsPFTQuflK3I5zR7uE2XBlw3lJUUWwxz2cHWb9
 c5TSgT3VbElkXAxejpLBOYKPq4PH7Makd/pjFiTJPH4wp/YCNK/HsOhnKnpiEChRvXPB
 p7qdQCKNuBLmUx/C1fUbHbbFBYg7PKe5kjbnk7vUSaR8/citxfIxcAbB4zTNh/ngI4pb
 gg2Q==
X-Gm-Message-State: AOJu0YyUlaISSrBTSAGW4GFvfKZ5jrPclKxDXcyS8Yn65H5hi+rkqkMI
 wYnsJCs/zo4kmpMil6h36QZkfQUh4g==
X-Google-Smtp-Source: AGHT+IGOBmIn/amB8IrPI+Cde1g0LIqyOl9NdLJL/2oAVzGl5tewyEwb59XP8wddRNKg82G10iLuBw==
X-Received: by 2002:a9d:6b95:0:b0:6be:fd51:cb6d with SMTP id
 b21-20020a9d6b95000000b006befd51cb6dmr8924240otq.31.1695732398455; 
 Tue, 26 Sep 2023 05:46:38 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id
 i11-20020a4aab0b000000b00578a0824ff6sm2218930oon.20.2023.09.26.05.46.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 05:46:38 -0700 (PDT)
Received: from mail.minyard.net (unknown
 [IPv6:2607:fb90:d993:57c1:fc20:85b8:467e:f3f4])
 by serve.minyard.net (Postfix) with ESMTPSA id E1C9E1800BF;
 Tue, 26 Sep 2023 12:46:36 +0000 (UTC)
Date: Tue, 26 Sep 2023 07:46:34 -0500
From: Corey Minyard <minyard@acm.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Subject: Re: [PATCH] pm_smbus: rename variable to avoid shadowing
Message-ID: <ZRLSqhgqlGVAk2/C@mail.minyard.net>
References: <20230925144744.527958-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925144744.527958-2-pbonzini@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=tcminyard@gmail.com; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: minyard@acm.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Sep 25, 2023 at 04:47:39PM +0200, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/i2c/pm_smbus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This looks ok to me.

Acked-by: Corey Minyard <cminyard@mvista.com>

> 
> diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
> index 9ad6a47739b..4e1b8a5182d 100644
> --- a/hw/i2c/pm_smbus.c
> +++ b/hw/i2c/pm_smbus.c
> @@ -279,7 +279,7 @@ static void smb_ioport_writeb(void *opaque, hwaddr addr, uint64_t val,
>              if (!read && s->smb_index == s->smb_data0) {
>                  uint8_t prot = (s->smb_ctl >> 2) & 0x07;
>                  uint8_t cmd = s->smb_cmd;
> -                uint8_t addr = s->smb_addr >> 1;
> +                uint8_t smb_addr = s->smb_addr >> 1;
>                  int ret;
>  
>                  if (prot == PROT_I2C_BLOCK_READ) {
> @@ -287,7 +287,7 @@ static void smb_ioport_writeb(void *opaque, hwaddr addr, uint64_t val,
>                      goto out;
>                  }
>  
> -                ret = smbus_write_block(s->smbus, addr, cmd, s->smb_data,
> +                ret = smbus_write_block(s->smbus, smb_addr, cmd, s->smb_data,
>                                          s->smb_data0, !s->i2c_enable);
>                  if (ret < 0) {
>                      s->smb_stat |= STS_DEV_ERR;
> -- 
> 2.41.0
> 
> 

