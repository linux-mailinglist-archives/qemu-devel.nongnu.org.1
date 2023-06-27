Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BACE73F8CF
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 11:31:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE51c-00051X-EN; Tue, 27 Jun 2023 05:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1qE51M-00050A-B3; Tue, 27 Jun 2023 05:30:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1qE51K-0006nA-CA; Tue, 27 Jun 2023 05:30:00 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35R9Lvti002832; Tue, 27 Jun 2023 09:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=r/EvpMD9Ts7C4H9mdgA6fXolIjIEW5oauDpMjB2/7mo=;
 b=o2Otrh07rvE/gangUsLSDYiuVndVTYDU3FEzXNaWN2dZdNEa5u5m6oMSpAV9kDGoSQIm
 rvvLVbIeb4GM8/3QKNLXCgqarW5I3bQOkEfMuwET23OlNdQvXKgT0DEAWLkGaXu19GFq
 mMBhT87vU0htzLA2jb9aGYBLMVwa3oRtNHBfrkjtv6TbNKv7+5CLOGklTetgxqUue+Z5
 tnEUeMBQ6MIoixMJaim86fCCP5Lc2iLfmY9g51VOlayjVOpEj0oCqXw8j9WnQXAF0JYs
 1xV2UAvPtuqr75j77m7uY9/br6RQEhnr5c1qYQPQGVM9LXR0PUh3QxKlMI1a3hiWJM+d OQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rfw2v04vr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 09:29:53 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35R9ONFP012595;
 Tue, 27 Jun 2023 09:29:53 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rfw2v04v7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 09:29:52 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35R4GHCD018106;
 Tue, 27 Jun 2023 09:29:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3rdr459c0d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 09:29:50 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35R9TlLR21693158
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jun 2023 09:29:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1528420043;
 Tue, 27 Jun 2023 09:29:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B17BC20040;
 Tue, 27 Jun 2023 09:29:46 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Jun 2023 09:29:46 +0000 (GMT)
Date: Tue, 27 Jun 2023 11:27:40 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Christian Borntraeger
 <borntraeger@linux.ibm.com>, mrezanin@redhat.com, Richard Henderson
 <richard.henderson@linaro.org>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clegoate@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, "Jason J .
 Herne" <jjherne@linux.ibm.com>, Marc Hartmayer <mhartmay@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH v2 2/4] pc-bios/s390-ccw: Provide space for initial
 stack frame in start.S
Message-ID: <20230627112740.7359b02b@p-imbrenda>
In-Reply-To: <20230627074703.99608-3-thuth@redhat.com>
References: <20230627074703.99608-1-thuth@redhat.com>
 <20230627074703.99608-3-thuth@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kNGtX-qGSj6vHug4qLjhyBTYYQQUu8CS
X-Proofpoint-GUID: tYnO_SREQ3ucGDA3VTggJGQE9t85xJ8O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_05,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 mlxscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
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

On Tue, 27 Jun 2023 09:47:01 +0200
Thomas Huth <thuth@redhat.com> wrote:

> Providing the space of a stack frame is the duty of the caller,
> so we should reserve 160 bytes before jumping into the main function.
> Otherwise the main() function might write past the stack array.
>=20
> While we're at it, add a proper STACK_SIZE macro for the stack size
> instead of using magic numbers (this is also required for the following
> patch).
>=20
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>


with Marc's suggestion applied:

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  pc-bios/s390-ccw/start.S | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
> index d29de09cc6..29b0a9ece0 100644
> --- a/pc-bios/s390-ccw/start.S
> +++ b/pc-bios/s390-ccw/start.S
> @@ -10,10 +10,12 @@
>   * directory.
>   */
> =20
> +#define STACK_SIZE 0x8000
> +
>      .globl _start
>  _start:
> =20
> -    larl    %r15,stack + 0x8000     /* Set up stack */
> +    larl    %r15,stack + STACK_SIZE - 160   /* Set up stack */
> =20
>      /* clear bss */
>      larl    %r2,__bss_start


