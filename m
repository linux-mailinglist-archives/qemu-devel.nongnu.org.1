Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E837BFB96
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 14:35:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqBww-0007q6-Qj; Tue, 10 Oct 2023 08:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qqBwr-0007pM-W9
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 08:34:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qqBwq-0000AA-3y
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 08:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696941290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TsgHDkiJB376Z7csyt0aSwsZz98d4fhvAIrWIkefqJs=;
 b=jVEsTn0Tae57GanwhJGT+3LTgFkWh9s6HKQVee6BZbLpj568jRT23HBE+pOP3KKI/DVk1n
 XKDoS3hZ7Xlt/uMtBNDA3Vd9KWM7MtBRm/+Pfx4govNVymgdbZ/C4lHFFvrXxZVq4U9EF1
 1nSAc6KJsW59zkHH8NvVqkBdi1uFuOo=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-Eaodw4cRNyuV-RR9D6I7kw-1; Tue, 10 Oct 2023 08:34:47 -0400
X-MC-Unique: Eaodw4cRNyuV-RR9D6I7kw-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-690bfae9b7eso4333013b3a.0
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 05:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696941285; x=1697546085;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TsgHDkiJB376Z7csyt0aSwsZz98d4fhvAIrWIkefqJs=;
 b=Qi/WfJx+WH4bK98m9hiJKwXQaEXZyOC9CTYYIb7lsJW6P4PyUmS7PuU3DjLYzZB8g6
 QcGQswpYUi5Ti4LUK7s5kdgUUlslbx3dSmoPCkk9vTyNvcxuW7TKS/yOeraGgoyjdwaJ
 xlwd81LGAVqbU0r83ZBOp0q13hv+KkAyASs95kIIc/okf0Tg6YRcrdJWCnePR7sEjycz
 FayJsi9+p1Jevb/JxGcH6dJd7q+6wYfOw7oXrw25iy+WKjiIVl/yGYpod0pic8zb3F/Z
 qSs6Xp0gx0TulyJXSQaeMy0AiVcyHna7vDgobMfVPnfm0UVtd1vmSU3tTDFKagBDAaRr
 SICQ==
X-Gm-Message-State: AOJu0Ywjy/hJTLC4yxWf69fmTTHgccRLHf01nFwmXXy0569tB3zO3yEv
 Clpd+6ydZYn+QoWlg1W+zP1sxo8SeH2fUh1I7zUBcKk0JfZ4XO//JI2TPYYB43uDOIfxJWIPa1K
 fbNlp5COp/m7M8CU=
X-Received: by 2002:a05:6a00:2e8f:b0:690:d4f5:c664 with SMTP id
 fd15-20020a056a002e8f00b00690d4f5c664mr19631990pfb.11.1696941285632; 
 Tue, 10 Oct 2023 05:34:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKE5XHF1Uove89Uuj1hf6wplmfnMet+LnPRJkqRzQ1OxDw2VjToADq14wwE4A2KBsVn82rxw==
X-Received: by 2002:a05:6a00:2e8f:b0:690:d4f5:c664 with SMTP id
 fd15-20020a056a002e8f00b00690d4f5c664mr19631967pfb.11.1696941285254; 
 Tue, 10 Oct 2023 05:34:45 -0700 (PDT)
Received: from smtpclient.apple ([115.96.109.49])
 by smtp.gmail.com with ESMTPSA id
 v5-20020aa78505000000b00696ca62d5f5sm8149878pfn.8.2023.10.10.05.34.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 10 Oct 2023 05:34:44 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH v2 1/6] hw/core/cpu: Clean up global variable shadowing
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20231010115048.11856-2-philmd@linaro.org>
Date: Tue, 10 Oct 2023 18:04:38 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3540D50E-E94F-472D-9179-A1D9034EFB65@redhat.com>
References: <20231010115048.11856-1-philmd@linaro.org>
 <20231010115048.11856-2-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 10-Oct-2023, at 5:20 PM, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> Fix:
>=20
>  hw/core/machine.c:1302:22: error: declaration shadows a variable in =
the global scope [-Werror,-Wshadow]
>      const CPUArchId *cpus =3D possible_cpus->cpus;
>                       ^
>  hw/core/numa.c:69:17: error: declaration shadows a variable in the =
global scope [-Werror,-Wshadow]
>      uint16List *cpus =3D NULL;
>                  ^
>  hw/acpi/aml-build.c:2005:20: error: declaration shadows a variable in =
the global scope [-Werror,-Wshadow]
>      CPUArchIdList *cpus =3D ms->possible_cpus;
>                     ^
>  hw/core/machine-smp.c:77:14: error: declaration shadows a variable in =
the global scope [-Werror,-Wshadow]
>      unsigned cpus    =3D config->has_cpus ? config->cpus : 0;
>               ^
>  include/hw/core/cpu.h:589:17: note: previous declaration is here
>  extern CPUTailQ cpus;
>                  ^
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> include/hw/core/cpu.h     | 8 ++++----
> cpu-common.c              | 6 +++---
> target/s390x/cpu_models.c | 2 +-
> 3 files changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index e02bc5980f..d0dc0a1698 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -586,13 +586,13 @@ static inline CPUArchState *cpu_env(CPUState =
*cpu)
> }
>=20
> typedef QTAILQ_HEAD(CPUTailQ, CPUState) CPUTailQ;
> -extern CPUTailQ cpus;
> +extern CPUTailQ cpus_queue;
>=20
> -#define first_cpu        QTAILQ_FIRST_RCU(&cpus)
> +#define first_cpu        QTAILQ_FIRST_RCU(&cpus_queue)
> #define CPU_NEXT(cpu)    QTAILQ_NEXT_RCU(cpu, node)
> -#define CPU_FOREACH(cpu) QTAILQ_FOREACH_RCU(cpu, &cpus, node)
> +#define CPU_FOREACH(cpu) QTAILQ_FOREACH_RCU(cpu, &cpus_queue, node)
> #define CPU_FOREACH_SAFE(cpu, next_cpu) \
> -    QTAILQ_FOREACH_SAFE_RCU(cpu, &cpus, node, next_cpu)
> +    QTAILQ_FOREACH_SAFE_RCU(cpu, &cpus_queue, node, next_cpu)
>=20
> extern __thread CPUState *current_cpu;
>=20
> diff --git a/cpu-common.c b/cpu-common.c
> index 45c745ecf6..c81fd72d16 100644
> --- a/cpu-common.c
> +++ b/cpu-common.c
> @@ -73,7 +73,7 @@ static int cpu_get_free_index(void)
>     return max_cpu_index;
> }
>=20
> -CPUTailQ cpus =3D QTAILQ_HEAD_INITIALIZER(cpus);
> +CPUTailQ cpus_queue =3D QTAILQ_HEAD_INITIALIZER(cpus_queue);
> static unsigned int cpu_list_generation_id;
>=20
> unsigned int cpu_list_generation_id_get(void)
> @@ -90,7 +90,7 @@ void cpu_list_add(CPUState *cpu)
>     } else {
>         assert(!cpu_index_auto_assigned);
>     }
> -    QTAILQ_INSERT_TAIL_RCU(&cpus, cpu, node);
> +    QTAILQ_INSERT_TAIL_RCU(&cpus_queue, cpu, node);
>     cpu_list_generation_id++;
> }
>=20
> @@ -102,7 +102,7 @@ void cpu_list_remove(CPUState *cpu)
>         return;
>     }
>=20
> -    QTAILQ_REMOVE_RCU(&cpus, cpu, node);
> +    QTAILQ_REMOVE_RCU(&cpus_queue, cpu, node);
>     cpu->cpu_index =3D UNASSIGNED_CPU_INDEX;
>     cpu_list_generation_id++;
> }
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 98f14c09c2..b1e77b3a2b 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -756,7 +756,7 @@ void s390_set_qemu_cpu_model(uint16_t type, =
uint8_t gen, uint8_t ec_ga,
>     const S390CPUDef *def =3D s390_find_cpu_def(type, gen, ec_ga, =
NULL);
>=20
>     g_assert(def);
> -    g_assert(QTAILQ_EMPTY_RCU(&cpus));
> +    g_assert(QTAILQ_EMPTY_RCU(&cpus_queue));
>=20
>     /* build the CPU model */
>     s390_qemu_cpu_model.def =3D def;
> --=20
> 2.41.0
>=20


