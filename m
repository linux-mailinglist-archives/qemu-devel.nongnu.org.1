Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F25D73F8CD
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 11:30:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE51e-00052g-BM; Tue, 27 Jun 2023 05:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1qE51N-000516-RI; Tue, 27 Jun 2023 05:30:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1qE51K-0006nS-O6; Tue, 27 Jun 2023 05:30:01 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35R9Lv7K002837; Tue, 27 Jun 2023 09:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=6M0msjcWR1Gj17Yy9kJ9nmjPy6YI6N0KvOefuWJvbrU=;
 b=kg6Mo9xBiP58h11RS4t0gkcDYPWffnGamjUbX+G7WjLt6kwqzO8WRIzSoUi//ElzgODA
 hD3dcL47BFK0atuSpZo26xHjDa8mRKKEG4jdB/u8Mu38fQlZNEm3cW04c8FBETb8pxRQ
 H3hbgalRf81OQRkBArgBLctP9AOz1NzfH8PKMmS4JHhpM3PTz6qC6Uj0vJcZDASyT2qB
 x5GxEt8dJi/DRyDqiizToQY6jBZhdj47EaI2j5q3D5t6rwtecwPr67CJW3HHBtOz/RQP
 BKrjGAavTi7r4fnjykcdxg1NGAVkiVfLCgIxI4dHPjoUOGTxDzPKqhcUGVV2wjPIV8JX WA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rfw2v04wd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 09:29:55 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35R9N9Od009554;
 Tue, 27 Jun 2023 09:29:54 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rfw2v04vk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 09:29:54 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35QLkXB5013753;
 Tue, 27 Jun 2023 09:29:52 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3rdqre1rq8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 09:29:52 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35R9TmdM13894152
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jun 2023 09:29:48 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD4A020040;
 Tue, 27 Jun 2023 09:29:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 81E5320043;
 Tue, 27 Jun 2023 09:29:48 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Jun 2023 09:29:48 +0000 (GMT)
Date: Tue, 27 Jun 2023 11:29:39 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Christian Borntraeger
 <borntraeger@linux.ibm.com>, mrezanin@redhat.com, Richard Henderson
 <richard.henderson@linaro.org>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clegoate@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, "Jason J .
 Herne" <jjherne@linux.ibm.com>, Marc Hartmayer <mhartmay@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH v2 4/4] pc-bios/s390-ccw: Don't use __bss_start with the
 "larl" instruction
Message-ID: <20230627112939.7366916c@p-imbrenda>
In-Reply-To: <20230627074703.99608-5-thuth@redhat.com>
References: <20230627074703.99608-1-thuth@redhat.com>
 <20230627074703.99608-5-thuth@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HI9QcHg_7f4_TpXaMiomdvt2T8aHuH2i
X-Proofpoint-GUID: f6LqqQnRaaW7HHjjIjNzjVN-a6kTFvbw
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_05,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 mlxscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306270086
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

On Tue, 27 Jun 2023 09:47:03 +0200
Thomas Huth <thuth@redhat.com> wrote:

> start.S currently cannot be compiled with Clang 16 and binutils 2.40:
> 
>  ld: start.o(.text+0x8): misaligned symbol `__bss_start' (0xc1e5) for
>      relocation R_390_PC32DBL
> 
> According to the built-in linker script of ld, the symbol __bss_start
> can actually point *before* the .bss section and does not need to have
> any alignment, so in certain situations (like when using the internal
> assembler of Clang), the __bss_start symbol can indeed be unaligned
> and thus it is not suitable for being used with the "larl" instruction
> that needs an address that is at least aligned to halfwords.
> The problem went unnoticed so far since binutils <= 2.39 did not
> check the alignment, but starting with binutils 2.40, such unaligned
> addresses are now refused.
> 
> Fix it by using the real start address of the .bss section instead.
> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2216662
> Reported-by: Miroslav Rezanina <mrezanin@redhat.com>
> Suggested-by: Nick Clifton <nickc@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/start.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
> index 111dea261b..a63c4e3ff2 100644
> --- a/pc-bios/s390-ccw/start.S
> +++ b/pc-bios/s390-ccw/start.S
> @@ -18,7 +18,7 @@ _start:
>      larl    %r15,stack + STACK_SIZE - 160   /* Set up stack */
>  
>      /* clear bss */
> -    larl    %r2,__bss_start
> +    larl    %r2,.bss
>      larl    %r3,_end

since we are here, do you have guarantees that _end is always correctly
aligned?

if so:

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

>      slgr    %r3,%r2    /* get sizeof bss */
>      ltgr    %r3,%r3    /* bss empty? */


