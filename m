Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 348187E06F6
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 17:47:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyxIQ-0002VT-W1; Fri, 03 Nov 2023 12:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qyxIO-0002Um-Jc; Fri, 03 Nov 2023 12:45:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qyxI9-0006wi-2W; Fri, 03 Nov 2023 12:45:20 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A3GBLVY008542; Fri, 3 Nov 2023 16:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=S8iUcBn0EoU7C1Xa9hRucvLUjG0XiFlvD5eNxxIhJlU=;
 b=E/peyoOBF7OB0qCr+F4I50uqHoJUzZtOoUQOOKu5ansugw6vtIAXGtswLLYW2M4bVgVw
 iO24PGiUf+yP8vRO+bFZHsDKTmZJjFHo9RmvTDXgqrgBw++MNO1N3qb8sJpL40qTOVDa
 rZvN9Iv07/VY95yZHCU4Z7Bq6DVYJNwdKTwbPgefK8i5qIzd+9rSKJ7oOWRMqcqQVeG5
 VgjjK9q8NL6AJ2bA8ESCuyoRAtaWd8MWPNnQ9Y1NpnOlhnwc1kuYiWVcERq4f+Aw1qWa
 iD9cwmBv1/infYlEYDm1QRiSlyKp7hVJG1cpW8MgSOeKYUWv3SJwTskTII8OfmmAW+8j 5w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u53td9tmb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Nov 2023 16:44:58 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A3Giw7T009823;
 Fri, 3 Nov 2023 16:44:58 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u53td9tm0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Nov 2023 16:44:57 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A3GOAYr000598; Fri, 3 Nov 2023 16:44:57 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u1cmtqhqs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Nov 2023 16:44:56 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3A3Gita666060658
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Nov 2023 16:44:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3932F2004B;
 Fri,  3 Nov 2023 16:44:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C737820043;
 Fri,  3 Nov 2023 16:44:54 +0000 (GMT)
Received: from [9.171.47.192] (unknown [9.171.47.192])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Nov 2023 16:44:54 +0000 (GMT)
Message-ID: <cbbffb85272fab70d1051d98ce024031215afe6e.camel@linux.ibm.com>
Subject: Re: [PATCH 0/4] target/s390x: CC fixes
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Date: Fri, 03 Nov 2023 17:44:54 +0100
In-Reply-To: <a7d962b5-d9d2-41f6-9f28-b84490cad0f8@redhat.com>
References: <20231031053718.347100-1-iii@linux.ibm.com>
 <a7d962b5-d9d2-41f6-9f28-b84490cad0f8@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -IZX1f-VmmqhlsEI7n79vkQobIrwBGv0
X-Proofpoint-GUID: W_6VYuBJ3VkQXGv6sCwWlGv4TosNa5u5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=901
 lowpriorityscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 phishscore=0 clxscore=1015 bulkscore=0 mlxscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311030139
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Tue, 2023-10-31 at 09:38 +0100, David Hildenbrand wrote:
> On 31.10.23 06:32, Ilya Leoshkevich wrote:
> > Hi,
> >=20
> > This series fixes two issues with updating CC. David was suggesting
> > a
> > bigger rewrite [1], but I did not dare do this (yet). Instead,
> > these
>=20
> I started coding that up but was distracted by other things; last
> time I=20
> looked at that, I concluded that the way we are calculating the carry
> in=20
> not suitable when we're doing two additions (like ADD LOGICAL WITH
> CARRY).

Do you per chance remember any details? IIUC the code in question is:

static DisasJumpType op_addc64(DisasContext *s, DisasOps *o)
{
    compute_carry(s);

    TCGv_i64 zero =3D tcg_constant_i64(0);
    tcg_gen_add2_i64(o->out, cc_src, o->in1, zero, cc_src, zero);
    tcg_gen_add2_i64(o->out, cc_src, o->out, cc_src, o->in2, zero);

    return DISAS_NEXT;
}

This looks correct to me, because the 128-bit result of the first
addition is passed fully to the second addition, and the upper half is
always either 0 or 1.

I played with chaining ADD-LOGICAL-WITH-CARRYs with various inputs, and
could not produce any wrong calculations in the emulation.

Best regards,
Ilya

[...]

