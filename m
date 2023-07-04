Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 419DC7471CD
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 14:53:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGfX2-00050M-Ir; Tue, 04 Jul 2023 08:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGfWz-0004yn-Or
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:53:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGfWx-000821-30
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688475196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5gv9HGmY8HQzine5JaTlmnV/WU8UAbenpmmWeOB2mpU=;
 b=ZyzfOTRTJgrIMciBNdShIv52cCos79obdbB+Sq6Si8p59S1J2mS7LF2B/hSV4gIRB5tVCy
 H/IjiU4ZNkvIaWKGYyoL+blRCqnrDYHaqcX/t/Blmfg/R//dnvxyaM0tudrSo/1DfzBQo2
 pKI2uOpD4jMQCxaoTABhqB3Ozzd5PsQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-VJV3B24QMhWaWihKuh8z5w-1; Tue, 04 Jul 2023 08:53:15 -0400
X-MC-Unique: VJV3B24QMhWaWihKuh8z5w-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-765986c0521so471315885a.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 05:53:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688475194; x=1691067194;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5gv9HGmY8HQzine5JaTlmnV/WU8UAbenpmmWeOB2mpU=;
 b=Sm3dXMENkw6quy7FE8lQm0LkU3oviQ3KMVHOf944f/z4FFdXQD+ChfZo1IkmGty02L
 +GM+0Ltjsvtl0IXO16JCMiuB7qgKU6HwaaL6b3LISd2RO6JUSW5ONIrH8OYvWsL+nXCO
 i46xu+6/HBNtan+Tuk2mun2oe0AUZS825fJnLafX/BWcwi2WGnjUz6g1VJht/onxPSic
 i3AsyhwkEJcdiqvwbsqY6bdUDMzdCE/aDz3Q/Ca6sXBhz2rZSyYfu5DhIa/OVh+iu5fL
 /mqwPO5ldj69KZufnuVrkjVOYTY0k0GycVriR1S4e5CYZtWzeU8QhM/xRkgPBUKWJGiZ
 KBiw==
X-Gm-Message-State: ABy/qLaQGw+Z5ctCq/whSN7eYj9YCWA+Lz6C5bUjwW3Cof+uP3EWq7rj
 io9UGONNGNSuN1UJQX7g13HrAB+hsKECjs7m9hhvQcvvVJBIs0IoMbLz49h59ObxE0tSEFWcFZy
 PJY+TafmTGr9NoVg=
X-Received: by 2002:a05:620a:4256:b0:767:671b:250f with SMTP id
 w22-20020a05620a425600b00767671b250fmr6019981qko.52.1688475194750; 
 Tue, 04 Jul 2023 05:53:14 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHBHZONvVUo6PrOi1MhSBFRGXvvjHRDOV5dqgTxiM2wZNipNp4ex5aVvF7nOAPLkv+myc0jSQ==
X-Received: by 2002:a05:620a:4256:b0:767:671b:250f with SMTP id
 w22-20020a05620a425600b00767671b250fmr6019948qko.52.1688475194480; 
 Tue, 04 Jul 2023 05:53:14 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-126.web.vodafone.de.
 [109.43.179.126]) by smtp.gmail.com with ESMTPSA id
 q26-20020ae9e41a000000b0076722cbcb97sm6762245qkc.33.2023.07.04.05.53.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 05:53:14 -0700 (PDT)
Message-ID: <7d1797ba-7e19-2fc8-535f-66f3d3aaaa75@redhat.com>
Date: Tue, 4 Jul 2023 14:53:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v21 08/20] qapi/s390x/cpu topology: set-cpu-topology qmp
 command
Content-Language: en-US
To: Pierre Morel <pmorel@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, cohuck@redhat.com,
 mst@redhat.com, pbonzini@redhat.com, kvm@vger.kernel.org,
 ehabkost@redhat.com, marcel.apfelbaum@gmail.com, eblake@redhat.com,
 armbru@redhat.com, seiden@linux.ibm.com, nrb@linux.ibm.com,
 nsg@linux.ibm.com, frankja@linux.ibm.com, berrange@redhat.com, clg@kaod.org
References: <20230630091752.67190-1-pmorel@linux.ibm.com>
 <20230630091752.67190-9-pmorel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230630091752.67190-9-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 30/06/2023 11.17, Pierre Morel wrote:
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
> ---
...
> diff --git a/hw/s390x/cpu-topology.c b/hw/s390x/cpu-topology.c
> index 1af70a5049..dfc4cb42a4 100644
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
> @@ -260,6 +261,29 @@ static bool s390_topology_check(uint16_t socket_id, uint16_t book_id,
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
> @@ -329,3 +353,113 @@ void s390_topology_setup_cpu(MachineState *ms, S390CPU *cpu, Error **errp)
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
> +     * Medium when the CPU is not dedicated.
> +     * High when dedicated is true.
> +     */
> +    if (!has_entitlement || (entitlement == S390_CPU_ENTITLEMENT_AUTO)) {
> +        if (dedicated) {
> +            entitlement = S390_CPU_ENTITLEMENT_HIGH;
> +        } else {
> +            entitlement = S390_CPU_ENTITLEMENT_MEDIUM;
> +        }
> +    }
> +
> +    if (!s390_topology_check(socket_id, book_id, drawer_id,
> +                             entitlement, dedicated, errp))
> +        return;

Missing curly braces here.
Not sure why this isn't caught by checkpatch.pl properly :-(

  Thomas


> +    /* Check for space on new socket */
> +    old_socket_entry = s390_socket_nb(cpu);
> +    new_socket_entry = __s390_socket_nb(drawer_id, book_id, socket_id);
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
> +
> +    if (!s390_has_topology()) {
> +        error_setg(errp, "This machine doesn't support topology");
> +        return;
> +    }
> +
> +    s390_change_topology(core, has_socket, socket, has_book, book,
> +                         has_drawer, drawer, has_entitlement, entitlement,
> +                         has_dedicated, dedicated, errp);
> +}


