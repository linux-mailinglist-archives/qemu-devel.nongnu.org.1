Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13593766D42
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 14:31:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPMLf-0007hm-H0; Fri, 28 Jul 2023 08:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qPMLb-0007fq-BP
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 08:13:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qPMLZ-0000Aa-5e
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 08:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690546408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=meggP9f0neIJgwwkop/7YpE/dGLynawA8kW3kZY/Sgc=;
 b=eMwplFmFoc+FqpW0LIjVYiodW7uW37yYwrahUEIUwSJpJ7zQ5F0H4OhgwhPPEeSuy22V76
 tLmE3yjnfwNrlFtfzsc4QAsjHQw9MQ7wOSk7DdnVRca0t3tgNmdjiCEjbMRVHP7WM2GV6n
 DaQ3InBs2FazeZcwloR2fvifVHCtHcA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-x1fLAJ8bN0ahjCUKkJZcuQ-1; Fri, 28 Jul 2023 08:13:27 -0400
X-MC-Unique: x1fLAJ8bN0ahjCUKkJZcuQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-993c24f3246so277808766b.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 05:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690546406; x=1691151206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=meggP9f0neIJgwwkop/7YpE/dGLynawA8kW3kZY/Sgc=;
 b=ZrQRnPgaaG/WZci5/2VaJ569Aa7CXVEBBqMsA7jWaxymYTIFsAOkJXAVRgh5VKrv4M
 vtQRx+yY8dM2RwemgG1+6tiO8OUyMVzl+odiQZw1iFi38U/XQnNUrbFN0GZLIGFSRrRb
 vrV+lh4xGz2Muaa1my/DnnSf+KptdJ0DuJT/gA23Z+L8Rg4tNMilS+BUdoU3RmDArVfe
 dL0GaeuXuwyoNVr1xIR9fKN6+tXY0rSHW5/G9Xqtm/bwj8umxUyFJVCGAFx/AHDQACg9
 7g7zMZypqG8eluMwi8BKDQfouPFZ8VPY73xUiaOomYAicObGyJn5e3BUO7qfF2AHJ9Yu
 Xk1g==
X-Gm-Message-State: ABy/qLam4m+QsIIQ5Wqgp8xB5E7ruPEqcYs1FgG8lMYVPWWyQYXgOzyy
 LaW+Tw7KaR7e1Hc7wTdMrJb7pkl0hnpUY+YeSFptGY1ehnzjIvXmYRPrYRhhRl65wFmhhWvOFvR
 +7Ip0GjkKi/+/8lE=
X-Received: by 2002:a17:907:720a:b0:99b:d244:2ac3 with SMTP id
 dr10-20020a170907720a00b0099bd2442ac3mr5483438ejc.9.1690546405928; 
 Fri, 28 Jul 2023 05:13:25 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHZ+kmlaUIPcIKpUov0vekKK2A3w2GNCqsBKljiwxQnVGRZWbEDGSOunAylve56fSM6vSD5+g==
X-Received: by 2002:a17:907:720a:b0:99b:d244:2ac3 with SMTP id
 dr10-20020a170907720a00b0099bd2442ac3mr5483421ejc.9.1690546405657; 
 Fri, 28 Jul 2023 05:13:25 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 z7-20020a170906074700b0099293cdbc98sm1999382ejb.145.2023.07.28.05.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jul 2023 05:13:25 -0700 (PDT)
Date: Fri, 28 Jul 2023 14:13:24 +0200
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
Subject: Re: [PATCH 4/8] Introduce the CPU address space destruction function
Message-ID: <20230728141324.5cbe61fb@imammedo.users.ipa.redhat.com>
In-Reply-To: <cf141dbe0b7d2d0837c02e452889f5669c78444d.1689837093.git.lixianglai@loongson.cn>
References: <cover.1689837093.git.lixianglai@loongson.cn>
 <cf141dbe0b7d2d0837c02e452889f5669c78444d.1689837093.git.lixianglai@loongson.cn>
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

On Thu, 20 Jul 2023 15:15:09 +0800
xianglai li <lixianglai@loongson.cn> wrote:

> Introduce new functions to destroy CPU address space resources

s/functions/function/

> for cpu hot-(un)plug.
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
>  include/exec/cpu-common.h |  8 ++++++++
>  include/hw/core/cpu.h     |  1 +
>  softmmu/physmem.c         | 24 ++++++++++++++++++++++++
>  3 files changed, 33 insertions(+)
>=20
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 87dc9a752c..27cd4d32b1 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -120,6 +120,14 @@ size_t qemu_ram_pagesize_largest(void);
>   */
>  void cpu_address_space_init(CPUState *cpu, int asidx,
>                              const char *prefix, MemoryRegion *mr);
> +/**
> + * cpu_address_space_destroy:
> + * @cpu: CPU for which address space needs to be destroyed
> + * @asidx: integer index of this address space
> + *
> + * Note that with KVM only one address space is supported.
> + */
> +void cpu_address_space_destroy(CPUState *cpu, int asidx);
> =20
>  void cpu_physical_memory_rw(hwaddr addr, void *buf,
>                              hwaddr len, bool is_write);
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index fdcbe87352..d6d68dac12 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -366,6 +366,7 @@ struct CPUState {
>      QSIMPLEQ_HEAD(, qemu_work_item) work_list;
> =20
>      CPUAddressSpace *cpu_ases;
> +    int cpu_ases_ref_count;

perhaps renaming it to num_ases would be better

>      int num_ases;
and this one can be named num__ases_[total|max]


>      AddressSpace *as;
>      MemoryRegion *memory;
> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> index 3df73542e1..f4545b4508 100644
> --- a/softmmu/physmem.c
> +++ b/softmmu/physmem.c
> @@ -762,6 +762,7 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
> =20
>      if (!cpu->cpu_ases) {
>          cpu->cpu_ases =3D g_new0(CPUAddressSpace, cpu->num_ases);
> +        cpu->cpu_ases_ref_count =3D cpu->num_ases;
>      }
> =20
>      newas =3D &cpu->cpu_ases[asidx];
> @@ -775,6 +776,29 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
>      }
>  }
> =20
> +void cpu_address_space_destroy(CPUState *cpu, int asidx)
                                                 ^^^ should it be uintX_t ?

> +{
> +    CPUAddressSpace *cpuas;
> +
> +    assert(asidx < cpu->num_ases);
> +    assert(asidx =3D=3D 0 || !kvm_enabled());
> +    assert(cpu->cpu_ases);
> +
> +    cpuas =3D &cpu->cpu_ases[asidx];
> +    if (tcg_enabled()) {
> +        memory_listener_unregister(&cpuas->tcg_as_listener);
> +    }
> +
> +    address_space_destroy(cpuas->as);
> +
> +    cpu->cpu_ases_ref_count--;
> +    if (cpu->cpu_ases_ref_count =3D=3D 0) {
> +        g_free(cpu->cpu_ases);
> +        cpu->cpu_ases =3D NULL;
> +    }
> +
> +}
> +
>  AddressSpace *cpu_get_address_space(CPUState *cpu, int asidx)
>  {
>      /* Return the AddressSpace corresponding to the specified index */


