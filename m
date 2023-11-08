Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 112B27E4F41
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 04:01:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Ync-0002Ul-EO; Tue, 07 Nov 2023 22:00:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1r0YnZ-0002UY-6G
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 22:00:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1r0YnW-0001jr-TA
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 22:00:08 -0500
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A82sjgb014446; Wed, 8 Nov 2023 03:00:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=kIX92bjWN9maTGzw8Ty38xlNAraM5axxvc4yumVETrc=;
 b=mqkVaumFDFEQTmcPLQw9EVUN80bzt0FRSmVgwvHHMxO9RLadbOHRjqa2rnIpA/gVQQ47
 yYe0yXv+OuahpHhkI6bqsjZhNuPtb5eabeNHkgip46RyTwp60JCp3jUR8YFdkzgTafbf
 Ie437jV9ata6MRrTiBGtFyv7skgXr/UZePZV0Zs3+CNmqRMy7lwvAY46gRewFPdzwLww
 J0vl8wpFHgNqdXBTi1XpF3qOIDSZe1UpVqUfPry4PXI+7SkgtR0GgUs49pEDOacXO9Pg
 srG4CR7Gl/XvepEd0Tw1l92cv16JLnPH+vHggxycDo/6aGQubD2Ysz7PvDCJSq5jursA aA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u81y8036k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Nov 2023 03:00:02 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A82ss6X014605;
 Wed, 8 Nov 2023 03:00:01 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u81y8035e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Nov 2023 03:00:01 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A82I8K7003435; Wed, 8 Nov 2023 03:00:00 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u7w21sxu4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Nov 2023 03:00:00 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3A82xxNl50266516
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Nov 2023 03:00:00 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A109858065;
 Wed,  8 Nov 2023 02:59:59 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A959C58059;
 Wed,  8 Nov 2023 02:59:57 +0000 (GMT)
Received: from [9.61.66.47] (unknown [9.61.66.47])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  8 Nov 2023 02:59:57 +0000 (GMT)
Message-ID: <76538479-77ec-1a7d-cee1-906f6f758cff@linux.ibm.com>
Date: Tue, 7 Nov 2023 21:59:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 28/41] vfio/iommufd: Implement the iommufd backend
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 "Jason J. Herne" <jjherne@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-29-zhenzhong.duan@intel.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20231102071302.1818071-29-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nXDogSe-X2E-gkFjrkJZLsft13cMrthW
X-Proofpoint-ORIG-GUID: p11hJryrvVOGmoiDNjVl3FgzKysNNtmg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=975 clxscore=1011 bulkscore=0 impostorscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080023
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.344,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 11/2/23 3:12 AM, Zhenzhong Duan wrote:
> From: Yi Liu <yi.l.liu@intel.com>
> 
> Add the iommufd backend. The IOMMUFD container class is implemented
> based on the new /dev/iommu user API. This backend obviously depends
> on CONFIG_IOMMUFD.
> 
> So far, the iommufd backend doesn't support dirty page sync yet due
> to missing support in the host kernel.
> 
> Co-authored-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---

[...]

> +static int iommufd_cdev_attach_container(VFIODevice *vbasedev,
> +                                         VFIOIOMMUFDContainer *container,
> +                                         Error **errp)
> +{
> +    int ret, iommufd = vbasedev->iommufd->fd;
> +    VFIOIOASHwpt *hwpt;
> +    uint32_t hwpt_id;
> +    Error *err = NULL;
> +
> +    /* try to attach to an existing hwpt in this container */
> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
> +        ret = iommufd_cdev_attach_hwpt(vbasedev, hwpt->hwpt_id, &err);
> +        if (ret) {
> +            const char *msg = error_get_pretty(err);
> +
> +            trace_iommufd_cdev_fail_attach_existing_hwpt(msg);
> +            error_free(err);
> +            err = NULL;
> +        } else {
> +            goto found_hwpt;
> +        }
> +    }
> +
> +    ret = iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
> +                                     container->ioas_id, &hwpt_id);
> +
> +    if (ret) {
> +        error_setg_errno(errp, errno, "error alloc shadow hwpt");
> +        return ret;
> +    }

The above alloc_hwpt fails for mdevs (at least, it fails for me attempting to use iommufd backend with vfio-ccw and vfio-ap on s390).  The ioctl is failing in the kernel because it can't find an IOMMUFD_OBJ_DEVICE.

AFAIU that's because the mdevs are meant to instead use kernel access via vfio_iommufd_emulated_attach_ioas, not hwpt.  That's how mdevs behave when looking at the kernel vfio compat container.

As a test, I was able to get vfio-ccw and vfio-ap working using the iommufd backend by just skipping this alloc_hwpt above and instead passing container->ioas_id into the iommufd_cdev_attach_hwpt below.  That triggers the vfio_iommufd_emulated_attach_ioas call in the kernel.

> +
> +    /* Attach cdev to a new allocated hwpt within iommufd */
> +    ret = iommufd_cdev_attach_hwpt(vbasedev, hwpt_id, errp);
> +    if (ret) {
> +        iommufd_backend_free_id(iommufd, hwpt_id);
> +        return ret;
> +    }
> +
> +    hwpt = iommufd_container_get_hwpt(container, hwpt_id);
> +found_hwpt:
> +    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, next);
> +    vbasedev->hwpt = hwpt;
> +
> +    trace_iommufd_cdev_attach_container(iommufd, vbasedev->name, vbasedev->fd,
> +                                        container->ioas_id, hwpt->hwpt_id);
> +    return ret;
> +}


