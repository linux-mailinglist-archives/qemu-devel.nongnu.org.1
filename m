Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B07C0742490
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 12:59:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEpMZ-0002Ht-0a; Thu, 29 Jun 2023 06:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1qEpM9-0002Dk-9d; Thu, 29 Jun 2023 06:58:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1qEpM7-0000Lb-30; Thu, 29 Jun 2023 06:58:33 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35TAvRIP015402; Thu, 29 Jun 2023 10:58:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=N9lt8LxD2HTz3BjXCHBQDbdMDxkMsQiTkoWpHog9ndY=;
 b=k++8wGAzW0Sk0F5S8RCC2Z+C0/iLfJLCDVZNDhsL76xYeInN4qHhb0+cfI8UdR1dTB7q
 T0gPHrRHz2gTmwMVfsm+xek8RySAKnLBNh/2jYfcMaIhBwQDJwFaZkhGuV3GQpc7nHpX
 /FVCQfO+Wj+cnZZ9rsUF+eWHIriI8wtBzOlYzvYL+MOc/dwjAztQJzWyQ7mqGf1EPy6c
 O7uWdw+XHLUET017hlpgzdMsDUBG6cpA48U+E8MV29KR9DtAOrnmlQ4IEoU7gXg52wN4
 06Ye8RxcQBEp4JV7BLvGho7qxEp6IEnDIVF1ZchYGh/bfl3qREjcg+/wqqsujGA2M5CG XA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rh8gt87y3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jun 2023 10:58:27 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35TAn3bc017703;
 Thu, 29 Jun 2023 10:58:26 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rh8gt87ww-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jun 2023 10:58:26 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35T60hJB007159;
 Thu, 29 Jun 2023 10:58:24 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3rdr45afq5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jun 2023 10:58:24 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35TAwKXQ13239032
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jun 2023 10:58:20 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A58720040;
 Thu, 29 Jun 2023 10:58:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 127732004B;
 Thu, 29 Jun 2023 10:58:20 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Jun 2023 10:58:19 +0000 (GMT)
Date: Thu, 29 Jun 2023 12:58:18 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH v3 7/7] pc-bios/s390-ccw: Don't use __bss_start with the
 "larl" instruction
Message-ID: <20230629125818.09ec8ad6@p-imbrenda>
In-Reply-To: <20230629104821.194859-8-thuth@redhat.com>
References: <20230629104821.194859-1-thuth@redhat.com>
 <20230629104821.194859-8-thuth@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QaH3Xl5b-BPj-uIzCqEuqP5hFKBasAJC
X-Proofpoint-ORIG-GUID: mQCMmXjvL5qE0HQAlo5Z8TaX6Zxbiefs
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_02,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290094
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=imbrenda@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On Thu, 29 Jun 2023 12:48:21 +0200
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
> Fix it by loading the address indirectly instead.

what are the advantages of this solution compared to your previous one
(i.e. align .bss) ?

> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2216662
> Reported-by: Miroslav Rezanina <mrezanin@redhat.com>
> Suggested-by:  Andreas Krebbel <andreas.krebbel@de.ibm.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/start.S | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
> index 429a2b30a1..061b06591c 100644
> --- a/pc-bios/s390-ccw/start.S
> +++ b/pc-bios/s390-ccw/start.S
> @@ -19,7 +19,8 @@ _start:
>      larl    %r15,stack + STACK_SIZE - STACK_FRAME_SIZE   /* Set up stack */
>  
>      /* clear bss */
> -    larl    %r2,__bss_start
> +    larl    %r2,bss_start_literal   /* __bss_start might be unaligned ... */
> +    lg      %r2,0(%r2)              /* ... so load it indirectly */
>      larl    %r3,_end
>      slgr    %r3,%r2    /* get sizeof bss */
>      ltgr    %r3,%r3    /* bss empty? */
> @@ -45,7 +46,6 @@ done:
>  memsetxc:
>      xc      0(1,%r1),0(%r1)
>  
> -
>  /*
>   * void disabled_wait(void)
>   *
> @@ -113,6 +113,8 @@ io_new_code:
>      br      %r14
>  
>      .align  8
> +bss_start_literal:
> +    .quad   __bss_start
>  disabled_wait_psw:
>      .quad   0x0002000180000000,0x0000000000000000
>  enabled_wait_psw:


