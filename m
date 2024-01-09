Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9805482891B
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 16:36:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNE8K-00034s-Nq; Tue, 09 Jan 2024 10:35:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1rNE8E-00034A-SI; Tue, 09 Jan 2024 10:35:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1rNE8B-0006GH-T1; Tue, 09 Jan 2024 10:35:10 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 409FCGBt029786; Tue, 9 Jan 2024 15:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=g5RRh/kCJiwh0cUb+hVvwy8PDhSPN930gUkaw+wV5jo=;
 b=COvr94ot4oXqVt1iup1Q9f2cRDxSO2gW3yOOT5aWg2ph6Hsxfiy8FxgVe4kbS6PBjpUQ
 gx0wgKWIRtfXutml3DLVH05p8l8vFEleyXgYisdZ2ulmG5pAIziGrGp3TNvCfxVxoSCW
 C7orB8GfgS4XCh0vCEhmU7CY6t1T4UltKu3ZuKvHH9/wc002p9fBgXbeq3LbDeAbCuoW
 W5/aQ54rKp0UZgsQP0KkC3r/CVLxKRIptiUmNjY/QYdgS2Ainn7dsbG4MMUwjWm+DOdx
 xgwY75gYnG1qpWw7yEYifTwWfLoC2mbO77g/zyqbSB/8go4eMswJiWIF9L7QNftL9Yjm iw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vh78yuhb6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 15:35:03 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 409F03Zr025848;
 Tue, 9 Jan 2024 15:35:02 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vh78yuh9m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 15:35:02 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 409FJFoP000926; Tue, 9 Jan 2024 15:35:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vfkdk73ba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 15:35:00 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 409FYvNF1638966
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Jan 2024 15:34:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C344B2004B;
 Tue,  9 Jan 2024 15:34:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 911EE20043;
 Tue,  9 Jan 2024 15:34:57 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  9 Jan 2024 15:34:57 +0000 (GMT)
Date: Tue, 9 Jan 2024 16:34:56 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Janosch
 Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org, Halil Pasic
 <pasic@linux.ibm.com>
Subject: Re: [PATCH] target/s390x/kvm/pv: Provide some more useful
 information if decryption fails
Message-ID: <20240109163456.5e7a29fa@p-imbrenda>
In-Reply-To: <20240109143038.155512-1-thuth@redhat.com>
References: <20240109143038.155512-1-thuth@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: awagV1hqepDBuUtf8ZXzMzbE3K6bLFpj
X-Proofpoint-ORIG-GUID: 4-Ut7fu_l37HE1DbQmco0LyFaQ6NL_PX
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_07,2024-01-09_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 phishscore=0
 clxscore=1011 priorityscore=1501 suspectscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401090126
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

On Tue,  9 Jan 2024 15:30:38 +0100
Thomas Huth <thuth@redhat.com> wrote:

> It's a common scenario to copy guest images from one host to another
> to run the guest on the other machine. This (of course) does not work
> with "secure exection" guests since they are encrypted with one certain

"secure execution"

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

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  target/s390x/kvm/pv.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
> index 6a69be7e5c..2833a255fa 100644
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
> @@ -144,12 +149,19 @@ bool s390_pv_vm_try_disable_async(S390CcwMachineState *ms)
>  
>  int s390_pv_set_sec_parms(uint64_t origin, uint64_t length)
>  {
> +    int ret, pvrc;
>      struct kvm_s390_pv_sec_parm args = {
>          .origin = origin,
>          .length = length,
>      };
>  
> -    return s390_pv_cmd(KVM_PV_SET_SEC_PARMS, &args);
> +    ret = s390_pv_cmd_pvrc(KVM_PV_SET_SEC_PARMS, &args, &pvrc);
> +    if (ret && pvrc == 0x108) {
> +        error_report("Can't set secure parameters, please check whether "
> +                     "the image is correctly encrypted for this host");
> +    }
> +
> +    return ret;
>  }
>  
>  /*


