Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE94A92D59
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Apr 2025 00:40:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5XtA-0005SN-IF; Thu, 17 Apr 2025 18:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1u5Xt7-0005S9-DU; Thu, 17 Apr 2025 18:39:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1u5Xt4-0004mn-69; Thu, 17 Apr 2025 18:39:17 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HLYgta021742;
 Thu, 17 Apr 2025 22:39:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=HreRWJ
 QZqhbXZUbOy3KzYldTlhVqy2Tzq1sAt/nbGUw=; b=rzm1ZczJGaGMi2jfCIqAYn
 pNcR8NO8RMeq3R3jZJtp39Kr1t1CVRLOfFRY6yNgbDTHSLVuZJIm4o4kJZzaf1JQ
 ffcsBmOvyMnyHmrZzs1GBThCMhQwVHwREagvOg5YgsYebX/kxU2clVN4+HkwkNlj
 j8Fahhrtp3qbggBtp2hbkjzZuUVx1N+wXKCI877loSeg/1S4n1PXRTzu3ap4xIVm
 7+Jub3cqb7e90CahOiJjAfPaUrXwiOe0sF8gfkb8Nmor699yqlUVguFM3j9e/udp
 kaJXi+v1H1yD5A8YOTTOx2odHSJ6bY8z5yGH0TKDQioxsUbWG/XCk36qu2rEEf6g
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46303ru6vr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Apr 2025 22:39:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53HJIgat016568;
 Thu, 17 Apr 2025 22:39:08 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 460572fkbf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Apr 2025 22:39:08 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53HMd6X030868182
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 22:39:07 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A91C25803F;
 Thu, 17 Apr 2025 22:39:06 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D68385805A;
 Thu, 17 Apr 2025 22:39:05 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 17 Apr 2025 22:39:05 +0000 (GMT)
Message-ID: <b8aa9eaa-ef96-4be9-b3e3-ccb46fead5a2@linux.ibm.com>
Date: Thu, 17 Apr 2025 18:39:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 17/24] pc-bios/s390-ccw: Add signature verification for
 secure boot in audit mode
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, pbonzini@redhat.com
Cc: jjherne@linux.ibm.com, jrossi@linux.ibm.com, fiuczy@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 iii@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250408155527.123341-1-zycai@linux.ibm.com>
 <20250408155527.123341-18-zycai@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <20250408155527.123341-18-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=C/bpyRP+ c=1 sm=1 tr=0 ts=6801830d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=sWKEhP36mHoA:10 a=VnNF1IyMAAAA:8
 a=oy77Bf7wdrC8YUNFCjAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: G0Cc_ux9oeMrtPQXaGXYDgWAU2wajoLF
X-Proofpoint-GUID: G0Cc_ux9oeMrtPQXaGXYDgWAU2wajoLF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_07,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170166
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 4/8/25 11:55 AM, Zhuoying Cai wrote:
> Enable secure IPL in audit mode, which performs signature verification,
> but any error does not terminate the boot process. Only warnings will be
> logged to the console instead.
> 
> Add a comp_len variable to store the length of a segment in
> zipl_load_segment. comp_len variable is necessary to store the
> calculated segment length and is used during signature verification.
> Return the length on success, or a negative return code on failure.
> 
> Secure IPL in audit mode requires at least one certificate provided in
> the key store along with necessary facilities (Secure IPL Facility,
> Certificate Store Facility and secure IPL extension support).
> 
> Note: Secure IPL in audit mode is implemented for the SCSI scheme of
> virtio-blk/virtio-scsi devices.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>

By the end of this patch series, the secure IPL related functions end up
comprising about 1/3 of the code in bootmap.c  Pretty neat :)  I think
that provides a good enough reason to house it all under its own roof,
if possible.  Maybe a pc-bios/s390-ccw/secure-ipl.c|h

It might make sense to put the diag320 & 508 code in there as well.
Please keep functions that relate to a specific facility grouped and
aptly named.

I ..think.. zipl_run_secure could go in there as well, not sure atm.

The print_func could be global to the file so you won't need to pass it
as a parameter to various functions.

> ---
>  pc-bios/s390-ccw/bootmap.c  | 344 +++++++++++++++++++++++++++++++++++-
>  pc-bios/s390-ccw/bootmap.h  |   9 +
>  pc-bios/s390-ccw/iplb.h     |  68 +++++++
>  pc-bios/s390-ccw/main.c     |   9 +
>  pc-bios/s390-ccw/s390-ccw.h |  10 ++
>  pc-bios/s390-ccw/sclp.c     |  43 +++++
>  pc-bios/s390-ccw/sclp.h     |   6 +
>  7 files changed, 486 insertions(+), 3 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index 4fb3e99f4b..bdbd6ccd96 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -30,6 +30,13 @@
>  
>  /* Scratch space */
>  static uint8_t sec[MAX_SECTOR_SIZE*4] __attribute__((__aligned__(PAGE_SIZE)));
> +/* sector for storing certificates */
> +static uint8_t certs_sec[CERT_MAX_SIZE * MAX_CERTIFICATES];
> +/* sector for storing signatures */
> +static uint8_t sig_sec[MAX_SECTOR_SIZE] __attribute__((__aligned__(PAGE_SIZE)));
> +
> +uint8_t vcb_data[MAX_SECTOR_SIZE * 4] __attribute__((__aligned__(PAGE_SIZE)));
> +uint8_t vcssb_data[VCSSB_MAX_LEN] __attribute__((__aligned__(PAGE_SIZE)));
>  
>  const uint8_t el_torito_magic[] = "EL TORITO SPECIFICATION"
>                                    "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0";
> @@ -622,6 +629,7 @@ static int zipl_load_segment(ComponentEntry *entry, uint64_t address)
>      int i;
>      char err_msg[] = "zIPL failed to read BPRS at 0xZZZZZZZZZZZZZZZZ";
>      char *blk_no = &err_msg[30]; /* where to print blockno in (those ZZs) */
> +    int comp_len = 0;
>  
>      blockno = entry->data.blockno;
>  
> @@ -660,6 +668,9 @@ static int zipl_load_segment(ComponentEntry *entry, uint64_t address)
>                   */
>                  break;
>              }
> +
> +            comp_len += (uint64_t)bprs->size * ((uint64_t)bprs[i].blockct + 1);
> +
>              address = virtio_load_direct(cur_desc[0], cur_desc[1], 0,
>                                           (void *)address);
>              if (!address) {
> @@ -669,6 +680,305 @@ static int zipl_load_segment(ComponentEntry *entry, uint64_t address)
>          }
>      } while (blockno);
>  
> +    return comp_len;

This changes the return behavior of the function without really
explaining it.  You refactor it in a previous patch.  I would suggest
making the comp_len change there and explain its significance in the
commit message.

> +}
> +
> +int get_vcssb(VerificationCertificateStorageSizeBlock *vcssb)
> +{
> +    int rc;
> +
> +    /* avoid retrieving vcssb multiple times */
> +    if (vcssb->length == VCSSB_MAX_LEN) {
> +        return 0;
> +    }
> +
> +    rc = diag320(vcssb, DIAG_320_SUBC_QUERY_VCSI);
> +    if (rc != DIAG_320_RC_OK) {
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static inline uint32_t request_certificate(uint64_t *cert, uint8_t index)
> +{
> +    VerificationCertificateStorageSizeBlock *vcssb;
> +    VerficationCertificateBlock *vcb;
> +    VerificationCertificateEntry *vce;
> +    uint64_t rc = 0;
> +    uint32_t cert_len = 0;
> +
> +    vcssb = (VerificationCertificateStorageSizeBlock *)vcssb_data;
> +    vcb = (VerficationCertificateBlock *)vcb_data;
> +
> +    /* Get Verification Certificate Storage Size block with DIAG320 subcode 1 */
> +    if (get_vcssb(vcssb)) {
> +        return 0;
> +    }
> +
> +    /*
> +     * Request single entry
> +     * Fill input fields of single-entry VCB
> +     */
> +    vcb->vcb_hdr.vcbinlen = ROUND_UP(vcssb->largestvcblen, PAGE_SIZE);
> +    vcb->vcb_hdr.fvci = index + 1;
> +    vcb->vcb_hdr.lvci = index + 1;
> +
> +    rc = diag320(vcb, DIAG_320_SUBC_STORE_VC);
> +    if (rc == DIAG_320_RC_OK) {
> +        vce = (VerificationCertificateEntry *)vcb->vcb_buf;
> +        cert_len = vce->vce_hdr.certlen;
> +        memcpy(cert, (uint8_t *)vce + vce->vce_hdr.certoffset, vce->vce_hdr.certlen);
> +        /* clear out region for next cert(s) */
> +        memcpy(vcb_data, 0, sizeof(vcb_data));
> +    }
> +
> +    return cert_len;
> +}
> +
> +static int cert_table_add(uint64_t **cert_table, uint64_t **cert,
> +                    uint64_t cert_len, uint8_t cert_idx)
> +{
> +    if (request_certificate(*cert, cert_idx)) {
> +        /* save certificate address to cert_table */
> +        cert_table[cert_idx] = *cert;
> +        /* update cert address for the next certificate */
> +        *cert += cert_len;
> +    } else {
> +        puts("Could not get certificate");
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static void cert_list_add(IplSignatureCertificateList *certs, int cert_index,
> +                   uint64_t *cert, uint64_t cert_len)
> +{
> +    if (cert_index > MAX_CERTIFICATES - 1) {
> +        printf("Warning: Ignoring cert entry [%d] because it's over 64 entires\n",
> +                cert_index + 1);
> +        return;
> +    }
> +
> +    certs->cert_entries[cert_index].addr = (uint64_t)cert;
> +    certs->cert_entries[cert_index].len = cert_len;
> +    certs->ipl_info_header.len += sizeof(certs->cert_entries[cert_index]);
> +}
> +
> +static void comp_list_add(IplDeviceComponentList *comps, int comp_index,
> +                   int cert_index, uint64_t comp_addr,
> +                   uint64_t comp_len, uint8_t flags)
> +{
> +    if (comp_index > MAX_CERTIFICATES - 1) {
> +        printf("Warning: Ignoring comp entry [%d] because it's over 64 entires\n",
> +                comp_index + 1);
> +        return;
> +    }
> +
> +    comps->device_entries[comp_index].addr = comp_addr;
> +    comps->device_entries[comp_index].len = comp_len;
> +    comps->device_entries[comp_index].flags = flags;
> +    comps->device_entries[comp_index].cert_index = cert_index;
> +    comps->ipl_info_header.len += sizeof(comps->device_entries[comp_index]);
> +}
> +
> +static int update_iirb(IplDeviceComponentList *comps, IplSignatureCertificateList *certs)
> +{
> +    IplInfoReportBlock *iirb;
> +    IplDeviceComponentList *comp_list;
> +    IplSignatureCertificateList *cert_list;
> +
> +    if (iplb->len % 8 != 0) {
> +        puts("IPL parameter block length field value is not multiple of 8 bytes");
> +        return -1;
> +    }

Shouldn't this have a greater consequence than return -1 and then the
caller assert/warn?  Also, you should add a check somewhere to ensure
there is enough space to hold all components and certs in the IIRB.

> +
> +    /* IIRB immediately follows IPLB */
> +    iirb = &ipl_data.iirb;
> +    iirb->hdr.len = sizeof(IplInfoReportBlockHeader);
> +
> +    /* Copy IPL device component list after IIRB Header */
> +    comp_list = (IplDeviceComponentList *) iirb->info_blks;
> +    memcpy(comp_list, comps, comps->ipl_info_header.len);

I think this would read better as iirb_comps

> +
> +    /* Update IIRB length */
> +    iirb->hdr.len += comps->ipl_info_header.len;
> +
> +    /* Copy IPL sig cert list after IPL device component list */
> +    cert_list = (IplSignatureCertificateList *) (iirb->info_blks +
> +                                                 comp_list->ipl_info_header.len);> +    memcpy(cert_list, certs, certs->ipl_info_header.len);

Same as above: iirb_certs

> +
> +    /* Update IIRB length */
> +    iirb->hdr.len += certs->ipl_info_header.len;
> +
> +    return 0;
> +}
> +
> +static bool secure_ipl_supported(void)
> +{
> +    if (!sclp_is_sipl_on()) {
> +        puts("Secure IPL Facility is not supported by the hypervisor!");
> +        return false;
> +    }
> +
> +    if (!is_secure_ipl_extension_supported()) {
> +        puts("Secure IPL extensions are not supported by the hypervisor!");
> +        return false;
> +    }
> +
> +    if (!(sclp_is_diag320_on() && is_cert_store_facility_supported())) {
> +        puts("Certificate Store Facility is not supported by the hypervisor!");
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static void init_lists(IplDeviceComponentList *comps, IplSignatureCertificateList *certs)
> +{
> +    comps->ipl_info_header.ibt = IPL_IBT_COMPONENTS;
> +    comps->ipl_info_header.len = sizeof(comps->ipl_info_header);
> +
> +    certs->ipl_info_header.ibt = IPL_IBT_CERTIFICATES;
> +    certs->ipl_info_header.len = sizeof(certs->ipl_info_header);
> +}
> +
> +static bool check_sig_entry(ComponentEntry *entry, uint32_t *sig_len)
> +{
> +    if ((entry + 1)->component_type != ZIPL_COMP_ENTRY_LOAD) {
> +        puts("Next component does not contain signed binary code");
> +        return false;
> +    }
> +
> +    if (zipl_load_segment(entry, (uint64_t)sig_sec) < 0) {
> +        return false;
> +    };
> +
> +    if (entry->compdat.sig_info.format != DER_SIGNATURE_FORMAT) {
> +        puts("Signature is not in DER format");
> +        return false;
> +    }
> +
> +    *sig_len = entry->compdat.sig_info.sig_len;
> +    return true;
> +}
> +
> +static int perform_sig_verf(uint64_t comp_addr, uint64_t comp_len, uint64_t sig_len,

/s/verf/verif

> +                           uint64_t *cert_table[], uint64_t **cert,
> +                           IplDeviceComponentList *comps,
> +                           IplSignatureCertificateList *certs,
> +                           int comp_index, int cert_index,
> +                           void (*print_func)(bool, const char *))
> +{
> +    uint64_t cert_len = -1;
> +    uint8_t cert_idx = -1;
> +    bool verified;
> +
> +    verified = verify_signature(comp_len, comp_addr, sig_len, (uint64_t)sig_sec,
> +                                &cert_len, &cert_idx);
> +
> +    if (verified) {
> +        if (cert_table[cert_idx] == 0) {
> +            if (cert_table_add(cert_table, cert, cert_len, cert_idx)) {
> +                return -1;
> +            }
> +        }
> +
> +        puts("Verified component");
> +        cert_list_add(certs, cert_index, cert_table[cert_idx], cert_len);
> +        comp_list_add(comps, comp_index, cert_index, comp_addr, comp_len,
> +                      S390_IPL_COMPONENT_FLAG_SC | S390_IPL_COMPONENT_FLAG_CSV);
> +    } else {
> +        comp_list_add(comps, comp_index, -1, comp_addr, comp_len,
> +                      S390_IPL_COMPONENT_FLAG_SC);
> +        print_func(verified, "Could not verify component");
> +    }
> +
> +    return 0;
> +}
> +
> +static int zipl_run_secure(ComponentEntry *entry, uint8_t *tmp_sec)
> +{
> +    bool found_signature = false;
> +    struct IplDeviceComponentList comps;
> +    struct IplSignatureCertificateList certs;
> +    uint64_t *cert = (uint64_t *)certs_sec;
> +    int cert_index = 0;
> +    int comp_index = 0;
> +    int comp_len;
> +    bool valid_sig;
> +    uint32_t sig_len;
> +    /*
> +     * Store address of certificate to prevent allocating
> +     * the same certificate multiple times.
> +     */
> +    uint64_t *cert_table[MAX_CERTIFICATES];

I'm not so sure if we necessarily need to store so much of the cert info
in a separate table in order to avoid duplication within the IIRB's cert
list.

Each component in the comp_list has a field indicating which cert in the
cert_list was used to verify it.  If the cert already exists in the
list, then we don't need to add it (in the case where a single cert was
used to verify multiple components).

Since the certs are index-based in the cert store, you could just keep a
table of which indices have already been added to the cert_list.  Then,
after diag508 returns the index of the cert used to verify,
cert_list_add just checks the index against the table.  If the cert was
already added, skip!  Otherwise, retrieve it and add it in.  Then store
the comp with the cert idx as you do.

> +
> +    void (*print_func)(bool, const char *) = NULL;
> +    print_func = &IPL_check;
> +
> +    if (!secure_ipl_supported()) {
> +        return -1;
> +    }
> +
> +    init_lists(&comps, &certs);
> +
> +    valid_sig = false;
> +    while (entry->component_type == ZIPL_COMP_ENTRY_LOAD ||
> +           entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
> +
> +        if (entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
> +            valid_sig = check_sig_entry(entry, &sig_len);
> +            if (!valid_sig) {
> +                return -1;
> +            }
> +        } else {
> +            comp_len = zipl_load_segment(entry, entry->compdat.load_addr);
> +            if (comp_len < 0) {
> +                return -1;
> +            }
> +
> +            if (valid_sig) {
> +                perform_sig_verf(entry->compdat.load_addr, comp_len, sig_len, cert_table,
> +                                 &cert, &comps, &certs, comp_index, cert_index,
> +                                 print_func);
> +
> +                cert_index++;
> +                found_signature = true;
> +                /*
> +                 * complete signature verification for current component,
> +                 * reset variable for the next signature entry.
> +                 */
> +                valid_sig = false;
> +            }
> +
> +            comp_index++;
> +        }
> +
> +        entry++;
> +
> +        if ((uint8_t *)(&entry[1]) > (tmp_sec + MAX_SECTOR_SIZE)) {
> +            puts("Wrong entry value");
> +            return -EINVAL;
> +        }
> +    }
> +
> +    if (entry->component_type != ZIPL_COMP_ENTRY_EXEC) {
> +        puts("No EXEC entry");
> +        return -EINVAL;
> +    }
> +
> +    if (!found_signature) {
> +        print_func(found_signature, "Secure boot is on, but components are not signed");
> +    }
> +
> +    if (update_iirb(&comps, &certs)) {
> +        print_func(false, "Failed to write IPL Information Report Block");
> +    }
> +    write_reset_psw(entry->compdat.load_psw);
> +
>      return 0;
>  }
>  
> @@ -683,7 +993,7 @@ static int zipl_run_normal(ComponentEntry *entry, uint8_t *tmp_sec)
>              continue;
>          }
>  
> -        if (zipl_load_segment(entry, entry->compdat.load_addr)) {
> +        if (zipl_load_segment(entry, entry->compdat.load_addr) < 0) {
>              return -1;
>          }
>  
> @@ -731,8 +1041,17 @@ static int zipl_run(ScsiBlockPtr *pte)
>      /* Load image(s) into RAM */
>      entry = (ComponentEntry *)(&header[1]);
>  
> -    if (zipl_run_normal(entry, tmp_sec)) {
> -        return -1;
> +    switch (boot_mode) {
> +    case ZIPL_SECURE_AUDIT_MODE:
> +        if (zipl_run_secure(entry, tmp_sec)) {
> +            return -1;
> +        }
> +        break;
> +    case ZIPL_NORMAL_MODE:
> +        if (zipl_run_normal(entry, tmp_sec)) {
> +            return -1;
> +        }
> +        break;
>      }
>  
>      /* should not return */
> @@ -1091,17 +1410,32 @@ static int zipl_load_vscsi(void)
>   * IPL starts here
>   */
>  
> +int zipl_mode(void)
> +{
> +    uint32_t cert_len;
> +
> +    cert_len = request_certificate((uint64_t *)certs_sec, 0);
> +
> +    return (cert_len > 0) ? ZIPL_SECURE_AUDIT_MODE : ZIPL_NORMAL_MODE;
> +}
> +

I think it will suffice to just check the iplb flags, as you do when you
enable secure mode.  IIUC, if only DIAG308_IPIB_FLAGS_IPLIR is set,
we're in audit mode.  If DIAG308_IPIB_FLAGS_SIPL is set as well, we're
in secure mode.  If neither are set, we're in "normal" mode.

If certs are missing by the time we get to signature-verification, then
that case should be handled accordingly at that time.

Hint: DIAG 508 has a return code for no certs found ;)

(though, DIAG 320 sc 1 has better inspection of the cert store -- handle
it however it make sense)

>  void zipl_load(void)
>  {
>      VDev *vdev = virtio_get_device();
>  
>      if (vdev->is_cdrom) {
> +        if (boot_mode == ZIPL_SECURE_AUDIT_MODE) {
> +            panic("Secure boot from ISO image is not supported!");
> +        }
>          ipl_iso_el_torito();
>          puts("Failed to IPL this ISO image!");
>          return;
>      }
>  
>      if (virtio_get_device_type() == VIRTIO_ID_NET) {
> +        if (boot_mode == ZIPL_SECURE_AUDIT_MODE) {
> +            panic("Virtio net boot device does not support secure boot!");
> +        }
>          netmain();
>          puts("Failed to IPL from this network!");
>          return;
> @@ -1112,6 +1446,10 @@ void zipl_load(void)
>          return;
>      }
>  
> +    if (boot_mode == ZIPL_SECURE_AUDIT_MODE) {
> +        panic("ECKD boot device does not support secure boot!");
> +    }
> +
>      switch (virtio_get_device_type()) {
>      case VIRTIO_ID_BLOCK:
>          zipl_load_vblk();
> diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
> index 95943441d3..e48823a835 100644
> --- a/pc-bios/s390-ccw/bootmap.h
> +++ b/pc-bios/s390-ccw/bootmap.h
> @@ -88,9 +88,18 @@ typedef struct BootMapTable {
>      BootMapPointer entry[];
>  } __attribute__ ((packed)) BootMapTable;
>  
> +#define DER_SIGNATURE_FORMAT 1
> +
> +typedef struct SignatureInformation {
> +    uint8_t format;
> +    uint8_t reserved[3];
> +    uint32_t sig_len;
> +} __attribute__((packed)) SignatureInformation;
> +
>  typedef union ComponentEntryData {
>      uint64_t load_psw;
>      uint64_t load_addr;
> +    SignatureInformation sig_info;
>  } ComponentEntryData;
>  
>  typedef struct ComponentEntry {
> diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
> index 11302e004d..8d9fdde30a 100644
> --- a/pc-bios/s390-ccw/iplb.h
> +++ b/pc-bios/s390-ccw/iplb.h
> @@ -16,12 +16,15 @@
>  #define QEMU_PACKED __attribute__((packed))
>  #endif
>  
> +#include <diag320.h>
> +#include <diag508.h>
>  #include <qipl.h>
>  #include <string.h>
>  
>  extern QemuIplParameters qipl;
>  extern IplParameterBlock *iplb;
>  extern bool have_iplb;
> +extern int boot_mode;
>  
>  struct IplInfoReportBlockHeader {
>      uint32_t len;
> @@ -143,4 +146,69 @@ static inline bool load_next_iplb(void)
>      return true;
>  }
>  
> +static inline uint64_t diag320(void *data, unsigned long subcode)
> +{
> +    register unsigned long addr asm("0") = (unsigned long)data;
> +    register unsigned long rc asm("1") = 0;
> +
> +    asm volatile ("diag %0,%2,0x320\n"
> +                  : "+d" (addr), "+d" (rc)
> +                  : "d" (subcode)
> +                  : "memory", "cc");
> +    return rc;
> +}
> +
> +static inline uint64_t get_320_subcodes(uint64_t *ism)
> +{
> +    return diag320(ism, DIAG_320_SUBC_QUERY_ISM);
> +}
> +
> +static inline bool is_cert_store_facility_supported(void)
> +{
> +    uint64_t d320_ism;
> +    get_320_subcodes(&d320_ism);
> +    return (d320_ism & DIAG_320_ISM_QUERY_VCSI) &&
> +           (d320_ism & DIAG_320_ISM_STORE_VC);
> +}
> +
> +static inline uint64_t _diag508(void *data, unsigned long subcode)
> +{
> +    register unsigned long addr asm("0") = (unsigned long)data;
> +    register unsigned long rc asm("1") = 0;
> +
> +    asm volatile ("diag %0,%2,0x508\n"
> +                  : "+d" (addr), "+d" (rc)
> +                  : "d" (subcode)
> +                  : "memory", "cc");
> +    return rc;
> +}
> +
> +static inline uint64_t get_508_subcodes(void)
> +{
> +    return _diag508(NULL, DIAG_508_SUBC_QUERY_SUBC);
> +}
> +
> +static inline bool is_secure_ipl_extension_supported(void)
> +{
> +    uint64_t d508_subcodes;
> +
> +    d508_subcodes = get_508_subcodes();
> +    return d508_subcodes & DIAG_508_SUBC_SIG_VERIF;
> +}
> +
> +static inline bool verify_signature(uint64_t comp_len, uint64_t comp_addr,
> +                                    uint64_t sig_len, uint64_t sig_addr,
> +                                    uint64_t *cert_len, uint8_t *cert_idx)
> +{
> +    Diag508SignatureVerificationBlock svb = {{}, comp_len, comp_addr,
> +                                             sig_len, sig_addr };
> +
> +    if (_diag508(&svb, DIAG_508_SUBC_SIG_VERIF) == DIAG_508_RC_OK) {
> +        *cert_len = svb.csi.len;
> +        *cert_idx = svb.csi.idx;
> +        return true;
> +    }
> +    return false;
> +}
> +
>  #endif /* IPLB_H */
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index c9328f1c51..92004a6f82 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -28,6 +28,7 @@ IplParameterBlock *iplb;
>  bool have_iplb;
>  static uint16_t cutype;
>  LowCore *lowcore; /* Yes, this *is* a pointer to address 0 */
> +int boot_mode;
>  
>  #define LOADPARM_PROMPT "PROMPT  "
>  #define LOADPARM_EMPTY  "        "
> @@ -272,9 +273,17 @@ static int virtio_setup(void)
>  
>  static void ipl_boot_device(void)
>  {
> +    if (boot_mode == 0) {
> +        boot_mode = zipl_mode();
> +    }
> +
>      switch (cutype) {
>      case CU_TYPE_DASD_3990:
>      case CU_TYPE_DASD_2107:
> +        if (boot_mode == ZIPL_SECURE_AUDIT_MODE) {
> +            panic("Passthrough (vfio) device does not support secure boot!");
> +        }
> +
>          dasd_ipl(blk_schid, cutype);
>          break;
>      case CU_TYPE_VIRTIO:
> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index 6cdce3e5e5..68ffbf7bc8 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -39,6 +39,9 @@ typedef unsigned long long u64;
>  #define MIN_NON_ZERO(a, b) ((a) == 0 ? (b) : \
>                              ((b) == 0 ? (a) : (MIN(a, b))))
>  #endif
> +#ifndef ROUND_UP
> +#define ROUND_UP(n, d) (((n) + (d) - 1) & -(0 ? (n) : (d)))
> +#endif
>  
>  #define ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))
>  
> @@ -64,6 +67,8 @@ void sclp_print(const char *string);
>  void sclp_set_write_mask(uint32_t receive_mask, uint32_t send_mask);
>  void sclp_setup(void);
>  void sclp_get_loadparm_ascii(char *loadparm);
> +bool sclp_is_diag320_on(void);
> +bool sclp_is_sipl_on(void);
>  int sclp_read(char *str, size_t count);
>  
>  /* virtio.c */
> @@ -76,6 +81,11 @@ int virtio_read(unsigned long sector, void *load_addr);
>  /* bootmap.c */
>  void zipl_load(void);
>  
> +#define ZIPL_NORMAL_MODE           1
> +#define ZIPL_SECURE_AUDIT_MODE     2
> +
> +int zipl_mode(void);

I think this would look better as an enum:

enum ZiplBootMode {
	ZIPL_BOOT_INVALID = -1
	ZIPL_BOOT_NORMAL  = 1,
	ZIPL_BOOT_AUDIT   = 2,
	ZIPL_BOOT_SECURE  = 3, (later patch)
};

or something like that.

zipl_mode should return a ZiplBootMode

> +
>  /* jump2ipl.c */
>  void write_reset_psw(uint64_t psw);
>  int jump_to_IPL_code(uint64_t address);
> diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
> index 4a07de018d..fd25c83387 100644
> --- a/pc-bios/s390-ccw/sclp.c
> +++ b/pc-bios/s390-ccw/sclp.c
> @@ -113,6 +113,49 @@ void sclp_get_loadparm_ascii(char *loadparm)
>      }
>  }
>  
> +static void sclp_get_fac134(uint8_t *fac134)
> +{
> +
> +    ReadInfo *sccb = (void *)_sccb;
> +
> +    memset((char *)_sccb, 0, sizeof(ReadInfo));
> +    sccb->h.length = SCCB_SIZE;
> +    if (!sclp_service_call(SCLP_CMDW_READ_SCP_INFO, sccb)) {
> +        *fac134 = sccb->fac134;
> +    }
> +}
> +
> +bool sclp_is_diag320_on(void)
> +{
> +    uint8_t fac134 = 0;
> +
> +    sclp_get_fac134(&fac134);
> +    return fac134 & SCCB_FAC134_DIAG320_BIT;
> +}
> +
> +/*
> + * Get cbl (byte 136 and byte 137 of the SCLP Read Info block) for IPL device facilities.
> + */
> +static void sclp_get_cbl(uint16_t *cbl)
> +{
> +
> +    ReadInfo *sccb = (void *)_sccb;
> +
> +    memset((char *)_sccb, 0, sizeof(ReadInfo));
> +    sccb->h.length = SCCB_SIZE;
> +    if (!sclp_service_call(SCLP_CMDW_READ_SCP_INFO, sccb)) {
> +        *cbl = sccb->cbl;
> +    }
> +}
> +
> +bool sclp_is_sipl_on(void)
> +{
> +    uint16_t cbl = 0;
> +
> +    sclp_get_cbl(&cbl);
> +    return cbl & SCCB_CBL_SIPL_BIT;
> +}
> +
>  int sclp_read(char *str, size_t count)
>  {
>      ReadEventData *sccb = (void *)_sccb;
> diff --git a/pc-bios/s390-ccw/sclp.h b/pc-bios/s390-ccw/sclp.h
> index 64b53cad29..de4141cb86 100644
> --- a/pc-bios/s390-ccw/sclp.h
> +++ b/pc-bios/s390-ccw/sclp.h
> @@ -50,6 +50,8 @@ typedef struct SCCBHeader {
>  } __attribute__((packed)) SCCBHeader;
>  
>  #define SCCB_DATA_LEN (SCCB_SIZE - sizeof(SCCBHeader))
> +#define SCCB_FAC134_DIAG320_BIT 0x4
> +#define SCCB_CBL_SIPL_BIT 0x4000
>  
>  typedef struct ReadInfo {
>      SCCBHeader h;
> @@ -57,6 +59,10 @@ typedef struct ReadInfo {
>      uint8_t rnsize;
>      uint8_t reserved[13];
>      uint8_t loadparm[LOADPARM_LEN];
> +    uint8_t reserved1[102];
> +    uint8_t fac134;
> +    uint8_t reserved2;
> +    uint16_t cbl;
>  } __attribute__((packed)) ReadInfo;
>  
>  typedef struct SCCB {


-- 
Regards,
  Collin

