Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB456772BF7
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 19:03:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT3dA-00071n-Ku; Mon, 07 Aug 2023 13:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qT3d6-00070R-31; Mon, 07 Aug 2023 13:02:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qT3d2-0007s0-Jy; Mon, 07 Aug 2023 13:02:51 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 377H0esa022501; Mon, 7 Aug 2023 17:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=JSLfH1vQo+/IlC6Tg+PVYn3VvTmxR1DA+MDUaivgYRs=;
 b=Dz5omgJ+eZP+C5q8ow/jDJgfaNHQvq8g9g6mm4mZWqUTEYw/hh0u9Y929ZwYuoeZUOJo
 czFG5k+Xv0rtXXxwuzztRC5ZnvjXUvxV+nCZ6K4qjhxfth81PMs1h5rGtSeGNsbXjDjc
 rx8ukKZ+T9PeK5K7Ilc6TNl+iJ/5lfn3DIJrHzjbd2jW4FucfKRy1dMqd6+KkaPMWGVm
 EmYi4yWEWeESF1ieSRG3XX5Ak/0QkQczeZndxWIKWa2NzKgztoCZcZFd3Lxe3fMIIl3k
 q1sP56pHib2mIDLSzyAdIRtrWq9nLBWjzYl/90sFLIa2st75QYMGJgKyHdEnFmBGBTEl Lw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sb4mq817n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Aug 2023 17:02:45 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 377H2iGD029243;
 Mon, 7 Aug 2023 17:02:44 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sb4mq817a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Aug 2023 17:02:44 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 377FlZIk015377; Mon, 7 Aug 2023 17:02:44 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sb3f2ggs4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Aug 2023 17:02:44 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 377H2gQJ18219610
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 7 Aug 2023 17:02:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 455F22004D;
 Mon,  7 Aug 2023 17:02:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D676020043;
 Mon,  7 Aug 2023 17:02:41 +0000 (GMT)
Received: from [9.179.26.52] (unknown [9.179.26.52])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  7 Aug 2023 17:02:41 +0000 (GMT)
Message-ID: <558af8b33fa9164b0a5a21f61aa583a3776784f7.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] target/s390x: Use a 16-bit immediate in VREP
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Date: Mon, 07 Aug 2023 19:02:41 +0200
In-Reply-To: <baa436ac-ffe4-8c7d-6eee-af9c26fe3c0f@redhat.com>
References: <20230807163459.849766-1-iii@linux.ibm.com>
 <baa436ac-ffe4-8c7d-6eee-af9c26fe3c0f@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wvPJ3mlJQXKBDAIqIFA8unNpEMUCAx8x
X-Proofpoint-GUID: YnEEmFB6megM3782kzxMvr1ys9TrIXOj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_17,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0 spamscore=0
 mlxlogscore=932 impostorscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070153
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
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

On Mon, 2023-08-07 at 19:00 +0200, David Hildenbrand wrote:
> On 07.08.23 18:34, Ilya Leoshkevich wrote:
> > Unlike most other instructions that contain an immediate element
> > index,
> > VREP's one is 16-bit, and not 4-bit. The code uses only 8 bits, so
> > using, e.g., 0x101 does not lead to a specification exception.
> >=20
> > Fix by checking all 16 bits.
> >=20
> > Cc: qemu-stable@nongnu.org
>=20
> Just curious, why stable? Are there valid programs that set invalid=20
> element size and they are fixed by this?

None that I know of, but I thought this was still nice to have, and at
the same time small enough to not cause any trouble.

> LGTM
>=20
> Reviewed-by: David Hildenbrand <david@redhat.com>

[...]
>=20

