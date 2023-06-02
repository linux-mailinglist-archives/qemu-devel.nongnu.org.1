Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8A8720519
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 17:01:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q56GY-0008B6-L0; Fri, 02 Jun 2023 11:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1q56GR-00084y-5r; Fri, 02 Jun 2023 11:00:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1q56GL-0005iZ-K7; Fri, 02 Jun 2023 11:00:24 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 352EqFdK019399; Fri, 2 Jun 2023 15:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=rH75uBGQIj4wAcZc4BvZvDAG06QjRCT9DmgWmeDrtZ4=;
 b=D3ylrkuqzLzhEaqppwMbeeIxaatffbgq+YCKAuKIDtkfldulilyl63bNS524HeVQTY97
 pyLFj+CWM+32EmpvVxpLYZcsVdu+CWCAnoeSgvZ9qKDAt1C8lSXC3UPgOdpKKx3MBlHu
 GaaBM1Ka1jmEdGczTzPDuFSWwHn4i1sthbKk2eAClmLR23GT2KBT468jaVIiTXIC7uMO
 Teth1UmGSX2FhhMOfVuA+PKa3X8GiP9nRy61pW0hMBEc1D+4cZXT6OupbBdgAwkIq0yV
 3TLLyWPw5L/2P0WKSlVuzH9K7eLS4A3xZVmDP0r1/kwSBJ7H8wfTSLHFx7JXwXGUakGb mA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qyjjf05h6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Jun 2023 15:00:19 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 352Esd8L027768;
 Fri, 2 Jun 2023 15:00:19 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qyjjf05ge-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Jun 2023 15:00:19 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 352BIGAZ008106;
 Fri, 2 Jun 2023 15:00:18 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
 by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3qu9g8qpk3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Jun 2023 15:00:18 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 352F0Hod61210924
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Jun 2023 15:00:17 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F3C4A58065;
 Fri,  2 Jun 2023 15:00:16 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E80A58055;
 Fri,  2 Jun 2023 15:00:16 +0000 (GMT)
Received: from [9.61.88.233] (unknown [9.61.88.233])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  2 Jun 2023 15:00:16 +0000 (GMT)
Message-ID: <86673335-bdae-61ed-cef9-b29b088e9040@linux.ibm.com>
Date: Fri, 2 Jun 2023 11:00:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/2] s390x/ap: Wire up the device request notifier
 interface
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, mjrosato@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, fiuczy@linux.ibm.com, thuth@redhat.com,
 farman@linux.ibm.com, borntraeger@linux.ibm.com, cohuck@redhat.com
References: <20230602141125.448833-1-akrowiak@linux.ibm.com>
 <20230602141125.448833-3-akrowiak@linux.ibm.com>
 <c272e7b2-4b72-fc7f-49ed-e1fec60e1aa3@redhat.com>
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <c272e7b2-4b72-fc7f-49ed-e1fec60e1aa3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DvF7jLo5iNG171JFFb_bvDxJU_CEj5Fc
X-Proofpoint-GUID: DrLIrhvermiKpXhg3lIgwxLMuKw1i9md
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_10,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2306020110
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 6/2/23 10:28 AM, Cédric Le Goater wrote:
> Hello Tony,
> 
> On 6/2/23 16:11, Tony Krowiak wrote:
>> Let's wire up the device request notifier interface to handle device 
>> unplug
>> requests for AP.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Link: 
>> https://lore.kernel.org/qemu-devel/20230530225544.280031-1-akrowiak@linux.ibm.com/
>> ---
>>   hw/vfio/ap.c | 113 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 113 insertions(+)
>>
>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>> index e0dd561e85a3..6e21d1da5a70 100644
>> --- a/hw/vfio/ap.c
>> +++ b/hw/vfio/ap.c
>> @@ -18,6 +18,8 @@
>>   #include "hw/vfio/vfio-common.h"
>>   #include "hw/s390x/ap-device.h"
>>   #include "qemu/error-report.h"
>> +#include "qemu/event_notifier.h"
>> +#include "qemu/main-loop.h"
>>   #include "qemu/module.h"
>>   #include "qemu/option.h"
>>   #include "qemu/config-file.h"
>> @@ -33,6 +35,7 @@
>>   struct VFIOAPDevice {
>>       APDevice apdev;
>>       VFIODevice vdev;
>> +    EventNotifier req_notifier;
>>   };
>>   OBJECT_DECLARE_SIMPLE_TYPE(VFIOAPDevice, VFIO_AP_DEVICE)
>> @@ -84,10 +87,110 @@ static VFIOGroup *vfio_ap_get_group(VFIOAPDevice 
>> *vapdev, Error **errp)
>>       return vfio_get_group(groupid, &address_space_memory, errp);
>>   }
>> +static void vfio_ap_req_notifier_handler(void *opaque)
>> +{
>> +    VFIOAPDevice *vapdev = opaque;
>> +    Error *err = NULL;
>> +
>> +    if (!event_notifier_test_and_clear(&vapdev->req_notifier)) {
>> +        return;
>> +    }
>> +
>> +    qdev_unplug(DEVICE(vapdev), &err);
>> +
>> +    if (err) {
>> +        warn_reportf_err(err, VFIO_MSG_PREFIX, vapdev->vdev.name);
>> +    }
>> +}
>> +
>> +static void vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>> +                                          unsigned int irq, Error 
>> **errp)
>> +{
>> +    int fd;
>> +    size_t argsz;
>> +    IOHandler *fd_read;
>> +    EventNotifier *notifier;
>> +    struct vfio_irq_info *irq_info;
>> +    VFIODevice *vdev = &vapdev->vdev;
>> +
>> +    switch (irq) {
> 
> Do you have plan for more interrupts ? If not, you could convert the
> 'switch' statement to a simple 'if' and remove the fd_read variable.

At this time there are no plans for further interrupts, but the switch 
does make it easy to add them:) On the other hand, I have no problem 
changing this to an 'if' statement. The fd_read variable is used below 
in the call to the qemu_set_fd_handler() function, so I can't get rid of it.

> 
>> +    case VFIO_AP_REQ_IRQ_INDEX:
>> +        notifier = &vapdev->req_notifier;
>> +        fd_read = vfio_ap_req_notifier_handler;
>> +        break;
>> +    default:
>> +        error_setg(errp, "vfio: Unsupported device irq(%d)", irq);
>> +        return;
>> +    }
>> +
>> +    if (vdev->num_irqs < irq + 1) {
>> +        error_setg(errp, "vfio: IRQ %u not available (number of irqs 
>> %u)",
>> +                   irq, vdev->num_irqs);
>> +        return;
>> +    }
>> +
>> +    argsz = sizeof(*irq_info);
>> +    irq_info = g_malloc0(argsz);
>> +    irq_info->index = irq;
>> +    irq_info->argsz = argsz;
>> +
>> +    if (ioctl(vdev->fd, VFIO_DEVICE_GET_IRQ_INFO,
>> +              irq_info) < 0 || irq_info->count < 1) {
>> +        error_setg_errno(errp, errno, "vfio: Error getting irq info");
>> +        goto out_free_info;
>> +    }
>> +
>> +    if (event_notifier_init(notifier, 0)) {
>> +        error_setg_errno(errp, errno,
>> +                         "vfio: Unable to init event notifier for irq 
>> (%d)",
>> +                         irq);
>> +        goto out_free_info;
>> +    }
>> +
>> +    fd = event_notifier_get_fd(notifier);
>> +    qemu_set_fd_handler(fd, fd_read, NULL, vapdev);
>> +
>> +    if (vfio_set_irq_signaling(vdev, irq, 0, 
>> VFIO_IRQ_SET_ACTION_TRIGGER, fd,
>> +                               errp)) {
>> +        qemu_set_fd_handler(fd, NULL, NULL, vapdev);
>> +        event_notifier_cleanup(notifier);
>> +    }
>> +
>> +out_free_info:
>> +    g_free(irq_info);
>> +
>> +}
>> +
>> +static void vfio_ap_unregister_irq_notifier(VFIOAPDevice *vapdev,
>> +                                            unsigned int irq)
>> +{
>> +    Error *err = NULL;
>> +    EventNotifier *notifier;
>> +
>> +    switch (irq) {
>> +    case VFIO_AP_REQ_IRQ_INDEX:
>> +        notifier = &vapdev->req_notifier;
>> +        break;
>> +    default:
>> +        error_report("vfio: Unsupported device irq(%d)", irq);
>> +        return;
>> +    }
>> +
>> +    if (vfio_set_irq_signaling(&vapdev->vdev, irq, 0,
>> +                               VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
>> +        warn_reportf_err(err, VFIO_MSG_PREFIX, vapdev->vdev.name);
>> +    }
>> +
>> +    qemu_set_fd_handler(event_notifier_get_fd(notifier),
>> +                        NULL, NULL, vapdev);
>> +    event_notifier_cleanup(notifier);
>> +}
>> +
>>   static void vfio_ap_realize(DeviceState *dev, Error **errp)
>>   {
>>       int ret;
>>       char *mdevid;
>> +    Error *err = NULL;
>>       VFIOGroup *vfio_group;
>>       APDevice *apdev = AP_DEVICE(dev);
>>       VFIOAPDevice *vapdev = VFIO_AP_DEVICE(apdev);
>> @@ -116,6 +219,15 @@ static void vfio_ap_realize(DeviceState *dev, 
>> Error **errp)
>>           goto out_get_dev_err;
>>       }
>> +    vfio_ap_register_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX, &err);
>> +    if (err) {
>> +        /*
>> +         * Report this error, but do not make it a failing condition.
>> +         * Lack of this IRQ in the host does not prevent normal 
>> operation.
>> +         */
>> +        error_report_err(err);
> 
> May be issue a warning instead ?

Given the comment above - i.e., not a failing condition - it probably 
makes sense to make it a warning.

> 
> Thanks,
> 
> C.
> 
>> +    }
>> +
>>       return;
>>   out_get_dev_err:
>> @@ -129,6 +241,7 @@ static void vfio_ap_unrealize(DeviceState *dev)
>>       VFIOAPDevice *vapdev = VFIO_AP_DEVICE(apdev);
>>       VFIOGroup *group = vapdev->vdev.group;
>> +    vfio_ap_unregister_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX);
>>       vfio_ap_put_device(vapdev);
>>       vfio_put_group(group);
>>   }
> 

