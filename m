Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92578C1C750
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Oct 2025 18:33:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEA14-00019u-Kn; Wed, 29 Oct 2025 13:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1vEA10-00018r-JR; Wed, 29 Oct 2025 13:31:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1vEA0v-0002Nj-B9; Wed, 29 Oct 2025 13:31:18 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TC6kVm025645;
 Wed, 29 Oct 2025 17:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=4gFkqj
 BO3ir5S3IoEaEdkpnJb4+vml9MAqUFNDsQcFo=; b=Bp3wWLe4PdsB80QJv+yjWx
 XTXz8JrKdVpSikhfpfk2vGd1yF1p8WOxSRRt8MVGSbGH2EfmzxnanoyFhyUU2d8F
 P98nhn30ccxvN3btrbqerjMSo9hdN9dzsDIucMeUzrx6SOWON9xrAJj8zSk6tM/X
 A2lT4GAd5T35PF8g4bYkXLtds0Lg6YJ14DwnB550LqWgtpbKl1ZqtjJF61UD/cyx
 /qlaQ1C50DufyQBniJL+lyCnextvugIlwJ0qDolQFcZjX+kv8JHsngbT8s9mZHS3
 cQ7rQ1uOOM8PQFBlsnn1YvwWy/jV7ksis0L4wu/k6pkjBHUk4OopsY+jAC5I55Qw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34acmpne-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Oct 2025 17:30:27 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59THPuf7017089;
 Wed, 29 Oct 2025 17:30:27 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34acmpnb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Oct 2025 17:30:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59TGdDp3030759;
 Wed, 29 Oct 2025 17:30:25 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a33wwmmjs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Oct 2025 17:30:25 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59THUL6a36503908
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Oct 2025 17:30:21 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A00302004E;
 Wed, 29 Oct 2025 17:30:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D1F9F20040;
 Wed, 29 Oct 2025 17:30:19 +0000 (GMT)
Received: from [9.39.29.62] (unknown [9.39.29.62])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Oct 2025 17:30:19 +0000 (GMT)
Message-ID: <1f952d10-9630-42d6-8d24-b7461f90aa9f@linux.ibm.com>
Date: Wed, 29 Oct 2025 23:00:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] hw/ppc/spapr: Remove deprecated pseries-3.0 ->
 pseries-4.2 machines
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>,
 qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20251021084346.73671-1-philmd@linaro.org>
 <aPdpjysqFBAMTvG-@kitsune.suse.cz>
Content-Language: en-US
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
In-Reply-To: <aPdpjysqFBAMTvG-@kitsune.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XbuEDY55 c=1 sm=1 tr=0 ts=69024f33 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=25UEqmkVfaNy5ATf4DkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=HhbK4dLum7pmb74im6QT:22 a=pHzHmUro8NiASowvMSCR:22
 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-ORIG-GUID: 83c93mqdpwgkSsb4ljr_LNVBPhkayISp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX4zi2Y13/kLCP
 qk5Bpv0P+JNYuWTkRGXHpHO07ebf5v6o3/+UvkWzpnq3i7ZqCLHuhxYADDRGypRYac0+Lp/iMr9
 oWCPA1rS5MwN4+Ebnr0g+lUL0O4sUoD5N9f5Muxh3dx1oHDjYZC7qlL3yKE8000gSNmEmxxd9gl
 ZqhBmoU094o/sNLdhoLqUL5RZH704bT/iXRaCTBOD+6AMBlJaV6TtHljSboYT3+IDfJ47bcmEJY
 jXnoi9kKWKDabskFzi1qodgO+gpqh0WMR9IzTxiLtPDhBUolZml16CiYHH0InuMPHDfS3dgoONk
 KjuzPW37tZoC+/TIx1Q6qM9wV+LKSrcKQ2CAGRNatdnjaWRmgD5wi75k1tq1+rrKQpLlEWi/SjA
 GAoCCT4F8+Rgbmy6mEwimMW31ARd8g==
X-Proofpoint-GUID: ytzy4QqTsGuIddlfdj5jRmqBe9iBFKzY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166
Received-SPF: pass client-ip=148.163.156.1; envelope-from=sbhat@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Michal,


On 10/21/25 4:37 PM, Michal Suchánek wrote:
> Hello,
>
> I noticed removal of old pSeries revisions.
>
> FTR to boot Linux 3.0 I need pSeries-2.7 (already removed earlier).
>
> The thing that broke booting linux 3.0 for me is
> 357d1e3bc7d2d80e5271bc4f3ac8537e30dc8046 spapr: Improved placement of
> PCI host bridges in guest memory map
>
> I do not use Linux 3.0 anymore which is the reason I did not notice this
> breakage due to old platform revision removal.

I tried booting linux kernel 3.13.0-170-generic from ubuntu 14.04.6 LTS 
with the oldest supported machine pseries-5.0 as of now.

It worked fine.


qemu-system-ppc64 -machine pseries-5.0 -accel tcg -nographic -m size=12G 
-cpu power8 -smp 1 -drive 
file=/root/images/ubuntu16.04.qcow2,format=qcow2,if=none,id=drive-virtio-disk0 
-device virtio-blk-pci,drive=drive-virtio-disk0,id=virtio-disk0 -serial 
mon:stdio -kernel /root/images/vmlinux-3.13.0-170-generic -initrd 
/root/images/initrd.img-3.13.0-170-generic -append 
"BOOT_IMAGE=/boot/vmlinux-4.4.0-142-generic 
root=UUID=94fba90c-dbb0-4f8d-bc3e-acd5f2e54749 ro vt.handoff=7"


shiva@ubuntu:~$ uname -a
Linux ubuntu 3.13.0-170-generic #220-Ubuntu SMP Thu May 9 12:44:25 UTC 
2019 ppc64le ppc64le ppc64le GNU/Linux
shiva@ubuntu:~$ cat /proc/cpuinfo
processor    : 0
cpu        : POWER8 (architected), altivec supported
clock        : 1000.000000MHz
revision    : 2.0 (pvr 004d 0200)

timebase    : 512000000
platform    : pSeries
model        : IBM pSeries (emulated by qemu)
machine        : CHRP IBM pSeries (emulated by qemu)


Hope that helps.


Thanks,

Shivaprasad



