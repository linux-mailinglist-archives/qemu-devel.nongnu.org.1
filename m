Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 235A4791992
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 16:21:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdAS2-0002cH-Ve; Mon, 04 Sep 2023 10:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qdARi-0002a3-Ay; Mon, 04 Sep 2023 10:20:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qdARf-0004kW-B5; Mon, 04 Sep 2023 10:20:54 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 384E8QPe007877; Mon, 4 Sep 2023 14:20:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=G7EfF76p318BFmMe7QIRQ35pxvuo59k0nIPK10By/6g=;
 b=Jntk1D2OwdflvJdjLl6OrLeON+g4n5Cm1MvBmTVe84VimAm11dXAh0DnglbRX+7BUFhe
 Zuubo5wM885sWLAB+qqqn1uQ4lvEQo55/aAJJ2+Bd1kUs5jW3HJJAlAeExL7iPYcHl7I
 7wt9I6BP++j4ylUWsLqpCQZGNSzRIOxMHFn24IHEoxoeUJUPGQYDd6OinkBAFvxDpyCd
 PHNZ6+uVh7LffmOVoVzy0FwyngqKcKFre6FBvW1f/xb9U1kC+jVu5ZiQ7EiAOGRWFUMs
 uyHfkj6H4aQb1SVLQVQ5WaydvDzlOhwaSytd5+gensOpag4G9VRAzzakgWlDSZ7b5dwo bg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sw7sqeyaw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Sep 2023 14:20:45 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 384EAmiK016421;
 Mon, 4 Sep 2023 14:20:44 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sw7sqeyaj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Sep 2023 14:20:44 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 384EK422021459; Mon, 4 Sep 2023 14:20:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svfry3fh1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 Sep 2023 14:20:43 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 384EKfbt11469566
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 4 Sep 2023 14:20:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 371EA20040;
 Mon,  4 Sep 2023 14:20:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC3102004B;
 Mon,  4 Sep 2023 14:20:40 +0000 (GMT)
Received: from [9.171.57.13] (unknown [9.171.57.13])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  4 Sep 2023 14:20:40 +0000 (GMT)
Message-ID: <b25fa578d588f29a7dc3f7817f0e6ea253647b11.camel@linux.ibm.com>
Subject: Re: [risu PATCH 2/4] s390x: Add simple s390x.risu file
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson
 <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>
Date: Mon, 04 Sep 2023 16:20:40 +0200
In-Reply-To: <20230904140040.33153-3-thuth@redhat.com>
References: <20230904140040.33153-1-thuth@redhat.com>
 <20230904140040.33153-3-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OIt0zypOK4UAhBaqrhSXT5NjFSfvA63a
X-Proofpoint-ORIG-GUID: 9Z1u05iBkEhf2f_4pfv6T5amTBf-Ybfc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_07,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0
 phishscore=0 mlxlogscore=993 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309040126
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Mon, 2023-09-04 at 16:00 +0200, Thomas Huth wrote:
> This only adds a limited set of s390x instructions for initial
> testing.
> More instructions will be added later.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
> =C2=A0s390x.risu | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
> =C2=A01 file changed, 48 insertions(+)
> =C2=A0create mode 100644 s390x.risu

Can this be somehow automatically derived from
target/s390x/tcg/insn-data.h.inc?

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>

