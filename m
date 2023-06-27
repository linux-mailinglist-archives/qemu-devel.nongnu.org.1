Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3298773F8C8
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 11:30:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE51h-00055T-3I; Tue, 27 Jun 2023 05:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1qE51P-00051h-PU; Tue, 27 Jun 2023 05:30:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1qE51N-0006pp-QR; Tue, 27 Jun 2023 05:30:03 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35R9IISl023600; Tue, 27 Jun 2023 09:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=M0im3BXmgP7t93pwzG2xJVerSxZvLUvNt8+eepFRAOI=;
 b=bFUg6rGz/+RwnIYZ1xdBHTCYeAXYPU4jn1clcgcbVSlchGYEwxMnuTNvdjKVJGOPB1fe
 lAPQ608nB0WysrRB4YTy+lMbia8ie/PNFs/vvuwmpFh2J4VwB4LcV8AgVUPfS/7HLbJY
 QQGbgVA2gIrX9qyR4h2v9/KjHMiiCfaGUruZBANL0tLcl9sc6+ksI/Fmob1CnvSFIme9
 X5wF7YaBuXdOq1JGVExLVlBkonDIq9cdfLewO4sIxVHtc69epJMvENG9DZjPuvYdCYNk
 Yp5I+rEC4FgfFCUPDpwRG0G8HhUs4cQq6JfUQzuwQ8nxTi8+nvL7ARHYCWa77LEc8P7Y hw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rfw0xr8m6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 09:29:58 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35R9KG8f029992;
 Tue, 27 Jun 2023 09:29:58 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rfw0xr8km-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 09:29:57 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35R3GAFg008662;
 Tue, 27 Jun 2023 09:29:55 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3rdr451rtx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 09:29:55 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35R9Tquv53674298
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jun 2023 09:29:52 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3247B20043;
 Tue, 27 Jun 2023 09:29:52 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D9E2320040;
 Tue, 27 Jun 2023 09:29:51 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Jun 2023 09:29:51 +0000 (GMT)
Date: Tue, 27 Jun 2023 11:28:13 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Christian Borntraeger
 <borntraeger@linux.ibm.com>, mrezanin@redhat.com, Richard Henderson
 <richard.henderson@linaro.org>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clegoate@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, "Jason J .
 Herne" <jjherne@linux.ibm.com>, Marc Hartmayer <mhartmay@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH v2 3/4] pc-bios/s390-ccw: Move the stack array into start.S
Message-ID: <20230627112813.1bebddfd@p-imbrenda>
In-Reply-To: <20230627074703.99608-4-thuth@redhat.com>
References: <20230627074703.99608-1-thuth@redhat.com>
 <20230627074703.99608-4-thuth@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7M8o7lLqv1QSb9gnatDdptk8dKJ_0jNN
X-Proofpoint-ORIG-GUID: Qty6Kr6J6eqCpBmaVSdZkYadvs0sgJaE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_05,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501 mlxlogscore=999
 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270086
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=imbrenda@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
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

On Tue, 27 Jun 2023 09:47:02 +0200
Thomas Huth <thuth@redhat.com> wrote:

> The stack array is only referenced from the start-up code (which is
> shared between the s390-ccw.img and the s390-netboot.img), but it is
> currently declared twice, once in main.c and once in netmain.c.
> It makes more sense to declare this in start.S instead - which will
> also be helpful in the next patch, since we need to mention the .bss
> section in start.S in that patch.
> 
> While we're at it, let's also drop the huge alignment of the stack,
> since there is no technical requirement for aligning it to page
> boundaries.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  pc-bios/s390-ccw/s390-ccw.h | 1 -
>  pc-bios/s390-ccw/main.c     | 1 -
>  pc-bios/s390-ccw/netmain.c  | 1 -
>  pc-bios/s390-ccw/start.S    | 6 ++++++
>  4 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index b88e0550ab..91afcbbca9 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -55,7 +55,6 @@ void consume_io_int(void);
>  /* main.c */
>  void write_subsystem_identification(void);
>  void write_iplb_location(void);
> -extern char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
>  unsigned int get_loadparm_index(void);
>  void main(void);
>  
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index a2def83e82..5506798098 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -17,7 +17,6 @@
>  #include "virtio-scsi.h"
>  #include "dasd-ipl.h"
>  
> -char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
>  static SubChannelId blk_schid = { .one = 1 };
>  static char loadparm_str[LOADPARM_LEN + 1];
>  QemuIplParameters qipl;
> diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
> index 056e93a818..5cd619b2d6 100644
> --- a/pc-bios/s390-ccw/netmain.c
> +++ b/pc-bios/s390-ccw/netmain.c
> @@ -50,7 +50,6 @@ void write_iplb_location(void) {}
>  /* STSI 3.2.2 offset of first vmdb + offset of uuid inside vmdb */
>  #define STSI322_VMDB_UUID_OFFSET ((8 + 12) * 4)
>  
> -char stack[PAGE_SIZE * 8] __attribute__((aligned(PAGE_SIZE)));
>  IplParameterBlock iplb __attribute__((aligned(PAGE_SIZE)));
>  static char cfgbuf[2048];
>  
> diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
> index 29b0a9ece0..111dea261b 100644
> --- a/pc-bios/s390-ccw/start.S
> +++ b/pc-bios/s390-ccw/start.S
> @@ -120,3 +120,9 @@ external_new_mask:
>      .quad   0x0000000180000000
>  io_new_mask:
>      .quad   0x0000000180000000
> +
> +.bss
> +    .align  8
> +stack:
> +    .space  STACK_SIZE
> +    .size   stack,STACK_SIZE


