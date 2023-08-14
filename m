Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8FE77B235
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 09:19:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVRqi-0004Ia-C7; Mon, 14 Aug 2023 03:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1qVRqb-0004IL-KH
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 03:18:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1qVRqZ-0001Vf-J5
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 03:18:41 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37E6vMHs030736; Mon, 14 Aug 2023 07:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=OjmA+Nt3wOwr3T9Ujec41HbLsw/ug2pbycP5tyWW5To=;
 b=mdhpyQs0rVZc94nOd+9oc9wFGF85+NI6Wdp4Wg6CJdqADRv6xGyyzmnvUKMkmOTdQLPX
 UdfDHFVkedqxbAzkiHZUQCu/CTSboZD61PbCAWHNf0w8YFo41LB79/EIshB/yuTfRJUC
 MV722JmypuevJSnmi2SWpbdj+arBgO90Ku//XvGTn0rZUiv/fAAfI5Rt93HPGRPB9EpB
 DQZzyuzNewsfu5bhEBtiWG90LC1efo6WBrdiVQqS8JMkltoddNEX9FQDJiRpT8d5HZHR
 P48saIIFpFDe1+CC90UN0HFbV8bewkYNvMQDLkY3Z9HCQ+549gw034pPHZkX1UYkpmkv zg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfff404q7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Aug 2023 07:01:37 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37E6voCw032297;
 Mon, 14 Aug 2023 07:01:36 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfff4046w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Aug 2023 07:01:35 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37E5R2xm018891; Mon, 14 Aug 2023 07:01:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3seq411cea-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Aug 2023 07:01:12 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37E71AKE9241092
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Aug 2023 07:01:10 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8CAA720043;
 Mon, 14 Aug 2023 07:01:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4091620040;
 Mon, 14 Aug 2023 07:01:10 +0000 (GMT)
Received: from p-imbrenda (unknown [9.179.13.124])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
 Mon, 14 Aug 2023 07:01:10 +0000 (GMT)
Date: Mon, 14 Aug 2023 09:01:08 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: util/async-teardown.c: is it really needed for --disable-system
 build?
Message-ID: <20230814090108.472547d8@p-imbrenda>
In-Reply-To: <a2f99abb-7ad6-41b4-1b74-ab7dba3d2424@tls.msk.ru>
References: <744ac8a7-dd6b-2ce4-3f47-250812241d0e@tls.msk.ru>
 <a2f99abb-7ad6-41b4-1b74-ab7dba3d2424@tls.msk.ru>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wu-pfAsVHa1Ir5Ms93NsA65x5pWGM9iC
X-Proofpoint-ORIG-GUID: J_TDCOT1rTezPIEyZXKFFNKLNYXV5Kfq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_01,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 mlxlogscore=887
 priorityscore=1501 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0
 suspectscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308140064
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=imbrenda@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On Sat, 12 Aug 2023 12:48:14 +0300
Michael Tokarev <mjt@tls.msk.ru> wrote:

> 12.08.2023 12:38, Michael Tokarev wrote:
> ...
> > It smells like, at the very least, os-posix.c should be split. We shoul=
dn't include
> > a ton of qemu-system functionality (like very specific option parsing) =
into qemu-nbd
> > for example.
> >=20
> > How about splitting os-posix.c into a few files in util/ (not in the ro=
ot dir), and
> > adding them to util_ss in case of posix-os?=C2=A0 Ditto for os-win32.c,=
 I guess, but I
> > haven't looked at this.
> >=20
> > And for the question in $subj, this one needs to be guarded by CONFIG_S=
OFTMMU. =20
>=20
> Or maybe better yet, put the softmmu-specific functions (one very good ex=
ample here
> is os_parse_cmd_args() function - it clearly belongs to softmmu/, it shou=
ld never
> has been in global os-foo.c but in some softmmu-os-foo.c instead.  This w=
ay,
> async-teardown.c is moved to softmmu/ too, maybe os-linux-async-teardown.=
c.
>=20
> /mjt

I think we could guard the offending item with CONFIG_SOFTMMU for now,
to immediately fix the issues you raised, and do the refactoring you
proposed later (e.g. next cycle).

what do you think?

