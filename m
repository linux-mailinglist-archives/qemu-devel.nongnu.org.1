Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BB87B1D56
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:06:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlqib-0006eO-HB; Thu, 28 Sep 2023 09:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qlqiK-0006cL-V6
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:05:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qlqiF-0003ht-LT
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695906350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PAX/JLEgv5AwL0Q5kJtBo6wHyrIfapphtNxxJyVvdsU=;
 b=hDFEzgXwMGjOhE4M35C+2UfowQ93ApRkvy0fovaVviaRNx4v/JBBwufMY4b03hJQ5S7Ztx
 fcqBGBoSap/YcVDkzRZ7mLLmZI7UpOaYoxx7405vMuHtdWuymGTLqiscJOWk754i4AyYU2
 Dlli41nbkoMNS3dkpPyKjD/qoJhPCDk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-FlkkwBRWMlqW2WRJw7EHNA-1; Thu, 28 Sep 2023 09:05:49 -0400
X-MC-Unique: FlkkwBRWMlqW2WRJw7EHNA-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-418099ca1c2so174418811cf.0
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 06:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695906348; x=1696511148;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PAX/JLEgv5AwL0Q5kJtBo6wHyrIfapphtNxxJyVvdsU=;
 b=J3NGCTaO0KlSNCgOKQdhIbnABs+LdSfF/MiB7IT03p04+kDKELnKEUesOudbglAH3g
 YkdEv1Qs5RrqH30HbovNgRGPAFl6z+96u7EmaCxga2FgXZ36tNKagxt2pnWq+AnXjWpa
 6+UK/3l2I1YjA1TBPFICj7PSUd9sok7C3Sr+kI3wVZFe/JJem+mvpjms/acWmrnSKLrp
 Hb1kY7SSSW+4hpwEm32aVS4ept11+jGQzrxoEAvrYB7aYsh34sat51/k9Zyn7x+rp2/4
 7kEQzkPuB43b3AprFIBglkI625O9IEFUOJJKATwRyagLi6gjL1X6fiNRG8YCy+1j2N5f
 VD0g==
X-Gm-Message-State: AOJu0Yyqw+VjO7kdrboP0wJhd2jNoqmuhNgbZNNnbzMWfiKUYU6dNGbv
 xgN9s1kVBQ1XXGsOL7b3MG3NV62E2TSpfyhPAeLCEel1s1RQpXUhM2AxeQimpmU6OrPmwXJ9c88
 F8Pi3BewG8GdfQ0k=
X-Received: by 2002:ac8:574a:0:b0:403:fcd9:963 with SMTP id
 10-20020ac8574a000000b00403fcd90963mr1363434qtx.67.1695906348452; 
 Thu, 28 Sep 2023 06:05:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGK7MIraEawjQpnptar7d9gbY6pLckEfXy9I2JNI+4WWpOGhbMkZCgmaJZZIGm4VeLWsKV0yA==
X-Received: by 2002:ac8:574a:0:b0:403:fcd9:963 with SMTP id
 10-20020ac8574a000000b00403fcd90963mr1363410qtx.67.1695906348128; 
 Thu, 28 Sep 2023 06:05:48 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-177-123.web.vodafone.de.
 [109.43.177.123]) by smtp.gmail.com with ESMTPSA id
 l11-20020ac84ccb000000b004181441cb2dsm3471794qtv.34.2023.09.28.06.05.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 06:05:47 -0700 (PDT)
Message-ID: <f137153e-e6df-9fd9-cf9e-5528a57e3a90@redhat.com>
Date: Thu, 28 Sep 2023 15:05:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
References: <20230926121534.406035-1-nsg@linux.ibm.com>
 <20230926121534.406035-5-nsg@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v24 04/21] target/s390x/cpu topology: handle STSI(15) and
 build the SYSIB
In-Reply-To: <20230926121534.406035-5-nsg@linux.ibm.com>
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

On 26/09/2023 14.15, Nina Schoetterl-Glausch wrote:
> From: Pierre Morel <pmorel@linux.ibm.com>
> 
> On interception of STSI(15.1.x) the System Information Block
> (SYSIB) is built from the list of pre-ordered topology entries.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
...
> diff --git a/include/hw/s390x/cpu-topology.h b/include/hw/s390x/cpu-topology.h
> index 97b0af2795..350c7ea8aa 100644
> --- a/include/hw/s390x/cpu-topology.h
> +++ b/include/hw/s390x/cpu-topology.h
> @@ -15,10 +15,33 @@
>   #include "hw/boards.h"
>   #include "qapi/qapi-types-machine-target.h"
>   
> +#define S390_TOPOLOGY_CPU_IFL   0x03
> +
> +typedef struct s390_topology_id {
> +    uint8_t sentinel;
> +    uint8_t drawer;
> +    uint8_t book;
> +    uint8_t socket;
> +    uint8_t type;
> +    uint8_t vertical:1;
> +    uint8_t entitlement:2;
> +    uint8_t dedicated;
> +    uint8_t origin;
> +} s390_topology_id;

Sorry for not noticing this earlier, but: Please adapt the name of the 
struct to the QEMU coding conventions, i.e. S390TopologyId instead of 
s390_topology_id.

...
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index dfcc1aa1fc..c1ba5c46d6 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -571,6 +571,29 @@ typedef struct SysIB_322 {
...
> +/*
> + * CPU Topology List provided by STSI with fc=15 provides a list
> + * of two different Topology List Entries (TLE) types to specify
> + * the topology hierarchy.
> + *
> + * - Container Topology List Entry
> + *   Defines a container to contain other Topology List Entries
> + *   of any type, nested containers or CPU.
> + * - CPU Topology List Entry
> + *   Specifies the CPUs position, type, entitlement and polarization
> + *   of the CPUs contained in the last Container TLE.

Please write Container with a small "c" at the beginning.

...
> diff --git a/target/s390x/kvm/stsi-topology.c b/target/s390x/kvm/stsi-topology.c
> new file mode 100644
> index 0000000000..67ecc67184
> --- /dev/null
> +++ b/target/s390x/kvm/stsi-topology.c
> @@ -0,0 +1,339 @@
...
> +/**
> + * s390_topology_fill_list_sorted:
> + * @topology_list: list to fill
> + *
> + * Loop over all CPU and insert it at the right place

I'd like to suggest to change that to:

"Loop over all CPUs and insert each of the at the right place"

> + * inside the TLE entry list.
> + * Fill the S390Topology list with entries according to the order
> + * specified by the PoP.
> + */
> +static void s390_topology_fill_list_sorted(S390TopologyList *topology_list)
> +{
> +    CPUState *cs;
> +    S390TopologyEntry sentinel = { .id.sentinel = 1 };
> +
> +    QTAILQ_INIT(topology_list);
> +
> +    QTAILQ_INSERT_HEAD(topology_list, &sentinel, next);
> +
> +    CPU_FOREACH(cs) {
> +        s390_topology_id id = s390_topology_from_cpu(S390_CPU(cs));
> +        S390TopologyEntry *entry = NULL, *tmp;
> +
> +        QTAILQ_FOREACH(tmp, topology_list, next) {
> +            if (s390_topology_id_eq(&id, &tmp->id)) {
> +                entry = tmp;
> +                break;
> +            } else if (s390_topology_id_lt(&id, &tmp->id)) {
> +                entry = g_malloc0(sizeof(*entry));
> +                entry->id = id;
> +                QTAILQ_INSERT_BEFORE(tmp, entry, next);
> +                break;
> +            }
> +        }
> +        assert(entry);
> +        s390_topology_add_cpu_to_entry(entry, S390_CPU(cs));
> +    }
> +
> +    QTAILQ_REMOVE(topology_list, &sentinel, next);
> +}
> +
> +/**
> + * s390_topology_empty_list:
> + *
> + * Clear all entries in the S390Topology list.
> + */
> +static void s390_topology_empty_list(S390TopologyList *topology_list)
> +{
> +    S390TopologyEntry *entry = NULL;
> +    S390TopologyEntry *tmp = NULL;
> +
> +    QTAILQ_FOREACH_SAFE(entry, topology_list, next, tmp) {
> +        QTAILQ_REMOVE(topology_list, entry, next);
> +        g_free(entry);
> +    }
> +}
> +
> +/**
> + * insert_stsi_15_1_x:
> + * @cpu: the CPU doing the call for which we set CC
> + * @sel2: the selector 2, containing the nested level
> + * @addr: Guest logical address of the guest SysIB
> + * @ar: the access register number
> + * @ra: the return address
> + *
> + * Emulate STSI 15.1.x, that is, perform all necessary checks and
> + * fill the SYSIB.
> + * In case the topology description is too long to fit into the SYSIB,
> + * set CC=3 and abort without writing the SYSIB.
> + */
> +void insert_stsi_15_1_x(S390CPU *cpu, int sel2, uint64_t addr, uint8_t ar, uintptr_t ra)
> +{
> +    S390TopologyList topology_list;
> +    SysIB sysib = {0};
> +    int length;
> +
> +    if (!s390_has_topology() || sel2 < 2 || sel2 > SCLP_READ_SCP_INFO_MNEST) {
> +        setcc(cpu, 3);
> +        return;
> +    }
> +
> +    s390_topology_fill_list_sorted(&topology_list);
> +
> +    length = setup_stsi(&topology_list, &sysib.sysib_151x, sel2);
> +
> +    if (!length) {
> +        s390_topology_empty_list(&topology_list);
> +        setcc(cpu, 3);
> +        return;
> +    }
> +
> +    sysib.sysib_151x.length = cpu_to_be16(length);
> +    if (!s390_cpu_virt_mem_write(cpu, addr, ar, &sysib, length)) {
> +        setcc(cpu, 0);
> +    } else {
> +        s390_cpu_virt_mem_handle_exc(cpu, ra);
> +    }
> +
> +    s390_topology_empty_list(&topology_list);

In case this will ever be used with TCG: s390_cpu_virt_mem_handle_exc() 
might not return, so the clean-up has to be done before calling that function:

     ret = s390_cpu_virt_mem_write(cpu, addr, ar, &sysib, length);
     s390_topology_empty_list(&topology_list);
     if (!ret) {
          setcc(cpu, 0);
     } else {
         s390_cpu_virt_mem_handle_exc(cpu, ra);
     }
}

Or maybe even do it before the "if (!length)" statement, so you don't need 
it in the body of that statement?

  Thomas


