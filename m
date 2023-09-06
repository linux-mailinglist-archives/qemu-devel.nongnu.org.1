Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C873E793D1A
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 14:51:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdrzA-0007Cr-JM; Wed, 06 Sep 2023 08:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mihajlov@linux.ibm.com>)
 id 1qdrz7-00075Q-Cu; Wed, 06 Sep 2023 08:50:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mihajlov@linux.ibm.com>)
 id 1qdrz2-0007wZ-G6; Wed, 06 Sep 2023 08:50:17 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 386CiT3d031234; Wed, 6 Sep 2023 12:49:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=bpT0gq024V/A1O9UYx0h6NmookYmdGSzDLFBEPttNsM=;
 b=mf7dBdQ6vxW1yTslmmT+9r314ZZS1EeRNxULiHpMJeICU6bg079wjlbI6EC9u3uPxDvx
 SEPaNis8v+B+70AVtlMdFxM5uuHZBCefixStqi0kQE6TAFxwmbqN0iWgJJEJfe6tc1+L
 n52s8QeMJuKJ7mcs8vnPAyjkQJKOl47YSUrkSEBictt1c2zN7pkBBBEWEfzmAQlPKNUX
 SbDWxhix+fmYeuEPGymAHKukHrVqeXEl7UbEOLR/gZ7BZwpkJ3zzD1tiIj5MibkZyqQ3
 eqdYqWRKylXz16oDP8FNap8N84MZzqkT9q4rPczC6wzXD+RKbW/tW4hAhUI9vF0vp++G 4g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxru69ryd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Sep 2023 12:49:25 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 386CklIh007187;
 Wed, 6 Sep 2023 12:49:25 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxru69rxx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Sep 2023 12:49:25 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 386Cf4O4011108; Wed, 6 Sep 2023 12:49:24 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svj31tc1p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Sep 2023 12:49:24 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 386CnLok58917182
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 6 Sep 2023 12:49:21 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 59FE92004D;
 Wed,  6 Sep 2023 12:49:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2331A2004B;
 Wed,  6 Sep 2023 12:49:21 +0000 (GMT)
Received: from dyn-9-152-222-240.boeblingen.de.ibm.com (unknown
 [9.152.222.240])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  6 Sep 2023 12:49:21 +0000 (GMT)
Message-ID: <2cff0741efb185d24e42e31c289edbc9c3db9ab7.camel@linux.ibm.com>
Subject: Re: [PATCH] s390x: do a subsystem reset before the unprotect on reboot
From: Viktor Mihajlovski <mihajlov@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, seiden@linux.ibm.com, mhartmay@linux.ibm.com,
 thuth@redhat.com, david@redhat.com, mimu@linux.ibm.com,
 borntraeger@linux.ibm.com
Date: Wed, 06 Sep 2023 14:49:20 +0200
In-Reply-To: <20230901114851.154357-1-frankja@linux.ibm.com>
References: <80b007e8-91d7-8298-f628-77c30616f0f4@linux.ibm.com>
 <20230901114851.154357-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eb1opy0UudR1JNUg8LwSjUrB19QKqfHO
X-Proofpoint-ORIG-GUID: gcD5Suxzyn0fAoj26ZIznUTolSE7V0k2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060108
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mihajlov@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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

On Fri, 2023-09-01 at 11:48 +0000, Janosch Frank wrote:
> Bound APQNs have to be reset before tearing down the secure config via
> s390_machine_unprotect(). Otherwise the Ultravisor will return a error
> code.
> 
> So let's do a subsystem_reset() which includes a AP reset before the
> unprotect call. We'll do a full device_reset() afterwards which will
> reset some devices twice. That's ok since we can't move the
> device_reset() before the unprotect as it includes a CPU clear reset
> which the Ultravisor does not expect at that point in time.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
> 
> I'm not able to test this for the PV AP case right new, that has to
> wait to early next week. However Marc told me that the non-AP PV test
> works fine now.
> 
> ---
>  hw/s390x/s390-virtio-ccw.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 3dd0b2372d..2d75f2131f 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -438,10 +438,20 @@ static void s390_machine_reset(MachineState *machine, ShutdownCause reason)
>      switch (reset_type) {
>      case S390_RESET_EXTERNAL:
>      case S390_RESET_REIPL:
> +        /*
> +         * Reset the subsystem which includes a AP reset. If a PV
> +         * guest had APQNs attached the AP reset is a prerequisite to
> +         * unprotecting since the UV checks if all APQNs are reset.
> +         */
> +        subsystem_reset();
>          if (s390_is_pv()) {
>              s390_machine_unprotect(ms);
>          }
>  
> +        /*
> +         * Device reset includes CPU clear resets so this has to be
> +         * done AFTER the unprotect call above.
> +         */
>          qemu_devices_reset(reason);
>          s390_crypto_reset();
>  
I tested this with and without bound/associated APQNs both with booting
from disk and with direct kernel boot. Subsequent reboots are correctly
resetting the APQNs. I also successfully tested the case direct kernel
boot -> chreipl -> disk boot.

If you want you can add
  Tested-by: Viktor Mihajlovski <mihajlov@linux.ibm.com>


