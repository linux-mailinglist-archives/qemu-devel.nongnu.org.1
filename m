Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B5B73F98C
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 12:02:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE5W9-0007QE-V1; Tue, 27 Jun 2023 06:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1qE5W5-0007Py-07; Tue, 27 Jun 2023 06:01:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1qE5W2-0005HI-Oz; Tue, 27 Jun 2023 06:01:44 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35R9ouPC032115; Tue, 27 Jun 2023 10:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=gm2a25etprQ8FpsuUp/cI3WIpv5kEFA7dy7URhKaJJY=;
 b=ULUvbWVsyaYIpg4CV3FoFIJEfdNfzjWFmdrDP4Qo4c5z46PTdfXMRS6cEid+rRvmauUc
 8DEfodUaEt+o15KMudi+whXWfsasQQDaPhIXsNJbetTYfg5qSoOzXTauHVxkrpqo2ReH
 J/mOsXw+SlZ6riTtQTyqClDuYwumjHnLDRtKVAdaTFyM7xgnKw+ScBjPEijcAnJ55b3A
 TWV/p4z1ECpdTOgVB37IMHd+ruemJ2TQkmVEKFWwkkVdM//0LLHAlNEXHr475wCAO55f
 sm4+GId2jcBXUhWvGhpOV8Pt6HhxcoVZHmKqwkNQ/bb/AqcHo0Z0Eiy2HbQn2ITZeHng ig== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rfwgb874q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 10:01:14 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35R9p7xa032177;
 Tue, 27 Jun 2023 10:01:14 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rfwgb874c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 10:01:14 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35R72Hmh013240;
 Tue, 27 Jun 2023 10:01:13 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
 by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3rdr45fxkb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 10:01:13 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35RA1CqJ44630420
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jun 2023 10:01:12 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 79ABB5803F;
 Tue, 27 Jun 2023 10:01:12 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3EDCA58054;
 Tue, 27 Jun 2023 10:01:11 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.34.238]) by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Jun 2023 10:01:11 +0000 (GMT)
Message-ID: <03736b7816bfa6dbe17db07edec54cb79cb0e170.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/4] pc-bios/s390-ccw: Fix indentation in start.S
From: Eric Farman <farman@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 mrezanin@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clegoate@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, "Jason J .
 Herne" <jjherne@linux.ibm.com>, Marc Hartmayer <mhartmay@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Date: Tue, 27 Jun 2023 06:01:10 -0400
In-Reply-To: <20230627074703.99608-2-thuth@redhat.com>
References: <20230627074703.99608-1-thuth@redhat.com>
 <20230627074703.99608-2-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: E13VOQRT2XkmRvkdNjJkfyVR7-1Swe-7
X-Proofpoint-ORIG-GUID: FYT0Op6vwnbd9bh5mu7BttEIE2EWAvVK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_06,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 clxscore=1011 mlxscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 mlxlogscore=976
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270090
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Tue, 2023-06-27 at 09:47 +0200, Thomas Huth wrote:
> start.S is currently indented with a mixture of spaces and tabs,
> which
> is quite ugly. QEMU coding style says indentation should be 4 spaces,
> and this is also what we are using in the assembler files in the
> tests/tcg/s390x/ folder already, so let's adjust start.S accordingly.
>=20
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
> =C2=A0pc-bios/s390-ccw/start.S | 136 +++++++++++++++++++-----------------=
-
> --
> =C2=A01 file changed, 68 insertions(+), 68 deletions(-)

Oh, that looks nice. Thank you.

Reviewed-by: Eric Farman <farman@linux.ibm.com>

