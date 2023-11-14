Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 478797EB50C
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 17:41:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2wTM-0008Hm-MP; Tue, 14 Nov 2023 11:41:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1r2wTF-0008H6-HG
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 11:41:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1r2wTC-0000Uh-74
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 11:41:01 -0500
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AEGeguG012197; Tue, 14 Nov 2023 16:40:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=FHVmxXSplurv0fh6098jHNfNMYn47QpwhCmPqSyqEu0=;
 b=P3bjfYzDLgm/wMSq5VEJfOdS9qNLzgApFoyakR6r9M1dD4EnHwEs0GaozynKDS6FHfVF
 Fnfw5V8awtYRVkbOJk38R4j4MCYDQTc00LsBeBSiaE9isdN5LYLt3UPqk8zSBMkxXOff
 fn00oXIwDNycVas6ozzrP6I9E1zZVlwzerAWPTvgKx0mS6PHcbYl7XwXYEXeL/xWGq0x
 kR8MTHyifFELCGRro4nWDBTooKXCRO1Jk28h1L4POIbYRaR13yK16JCgKFA3PvpM5gm0
 W75COLfEsTtmQMYtWfKFBfzjKLkDAHYsMkcz8AtSPACmD4+qXyXuBqRS+RvIzFYbqpno +g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucc97ghvv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Nov 2023 16:40:52 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AEGekmF012461;
 Tue, 14 Nov 2023 16:40:52 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucc97ghn7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Nov 2023 16:40:51 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AEGXwTl022348; Tue, 14 Nov 2023 16:37:14 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uap5k0q7s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Nov 2023 16:37:14 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AEGbDFs22282782
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Nov 2023 16:37:13 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B40BC5805F;
 Tue, 14 Nov 2023 16:37:13 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D54C058043;
 Tue, 14 Nov 2023 16:37:12 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Nov 2023 16:37:12 +0000 (GMT)
Message-ID: <865e5b38-0e83-4522-8d3e-410ba2394173@linux.ibm.com>
Date: Tue, 14 Nov 2023 11:37:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/14] tpm_crb: move ACPI table building to device
 interface
Content-Language: en-US
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20231114020927.62315-1-j@getutm.app>
 <20231114020927.62315-6-j@getutm.app>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231114020927.62315-6-j@getutm.app>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BBykVsgqtI9gLta8CbLlQtBIxV8wgacv
X-Proofpoint-GUID: yaN-puCsgV2gehDO9AG8ibEdFMgZ2t0-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_16,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311140127
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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



On 11/13/23 21:09, Joelle van Dyne wrote:
> This logic is similar to TPM TIS ISA device. Since TPM CRB can only
> support TPM 2.0 backends, we check for this in realize.
> 
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> ---
>   hw/tpm/tpm_crb.h        |  2 ++
>   hw/i386/acpi-build.c    | 16 +---------------
>   hw/tpm/tpm_crb.c        | 16 ++++++++++++++++
>   hw/tpm/tpm_crb_common.c | 19 +++++++++++++++++++
>   4 files changed, 38 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/tpm/tpm_crb.h b/hw/tpm/tpm_crb.h
> index 36863e1664..e6a86e3fd1 100644
> --- a/hw/tpm/tpm_crb.h
> +++ b/hw/tpm/tpm_crb.h
> @@ -73,5 +73,7 @@ void tpm_crb_init_memory(Object *obj, TPMCRBState *s, Error **errp);
>   void tpm_crb_mem_save(TPMCRBState *s, uint32_t *saved_regs, void *saved_cmdmem);
>   void tpm_crb_mem_load(TPMCRBState *s, const uint32_t *saved_regs,
>                         const void *saved_cmdmem);
> +void tpm_crb_build_aml(TPMIf *ti, Aml *scope, uint32_t baseaddr, uint32_t size,
> +                       bool build_ppi);
> 
>   #endif /* TPM_TPM_CRB_H */
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 80db183b78..7491cee2af 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1792,21 +1792,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> 
>   #ifdef CONFIG_TPM
>       if (TPM_IS_CRB(tpm)) {
> -        dev = aml_device("TPM");
> -        aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")));
> -        aml_append(dev, aml_name_decl("_STR",
> -                                      aml_string("TPM 2.0 Device")));
> -        crs = aml_resource_template();
> -        aml_append(crs, aml_memory32_fixed(TPM_CRB_ADDR_BASE,
> -                                           TPM_CRB_ADDR_SIZE, AML_READ_WRITE));
> -        aml_append(dev, aml_name_decl("_CRS", crs));
> -
> -        aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
> -        aml_append(dev, aml_name_decl("_UID", aml_int(1)));
> -
> -        tpm_build_ppi_acpi(tpm, dev);
> -
> -        aml_append(sb_scope, dev);
> +        call_dev_aml_func(DEVICE(tpm), scope);

For an x86_64 VM we have to call it directly otherwise the ACPI table 
won't be there.

         tpm_crb_build_aml(tpm, sb_scope, TPM_CRB_ADDR_BASE, 
TPM_CRB_ADDR_SIZE, true);



