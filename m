Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 880F081B5BF
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 13:27:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGI89-0002Ey-Cq; Thu, 21 Dec 2023 07:26:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rGI85-0002En-Oy
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 07:26:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rGI83-0005I9-Pk
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 07:26:21 -0500
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3BLAP7cS017952; Thu, 21 Dec 2023 12:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Kl3ttf8yuqZXtX2OSK2olNV7DSU+opMQw56qByuiubc=;
 b=DCj8mAIG+UKD4WvzlEakVwP0LMMQh/MmX7Ne+amhEXMIMmv4pLxNn8ZyATU8mk6QmXna
 rdwhFSosp3g1bsJVWdDeiu7+mQK2JNcOa1RvEktKYfZCKdeCseQO6aeGQkYW0T8xEaQb
 WbUkhV7dQGefvTZIiHYCVhjEvgKFU+veMF2040SejyNrAy+burZdjjNMAXagS2zv/IW6
 C8Q1X/NtHZQ7rnjmNtfPC+le5UnxtsAffu2wXf7qqlWvBuiHaWu3YZuGgxZHZaBQtKhK
 ZrZbKhfIk1Ci8iVQEuu//uFa5SAsoZxgN4qqZz187gTQTSxj/i8gf3RaZ06eVQhdlICA XQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v4h2cjcq9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Dec 2023 12:26:14 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BLC8qhB017686;
 Thu, 21 Dec 2023 12:26:14 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v4h2cjcpm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Dec 2023 12:26:14 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3BL9UArr010885; Thu, 21 Dec 2023 12:26:13 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3v1q7nvts4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Dec 2023 12:26:12 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3BLCQAFS27656704
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Dec 2023 12:26:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D495020040;
 Thu, 21 Dec 2023 12:26:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 74D8720043;
 Thu, 21 Dec 2023 12:26:10 +0000 (GMT)
Received: from heavy (unknown [9.171.70.156])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 21 Dec 2023 12:26:10 +0000 (GMT)
Date: Thu, 21 Dec 2023 13:26:08 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, philmd@linaro.org
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH RFC] linux-user: Allow gdbstub to ignore page protection
Message-ID: <w2uzdrhr6orfaauxtpqbg4o4z4fewkdfnze5zqoybzwdcc2z5t@fkpxdn7vmaeg>
References: <20231215232908.1040209-1-iii@linux.ibm.com>
 <7f2c38bc-d3d8-4d22-867e-74330dcb2ab8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f2c38bc-d3d8-4d22-867e-74330dcb2ab8@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: N160Z-5TnxJmh8HcyhG49hcn3WQc1AFP
X-Proofpoint-GUID: 0_56T9G1SLJeqS5XBBDO88aGUeke2s4o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-21_05,2023-12-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312210093
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Thu, Dec 21, 2023 at 10:33:51AM +1100, Richard Henderson wrote:
> On 12/16/23 10:24, Ilya Leoshkevich wrote:
> > @@ -377,22 +379,42 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
> >           flags = page_get_flags(page);
> >           if (!(flags & PAGE_VALID))
> >               return -1;
> > +        prot = ((flags & PAGE_READ) ? PROT_READ : 0) |
> > +               ((flags & PAGE_WRITE) ? PROT_WRITE : 0) |
> > +               ((flags & PAGE_EXEC) ? PROT_EXEC : 0);
> 
> See target_to_host_prot where guest PROT_EXEC is mapped to host PROT_READ.
> This should be
> 
> 	flags & (PAGE_READ | PAGE_EXEC) ? PROT_READ

Oh, right. PROT_EXEC is rather set on code_gen_buffer.

> > +            if (!(prot & PROT_WRITE)) {
> > +                if (target_mprotect(page, TARGET_PAGE_SIZE,
> > +                                    prot | PROT_WRITE)) {
> > +                    return -1;
> > +                }
> > +            }
> >              /* XXX: this code should not depend on lock_user */
> > -            if (!(p = lock_user(VERIFY_WRITE, addr, l, 0)))
> > +            if (!(p = lock_user(VERIFY_NONE, addr, l, 0)))
> >                  return -1;
> >              memcpy(p, buf, l);
> >              unlock_user(p, addr, l);
> > +            if (!(prot & PROT_WRITE)) {
> > +                if (target_mprotect(page, TARGET_PAGE_SIZE, prot)) {
> > +                    return -1;
> > +                }
> > +            }
> 
> Is the mmap lock held here?  You're opening up a window in which a page may
> be modified but we don't catch the modification to translation blocks.

I don't think so, I'll need to add it.

> > +            if (!(prot & PROT_READ)) {
> > +                if (target_mprotect(page, TARGET_PAGE_SIZE, prot | PROT_READ)) {
> > +                    return -1;
> > +                }
> > +            }
> 
> I really really doubt you need to do this.  The page is not accessible, so
> why expose it at all?  If you want to do this, I wonder if we should instead
> be interacting with ptrace?

Wouldn't this break when QEMU itself is being debugged? We would also
need mounted /proc or a lot of peek calls. So I thought that if we
could transparently remove and restore protection, it would be better.

> r~

