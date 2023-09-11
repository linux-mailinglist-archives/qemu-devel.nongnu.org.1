Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C46F979A816
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 14:58:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfgTH-0001i1-Mr; Mon, 11 Sep 2023 08:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qfgTB-0001hi-Cm
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 08:56:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qfgT6-0007uA-Nt
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 08:56:49 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38BCreOC032580
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 12:56:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=i8LRrr+UvU/WNQy7KSvniSkkbRTVdcB6KmojzvrrhYc=;
 b=njqUgeoa/iIxm/0DdghQqJwLTJtkJMAl9bvtctlCG13GQZuPRpsVqqhnOx9GACN1ljdU
 bGhU5E79LBxH7HS7cdALNO7XVGuf9BOb4HpfcjxY7F4Jh267QYbOwD0AZQRS7covuvoF
 9VJpqSoKkRF+Suo5iJ6JZdAcKYKuehL17QKv31vpnyIpdS3J1+PE8Dos4dqUkcOuf+67
 DTrXNthtlGsy9uliYP3kLSpIaRQc8fs1bWaiM6vgN3En2CMMn6657y7vjnEixQnOl7dP
 xHaFWTqUJ2c+H01GECpMql6csFeOPlZ6ZJgBo31Ca1CvCTWfMIVX1ragtbVyK+kC3ui4 zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t23a402d0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 12:56:37 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38BCri3l032687
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 12:56:35 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t23a402cd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Sep 2023 12:56:35 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38BAbZ4l002775; Mon, 11 Sep 2023 12:56:34 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t14hkjd16-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Sep 2023 12:56:34 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38BCuXvT721644
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Sep 2023 12:56:33 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 55E1A58056;
 Mon, 11 Sep 2023 12:56:33 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B0AE5803F;
 Mon, 11 Sep 2023 12:56:33 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 11 Sep 2023 12:56:32 +0000 (GMT)
Message-ID: <ede09511-9f7d-9ca9-23f6-97d3a5af1c21@linux.ibm.com>
Date: Mon, 11 Sep 2023 08:56:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tpm: fix crash when FD >= 1024
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20230911113614.1412887-1-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230911113614.1412887-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fXZwXs-LzLfLeOYi0VxKAZM-FFu0m7Fd
X-Proofpoint-GUID: so-0zs54EdjOsAPk_FlUOQICL8PIznqU
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 bulkscore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 lowpriorityscore=0
 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110114
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


On 9/11/23 07:36, marcandre.lureau@redhat.com wrote:
> From: Marc-Andr޸ Lureau <marcandre.lureau@redhat.com>
>
> Replace select() with poll() to fix a crash when QEMU has a large number
> of FDs.
>
> Fixes:
> https://bugzilla.redhat.com/show_bug.cgi?id=2020133

The description there seems wrong. It's a limit of the POSIX API not the 
vTPM device driver.

>
> Signed-off-by: Marc-Andr޸ Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>



> ---
>   backends/tpm/tpm_util.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
> index a6e6d3e72f..5f4c9f5b6f 100644
> --- a/backends/tpm/tpm_util.c
> +++ b/backends/tpm/tpm_util.c
> @@ -112,12 +112,9 @@ static int tpm_util_request(int fd,
>                               void *response,
>                               size_t responselen)
>   {
> -    fd_set readfds;
> +    GPollFD fds[1] = { {.fd = fd, .events = G_IO_IN } };
>       int n;
> -    struct timeval tv = {
> -        .tv_sec = 1,
> -        .tv_usec = 0,
> -    };
> +    int timeout = 1000;
>
>       n = write(fd, request, requestlen);
>       if (n < 0) {
> @@ -127,11 +124,8 @@ static int tpm_util_request(int fd,
>           return -EFAULT;
>       }
>
> -    FD_ZERO(&readfds);
> -    FD_SET(fd, &readfds);
> -
>       /* wait for a second */
> -    n = select(fd + 1, &readfds, NULL, NULL, &tv);
> +    n = RETRY_ON_EINTR(g_poll(fds, 1, timeout));
>       if (n != 1) {
>           return -errno;
>       }

