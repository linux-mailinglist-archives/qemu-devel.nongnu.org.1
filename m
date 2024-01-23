Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF33838DDA
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 12:49:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSFGr-00062N-6X; Tue, 23 Jan 2024 06:48:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1rSFGp-000626-Ju; Tue, 23 Jan 2024 06:48:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pasic@linux.ibm.com>)
 id 1rSFGn-0003k0-Mt; Tue, 23 Jan 2024 06:48:47 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40NA7t4s023213; Tue, 23 Jan 2024 11:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=FDNME5hbzaEnsHDO/Qz7pbl9lDzJUgSQ0UnLA/DbsNg=;
 b=MshiEMMCx/vTnk7QyRAjzl5iTf0oYKdqmMCINEj9k5FSZtPfpGNWDA/qy+JC2I8kNnQU
 MU+7Mp9l1WkZ5YedZ4WVbyhWBiedrRVk2sM4tqpidhnb1x8mK2HgeyzLkjL0v8yZqge/
 xEZmll8tQz0Aot+nlCpMawpBS/psW26RDiLiU/g8l1TsUiGu7vlnFe1THpCI+w755K8n
 jrHgYhE+jmM0v674eCGmyyKE12l0xCK/eZJ6n2cTApRYpUyV015dsh3c0M1f2EcRLZtl
 5E+uN+e/Maiv/avRhuqQ/lPFDA9pKHBia7FwS1mEyBcTQBvuyedFUgImYIgCxNc1BBV1 Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vtbe7j3y9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jan 2024 11:48:42 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40NBAw0m024918;
 Tue, 23 Jan 2024 11:48:41 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vtbe7j3y3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jan 2024 11:48:41 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40NBdKW6026879; Tue, 23 Jan 2024 11:48:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vrrgt74s8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jan 2024 11:48:40 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40NBmctF41222816
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jan 2024 11:48:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E8A7B2004B;
 Tue, 23 Jan 2024 11:48:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 924D220040;
 Tue, 23 Jan 2024 11:48:37 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown
 [9.152.224.212])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jan 2024 11:48:37 +0000 (GMT)
Date: Tue, 23 Jan 2024 12:48:35 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, farman@linux.ibm.com, thuth@redhat.com,
 clg@redhat.com, frankja@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org, Halil Pasic
 <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 3/3] s390x/pci: drive ISM reset from subsystem reset
Message-ID: <20240123124835.7ea76fb0.pasic@linux.ibm.com>
In-Reply-To: <c206887f-7bca-4c5a-a416-88951902ff21@linux.ibm.com>
References: <20240118185151.265329-1-mjrosato@linux.ibm.com>
 <20240118185151.265329-4-mjrosato@linux.ibm.com>
 <20240119220739.0f5739b3.pasic@linux.ibm.com>
 <c206887f-7bca-4c5a-a416-88951902ff21@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VLeiMEvVxWj9o1OHguVEk-Muld7U1FLr
X-Proofpoint-ORIG-GUID: t8ceGdktfwrNUqEw0LNQLZ6d6JLecj8B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_05,2024-01-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401230085
Received-SPF: pass client-ip=148.163.158.5; envelope-from=pasic@linux.ibm.com;
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

On Mon, 22 Jan 2024 10:06:38 -0500
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> On 1/19/24 4:07 PM, Halil Pasic wrote:
> > On Thu, 18 Jan 2024 13:51:51 -0500
> > Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> >   
> >> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> >> index eaf61d3640..c99682b07d 100644
> >> --- a/hw/s390x/s390-virtio-ccw.c
> >> +++ b/hw/s390x/s390-virtio-ccw.c
> >> @@ -118,6 +118,14 @@ static void subsystem_reset(void)
> >>      DeviceState *dev;
> >>      int i;
> >>  
> >> +    /*
> >> +     * ISM firmware is sensitive to unexpected changes to the IOMMU, which can
> >> +     * occur during reset of the vfio-pci device (unmap of entire aperture).
> >> +     * Ensure any passthrough ISM devices are reset now, while CPUs are paused
> >> +     * but before vfio-pci cleanup occurs.
> >> +     */
> >> +    s390_pci_ism_reset();  
> > 
> > Hm I'm not sure about special casing ISM in here. In my opinion the loop
> > below shall take care of all the reset.
> > 
> > For TYPE_AP_BRIDGE and TYPE_VIRTUAL_CSS_BRIDGE AFAIU a
> > device_cold_reset() on all objects of those types results in the resets
> > of objects that hang below these buses.
> > 
> > I guess this also happens for the S390PCIBusDevices, but not for the
> > actual PCI devices.  
> 
> PCI is a bit different because we have both the PCI root bus and the s390 pci bus --  When we reset the s390-pcihost in the device_cold_reset() loop, the root pci bus will also receive a reset and in practice this causes the vfio-pci devices to get cleaned up (this includes an unmap of the entire iommu aperture) and this happens before we get to the reset of S390PCIBusDevices.  This order is OK for other device types who are not sensitive to the IOMMU being wiped out in this manner, but ISM is effectively treating some portion of the IOMMU as state data and is not expecting this UNMAP.  Triggering the reset as we do here causes the host device to throw out the existing state data, so we want to do that at a point in time after CPU pause and before vfio-pci cleanup; this is basically working around a quirk of ISM devices.
>

I am still a bit confused. Are you saying that when subsystem_reset() is
called, the resets happen in an order that leads to problems with ISM
but when qemu_devices_reset() is called the resets happen in an order
favorable to ISM?

Anyway the important thing is that we are functionally covered. My
concern is just the how.

 
> FWIW, this series of fixes was already pulled.  I think for a fix, this location in code was the safe bet -- But if we can figure out a way to ensure the reset targeted S390PCIBusDevices first before the root PCI bus then I could see a follow-on cleanup patch that moves this logic back into s390 pci bus code (e.g. allowing the loop to take care of all the reset once again). 
> 

Yes that makes sense. Should I find the time, I can come back to this
too.

Regards,
Halil

