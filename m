Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 837B477FC6B
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 18:59:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWgJX-0007PD-2o; Thu, 17 Aug 2023 12:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qWgJS-0007Od-4X; Thu, 17 Aug 2023 12:57:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qWgJP-0003nQ-Ly; Thu, 17 Aug 2023 12:57:33 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37HGbtMA025033; Thu, 17 Aug 2023 16:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Dafww24Ti4IgU3cdQi7kSWM/D6weo/Ld65xlQxKA6/M=;
 b=slFKaq7+6BHDGkDa3nBXAII1gp1KmXT7mW0vC8KQUqwpd1DZ+QAQ51AfxMOO2nkS/FaX
 DJXIITriRgADI8+SwQuXEnbA9uEuTiNxzueyhhRJM2dPAy0/0CkkeoHClFtt+D7f+6Rr
 I9QV1B1YNlhJW7Uh4I0+1rpLJ4JADw1iPjlskRvA6t/LgbfMdJpOqhhfpJAieWlvsbKY
 KSCBuBv0R0Cql6LIRgG/a/k5bZCuvGfUHgtx/UFy5qKQ9dROJtGamBGqvXlnYuglxJit
 wSDTjnc8/9MKGc1wVk/e/u7MDT1VPh5WEwACf2uFssHlDd7mf4Ryh2ENIZv2alBvF1Hi xw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3shpyg0vtv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Aug 2023 16:57:27 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37HGbuqq025142;
 Thu, 17 Aug 2023 16:57:26 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3shpyg0vtm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Aug 2023 16:57:26 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37HGLEcB002460; Thu, 17 Aug 2023 16:57:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sendnqptu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Aug 2023 16:57:25 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37HGvNLD9634360
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Aug 2023 16:57:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B78C020043;
 Thu, 17 Aug 2023 16:57:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2EE7120040;
 Thu, 17 Aug 2023 16:57:23 +0000 (GMT)
Received: from heavy (unknown [9.171.85.44])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 17 Aug 2023 16:57:23 +0000 (GMT)
Date: Thu, 17 Aug 2023 18:57:21 +0200
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Claudio Fontana <cfontana@suse.de>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Subject: Re: [PATCH 3/3] tests/tcg/s390x: Test VSTRS
Message-ID: <ji4u37wgb76uo5tikgh2onxrw6ruucb4bzv6sxnszo23sdncqa@t4ekqxf5zoly>
References: <20230804233748.218935-1-iii@linux.ibm.com>
 <20230804233748.218935-4-iii@linux.ibm.com>
 <733747a8-fda3-677a-82ea-8091fec84501@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <733747a8-fda3-677a-82ea-8091fec84501@suse.de>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7LvA_p91SC9EBrpzu92O2LVevrg26i_d
X-Proofpoint-ORIG-GUID: ynIm7jtw5MNOFfbSMSdAf97SSggmFn6q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_11,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=813 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308170148
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Aug 17, 2023 at 11:37:29AM +0200, Claudio Fontana wrote:
> On 8/5/23 01:03, Ilya Leoshkevich wrote:
> > Add a small test to prevent regressions.
> > 
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> 
> Something seems off in the wiring of the make check target?
> 
> I built with:
> 
> ./configure --target-list=s390x-linux-user,s390x-softmmu
> 
> make -j
> make -j check-help
> 
> ...
> 
> Individual test suites:
>  make check-qtest-TARGET     Run qtest tests for given target
>  make check-qtest            Run qtest tests
>  make check-unit             Run qobject tests
>  make check-qapi-schema      Run QAPI schema tests
>  make check-block            Run block tests
>  make check-tcg              Run TCG tests
> 
> 
> ...
> 
> make -j check-tcg
> 
> changing dir to build for make "check-tcg"...
> make[1]: Entering directory '/root/git/qemu/build'
> make[1]: Nothing to be done for 'check-tcg'.
> make[1]: Leaving directory '/root/git/qemu/build'
> 
> 
> Why is this not running any tests for tcg?
> 
> I tried also to run the general make check,
> but even in this case the tcg tests do not seem to trigger.
> 
> Thanks,
> 
> Claudio

Hi,

I believe you need either s390x-linux-gnu-gcc or docker/podman to run
the tcg tests.

Best regards,
Ilya

