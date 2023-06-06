Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20110724D14
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 21:29:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6cMy-00056D-Rt; Tue, 06 Jun 2023 15:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q6cMn-00053V-NQ; Tue, 06 Jun 2023 15:29:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q6cMl-0002VU-Gk; Tue, 06 Jun 2023 15:29:17 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 356JN1se023941; Tue, 6 Jun 2023 19:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=n78VaPQMM4BWAcNTYBayvcjW5p5AXnzFDxlYIAeRgIM=;
 b=fmt6DQ4U9H2aD727ghjtUZkzwinBII4Q51EMjiCQr0zmxq6aiwWqIX9thhMSANCUGpFG
 koHB8kLwzVmWTglFw/RTQig/DP85bRYF7SngRDHQvmU5deIWtwCE+bpGKgy7rQWuZrIw
 tZZwSXYYeXBPj1sZwwdVBNSToHC3ILozwuXN3YOsIVavHmZmzdeW/b4HrlrHVnZIYDyE
 IHRExZV1wJlW2WKpEwclX+wBLwWCfFqJ4i4rxmW4HJzZDuo9pYeANSe3KdoS68vRPdJb
 BX3biJNfy1lIj0NU7nrNhlM0ja1Q000tu124ejSMZ0xtvK3GpY2fukcJaQ3lu935u5HM +A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r2awmr40j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jun 2023 19:29:13 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 356JNjCm027051;
 Tue, 6 Jun 2023 19:29:12 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r2awmr3yj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jun 2023 19:29:12 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 356IZD8K014735;
 Tue, 6 Jun 2023 19:29:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3r2a77g1qx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jun 2023 19:29:10 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 356JT8mP44892530
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Jun 2023 19:29:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2378420043;
 Tue,  6 Jun 2023 19:29:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C31A20040;
 Tue,  6 Jun 2023 19:29:07 +0000 (GMT)
Received: from [9.171.41.107] (unknown [9.171.41.107])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Jun 2023 19:29:07 +0000 (GMT)
Message-ID: <3c3df53d22f6f122cd389a9ed748c1655f8d77a6.camel@linux.ibm.com>
Subject: Re: [PATCH v3 2/8] linux-user: Add "safe" parameter to
 do_guest_openat()
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, Alex
 =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Laurent Vivier
 <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, David
 Hildenbrand <david@redhat.com>
Cc: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
Date: Tue, 06 Jun 2023 21:29:07 +0200
In-Reply-To: <ad49111a-5dd9-671b-f18f-009a7eae73b0@linaro.org>
References: <20230606132743.1386003-1-iii@linux.ibm.com>
 <20230606132743.1386003-3-iii@linux.ibm.com>
 <ad49111a-5dd9-671b-f18f-009a7eae73b0@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BCib8dL1E-XC1SvputxouHPyBhQ_jmjm
X-Proofpoint-ORIG-GUID: _dUF8T9s6hA8na34JGvTTX2v5gFWywa7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_14,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=696 phishscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306060163
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
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

On Tue, 2023-06-06 at 11:24 -0700, Richard Henderson wrote:
> On 6/6/23 06:27, Ilya Leoshkevich wrote:
> > @@ -8518,7 +8522,11 @@ int do_guest_openat(CPUArchState *cpu_env,
> > int dirfd, const char *pathname,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return fd;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=20
> > -=C2=A0=C2=A0=C2=A0 return safe_openat(dirfd, path(pathname), flags, mo=
de);
> > +=C2=A0=C2=A0=C2=A0 if (safe) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return safe_openat(dirfd, p=
ath(pathname), flags, mode);
> > +=C2=A0=C2=A0=C2=A0 } else {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return openat(dirfd, path(p=
athname), flags, mode);
> > +=C2=A0=C2=A0=C2=A0 }
> > =C2=A0 }
>=20
> I'm not keen on this, as it seems like the wrong abstraction.=C2=A0 But I
> can't immediately=20
> think of how it could be better structured.

I also thought about temporarily clearing signal_pending in gdbstub,
but could not convince myself that this were safe.

> The only concrete objection I have is the change of API, which could
> be fixed with return=20
> get_errno(openat(...)).

I believe both openat() and safe_openat() return -1 on error and set
errno, or am I missing something?

>=20
> With that,
>=20
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>=20
>=20
> r~


