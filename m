Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE48740BA0
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 10:36:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEQeH-0007zc-3G; Wed, 28 Jun 2023 04:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1qEQeA-0007z8-4N; Wed, 28 Jun 2023 04:35:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1qEQe7-0003M0-OL; Wed, 28 Jun 2023 04:35:29 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35S8W6Jw005268; Wed, 28 Jun 2023 08:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=qMIrR7ULNqBi5IsQ5BdRYmL/vcAJG78sKcyqsp2Bjw8=;
 b=ZkSOxKSPouEhJNKAlX4+6dZhl7UEeda8/plL628slUl9U/CYoJSFhWJHQ6XkMr1TmQ45
 mCH4oARu8M91sSR4NkEmdyN6O+zpjNS+MoHk55e4QVSlf2excOouN/bT5QQZV+WmpDNn
 FsSsrRWNLb8Sshk6CqJJ0eJsLnhMrxWU3nRY5N2ufkorV/BJZq9Qik5VMA3CRbMQYZaH
 QZGEI0IZYsUkkN4NTZsA9wr/ASACFcwNxpJ3cSKuwJqD9srzLEX+Y9lUwlJtttZeCEj4
 EcgzBw70MlwRNa8nk7AS218zngnwwtCmESLDnbbQ4rvBUSRFf44J9WyOfG03p50LwKFY Xg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rghefg2tb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Jun 2023 08:35:23 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35S8WdZC006994;
 Wed, 28 Jun 2023 08:35:23 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rghefg2s2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Jun 2023 08:35:23 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35S2uxOd024204;
 Wed, 28 Jun 2023 08:35:21 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3rdr451uu8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Jun 2023 08:35:20 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35S8ZHSv18744034
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Jun 2023 08:35:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 640FC20040;
 Wed, 28 Jun 2023 08:35:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 39ADE20043;
 Wed, 28 Jun 2023 08:35:17 +0000 (GMT)
Received: from [9.152.224.41] (unknown [9.152.224.41])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 28 Jun 2023 08:35:17 +0000 (GMT)
Message-ID: <57a9b1fe-5abc-d2b2-26f8-fa1ca0905214@linux.ibm.com>
Date: Wed, 28 Jun 2023 10:35:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] pc-bios/s390-ccw: Get rid of the the __u* types
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, cohuck@redhat.com,
 Juan Quintela <quintela@redhat.com>
References: <20230627114101.122231-1-thuth@redhat.com>
 <585834bf-33a0-2a64-0bba-f1f47df41275@linux.ibm.com>
 <563ee2d5-ce64-de5f-02fc-8eb08be68854@redhat.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <563ee2d5-ce64-de5f-02fc-8eb08be68854@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mnVlNwIQXIJSFEoCPi65F2M-wFeniPjK
X-Proofpoint-ORIG-GUID: bziT-HHoIDWBmA0mPGJ2TaOFmhK3RAqV
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_04,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0
 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280075
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 URI_DOTEDU=1.999 autolearn=no autolearn_force=no
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



Am 28.06.23 um 10:32 schrieb Thomas Huth:
> On 27/06/2023 14.19, Christian Borntraeger wrote:
>>
>>
>> Am 27.06.23 um 13:41 schrieb Thomas Huth:
>>> Using types starting with double underscores should be avoided since these
>>> names are marked as reserved by the C standard. The corresponding Linux
>>
>> In general I think this change is fine, but this is kind of interesting, as
>> /usr/include/linux/types.h does have __u64 and friends. In fact there is
>> __u64 but not u64 in /usr/include.
>>
>> And yes a google search for double underscore  has
>>
>> The use of two underscores (` __ ') in identifiers is reserved for the
>> compiler's internal use according to the ANSI-C standard. Underscores
>> (` _ ') are often used in names of library functions (such as " _main
>> " and " _exit "). In order to avoid collisions, do not begin an
>> identifier with an underscore.
>>
>>> kernel header file has also been changed accordingly a long time ago:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/diff/drivers/s390/cio/cio.h?id=cd6b4f27b9bb2a
>>
>> but IIRC from a kernel perspective u64 is for kernel internal uint64_t
>> and __u64 is for uapi, e.g. see
>> https://lkml.indiana.edu/hypermail/linux/kernel/1401.2/02851.html
>>
>> So in essence we (QEMU/s390-ccw) have to decide what to use for our
>> internal purposes. And yes, u64 and this patch is certainly ok. But
>> we might need to change the patch description
> 
> Ok, agreed, the patch description could be better. Maybe just something like this:
> 
> "
> The types starting with double underscores have likely been introduced into the s390-ccw bios to be able to re-use structs from the Linux kernel in the past, but the corresponding structs in cio.h have been changed there a long time ago already to not use the variants with the double underscores anymore:
> 
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/diff/drivers/s390/cio/cio.h?id=cd6b4f27b9bb2a
> 
> So it would be good to replace these in the s390-ccw bios now, too.

Yes, looks good.

