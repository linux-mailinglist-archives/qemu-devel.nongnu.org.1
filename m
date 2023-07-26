Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F31762EF7
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 10:00:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOZPs-0004lj-7V; Wed, 26 Jul 2023 03:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1qOZPq-0004lU-5t; Wed, 26 Jul 2023 03:58:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1qOZPn-0003Ao-8h; Wed, 26 Jul 2023 03:58:37 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36Q7ndZb016450; Wed, 26 Jul 2023 07:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=iR3hH1LJHHWrm34vr/XBUHDpDPAajYxbZXPFfFhrW2A=;
 b=hReUDVK2qbtBUK1cnL505Djc8ocRvgTb/wMQDzOlzKQsjPPdu2GYYoAvdkF+Tt6+tg6Q
 NzfsGXX8sFzUmvNnaIUK1jMYjqCKu2kwX16ikLFeo3bGzQ3kSsx3pPxbQxiQW4unYakz
 GkUzsQsZkJydEiZmuG0gQ9qYfTbPEpHY0BRTm3jmNqFBOLUJCuyO88Ehz2CmXHK7x6V3
 wl3mZCgPWL5azKSSnmt7Wh2hTnk8Q4yn2VoeA2VWVwOHyzz9wpYFDnjrrRDoeqYguemU
 uR9DLh6rB67T0DkgqOR3QZTeKy+g5Q0nkBghmwmZTCVvvbZ8bDjQ7QjjzULSydsbaFfJ Ow== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s2yej055x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Jul 2023 07:58:30 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36Q7oFRd018025;
 Wed, 26 Jul 2023 07:58:30 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s2yej055r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Jul 2023 07:58:30 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36Q7eEmV016610; Wed, 26 Jul 2023 07:58:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s0v51ajgc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Jul 2023 07:58:29 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36Q7wSq045678960
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jul 2023 07:58:28 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D78320049;
 Wed, 26 Jul 2023 07:58:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E2D6020040;
 Wed, 26 Jul 2023 07:58:27 +0000 (GMT)
Received: from [9.155.198.239] (unknown [9.155.198.239])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Jul 2023 07:58:27 +0000 (GMT)
Message-ID: <d254f19d-0520-bc5d-6583-10fd46d9b894@linux.ibm.com>
Date: Wed, 26 Jul 2023 09:58:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: s390 intermittent test failure in qemu:block /
 io-qcow2-copy-before-write
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Qemu-block <qemu-block@nongnu.org>, Thomas Huth <thuth@redhat.com>
References: <CAFEAcA--B6=JxOuy-55bvBmHDAkvHv5T-7K_kW_9JK0OQ4MPiA@mail.gmail.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <CAFEAcA--B6=JxOuy-55bvBmHDAkvHv5T-7K_kW_9JK0OQ4MPiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2G1_SywLwPd5iPhI1pYV9D8vFuzY4fhL
X-Proofpoint-GUID: TzaW9us0w8Iisaj1lus7QuvRggOnXVH5
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_01,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 impostorscore=0 clxscore=1011 phishscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260066
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



Am 25.07.23 um 18:45 schrieb Peter Maydell:
> There seems to be an intermittent failure on the s390 host in
> the qemu:block / io-qcow2-copy-before-write test:
> https://gitlab.com/qemu-project/qemu/-/jobs/4737819873
> 
> The log says the test was expecting to do some reading
> and writing but got an unexpected 'permission denied'
> error on the read. Any idea why this might happen ?
> 
> 768/835 qemu:block / io-qcow2-copy-before-write ERROR 12.05s exit status 1
>>>> PYTHON=/home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/build/pyvenv/bin/python3 MALLOC_PERTURB_=101 /home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/build/pyvenv/bin/python3 /home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/build/../tests/qemu-iotests/check -tap -qcow2 copy-before-write --source-dir /home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/tests/qemu-iotests --build-dir /home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/build/tests/qemu-iotests
> ――――――――――――――――――――――――――――――――――――― ✀ ―――――――――――――――――――――――――――――――――――――
> stderr:
> --- /home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/tests/qemu-iotests/tests/copy-before-write.out
> +++ /home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/build/scratch/qcow2-file-copy-before-write/copy-before-write.out.bad
> @@ -1,5 +1,21 @@
> -....
> +...F
> +======================================================================
> +FAIL: test_timeout_break_snapshot (__main__.TestCbwError)
> +----------------------------------------------------------------------
> +Traceback (most recent call last):
> + File "/home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/tests/qemu-iotests/tests/copy-before-write",
> line 210, in test_timeout_break_snapshot
> + self.assertEqual(log, """\
> +AssertionError: 'wrot[195 chars]read 1048576/1048576 bytes at offset
> 0\n1 MiB,[46 chars]c)\n' != 'wrot[195 chars]read failed: Permission
> denied\n'
> + wrote 524288/524288 bytes at offset 0
> + 512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> + wrote 524288/524288 bytes at offset 524288
> + 512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> ++ read failed: Permission denied
> +- read 1048576/1048576 bytes at offset 0
> +- 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
> +
> ----------------------------------------------------------------------
> Ran 4 tests
> -OK
> +FAILED (failures=1)
> (test program exited with status code 1)
> ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
> 
> Same failure, previous job:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/4736463062
> 
> This one's a "Failed to get write lock" in io-qcow2-161:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/4734846533

See
https://lore.kernel.org/qemu-devel/028059df-eaf4-9e65-a195-4733b708a426@linux.ibm.com/

I was not yet able to understand that. And I can only reproduce with Ubuntu (RHEL,SLES,Fedora are fine).
Upstream kernel on Ubuntu does not help, so I assume it must be something in the libraries or config.

