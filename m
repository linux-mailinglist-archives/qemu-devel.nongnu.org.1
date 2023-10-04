Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9477B8151
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 15:48:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo2EV-00050O-EF; Wed, 04 Oct 2023 09:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qo2EM-0004zx-3G; Wed, 04 Oct 2023 09:48:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qo2EI-00007c-VC; Wed, 04 Oct 2023 09:48:00 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 394DgJQw017408; Wed, 4 Oct 2023 13:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=QLZ61d/Bj8ie6VpJfdo/Wk8E+53pPs04LiAcjfypJ3Y=;
 b=Lu2SKQ7oAZKe076kjq++vUGZXdizNCiIEoyoxC1+IGKv/aEp0Qg+0SuppqXWkXZvg3vq
 DSzDgv4dJv3Zxc3dL5DUOn1/+nOTIr+0X7XxHN3FRR/IDTmS/+KWZqXlcXhZIpAwZptk
 0AoVkT2bi+XckW/kjMpiaT32vUh4LXhDKNog1iWpBezd94A+A5KlHHU1KGwFkboOkf99
 nwGjQM3xcvQDIUBVD2K6Fgw1iEjf5AFQD1vuOcECrk2N/z97QgRYLiKM+5qhMZI3wH0k
 teeAsn7c3ewa3BOhTAFkF3ihzgLF7EZU5UGeErq2f7sIPNfKS0MxJzht0kgrXPqYLjju qA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3th95s868e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 13:47:49 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 394Dgahb017827;
 Wed, 4 Oct 2023 13:47:49 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3th95s867p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 13:47:49 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 394DdNkL017611; Wed, 4 Oct 2023 13:47:48 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tey0nd3rd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 13:47:48 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 394DllZm28639606
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Oct 2023 13:47:47 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6555158052;
 Wed,  4 Oct 2023 13:47:47 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A1B735805A;
 Wed,  4 Oct 2023 13:47:46 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  4 Oct 2023 13:47:46 +0000 (GMT)
Message-ID: <818ebdcc-e2e1-be09-ad50-06cb9d1d3987@linux.ibm.com>
Date: Wed, 4 Oct 2023 09:47:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 15/16] sysemu/tpm: Clean up global variable shadowing
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20231004120019.93101-1-philmd@linaro.org>
 <20231004120019.93101-16-philmd@linaro.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231004120019.93101-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CQoUI55q-sb4I2d--fc1Fca1zoaY1eqs
X-Proofpoint-ORIG-GUID: JI4frXQQNY7IHGZcz5DSc82S0-LEvi5H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_05,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 clxscore=1011 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040099
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.528,
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


On 10/4/23 08:00, Philippe Mathieu-Daudé wrote:
> Fix:
>
>    softmmu/tpm.c:178:59: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>    int tpm_config_parse(QemuOptsList *opts_list, const char *optarg)
>                                                              ^
>    /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/getopt.h:77:14: note: previous declaration is here
>    extern char *optarg;                    /* getopt(3) external variables */
>                 ^
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>



> ---
>   include/sysemu/tpm.h | 2 +-
>   softmmu/tpm.c        | 6 +++---
>   2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
> index 66e3b45f30..1ee568b3b6 100644
> --- a/include/sysemu/tpm.h
> +++ b/include/sysemu/tpm.h
> @@ -17,7 +17,7 @@
>
>   #ifdef CONFIG_TPM
>
> -int tpm_config_parse(QemuOptsList *opts_list, const char *optarg);
> +int tpm_config_parse(QemuOptsList *opts_list, const char *optstr);
>   int tpm_init(void);
>   void tpm_cleanup(void);
>
> diff --git a/softmmu/tpm.c b/softmmu/tpm.c
> index 578563f05a..7164ea7ff1 100644
> --- a/softmmu/tpm.c
> +++ b/softmmu/tpm.c
> @@ -175,15 +175,15 @@ int tpm_init(void)
>    * Parse the TPM configuration options.
>    * To display all available TPM backends the user may use '-tpmdev help'
>    */
> -int tpm_config_parse(QemuOptsList *opts_list, const char *optarg)
> +int tpm_config_parse(QemuOptsList *opts_list, const char *optstr)
>   {
>       QemuOpts *opts;
>
> -    if (!strcmp(optarg, "help")) {
> +    if (!strcmp(optstr, "help")) {
>           tpm_display_backend_drivers();
>           return -1;
>       }
> -    opts = qemu_opts_parse_noisily(opts_list, optarg, true);
> +    opts = qemu_opts_parse_noisily(opts_list, optstr, true);
>       if (!opts) {
>           return -1;
>       }

