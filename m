Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8D582FF16
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 04:03:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPwBe-0001qx-TZ; Tue, 16 Jan 2024 22:01:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1rPwBc-0001q7-8o; Tue, 16 Jan 2024 22:01:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1rPwBZ-0005VW-Uy; Tue, 16 Jan 2024 22:01:52 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40H30w1K022563; Wed, 17 Jan 2024 03:01:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=aUWgDw/50nx0sk1UfGViDYeP6kfPuy6hrkZke/7l9uc=;
 b=ea1pLurfYGSlOEcJv9n7s7irAI8OliQxQxP3hTsF8D+BVhGJI4htG7uaQVHYqN4G+ZWw
 iiZEQcbbn6SAhX3GgVeaJCocBhzTk1E0yrYTL0js2mrTDaavL7BO/Ws4hhDte29YXo2F
 BEn0m/hGU6vYRcP1ra5rDM37HmTCDBtkd94wjhvSNhgbs0j+EGse5/HJx1JnZNBvYkLH
 3rG+g/c4RbHk0YeBcXSYGP9/+rbpTTC9iTOoxlOqrD1quk6+9dXtqb8WLbBxoOKokVGL
 W/PF4e3iU1pWGMQRym2Nt7HodG7W5XeVcsH1P/HVVAbSyzjbZxnaQ7ONHq2eN3gWXrFo PQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vp6bd8c33-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 03:01:46 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40H31422023380;
 Wed, 17 Jan 2024 03:01:45 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vp6bd8c2g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 03:01:45 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40H1M8rJ023705; Wed, 17 Jan 2024 03:01:44 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vm6bkjju8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 03:01:44 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40H31hrD20120226
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jan 2024 03:01:43 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ABBBA5805B;
 Wed, 17 Jan 2024 03:01:43 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 555E258058;
 Wed, 17 Jan 2024 03:01:42 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.107.253]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jan 2024 03:01:42 +0000 (GMT)
Message-ID: <6967e5faa99d1388bc2d1e0541163ef0bb97098d.camel@linux.ibm.com>
Subject: Re: [PATCH 3/3] s390x/pci: drive ISM reset from subsystem reset
From: Eric Farman <farman@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: thuth@redhat.com, clg@redhat.com, frankja@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 qemu-devel@nongnu.org
Date: Tue, 16 Jan 2024 22:01:41 -0500
In-Reply-To: <20240116223157.73752-4-mjrosato@linux.ibm.com>
References: <20240116223157.73752-1-mjrosato@linux.ibm.com>
 <20240116223157.73752-4-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: khlsDShp9-QHKgqoBrscNAruzEJyBLa8
X-Proofpoint-ORIG-GUID: kil4t8xbZf97wjtUlpNV2JzVZeTp5JNd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_14,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 mlxlogscore=999 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401170020
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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

On Tue, 2024-01-16 at 17:31 -0500, Matthew Rosato wrote:
> ISM devices are sensitive to manipulation of the IOMMU, so the ISM
> device
> needs to be reset before the vfio-pci device is reset (triggering a
> full
> UNMAP).=C2=A0 In order to ensure this occurs, trigger ISM device resets
> from
> subsystem_reset before triggering the PCI bus reset (which will also
> trigger vfio-pci reset).=C2=A0 This only needs to be done for ISM devices
> which were enabled for use by the guest.
> Further, ensure that AIF is disabled as part of the reset event.
>=20
> Fixes: ef1535901a ("s390x: do a subsystem reset before the unprotect
> on reboot")
> Fixes: 03451953c7 ("s390x/pci: reset ISM passthrough devices on
> shutdown and system reset")
> Reported-by: C=C3=A9dric Le Goater <clg@redhat.com>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
> =C2=A0hw/s390x/s390-pci-bus.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 26 +++++++++++++++++---------
> =C2=A0hw/s390x/s390-virtio-ccw.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 =
++
> =C2=A0include/hw/s390x/s390-pci-bus.h |=C2=A0 1 +
> =C2=A03 files changed, 20 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 347580ebac..3e57d5faca 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -151,20 +151,12 @@ static void s390_pci_shutdown_notifier(Notifier
> *n, void *opaque)
> =C2=A0=C2=A0=C2=A0=C2=A0 pci_device_reset(pbdev->pdev);
> =C2=A0}
> =C2=A0
> -static void s390_pci_reset_cb(void *opaque)
> -{
> -=C2=A0=C2=A0=C2=A0 S390PCIBusDevice *pbdev =3D opaque;
> -
> -=C2=A0=C2=A0=C2=A0 pci_device_reset(pbdev->pdev);
> -}
> -
> =C2=A0static void s390_pci_perform_unplug(S390PCIBusDevice *pbdev)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 HotplugHandler *hotplug_ctrl;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 if (pbdev->pft =3D=3D ZPCI_PFT_ISM) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 notifier_remove(&pbdev->=
shutdown_notifier);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_unregister_reset(s390_pc=
i_reset_cb, pbdev);
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 /* Unplug the PCI device */
> @@ -1132,7 +1124,6 @@ static void s390_pcihost_plug(HotplugHandler
> *hotplug_dev, DeviceState *dev,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if (pbdev->pft =3D=3D ZPCI_PFT_ISM) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 pbdev->shutdown_notifier.notify =3D
> s390_pci_shutdown_notifier;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 qemu_register_shutdown_notifier(&pbdev-
> >shutdown_notifier);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 qemu_register_reset(s390_pci_reset_cb, pbdev);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
}
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
pbdev->fh |=3D FH_SHM_EMUL;
> @@ -1279,6 +1270,23 @@ static void s390_pci_enumerate_bridge(PCIBus
> *bus, PCIDevice *pdev,
> =C2=A0=C2=A0=C2=A0=C2=A0 pci_default_write_config(pdev, PCI_SUBORDINATE_B=
US, s->bus_no,
> 1);
> =C2=A0}
> =C2=A0
> +void s390_pci_ism_reset(void)
> +{
> +=C2=A0=C2=A0=C2=A0 S390pciState *s =3D s390_get_phb();
> +
> +=C2=A0=C2=A0=C2=A0 S390PCIBusDevice *pbdev, *next;
> +
> +=C2=A0=C2=A0=C2=A0 /* Trigger reset event for each passthrough ISM devic=
e currently
> in-use */
> +=C2=A0=C2=A0=C2=A0 QTAILQ_FOREACH_SAFE(pbdev, &s->zpci_devs, link, next)=
 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pbdev->interp && pbdev->p=
ft =3D=3D ZPCI_PFT_ISM &&
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pbdev=
->fh & FH_MASK_ENABLE) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s390_=
pci_kvm_aif_disable(pbdev);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_d=
evice_reset(pbdev->pdev);

Do we care about the loss of a reset for ISM devices in a
!interpretation case? (I seem to think such a configuration is not
possible today, and so we don't care, but could use a reminder.)

> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 }
> +}
> +
> =C2=A0static void s390_pcihost_reset(DeviceState *dev)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 S390pciState *s =3D S390_PCI_HOST_BRIDGE(dev);
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 1169e20b94..4de04f7e9f 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -118,6 +118,8 @@ static void subsystem_reset(void)
> =C2=A0=C2=A0=C2=A0=C2=A0 DeviceState *dev;
> =C2=A0=C2=A0=C2=A0=C2=A0 int i;
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 s390_pci_ism_reset();
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < ARRAY_SIZE(reset_dev_types); i=
++) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev =3D DEVICE(object_re=
solve_path_type("",
> reset_dev_types[i], NULL));
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dev) {
> diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-
> pci-bus.h
> index 435e788867..2c43ea123f 100644
> --- a/include/hw/s390x/s390-pci-bus.h
> +++ b/include/hw/s390x/s390-pci-bus.h
> @@ -401,5 +401,6 @@ S390PCIBusDevice
> *s390_pci_find_dev_by_target(S390pciState *s,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *target);
> =C2=A0S390PCIBusDevice *s390_pci_find_next_avail_dev(S390pciState *s,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 S390PCIBusDevi=
ce
> *pbdev);
> +void s390_pci_ism_reset(void);
> =C2=A0
> =C2=A0#endif


