Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8A7AE49C4
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Jun 2025 18:08:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTjhs-0004gN-Gj; Mon, 23 Jun 2025 12:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1uTjhW-0004fG-Rs; Mon, 23 Jun 2025 12:07:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1uTjhT-0000us-1v; Mon, 23 Jun 2025 12:07:17 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N9le0o014445;
 Mon, 23 Jun 2025 16:07:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=GVpP1B
 2K7NcZVQ88k9g9h0loQCSOI0gN4T5v2HMRblM=; b=Yh1KGuBSdRqFWl8+pUgmBP
 hdIFA1VN9z301SXCRDtN2UERXV+u8PYtT2mkShWSYmLUu9O44eIxkkaW+zQuPexE
 f0pgqMizUumwoplLKmonsULHEutgqjiI+MLxRTpYJyORiRImL486WZ7Z72Yq0Hrg
 fXv0hWIqyvB2Dq/yofLqTNsZOKm8t+PF+i6RLo53tI2tOAauxHrmNfsvSrv80hqD
 yp/mKzR5gl3SQIoNp5l2NiWY2hA7hBNWA8DTzdrBZZN5ZSxxG7FzSQ9SI5eGtr98
 AtRB7BcbSjtaaHhUCy8IqYg5Y9NvXOo5gob8xpWioXivgKrdfs1NOJuJQPsKewYQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8j396r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 16:07:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55NEI6K8002512;
 Mon, 23 Jun 2025 16:07:09 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e8jkyhf2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 16:07:09 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55NG77JR7537376
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Jun 2025 16:07:07 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C957858063;
 Mon, 23 Jun 2025 16:07:07 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D83B58067;
 Mon, 23 Jun 2025 16:07:06 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.77.138]) by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Jun 2025 16:07:06 +0000 (GMT)
Message-ID: <0eb11342042b75a76d8e4ac49cd570ebece60f1b.camel@linux.ibm.com>
Subject: Re: [PATCH] MAINTAINERS: add reviewers for some s390 areas
From: Eric Farman <farman@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: thuth@redhat.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 alifm@linux.ibm.com, jjherne@linux.ibm.com, walling@linux.ibm.com,
 jrossi@linux.ibm.com, qemu-devel@nongnu.org, zycai@linux.ibm.com
Date: Mon, 23 Jun 2025 12:07:05 -0400
In-Reply-To: <20250623160030.98281-1-mjrosato@linux.ibm.com>
References: <20250623160030.98281-1-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA5NiBTYWx0ZWRfXwxQaVgqPjJq1
 rUGwD3lPy3ebGQKwOoEJFeCuABYYkM0IWJvUTvAIyG0YS2f97fAcceoP106V0KyO+IYyfEFCt3N
 4YpNNlyMYtdFrJusvQQkMhk0MVGsUmHokG9nNE3wEp2w0G2Zs1bcP1doJHRDy1ddH/XpJIYihOz
 TkETJsnA6+z+M7Ny2tCK6Jx5b1dUdTozC87YtGiWNfqHEe6BgfVrPUCELEsh90hFYGId/sdCS4f
 2fxOlOQ3fpcn5EvKMLRntaSOVCCUCIVTfUq5Y7YnBU3tbhOCUfmeKOp4E2OsCMfqh8P+4DNLcU6
 3Xo9Z5h0Scq4rwZ17VsVtSwETEtvfyeFpzAoSmgC3V0qqT/oHFN6uwsS+jNTNKTBM9IRZ9MivKZ
 OffU20sTWv5NcvJ1JFadkhryRzXwKwbUyKTalnB7RBpCfDcvvPKIhNxZOV5FKug89J43mH4F
X-Proofpoint-GUID: M6KcegkEcjNdkNJiDjvuYkLPUyLvcHeH
X-Proofpoint-ORIG-GUID: M6KcegkEcjNdkNJiDjvuYkLPUyLvcHeH
X-Authority-Analysis: v=2.4 cv=combk04i c=1 sm=1 tr=0 ts=68597bae cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=20KFwNOVAAAA:8 a=Kf2Tvuw_2pJ0JA08flIA:9
 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_06,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230096
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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

On Mon, 2025-06-23 at 12:00 -0400, Matthew Rosato wrote:
> To improve review coverage, assign additional people as reviewers for
> multiple s390 sections.
>=20
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>

Acked-by: Eric Farman <farman@linux.ibm.com>

> ---
>  MAINTAINERS | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 94c4076127..3ce6fce8ce 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -459,6 +459,8 @@ F: target/ppc/kvm.c
>  S390 KVM CPUs
>  M: Halil Pasic <pasic@linux.ibm.com>
>  M: Christian Borntraeger <borntraeger@linux.ibm.com>
> +R: Eric Farman <farman@linux.ibm.com>
> +R: Matthew Rosato <mjrosato@linux.ibm.com>
>  S: Supported
>  F: target/s390x/kvm/
>  F: target/s390x/machine.c
> @@ -1771,6 +1773,7 @@ S390 Virtio-ccw
>  M: Halil Pasic <pasic@linux.ibm.com>
>  M: Christian Borntraeger <borntraeger@linux.ibm.com>
>  M: Eric Farman <farman@linux.ibm.com>
> +R: Matthew Rosato <mjrosato@linux.ibm.com>
>  S: Supported
>  F: hw/s390x/
>  F: include/hw/s390x/
> @@ -1782,6 +1785,8 @@ L: qemu-s390x@nongnu.org
>  S390-ccw boot
>  M: Christian Borntraeger <borntraeger@linux.ibm.com>
>  M: Thomas Huth <thuth@redhat.com>
> +R: Jared Rossi <jrossi@linux.ibm.com>
> +R: Zhuoying Cai <zycai@linux.ibm.com>
>  S: Supported
>  F: hw/s390x/ipl.*
>  F: pc-bios/s390-ccw/
> @@ -1802,6 +1807,7 @@ S390 channel subsystem
>  M: Halil Pasic <pasic@linux.ibm.com>
>  M: Christian Borntraeger <borntraeger@linux.ibm.com>
>  M: Eric Farman <farman@linux.ibm.com>
> +R: Farhan Ali <alifm@linux.ibm.com>
>  S: Supported
>  F: hw/s390x/ccw-device.[ch]
>  F: hw/s390x/css.c
> @@ -1822,6 +1828,7 @@ L: qemu-s390x@nongnu.org
>  S390 SCLP-backed devices
>  M: Halil Pasic <pasic@linux.ibm.com>
>  M: Christian Borntraeger <borntraeger@linux.ibm.com>
> +R: Jason Herne <jjherne@linux.ibm.com>
>  S: Supported
>  F: include/hw/s390x/event-facility.h
>  F: include/hw/s390x/sclp.h
> @@ -2809,6 +2816,7 @@ F: include/hw/timer/mips_gictimer.h
>  S390 3270 device
>  M: Halil Pasic <pasic@linux.ibm.com>
>  M: Christian Borntraeger <borntraeger@linux.ibm.com>
> +R: Collin Walling <walling@linux.ibm.com>
>  S: Odd fixes
>  F: include/hw/s390x/3270-ccw.h
>  F: hw/char/terminal3270.c
> @@ -2818,6 +2826,7 @@ L: qemu-s390x@nongnu.org
>  S390 diag 288 watchdog
>  M: Halil Pasic <pasic@linux.ibm.com>
>  M: Christian Borntraeger <borntraeger@linux.ibm.com>
> +R: Collin Walling <walling@linux.ibm.com>
>  S: Supported
>  F: hw/watchdog/wdt_diag288.c
>  F: include/hw/watchdog/wdt_diag288.h
> @@ -2826,6 +2835,7 @@ L: qemu-s390x@nongnu.org
>  S390 storage key device
>  M: Halil Pasic <pasic@linux.ibm.com>
>  M: Christian Borntraeger <borntraeger@linux.ibm.com>
> +R: Jason Herne <jjherne@linux.ibm.com>
>  S: Supported
>  F: hw/s390x/storage-keys.h
>  F: hw/s390x/s390-skeys*.c
> @@ -2834,6 +2844,7 @@ L: qemu-s390x@nongnu.org
>  S390 storage attribute device
>  M: Halil Pasic <pasic@linux.ibm.com>
>  M: Christian Borntraeger <borntraeger@linux.ibm.com>
> +R: Jason Herne <jjherne@linux.ibm.com>
>  S: Supported
>  F: hw/s390x/storage-attributes.h
>  F: hw/s390x/s390-stattrib*.c
> @@ -2843,6 +2854,7 @@ S390 floating interrupt controller
>  M: Halil Pasic <pasic@linux.ibm.com>
>  M: Christian Borntraeger <borntraeger@linux.ibm.com>
>  M: David Hildenbrand <david@redhat.com>
> +R: Jason Herne <jjherne@linux.ibm.com>
>  S: Supported
>  F: hw/intc/s390_flic*.c
>  F: include/hw/s390x/s390_flic.h

