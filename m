Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6577782AEB6
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 13:30:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNuBX-0001hz-8P; Thu, 11 Jan 2024 07:29:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1rNuBJ-0001fy-MR; Thu, 11 Jan 2024 07:29:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1rNuBG-0004UK-3X; Thu, 11 Jan 2024 07:29:08 -0500
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40BBQ2vN025234; Thu, 11 Jan 2024 12:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=OKcrZriGKAxo+iCbxagusfHYXftsmf9ma3py7OBimVk=;
 b=MdgbEikdpN4t+qGnjDd1ok8IvNhPuZb6Zv9dDGnzlbqaGQQVtcG+fgDV+EzM9adbuGu9
 lhHT+uv5Z5MrYnOb4ntLhq0k2xXRfzO3CnxlnQxu+lBJbspccDAqcTKnJuaJtItyLQ93
 x57cyvEjiVuFQ5+kIgNLD3HfiTvkCBXbP76FGcjKdNbuhg72A3jJUWkdf1uQPTYp9Nak
 DMPO4+IwdX52V3qfi/IwrVFl8OxL8+IvzJDWf4S+42I1wF495+cLjquiedOVX7mAoT+m
 bk0funTKfKupbi/Fes506ZS7vhdkGiYZo7wx6is14MkLIuzRPDba4jErUwIwe4bI8xbX Zg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vjbc57hjv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jan 2024 12:29:01 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40BCFebY014653;
 Thu, 11 Jan 2024 12:29:01 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vjbc57hjg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jan 2024 12:29:01 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40BAPCMS026999; Thu, 11 Jan 2024 12:29:00 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vfkw2awqf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jan 2024 12:29:00 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40BCSvRJ25887304
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Jan 2024 12:28:57 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 431D42004E;
 Thu, 11 Jan 2024 12:28:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 15C952004B;
 Thu, 11 Jan 2024 12:28:57 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 11 Jan 2024 12:28:57 +0000 (GMT)
Date: Thu, 11 Jan 2024 13:28:55 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Janosch
 Frank <frankja@linux.ibm.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clegoate@redhat.com>, qemu-devel@nongnu.org, Halil Pasic
 <pasic@linux.ibm.com>
Subject: Re: [PATCH v2] target/s390x/kvm/pv: Provide some more useful
 information if decryption fails
Message-ID: <20240111132855.0421878d@p-imbrenda>
In-Reply-To: <20240110142916.850605-1-thuth@redhat.com>
References: <20240110142916.850605-1-thuth@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -t1HPBBRlqqcyxKa34JxKMSZz7MNh3h7
X-Proofpoint-GUID: S5Sn8OSox0WNleOANY1ao64vD9MSIK_w
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_06,2024-01-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401110099
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=imbrenda@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On Wed, 10 Jan 2024 15:29:16 +0100
Thomas Huth <thuth@redhat.com> wrote:

> It's a common scenario to copy guest images from one host to another
> to run the guest on the other machine. This (of course) does not work
> with "secure exection" guests since they are encrypted with one certain

*execution

with that fixed:

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> host key. However, if you still (accidentally) do it, you only get a
> very user-unfriendly error message that looks like this:
> 
>  qemu-system-s390x: KVM PV command 2 (KVM_PV_SET_SEC_PARMS) failed:
>   header rc 108 rrc 5 IOCTL rc: -22
> 
> Let's provide at least a somewhat nicer hint to the users so that they
> are able to figure out what might have gone wrong.
> 
> Buglink: https://issues.redhat.com/browse/RHEL-18212
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Print the error in s390_machine_protect() instead of doing it
>      in s390_pv_set_sec_parms(), report the text via Error **errp
> 
>  hw/s390x/ipl.h             |  2 +-
>  target/s390x/kvm/pv.h      |  2 +-
>  hw/s390x/ipl.c             |  5 ++---
>  hw/s390x/s390-virtio-ccw.c |  5 ++++-
>  target/s390x/kvm/pv.c      | 25 ++++++++++++++++++++-----
>  5 files changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index 7fc86e7905..57cd125769 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -107,7 +107,7 @@ typedef union IplParameterBlock IplParameterBlock;
>  
>  int s390_ipl_set_loadparm(uint8_t *loadparm);
>  void s390_ipl_update_diag308(IplParameterBlock *iplb);
> -int s390_ipl_prepare_pv_header(void);
> +int s390_ipl_prepare_pv_header(Error **errp);
>  int s390_ipl_pv_unpack(void);
>  void s390_ipl_prepare_cpu(S390CPU *cpu);
>  IplParameterBlock *s390_ipl_get_iplb(void);
> diff --git a/target/s390x/kvm/pv.h b/target/s390x/kvm/pv.h
> index 7b935e2246..fca373a826 100644
> --- a/target/s390x/kvm/pv.h
> +++ b/target/s390x/kvm/pv.h
> @@ -42,7 +42,7 @@ int s390_pv_query_info(void);
>  int s390_pv_vm_enable(void);
>  void s390_pv_vm_disable(void);
>  bool s390_pv_vm_try_disable_async(S390CcwMachineState *ms);
> -int s390_pv_set_sec_parms(uint64_t origin, uint64_t length);
> +int s390_pv_set_sec_parms(uint64_t origin, uint64_t length, Error **errp);
>  int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak);
>  void s390_pv_prep_reset(void);
>  int s390_pv_verify(void);
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 76110e8f58..e934bf89d1 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -702,7 +702,7 @@ static void s390_ipl_prepare_qipl(S390CPU *cpu)
>      cpu_physical_memory_unmap(addr, len, 1, len);
>  }
>  
> -int s390_ipl_prepare_pv_header(void)
> +int s390_ipl_prepare_pv_header(Error **errp)
>  {
>      IplParameterBlock *ipib = s390_ipl_get_iplb_pv();
>      IPLBlockPV *ipib_pv = &ipib->pv;
> @@ -711,8 +711,7 @@ int s390_ipl_prepare_pv_header(void)
>  
>      cpu_physical_memory_read(ipib_pv->pv_header_addr, hdr,
>                               ipib_pv->pv_header_len);
> -    rc = s390_pv_set_sec_parms((uintptr_t)hdr,
> -                               ipib_pv->pv_header_len);
> +    rc = s390_pv_set_sec_parms((uintptr_t)hdr, ipib_pv->pv_header_len, errp);
>      g_free(hdr);
>      return rc;
>  }
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 1169e20b94..eaf61d3640 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -391,7 +391,7 @@ static int s390_machine_protect(S390CcwMachineState *ms)
>      }
>  
>      /* Set SE header and unpack */
> -    rc = s390_ipl_prepare_pv_header();
> +    rc = s390_ipl_prepare_pv_header(&local_err);
>      if (rc) {
>          goto out_err;
>      }
> @@ -410,6 +410,9 @@ static int s390_machine_protect(S390CcwMachineState *ms)
>      return rc;
>  
>  out_err:
> +    if (local_err) {
> +        error_report_err(local_err);
> +    }
>      s390_machine_unprotect(ms);
>      return rc;
>  }
> diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
> index 6a69be7e5c..7ca7faec73 100644
> --- a/target/s390x/kvm/pv.c
> +++ b/target/s390x/kvm/pv.c
> @@ -29,7 +29,8 @@ static bool info_valid;
>  static struct kvm_s390_pv_info_vm info_vm;
>  static struct kvm_s390_pv_info_dump info_dump;
>  
> -static int __s390_pv_cmd(uint32_t cmd, const char *cmdname, void *data)
> +static int __s390_pv_cmd(uint32_t cmd, const char *cmdname, void *data,
> +                         int *pvrc)
>  {
>      struct kvm_pv_cmd pv_cmd = {
>          .cmd = cmd,
> @@ -46,6 +47,9 @@ static int __s390_pv_cmd(uint32_t cmd, const char *cmdname, void *data)
>                       "IOCTL rc: %d", cmd, cmdname, pv_cmd.rc, pv_cmd.rrc,
>                       rc);
>      }
> +    if (pvrc) {
> +        *pvrc = pv_cmd.rc;
> +    }
>      return rc;
>  }
>  
> @@ -53,12 +57,13 @@ static int __s390_pv_cmd(uint32_t cmd, const char *cmdname, void *data)
>   * This macro lets us pass the command as a string to the function so
>   * we can print it on an error.
>   */
> -#define s390_pv_cmd(cmd, data) __s390_pv_cmd(cmd, #cmd, data)
> +#define s390_pv_cmd(cmd, data) __s390_pv_cmd(cmd, #cmd, data, NULL)
> +#define s390_pv_cmd_pvrc(cmd, data, pvrc) __s390_pv_cmd(cmd, #cmd, data, pvrc)
>  #define s390_pv_cmd_exit(cmd, data)    \
>  {                                      \
>      int rc;                            \
>                                         \
> -    rc = __s390_pv_cmd(cmd, #cmd, data);\
> +    rc = __s390_pv_cmd(cmd, #cmd, data, NULL); \
>      if (rc) {                          \
>          exit(1);                       \
>      }                                  \
> @@ -142,14 +147,24 @@ bool s390_pv_vm_try_disable_async(S390CcwMachineState *ms)
>      return true;
>  }
>  
> -int s390_pv_set_sec_parms(uint64_t origin, uint64_t length)
> +int s390_pv_set_sec_parms(uint64_t origin, uint64_t length, Error **errp)
>  {
> +    int ret, pvrc;
>      struct kvm_s390_pv_sec_parm args = {
>          .origin = origin,
>          .length = length,
>      };
>  
> -    return s390_pv_cmd(KVM_PV_SET_SEC_PARMS, &args);
> +    ret = s390_pv_cmd_pvrc(KVM_PV_SET_SEC_PARMS, &args, &pvrc);
> +    if (ret) {
> +        error_setg(errp, "Failed to set secure execution parameters");
> +        if (pvrc == 0x108) {
> +            error_append_hint(errp, "Please check whether the image is "
> +                                    "correctly encrypted for this host\n");
> +        }
> +    }
> +
> +    return ret;
>  }
>  
>  /*


