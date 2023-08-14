Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0476577B3A7
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 10:16:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVSk1-0002zI-Tv; Mon, 14 Aug 2023 04:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1qVSjq-0002wb-7E
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 04:15:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1qVSjo-00050r-Ix
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 04:15:45 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37E7vYXo027118; Mon, 14 Aug 2023 08:15:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=rOoR+3BmJsEdiyUOgeuaXnuvtyuI+7mJ/DTxYwcgcew=;
 b=gb4CS2xlzij8wVHkjeu2Ly6UyXZ05YFyhn35stQhNCxkO1z1UkLRvopst96OITZc6N1w
 3QheGvf8RTstOLNOh403DF3HfUqkiE2A/0+ETYqR26GMVQJdy5OIUiVR8XOFcVtyl5pz
 9ff/Dg9MdULLmVVwX0f+/lhpYEiUC1EAlEsDb2TUPp2X7J0+wPveHVjrQe34cnIpXJhC
 v7/hMVa2IaxuQfes8TorZ6vbhWeR62p2zqJldhj3BwLkFE/y4MUNUGmkOJY6RDakhlLs
 joUi/qKi/i7qxNwChR8eGSKC8Uw+TyGYtV8m5jj+MdJCDvXyDaEAhUKy40fPGxINK9Ai fg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfgbb0m7x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Aug 2023 08:15:42 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37E8Ctt9031836;
 Mon, 14 Aug 2023 08:15:42 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfgbb0m4q-6
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Aug 2023 08:15:42 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37E78M26003456; Mon, 14 Aug 2023 07:27:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3semds2nje-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Aug 2023 07:27:29 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37E7RRS260817828
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Aug 2023 07:27:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C6B4320040;
 Mon, 14 Aug 2023 07:27:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 744672005A;
 Mon, 14 Aug 2023 07:27:27 +0000 (GMT)
Received: from p-imbrenda (unknown [9.179.13.124])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
 Mon, 14 Aug 2023 07:27:27 +0000 (GMT)
Date: Mon, 14 Aug 2023 09:27:25 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: util/async-teardown.c: is it really needed for --disable-system
 build?
Message-ID: <20230814092725.7181c072@p-imbrenda>
In-Reply-To: <97d04dd0-6182-9b61-576c-1a29f856e2c4@tls.msk.ru>
References: <744ac8a7-dd6b-2ce4-3f47-250812241d0e@tls.msk.ru>
 <a2f99abb-7ad6-41b4-1b74-ab7dba3d2424@tls.msk.ru>
 <20230814090108.472547d8@p-imbrenda>
 <97d04dd0-6182-9b61-576c-1a29f856e2c4@tls.msk.ru>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zmfAX7FgxMYbvNc_I_ki_Hw_RnJNmIJR
X-Proofpoint-ORIG-GUID: Ex_5M22Z5b6IEAvmdA3K7mesotuQK038
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_03,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 impostorscore=0 mlxlogscore=574
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140073
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=imbrenda@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On Mon, 14 Aug 2023 10:12:35 +0300
Michael Tokarev <mjt@tls.msk.ru> wrote:

> 14.08.2023 10:01, Claudio Imbrenda wrote:
> 
> > I think we could guard the offending item with CONFIG_SOFTMMU for now,
> > to immediately fix the issues you raised, and do the refactoring you
> > proposed later (e.g. next cycle).  
> 
> I don't think rushing for the last-minute fix is necessary in this case.

yes and no

it's a bug (which I introduced), and the quick fix seems to be
easy enough, so why not?

> It has real build problem on ia64 only which does not work for several
> releases anyway, and the linking of unnecessary pieces happened for a
> long time too.
> 
> /mjt


