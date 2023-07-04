Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D70FB746AD8
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 09:41:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGaee-00022I-II; Tue, 04 Jul 2023 03:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGaea-0001t6-N1; Tue, 04 Jul 2023 03:40:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGaeY-0003Ci-IR; Tue, 04 Jul 2023 03:40:52 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3647WWPg021603; Tue, 4 Jul 2023 07:40:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=GFS6KPyRiCGpGQAzqda36vDw1Wanqbaf24Qx80k4lUM=;
 b=GizW00P7W1RqXQ1chtqRqB95aGKF7uNbJHpOnYctWYsdjamiiCcc4Z+WU94UxhxzVdXC
 dksX1Y+4SbsOAOKw4UItjOTUvVOi3/pAZjVkdy94BUW/LKF7R2waIeYwlnMINF+oIWJ3
 jNUddtUwTLwOJvXsCEnSM+k+SXTvZQkph4G8gXUsf8K23zcZWzjqd9z0UgctkLWWBhOc
 Ne304h9xnlpVCLI7oOpemBYSOJvEzvb8bw9xERUIJ4U8YTashQI5VPoT42BgHr/OytGL
 rW5kJKw1oUNseVXMsMmIcGTbXn4zZEvDe1FSUnvM5j6N6uoCInPUDqhpYfyQ+MOVL6dv 6g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmf4k865p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 07:40:48 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3647aRKg032507;
 Tue, 4 Jul 2023 07:40:47 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmf4k8656-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 07:40:47 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 363NdRpM018448;
 Tue, 4 Jul 2023 07:40:45 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3rjbs4svxx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 07:40:45 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3647ehbu24642224
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Jul 2023 07:40:43 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 43E8B20043;
 Tue,  4 Jul 2023 07:40:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BBD8120049;
 Tue,  4 Jul 2023 07:40:42 +0000 (GMT)
Received: from [9.179.30.217] (unknown [9.179.30.217])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Jul 2023 07:40:42 +0000 (GMT)
Message-ID: <f4fd796869a3dd189084b52c12b8ba80e69113b0.camel@linux.ibm.com>
Subject: Re: [PATCH 01/12] linux-user: elfload: Add more initial s390x PSW bits
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Date: Tue, 04 Jul 2023 09:40:42 +0200
In-Reply-To: <e53ccd03-1109-7868-4302-6e578aa503c8@redhat.com>
References: <20230703155801.179167-1-iii@linux.ibm.com>
 <20230703155801.179167-2-iii@linux.ibm.com>
 <e53ccd03-1109-7868-4302-6e578aa503c8@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JFwQGZp1LnhXyGfNOpNpd3WRe8pqgW_D
X-Proofpoint-GUID: E8N1-3bEtWhKP_kDWjnzv6j3S2TJvC0j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_04,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=931 phishscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307040060
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

On Tue, 2023-07-04 at 09:32 +0200, David Hildenbrand wrote:
> On 03.07.23 17:50, Ilya Leoshkevich wrote:
> > Make the PSW look more similar to the real s390x userspace PSW.
> > Except for being there, the newly added bits should not affect the
> > userspace code execution.
>=20
> What's the purpose of this then? Required for follow-up patches?

That's required for the EPSW test.
I could, of course, mask out the bits that are not emulated in the
test, but I thought it was better to make the emulation closer to
reality, if only for cosmetic purposes.

[...]

