Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 859EE7922A2
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 14:29:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdVAx-0007tV-Pg; Tue, 05 Sep 2023 08:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdVAt-0007tG-DC
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 08:28:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdVAq-00020r-MC
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 08:28:55 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-XgFSLp5oPmC3r0zCxxHuUA-1; Tue, 05 Sep 2023 08:28:49 -0400
X-MC-Unique: XgFSLp5oPmC3r0zCxxHuUA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31c7727aa5cso1232718f8f.0
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 05:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693916928; x=1694521728;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O9VVqucldNYbxHl664UtZWVZFNAPK4Rx3cn7vQNsHto=;
 b=X3M6lzQ/QXG7nTOOv0bMZ+z49ghuIIzyx3w6h8RbbsSeFstqHww1wu99aJvPjTfHMl
 0eFqzQamUqd0D4tOTIHQBGSXdRMeNGv5JTxxoGEOGd4yR0jp4rfGS0DqauoVMioMfs86
 e3c3tdZMdyr47okevt+Dp4Ykv8ug1LxgLcHScvK6f0BBJI4nMALItFiMTnnpey1SWlnN
 HnuRN6iTDQ3X25Joy0t/Y1+LywJ9K4yH+3Qpj4veoWT9iup7S6Fwx/XodTOSCTAS5fNQ
 FAFVqo3ZcelFIPLEk2VFbQdw/HC8hrlldPrtRRAAp76pyt/A1sAkGhZoHYWZSRGV09h2
 2O3w==
X-Gm-Message-State: AOJu0YzyVZRIwX7jD1nwxqxPyPpktdej87ftuJsfrvRjt4UWZVpEvc53
 nm0XfWf52hRT8XlvJaMGqSn2tCrlIgS6lDjbyFYiD9EpbA0MzP3teCcVLkzz+1zb7P1JQT1FbQy
 hkH8F++z920ORqPs=
X-Received: by 2002:a5d:4041:0:b0:31a:c6fb:4142 with SMTP id
 w1-20020a5d4041000000b0031ac6fb4142mr9197221wrp.16.1693916927857; 
 Tue, 05 Sep 2023 05:28:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExs81ev9VXVq1i1haa8U0IIfVo9G4w+f/pkAULnucG6PYJB5fWL0QJ1KXxbaNbUV6f8AjjCw==
X-Received: by 2002:a5d:4041:0:b0:31a:c6fb:4142 with SMTP id
 w1-20020a5d4041000000b0031ac6fb4142mr9197191wrp.16.1693916927469; 
 Tue, 05 Sep 2023 05:28:47 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-5.web.vodafone.de. [109.43.176.5])
 by smtp.gmail.com with ESMTPSA id
 l4-20020adffe84000000b003176eab8868sm17401431wrr.82.2023.09.05.05.28.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 05:28:46 -0700 (PDT)
Message-ID: <559e78ac-adff-721b-13ea-aae1de1e9dd5@redhat.com>
Date: Tue, 5 Sep 2023 14:28:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
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
 <20230901155812.2696560-3-nsg@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v22 02/20] s390x/cpu topology: add topology entries on CPU
 hotplug
In-Reply-To: <20230901155812.2696560-3-nsg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
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

On 01/09/2023 17.57, Nina Schoetterl-Glausch wrote:
> From: Pierre Morel <pmorel@linux.ibm.com>
> 
> The topology information are attributes of the CPU and are
> specified during the CPU device creation.
> 
> On hot plug we:
> - calculate the default values for the topology for drawers,
>    books and sockets in the case they are not specified.
> - verify the CPU attributes
> - check that we have still room on the desired socket
> 
> The possibility to insert a CPU in a mask is dependent on the
> number of cores allowed in a socket, a book or a drawer, the
> checking is done during the hot plug of the CPU to have an
> immediate answer.
> 
> If the complete topology is not specified, the core is added
> in the physical topology based on its core ID and it gets
> defaults values for the modifier attributes.
> 
> This way, starting QEMU without specifying the topology can
> still get some advantage of the CPU topology.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
...
> +/**
> + * s390_topology_cpu_default:
> + * @cpu: pointer to a S390CPU
> + * @errp: Error pointer
> + *
> + * Setup the default topology if no attributes are already set.
> + * Passing a CPU with some, but not all, attributes set is considered
> + * an error.
> + *
> + * The function calculates the (drawer_id, book_id, socket_id)
> + * topology by filling the cores starting from the first socket
> + * (0, 0, 0) up to the last (smp->drawers, smp->books, smp->sockets).
> + *
> + * CPU type and dedication have defaults values set in the
> + * s390x_cpu_properties, entitlement must be adjust depending on the
> + * dedication.
> + *
> + * Returns false if it is impossible to setup a default topology
> + * true otherwise.
> + */
> +static bool s390_topology_cpu_default(S390CPU *cpu, Error **errp)
> +{
> +    CpuTopology *smp = &current_machine->smp;
> +    CPUS390XState *env = &cpu->env;
> +
> +    /* All geometry topology attributes must be set or all unset */
> +    if ((env->socket_id < 0 || env->book_id < 0 || env->drawer_id < 0) &&
> +        (env->socket_id >= 0 || env->book_id >= 0 || env->drawer_id >= 0)) {
> +        error_setg(errp,
> +                   "Please define all or none of the topology geometry attributes");
> +        return false;
> +    }
> +
> +    /* Check if one of the geometry topology is unset */

The comment isn't too helpful - maybe rather something like this:
"If one value of the topology is still unset, this means that now that all 
of them are unset, so calculate  the default attributes now." (and then 
remove also the comment within the curly braces below)

> +    if (env->socket_id < 0) {
> +        /* Calculate default geometry topology attributes */
> +        env->socket_id = s390_std_socket(env->core_id, smp);
> +        env->book_id = s390_std_book(env->core_id, smp);
> +        env->drawer_id = s390_std_drawer(env->core_id, smp);
> +    }
> +
> +    /*
> +     * When the user specifies the entitlement as 'auto' on the command line,
> +     * QEMU will set the entitlement as:
> +     * Medium when the CPU is not dedicated.
> +     * High when dedicated is true.
> +     */
> +    if (env->entitlement == S390_CPU_ENTITLEMENT_AUTO) {
> +        if (env->dedicated) {
> +            env->entitlement = S390_CPU_ENTITLEMENT_HIGH;
> +        } else {
> +            env->entitlement = S390_CPU_ENTITLEMENT_MEDIUM;
> +        }
> +    }
> +    return true;
> +}
> +
> +/**
> + * s390_topology_check:
> + * @socket_id: socket to check
> + * @book_id: book to check
> + * @drawer_id: drawer to check
> + * @entitlement: entitlement to check
> + * @dedicated: dedication to check
> + * @errp: Error pointer
> + *
> + * The function checks if the topology
> + * attributes fits inside the system topology.
> + *
> + * Returns false if the specified topology does not match with
> + * the machine topology.
> + */
> +static bool s390_topology_check(uint16_t socket_id, uint16_t book_id,
> +                                uint16_t drawer_id, uint16_t entitlement,
> +                                bool dedicated, Error **errp)
> +{
> +    CpuTopology *smp = &current_machine->smp;
> +    ERRP_GUARD();

No need for ERRP_GUARD() here, I think.

> +    if (socket_id >= smp->sockets) {
> +        error_setg(errp, "Unavailable socket: %d", socket_id);
> +        return false;
> +    }
> +    if (book_id >= smp->books) {
> +        error_setg(errp, "Unavailable book: %d", book_id);
> +        return false;
> +    }
> +    if (drawer_id >= smp->drawers) {
> +        error_setg(errp, "Unavailable drawer: %d", drawer_id);
> +        return false;
> +    }
> +    if (entitlement >= S390_CPU_ENTITLEMENT__MAX) {
> +        error_setg(errp, "Unknown entitlement: %d", entitlement);
> +        return false;
> +    }
> +    if (dedicated && (entitlement == S390_CPU_ENTITLEMENT_LOW ||
> +                      entitlement == S390_CPU_ENTITLEMENT_MEDIUM)) {
> +        error_setg(errp, "A dedicated CPU implies high entitlement");
> +        return false;
> +    }
> +    return true;
> +}
> +
> +/**
> + * s390_update_cpu_props:
> + * @ms: the machine state
> + * @cpu: the CPU for which to update the properties from the environment.
> + *
> + */
> +static void s390_update_cpu_props(MachineState *ms, S390CPU *cpu)
> +{
> +    CpuInstanceProperties *props;
> +
> +    props = &ms->possible_cpus->cpus[cpu->env.core_id].props;
> +
> +    props->socket_id = cpu->env.socket_id;
> +    props->book_id = cpu->env.book_id;
> +    props->drawer_id = cpu->env.drawer_id;
> +}
> +
> +/**
> + * s390_topology_setup_cpu:
> + * @ms: MachineState used to initialize the topology structure on
> + *      first call.
> + * @cpu: the new S390CPU to insert in the topology structure
> + * @errp: the error pointer
> + *
> + * Called from CPU hotplug to check and setup the CPU attributes
> + * before the CPU is inserted in the topology.
> + * There is no need to update the MTCR explicitly here because it
> + * will be updated by KVM on creation of the new CPU.
> + */
> +void s390_topology_setup_cpu(MachineState *ms, S390CPU *cpu, Error **errp)
> +{
> +    ERRP_GUARD();

I think ERRP_GUARD is also not necessary here?

> +    int entry;
> +
> +    /*
> +     * We do not want to initialize the topology if the CPU model
> +     * does not support topology, consequently, we have to wait for
> +     * the first CPU to be realized, which realizes the CPU model
> +     * to initialize the topology structures.
> +     *
> +     * s390_topology_setup_cpu() is called from the CPU hotplug.
> +     */
> +    if (!s390_topology.cores_per_socket) {
> +        s390_topology_init(ms);
> +    }
> +
> +    if (!s390_topology_cpu_default(cpu, errp)) {
> +        return;
> +    }
> +
> +    if (!s390_topology_check(cpu->env.socket_id, cpu->env.book_id,
> +                             cpu->env.drawer_id, cpu->env.entitlement,
> +                             cpu->env.dedicated, errp)) {
> +        return;
> +    }
> +
> +    /* Do we still have space in the socket */
> +    entry = s390_socket_nb(cpu);
> +    if (s390_topology.cores_per_socket[entry] >= current_machine->smp.cores) {
> +        error_setg(errp, "No more space on this socket");
> +        return;
> +    }
> +
> +    /* Update the count of cores in sockets */
> +    s390_topology.cores_per_socket[entry] += 1;
> +
> +    /* topology tree is reflected in props */
> +    s390_update_cpu_props(ms, cpu);
> +}

Anyway, with or without the nits fixed, this looks fine to me, so:

Reviewed-by: Thomas Huth <thuth@redhat.com>


