Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0124A76BF0A
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 23:12:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQwel-0000sw-EH; Tue, 01 Aug 2023 17:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qQwei-0000r9-Vv
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:11:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qQweh-00069h-3l
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:11:48 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 371L9DnH009727; Tue, 1 Aug 2023 21:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=wM2LStXAhSBqao9CJS/YQSxw0LsW4U229m9MlvCXPRo=;
 b=QgP9b6WCcUb58rQSGANDzI6UjGUnHKMDlpRCAwu1lgY3WA4++eURqyfvH35sFDWKh5nY
 oDsLs5bhybIcTfu/nzbRD23nLlBPtLXYZ0vJJjZA+I/k/RB6b68WP91QYDA5ORaYwEha
 dy0nlYX7O1G/6qpRdStT0/nVqoKVkbu2Nf8TKQ4H3nSywXJAEgwP/Lf7ef3X8pCPrxjc
 Nl4OyyuOFkJXZFXpiQs35V4z4jPwnUEnSSrEhlrViwqpQzgEalES0etEIaIDRYNcOxmB
 f9Vgq0WRTImHMlWgiUvC7aIIhQF531i6DttpXeL5kKxJCiqDdmZLikWfwEL0GhBplRLD 0A== 
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s791wh37t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Aug 2023 21:11:42 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 371JFalJ017127; Tue, 1 Aug 2023 21:11:41 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s5fajpsax-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Aug 2023 21:11:41 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 371LBdpp43843840
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Aug 2023 21:11:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D4572004E;
 Tue,  1 Aug 2023 21:11:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A0522004B;
 Tue,  1 Aug 2023 21:11:39 +0000 (GMT)
Received: from [9.179.21.93] (unknown [9.179.21.93])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  1 Aug 2023 21:11:38 +0000 (GMT)
Message-ID: <922a658a278cf241e7ca0f49b2249c7d5a6871b6.camel@linux.ibm.com>
Subject: Re: [PATCH] gdbstub: use 0 ("any process") on packets with no PID
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, bcain@quicinc.com, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Date: Tue, 01 Aug 2023 23:11:38 +0200
In-Reply-To: <78a3b06f6ab90a7ff8e73ae14a996eb27ec76c85.1690904195.git.quic_mathbern@quicinc.com>
References: <78a3b06f6ab90a7ff8e73ae14a996eb27ec76c85.1690904195.git.quic_mathbern@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1u4YE25UP6dDSzwUByDWNh_KMEA11nk3
X-Proofpoint-ORIG-GUID: 1u4YE25UP6dDSzwUByDWNh_KMEA11nk3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_19,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 clxscore=1011 mlxlogscore=841 spamscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308010188
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Tue, 2023-08-01 at 12:37 -0300, Matheus Tavares Bernardino wrote:
> Previously, qemu-user would always report PID 1 to GDB. This was
> changed
> at dc14a7a6e9 (gdbstub: Report the actual qemu-user pid, 2023-06-30),
> but read_thread_id() still considers GDB packets with "no PID" as
> "PID
> 1", which is not the qemu-user PID. Fix that by parsing "no PID" as
> "0",
> which the GDB Remote Protocol defines as "any process".
>=20
> Note that this should have no effect for system emulation as, in this
> case, gdb_create_default_process() will assign PID 1 for the first
> process and that is what the gdbstub uses for GDB requests with no
> PID,
> or PID 0.
>=20
> This issue was found with hexagon-lldb, which sends a "Hq" packet
> with
> only the thread-id, but no process-id, leading to the invalid usage
> of
> "PID 1" by qemu-hexagon and a subsequent "E22" reply.

Did you mean "Hg"?

> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> ---
> =C2=A0gdbstub/gdbstub.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)

The change looks good to me.
Thanks for looking into this and sorry for the breakage.

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>

