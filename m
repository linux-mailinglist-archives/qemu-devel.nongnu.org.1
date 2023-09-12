Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC2179B961
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 02:10:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfqxk-0006fN-Vt; Mon, 11 Sep 2023 20:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qfqxf-0006eM-4q
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 20:08:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qfqxb-0003yK-Gu
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 20:08:58 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38C06GYZ007710
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 00:08:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=aOY5ZqcHpCqEQ9OC+5/IM81aK919yoRuJpchQiqeqFs=;
 b=VDeY8Qwek8ninlydfZn4Cfe/qtWOSTNiQF5YiM4sbaGO8QHY1RZSJJhZ9z+BSb7oslkW
 mytiXJSsoZMZxEEDcooYjsVhgT0mC/xVFMPc4pUWkwLtkoGztXmQ/b61NskMjRqGJT1X
 Tp2bWG8WCyWZ41NuzaxTM/wFw+a7vtn5LiYdjB3j9A1P/SBslI6CDYmstkwMZc6+LQ5Y
 WGz1IZ4hAoPSW//rLGwStzdJc6zO6pObUxzee6ccnue5ZOm3EL24SJtrmGIlyB+jd8UD
 T2aOeNf5owv/bLzeYQg5RK2yrjiRzlFGMb627nXm7Tmu3+LDxGoeHvrNyqnEXX40akEX aw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2bm9a3j2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 00:08:53 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38C06nlx012224
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 00:08:52 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2bm9a3ht-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Sep 2023 00:08:52 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38BNu0X8012169; Tue, 12 Sep 2023 00:08:52 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t13dyf036-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Sep 2023 00:08:51 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38C08pvI17039678
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Sep 2023 00:08:51 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3EDB658060;
 Tue, 12 Sep 2023 00:08:51 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0533C5805A;
 Tue, 12 Sep 2023 00:08:51 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 12 Sep 2023 00:08:50 +0000 (GMT)
Message-ID: <dcf26f94-4b0b-e992-1207-a1ee73f21508@linux.ibm.com>
Date: Mon, 11 Sep 2023 20:08:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] tpm: fix crash when FD >= 1024
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20230911132551.1421276-1-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230911132551.1421276-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YrsMeVY3GXSpnXnmbQG-4mguYUshRL8s
X-Proofpoint-ORIG-GUID: DL-uhSSp08hD7xuSg7xZl2Sei-wtHcSN
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_19,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110221
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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


On 9/11/23 09:25, marcandre.lureau@redhat.com wrote:
> From: Marc-Andr޸ Lureau <marcandre.lureau@redhat.com>
>
> Replace select() with poll() to fix a crash when QEMU has a large number
> of FDs.
>
> Fixes:
> https://bugzilla.redhat.com/show_bug.cgi?id=2020133

For backporting I think we should also add this tag here:

Fixes:  ca64b08638 ("tpm: Move backend code under the 'backends/' 
directory")

Though RETRY_ON_EINTR was only introduced in 8.0.0-rc0. What's the right 
tag for backporting then?

    Stefan


> Signed-off-by: Marc-Andr޸ Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>   backends/tpm/tpm_util.c | 11 ++---------
>   1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
> index a6e6d3e72f..1856589c3b 100644
> --- a/backends/tpm/tpm_util.c
> +++ b/backends/tpm/tpm_util.c
> @@ -112,12 +112,8 @@ static int tpm_util_request(int fd,
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
>
>       n = write(fd, request, requestlen);
>       if (n < 0) {
> @@ -127,11 +123,8 @@ static int tpm_util_request(int fd,
>           return -EFAULT;
>       }
>
> -    FD_ZERO(&readfds);
> -    FD_SET(fd, &readfds);
> -
>       /* wait for a second */
> -    n = select(fd + 1, &readfds, NULL, NULL, &tv);
> +    n = RETRY_ON_EINTR(g_poll(fds, 1, 1000));
>       if (n != 1) {
>           return -errno;
>       }

