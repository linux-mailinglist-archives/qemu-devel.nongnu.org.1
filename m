Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2AD9EA19F
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Dec 2024 23:10:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKlvt-0006fv-Sy; Mon, 09 Dec 2024 17:08:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1tKlvq-0006an-E1; Mon, 09 Dec 2024 17:08:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1tKlvn-0005pR-R1; Mon, 09 Dec 2024 17:08:46 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9IvL9F009918;
 Mon, 9 Dec 2024 22:08:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=dgJ/YG
 K+/2oaORSbDDG6NFaMUgkRreVHcuqHwxW4jMs=; b=QxrJqeQ3p3fhA39OVpl+H8
 2TrE+hu2deziwOlq552emuGVtpSn01vPmS/rLbu2kOjp9hgax+GpfIjoaJE9pCWI
 5w38pqNpJNYohidOFqxdOD56GqzCm6shso+KyLLwf7ylWUd9iyvnyJ7yLiwVNAvf
 z4HTxSdbOJOxhxukU3aaGtdi645xTj617brsV8qtwewRlz8qCpKYdbJf61NbVSTi
 Kl/nN5rSqxbrReHs7SplSeINXwfcDToGK2uVV8bm6RlEwcC8f5GKj9kWbk8S+p/O
 pMM1PMWP3rwNz9Npr60V8T3zc2ABM1apVKTd/aLXTV13+PujEkmMnd1Y8G21hoYQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cdv8ktwn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Dec 2024 22:08:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9Joak5023015;
 Mon, 9 Dec 2024 22:08:39 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d2wjrbkn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Dec 2024 22:08:39 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4B9M8c5F24511082
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Dec 2024 22:08:39 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8F025805B;
 Mon,  9 Dec 2024 22:08:38 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 02F5558058;
 Mon,  9 Dec 2024 22:08:38 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Dec 2024 22:08:37 +0000 (GMT)
Message-ID: <bf154441-1e0a-4029-946a-727621395e25@linux.ibm.com>
Date: Mon, 9 Dec 2024 17:08:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 25/26] target/arm/kvm-rme: Add measurement log
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-27-jean-philippe@linaro.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20241125195626.856992-27-jean-philippe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bRDVbE4EHyozJhLnfSUCvYeC7b7yVG5R
X-Proofpoint-ORIG-GUID: bRDVbE4EHyozJhLnfSUCvYeC7b7yVG5R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090167
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



On 11/25/24 2:56 PM, Jean-Philippe Brucker wrote:
> Create an event log, in the format defined by Trusted Computing Group

s/,//

> for TPM2. It contains information about the VMM, the Realm parameters,
> any data loaded into guest memory before boot and the initial vCPU

s/ and/ ,and/

[move comma from above to before 'and']

> state.
> 
> The guest can access this log from RAM and send it to a verifier, to
> help the verifier independently compute the Realm Initial Measurement,
> and check that the data we load into guest RAM is known-good images.
> Without this log, the verifier has to guess where everything is loaded
> and in what order.

Mention that the verifier can pull out the signature from somewhere as 
well...

> 
> Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v2->v3: New
> ---
>   qapi/qom.json        |   9 +-
>   target/arm/kvm_arm.h |  27 +++
>   target/arm/kvm-rme.c | 415 ++++++++++++++++++++++++++++++++++++++++++-
>   target/arm/Kconfig   |   1 +
>   4 files changed, 449 insertions(+), 3 deletions(-)
> 
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 901ba67634..1de1b0d8af 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1094,11 +1094,18 @@
>   # @measurement-algorithm: Realm measurement algorithm
>   #     (default: sha512)
>   #
> +# @measurement-log: Enable a measurement log for the Realm. All events
> +#     that contribute to the Realm Initial Measurement (RIM) are added
> +#     to a log in TCG TPM2 format, which is itself loaded into Realm
> +#     memory (unmeasured) and can then be read by a verifier to
> +#     reconstruct the RIM.
> +#
>   # Since: 9.3
>   ##
>   { 'struct': 'RmeGuestProperties',
>     'data': { '*personalization-value': 'str',
> -            '*measurement-algorithm': 'RmeGuestMeasurementAlgorithm' } }
> +            '*measurement-algorithm': 'RmeGuestMeasurementAlgorithm',
> +            '*measurement-log': 'bool'} }
>   
>   ##
>   # @ObjectType:
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index 77680f238a..44e95a034b 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -268,6 +268,24 @@ int kvm_arm_rme_vcpu_init(CPUState *cs);
>    */
>   void kvm_arm_rme_init_guest_ram(hwaddr base, size_t size);
>   
> +/**
> + * kvm_arm_rme_get_measurement_log
> + *
> + * Obtain the measurement log object if enabled, in order to get its size and
> + * set its base address.
> + *
> + * Returns NULL if measurement log is disabled.
> + */
> +Object *kvm_arm_rme_get_measurement_log(void);
> +
> +/**
> + * kvm_arm_rme_set_ipa_size
> + * @ipa_bits: number of guest physical address bits
> + *
> + * Set the GPA size, not counting the bit reserved for shared address range.
> + */
> +void kvm_arm_rme_set_ipa_size(uint8_t ipa_bits);
> +
>   #else
>   
>   /*
> @@ -298,6 +316,15 @@ static inline void kvm_arm_rme_init_guest_ram(hwaddr base, size_t size)
>   {
>   }
>   
> +static inline Object *kvm_arm_rme_get_measurement_log(void)
> +{
> +    return NULL;
> +}
> +
> +static inline void kvm_arm_rme_set_ipa_size(uint8_t ipa_size)
> +{
> +}
> +
>   /*
>    * These functions should never actually be called without KVM support.
>    */
> diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> index bf0bcf9a38..f92cfdb5f3 100644
> --- a/target/arm/kvm-rme.c
> +++ b/target/arm/kvm-rme.c
> @@ -10,10 +10,12 @@
>   #include "hw/boards.h"
>   #include "hw/core/cpu.h"
>   #include "hw/loader.h"
> +#include "hw/tpm/tpm_log.h"
>   #include "kvm_arm.h"
>   #include "migration/blocker.h"
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
> +#include "qemu/units.h"
>   #include "qom/object_interfaces.h"
>   #include "sysemu/kvm.h"
>   #include "sysemu/runstate.h"
> @@ -25,6 +27,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
>   
>   #define RME_MAX_CFG         2
>   
> +#define RME_MEASUREMENT_LOG_SIZE    (64 * KiB)
> +
>   struct RmeGuest {
>       ConfidentialGuestSupport parent_obj;
>       Notifier rom_load_notifier;
> @@ -32,22 +36,344 @@ struct RmeGuest {
>   
>       uint8_t *personalization_value;
>       RmeGuestMeasurementAlgorithm measurement_algo;
> +    bool use_measurement_log;
>   
> +    size_t num_cpus;
> +    uint8_t ipa_bits;
>       hwaddr ram_base;
>       size_t ram_size;
> +
> +    TpmLog *log;
> +    GHashTable *images;
>   };
>   
>   OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
>                                             CONFIDENTIAL_GUEST_SUPPORT,
>                                             { TYPE_USER_CREATABLE }, { })
>   
> +typedef struct RmeLogFiletype {
> +    uint32_t event_type;
> +    /* Description copied into the log event */
> +    const char *desc;
> +} RmeLogFiletype;
> +
>   typedef struct {
>       hwaddr base;
>       hwaddr size;
> +    uint8_t *data;
> +    RmeLogFiletype *filetype;
>   } RmeRamRegion;
>   
> +typedef struct {
> +    char        signature[16];
> +    char        name[32];
> +    char        version[40];
> +    uint64_t    ram_size;
> +    uint32_t    num_cpus;
> +    uint64_t    flags;
> +} EventLogVmmVersion;
> +
> +typedef struct {
> +    uint32_t    id;
> +    uint32_t    data_size;
> +    uint8_t     data[];
> +} EventLogTagged;
> +


> +#define EVENT_LOG_TAG_REALM_CREATE  1
> +#define EVENT_LOG_TAG_INIT_RIPAS    2
> +#define EVENT_LOG_TAG_REC_CREATE    3
> +
If these are ARM-related structures and constants from a document you 
may want to mention the document you got them from.


> +#define REALM_PARAMS_FLAG_SVE       (1 << 1)
> +#define REALM_PARAMS_FLAG_PMU       (1 << 2)
> +
> +#define REC_CREATE_FLAG_RUNNABLE    (1 << 0)
> +
>   static RmeGuest *rme_guest;
>   
> +static int rme_init_measurement_log(MachineState *ms)
> +{
> +    Object *log;
> +    gpointer filename;
> +    TpmLogDigestAlgo algo;
> +    RmeLogFiletype *filetype;
> +
> +    if (!rme_guest->use_measurement_log) {
> +        return 0;
> +    }
> +
> +    switch (rme_guest->measurement_algo) {
> +    case RME_GUEST_MEASUREMENT_ALGORITHM_SHA256:
> +        algo = TPM_LOG_DIGEST_ALGO_SHA256;
> +        break;
> +    case RME_GUEST_MEASUREMENT_ALGORITHM_SHA512:
> +        algo = TPM_LOG_DIGEST_ALGO_SHA512;
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    log = object_new_with_props(TYPE_TPM_LOG, OBJECT(rme_guest),
> +                                "log", &error_fatal,
> +                                "digest-algo", TpmLogDigestAlgo_str(algo),
> +                                NULL);
> +
> +    tpm_log_create(TPM_LOG(log), RME_MEASUREMENT_LOG_SIZE, &error_fatal);
> +    rme_guest->log = TPM_LOG(log);
> +
> +    /*
> +     * Write down the image names we're expecting to encounter when handling the
> +     * ROM load notifications, so we can record the type of image being loaded
> +     * to help the verifier.
> +     */
> +    rme_guest->images = g_hash_table_new_full(g_str_hash, g_str_equal, g_free,
> +                                              g_free);
> +
> +    filename = g_strdup(ms->kernel_filename);
> +    if (filename) {
> +        filetype = g_new0(RmeLogFiletype, 1);
> +        filetype->event_type = TCG_EV_POST_CODE2;
> +        filetype->desc = "KERNEL";
> +        g_hash_table_insert(rme_guest->images, filename, (gpointer)filetype);
> +    }
> +
> +    filename = g_strdup(ms->initrd_filename);
> +    if (filename) {
> +        filetype = g_new0(RmeLogFiletype, 1);
> +        filetype->event_type = TCG_EV_POST_CODE2;
> +        filetype->desc = "INITRD";
> +        g_hash_table_insert(rme_guest->images, filename, (gpointer)filetype);
> +    }
> +
> +    filename = g_strdup(ms->firmware);
> +    if (filename) {
> +        filetype = g_new0(RmeLogFiletype, 1);
> +        filetype->event_type = TCG_EV_EFI_PLATFORM_FIRMWARE_BLOB2;
> +        filetype->desc = "FIRMWARE";
> +        g_hash_table_insert(rme_guest->images, filename, filetype);
> +    }
> +
> +    filename = g_strdup(ms->dtb);
> +    if (!filename) {
> +        filename = g_strdup("dtb");
> +    }
> +    filetype = g_new0(RmeLogFiletype, 1);
> +    filetype->event_type = TCG_EV_POST_CODE2;
> +    filetype->desc = "DTB";
> +    g_hash_table_insert(rme_guest->images, filename, filetype);
> +
> +    return 0;
> +}
> +
> +static int rme_log_event_tag(uint32_t id, uint8_t *data, size_t size,
> +                             Error **errp)
> +{
> +    int ret;
> +    EventLogTagged event = {
> +        .id = id,
> +        .data_size = size,
> +    };
> +    GByteArray *bytes = g_byte_array_new();
> +
> +    if (!rme_guest->log) {
> +        return 0;
> +    }
> +
> +    g_byte_array_append(bytes, (uint8_t *)&event, sizeof(event));
> +    g_byte_array_append(bytes, data, size);
> +    ret = tpm_log_add_event(rme_guest->log, TCG_EV_EVENT_TAG, bytes->data,
> +                             bytes->len, NULL, 0, errp);
> +    g_byte_array_free(bytes, true);
> +    return ret;
> +}
> +
> +/* Log VM type and Realm Descriptor create */
> +static int rme_log_realm_create(Error **errp)
> +{
> +    int ret;
> +    ARMCPU *cpu;
> +    EventLogVmmVersion vmm_version = {
> +        .signature = "VM VERSION",
> +        .name = "QEMU",
> +        .version = "9.1", /* TODO: dynamic */

$ grep -r QEMU_VERSION_M build/
build/config-host.h:#define QEMU_VERSION_MAJOR 9
build/config-host.h:#define QEMU_VERSION_MICRO 93
build/config-host.h:#define QEMU_VERSION_MINOR 1

$ cat VERSION
9.1.93


> +        .ram_size = cpu_to_le64(rme_guest->ram_size),
> +        .num_cpus = cpu_to_le32(rme_guest->num_cpus),
> +        .flags = 0,
> +    };
> +    struct {
> +        uint64_t    flags;
> +        uint8_t     s2sz;
> +        uint8_t     sve_vl;
> +        uint8_t     num_bps;
> +        uint8_t     num_wps;
> +        uint8_t     pmu_num_ctrs;
> +        uint8_t     hash_algo;
> +    } params = {
> +        .s2sz = rme_guest->ipa_bits,
> +    };
> +
> +    if (!rme_guest->log) {
> +        return 0;
> +    }
> +
> +    ret = tpm_log_add_event(rme_guest->log, TCG_EV_NO_ACTION,
> +                            (uint8_t *)&vmm_version, sizeof(vmm_version),
> +                            NULL, 0, errp);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    /* With KVM all CPUs have the same capability */
> +    cpu = ARM_CPU(first_cpu);
> +    if (cpu->has_pmu) {
> +        params.flags |= REALM_PARAMS_FLAG_PMU;
> +        params.pmu_num_ctrs = FIELD_EX64(cpu->isar.reset_pmcr_el0, PMCR, N);
> +    }
> +
> +    if (cpu->sve_max_vq) {
> +        params.flags |= REALM_PARAMS_FLAG_SVE;
> +        params.sve_vl = cpu->sve_max_vq - 1;
> +    }
> +    params.num_bps = FIELD_EX64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, BRPS);
> +    params.num_wps = FIELD_EX64(cpu->isar.id_aa64dfr0, ID_AA64DFR0, WRPS);
> +
> +    switch (rme_guest->measurement_algo) {
> +    case RME_GUEST_MEASUREMENT_ALGORITHM_SHA256:
> +        params.hash_algo = KVM_CAP_ARM_RME_MEASUREMENT_ALGO_SHA256;
> +        break;
> +    case RME_GUEST_MEASUREMENT_ALGORITHM_SHA512:
> +        params.hash_algo = KVM_CAP_ARM_RME_MEASUREMENT_ALGO_SHA512;
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    return rme_log_event_tag(EVENT_LOG_TAG_REALM_CREATE, (uint8_t *)&params,
> +                             sizeof(params), errp);
> +}
> +
> +/* unmeasured images are logged with @data == NULL */
> +static int rme_log_image(RmeLogFiletype *filetype, uint8_t *data, hwaddr base,
> +                          size_t size, Error **errp)
> +{
> +    int ret;
> +    size_t desc_size;
> +    GByteArray *event = g_byte_array_new();
> +    struct UefiPlatformFirmwareBlob2Head head = {0};
> +    struct UefiPlatformFirmwareBlob2Tail tail = {0};
> +
> +    if (!rme_guest->log) {
> +        return 0;
> +    }
> +
> +    if (!filetype) {
> +        error_setg(errp, "cannot log image without a filetype");
> +        return -1;
> +    }
> +
> +    /* EV_POST_CODE2 strings are not NUL-terminated */
> +    desc_size = strlen(filetype->desc);
> +    head.blob_description_size = desc_size;
> +    tail.blob_base = cpu_to_le64(base);
> +    tail.blob_size = cpu_to_le64(size);
> +
> +    g_byte_array_append(event, (guint8 *)&head, sizeof(head));
> +    g_byte_array_append(event, (guint8 *)filetype->desc, desc_size);
> +    g_byte_array_append(event, (guint8 *)&tail, sizeof(tail));
> +
> +    ret = tpm_log_add_event(rme_guest->log, filetype->event_type, event->data,
> +                            event->len, data, size, errp);
> +    g_byte_array_free(event, true);
> +    return ret;
> +}
> +
> +static int rme_log_ripas(hwaddr base, size_t size, Error **errp)
> +{
> +    struct {
> +        uint64_t base;
> +        uint64_t size;
> +    } init_ripas = {
> +        .base = cpu_to_le64(base),
> +        .size = cpu_to_le64(size),
> +    };
> +
> +    return rme_log_event_tag(EVENT_LOG_TAG_INIT_RIPAS, (uint8_t *)&init_ripas,
> +                             sizeof(init_ripas), errp);
> +}
> +
> +static int rme_log_rec(uint64_t flags, uint64_t pc, uint64_t gprs[8], Error **errp)
> +{

$ ./scripts/checkpatch.pl ./tmp/*.patch
[...]
Checking ./tmp/0002-target-arm-kvm-rme-Add-measurement-log.patch...
WARNING: line over 80 characters
#353: FILE: target/arm/kvm-rme.c:303:
+static int rme_log_rec(uint64_t flags, uint64_t pc, uint64_t gprs[8], 
Error **errp)

May want to run this on all patches.

Rest LGTM.


> +    struct {
> +        uint64_t flags;
> +        uint64_t pc;
> +        uint64_t gprs[8];
> +    } rec_create = {
> +        .flags = cpu_to_le64(flags),
> +        .pc = cpu_to_le64(pc),
> +        .gprs[0] = cpu_to_le64(gprs[0]),
> +        .gprs[1] = cpu_to_le64(gprs[1]),
> +        .gprs[2] = cpu_to_le64(gprs[2]),
> +        .gprs[3] = cpu_to_le64(gprs[3]),
> +        .gprs[4] = cpu_to_le64(gprs[4]),
> +        .gprs[5] = cpu_to_le64(gprs[5]),
> +        .gprs[6] = cpu_to_le64(gprs[6]),
> +        .gprs[7] = cpu_to_le64(gprs[7]),
> +    };
> +
> +    return rme_log_event_tag(EVENT_LOG_TAG_REC_CREATE, (uint8_t *)&rec_create,
> +                             sizeof(rec_create), errp);
> +}
> +
> +static int rme_populate_range(hwaddr base, size_t size, bool measure,
> +                              Error **errp);
> +
> +static int rme_close_measurement_log(Error **errp)
> +{
> +    int ret;
> +    hwaddr base;
> +    size_t size;
> +    RmeLogFiletype filetype = {
> +        .event_type = TCG_EV_POST_CODE2,
> +        .desc = "LOG",
> +    };
> +
> +    if (!rme_guest->log) {
> +        return 0;
> +    }
> +
> +    base = object_property_get_uint(OBJECT(rme_guest->log), "load-addr", errp);
> +    if (*errp) {
> +        return -1;
> +    }
> +
> +    size = object_property_get_uint(OBJECT(rme_guest->log), "max-size", errp);
> +    if (*errp) {
> +        return -1;
> +    }
> +
> +    /* Log the log itself */
> +    ret = rme_log_image(&filetype, NULL, base, size, errp);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    ret = tpm_log_write_and_close(rme_guest->log, errp);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    ret = rme_populate_range(base, size, /* measure */ false, errp);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    g_hash_table_destroy(rme_guest->images);
> +
> +    /* The log is now in the guest. Free this object */
> +    object_unparent(OBJECT(rme_guest->log));
> +    rme_guest->log = NULL;
> +    return 0;
> +}
> +
>   static int rme_configure_one(RmeGuest *guest, uint32_t cfg, Error **errp)
>   {
>       int ret;
> @@ -120,9 +446,10 @@ static int rme_init_ram(hwaddr base, size_t size, Error **errp)
>           error_setg_errno(errp, -ret,
>                            "failed to init RAM [0x%"HWADDR_PRIx", 0x%"HWADDR_PRIx")",
>                            start, end);
> +        return ret;
>       }
>   
> -    return ret;
> +    return rme_log_ripas(base, size, errp);
>   }
>   
>   static int rme_populate_range(hwaddr base, size_t size, bool measure,
> @@ -158,23 +485,42 @@ static void rme_populate_ram_region(gpointer data, gpointer err)
>       }
>   
>       rme_populate_range(region->base, region->size, /* measure */ true, errp);
> +    if (*errp) {
> +        return;
> +    }
> +
> +    rme_log_image(region->filetype, region->data, region->base, region->size,
> +                  errp);
>   }
>   
>   static int rme_init_cpus(Error **errp)
>   {
>       int ret;
>       CPUState *cs;
> +    bool logged_primary_cpu = false;
>   
>       /*
>        * Now that do_cpu_reset() initialized the boot PC and
>        * kvm_cpu_synchronize_post_reset() registered it, we can finalize the REC.
>        */
>       CPU_FOREACH(cs) {
> -        ret = kvm_arm_vcpu_finalize(ARM_CPU(cs), KVM_ARM_VCPU_REC);
> +        ARMCPU *cpu = ARM_CPU(cs);
> +
> +        ret = kvm_arm_vcpu_finalize(cpu, KVM_ARM_VCPU_REC);
>           if (ret) {
>               error_setg_errno(errp, -ret, "failed to finalize vCPU");
>               return ret;
>           }
> +
> +        if (!logged_primary_cpu) {
> +            ret = rme_log_rec(REC_CREATE_FLAG_RUNNABLE, cpu->env.pc,
> +                              cpu->env.xregs, errp);
> +            if (ret) {
> +                return ret;
> +            }
> +
> +            logged_primary_cpu = true;
> +        }
>       }
>       return 0;
>   }
> @@ -194,6 +540,10 @@ static int rme_create_realm(Error **errp)
>           return -1;
>       }
>   
> +    if (rme_log_realm_create(errp)) {
> +        return -1;
> +    }
> +
>       if (rme_init_ram(rme_guest->ram_base, rme_guest->ram_size, errp)) {
>           return -1;
>       }
> @@ -208,6 +558,10 @@ static int rme_create_realm(Error **errp)
>           return -1;
>       }
>   
> +    if (rme_close_measurement_log(errp)) {
> +        return -1;
> +    }
> +
>       ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_ARM_RME, 0,
>                               KVM_CAP_ARM_RME_ACTIVATE_REALM);
>       if (ret) {
> @@ -303,6 +657,20 @@ static void rme_set_measurement_algo(Object *obj, int algo, Error **errp)
>       guest->measurement_algo = algo;
>   }
>   
> +static bool rme_get_measurement_log(Object *obj, Error **errp)
> +{
> +    RmeGuest *guest = RME_GUEST(obj);
> +
> +    return guest->use_measurement_log;
> +}
> +
> +static void rme_set_measurement_log(Object *obj, bool value, Error **errp)
> +{
> +    RmeGuest *guest = RME_GUEST(obj);
> +
> +    guest->use_measurement_log = value;
> +}
> +
>   static void rme_guest_class_init(ObjectClass *oc, void *data)
>   {
>       object_class_property_add_str(oc, "personalization-value", rme_get_rpv,
> @@ -317,6 +685,12 @@ static void rme_guest_class_init(ObjectClass *oc, void *data)
>                                      rme_set_measurement_algo);
>       object_class_property_set_description(oc, "measurement-algorithm",
>               "Realm measurement algorithm ('sha256', 'sha512')");
> +
> +    object_class_property_add_bool(oc, "measurement-log",
> +                                   rme_get_measurement_log,
> +                                   rme_set_measurement_log);
> +    object_class_property_set_description(oc, "measurement-log",
> +            "Enable/disable Realm measurement log");
>   }
>   
>   static void rme_guest_init(Object *obj)
> @@ -359,6 +733,20 @@ static void rme_rom_load_notify(Notifier *notifier, void *data)
>       region = g_new0(RmeRamRegion, 1);
>       region->base = rom->addr;
>       region->size = rom->len;
> +    /*
> +     * TODO: double-check lifetime. Is data is still available when we measure
> +     * it, while writing the log. Should be fine since data is kept for the next
> +     * reset.
> +     */
> +    region->data = rom->data;
> +
> +    /*
> +     * rme_guest->images is destroyed after ram_regions, so we can store
> +     * filetype even if we don't own the struct.
> +     */
> +    if (rme_guest->images) {
> +        region->filetype = g_hash_table_lookup(rme_guest->images, rom->name);
> +    }
>   
>       /*
>        * The Realm Initial Measurement (RIM) depends on the order in which we
> @@ -388,6 +776,13 @@ int kvm_arm_rme_init(MachineState *ms)
>           return -ENODEV;
>       }
>   
> +    if (rme_init_measurement_log(ms)) {
> +        return -ENODEV;
> +    }
> +
> +    rme_guest->ram_size = ms->ram_size;
> +    rme_guest->num_cpus = ms->smp.max_cpus;
> +
>       error_setg(&rme_mig_blocker, "RME: migration is not implemented");
>       migrate_add_blocker(&rme_mig_blocker, &error_fatal);
>   
> @@ -430,3 +825,19 @@ int kvm_arm_rme_vm_type(MachineState *ms)
>       }
>       return 0;
>   }
> +
> +void kvm_arm_rme_set_ipa_size(uint8_t ipa_bits)
> +{
> +    if (rme_guest) {
> +        /* We request one more bit to KVM as the NS flag */
> +        rme_guest->ipa_bits = ipa_bits + 1;
> +    }
> +}
> +
> +Object *kvm_arm_rme_get_measurement_log(void)
> +{
> +    if (rme_guest) {
> +        return OBJECT(rme_guest->log);
> +    }
> +    return NULL;
> +}
> diff --git a/target/arm/Kconfig b/target/arm/Kconfig
> index 7f8a2217ae..ee3a2184d0 100644
> --- a/target/arm/Kconfig
> +++ b/target/arm/Kconfig
> @@ -13,3 +13,4 @@ config AARCH64
>       select ARM
>       # kvm_arch_fixup_msi_route() needs to access PCIDevice
>       select PCI if KVM
> +    select TPM_LOG if KVM


