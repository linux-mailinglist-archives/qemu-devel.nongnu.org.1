Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EED97837299
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 20:32:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS00C-0006Sw-74; Mon, 22 Jan 2024 14:30:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1rS00A-0006Sk-0J
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 14:30:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1rS008-0006Kz-Ad
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 14:30:33 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40MIZR6f008164; Mon, 22 Jan 2024 19:30:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=iWSEL8pC2DjyWxJJ+zRL8B9kKcLRztdBVq29E4rdOXs=;
 b=fdZIlnePiwKv9Gx6GHRglmaGlzgQ1IVR+icU8rD5kfK0h/o2SUNfSEBPyYcaXFRqrpmc
 TzPnPm6kc/Y9gFlpus1XXJ3h+e7cv+0qqLA2IpqXOhpST1wWnUKP9PHisQ0ULbg+fqG8
 If52QUV8sGu1nTkTnaJJQAtvWdnrg7sSRdLBD9K7y0s2HT/6uyGJxNOAGB/BzPZ0tuqw
 SOpbCt3IGotUnjANd6/Fo9IVn2/Fou/xAD8XX9fbT38/bU1lYIKBn4dpefm6oaMsYCAh
 bF985O9vNhhYFS2iJrNupIph/OGC+HwUDw9YkQRFZZovH0XEKGhnIMpKwThE7QHcnHYs ew== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vsurfcsjt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 19:30:23 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40MJ0LBg008253;
 Mon, 22 Jan 2024 19:30:23 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vsurfcshw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 19:30:23 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40MGR2fa022395; Mon, 22 Jan 2024 19:30:22 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vrt0kthfq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 19:30:22 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40MJULRQ29622646
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jan 2024 19:30:21 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4213A58057;
 Mon, 22 Jan 2024 19:30:21 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E9CB65805D;
 Mon, 22 Jan 2024 19:30:20 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 22 Jan 2024 19:30:20 +0000 (GMT)
Message-ID: <130d2f10-4165-4d35-ade3-e6080e2a109f@linux.ibm.com>
Date: Mon, 22 Jan 2024 14:30:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] Exclude TPM ioctls definitions for the GNU/Hurd
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Manolo de Medici <manolodemedici@gmail.com>
Cc: qemu-devel@nongnu.org, bug-hurd@gnu.org
References: <CAHP40m=_7zOT5bnp1FR12ohVbm-miUorh6+rrk2Rwd1jArR1VA@mail.gmail.com>
 <CAFEAcA_ZyphRxH59VHEpnS_8D4YuBFSZeODwRbMjrqhkggD-Cw@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAFEAcA_ZyphRxH59VHEpnS_8D4YuBFSZeODwRbMjrqhkggD-Cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SxNXnVSPDhPeF7eHSqKdMnMFroEoUGmf
X-Proofpoint-GUID: k2ZHBbGcggV4wdJRfZvlmXjakhLGKrQl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_09,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 clxscore=1011 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401220138
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 1/22/24 12:16, Peter Maydell wrote:
> On Thu, 18 Jan 2024 at 16:04, Manolo de Medici <manolodemedici@gmail.com> wrote:
>>
>> The Hurd currently doesn't have any TPM driver, compilation fails
>> for missing symbols unless these are left undefined.
>>
>> Signed-off-by: Manolo de Medici <manolo.demedici@gmail.com>
>> ---
>>   backends/tpm/tpm_ioctl.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/backends/tpm/tpm_ioctl.h b/backends/tpm/tpm_ioctl.h
>> index 1933ab6855..c721bf8847 100644
>> --- a/backends/tpm/tpm_ioctl.h
>> +++ b/backends/tpm/tpm_ioctl.h
>> @@ -274,7 +274,7 @@ typedef struct ptm_lockstorage ptm_lockstorage;
>>   #define PTM_CAP_SEND_COMMAND_HEADER (1 << 15)
>>   #define PTM_CAP_LOCK_STORAGE       (1 << 16)
>>
>> -#ifndef _WIN32
>> +#if !defined(_WIN32) && !defined(__GNU__)
>>   enum {
>>       PTM_GET_CAPABILITY     = _IOR('P', 0, ptm_cap),
>>       PTM_INIT               = _IOWR('P', 1, ptm_init),
>> --
>> 2.43.0
> 
> This looks plausible as a change, but looking at the history
> of the file in git it seems like this is a file we import
> from a third-party swtpm project.
> 
> Stefan: should we get this change made in the swtpm project
> too? Or have we diverged from that copy of the header?

The diffs are minimal at the moment:
$ diff swtpm/include/swtpm/tpm_ioctl.h qemu/backends/tpm/tpm_ioctl.h
15,16d14
< #include <stdint.h>
< #include <sys/types.h>

Since we already handle _WIN32 we can just take this case for __GNU__.

   Stefan

> If the latter, then the simple thing woud be to delete
> this enum entirely, because as far as I can see we don't
> use any of the values in QEMU, so we can avoid the
> portability problem that way.
> 
> thanks
> -- PMM
> 

