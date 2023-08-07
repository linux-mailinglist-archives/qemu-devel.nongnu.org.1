Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DBE771C0C
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 10:11:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSvK9-0006pG-1T; Mon, 07 Aug 2023 04:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qSvK3-0006oa-Lq; Mon, 07 Aug 2023 04:10:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qSvJz-0000wQ-75; Mon, 07 Aug 2023 04:10:37 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3778A0nA032695; Mon, 7 Aug 2023 08:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ssXNVX+zZd/lEprh8qHPs3UkazgFRHUonQryaO7tHiY=;
 b=CAY1AGOEVogaJ5ZkpOMnPZnxYNuNBAj9sCc0QgFXdmwzSi8wXFbhGgyaClqoFy8iptyN
 0mCcGEl3iZ9nlx+uQATYN+2OvnDX68OMuc/ObPD3PeWSS4Zectnv/ArNDqpyH2RatyBt
 o3CANdcUxY/kvSZjRnVRCMxbQrS7WGQWmW2DVEdDMP48LeIxLaoFgE56ZfUel9JIhbcd
 XHrjTKPxNk27CXc/l75YwCXDihiBuji5uW83Mao5DPxY/pvYeyyKDYli8EUt9DPducNt
 o4zh36ZkHMEbDZS4tiqikHSNUot7XDz+YMkB5UkVCyp3Xfk20WjGv+Yydj+37izbpd9K TQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3savkrrbnv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Aug 2023 08:10:32 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3778AW9s002718;
 Mon, 7 Aug 2023 08:10:32 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3savkrrbnf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Aug 2023 08:10:32 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3777e9uI001796; Mon, 7 Aug 2023 08:10:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sa3f1aqa3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Aug 2023 08:10:31 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3778ATxc28508770
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 7 Aug 2023 08:10:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C3D42004E;
 Mon,  7 Aug 2023 08:10:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E0F5B20040;
 Mon,  7 Aug 2023 08:10:28 +0000 (GMT)
Received: from [9.171.18.187] (unknown [9.171.18.187])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  7 Aug 2023 08:10:28 +0000 (GMT)
Message-ID: <558f087ae3f7e13a202f1e7ddda22e5996066269.camel@linux.ibm.com>
Subject: Re: [PATCH 2/3] target/s390x: Fix the "ignored match" case in VSTRS
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Claudio Fontana
 <cfontana@suse.de>, qemu-stable@nongnu.org
Date: Mon, 07 Aug 2023 10:10:28 +0200
In-Reply-To: <5ea25092-b362-0587-5ad0-f3883cc86ba1@redhat.com>
References: <20230804233748.218935-1-iii@linux.ibm.com>
 <20230804233748.218935-3-iii@linux.ibm.com>
 <5ea25092-b362-0587-5ad0-f3883cc86ba1@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4f3L-3WXtJ4YHSyAcQJs0xq_vaohS31r
X-Proofpoint-GUID: 3zNZAUhGxkZT-f8xWZAiAuEiPl03rAWl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_06,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=938 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070074
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On Sat, 2023-08-05 at 10:02 +0200, David Hildenbrand wrote:
> On 05.08.23 01:03, Ilya Leoshkevich wrote:
> > Currently the emulation of VSTRS recognizes partial matches in
> > presence
> > of \0 in the haystack, which, according to PoP, is not correct:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 If the ZS flag is one and a zero byte was dete=
cted
> > =C2=A0=C2=A0=C2=A0=C2=A0 in the second operand, then there can not be a
> > =C2=A0=C2=A0=C2=A0=C2=A0 partial match ...
> >=20
> > Add a check for this. While at it, fold a number of explicitly
> > handled
> > special cases into the generic logic.
>=20
> Can we split that off? Or doesn't it make sense to split it off after
> fixing the issue?

I could do this if this is important, e.g., for stable, but I came to
the conclusion that I needed to get rid of the special cases after I
had to add the new check to more than one place.

