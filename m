Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B57B3A79A
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Aug 2025 19:17:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgEo-0008Jo-Ik; Thu, 28 Aug 2025 13:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1ureJP-0006tT-MC; Thu, 28 Aug 2025 11:13:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1ureJK-0005m5-Fx; Thu, 28 Aug 2025 11:13:14 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SEDUr0003853;
 Thu, 28 Aug 2025 15:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=6VdeKx
 HHHjr9ePiG5vUrvIUATeQcd9Mtpb60bh5hNq4=; b=oqFvKd/e+0KewztbCkQrpg
 FJCdGABYU4I7SCgOURB540ihK2fD+U1ZnMz211fs7Jhszag+pkN5GhCY+Je+iyki
 /bny6INoNdxpj0V1mtL1ww+vyOPywqnWoCPRvYJ0RY5KPos+UNM1ow+8hxcFS8l0
 nTWbbD5cs/b0GdLKXhT8MfyRTFLxajMcDz5tmbruqmexb3iXO1Z/Gb8gK2b4sXMq
 OpoYi36rPPZOiqq08hiA/1N7V9OmvFG3wr7zi9T5nOOIBFpWepYj8wg8gVto50o5
 UZj/BNmytytPOL5xKEKoG7KI8F4TpjPisG1iLXvcqnz8IGUO9MvUMW7ZYbaY8q9w
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q558arcm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 Aug 2025 15:13:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57SDLhHv002543;
 Thu, 28 Aug 2025 15:13:02 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48qrypwhsn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 Aug 2025 15:13:02 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57SFD0FZ3015338
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Aug 2025 15:13:01 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC19358066;
 Thu, 28 Aug 2025 15:13:00 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 241EE58055;
 Thu, 28 Aug 2025 15:12:59 +0000 (GMT)
Received: from [9.61.75.179] (unknown [9.61.75.179])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 28 Aug 2025 15:12:59 +0000 (GMT)
Message-ID: <3b4eed66-f2fa-4a09-9e89-342a71547acd@linux.ibm.com>
Date: Thu, 28 Aug 2025 11:12:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/29] s390x/diag: Implement DIAG 320 subcode 2
To: Jared Rossi <jrossi@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com
References: <20250818214323.529501-1-zycai@linux.ibm.com>
 <20250818214323.529501-10-zycai@linux.ibm.com>
 <a78032c2-28c8-44e6-9b33-36035e75393a@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <a78032c2-28c8-44e6-9b33-36035e75393a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: x7X2Xfrg2kdD5-d41J-aT9JcjhoFUGtr
X-Proofpoint-ORIG-GUID: x7X2Xfrg2kdD5-d41J-aT9JcjhoFUGtr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyMSBTYWx0ZWRfX6+BRad8tixrm
 h0XL9UUBITY9D5g/rMOQcmnkTBr4a9UR281RN4VxjDTzrJP3dTSBvn7kwdb/gLOIrRDDe+IPhaL
 Tc6XMp3zYSj0iHZkFWrcFUT05zj8AZptKjyow6ixTmg7LTsUf9d5c14ZqRqQLtks0gXBb7tmzSL
 3zk2OxS0nXFZaYC6eNexjzMu0HQ0sl5ZFQSdVFxB1jcv4iNBeiuzgBw+Wind9s+m8P9Zq2MhWgF
 AGjDd3zKSg0on9tydoVPt74MMsCetACuCBG96FTa60PGDtcMd4QgsJ5SiMYBLqp5sLmI+fScCr4
 ch8HXBb7TosD6hcSrGoZnEwm2WWovisAkSHyPaJGVfoGvFwEqi9eNZMSj3UYsB3Do0NI8GZ176Y
 falNgznl
X-Authority-Analysis: v=2.4 cv=A8ZsP7WG c=1 sm=1 tr=0 ts=68b071ff cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=ne0RqYv0KoaLZF6PVbgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230021
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 8/27/25 10:35 AM, Jared Rossi wrote:
> 
> On 8/18/25 5:43 PM, Zhuoying Cai wrote:
>> DIAG 320 subcode 2 provides verification-certificates (VCs) that are in the
>> certificate store. Only X509 certificates in DER format and SHA-256 hash
>> type are recognized.
>>
>> The subcode value is denoted by setting the second-left-most bit
>> of an 8-byte field.
>>
>> The Verification Certificate Block (VCB) contains the output data
>> when the operation completes successfully. It includes a common
>> header followed by zero or more Verification Certificate Entries (VCEs),
>> depending on the VCB input length and the VC range (from the first VC
>> index to the last VC index) in the certificate store.
>>
>> Each VCE contains information about a certificate retrieved from
>> the S390IPLCertificateStore, such as the certificate name, key type,
>> key ID length, hash length, and the raw certificate data.
>> The key ID and hash are extracted from the raw certificate by the crypto API.
>>
>> Note: SHA2-256 VC hash type is required for retrieving the hash
>> (fingerprint) of the certificate.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
>>   docs/specs/s390x-secure-ipl.rst |  13 ++
>>   include/hw/s390x/ipl/diag320.h  |  49 ++++++
>>   target/s390x/diag.c             | 286 +++++++++++++++++++++++++++++++-
>>   3 files changed, 347 insertions(+), 1 deletion(-)
>>
> [snip...]
>> +static VCEntry *diag_320_build_vce(S390IPLCertificate qcert, uint32_t vce_len, int idx)
>> +{
>> +    g_autofree VCEntry *vce = NULL;
>> +    int rc;
>> +
>> +    /*
>> +     * Construct VCE
>> +     * Allocate enough memory for all certificate data (key id, hash and certificate).
>> +     * Unused area following the VCE field contains zeros.
>> +     */
>> +    vce = g_malloc0(vce_len);
>> +    rc = build_vce_header(vce, qcert, idx);
>> +    if (rc) {
>> +        vce->len = cpu_to_be32(VCE_INVALID_LEN);
>> +        goto out;
>> +    }
>> +    vce->len = cpu_to_be32(VCE_HEADER_LEN);
>> +
>> +    rc = build_vce_data(vce, qcert);
>> +    if (rc) {
>> +        vce->len = cpu_to_be32(VCE_INVALID_LEN);
>> +    }
>> +
>> +out:
>> +    return g_steal_pointer(&vce);
>> +}
>> +
>> +static int handle_diag320_store_vc(S390CPU *cpu, uint64_t addr, uint64_t r1, uintptr_t ra,
>> +                                   S390IPLCertificateStore *qcs)
>> +{
>> +    g_autofree VCBlock *vcb = NULL;
>> +    size_t vce_offset;
>> +    size_t remaining_space;
>> +    uint32_t vce_len;
>> +    uint16_t first_vc_index;
>> +    uint16_t last_vc_index;
>> +    uint32_t in_len;
>> +
>> +    vcb = g_new0(VCBlock, 1);
>> +    if (s390_cpu_virt_mem_read(cpu, addr, r1, vcb, sizeof(*vcb))) {
>> +        s390_cpu_virt_mem_handle_exc(cpu, ra);
>> +        return -1;
>> +    }
>> +
>> +    in_len = be32_to_cpu(vcb->in_len);
>> +    first_vc_index = be16_to_cpu(vcb->first_vc_index);
>> +    last_vc_index = be16_to_cpu(vcb->last_vc_index);
>> +
>> +    if (in_len % TARGET_PAGE_SIZE != 0) {
>> +        return DIAG_320_RC_INVAL_VCB_LEN;
>> +    }
>> +
>> +    if (first_vc_index > last_vc_index) {
>> +        return DIAG_320_RC_BAD_RANGE;
>> +    }
>> +
>> +    if (first_vc_index == 0) {
>> +        /*
>> +         * Zero is a valid index for the first and last VC index.
>> +         * Zero index results in the VCB header and zero certificates returned.
>> +         */
>> +        if (last_vc_index == 0) {
>> +            goto out;
>> +        }
>> +
>> +        /* DIAG320 certificate store remains a one origin for cert entries */
>> +        vcb->first_vc_index = 1;
>> +        first_vc_index = 1;
>> +    }
>> +
>> +    vce_offset = VCB_HEADER_LEN;
>> +    vcb->out_len = VCB_HEADER_LEN;
>> +    remaining_space = in_len - VCB_HEADER_LEN;
>> +
>> +    for (int i = first_vc_index - 1; i < last_vc_index && i < qcs->count; i++) {
>> +        VCEntry *vce;
>> +        S390IPLCertificate qcert = qcs->certs[i];
>> +        /*
>> +         * Each VCE is word aligned.
>> +         * Each variable length field within the VCE is also word aligned.
>> +         */
>> +        vce_len = VCE_HEADER_LEN +
>> +                  ROUND_UP(qcert.key_id_size, 4) +
>> +                  ROUND_UP(qcert.hash_size, 4) +
>> +                  ROUND_UP(qcert.der_size, 4);
>> +
>> +        /*
>> +         * If there is no more space to store the cert,
>> +         * set the remaining verification cert count and
>> +         * break early.
>> +         */
>> +        if (remaining_space < vce_len) {
>> +            vcb->remain_ct = cpu_to_be16(last_vc_index - i);
>> +            break;
>> +        }
> What is the significance of remain_ct != 0?
> 
> Should there be an error or warning that there was not enough space?
> 

remain_ct != 0 indicates insufficient memory to acquire all requested
certificates.

I'll add a check in the caller function and report an error if not all
certificates can be retrieved.

>> +
>> +        vce = diag_320_build_vce(qcert, vce_len, i);
>> +
>> +        /* Write VCE */
>> +        if (s390_cpu_virt_mem_write(cpu, addr + vce_offset, r1,
>> +                                    vce, be32_to_cpu(vce->len))) {
>> +            s390_cpu_virt_mem_handle_exc(cpu, ra);
>> +            return -1;
> Missing vce free in this early return?
> 
>> +        }
>> +
>> +        vce_offset += be32_to_cpu(vce->len);
>> +        vcb->out_len += be32_to_cpu(vce->len);
>> +        remaining_space -= be32_to_cpu(vce->len);
>> +        vcb->stored_ct++;
>> +
>> +        g_free(vce);
>> +    }
>> +
>> +    vcb->out_len = cpu_to_be32(vcb->out_len);
>> +    vcb->stored_ct = cpu_to_be16(vcb->stored_ct);
>> +
>> +out:
>> +    /*
>> +     * Write VCB header
>> +     * All VCEs have been populated with the latest information
>> +     * and write VCB header last.
>> +     */
>> +    if (s390_cpu_virt_mem_write(cpu, addr, r1, vcb, VCB_HEADER_LEN)) {
>> +        s390_cpu_virt_mem_handle_exc(cpu, ra);
>> +        return -1;
>> +    }
>> +
>> +    return DIAG_320_RC_OK;
>> +}
>> +
>>   void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>>   {
>>       S390CPU *cpu = env_archcpu(env);
>> @@ -256,7 +532,8 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>>            * for now.
>>            */
>>           uint32_t ism_word0 = cpu_to_be32(DIAG_320_ISM_QUERY_SUBCODES |
>> -                                         DIAG_320_ISM_QUERY_VCSI);
>> +                                         DIAG_320_ISM_QUERY_VCSI |
>> +                                         DIAG_320_ISM_STORE_VC);
>>   
>>           if (s390_cpu_virt_mem_write(cpu, addr, r1, &ism_word0, sizeof(ism_word0))) {
>>               s390_cpu_virt_mem_handle_exc(cpu, ra);
>> @@ -282,6 +559,13 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>>           }
>>           env->regs[r1 + 1] = rc;
>>           break;
>> +    case DIAG_320_SUBC_STORE_VC:
>> +        rc = handle_diag320_store_vc(cpu, addr, r1, ra, qcs);
>> +        if (rc == -1) {
>> +            return;
>> +        }
>> +        env->regs[r1 + 1] = rc;
>> +        break;
>>       default:
>>           env->regs[r1 + 1] = DIAG_320_RC_NOT_SUPPORTED;
>>           break;
> Regards,
> Jared Rossi


