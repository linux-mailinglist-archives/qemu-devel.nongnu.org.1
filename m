Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B558E740AF3
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 10:15:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEQK1-0001iY-Ob; Wed, 28 Jun 2023 04:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qEQJz-0001hQ-1S
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 04:14:39 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qEQJx-0002Xd-B5
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 04:14:38 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-991fe70f21bso252100666b.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 01:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687940075; x=1690532075;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cFkITCm7Ej6n3DjkfdwkD4Elkhz2kqSHz2YVvLg1u08=;
 b=RTCvYi/1PQugB30B06+ygqrdftaCE1v2/txMRMz17itSwI1uTcU62xa3qDmngRUbNv
 m2vKCnB2AuM4LRSHUZI1mYTXrAL5HSBxWfchEyyvoPcLjLdEscvCFV1DAY74REWXw4Ps
 EjH2wIR3F0Gj6k+3Wn676l597vohi/u+s0KBWRWaudwz7cuRYWcldAIcQVtZ7x4d1qgc
 x9o/RBugw/6Fwc/rsxDFOtT9SmbQSlYeVjEeYpj3Tpn/A+QamAjjETXH+j1rf1sL25e0
 /RHe6PLgGhDAMRcVXZXzIvagciUyjw8xcdCdttDrB7mY8/jaGW38VKhlrT8F+b5STQ4F
 f6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687940075; x=1690532075;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cFkITCm7Ej6n3DjkfdwkD4Elkhz2kqSHz2YVvLg1u08=;
 b=hHMEajgDOBSc8VpW5ZNqaCna+9qHPF3Hq2LmhHRadizEh6z52oI5ksFRRIl7D7BcdU
 P4Zg/gNGtnKN86C5MrhMb7dEFMx0sB4wLU71sfCT4MBkLj7vReQQmH6MIDgDkj0LwSer
 dLqKNtXbiIutD/PYgfXdOez2uy5Pdm+Owl1sVW4GBzHx/r6Tj9Z1v/Uvor3s90RMju+0
 wLE8UHcjoo0fy0gisG/F+GA4dJOqIxNL5h4HpNv4D9xTLJoFOIat7RQ2FwxBSKOws6q1
 S9F7o1y1Kn9PGZFY3/mhJkiF+WIcgGn4XLWv/W8cM8IascT5q5HRGmS5QH43A8GS3Ga1
 DKqw==
X-Gm-Message-State: AC+VfDxPpWNsDLaEAt0tOvQYjSQAwbmrTMs4//T3lNDD3ErhvU9+gU/C
 gGo2MO5ZXezWHl8Ne8r7PauaFg==
X-Google-Smtp-Source: ACHHUZ67bFSbmMlXFuxlfzAxQaVtZCIn6e+AI3cERCDJgGm7a1WEEoRA0cmqI1t56uRQXeiM4JPMeQ==
X-Received: by 2002:a17:906:da8a:b0:97d:2bcc:47d5 with SMTP id
 xh10-20020a170906da8a00b0097d2bcc47d5mr29715601ejb.49.1687940075311; 
 Wed, 28 Jun 2023 01:14:35 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 l16-20020a1709065a9000b0098884f86e41sm5379644ejq.123.2023.06.28.01.14.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 01:14:34 -0700 (PDT)
Date: Wed, 28 Jun 2023 10:14:33 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v5 16/19] target/riscv/cpu.c: create KVM mock properties
Message-ID: <20230628-3c9c1c6716a2b5752db75315@orel>
References: <20230627163203.49422-1-dbarboza@ventanamicro.com>
 <20230627163203.49422-17-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627163203.49422-17-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x62e.google.com
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

On Tue, Jun 27, 2023 at 01:32:00PM -0300, Daniel Henrique Barboza wrote:
> KVM-specific properties are being created inside target/riscv/kvm.c. But
> at this moment we're gathering all the remaining properties from TCG and
> adding them as is when running KVM. This creates a situation where
> non-KVM properties are setting flags to 'true' due to its default
> settings (e.g.  Zawrs). Users can also freely enable them via command
> line.
> 
> This doesn't impact runtime per se because KVM doesn't care about these
> flags, but code such as riscv_isa_string_ext() take those flags into
> account. The result is that, for a KVM guest, setting non-KVM properties
> will make them appear in the riscv,isa DT.
> 
> We want to keep the same API for both TCG and KVM and at the same time,
> when running KVM, forbid non-KVM extensions to be enabled internally. We
> accomplish both by changing riscv_cpu_add_user_properties() to add a
> mock boolean property for every non-KVM extension in
> riscv_cpu_extensions[]. Then, when running KVM, users are still free to
> set extensions at will, but we'll error out if a non-KVM extension is
> enabled. Setting such extension to 'false' will be ignored.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c | 42 +++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index b65db165cc..22851b0e93 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1720,6 +1720,24 @@ static Property riscv_cpu_extensions[] = {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> +
> +static void cpu_set_cfg_unavailable(Object *obj, Visitor *v,
> +                                    const char *name,
> +                                    void *opaque, Error **errp)
> +{
> +    const char *propname = opaque;
> +    bool value;
> +
> +    if (!visit_type_bool(v, name, &value, errp)) {
> +        return;
> +    }
> +
> +    if (value) {
> +        error_setg(errp, "extension %s is not available with KVM",
> +                   propname);
> +    }
> +}
> +
>  /*
>   * Add CPU properties with user-facing flags.
>   *
> @@ -1738,9 +1756,27 @@ static void riscv_cpu_add_user_properties(Object *obj)
>      riscv_cpu_add_misa_properties(obj);
>  
>      for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
> -        /* Check if KVM didn't create the property already */
> -        if (object_property_find(obj, prop->name)) {
> -            continue;
> +        if (riscv_running_kvm()) {
> +            /* Check if KVM created the property already */

The comment change should have been fixed on patch 12 where it was
introduced.

> +            if (object_property_find(obj, prop->name)) {
> +                continue;
> +            }
> +
> +            /*
> +             * Set the default to disabled for every extension
> +             * unknown to KVM and error out if the user attempts
> +             * to enable any of them.
> +             *
> +             * We're giving a pass for non-bool properties since they're
> +             * not related to the availability of extensions and can be
> +             * safely ignored as is.
> +             */
> +            if (prop->info == &qdev_prop_bool) {
> +                object_property_add(obj, prop->name, "bool",
> +                                    NULL, cpu_set_cfg_unavailable,
> +                                    NULL, (void *)prop->name);
> +                continue;
> +            }
>          }
>  
>          qdev_property_add_static(dev, prop);
> -- 
> 2.41.0
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew

