Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7BF766EA2
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 15:44:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPNRT-0001l2-TM; Fri, 28 Jul 2023 09:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qPNRQ-0001kh-1D
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 09:23:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qPNRN-0007PQ-Tc
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 09:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690550613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kW5dp9bznKqUPnHyL9s/AnyT/WfstKwZp9MOI+oN+tI=;
 b=BK9EDAygsewfjZ+KYR7XXxne0UQLV4vQDHu++2XjLv6bEm8e5GCufuHNV3GiH+k2Xj38NP
 j9XzF8EwQHl+aH0zXeJMo5IojByYn4L4eYf98krwyhSDoiJ4lqQwWhnDa2PNpTu/RPKw2M
 6IzSELhXguUf7Kk/Tda3uUjB2AFxAq0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-leOrUM1mOOqxzJYkjzdxKw-1; Fri, 28 Jul 2023 09:23:31 -0400
X-MC-Unique: leOrUM1mOOqxzJYkjzdxKw-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b93faa81c9so22597721fa.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 06:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690550610; x=1691155410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kW5dp9bznKqUPnHyL9s/AnyT/WfstKwZp9MOI+oN+tI=;
 b=BoqWDv0xFOGmM9YbIM0AcFJlMsSA/Oec/4PPSSLe1vAMc4Stk0oGpUmqKfw+c7zZ1t
 UfAvq+MCLgcLRTLNR97y29QKu3qmcNYEMP33iDCXE4ZmvbLv8K0Nw+VxdCg+/1wojDNR
 ROty1rxx69KR2hWMZqWf9lszmCknLHCJGdWxSwsoVogNv8PXWQr/OgoRCeJ3f9L+6gxl
 W3htiUv8elX2zXuL9gUWIqlMIm6a2JtyYU4q+V3MAl3cFabygGRQEeviX2aoZpMqnmTX
 ILJiZbYa6LCsmoZmhEmiWlAigQGzkkaDODz6D6yV66KzuqYPlCTKEVptPCcbMq7J+UvC
 HllQ==
X-Gm-Message-State: ABy/qLbK1hPguLJExsFNZdFPKnkQ0I+QVAJWynXtzpjz7NCilb9Z7MsX
 rAWWOZZZuWpJoF5lfp96dZDoWDbj9vLTbHxAlm3UuOclGza+DYjwC0ZcVbbqQ0KrWPvozof3y71
 Et3fFALGPu1I0uxg=
X-Received: by 2002:a2e:2403:0:b0:2b9:a63f:6415 with SMTP id
 k3-20020a2e2403000000b002b9a63f6415mr1783094ljk.5.1690550610082; 
 Fri, 28 Jul 2023 06:23:30 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGpsV4CVeb+zG5jVZ3eex1WrDnoVFqkzassd4SN+FYN52xg7jft2x7MlSt9G1Wnkq2u7yb2rQ==
X-Received: by 2002:a2e:2403:0:b0:2b9:a63f:6415 with SMTP id
 k3-20020a2e2403000000b002b9a63f6415mr1783074ljk.5.1690550609787; 
 Fri, 28 Jul 2023 06:23:29 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 b12-20020a170906038c00b00991faf3810esm2110586eja.146.2023.07.28.06.23.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jul 2023 06:23:29 -0700 (PDT)
Date: Fri, 28 Jul 2023 15:23:28 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: xianglai li <lixianglai@loongson.cn>
Cc: qemu-devel@nongnu.org, Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song
 Gao <gaosong@loongson.cn>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>, David Hildenbrand
 <david@redhat.com>
Subject: Re: [PATCH 6/8] Add support of *unrealize* for loongarch cpu
Message-ID: <20230728152328.37420bee@imammedo.users.ipa.redhat.com>
In-Reply-To: <3c03a7e5c3a3e93adb50b852264a02790221865e.1689837093.git.lixianglai@loongson.cn>
References: <cover.1689837093.git.lixianglai@loongson.cn>
 <3c03a7e5c3a3e93adb50b852264a02790221865e.1689837093.git.lixianglai@loongson.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, 20 Jul 2023 15:15:11 +0800
xianglai li <lixianglai@loongson.cn> wrote:

> 1.Add the Unrealize function to the Loongarch CPU for cpu hot-(un)plug
> 2.Add CPU topology-related properties to the Loongarch CPU for cpu hot-(u=
n)plug
>=20
> Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
> Cc: Song Gao <gaosong@loongson.cn>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Ani Sinha <anisinha@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Eduardo Habkost <eduardo@habkost.net>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@linaro.org>
> Cc: Yanan Wang <wangyanan55@huawei.com>
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: xianglai li <lixianglai@loongson.cn>
> ---
>  target/loongarch/cpu.c | 33 +++++++++++++++++++++++++++++++++
>  target/loongarch/cpu.h |  1 +
>  2 files changed, 34 insertions(+)
>=20
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index ad93ecac92..97c577820f 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -18,6 +18,7 @@
>  #include "cpu-csr.h"
>  #include "sysemu/reset.h"
>  #include "tcg/tcg.h"
> +#include "hw/qdev-properties.h"
> =20
>  const char * const regnames[32] =3D {
>      "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
> @@ -540,6 +541,24 @@ static void loongarch_cpu_realizefn(DeviceState *dev=
, Error **errp)
>      lacc->parent_realize(dev, errp);
>  }
> =20
> +static void loongarch_cpu_unrealizefn(DeviceState *dev)
> +{
> +    LoongArchCPUClass *mcc =3D LOONGARCH_CPU_GET_CLASS(dev);
> +
> +#ifndef CONFIG_USER_ONLY
> +    CPUState *cs =3D CPU(dev);
> +    LoongArchCPU *cpu =3D LOONGARCH_CPU(dev);
> +    CPULoongArchState *env =3D &cpu->env;
> +
> +    cpu_remove_sync(CPU(dev));
> +    cpu_address_space_destroy(cs, 0);
> +    address_space_destroy(&env->address_space_iocsr);
> +    memory_region_del_subregion(&env->system_iocsr, &env->iocsr_mem);
> +#endif
> +
> +    mcc->parent_unrealize(dev);
> +}
> +
>  #ifndef CONFIG_USER_ONLY
>  static void loongarch_qemu_write(void *opaque, hwaddr addr,
>                                   uint64_t val, unsigned size)
> @@ -697,6 +716,15 @@ static gchar *loongarch_gdb_arch_name(CPUState *cs)
>      return g_strdup("loongarch64");
>  }
> =20


> +static Property loongarch_cpu_properties[] =3D {
> +    DEFINE_PROP_INT32("socket-id", LoongArchCPU, socket_id, 0),
> +    DEFINE_PROP_INT32("core-id", LoongArchCPU, core_id, 0),
> +    DEFINE_PROP_INT32("thread-id", LoongArchCPU, thread_id, 0),
> +    DEFINE_PROP_INT32("node-id", LoongArchCPU, node_id, CPU_UNSET_NUMA_N=
ODE_ID),
> +
> +    DEFINE_PROP_END_OF_LIST()
> +};
this should be a part of topo patches

> +
>  static void loongarch_cpu_class_init(ObjectClass *c, void *data)
>  {
>      LoongArchCPUClass *lacc =3D LOONGARCH_CPU_CLASS(c);
> @@ -704,8 +732,12 @@ static void loongarch_cpu_class_init(ObjectClass *c,=
 void *data)
>      DeviceClass *dc =3D DEVICE_CLASS(c);
>      ResettableClass *rc =3D RESETTABLE_CLASS(c);
> =20
> +    device_class_set_props(dc, loongarch_cpu_properties);
>      device_class_set_parent_realize(dc, loongarch_cpu_realizefn,
>                                      &lacc->parent_realize);
> +    device_class_set_parent_unrealize(dc, loongarch_cpu_unrealizefn,
> +                                  &lacc->parent_unrealize);
> +
>      resettable_class_set_parent_phases(rc, NULL, loongarch_cpu_reset_hol=
d, NULL,
>                                         &lacc->parent_phases);
> =20
> @@ -730,6 +762,7 @@ static void loongarch_cpu_class_init(ObjectClass *c, =
void *data)
>  #ifdef CONFIG_TCG
>      cc->tcg_ops =3D &loongarch_tcg_ops;
>  #endif
> +    dc->user_creatable =3D true;
>  }
> =20
>  #define DEFINE_LOONGARCH_CPU_TYPE(model, initfn) \
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index f4439c245f..32feee4fe6 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -397,6 +397,7 @@ struct LoongArchCPUClass {
>      /*< public >*/
> =20
>      DeviceRealize parent_realize;
> +    DeviceUnrealize parent_unrealize;
>      ResettablePhases parent_phases;
>  };
> =20


