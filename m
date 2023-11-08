Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4B17E4F72
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 04:28:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0ZDL-0005ye-6V; Tue, 07 Nov 2023 22:26:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1r0ZDH-0005yK-Ij
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 22:26:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1r0ZDE-0006e7-IR
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 22:26:42 -0500
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A82lELt003583; Wed, 8 Nov 2023 03:26:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=uBBx2HJJ2pbF2duW/LdqW9HCAdfAr0sIDJPk4qQh/Rs=;
 b=hbebXkDOMvtxZa2rjZTzlghzhMj9iyrwCWqGostR8g9Qq0k0WsBeV5/pyMOr7NXQYx5l
 sBSvBV6bvPMs3GhyxpFwTjW5/4T1rrB+IBTZ3mlrXUtdb4iUEH6F4TkKN+nslsaZ/zhI
 w/JhuNZMPM78S/fE/H5p7FObQdKZe8kve8MH029bgPWZSVgm2N6FVwjtJmrBTfuTzvri
 EHmzYIAMMk1qrd0RG5AaFsB1NkfgwYsX1Qhh6G8EExnnrEBmJzASn71rgx1cwnxF1TeI
 Ckb1oe5uHOF3Qd61Wb2sroQqeCDhJGjIDH3ZG8l7EcNNNPuwsnkghvjRja3f2ITz2Q5p YA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u81uq955w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Nov 2023 03:26:37 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A82ldgg005135;
 Wed, 8 Nov 2023 03:26:37 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u81uq955d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Nov 2023 03:26:36 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A82BHtg004112; Wed, 8 Nov 2023 03:26:35 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u7w20t2rx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Nov 2023 03:26:35 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3A83QZal48496906
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Nov 2023 03:26:35 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 360E758060;
 Wed,  8 Nov 2023 03:26:35 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6C7D58056;
 Wed,  8 Nov 2023 03:26:33 +0000 (GMT)
Received: from [9.61.66.47] (unknown [9.61.66.47])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  8 Nov 2023 03:26:33 +0000 (GMT)
Message-ID: <923acaad-4e52-442f-b688-277e87a48469@linux.ibm.com>
Date: Tue, 7 Nov 2023 22:26:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 00/41] vfio: Adopt iommufd
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 "Jason J. Herne" <jjherne@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <d8f1ecdd-4ce8-4811-8efe-6607e71a9f98@redhat.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <d8f1ecdd-4ce8-4811-8efe-6607e71a9f98@redhat.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KVItRMhQlZRshiBD-SHy1bSHTIwsASvl
X-Proofpoint-GUID: Tz91rSNeUxlTIPkug0QU2EAKmb97kE_x
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080027
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 11/7/23 1:28 PM, Cédric Le Goater wrote:
> On 11/2/23 08:12, Zhenzhong Duan wrote:
>> Hi,
>>
>> Thanks all for giving guides and comments on previous series, here is
>> the v4 of pure iommufd support part.
>>
>> Based on Cédric's suggestion, this series includes an effort to remove
>> spapr code from container.c, now all spapr functions are moved to spapr.c
>> or spapr_pci_vfio.c, but there are still a few trival check on
>> VFIO_SPAPR_TCE_*_IOMMU which I am not sure if deserved to introduce many
>> callbacks and duplicate code just to remove them. Some functions are moved
>> to spapr.c instead of spapr_pci_vfio.c to avoid compile issue because
>> spapr_pci_vfio.c is arch specific, or else we need to introduce stub
>> functions to those spapr functions moved.
>>
>>
>> PATCH 1-5: Move spapr functions to spapr*.c
>> PATCH 6-20: Abstract out base container
>> PATCH 21-24: Introduce sparpr container and its specific interface
> 
> PATCH 6-24 applied to vfio-next :
> 
>   https://github.com/legoater/qemu/commits/vfio-next
> 
> (with a global s/fucntional/functional/)
> 
> 
> I also pushed the remaining patches on :
> 
>   https://github.com/legoater/qemu/commits/vfio-8.2
> 
> with a slight rework of the IOMMUFD configuration, now done per platform.
> The VFIO frontend and the 'iommufd' object are only available on x86_64,
> arm, s390x.

FYI, I first tried this vfio-8.2 branch on s390x but wasn't actually able to use the iommufd backend (was getting errors like Property 'vfio-pci.iommufd' not found) so I think something isn't actually enabling IOMMUFD as expected with your change...

Instead I tested on s390x using vfio-next + patches 25-41 of this series on top.  

Legacy backend regression testing worked fine for vfio-pci, vfio-ap and vfio-ccw.

Using iommufd backend for vfio-pci on s390 exposes an s390-only issue related to accounting of vfio DMA limit (code in hw/s390x/s390-pci-vfio.c assumes VFIODevice.group is never null, but that's no longer true when we use the iommufd backend with cdev).  We don't even need to track this when using the iommufd backend -- With that issue bypassed, vfio-pci testing on s390x looks good so far.  I'll send a separate fix for that.

Using the iommufd backend for vfio-ccw and vfio-ap did not work, see response to patch 28.

Thanks,
Matt


