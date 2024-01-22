Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B5E8374EB
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 22:09:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS1Xk-0000fL-EK; Mon, 22 Jan 2024 16:09:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rS1XF-0000Qm-3j; Mon, 22 Jan 2024 16:08:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rS1XC-00012r-4b; Mon, 22 Jan 2024 16:08:48 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40MKXfpV000551; Mon, 22 Jan 2024 21:08:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=W0QYU9EiatvYhqqkdNwRTy7IOqvo40s0QzAx49GDfCo=;
 b=Ahhmt1Qro0ZE4BitOxu1XL9Wtm+ynIOfhV8GHiMJXzVas6YGRSuERbhcJmV4gXnQCAnz
 Y1/KZP10T/ZkCcjVbMPSp/Kndw876qcPdtng/PcaLfexnaVLR0gwfXtywCh2UBWdPuMA
 SrSUygwytqZDaOrb8fk9xm+9UAlB+h9r5t+x34Kg3PRA2SyaxSFqI0E4yQj7/GGluEbO
 D5n0TW0qgy1ly/wRsWV7pnMLSuLTbdraELOJqh2wKmkFwDOeHCsr9OBf059I0jO5qGAK
 RE7TqtrR+oePbDn0RlxfQbdNY3Z0FH9KjVf64xViMi16hMSit9iKQjpYhZYUFtbl+pNa tw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vsygh0rks-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 21:08:40 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40ML38D9000637;
 Mon, 22 Jan 2024 21:08:39 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vsygh0rkj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 21:08:39 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40MKGQSD025277; Mon, 22 Jan 2024 21:08:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vrtqk2s21-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 21:08:38 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40ML8bX666060604
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jan 2024 21:08:37 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0565C20040;
 Mon, 22 Jan 2024 21:08:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7942020043;
 Mon, 22 Jan 2024 21:08:36 +0000 (GMT)
Received: from heavy (unknown [9.171.83.169])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 22 Jan 2024 21:08:36 +0000 (GMT)
Date: Mon, 22 Jan 2024 22:08:35 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
Subject: Re: Re: [PATCH v3 2/3] tests/tcg: Factor out gdbstub test functions
Message-ID: <c3ve2aclqw7dbtubjxrwpu6tlfjdufqncgy4xiqesgs24jw2cd@uda3e7rgdpt2>
References: <20240116003551.75168-1-iii@linux.ibm.com>
 <20240116003551.75168-3-iii@linux.ibm.com>
 <87v87lmk7n.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v87lmk7n.fsf@draig.linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aFlWd8vN7Gl84hL8T08kf7lK_xriWneu
X-Proofpoint-ORIG-GUID: RAJcDYFT93bx_ou0OtERhDr_NunOENhW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_09,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 mlxlogscore=923 priorityscore=1501 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401220150
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
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

On Mon, Jan 22, 2024 at 04:00:44PM +0000, Alex Bennée wrote:
> Ilya Leoshkevich <iii@linux.ibm.com> writes:
> 
> > Both the report() function as well as the initial gdbstub test sequence
> > are copy-pasted into ~10 files with slight modifications. This
> > indicates that they are indeed generic, so factor them out. While
> > at it, add a few newlines to make the formatting closer to PEP-8.
> >
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> >  tests/guest-debug/run-test.py                 |  7 ++-
> >  tests/guest-debug/test_gdbstub.py             | 58 +++++++++++++++++++
> >  tests/tcg/aarch64/gdbstub/test-sve-ioctl.py   | 34 +----------
> >  tests/tcg/aarch64/gdbstub/test-sve.py         | 33 +----------
> >  tests/tcg/multiarch/gdbstub/interrupt.py      | 47 ++-------------
> >  tests/tcg/multiarch/gdbstub/memory.py         | 41 +------------
> >  tests/tcg/multiarch/gdbstub/registers.py      | 41 ++-----------
> >  tests/tcg/multiarch/gdbstub/sha1.py           | 40 ++-----------
> >  .../multiarch/gdbstub/test-proc-mappings.py   | 39 +------------
> >  .../multiarch/gdbstub/test-qxfer-auxv-read.py | 37 +-----------
> >  .../gdbstub/test-thread-breakpoint.py         | 37 +-----------
> >  tests/tcg/s390x/gdbstub/test-signals-s390x.py | 42 +-------------
> >  tests/tcg/s390x/gdbstub/test-svc.py           | 39 +------------
> >  13 files changed, 98 insertions(+), 397 deletions(-)
> >  create mode 100644 tests/guest-debug/test_gdbstub.py

[...]

> > +    if gdb.parse_and_eval("$pc") == 0:
> > +        print("SKIP: PC not set")
> > +        exit(0)
> > +
> > +    try:
> > +        test()
> > +    except:
> > +        print("GDB Exception:")
> > +        traceback.print_exc(file=sys.stdout)
> > +        global fail_count
> > +        fail_count += 1
> > +        import code
> > +        code.InteractiveConsole(locals=globals()).interact()
> > +        raise
> 
> While I can see this is useful we don't want to default to an
> interactive console as that will hang the test in CI type setups. Can we
> make this a option we enable?

Would something like `export QEMU_TEST_INTERACTIVE=1` be okay?

[...]

