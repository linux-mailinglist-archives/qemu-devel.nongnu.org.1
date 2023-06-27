Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FDD73F8CC
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 11:30:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE51e-00052i-Ct; Tue, 27 Jun 2023 05:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1qE51M-00050B-E5; Tue, 27 Jun 2023 05:30:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1qE51K-0006nU-F5; Tue, 27 Jun 2023 05:30:00 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35R9Gdl9004026; Tue, 27 Jun 2023 09:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=x606jwniIKW2Tcq8Fz6dT8e4QPuMoks1nFu47AIpEmU=;
 b=rHQ/xVZWkmLkYKTw7mAT8LwF/LVYjfoinZM0nsKzMqn87Z00PlISgfxPT+ig03It6d0D
 yrVM5K78GOwtRstjqZxzaNMPk3vBMDNL1pn2Od7tj9ZlQV3RuRTw+puFo2yY2YAiy+wY
 1SfmoLtRjuaHXCJcMmVrILPICbKdmaCfc0MBdECnH+HlPYMnCZ6ylPF5hDp4NdLVkssm
 DDDcjtUO+++g6mqpsbCfC7h4vdhiIvyncEQY+rIvzhzy6XLo0ySCvMy9fHIxmLx1o9ez
 SOPqOoiJKp+DJzOezqNXPCM6SLbT/wlVluT+D9fumDL0otJD2qI6HIQFWzpYBeQoOTNH Mg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rfw0d0a4s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 09:29:56 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35R9K2Ex015625;
 Tue, 27 Jun 2023 09:29:56 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rfw0d0a4a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 09:29:55 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35R4mKxS010013;
 Tue, 27 Jun 2023 09:29:54 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3rdr459c0e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 09:29:53 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35R9ToEG24707756
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jun 2023 09:29:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 726F220040;
 Tue, 27 Jun 2023 09:29:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 30A112004B;
 Tue, 27 Jun 2023 09:29:50 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Jun 2023 09:29:50 +0000 (GMT)
Date: Tue, 27 Jun 2023 11:27:14 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Christian Borntraeger
 <borntraeger@linux.ibm.com>, mrezanin@redhat.com, Richard Henderson
 <richard.henderson@linaro.org>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clegoate@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, "Jason J .
 Herne" <jjherne@linux.ibm.com>, Marc Hartmayer <mhartmay@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH v2 1/4] pc-bios/s390-ccw: Fix indentation in start.S
Message-ID: <20230627112714.2b7e263f@p-imbrenda>
In-Reply-To: <20230627074703.99608-2-thuth@redhat.com>
References: <20230627074703.99608-1-thuth@redhat.com>
 <20230627074703.99608-2-thuth@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qDLfMaN8IuSLA4SP42ISjcti2paIymTv
X-Proofpoint-ORIG-GUID: TsTIqWsdhb6eC70C27yNKh4S4kW4KzeT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_05,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270086
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

On Tue, 27 Jun 2023 09:47:00 +0200
Thomas Huth <thuth@redhat.com> wrote:

> start.S is currently indented with a mixture of spaces and tabs, which
> is quite ugly. QEMU coding style says indentation should be 4 spaces,
> and this is also what we are using in the assembler files in the
> tests/tcg/s390x/ folder already, so let's adjust start.S accordingly.
>=20
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  pc-bios/s390-ccw/start.S | 136 +++++++++++++++++++--------------------
>  1 file changed, 68 insertions(+), 68 deletions(-)
>=20
> diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
> index 6072906df4..d29de09cc6 100644
> --- a/pc-bios/s390-ccw/start.S
> +++ b/pc-bios/s390-ccw/start.S
> @@ -10,37 +10,37 @@
>   * directory.
>   */
> =20
> -        .globl _start
> +    .globl _start
>  _start:
> =20
> -	larl   %r15, stack + 0x8000	/* Set up stack */
> +    larl    %r15,stack + 0x8000     /* Set up stack */
> =20
> -	/* clear bss */
> -	larl %r2, __bss_start
> -	larl %r3, _end
> -	slgr %r3, %r2		/* get sizeof bss */
> -	ltgr	%r3,%r3 	/* bss empty? */
> -	jz	done
> -	aghi	%r3,-1
> -	srlg	%r4,%r3,8	/* how many 256 byte chunks? */
> -	ltgr	%r4,%r4
> -	lgr	%r1,%r2
> -	jz	remainder
> +    /* clear bss */
> +    larl    %r2,__bss_start
> +    larl    %r3,_end
> +    slgr    %r3,%r2    /* get sizeof bss */
> +    ltgr    %r3,%r3    /* bss empty? */
> +    jz      done
> +    aghi    %r3,-1
> +    srlg    %r4,%r3,8  /* how many 256 byte chunks? */
> +    ltgr    %r4,%r4
> +    lgr     %r1,%r2
> +    jz      remainder
>  loop:
> -	xc	0(256,%r1),0(%r1)
> -	la	%r1,256(%r1)
> -	brctg	%r4,loop
> +    xc      0(256,%r1),0(%r1)
> +    la      %r1,256(%r1)
> +    brctg   %r4,loop
>  remainder:
> -	larl	%r2,memsetxc
> -	ex	%r3,0(%r2)
> +    larl    %r2,memsetxc
> +    ex      %r3,0(%r2)
>  done:
> -        /* set up a pgm exception disabled wait psw */
> -        larl	%r2, disabled_wait_psw
> -        mvc	0x01d0(16), 0(%r2)
> -        j      main		/* And call C */
> +    /* set up a pgm exception disabled wait psw */
> +    larl    %r2,disabled_wait_psw
> +    mvc     0x01d0(16),0(%r2)
> +    j       main       /* And call C */
> =20
>  memsetxc:
> -	xc	0(1,%r1),0(%r1)
> +    xc      0(1,%r1),0(%r1)
> =20
> =20
>  /*
> @@ -48,11 +48,11 @@ memsetxc:
>   *
>   * stops the current guest cpu.
>   */
> -	.globl disabled_wait
> +    .globl disabled_wait
>  disabled_wait:
> -	larl	%r1,disabled_wait_psw
> -	lpswe	0(%r1)
> -1:	j	1b
> +    larl    %r1,disabled_wait_psw
> +    lpswe   0(%r1)
> +1:  j       1b
> =20
> =20
>  /*
> @@ -60,61 +60,61 @@ disabled_wait:
>   *
>   * eats one sclp interrupt
>   */
> -        .globl consume_sclp_int
> +    .globl consume_sclp_int
>  consume_sclp_int:
> -        /* enable service interrupts in cr0 */
> -        stctg   %c0,%c0,0(%r15)
> -        oi      6(%r15),0x2
> -        lctlg   %c0,%c0,0(%r15)
> -        /* prepare external call handler */
> -        larl %r1, external_new_code
> -        stg %r1, 0x1b8
> -        larl %r1, external_new_mask
> -        mvc 0x1b0(8),0(%r1)
> -        /* load enabled wait PSW */
> -        larl %r1, enabled_wait_psw
> -        lpswe 0(%r1)
> +    /* enable service interrupts in cr0 */
> +    stctg   %c0,%c0,0(%r15)
> +    oi      6(%r15),0x2
> +    lctlg   %c0,%c0,0(%r15)
> +    /* prepare external call handler */
> +    larl    %r1,external_new_code
> +    stg     %r1,0x1b8
> +    larl    %r1,external_new_mask
> +    mvc     0x1b0(8),0(%r1)
> +    /* load enabled wait PSW */
> +    larl    %r1,enabled_wait_psw
> +    lpswe   0(%r1)
> =20
>  /*
>   * void consume_io_int(void)
>   *
>   * eats one I/O interrupt
>   */
> -        .globl consume_io_int
> +    .globl consume_io_int
>  consume_io_int:
> -        /* enable I/O interrupts in cr6 */
> -        stctg %c6,%c6,0(%r15)
> -        oi    4(%r15), 0xff
> -        lctlg %c6,%c6,0(%r15)
> -        /* prepare i/o call handler */
> -        larl  %r1, io_new_code
> -        stg   %r1, 0x1f8
> -        larl  %r1, io_new_mask
> -        mvc   0x1f0(8),0(%r1)
> -        /* load enabled wait PSW */
> -        larl  %r1, enabled_wait_psw
> -        lpswe 0(%r1)
> +    /* enable I/O interrupts in cr6 */
> +    stctg   %c6,%c6,0(%r15)
> +    oi      4(%r15), 0xff
> +    lctlg   %c6,%c6,0(%r15)
> +    /* prepare i/o call handler */
> +    larl    %r1,io_new_code
> +    stg     %r1,0x1f8
> +    larl    %r1,io_new_mask
> +    mvc     0x1f0(8),0(%r1)
> +    /* load enabled wait PSW */
> +    larl    %r1,enabled_wait_psw
> +    lpswe   0(%r1)
> =20
>  external_new_code:
> -        /* disable service interrupts in cr0 */
> -        stctg   %c0,%c0,0(%r15)
> -        ni      6(%r15),0xfd
> -        lctlg   %c0,%c0,0(%r15)
> -        br      %r14
> +    /* disable service interrupts in cr0 */
> +    stctg   %c0,%c0,0(%r15)
> +    ni      6(%r15),0xfd
> +    lctlg   %c0,%c0,0(%r15)
> +    br      %r14
> =20
>  io_new_code:
> -        /* disable I/O interrupts in cr6 */
> -        stctg %c6,%c6,0(%r15)
> -        ni    4(%r15), 0x00
> -        lctlg %c6,%c6,0(%r15)
> -        br    %r14
> +    /* disable I/O interrupts in cr6 */
> +    stctg   %c6,%c6,0(%r15)
> +    ni      4(%r15),0x00
> +    lctlg   %c6,%c6,0(%r15)
> +    br      %r14
> =20
> -        .align  8
> +    .align  8
>  disabled_wait_psw:
> -        .quad   0x0002000180000000,0x0000000000000000
> +    .quad   0x0002000180000000,0x0000000000000000
>  enabled_wait_psw:
> -        .quad   0x0302000180000000,0x0000000000000000
> +    .quad   0x0302000180000000,0x0000000000000000
>  external_new_mask:
> -        .quad   0x0000000180000000
> +    .quad   0x0000000180000000
>  io_new_mask:
> -        .quad   0x0000000180000000
> +    .quad   0x0000000180000000


