Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F45184AB17
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Feb 2024 01:25:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX9Fp-0001kM-HP; Mon, 05 Feb 2024 19:24:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rX9Fm-0001jO-V9
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 19:23:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rX9Fk-0003sQ-6E
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 19:23:58 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 4160La94020063; Tue, 6 Feb 2024 00:23:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=5scoyxeZrpD55gJXQmFnsBLMvXzr/JhUpF6HWnxiifs=;
 b=EEsASDli3v3/b06Cw97RDcxBsyRpOM28MzgMdtY/fdSD3N/DXbRh/KutahOwKBeHUNTH
 1FD1FW9Ta1eU1n0vNPx/ja377ZBGvLYHtF9B5jwe4333Q8jVFaJWl0nthjF6pn1IXGO3
 TTrQ+P8/H0Hqz0xNPmd6Bf87NpNQ+LbBFUCg5r1cs44CJ+VaSQXnJM+dfNVL9292q46E
 Ucd0oFoW1yJRPcHB01tavutVVdc2E/QFwLiyrsnywNn21iycpaMfyx4a3GtSRKrsvgU8
 KtMWkwtFyJP9HWdyYHC6lKU8FkVVYgTBbl0WxauHCv+6N72jc+YoZ3i4iy7Q80ggqRLw HA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w39r2rf72-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Feb 2024 00:23:50 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4160Ldwq020383;
 Tue, 6 Feb 2024 00:23:49 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w39r2rf6w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Feb 2024 00:23:49 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 415MeFgb008971; Tue, 6 Feb 2024 00:23:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w206ybxev-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Feb 2024 00:23:49 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4160NlSa26214912
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Feb 2024 00:23:47 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F01BE20043;
 Tue,  6 Feb 2024 00:23:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 11F0820040;
 Tue,  6 Feb 2024 00:23:46 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.57.170])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Feb 2024 00:23:45 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Warner Losh <imp@bsdimp.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 0/4] make vm-build-freebsd fixes
Date: Tue,  6 Feb 2024 01:21:59 +0100
Message-ID: <20240206002344.12372-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _hQ-dgau6RFG8T3bp2WxcV4MmbjCwgkJ
X-Proofpoint-ORIG-GUID: GOsPrk3IPkgc8RVPdK_4tsb4wF2x2rRI
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_18,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=998 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402060000
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

v2: https://lists.gnu.org/archive/html/qemu-devel/2024-02/msg00890.html
v2 -> v3: Structure the meson check similar to have_asan_fiber;
          Reduce the context size a little (Philippe).

v1: https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg05155.html
v1 -> v2: Link with libinotify instead of disabling the inotify
          support (Daniel).
          Use a bit more context lines in order to prevent the
          incorrect application of the test patch.

Hi,

I needed to verify that my qemu-user changes didn't break BSD, and
Daniel Berrange suggested vm-build-freebsd on IRC. I had several
problems with it, which this series resolves.

Best regards,
Ilya

Ilya Leoshkevich (4):
  tests/vm: Set UseDNS=no in the sshd configuration
  tests/vm/freebsd: Reload the sshd configuration
  test-util-filemonitor: Adapt to the FreeBSD inotify rename semantics
  meson: Link with libinotify on FreeBSD

 meson.build                        | 23 +++++++++++++++++++----
 tests/unit/test-util-filemonitor.c |  8 ++++++++
 tests/vm/basevm.py                 |  2 ++
 tests/vm/freebsd                   |  1 +
 util/meson.build                   |  6 +++++-
 5 files changed, 35 insertions(+), 5 deletions(-)

-- 
2.43.0


