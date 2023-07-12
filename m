Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 665B9750778
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 14:05:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJXu1-0006R6-PD; Wed, 12 Jul 2023 07:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmorel@linux.ibm.com>)
 id 1qJXtr-0006Qg-RU; Wed, 12 Jul 2023 07:20:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmorel@linux.ibm.com>)
 id 1qJXtp-0005m8-83; Wed, 12 Jul 2023 07:20:51 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36CBCELc017358; Wed, 12 Jul 2023 11:20:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=5XkuWlyg9JcVC8l49W6tLULM1fSrk8RfxXv0ceJV5CE=;
 b=Xg9FM2j4UBrnTiVZXMHqhHkJwtjlG835C258S+SfYci91lZH4d+SVa4ytv4Ox5kiF+2I
 BIyEfic/0h6O2gWvUO9M1nC3SwI/N1oN0gsKWt9bupiYAfoZOeG3SHuu7LvbcrN+8ypi
 AJImkCxG1iW5ArbGXValuWWd+Ts0BgvJjXYP8pyu+yrjYg3JSWqC0IoIaU9dUc5ql09Q
 iRkijb/osOOSYcJpsWieFEdKofJfOxyFQjgGgg+sI/oHRBYkU1Wsb69jeasi+OUekGch
 EMvzsGZv4YKL3FU5yXo+QTtkWigUoF3WTJk0VqIs62jHjbOgH2NJrfB15i27fxYdEb3T 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rsu3ar6xf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Jul 2023 11:20:36 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36CBD8ql020315;
 Wed, 12 Jul 2023 11:20:35 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rsu3ar6w4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Jul 2023 11:20:35 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36C8OgmS030057;
 Wed, 12 Jul 2023 11:20:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3rpye59vn6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Jul 2023 11:20:32 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36CBKRS365667494
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Jul 2023 11:20:27 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9301420063;
 Wed, 12 Jul 2023 11:20:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 25A7C2005A;
 Wed, 12 Jul 2023 11:20:27 +0000 (GMT)
Received: from [9.152.222.242] (unknown [9.152.222.242])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 12 Jul 2023 11:20:27 +0000 (GMT)
Message-ID: <234c79fd-1435-71e5-73b7-235724998cdc@linux.ibm.com>
Date: Wed, 12 Jul 2023 13:20:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v21 02/20] s390x/cpu topology: add topology entries on CPU
 hotplug
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, cohuck@redhat.com,
 mst@redhat.com, pbonzini@redhat.com, kvm@vger.kernel.org,
 ehabkost@redhat.com, marcel.apfelbaum@gmail.com, eblake@redhat.com,
 armbru@redhat.com, seiden@linux.ibm.com, nrb@linux.ibm.com,
 nsg@linux.ibm.com, frankja@linux.ibm.com, berrange@redhat.com, clg@kaod.org
References: <20230630091752.67190-1-pmorel@linux.ibm.com>
 <20230630091752.67190-3-pmorel@linux.ibm.com>
 <71bd9791-cdfe-3930-fdd3-64b27b180c6d@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
In-Reply-To: <71bd9791-cdfe-3930-fdd3-64b27b180c6d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: o-G5O88_cSZrRsh6CAoS8AM2HB-voAHv
X-Proofpoint-ORIG-GUID: SxJEAFViEbQ-rPP5Mvk1tQKngl1e5GOJ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_06,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120098
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pmorel@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.11,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


On 7/4/23 12:32, Thomas Huth wrote:
> On 30/06/2023 11.17, Pierre Morel wrote:
>> The topology information are attributes of the CPU and are
>> specified during the CPU device creation.
>>
>> On hot plug we:
>> - calculate the default values for the topology for drawers,
>>    books and sockets in the case they are not specified.
>> - verify the CPU attributes
>> - check that we have still room on the desired socket
>>
>> The possibility to insert a CPU in a mask is dependent on the
>> number of cores allowed in a socket, a book or a drawer, the
>> checking is done during the hot plug of the CPU to have an
>> immediate answer.
>>
>> If the complete topology is not specified, the core is added
>> in the physical topology based on its core ID and it gets
>> defaults values for the modifier attributes.
>>
>> This way, starting QEMU without specifying the topology can
>> still get some advantage of the CPU topology.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
> ...
>> diff --git a/include/hw/s390x/cpu-topology.h 
>> b/include/hw/s390x/cpu-topology.h
>> new file mode 100644
>> index 0000000000..9164ac00a7
>> --- /dev/null
>> +++ b/include/hw/s390x/cpu-topology.h
>> @@ -0,0 +1,54 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * CPU Topology
>> + *
>> + * Copyright IBM Corp. 2022,2023
>
> Nit: Add a space after the comma ?

thx


>
>> + * Author(s): Pierre Morel <pmorel@linux.ibm.com>
>> + *
>> + */
>> +#ifndef HW_S390X_CPU_TOPOLOGY_H
>> +#define HW_S390X_CPU_TOPOLOGY_H
>> +
>> +#ifndef CONFIG_USER_ONLY
>> +
>> +#include "qemu/queue.h"
>> +#include "hw/boards.h"
>> +#include "qapi/qapi-types-machine-target.h"
>> +
>> +typedef struct S390Topology {
>> +    uint8_t *cores_per_socket;
>> +} S390Topology;
>
> So S390Topology has only one entry, "cores_per_socket" here...
>
> ...
>> diff --git a/hw/s390x/cpu-topology.c b/hw/s390x/cpu-topology.c
>> new file mode 100644
>> index 0000000000..b163c17f8f
>> --- /dev/null
>> +++ b/hw/s390x/cpu-topology.c
>> @@ -0,0 +1,264 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * CPU Topology
>> + *
>> + * Copyright IBM Corp. 2022,2023
>> + * Author(s): Pierre Morel <pmorel@linux.ibm.com>
>> + *
>> + * S390 topology handling can be divided in two parts:
>> + *
>> + * - The first part in this file is taking care of all common functions
>> + *   used by KVM and TCG to create and modify the topology.
>> + *
>> + * - The second part, building the topology information data for the
>> + *   guest with CPU and KVM specificity will be implemented inside
>> + *   the target/s390/kvm sub tree.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "qemu/error-report.h"
>> +#include "hw/qdev-properties.h"
>> +#include "hw/boards.h"
>> +#include "target/s390x/cpu.h"
>> +#include "hw/s390x/s390-virtio-ccw.h"
>> +#include "hw/s390x/cpu-topology.h"
>> +
>> +/*
>> + * s390_topology is used to keep the topology information.
>> + * .cores_per_socket: tracks information on the count of cores
>> + *                    per socket.
>> + * .smp: keeps track of the machine topology.
>> + *
>
> ... but the description talks about ".smp" here, too, which never 
> seems to be added. Leftover from a previous iteration?
> (also: please remove the empty line at the end of the comment)


right, thx


>
>> + */
>> +S390Topology s390_topology = {
>> +    /* will be initialized after the cpu model is realized */
>> +    .cores_per_socket = NULL,
>> +};
>> +
>> +/**
>> + * s390_socket_nb:
>> + * @cpu: s390x CPU
>> + *
>> + * Returns the socket number used inside the cores_per_socket array
>> + * for a topology tree entry
>> + */
>> +static int __s390_socket_nb(int drawer_id, int book_id, int socket_id)
>
> Please don't use function names starting with double underscores. This 
> namespace is reserved by the C standard.
> Maybe "s390_socket_nb_from_ids" ?


OK


>
>> +{
>> +    return (drawer_id * current_machine->smp.books + book_id) *
>> +           current_machine->smp.sockets + socket_id;
>> +}
>> +
>> +/**
>> + * s390_socket_nb:
>> + * @cpu: s390x CPU
>> + *
>> + * Returns the socket number used inside the cores_per_socket array
>> + * for a cpu.
>> + */
>> +static int s390_socket_nb(S390CPU *cpu)
>> +{
>> +    return __s390_socket_nb(cpu->env.drawer_id, cpu->env.book_id,
>> +                            cpu->env.socket_id);
>> +}
>> +
>> +/**
>> + * s390_has_topology:
>> + *
>> + * Return value: if the topology is supported by the machine.
>
> "Return: true if the topology is supported by the machine"
>
> (QEMU uses kerneldoc style, so it's just "Return:" and not "Return 
> value:", see e.g. 
> https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html )


OK, thx


>
>> + */
>> +bool s390_has_topology(void)
>> +{
>> +    return false;
>> +}
>> +
>> +/**
>> + * s390_topology_init:
>> + * @ms: the machine state where the machine topology is defined
>> + *
>> + * Keep track of the machine topology.
>> + *
>> + * Allocate an array to keep the count of cores per socket.
>> + * The index of the array starts at socket 0 from book 0 and
>> + * drawer 0 up to the maximum allowed by the machine topology.
>> + */
>> +static void s390_topology_init(MachineState *ms)
>> +{
>> +    CpuTopology *smp = &ms->smp;
>> +
>> +    s390_topology.cores_per_socket = g_new0(uint8_t, smp->sockets *
>> +                                            smp->books * smp->drawers);
>> +}
>> +
>> +/**
>> + * s390_topology_cpu_default:
>> + * @cpu: pointer to a S390CPU
>> + * @errp: Error pointer
>> + *
>> + * Setup the default topology if no attributes are already set.
>> + * Passing a CPU with some, but not all, attributes set is considered
>> + * an error.
>> + *
>> + * The function calculates the (drawer_id, book_id, socket_id)
>> + * topology by filling the cores starting from the first socket
>> + * (0, 0, 0) up to the last (smp->drawers, smp->books, smp->sockets).
>> + *
>> + * CPU type and dedication have defaults values set in the
>> + * s390x_cpu_properties, entitlement must be adjust depending on the
>> + * dedication.
>> + *
>> + * Returns false if it is impossible to setup a default topology
>> + * true otherwise.
>> + */
>> +static bool s390_topology_cpu_default(S390CPU *cpu, Error **errp)
>> +{
>> +    CpuTopology *smp = &current_machine->smp;
>> +    CPUS390XState *env = &cpu->env;
>> +
>> +    /* All geometry topology attributes must be set or all unset */
>> +    if ((env->socket_id < 0 || env->book_id < 0 || env->drawer_id < 
>> 0) &&
>> +        (env->socket_id >= 0 || env->book_id >= 0 || env->drawer_id 
>> >= 0)) {
>> +        error_setg(errp,
>> +                   "Please define all or none of the topology 
>> geometry attributes");
>> +        return false;
>> +    }
>> +
>> +    /* Check if one of the geometry topology is unset */
>> +    if (env->socket_id < 0) {
>> +        /* Calculate default geometry topology attributes */
>> +        env->socket_id = s390_std_socket(env->core_id, smp);
>> +        env->book_id = s390_std_book(env->core_id, smp);
>> +        env->drawer_id = s390_std_drawer(env->core_id, smp);
>> +    }
>> +
>> +    /*
>> +     * When the user specifies the entitlement as 'auto' on the 
>> command line,
>> +     * qemu will set the entitlement as:
>
> s/qemu/QEMU/


ok

>
>> +     * Medium when the CPU is not dedicated.
>> +     * High when dedicated is true.
>> +     */
>> +    if (env->entitlement == S390_CPU_ENTITLEMENT_AUTO) {
>> +        if (env->dedicated) {
>> +            env->entitlement = S390_CPU_ENTITLEMENT_HIGH;
>> +        } else {
>> +            env->entitlement = S390_CPU_ENTITLEMENT_MEDIUM;
>> +        }
>> +    }
>> +    return true;
>> +}
>> +
>> +/**
>> + * s390_topology_check:
>> + * @socket_id: socket to check
>> + * @book_id: book to check
>> + * @drawer_id: drawer to check
>> + * @entitlement: entitlement to check
>> + * @dedicated: dedication to check
>> + * @errp: Error pointer
>> + *
>> + * The function checks if the topology
>> + * attributes fits inside the system topology.
>> + *
>> + * Returns false if the specified topology does not match with
>> + * the machine topology.
>> + */
>> +static bool s390_topology_check(uint16_t socket_id, uint16_t book_id,
>> +                                uint16_t drawer_id, uint16_t 
>> entitlement,
>> +                                bool dedicated, Error **errp)
>> +{
>> +    CpuTopology *smp = &current_machine->smp;
>> +    ERRP_GUARD();
>> +
>> +    if (socket_id >= smp->sockets) {
>> +        error_setg(errp, "Unavailable socket: %d", socket_id);
>> +        return false;
>> +    }
>> +    if (book_id >= smp->books) {
>> +        error_setg(errp, "Unavailable book: %d", book_id);
>> +        return false;
>> +    }
>> +    if (drawer_id >= smp->drawers) {
>> +        error_setg(errp, "Unavailable drawer: %d", drawer_id);
>> +        return false;
>> +    }
>> +    if (entitlement >= S390_CPU_ENTITLEMENT__MAX) {
>> +        error_setg(errp, "Unknown entitlement: %d", entitlement);
>> +        return false;
>> +    }
>> +    if (dedicated && (entitlement == S390_CPU_ENTITLEMENT_LOW ||
>> +                      entitlement == S390_CPU_ENTITLEMENT_MEDIUM)) {
>> +        error_setg(errp, "A dedicated cpu implies high entitlement");
>
> s/cpu/CPU/ ?


yes OK

>
>> +        return false;
>> +    }
>> +    return true;
>> +}
>> +
>> +/**
>> + * s390_update_cpu_props:
>> + * @ms: the machine state
>> + * @cpu: the CPU for which to update the properties from the 
>> environment.
>> + *
>> + */
>> +static void s390_update_cpu_props(MachineState *ms, S390CPU *cpu)
>> +{
>> +    CpuInstanceProperties *props;
>> +
>> +    props = &ms->possible_cpus->cpus[cpu->env.core_id].props;
>> +
>> +    props->socket_id = cpu->env.socket_id;
>> +    props->book_id = cpu->env.book_id;
>> +    props->drawer_id = cpu->env.drawer_id;
>> +}
>> +
>> +/**
>> + * s390_topology_setup_cpu:
>> + * @ms: MachineState used to initialize the topology structure on
>> + *      first call.
>> + * @cpu: the new S390CPU to insert in the topology structure
>> + * @errp: the error pointer
>> + *
>> + * Called from CPU hotplug to check and setup the CPU attributes
>> + * before the CPU is inserted in the topology.
>> + * There is no need to update the MTCR explicitly here because it
>> + * will be updated by KVM on creation of the new CPU.
>> + */
>> +void s390_topology_setup_cpu(MachineState *ms, S390CPU *cpu, Error 
>> **errp)
>> +{
>> +    ERRP_GUARD();
>> +    int entry;
>> +
>> +    /*
>> +     * We do not want to initialize the topology if the cpu model
>
> s/cpu/CPU/
ok
>
>> +     * does not support topology, consequently, we have to wait for
>> +     * the first CPU to be realized, which realizes the CPU model
>> +     * to initialize the topology structures.
>> +     *
>> +     * s390_topology_setup_cpu() is called from the cpu hotplug.
>> +     */
>> +    if (!s390_topology.cores_per_socket) {
>> +        s390_topology_init(ms);
>> +    }
>> +
>> +    if (!s390_topology_cpu_default(cpu, errp)) {
>> +        return;
>> +    }
>> +
>> +    if (!s390_topology_check(cpu->env.socket_id, cpu->env.book_id,
>> +                             cpu->env.drawer_id, cpu->env.entitlement,
>> +                             cpu->env.dedicated, errp)) {
>> +        return;
>> +    }
>> +
>> +    /* Do we still have space in the socket */
>> +    entry = s390_socket_nb(cpu);
>> +    if (s390_topology.cores_per_socket[entry] >= 
>> current_machine->smp.cores) {
>> +        error_setg(errp, "No more space on this socket");
>> +        return;
>> +    }
>> +
>> +    /* Update the count of cores in sockets */
>> +    s390_topology.cores_per_socket[entry] += 1;
>> +
>> +    /* topology tree is reflected in props */
>> +    s390_update_cpu_props(ms, cpu);
>> +}
>
>  Thomas
>
>
Thanks, I make the changes.

Regards,

Pierre



