Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F13383755C
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 22:32:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS1t7-0005ig-0F; Mon, 22 Jan 2024 16:31:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rS1t2-0005ha-5f; Mon, 22 Jan 2024 16:31:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rS1sz-0005Q5-H3; Mon, 22 Jan 2024 16:31:19 -0500
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40MLMIDW015660; Mon, 22 Jan 2024 21:31:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=AzxswaSdptTEDo3W/yeo/M3ux5cfnS0/KQDqILVGnrI=;
 b=kbLDMKTKHl+ucFtFGHsOz6UAeOkWVRmRL+Dd6zLT27twTnewkIy/yUrESw4BM13/Pcmn
 uV5EUJwyUp0dfyW9Yxy2440Mny4KaZ3nermV/93euX2Z2UphijYlB8x3tO4QXuCZ6anW
 D8EMBvz+q3uSn1nUNSDORmrUaAsQVcT0oCAk+pcBulFRhvrdfrBXZGpMmv2nYxB7BUFG
 igzbDEh/nu/jw8/exccfhwh6+9DUYROYysfVyKKin12Wc5wsr3KVgy1uCSIYTJvQxyXs
 g746ebQUrL/NV6FzMlAp0ycXPIAijapMo/kgjNDkzTA14ajsYLINV2plcoz6It4icrLO QQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vt07br6u0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 21:31:13 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40MLNlHO019070;
 Mon, 22 Jan 2024 21:31:13 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vt07br6t5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 21:31:13 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40MKbVj3025285; Mon, 22 Jan 2024 21:31:12 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vrtqk2vbx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 21:31:12 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40MLVAdb4391674
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jan 2024 21:31:10 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A1F6720043;
 Mon, 22 Jan 2024 21:31:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B3A420040;
 Mon, 22 Jan 2024 21:31:10 +0000 (GMT)
Received: from heavy (unknown [9.171.83.169])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 22 Jan 2024 21:31:09 +0000 (GMT)
Date: Mon, 22 Jan 2024 22:31:08 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
Subject: Re: Re: [PATCH v3 3/3] tests/tcg: Add the PROT_NONE gdbstub test
Message-ID: <aybsdiscvgcl5kici5lfupjtykvkyw4u5g3bdncmv3wufzwgou@r42zm6labldl>
References: <20240116003551.75168-1-iii@linux.ibm.com>
 <20240116003551.75168-4-iii@linux.ibm.com>
 <871qa9nz2f.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871qa9nz2f.fsf@draig.linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BMm8EY_NhMZmPDb7Hi_Qi4ULDrIGUr3A
X-Proofpoint-GUID: PprifhZw7RSfvShFWoNL6acTRzb0NnqZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_09,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=934 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401220152
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

On Mon, Jan 22, 2024 at 03:54:32PM +0000, Alex Bennée wrote:
> Ilya Leoshkevich <iii@linux.ibm.com> writes:
> 
> > Make sure that qemu gdbstub, like gdbserver, allows reading from and
> > writing to PROT_NONE pages.
> >
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> >  tests/tcg/multiarch/Makefile.target      |  9 +++++-
> >  tests/tcg/multiarch/gdbstub/prot-none.py | 22 +++++++++++++
> >  tests/tcg/multiarch/prot-none.c          | 40 ++++++++++++++++++++++++
> >  3 files changed, 70 insertions(+), 1 deletion(-)
> >  create mode 100644 tests/tcg/multiarch/gdbstub/prot-none.py
> >  create mode 100644 tests/tcg/multiarch/prot-none.c

[...]

> > +def run_test():
> > +    """Run through the tests one by one"""
> > +    gdb.Breakpoint("break_here")
> > +    gdb.execute("continue")
> > +    val = gdb.parse_and_eval("*(char[2] *)q").string()
> 
> Better traceback:
> 
>   Breakpoint 1, break_here (q=0x400000802fff) at /home/alex/lsrc/qemu.git/tests/tcg/multiarch/prot-none.c:14
>   14      }
>   GDB Exception:
>   Traceback (most recent call last):
>     File "/home/alex/lsrc/qemu.git/tests/guest-debug/test_gdbstub.py", line 42, in main
>       test()
>     File "./tests/tcg/multiarch/gdbstub/prot-none.py", line 14, in run_test
>       val = gdb.parse_and_eval("*(char[2] *)q").string()
>             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   gdb.MemoryError: Cannot access memory at address 0x400000802fff
>   Python 3.11.2 (main, Mar 13 2023, 12:18:29) [GCC 12.2.0] on linux
>   Type "help", "copyright", "credits" or "license" for more information.
>   (InteractiveConsole)
>   >>> 

Thanks for the debug output. This shows that the feature being tested
doesn't work (the value of `q` looks sane to me). May I ask what host
distro is this? I tried on x86_64 Fedora 38 and x86_64 Ubuntu 22.04 so
far, and the test was successful.

[...]

