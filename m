Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6D972457C
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:15:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6XSl-0000ZP-Ic; Tue, 06 Jun 2023 10:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1q6XSf-0000DF-Ca; Tue, 06 Jun 2023 10:15:01 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1q6XSd-0005vF-N5; Tue, 06 Jun 2023 10:15:01 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6563ccf5151so3557028b3a.0; 
 Tue, 06 Jun 2023 07:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686060897; x=1688652897;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=jscPpoIyBbb5DyFVUeKz1tc6zWKyB11ZCyH+AzHgLOo=;
 b=S6bRFuoms+Heu/rZfGtRfpn6OGvuxiwtTMOY46BB263w1H5TSTBoh5+cq9N0B5Ob97
 sc8mwz+tVSD33skoIL9Dt1QUk5+MdQuy82s6KJGVXoy9JShrVDm1VcPI0YpTquNL4ktY
 SofIpXaz030iBv9t8DnV3xtB8YzfghPoE6BqkzV2sfDAPYQmpCmjrSUjA9wJffUXwul8
 VsrEgkV8bq+ZGPJt4su8kAH9HxQiSLVmjh1mrM6EXoRcTZMFFc/nhS3tyTQokSSUwCwA
 6bBZiok5yfY17fvAmI5nqH7dXyjIDy2n+BtHac3GlLxv+PyJ3kF6F1G2NkGICM4gpD57
 JsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686060897; x=1688652897;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jscPpoIyBbb5DyFVUeKz1tc6zWKyB11ZCyH+AzHgLOo=;
 b=GpDziwYPLgPLMG+nZszxT7XI5jglidJNjhYFUyMFz65Pf5cacPUwEv3412s/bxJ1Mo
 nLFubYJbZkaqfRTpt2TdcnEf+5xphIZFrh/NpHy+qEgXOPsw2wpR4L+B+NOzm+dp+CGm
 FHbDrpRaLdbYYMti2nfzhr/EO0yFhE/+7Jth2zd8xwYxsc6NsTnejoPhqj9gal3DXrGM
 LiLQ8G4mZ9NQ/HIaoENljBVB6KDxrhiYn1j3olNYkT56ArbYOPNuHlR/EAIbLXHctJdb
 RFzoaaqw1rt/Qqp3Csep9c68Me6WG9iuenAM0kyoINxCdG937ZhY+wi7I3IUVUOklBzz
 i9jw==
X-Gm-Message-State: AC+VfDy7KPn5blDAMCLp9fs1EbIk/SpR2/aLJlh6Nn3Y8/d6SNgASp0x
 vGqwRQ5/1M7j3nsaxkjnaew=
X-Google-Smtp-Source: ACHHUZ71Who9b8drqdmiiX0u6uluk7Glf+kamkV8mPUiELswyzewForYAQ4v6MCKyC6ZAjHXtdprag==
X-Received: by 2002:a05:6a00:a29:b0:655:89f1:2db8 with SMTP id
 p41-20020a056a000a2900b0065589f12db8mr2831909pfh.16.1686060897444; 
 Tue, 06 Jun 2023 07:14:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 x9-20020aa793a9000000b0064d32771fafsm7116181pff.97.2023.06.06.07.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 07:14:57 -0700 (PDT)
Date: Tue, 6 Jun 2023 07:14:55 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH 2/2] hw/sd/allwinner-sdhost: Don't send non-boolean IRQ
 line levels
Message-ID: <4a76b9a1-cc54-4832-910a-984d8674dc70@roeck-us.net>
References: <20230606104609.3692557-1-peter.maydell@linaro.org>
 <20230606104609.3692557-3-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606104609.3692557-3-peter.maydell@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
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

On Tue, Jun 06, 2023 at 11:46:09AM +0100, Peter Maydell wrote:
> QEMU allows qemu_irq lines to transfer arbitrary integers.  However
> the convention is that for a simple IRQ line the values transferred
> are always 0 and 1.  The A10 SD controller device instead assumes a
> 0-vs-non-0 convention, which happens to work with the interrupt
> controller it is wired up to.
> 
> Coerce the value to boolean to follow our usual convention.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  hw/sd/allwinner-sdhost.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/sd/allwinner-sdhost.c b/hw/sd/allwinner-sdhost.c
> index 92a0f42708d..62df8f3d396 100644
> --- a/hw/sd/allwinner-sdhost.c
> +++ b/hw/sd/allwinner-sdhost.c
> @@ -191,7 +191,7 @@ static void allwinner_sdhost_update_irq(AwSdHostState *s)
>      }
>  
>      trace_allwinner_sdhost_update_irq(irq);
> -    qemu_set_irq(s->irq, irq);
> +    qemu_set_irq(s->irq, !!irq);
>  }
>  
>  static void allwinner_sdhost_update_transfer_cnt(AwSdHostState *s,
> -- 
> 2.34.1
> 

