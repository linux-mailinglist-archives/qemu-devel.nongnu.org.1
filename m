Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E09B19D147A
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Nov 2024 16:30:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD3hX-0005b7-M5; Mon, 18 Nov 2024 10:30:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1tD3hU-0005YY-B7; Mon, 18 Nov 2024 10:30:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1tD3hS-0004wy-73; Mon, 18 Nov 2024 10:30:04 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIF1NpN004413;
 Mon, 18 Nov 2024 15:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=EU0ovh
 V3vN31wxdarJyHfyV6Yp8wsj+9iBM8eaT2p3k=; b=hBiaj3GxEBYGbw3jcvDjCn
 jGl+E2iPvhekOi0E8XX1D+sF7syic+OLjJR7Xs6iR46L6b7nu4f9ydaISHVxRJC9
 ADY26964ZGsvt+zWM6jsysn82XGpfuklp/p39cAdLqVxqsFN23ss9WzFZ415C9tL
 eUW01HYoxAB4oS1owuTVIZ+CFOd2zxC+0lImkVaik/NJlNM5/UusF6188L21bXjS
 Ook08zF3CwLWjKkF/nPeCc9dhOQSIT+ushsJJrKXvS1WuekEGgTB0xtMkVe017p3
 OtDgwAMm3JIgsHIrgn/wOXTa8hmw0GqzrywOjamx/yKpvS+ZdukJbqooO/9IoA5w
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xk20t026-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Nov 2024 15:29:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIFPRg8000626;
 Mon, 18 Nov 2024 15:29:52 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42y77kn4p2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Nov 2024 15:29:52 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4AIFTp2v42074526
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Nov 2024 15:29:51 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7223058052;
 Mon, 18 Nov 2024 15:29:51 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA2F158056;
 Mon, 18 Nov 2024 15:29:50 +0000 (GMT)
Received: from [9.61.180.239] (unknown [9.61.180.239])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 18 Nov 2024 15:29:50 +0000 (GMT)
Message-ID: <ee20d61c-88a9-480f-be64-084f737ee976@linux.ibm.com>
Date: Mon, 18 Nov 2024 10:29:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw: Add "loadparm" property to scsi disk devices for
 booting on s390x
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Boris Fiuczynski <fiuczy@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Fam Zheng <fam@euphon.net>, Eric Farman <farman@linux.ibm.com>
References: <20241115141202.1877294-1-thuth@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20241115141202.1877294-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: h4Ofzrbm7tKybmNpjhzyk_E5qT_RTKq7
X-Proofpoint-GUID: h4Ofzrbm7tKybmNpjhzyk_E5qT_RTKq7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411180128
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Looks OK to me.

Reviewed-by Jared Rossi <jrossi@linux.ibm.com>

On 11/15/24 9:12 AM, Thomas Huth wrote:
> While adding the new flexible boot order feature on s390x recently,
> we missed to add the "loadparm" property to the scsi-hd and scsi-cd
> devices. This property is required on s390x to pass the information
> to the boot loader about which kernel should be started or whether
> the boot menu should be shown. But even more serious: The missing
> property is now causing trouble with the corresponding libvirt patches
> that assume that the "loadparm" property is either settable for all
> bootable devices (when the "boot order" feature is implemented in
> QEMU), or none (meaning the behaviour of older QEMUs that only allowed
> one "loadparm" at the machine level). To fix this broken situation,
> let's implement the "loadparm" property in for the SCSI devices, too.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v2:
>   - Only add the property when running with the s390x target
>     (checked via the arch_type variable during runtime)
>   - Check bootindex property before setting the loadparm property
>   - Call the sanitize function before setting the property, so we
>     can now immediately reject bad properties for the scsi devices,
>     too (had to move the sanitize function to the common code in
>     qdev-properties-system.c for this)
>
>   include/hw/qdev-properties-system.h |  3 ++
>   hw/core/qdev-properties-system.c    | 26 +++++++++++++++++
>   hw/s390x/ipl.c                      | 19 ++++---------
>   hw/scsi/scsi-disk.c                 | 43 +++++++++++++++++++++++++++++
>   4 files changed, 78 insertions(+), 13 deletions(-)
>
> diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properties-system.h
> index cdcc63056e..7ec37f6316 100644
> --- a/include/hw/qdev-properties-system.h
> +++ b/include/hw/qdev-properties-system.h
> @@ -3,6 +3,9 @@
>   
>   #include "hw/qdev-properties.h"
>   
> +bool qdev_prop_sanitize_s390x_loadparm(uint8_t *loadparm, const char *str,
> +                                       Error **errp);
> +
>   extern const PropertyInfo qdev_prop_chr;
>   extern const PropertyInfo qdev_prop_macaddr;
>   extern const PropertyInfo qdev_prop_reserved_region;
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> index 35deef05f3..a61c5ee6dd 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -58,6 +58,32 @@ static bool check_prop_still_unset(Object *obj, const char *name,
>       return false;
>   }
>   
> +bool qdev_prop_sanitize_s390x_loadparm(uint8_t *loadparm, const char *str,
> +                                       Error **errp)
> +{
> +    int i, len;
> +
> +    len = strlen(str);
> +    if (len > 8) {
> +        error_setg(errp, "'loadparm' can only contain up to 8 characters");
> +        return false;
> +    }
> +
> +    for (i = 0; i < len; i++) {
> +        uint8_t c = qemu_toupper(str[i]); /* mimic HMC */
> +
> +        if (qemu_isalnum(c) || c == '.' || c == ' ') {
> +            loadparm[i] = c;
> +        } else {
> +            error_setg(errp,
> +                       "invalid character in 'loadparm': '%c' (ASCII 0x%02x)",
> +                       c, c);
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
>   
>   /* --- drive --- */
>   
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index dc02b0fdda..30734661ad 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -418,21 +418,9 @@ static uint64_t s390_ipl_map_iplb_chain(IplParameterBlock *iplb_chain)
>   
>   void s390_ipl_fmt_loadparm(uint8_t *loadparm, char *str, Error **errp)
>   {
> -    int i;
> -
>       /* Initialize the loadparm with spaces */
>       memset(loadparm, ' ', LOADPARM_LEN);
> -    for (i = 0; i < LOADPARM_LEN && str[i]; i++) {
> -        uint8_t c = qemu_toupper(str[i]); /* mimic HMC */
> -
> -        if (qemu_isalnum(c) || c == '.' || c == ' ') {
> -            loadparm[i] = c;
> -        } else {
> -            error_setg(errp, "LOADPARM: invalid character '%c' (ASCII 0x%02x)",
> -                       c, c);
> -            return;
> -        }
> -    }
> +    qdev_prop_sanitize_s390x_loadparm(loadparm, str, errp);
>   }
>   
>   void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp)
> @@ -452,6 +440,7 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>       SCSIDevice *sd;
>       int devtype;
>       uint8_t *lp;
> +    g_autofree void *scsi_lp = NULL;
>   
>       /*
>        * Currently allow IPL only from CCW devices.
> @@ -463,6 +452,10 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>           switch (devtype) {
>           case CCW_DEVTYPE_SCSI:
>               sd = SCSI_DEVICE(dev_st);
> +            scsi_lp = object_property_get_str(OBJECT(sd), "loadparm", NULL);
> +            if (scsi_lp && strlen(scsi_lp) > 0) {
> +                lp = scsi_lp;
> +            }
>               iplb->len = cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
>               iplb->blk0_len =
>                   cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN - S390_IPLB_HEADER_LEN);
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index cb222da7a5..8e553487d5 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -32,6 +32,7 @@
>   #include "migration/vmstate.h"
>   #include "hw/scsi/emulation.h"
>   #include "scsi/constants.h"
> +#include "sysemu/arch_init.h"
>   #include "sysemu/block-backend.h"
>   #include "sysemu/blockdev.h"
>   #include "hw/block/block.h"
> @@ -111,6 +112,7 @@ struct SCSIDiskState {
>       char *vendor;
>       char *product;
>       char *device_id;
> +    char *loadparm;     /* only for s390x */
>       bool tray_open;
>       bool tray_locked;
>       /*
> @@ -3135,6 +3137,43 @@ BlockAIOCB *scsi_dma_writev(int64_t offset, QEMUIOVector *iov,
>       return blk_aio_pwritev(s->qdev.conf.blk, offset, iov, 0, cb, cb_opaque);
>   }
>   
> +static char *scsi_property_get_loadparm(Object *obj, Error **errp)
> +{
> +    return g_strdup(SCSI_DISK_BASE(obj)->loadparm);
> +}
> +
> +static void scsi_property_set_loadparm(Object *obj, const char *value,
> +                                       Error **errp)
> +{
> +    void *lp_str;
> +
> +    if (object_property_get_int(obj, "bootindex", NULL) < 0) {
> +        error_setg(errp, "'loadparm' is only valid for boot devices");
> +        return;
> +    }
> +
> +    lp_str = g_malloc0(strlen(value));
> +    if (!qdev_prop_sanitize_s390x_loadparm(lp_str, value, errp)) {
> +        g_free(lp_str);
> +        return;
> +    }
> +    SCSI_DISK_BASE(obj)->loadparm = lp_str;
> +}
> +
> +static void scsi_property_add_specifics(DeviceClass *dc)
> +{
> +    ObjectClass *oc = OBJECT_CLASS(dc);
> +
> +    /* The loadparm property is only supported on s390x */
> +    if (arch_type & QEMU_ARCH_S390X) {
> +        object_class_property_add_str(oc, "loadparm",
> +                                      scsi_property_get_loadparm,
> +                                      scsi_property_set_loadparm);
> +        object_class_property_set_description(oc, "loadparm",
> +                                              "load parameter (s390x only)");
> +    }
> +}
> +
>   static void scsi_disk_base_class_initfn(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -3218,6 +3257,8 @@ static void scsi_hd_class_initfn(ObjectClass *klass, void *data)
>       dc->desc = "virtual SCSI disk";
>       device_class_set_props(dc, scsi_hd_properties);
>       dc->vmsd  = &vmstate_scsi_disk_state;
> +
> +    scsi_property_add_specifics(dc);
>   }
>   
>   static const TypeInfo scsi_hd_info = {
> @@ -3258,6 +3299,8 @@ static void scsi_cd_class_initfn(ObjectClass *klass, void *data)
>       dc->desc = "virtual SCSI CD-ROM";
>       device_class_set_props(dc, scsi_cd_properties);
>       dc->vmsd  = &vmstate_scsi_disk_state;
> +
> +    scsi_property_add_specifics(dc);
>   }
>   
>   static const TypeInfo scsi_cd_info = {


