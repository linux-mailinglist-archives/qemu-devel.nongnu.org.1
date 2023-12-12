Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BC680ECDA
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 14:09:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD2VS-0006hf-54; Tue, 12 Dec 2023 08:09:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1rD2VP-0006hP-Uq; Tue, 12 Dec 2023 08:08:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1rD2VB-000606-8M; Tue, 12 Dec 2023 08:08:59 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3BCBWg7M028897; Tue, 12 Dec 2023 13:08:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=hxKZmEWC9IDUkm6EN4NmDIVbuFTOOmioTZHSLMLmXVA=;
 b=FglRLw2TCLpGCqjAOUZuvbrRI6+dYhdrB6aai3GfQKVU7e/a7ujOZQ20jnDdQ43Ruc10
 ljjfmMEnlno4Jxe3RwSqILPr4Lta5yZmHkOJHsdWMoBDUhqmtj7DBlZEFV7KlH1TxYlt
 q5HeLyijmH9ZSUzSHUvYFZ3P0rhHvMlt57CJG7UGVKgH2aJdWF9hILbzaNWFyuRBb0J7
 PVLPcXEZ4FnXds7adyYnHlB+YCoef20l5wkk9w6igvFQcxSM3I7PyRPFxBopZhtxIkM9
 aCIwcb0jEG9bVdgTKIzUV8M1tcEkQaOfHK4p1TRvYTGtjnTORAyFE1xgTWrBJCMMTqHi Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uxpqttmc2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Dec 2023 13:08:39 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BCCfe5S026653;
 Tue, 12 Dec 2023 13:08:39 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uxpqttmbk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Dec 2023 13:08:39 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3BCBA7Db028248; Tue, 12 Dec 2023 13:08:38 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw2xyh7x4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Dec 2023 13:08:37 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3BCD8YSo17564230
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Dec 2023 13:08:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C321720043;
 Tue, 12 Dec 2023 13:08:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2240420040;
 Tue, 12 Dec 2023 13:08:34 +0000 (GMT)
Received: from [9.171.43.249] (unknown [9.171.43.249])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Dec 2023 13:08:34 +0000 (GMT)
Message-ID: <a5560c21-658d-436c-a26f-87066b152d0a@linux.ibm.com>
Date: Tue, 12 Dec 2023 14:08:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hw/s390x/ipl: Remove unused 'exec/exec-all.h'
 included header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
References: <20231212113640.30287-1-philmd@linaro.org>
 <20231212113640.30287-4-philmd@linaro.org>
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20231212113640.30287-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FWq5_CfQKHEd94MOxrtUN-U-QP3Tnbl6
X-Proofpoint-GUID: ltH24Obo9JEsnhcjeFXLB4ZQg6W9cxK4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_06,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 phishscore=0 spamscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312120103
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



Am 12.12.23 um 12:36 schrieb Philippe Mathieu-Daudé:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/s390x/ipl.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 515dcf51b5..62182d81a0 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -35,7 +35,6 @@
>   #include "qemu/cutils.h"
>   #include "qemu/option.h"
>   #include "standard-headers/linux/virtio_ids.h"
> -#include "exec/exec-all.h"

Philippe,

This include came with
commit a30fb811cbe940020a498d2cdac9326cac38b4d9
Author:     David Hildenbrand <david@redhat.com>
AuthorDate: Tue Apr 24 12:18:59 2018 +0200
Commit:     Cornelia Huck <cohuck@redhat.com>
CommitDate: Mon May 14 17:10:02 2018 +0200

     s390x: refactor reset/reipl handling

And I think one reason was

cpu_loop_exit

This is still part of ipl.c

a30fb811cbe (David Hildenbrand      2018-04-24 12:18:59 +0200 664)     /* as this is triggered by a CPU, make sure to exit the loop */
a30fb811cbe (David Hildenbrand      2018-04-24 12:18:59 +0200 665)     if (tcg_enabled()) {
a30fb811cbe (David Hildenbrand      2018-04-24 12:18:59 +0200 666)         cpu_loop_exit(cs);
a30fb811cbe (David Hildenbrand      2018-04-24 12:18:59 +0200 667)     }

So why do you think exec-all.h is unused?



