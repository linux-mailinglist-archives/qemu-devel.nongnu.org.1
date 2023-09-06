Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A05F793790
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 10:58:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdoLZ-00067p-EQ; Wed, 06 Sep 2023 04:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdoLX-00066t-9t
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 04:57:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdoLU-0001dp-Ry
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 04:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693990623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EQ6MIRb/s2ERMlIsQZwknp7IKwe6jjm1pamkiZMpSAc=;
 b=BZGlQBQTv0yHWs0E3a1XOUEscAWZYBK2V1KWjK4GCSAMoEtHxQmBKbNIH6KQbtK0Mu61Q5
 lrdYGtLZjx+7jxp9BtlScYC2WEPEcm0+ZEkRt+aYW1hJkX9GI5kGUlZ+ZWY8Fn11Jr1cXX
 PbZjkRlnbXG1+KgEI1rf7hOyVKTVr3U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-lRG8ErZsNUWnJ_ZKdn8Y1w-1; Wed, 06 Sep 2023 04:57:02 -0400
X-MC-Unique: lRG8ErZsNUWnJ_ZKdn8Y1w-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f41a04a297so25638305e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 01:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693990621; x=1694595421;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EQ6MIRb/s2ERMlIsQZwknp7IKwe6jjm1pamkiZMpSAc=;
 b=Vgr1PHy0Jm+4Akst0n1VeCMqpeWzaLcF3aBIBb0tbp3g6z5nD5D9Db1muV09fKxpDg
 44AJqxw4WyUBtKdtJoD8Ki4SSXtuQoM+4DZ4K4ZcokMwsTgQ+3E8+cJTcQdVo7uxRx2H
 HJfzi3feU6dK8KOsTuqG0NH6vMO2sjEkVGIrGmRoEKHNZeA5thX0b7HJhAqyz2Q7NP+W
 vqEpbmfhZpSlC46FwR817z72A3le5Ot8bcSXb65g82Vhf1f3tE+wmqgMLCU9sjAAgycX
 fSEe408crtFGcdPpX6cTMlDjn5OiFUNeq99CLD1sjbJ9Z6uM2oqXaZP2p6miPv5hKLi6
 mmBw==
X-Gm-Message-State: AOJu0YxdrbvmsV7dqrB53usMvpt30oQBIEfmnGebslijlq7EWgngDAjG
 w+zORqdlMi6akVJVxXxd5e3sIv35W0ETwZjcnN/eJ9n2s4aAQaXPSnuiUW2rsJ1tJUW17keI4zw
 hOIPGqLYNsQS1YXU=
X-Received: by 2002:a05:600c:2409:b0:402:ba85:3e3a with SMTP id
 9-20020a05600c240900b00402ba853e3amr1773992wmp.19.1693990621567; 
 Wed, 06 Sep 2023 01:57:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnvHW+zcQsQ7wq+Wyr+gFDSooYwYiTnY7gDJrbkq1dQds7AXyV+YFoROBB/pcgltIAaIWXVw==
X-Received: by 2002:a05:600c:2409:b0:402:ba85:3e3a with SMTP id
 9-20020a05600c240900b00402ba853e3amr1773965wmp.19.1693990621212; 
 Wed, 06 Sep 2023 01:57:01 -0700 (PDT)
Received: from [10.33.192.187] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 f7-20020adffcc7000000b0031c7682607asm19790711wrs.111.2023.09.06.01.56.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 01:57:00 -0700 (PDT)
Message-ID: <d31ab49b-3baa-22dc-e6e7-892385c9bb97@redhat.com>
Date: Wed, 6 Sep 2023 10:56:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v22 08/20] qapi/s390x/cpu topology: set-cpu-topology qmp
 command
Content-Language: en-US
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
References: <20230901155812.2696560-1-nsg@linux.ibm.com>
 <20230901155812.2696560-9-nsg@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230901155812.2696560-9-nsg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 01/09/2023 17.58, Nina Schoetterl-Glausch wrote:
> From: Pierre Morel <pmorel@linux.ibm.com>
> 
> The modification of the CPU attributes are done through a monitor
> command.
> 
> It allows to move the core inside the topology tree to optimize
> the cache usage in the case the host's hypervisor previously
> moved the CPU.
> 
> The same command allows to modify the CPU attributes modifiers
> like polarization entitlement and the dedicated attribute to notify
> the guest if the host admin modified scheduling or dedication of a vCPU.
> 
> With this knowledge the guest has the possibility to optimize the
> usage of the vCPUs.
> 
> The command has a feature unstable for the moment.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
...
> diff --git a/hw/s390x/cpu-topology.c b/hw/s390x/cpu-topology.c
> index 52bfbe12a9..c828538f2a 100644
> --- a/hw/s390x/cpu-topology.c
> +++ b/hw/s390x/cpu-topology.c
> @@ -23,6 +23,7 @@
>   #include "target/s390x/cpu.h"
>   #include "hw/s390x/s390-virtio-ccw.h"
>   #include "hw/s390x/cpu-topology.h"
> +#include "qapi/qapi-commands-machine-target.h"
>   
>   /*
>    * s390_topology is used to keep the topology information.
> @@ -259,6 +260,29 @@ static bool s390_topology_check(uint16_t socket_id, uint16_t book_id,
>       return true;
>   }
>   
> +/**
> + * s390_topology_need_report
> + * @cpu: Current cpu
> + * @drawer_id: future drawer ID
> + * @book_id: future book ID
> + * @socket_id: future socket ID
> + * @entitlement: future entitlement
> + * @dedicated: future dedicated
> + *
> + * A modified topology change report is needed if the topology
> + * tree or the topology attributes change.
> + */
> +static bool s390_topology_need_report(S390CPU *cpu, int drawer_id,
> +                                   int book_id, int socket_id,
> +                                   uint16_t entitlement, bool dedicated)

Nit: Indentation should match the "(" ?

> +{
> +    return cpu->env.drawer_id != drawer_id ||
> +           cpu->env.book_id != book_id ||
> +           cpu->env.socket_id != socket_id ||
> +           cpu->env.entitlement != entitlement ||
> +           cpu->env.dedicated != dedicated;
> +}
> +
>   /**
>    * s390_update_cpu_props:
>    * @ms: the machine state
> @@ -328,3 +352,114 @@ void s390_topology_setup_cpu(MachineState *ms, S390CPU *cpu, Error **errp)
>       /* topology tree is reflected in props */
>       s390_update_cpu_props(ms, cpu);
>   }
> +
> +static void s390_change_topology(uint16_t core_id,
> +                                 bool has_socket_id, uint16_t socket_id,
> +                                 bool has_book_id, uint16_t book_id,
> +                                 bool has_drawer_id, uint16_t drawer_id,
> +                                 bool has_entitlement,
> +                                 CpuS390Entitlement entitlement,
> +                                 bool has_dedicated, bool dedicated,
> +                                 Error **errp)
> +{
> +    MachineState *ms = current_machine;
> +    int old_socket_entry;
> +    int new_socket_entry;
> +    bool report_needed;
> +    S390CPU *cpu;
> +    ERRP_GUARD();
> +
> +    cpu = s390_cpu_addr2state(core_id);
> +    if (!cpu) {
> +        error_setg(errp, "Core-id %d does not exist!", core_id);
> +        return;
> +    }
> +
> +    /* Get attributes not provided from cpu and verify the new topology */
> +    if (!has_socket_id) {
> +        socket_id = cpu->env.socket_id;
> +    }
> +    if (!has_book_id) {
> +        book_id = cpu->env.book_id;
> +    }
> +    if (!has_drawer_id) {
> +        drawer_id = cpu->env.drawer_id;
> +    }
> +    if (!has_dedicated) {
> +        dedicated = cpu->env.dedicated;
> +    }
> +
> +    /*
> +     * When the user specifies the entitlement as 'auto' on the command line,
> +     * qemu will set the entitlement as:

s/qemu/QEMU/

> +     * Medium when the CPU is not dedicated.
> +     * High when dedicated is true.
> +     */
> +    if (!has_entitlement || (entitlement == S390_CPU_ENTITLEMENT_AUTO)) {

nit: Remove the parentheses around "entitlement == S390_CPU_ENTITLEMENT_AUTO".

> +        if (dedicated) {
> +            entitlement = S390_CPU_ENTITLEMENT_HIGH;
> +        } else {
> +            entitlement = S390_CPU_ENTITLEMENT_MEDIUM;
> +        }
> +    }
> +
> +    if (!s390_topology_check(socket_id, book_id, drawer_id,
> +                             entitlement, dedicated, errp)) {
> +        return;
> +    }
> +
> +    /* Check for space on new socket */
> +    old_socket_entry = s390_socket_nb(cpu);
> +    new_socket_entry = s390_socket_nb_from_ids(drawer_id, book_id, socket_id);
> +
> +    if (new_socket_entry != old_socket_entry) {
> +        if (s390_topology.cores_per_socket[new_socket_entry] >=
> +            ms->smp.cores) {
> +            error_setg(errp, "No more space on this socket");
> +            return;
> +        }
> +        /* Update the count of cores in sockets */
> +        s390_topology.cores_per_socket[new_socket_entry] += 1;
> +        s390_topology.cores_per_socket[old_socket_entry] -= 1;
> +    }
> +
> +    /* Check if we will need to report the modified topology */
> +    report_needed = s390_topology_need_report(cpu, drawer_id, book_id,
> +                                              socket_id, entitlement,
> +                                              dedicated);
> +
> +    /* All checks done, report new topology into the vCPU */
> +    cpu->env.drawer_id = drawer_id;
> +    cpu->env.book_id = book_id;
> +    cpu->env.socket_id = socket_id;
> +    cpu->env.dedicated = dedicated;
> +    cpu->env.entitlement = entitlement;
> +
> +    /* topology tree is reflected in props */
> +    s390_update_cpu_props(ms, cpu);
> +
> +    /* Advertise the topology change */
> +    if (report_needed) {
> +        s390_cpu_topology_set_changed(true);
> +    }
> +}
> +
> +void qmp_set_cpu_topology(uint16_t core,
> +                         bool has_socket, uint16_t socket,
> +                         bool has_book, uint16_t book,
> +                         bool has_drawer, uint16_t drawer,
> +                         bool has_entitlement, CpuS390Entitlement entitlement,
> +                         bool has_dedicated, bool dedicated,
> +                         Error **errp)
> +{
> +    ERRP_GUARD();

No need for ERRP_GUARD here, I think.

> +    if (!s390_has_topology()) {
> +        error_setg(errp, "This machine doesn't support topology");
> +        return;
> +    }
> +
> +    s390_change_topology(core, has_socket, socket, has_book, book,
> +                         has_drawer, drawer, has_entitlement, entitlement,
> +                         has_dedicated, dedicated, errp);
> +}

  Thomas


