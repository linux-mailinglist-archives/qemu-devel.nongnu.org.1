Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 015977E4157
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:58:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Ma2-0003DW-W1; Tue, 07 Nov 2023 08:57:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1r0Ma0-0003D1-S8; Tue, 07 Nov 2023 08:57:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1r0MZy-0001LL-G7; Tue, 07 Nov 2023 08:57:20 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A7DYEHY011505; Tue, 7 Nov 2023 13:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=7NdpCFNspD2z3ZcdMI85bq/sD4j7PJb7YdC2o0bLDm0=;
 b=lshaJHTvvnlSBsdT9AouDZBWMcNPWCCTux0CdoKAlE70An2bdYstRFbXf7oG42d22VmT
 PKJ60k+wxHqu7HgHzGgHgwiZj/Wm78jofiIP72skP5MZF3rxsGuQIXv9THcfhgViWLW3
 BQGAIMtXkZ5v+bRg0au1dETzMeLCnu6eXatH+iYonTk+kD03eSbPj6+qGX7A1+KTrB0/
 rpJVBUvndG50GDdSS54iEtHg0dVPOP/AzsPvEtc3b+Z/m4/znMtat3+TaA4ygLCByilU
 HS8QbcBGCD9KawxfC3Co893WuBej45dZBBv6JWmyhVIaS2IlqTSy0tpwhK759Q2t3OJG +A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7m71n382-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Nov 2023 13:57:14 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A7DhiTZ011705;
 Tue, 7 Nov 2023 13:57:14 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7m71n37n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Nov 2023 13:57:14 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A7CHF9D012887; Tue, 7 Nov 2023 13:57:13 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u609ss7w5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Nov 2023 13:57:13 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3A7DvCmU8323632
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Nov 2023 13:57:13 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D30C458064;
 Tue,  7 Nov 2023 13:57:12 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5375F58056;
 Tue,  7 Nov 2023 13:57:12 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.80.60]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Nov 2023 13:57:12 +0000 (GMT)
Message-ID: <e6ff98c2690df6d20f2a7a9dc49eb37ecd884353.camel@linux.ibm.com>
Subject: Re: [PATCH] s390/sclp: fix SCLP facility map
From: Eric Farman <farman@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Date: Tue, 07 Nov 2023 08:57:12 -0500
In-Reply-To: <f9a4c0bd-347e-4f26-9690-c27a6266a1e9@redhat.com>
References: <20231024100703.929679-1-hca@linux.ibm.com>
 <0cb53eda95889a41d485b993003a10600a7d4424.camel@linux.ibm.com>
 <f9a4c0bd-347e-4f26-9690-c27a6266a1e9@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4o4_NcHUmbDeagJPT5ZajkVHWz8NiYnK
X-Proofpoint-GUID: cXA5SvoAoXXGUIeqPkw5i7-BfPWWP5AB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_04,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0
 mlxlogscore=878 adultscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311070114
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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

On Tue, 2023-11-07 at 10:45 +0100, Thomas Huth wrote:
> On 02/11/2023 19.50, Eric Farman wrote:
> > (+cc qemu-devel)
> >=20
> > On Tue, 2023-10-24 at 12:07 +0200, Heiko Carstens wrote:
> > > Qemu's SCLP implementation incorrectly reports that it supports
> > > CPU
> > > reconfiguration. If a guest issues a CPU reconfiguration request
> > > it
> > > is rejected as invalid command.
> > >=20
> > > Fix the SCLP_HAS_CPU_INFO mask, and remove the unused
> > > SCLP_CMDW_CONFIGURE_CPU and SCLP_CMDW_DECONFIGURE_CPU defines.
> > >=20
> > > Reviewed-by: Eric Farman <farman@linux.ibm.com>
> > > Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> > > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> > > ---
> > > =C2=A0=C2=A0include/hw/s390x/sclp.h | 4 +---
> > > =C2=A0=C2=A01 file changed, 1 insertion(+), 3 deletions(-)
> >=20
> > Thomas, any concerns? Could this get picked up for 8.2, please?
>=20
> Sorry, been away from keyboard for the last 10 days... queued it now!

Ah, nice, hope it was refreshing. Thank you!

Eric

