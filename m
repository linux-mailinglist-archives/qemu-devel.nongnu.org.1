Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4D478F12C
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 18:23:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbkQo-0002K5-9L; Thu, 31 Aug 2023 12:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1qbkQS-0002HZ-Ki; Thu, 31 Aug 2023 12:21:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1qbkQP-0004Al-Oy; Thu, 31 Aug 2023 12:21:44 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37VGHgfN018917; Thu, 31 Aug 2023 16:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=mcxkzMR36x/sI2xdS1Yq+jqBHDzevVXzZDq3zrje60U=;
 b=lk70YdnOjczYC4qxDYRgUEFgEtBYKNFEzn5mjIJI5MLUJAtMujTqBHRxBOluc/xRoN7O
 hX7E2B1gnvSzU3GrojYvMw+oolo/1/W3Vyg1gJhWOcA3SVYR07DQ0q654LRbZiC5grhT
 rXoqIrS8eTCL1RM405pMNUedQqp57H/8UYijpMzX6Y44f0q9+r67UGX/Ll4klbF1uw5U
 OFWc2zyOiWOkZt1IEc2nPxdNV6JWAeP1ES0vM/lqk5n/qeoFTrdkkFmmc2FCTcl57aHA
 wj6yWuinR1ydyXg3cfre1neOL8CferJEKx2xzVFilMbKJxgSU1wc3b2tsmAL1niZTtEt yw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3stt7w89b1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 31 Aug 2023 16:21:38 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37VGHmB0019356;
 Thu, 31 Aug 2023 16:21:38 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3stt7w89ar-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 31 Aug 2023 16:21:38 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37VETMLt009941; Thu, 31 Aug 2023 16:21:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqw7kwmvr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 31 Aug 2023 16:21:36 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37VGLXNm45548124
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 31 Aug 2023 16:21:33 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 991D720043;
 Thu, 31 Aug 2023 16:21:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0310420040;
 Thu, 31 Aug 2023 16:21:33 +0000 (GMT)
Received: from li-1de7cd4c-3205-11b2-a85c-d27f97db1fe1.ibm.com (unknown
 [9.179.26.51]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 31 Aug 2023 16:21:32 +0000 (GMT)
From: "Marc Hartmayer" <mhartmay@linux.ibm.com>
To: Steffen Eiden <seiden@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: Janosch Frank <frankja@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Michael Mueller <mimu@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH v4 2/5] s390x: switch pv and subsystem reset ordering on
 reboot
In-Reply-To: <20230823142219.1046522-3-seiden@linux.ibm.com>
References: <20230823142219.1046522-1-seiden@linux.ibm.com>
 <20230823142219.1046522-3-seiden@linux.ibm.com>
Date: Thu, 31 Aug 2023 18:21:31 +0200
Message-ID: <87o7in2nec.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _TB6m1RN7xNAkf7XWYOAZgZxxGPkKYcT
X-Proofpoint-ORIG-GUID: B8htBybaOBNEBY3X3ciKMisB4Nl6IJG4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_14,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 malwarescore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308310144
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mhartmay@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On Wed, Aug 23, 2023 at 04:22 PM +0200, Steffen Eiden <seiden@linux.ibm.com=
> wrote:
> From: Janosch Frank <frankja@linux.ibm.com>
>
> Bound APQNs have to be reset before tearing down the secure config via
> s390_machine_unprotect(). Otherwise the Ultravisor will return a error
> code.
>
> So let's switch the ordering around to make that happen.
>
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 4b36c9970e..795dd53d68 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -442,13 +442,13 @@ static void s390_machine_reset(MachineState *machin=
e, ShutdownCause reason)
>      switch (reset_type) {
>      case S390_RESET_EXTERNAL:
>      case S390_RESET_REIPL:
> +        qemu_devices_reset(reason);
> +        s390_crypto_reset();
> +
>          if (s390_is_pv()) {
>              s390_machine_unprotect(ms);
>          }
>=20=20
> -        qemu_devices_reset(reason);
> -        s390_crypto_reset();
> -
>          /* configure and start the ipl CPU only */
>          run_on_cpu(cs, s390_do_cpu_ipl, RUN_ON_CPU_NULL);
>          break;
> --=20
> 2.41.0
>

Unfortunately, this breaks things for me. You can reproduce the problem
easily=E2=80=A6 Start an SE guest via direct kernel boot and reboot the gue=
st
after the guest has booted.

e.g.

$ sudo qemu-system-s390x -smp 2 --machine accel=3Dkvm,aes-key-wrap=3Doff -k=
ernel /var/lib/libvirt/images/hades/vmlinux-s390x.se.img -m 2048 -nographic=
 -nodefaults -chardev stdio,id=3Dc1,mux=3Don  -device sclpconsole,chardev=
=3Dc1 -append "earlyprintk"
=E2=80=A6
#  reboot  # (console in the guest)
=E2=80=A6
[    3.966496] systemd-shutdown[1]: Syncing filesystems and block devices.
[    3.966606] systemd-shutdown[1]: Rebooting.
qemu-system-s390x: CPU reset failed on CPU 0 type aec4
qemu-system-s390x: CPU reset failed on CPU 1 type aec4
qemu-system-s390x: KVM PV command 4 (KVM_PV_VERIFY) failed: header rc 102 r=
rc 1b IOCTL rc: -22
Protected boot has failed: 0xa02

--=20
Kind regards / Beste Gr=C3=BC=C3=9Fe
   Marc Hartmayer

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Gregor Pillen
Gesch=C3=A4ftsf=C3=BChrung: David Faller
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

