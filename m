Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 735C97D117F
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 16:24:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtqPN-0006ys-PG; Fri, 20 Oct 2023 10:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1qtqPK-0006rt-UP; Fri, 20 Oct 2023 10:23:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1qtqPI-0004oc-U3; Fri, 20 Oct 2023 10:23:22 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39KEJWw2018578; Fri, 20 Oct 2023 14:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=SrMHY3CRYkIOD3mjbA6Z73jblHu5H+NkQF3k3JsNmIM=;
 b=rmwmBbm2Q+YA+hW/9NZz/2P2TeYI1FUS+8i8VCGKn2RmZC0C5uUgyFQOJ9bCCH9qIyJw
 Rn8ikoXtNqlxwM/pNrJVm5MSvSo0zc2z2cpZB4CtRjt7lwB6++DU711bGCk6SfPWDuot
 LFnxPm8zG8CCJPWrLY8Ojk7LeHjpNeKZm02vqHwKoBhIy61DCdasLA8n2B71zkV4QH6o
 JHhLn23Q2bmYUQCNhsYrDyBIUq2EcBM7aTQqwkYuxNbi4sRcQpIAjp1tE1ShklIC+MXs
 laG3f7aYxVJ9sN/dEMy69c9PEPNbCYujlEFj+4dQAmy+kMeUBZGad0JFx91oTfhqsXBa 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tuu7bg53f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Oct 2023 14:23:17 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39KEJX1b018644;
 Fri, 20 Oct 2023 14:23:17 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tuu7bg52y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Oct 2023 14:23:16 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39KC4nG6029794; Fri, 20 Oct 2023 14:23:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tuc47n27u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Oct 2023 14:23:16 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39KENCT346727440
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Oct 2023 14:23:12 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB1572004B;
 Fri, 20 Oct 2023 14:23:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9A4F420040;
 Fri, 20 Oct 2023 14:23:12 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 20 Oct 2023 14:23:12 +0000 (GMT)
Date: Fri, 20 Oct 2023 16:23:11 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Eric Farman <farman@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: Fix a couple s390 paths
Message-ID: <20231020162311.468c16fe@p-imbrenda>
In-Reply-To: <20231020141509.2096591-1-farman@linux.ibm.com>
References: <20231020141509.2096591-1-farman@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: toelGxtsrLLdtXeKc1biNgMjrbeKYLRq
X-Proofpoint-ORIG-GUID: 2qyHk8BY1kB70QVOzlbBQF-y1k4aiauu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=736 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1011 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310200117
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=imbrenda@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Fri, 20 Oct 2023 16:15:09 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> These are simple typos, since the directories don't exist but the
> files themselves do in hw/s390x/
> 
> Fixes: 56e3483402 ("MAINTAINERS: split out s390x sections")
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9bd4fe378d..ac71eff7fa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2574,7 +2574,7 @@ M: Halil Pasic <pasic@linux.ibm.com>
>  M: Christian Borntraeger <borntraeger@linux.ibm.com>
>  S: Supported
>  F: hw/s390x/storage-keys.h
> -F: hw/390x/s390-skeys*.c
> +F: hw/s390x/s390-skeys*.c
>  L: qemu-s390x@nongnu.org
>  
>  S390 storage attribute device
> @@ -2582,7 +2582,7 @@ M: Halil Pasic <pasic@linux.ibm.com>
>  M: Christian Borntraeger <borntraeger@linux.ibm.com>
>  S: Supported
>  F: hw/s390x/storage-attributes.h
> -F: hw/s390/s390-stattrib*.c
> +F: hw/s390x/s390-stattrib*.c
>  L: qemu-s390x@nongnu.org
>  
>  S390 floating interrupt controller


