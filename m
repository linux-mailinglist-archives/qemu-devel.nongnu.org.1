Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4637753A48
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 13:59:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKHSY-00044k-6L; Fri, 14 Jul 2023 07:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qKHSW-000442-1Z
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 07:59:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qKHSR-0004CK-Qo
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 07:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689335975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pL8kzYo1qhSZ6fIzoUIBM9v4GNhjP0IKX1EVPTyJkbo=;
 b=OOLFnFnBkVXdEVm+HKipUXnmXiwE4JHK/xzHH5Y5DrrLXaTVKFoSYagRhB0hwDRv3KwpIA
 F5kkMPHQrKNOwy+U37XGdRyRAGNWHQAdoUyp9NGUUDWilVCgzI3txPXJPa6HNHuaPukHax
 OkQmrZz5qybMm7h11B/w9KD2Q5+0vvs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-omR6-8x1NC-BPEJBn2ZPuA-1; Fri, 14 Jul 2023 07:59:33 -0400
X-MC-Unique: omR6-8x1NC-BPEJBn2ZPuA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-978a991c3f5so113764266b.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 04:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689335972; x=1691927972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pL8kzYo1qhSZ6fIzoUIBM9v4GNhjP0IKX1EVPTyJkbo=;
 b=dP+RBRCchN7ELqDpEet2M70KCw6s+9Iua2rg2AYv0GT+FBz8h1D8PkqNHNRT1sXwSB
 YhI5J19mc/hsf3sM2rYkl0SsST5Gzv/JT/MOqYN1QiGjH62/BpTBRMHEzn8gHASLg7o2
 xzOPRgskrTKAy5AbZXy0p80HmArtTaUi7wBTRJg+v/pY86PunXIggRSe3i1EJdqKQvLl
 hhrP9TbonPe2vmNRFjNzt2RGRdAoXVWl4MNQRnZdQsXzmJRvdKcEipf15l7ee7J5iGMU
 9QKYOUzCVpxGEL3PA2MuR97p9iH6avT0H0KlrZVvjKojUihek6p1rqnB733Y8rfOoQEi
 CpyQ==
X-Gm-Message-State: ABy/qLbY51kGI+pyv4MS1++zoBD1ZLG0JNDv0gjlNjse4zjGF0ErEuuk
 1kFEGTN7u7II1hT0psK4gUrpq8bX/kvNCjIazYX9or6DXfI+JUE9ZPulG+5gG9RJqSnpfVYnKLu
 gdFc2OK8oQgpCHuU=
X-Received: by 2002:a17:906:73c4:b0:993:f15f:efb7 with SMTP id
 n4-20020a17090673c400b00993f15fefb7mr3994603ejl.8.1689335972109; 
 Fri, 14 Jul 2023 04:59:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEsdwqnLRt8rBo+8nvKewjRnlK/PfSjKI4JXllNkShDgkPtg0ao2UC67fYr1/4O8u+x9dU6NQ==
X-Received: by 2002:a17:906:73c4:b0:993:f15f:efb7 with SMTP id
 n4-20020a17090673c400b00993f15fefb7mr3994591ejl.8.1689335971786; 
 Fri, 14 Jul 2023 04:59:31 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 gr19-20020a170906e2d300b0098e2eaec394sm5390425ejb.101.2023.07.14.04.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jul 2023 04:59:31 -0700 (PDT)
Date: Fri, 14 Jul 2023 13:59:30 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com,
 eduardo@habkost.net, peter.maydell@linaro.org, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, shan.gavin@gmail.com
Subject: Re: [PATCH 2/3] hw/arm/virt: Use generic CPU type invalidation
Message-ID: <20230714135930.428e7d19@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230713054502.410911-3-gshan@redhat.com>
References: <20230713054502.410911-1-gshan@redhat.com>
 <20230713054502.410911-3-gshan@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, 13 Jul 2023 15:45:01 +1000
Gavin Shan <gshan@redhat.com> wrote:

> There is a generic CPU type invalidation in machine_run_board_init()
                              ^^^^^
using that throughout the series is confusing to me.
Perhaps use original phrase 'valid cpu types' with appropriate rephrasing
would be better 

> and we needn't a same and private invalidation. Set mc->valid_cpu_types
> to use the generic CPU type invalidation.

I's suggest to replace commit message/subj with something like

arm/virt specific cpu_type_valid() is duplicate of ...
drop it and use ...

> No functional change intended.



> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  hw/arm/virt.c | 21 +++------------------
>  1 file changed, 3 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 7d9dbc2663..43d7772ffd 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -203,7 +203,7 @@ static const int a15irqmap[] = {
>      [VIRT_PLATFORM_BUS] = 112, /* ...to 112 + PLATFORM_BUS_NUM_IRQS -1 */
>  };
>  
> -static const char *valid_cpus[] = {
> +static const char *valid_cpu_types[] = {
>  #ifdef CONFIG_TCG
>      ARM_CPU_TYPE_NAME("cortex-a7"),
>      ARM_CPU_TYPE_NAME("cortex-a15"),
> @@ -219,20 +219,9 @@ static const char *valid_cpus[] = {
>      ARM_CPU_TYPE_NAME("cortex-a57"),
>      ARM_CPU_TYPE_NAME("host"),
>      ARM_CPU_TYPE_NAME("max"),
> +    NULL
>  };
>  
> -static bool cpu_type_valid(const char *cpu)
> -{
> -    int i;
> -
> -    for (i = 0; i < ARRAY_SIZE(valid_cpus); i++) {
> -        if (strcmp(cpu, valid_cpus[i]) == 0) {
> -            return true;
> -        }
> -    }
> -    return false;
> -}
> -
>  static void create_randomness(MachineState *ms, const char *node)
>  {
>      struct {
> @@ -2030,11 +2019,6 @@ static void machvirt_init(MachineState *machine)
>      unsigned int smp_cpus = machine->smp.cpus;
>      unsigned int max_cpus = machine->smp.max_cpus;
>  
> -    if (!cpu_type_valid(machine->cpu_type)) {
> -        error_report("mach-virt: CPU type %s not supported", machine->cpu_type);
> -        exit(1);
> -    }
> -
>      possible_cpus = mc->possible_cpu_arch_ids(machine);
>  
>      /*
> @@ -2953,6 +2937,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>  #else
>      mc->default_cpu_type = ARM_CPU_TYPE_NAME("max");
>  #endif
> +    mc->valid_cpu_types = valid_cpu_types;
>      mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
>      mc->kvm_type = virt_kvm_type;
>      assert(!mc->get_hotplug_handler);


