Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B20467BE385
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 16:50:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qprZV-000604-UW; Mon, 09 Oct 2023 10:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1qprZP-0005wP-W2; Mon, 09 Oct 2023 10:49:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1qprZO-0005A6-1K; Mon, 09 Oct 2023 10:49:19 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 399EluWq030811; Mon, 9 Oct 2023 14:49:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=btmypdho8Csg97M4qewAQjWBNOYtfA4sdeuc6lkj/Ds=;
 b=iIuxdqSJdkq2aQ/CIzoaQQc+1xDoV9CnLeqsSB14ydaTUKnecgvH/HC5IA4e6xLJ8YVs
 4/brx4LrZNePkGr7hxxJblFhZRoQ6+3eWNKGziVTAYfNsEH6++hGSBbNhh60y5uFnogg
 hpW3en3s4z5RLwW9+deipHLiymaJ2+EsXccLjil7yji28paJ+WTL5SYvExkb6mLoZqkq
 Xnz6HCOqo7KJ/R0mSsI4aQbwS9KEaWhtegtZJ1PygmBkLmWq2XUVNRHDA2U6nRnEefK6
 +l1F3KBQdJv+DoHLsbT29QxUFhnqb/GHRnuvey8hdE6sSaWlFSgwLUIp2SzVKBdE0uLE Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tmkke0277-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Oct 2023 14:49:12 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 399EmCAY031520;
 Mon, 9 Oct 2023 14:49:11 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tmkke0263-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Oct 2023 14:49:11 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 399De2vk023000; Mon, 9 Oct 2023 14:49:10 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkmc19494-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Oct 2023 14:49:10 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 399En9Um13959758
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Oct 2023 14:49:09 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F2AE5805D;
 Mon,  9 Oct 2023 14:49:09 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 48D4558043;
 Mon,  9 Oct 2023 14:49:08 +0000 (GMT)
Received: from [9.61.31.223] (unknown [9.61.31.223])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Oct 2023 14:49:08 +0000 (GMT)
Message-ID: <174833e2-f1c4-bb23-0518-6a2474f3b471@linux.ibm.com>
Date: Mon, 9 Oct 2023 10:49:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] vfio/ap: Remove pointless apdev variable
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 pasic@linux.ibm.com, jjherne@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, borntraeger@linux.ibm.com, aik@ozlabs.ru,
 eric.auger@redhat.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 qemu-s390x@nongnu.org
References: <20231009022048.35475-1-zhenzhong.duan@intel.com>
 <20231009022048.35475-3-zhenzhong.duan@intel.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20231009022048.35475-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cL0okbbHoVcFVjlpvHSsxxPQsE64ZDtJ
X-Proofpoint-ORIG-GUID: Ijyo9M35ZKRzMLW-m8qos1s-p3_bqo3f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_12,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310090123
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>

On 10/8/23 22:20, Zhenzhong Duan wrote:
> No need to double-cast, call VFIO_AP_DEVICE() on DeviceState.
> 
> No functional changes.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/vfio/ap.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 22e564f4f7..e083a19eac 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -156,8 +156,7 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
>   {
>       int ret;
>       Error *err = NULL;
> -    APDevice *apdev = AP_DEVICE(dev);
> -    VFIOAPDevice *vapdev = VFIO_AP_DEVICE(apdev);
> +    VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
>       VFIODevice *vbasedev = &vapdev->vdev;
>   
>       vbasedev->name = g_path_get_basename(vbasedev->sysfsdev);
> @@ -195,8 +194,7 @@ error:
>   
>   static void vfio_ap_unrealize(DeviceState *dev)
>   {
> -    APDevice *apdev = AP_DEVICE(dev);
> -    VFIOAPDevice *vapdev = VFIO_AP_DEVICE(apdev);
> +    VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
>   
>       vfio_ap_unregister_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX);
>       vfio_detach_device(&vapdev->vdev);
> @@ -211,8 +209,7 @@ static Property vfio_ap_properties[] = {
>   static void vfio_ap_reset(DeviceState *dev)
>   {
>       int ret;
> -    APDevice *apdev = AP_DEVICE(dev);
> -    VFIOAPDevice *vapdev = VFIO_AP_DEVICE(apdev);
> +    VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
>   
>       ret = ioctl(vapdev->vdev.fd, VFIO_DEVICE_RESET);
>       if (ret) {

