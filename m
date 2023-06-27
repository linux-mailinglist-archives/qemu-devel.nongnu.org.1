Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB8773F715
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 10:27:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE425-0002H2-Ro; Tue, 27 Jun 2023 04:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1qE423-0002Gi-3W; Tue, 27 Jun 2023 04:26:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1qE420-0008B4-LR; Tue, 27 Jun 2023 04:26:38 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35R8HhkX013435; Tue, 27 Jun 2023 08:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=HtzG+Nn/kCLer3i5MBmA9ueQHmgYhlfFfFyzTno2Nb8=;
 b=MZ2Zp+Kbk5fUkWGmTHn0lOAhGyZcZSyZFMAIWnVblLgV4UUq8jZZAYr5uuLpoYs/kh/T
 y5ZwqYwmGHYE6IlMbWQ1dLHXhtkT4h2bPjDO0Vy0hsj6uT1oCPIB0zfNMapDykmN/UkA
 SDwThQcN9gY6oSFuTFU62/F7gFZGsWhYf59tQ1JIeD0eKLoepiDs88PyX1Mx205FkbrM
 HZ9geVnX5ktE+rMW6F8LeGceUcsXGe7+ET+ylODrIGRWlnDXluAXfRuatbEbCQ03y4CM
 7ZYI98rV8MeSl3RbF6g4MGO9SomBTl14etpGXRgQml0OjKuTOIeShv5Rda7k1a2tSrkg bQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rfv4fg66d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 08:26:31 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35R8LXPH026663;
 Tue, 27 Jun 2023 08:26:31 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rfv4fg65g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 08:26:31 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35R7KKOm000764;
 Tue, 27 Jun 2023 08:26:28 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3rdqre1b6r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 08:26:28 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35R8QOH656033590
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jun 2023 08:26:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B0BA420043;
 Tue, 27 Jun 2023 08:26:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F025E20040;
 Tue, 27 Jun 2023 08:26:23 +0000 (GMT)
Received: from li-1de7cd4c-3205-11b2-a85c-d27f97db1fe1.ibm.com (unknown
 [9.171.44.52]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 27 Jun 2023 08:26:23 +0000 (GMT)
From: "Marc Hartmayer" <mhartmay@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 mrezanin@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clegoate@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, "Jason J . Herne"
 <jjherne@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Claudio
 Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v2 2/4] pc-bios/s390-ccw: Provide space for initial
 stack frame in start.S
In-Reply-To: <20230627074703.99608-3-thuth@redhat.com>
References: <20230627074703.99608-1-thuth@redhat.com>
 <20230627074703.99608-3-thuth@redhat.com>
Date: Tue, 27 Jun 2023 10:26:22 +0200
Message-ID: <877crp9uq9.fsf@li-1de7cd4c-3205-11b2-a85c-d27f97db1fe1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FFhFwH6a8TNe91z_7867r95MOZcl-gDc
X-Proofpoint-GUID: gPtv28wR6HK3ygn7u1FTVbvM9h5zok1T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_04,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270076
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mhartmay@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Thomas Huth <thuth@redhat.com> writes:

> Providing the space of a stack frame is the duty of the caller,
> so we should reserve 160 bytes before jumping into the main function.
> Otherwise the main() function might write past the stack array.
>
> While we're at it, add a proper STACK_SIZE macro for the stack size
> instead of using magic numbers (this is also required for the following
> patch).
>
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/start.S | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
> index d29de09cc6..29b0a9ece0 100644
> --- a/pc-bios/s390-ccw/start.S
> +++ b/pc-bios/s390-ccw/start.S
> @@ -10,10 +10,12 @@
>   * directory.
>   */
>=20=20
> +#define STACK_SIZE 0x8000
> +
>      .globl _start
>  _start:
>=20=20
> -    larl    %r15,stack + 0x8000     /* Set up stack */
> +    larl    %r15,stack + STACK_SIZE - 160   /* Set up stack */
                                         ^^^
                                         You can also add a macro for this
                                         - e.g. STACK_FRAME_SIZE.

Besides that,
Reviewed-by: Marc Hartmayer <mhartmay@linux.ibm.com>

>=20=20
>      /* clear bss */
>      larl    %r2,__bss_start
> --=20
> 2.39.3
>
--=20
Kind regards / Beste Gr=C3=BC=C3=9Fe
   Marc Hartmayer

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Gregor Pillen=20
Gesch=C3=A4ftsf=C3=BChrung: David Faller
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

