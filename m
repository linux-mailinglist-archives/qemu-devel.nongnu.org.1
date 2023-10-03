Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C407B756C
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:44:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnowM-0006UG-GY; Tue, 03 Oct 2023 19:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1qnowL-0006Ts-0S
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:36:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1qnowI-0007he-Fq
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:36:32 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 393MrVke004285; Tue, 3 Oct 2023 23:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=aWZ4Z+87tUZLDujccimWRBT70C7TZXswqUXosZqiz7k=;
 b=Pl+pHu7nciz3xXzWXnveSwl6t+CUVARCaRHZHlsz1yrexLfknkD4CwM6XGeu0QVN0VYn
 VPJxhdgvCPtEJP2Hj7b4qMxecGRuq5kIRKnCybPaaJPXaQNIR6iqP+DqmAvvYycWVOQf
 h03dwB6a11v1mhwOkWhyhbFmePTb73xNJzBuJG6CcdyEToFzJyBvK3bD8D0yRl0w4hI2
 Iu+fj8SMNXUjDyTuYKB/loTzn+I90ehqJJLR679hn4UUnMoa1+ttGmbcy9PyWVAT17/V
 Fgjf4MffdfGEme70oVre0K1HfokmjUPT4Hq3Z6LFYyGRmnWTWY+xCX6uxB2o0TQb0jtT sw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tgv58g4dc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Oct 2023 23:01:52 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 393MxDva018457;
 Tue, 3 Oct 2023 23:01:52 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tgv58g4d4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Oct 2023 23:01:51 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 393LjOJG017649; Tue, 3 Oct 2023 23:01:51 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tey0n6dhv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Oct 2023 23:01:50 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 393N1o444784894
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Oct 2023 23:01:50 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2DD0C580E6;
 Tue,  3 Oct 2023 23:01:50 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E324580E4;
 Tue,  3 Oct 2023 23:01:49 +0000 (GMT)
Received: from [9.61.106.119] (unknown [9.61.106.119])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  3 Oct 2023 23:01:49 +0000 (GMT)
Message-ID: <99a623d9-c161-fa3e-24fe-3e7b5795718f@linux.ibm.com>
Date: Tue, 3 Oct 2023 19:01:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 10/15] vfio/ccw: Use vfio_[attach/detach]_device
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, zhenzhong.duan@intel.com,
 alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, peterx@redhat.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
 chao.p.peng@intel.com
References: <20231003101530.288864-1-eric.auger@redhat.com>
 <20231003101530.288864-11-eric.auger@redhat.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20231003101530.288864-11-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FGVNEHU26HT5gXdloVRw_a_n1Ko2Sy9j
X-Proofpoint-GUID: l8myhx1b-rXiTun-lZj0bhjXAnaBAJUk
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_18,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 suspectscore=0 adultscore=0
 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030170
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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

On 10/3/23 6:14 AM, Eric Auger wrote:
> Let the vfio-ccw device use vfio_attach_device() and
> vfio_detach_device(), hence hiding the details of the used
> IOMMU backend.
> 
> Note that the migration reduces the following trace
> "vfio: subchannel %s has already been attached" (featuring
> cssid.ssid.devid) into "device is already attached"
> 
> Also now all the devices have been migrated to use the new
> vfio_attach_device/vfio_detach_device API, let's turn the
> legacy functions into static functions, local to container.c.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> 
> ---
> v2 -> v3:
> - Hopefully fix confusion beteen vbasedev->name, mdevid and sysfsdev
>   while keeping into account Matthew's comment
>   https://lore.kernel.org/qemu-devel/6e04ab8f-dc84-e9c2-deea-2b6b31678b53@linux.ibm.com/

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

Tested out using some vfio-ccw devices and verified attach/detach worked / sysfsdev was correct.

> ---
>  include/hw/vfio/vfio-common.h |   5 --
>  hw/vfio/ccw.c                 | 122 +++++++++-------------------------
>  hw/vfio/common.c              |  10 +--
>  3 files changed, 37 insertions(+), 100 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 12fbfbc37d..c486bdef2a 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -202,7 +202,6 @@ typedef struct {
>      hwaddr pages;
>  } VFIOBitmap;
>  
> -void vfio_put_base_device(VFIODevice *vbasedev);
>  void vfio_disable_irqindex(VFIODevice *vbasedev, int index);
>  void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index);
>  void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index);
> @@ -220,11 +219,7 @@ void vfio_region_unmap(VFIORegion *region);
>  void vfio_region_exit(VFIORegion *region);
>  void vfio_region_finalize(VFIORegion *region);
>  void vfio_reset_handler(void *opaque);
> -VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp);
> -void vfio_put_group(VFIOGroup *group);
>  struct vfio_device_info *vfio_get_device_info(int fd);
> -int vfio_get_device(VFIOGroup *group, const char *name,
> -                    VFIODevice *vbasedev, Error **errp);
>  int vfio_attach_device(char *name, VFIODevice *vbasedev,
>                         AddressSpace *as, Error **errp);
>  void vfio_detach_device(VFIODevice *vbasedev);
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 1e2fce83b0..84eafb2e87 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -572,88 +572,15 @@ static void vfio_ccw_put_region(VFIOCCWDevice *vcdev)
>      g_free(vcdev->io_region);
>  }
>  
> -static void vfio_ccw_put_device(VFIOCCWDevice *vcdev)
> -{
> -    g_free(vcdev->vdev.name);
> -    vfio_put_base_device(&vcdev->vdev);
> -}
> -
> -static void vfio_ccw_get_device(VFIOGroup *group, VFIOCCWDevice *vcdev,
> -                                Error **errp)
> -{
> -    S390CCWDevice *cdev = S390_CCW_DEVICE(vcdev);
> -    char *name = g_strdup_printf("%x.%x.%04x", cdev->hostid.cssid,
> -                                 cdev->hostid.ssid,
> -                                 cdev->hostid.devid);
> -    VFIODevice *vbasedev;
> -
> -    QLIST_FOREACH(vbasedev, &group->device_list, next) {
> -        if (strcmp(vbasedev->name, name) == 0) {
> -            error_setg(errp, "vfio: subchannel %s has already been attached",
> -                       name);
> -            goto out_err;
> -        }
> -    }
> -
> -    /*
> -     * All vfio-ccw devices are believed to operate in a way compatible with
> -     * discarding of memory in RAM blocks, ie. pages pinned in the host are
> -     * in the current working set of the guest driver and therefore never
> -     * overlap e.g., with pages available to the guest balloon driver.  This
> -     * needs to be set before vfio_get_device() for vfio common to handle
> -     * ram_block_discard_disable().
> -     */
> -    vcdev->vdev.ram_block_discard_allowed = true;
> -
> -    if (vfio_get_device(group, cdev->mdevid, &vcdev->vdev, errp)) {
> -        goto out_err;
> -    }
> -
> -    vcdev->vdev.ops = &vfio_ccw_ops;
> -    vcdev->vdev.type = VFIO_DEVICE_TYPE_CCW;
> -    vcdev->vdev.name = name;
> -    vcdev->vdev.dev = DEVICE(vcdev);
> -
> -    return;
> -
> -out_err:
> -    g_free(name);
> -}
> -
> -static VFIOGroup *vfio_ccw_get_group(S390CCWDevice *cdev, Error **errp)
> -{
> -    char *tmp, group_path[PATH_MAX];
> -    ssize_t len;
> -    int groupid;
> -
> -    tmp = g_strdup_printf("/sys/bus/css/devices/%x.%x.%04x/%s/iommu_group",
> -                          cdev->hostid.cssid, cdev->hostid.ssid,
> -                          cdev->hostid.devid, cdev->mdevid);
> -    len = readlink(tmp, group_path, sizeof(group_path));
> -    g_free(tmp);
> -
> -    if (len <= 0 || len >= sizeof(group_path)) {
> -        error_setg(errp, "vfio: no iommu_group found");
> -        return NULL;
> -    }
> -
> -    group_path[len] = 0;
> -
> -    if (sscanf(basename(group_path), "%d", &groupid) != 1) {
> -        error_setg(errp, "vfio: failed to read %s", group_path);
> -        return NULL;
> -    }
> -
> -    return vfio_get_group(groupid, &address_space_memory, errp);
> -}
> -
>  static void vfio_ccw_realize(DeviceState *dev, Error **errp)
>  {
> -    VFIOGroup *group;
>      S390CCWDevice *cdev = S390_CCW_DEVICE(dev);
>      VFIOCCWDevice *vcdev = VFIO_CCW(cdev);
>      S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
> +    VFIODevice *vbasedev = &vcdev->vdev;
>      Error *err = NULL;
> +    char *name;
> +    int ret;
>  
>      /* Call the class init function for subchannel. */
>      if (cdc->realize) {
> @@ -663,14 +590,31 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
>          }
>      }
>  
> -    group = vfio_ccw_get_group(cdev, &err);
> -    if (!group) {
> -        goto out_group_err;
> -    }
> +    name = g_strdup_printf("%x.%x.%04x", vcdev->cdev.hostid.cssid,
> +                           vcdev->cdev.hostid.ssid,
> +                           vcdev->cdev.hostid.devid);
> +    vbasedev->sysfsdev = g_strdup_printf("/sys/bus/css/devices/%s/%s",
> +                                         name,
> +                                         cdev->mdevid);
> +    vbasedev->ops = &vfio_ccw_ops;
> +    vbasedev->type = VFIO_DEVICE_TYPE_CCW;
> +    vbasedev->name = name;
> +    vbasedev->dev = &vcdev->cdev.parent_obj.parent_obj;
>  
> -    vfio_ccw_get_device(group, vcdev, &err);
> -    if (err) {
> -        goto out_device_err;
> +    /*
> +     * All vfio-ccw devices are believed to operate in a way compatible with
> +     * discarding of memory in RAM blocks, ie. pages pinned in the host are
> +     * in the current working set of the guest driver and therefore never
> +     * overlap e.g., with pages available to the guest balloon driver.  This
> +     * needs to be set before vfio_get_device() for vfio common to handle
> +     * ram_block_discard_disable().
> +     */
> +    vbasedev->ram_block_discard_allowed = true;
> +
> +    ret = vfio_attach_device(cdev->mdevid, vbasedev,
> +                             &address_space_memory, errp);
> +    if (ret) {
> +        goto out_attach_dev_err;
>      }
>  
>      vfio_ccw_get_region(vcdev, &err);
> @@ -708,10 +652,9 @@ out_irq_notifier_err:
>  out_io_notifier_err:
>      vfio_ccw_put_region(vcdev);
>  out_region_err:
> -    vfio_ccw_put_device(vcdev);
> -out_device_err:
> -    vfio_put_group(group);
> -out_group_err:
> +    vfio_detach_device(vbasedev);
> +out_attach_dev_err:
> +    g_free(vbasedev->name);
>      if (cdc->unrealize) {
>          cdc->unrealize(cdev);
>      }
> @@ -724,14 +667,13 @@ static void vfio_ccw_unrealize(DeviceState *dev)
>      S390CCWDevice *cdev = S390_CCW_DEVICE(dev);
>      VFIOCCWDevice *vcdev = VFIO_CCW(cdev);
>      S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
> -    VFIOGroup *group = vcdev->vdev.group;
>  
>      vfio_ccw_unregister_irq_notifier(vcdev, VFIO_CCW_REQ_IRQ_INDEX);
>      vfio_ccw_unregister_irq_notifier(vcdev, VFIO_CCW_CRW_IRQ_INDEX);
>      vfio_ccw_unregister_irq_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX);
>      vfio_ccw_put_region(vcdev);
> -    vfio_ccw_put_device(vcdev);
> -    vfio_put_group(group);
> +    vfio_detach_device(&vcdev->vdev);
> +    g_free(vcdev->vdev.name);
>  
>      if (cdc->unrealize) {
>          cdc->unrealize(cdev);
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index f4c33c9858..56cfe94d97 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -2335,7 +2335,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
>      }
>  }
>  
> -VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
> +static VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
>  {
>      VFIOGroup *group;
>      char path[32];
> @@ -2402,7 +2402,7 @@ free_group_exit:
>      return NULL;
>  }
>  
> -void vfio_put_group(VFIOGroup *group)
> +static void vfio_put_group(VFIOGroup *group)
>  {
>      if (!group || !QLIST_EMPTY(&group->device_list)) {
>          return;
> @@ -2447,8 +2447,8 @@ retry:
>      return info;
>  }
>  
> -int vfio_get_device(VFIOGroup *group, const char *name,
> -                    VFIODevice *vbasedev, Error **errp)
> +static int vfio_get_device(VFIOGroup *group, const char *name,
> +                           VFIODevice *vbasedev, Error **errp)
>  {
>      g_autofree struct vfio_device_info *info = NULL;
>      int fd;
> @@ -2506,7 +2506,7 @@ int vfio_get_device(VFIOGroup *group, const char *name,
>      return 0;
>  }
>  
> -void vfio_put_base_device(VFIODevice *vbasedev)
> +static void vfio_put_base_device(VFIODevice *vbasedev)
>  {
>      if (!vbasedev->group) {
>          return;


