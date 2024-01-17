Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE5482FE9D
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 02:59:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPvBV-0006bP-Gj; Tue, 16 Jan 2024 20:57:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1rPvBS-0006b7-Pf; Tue, 16 Jan 2024 20:57:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1rPvBQ-00042I-JO; Tue, 16 Jan 2024 20:57:38 -0500
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40H0fffG019228; Wed, 17 Jan 2024 01:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Cf2WxhcWNKtFIZITANc2ufhTWtnAH5/Y7CcEsTG+VKA=;
 b=CfH21vrOdMMUmjZWwxpeA0QbxnIPgPtDc5iAAbpk1f1GQ66Ype+hjiBUYgAGFYvxop1e
 fKGLYy6bBO7Y39xLP6373SbFCw2n7y5XfbYQTQp9pDjKnT+f6swmB9Zsd7fYjZb6LXzw
 FHT21bFtnRjE4pLnSdQsNAa/a6aiOMZVmTXiNAt3sgvsz7485TPf5p+XJdbskp5mQamk
 B5+UoWUC/0LR6WG8qcb2O9w0Inw+W8MEtPKRuUaqGk+JMgicYxCPmZYDmvaZU2dwsBiw
 l9EOOK9f6pRiOpj4C3924iGypzLAqck6+3yaJtuGIPz4slCKLEY2aLboB/jYNfwe9bv7 Dg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vp4emsrmk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 01:57:33 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40H1u9YL002818;
 Wed, 17 Jan 2024 01:57:32 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vp4emsrma-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 01:57:32 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40H1PxIv019538; Wed, 17 Jan 2024 01:57:32 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vm72k242b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 01:57:32 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40H1vV2h22872676
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jan 2024 01:57:31 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 09EBA58043;
 Wed, 17 Jan 2024 01:57:31 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CAEFC58059;
 Wed, 17 Jan 2024 01:57:29 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.107.253]) by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jan 2024 01:57:29 +0000 (GMT)
Message-ID: <0369e3381ec73d7fd5a34d2d9e36f98dde829cb5.camel@linux.ibm.com>
Subject: Re: [PATCH 1/3] s390x/pci: avoid double enable/disable of aif
From: Eric Farman <farman@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: thuth@redhat.com, clg@redhat.com, frankja@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 qemu-devel@nongnu.org
Date: Tue, 16 Jan 2024 20:57:29 -0500
In-Reply-To: <20240116223157.73752-2-mjrosato@linux.ibm.com>
References: <20240116223157.73752-1-mjrosato@linux.ibm.com>
 <20240116223157.73752-2-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OCnHOOngTd2WDNPjjacx0tM_oPw2tMJV
X-Proofpoint-ORIG-GUID: eavJOsOE9FXmwAaNVEzRgkArX4qj59SW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_14,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401170011
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Tue, 2024-01-16 at 17:31 -0500, Matthew Rosato wrote:
> Use a flag to keep track of whether AIF is currently enabled.=C2=A0 This
> can be
> used to avoid enabling/disabling AIF multiple times as well as to
> determine
> whether or not it should be disabled during reset processing.
>=20
> Fixes: d0bc7091c2 ("s390x/pci: enable adapter event notification for
> interpreted devices")
> Reported-by: C=C3=A9dric Le Goater <clg@redhat.com>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
> =C2=A0hw/s390x/s390-pci-kvm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 25 +++++++++++++++++++++++--
> =C2=A0include/hw/s390x/s390-pci-bus.h |=C2=A0 1 +
> =C2=A02 files changed, 24 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/s390x/s390-pci-kvm.c b/hw/s390x/s390-pci-kvm.c
> index ff41e4106d..f7e10cfa72 100644
> --- a/hw/s390x/s390-pci-kvm.c
> +++ b/hw/s390x/s390-pci-kvm.c
> @@ -27,6 +27,7 @@ bool s390_pci_kvm_interp_allowed(void)
> =C2=A0
> =C2=A0int s390_pci_kvm_aif_enable(S390PCIBusDevice *pbdev, ZpciFib *fib,
> bool assist)
> =C2=A0{
> +=C2=A0=C2=A0=C2=A0 int rc;
> =C2=A0=C2=A0=C2=A0=C2=A0 struct kvm_s390_zpci_op args =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .fh =3D pbdev->fh,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .op =3D KVM_S390_ZPCIOP_=
REG_AEN,
> @@ -38,15 +39,35 @@ int s390_pci_kvm_aif_enable(S390PCIBusDevice
> *pbdev, ZpciFib *fib, bool assist)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .u.reg_aen.flags =3D (as=
sist) ? 0 :
> KVM_S390_ZPCIOP_REGAEN_HOST
> =C2=A0=C2=A0=C2=A0=C2=A0 };
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 return kvm_vm_ioctl(kvm_state, KVM_S390_ZPCI_OP, &arg=
s);
> +=C2=A0=C2=A0=C2=A0 if (pbdev->aif) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 rc =3D kvm_vm_ioctl(kvm_state, KVM_S390_ZPCI_OP, &arg=
s);
> +=C2=A0=C2=A0=C2=A0 if (rc =3D=3D 0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pbdev->aif =3D true;
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 return rc;
> =C2=A0}
> =C2=A0
> =C2=A0int s390_pci_kvm_aif_disable(S390PCIBusDevice *pbdev)
> =C2=A0{
> +=C2=A0=C2=A0=C2=A0 int rc;
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 struct kvm_s390_zpci_op args =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .fh =3D pbdev->fh,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .op =3D KVM_S390_ZPCIOP_=
DEREG_AEN
> =C2=A0=C2=A0=C2=A0=C2=A0 };
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 return kvm_vm_ioctl(kvm_state, KVM_S390_ZPCI_OP, &arg=
s);
> +=C2=A0=C2=A0=C2=A0 if (!pbdev->aif) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 rc =3D kvm_vm_ioctl(kvm_state, KVM_S390_ZPCI_OP, &arg=
s);
> +=C2=A0=C2=A0=C2=A0 if (rc =3D=3D 0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pbev->aif =3D false;

s/pbev/pbdev/

You fix this in patch 2. :)

With that fixed:

Reviewed-by: Eric Farman <farman@linux.ibm.com>

> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 return rc;
> =C2=A0}
> diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-
> pci-bus.h
> index b1bdbeaeb5..435e788867 100644
> --- a/include/hw/s390x/s390-pci-bus.h
> +++ b/include/hw/s390x/s390-pci-bus.h
> @@ -361,6 +361,7 @@ struct S390PCIBusDevice {
> =C2=A0=C2=A0=C2=A0=C2=A0 bool unplug_requested;
> =C2=A0=C2=A0=C2=A0=C2=A0 bool interp;
> =C2=A0=C2=A0=C2=A0=C2=A0 bool forwarding_assist;
> +=C2=A0=C2=A0=C2=A0 bool aif;
> =C2=A0=C2=A0=C2=A0=C2=A0 QTAILQ_ENTRY(S390PCIBusDevice) link;
> =C2=A0};
> =C2=A0


