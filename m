Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B6683759E
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 22:51:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS2Bq-0003vz-CC; Mon, 22 Jan 2024 16:50:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1rS2Bb-0003rr-FB
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 16:50:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1rS2BY-0000mz-IE
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 16:50:29 -0500
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40MJlDeA000791; Mon, 22 Jan 2024 21:50:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=yvufu5WV3pdUFecNaztgTEy/SaLjTzcl7J5GjThuX6c=;
 b=dvQN1uY4lWVKLAOpvf5NkHvmCV3a3iAkjhQgZz6jsQXcl1Lnxd2pvD5n5YpKtqdF65M/
 cDtx4Ogob0Cn5oG/vOIPW/kSxUdF67WrWrH8EKOcn+sSzvdqEgLlY3rDIn+inqUzi5Rg
 hCQveCRTeGLiGcWxH6ZAazmycdIluazeTatz+AjSq6lp5LghZoz82FzjY90m62QYyMkl
 nnRyGOlAgJGCciyjMAte47e385e1Y0O5WCF2UwDtUxIvknpyiDFSTdCJOkD7dXK6xXB8
 RT0gG7WKk3SwY+BxA10rFnatAWVi0aj8dfPuR6qyGVrsmZu1/W3SrEkE6SIVMMv4pcRP 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vsxtr2qbx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 21:50:22 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40MLkH1v011523;
 Mon, 22 Jan 2024 21:50:21 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vsxtr2qba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 21:50:21 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40MJiwgS022412; Mon, 22 Jan 2024 21:50:20 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vrt0ku592-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 21:50:20 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40MLoKHc14942800
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jan 2024 21:50:20 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C0D758056;
 Mon, 22 Jan 2024 21:50:20 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B55145803F;
 Mon, 22 Jan 2024 21:50:19 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 22 Jan 2024 21:50:19 +0000 (GMT)
Message-ID: <0713a717-6220-41b3-a578-53f1f0beb2c0@linux.ibm.com>
Date: Mon, 22 Jan 2024 16:50:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] Exclude TPM ioctls definitions for the GNU/Hurd
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Manolo de Medici <manolodemedici@gmail.com>, qemu-devel@nongnu.org,
 bug-hurd@gnu.org
References: <CAHP40m=_7zOT5bnp1FR12ohVbm-miUorh6+rrk2Rwd1jArR1VA@mail.gmail.com>
 <CAFEAcA_ZyphRxH59VHEpnS_8D4YuBFSZeODwRbMjrqhkggD-Cw@mail.gmail.com>
 <130d2f10-4165-4d35-ade3-e6080e2a109f@linux.ibm.com>
 <CAFEAcA-k8MF6f6fAa8Hn1B8z4H-Ott8d7G1tZRqxVtQyY+O9og@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAFEAcA-k8MF6f6fAa8Hn1B8z4H-Ott8d7G1tZRqxVtQyY+O9og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IBIpHfF5uaZeQ_vj_nbw3608A29VSVqy
X-Proofpoint-ORIG-GUID: WZvrhXYEMoLKpU2FcSKHFVWH4z-L_N9l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_09,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401220154
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



On 1/22/24 15:46, Peter Maydell wrote:
> On Mon, 22 Jan 2024 at 19:30, Stefan Berger <stefanb@linux.ibm.com> wrote:
>>
>>
>>
>> On 1/22/24 12:16, Peter Maydell wrote:
>>> On Thu, 18 Jan 2024 at 16:04, Manolo de Medici <manolodemedici@gmail.com> wrote:
>>>>
>>>> The Hurd currently doesn't have any TPM driver, compilation fails
>>>> for missing symbols unless these are left undefined.
>>>>
>>>> Signed-off-by: Manolo de Medici <manolo.demedici@gmail.com>
>>>> ---
>>>>    backends/tpm/tpm_ioctl.h | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/backends/tpm/tpm_ioctl.h b/backends/tpm/tpm_ioctl.h
>>>> index 1933ab6855..c721bf8847 100644
>>>> --- a/backends/tpm/tpm_ioctl.h
>>>> +++ b/backends/tpm/tpm_ioctl.h
>>>> @@ -274,7 +274,7 @@ typedef struct ptm_lockstorage ptm_lockstorage;
>>>>    #define PTM_CAP_SEND_COMMAND_HEADER (1 << 15)
>>>>    #define PTM_CAP_LOCK_STORAGE       (1 << 16)
>>>>
>>>> -#ifndef _WIN32
>>>> +#if !defined(_WIN32) && !defined(__GNU__)
>>>>    enum {
>>>>        PTM_GET_CAPABILITY     = _IOR('P', 0, ptm_cap),
>>>>        PTM_INIT               = _IOWR('P', 1, ptm_init),
>>>> --
>>>> 2.43.0
>>>
>>> This looks plausible as a change, but looking at the history
>>> of the file in git it seems like this is a file we import
>>> from a third-party swtpm project.
>>>
>>> Stefan: should we get this change made in the swtpm project
>>> too? Or have we diverged from that copy of the header?
>>
>> The diffs are minimal at the moment:
>> $ diff swtpm/include/swtpm/tpm_ioctl.h qemu/backends/tpm/tpm_ioctl.h
>> 15,16d14
>> < #include <stdint.h>
>> < #include <sys/types.h>
>>
>> Since we already handle _WIN32 we can just take this case for __GNU__.
> 
> OK, so how should we handle the mechanics of it -- just take
> this commit in QEMU and then you'll sort it out in swtpm?

Yes.

> Or do we need to change swtpm first and then sync?

No.

Regarding the patch:

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> 
> thanks
> -- PMM

