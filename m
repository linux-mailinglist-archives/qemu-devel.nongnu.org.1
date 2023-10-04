Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 712377B971A
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 00:04:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo9z3-0002of-FL; Wed, 04 Oct 2023 18:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qo9z1-0002my-0l; Wed, 04 Oct 2023 18:04:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qo9yy-0005BC-N8; Wed, 04 Oct 2023 18:04:42 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 394Lrv2H011126; Wed, 4 Oct 2023 22:04:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=SN7B2C72peGSDFGYI0S6afh6Wo2s+XULg/YGD5hexk8=;
 b=IOEMklrsIxMjxH6fFcTawG4maxY4MIf7GW6dqOx64lN7DkXesTV5yx27DiHmHJlDyNBg
 xSgvHzcag20+Ms37eQHu4xJkqVwut9uvGH36l9WfDUePlbz6a4ihUUNQI4yKIqqOQLmN
 luo6Sygzpp9LdicyU2rEjrFTqeA0c9Ct0kznaWpDFPUw5JbvymOsDNTTHKqG4NF2iD6t
 Qz50bGgk9qJc1Tc0yQnLS/3S2epDt3cPWeAT1jmxZ3G/+xoL7Pco0mmZpfllr3EXNfa/
 NS+eUcx9VFyhm/B21aMbClmytLyOdd8f/SQE/01RjqgaGExiG0cfpwNcytnZHyodESc+ zg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3thgccr7yt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 22:04:36 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 394Lsamq012600;
 Wed, 4 Oct 2023 22:04:35 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3thgccr7xu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 22:04:35 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 394L9NNR007467; Wed, 4 Oct 2023 22:04:34 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3teygkvthr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 22:04:34 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 394M4Ylf22807114
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Oct 2023 22:04:34 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F02DB58069;
 Wed,  4 Oct 2023 22:04:33 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D98D58052;
 Wed,  4 Oct 2023 22:04:33 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  4 Oct 2023 22:04:33 +0000 (GMT)
Message-ID: <661cf24b-1c9f-97a0-8259-c0b995089df6@linux.ibm.com>
Date: Wed, 4 Oct 2023 18:04:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 12/21] qapi: Inline and remove
 QERR_INVALID_PARAMETER_VALUE definition
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20231004173158.42591-1-philmd@linaro.org>
 <20231004173158.42591-13-philmd@linaro.org>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231004173158.42591-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JEDTWAFhwFCPHaIQTRb7BqkQmP2A6fm3
X-Proofpoint-GUID: gAVzrTUIbvuMt7_8FzqT5V2s3dGB3p2Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_12,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0
 clxscore=1011 impostorscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040159
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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


On 10/4/23 13:31, Philippe Mathieu-Daudé wrote:
> Address the comment added in commit 4629ed1e98
> ("qerror: Finally unused, clean up"), from 2015:
>
>    /*
>     * These macros will go away, please don't use
>     * in new code, and do not add new ones!
>     */
>
> Manually modify the error_report() call in softmmu/tpm.c,
> then use sed to mechanically transform the rest. Finally
> remove the definition in include/qapi/qmp/qerror.h.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


> ---
>   include/qapi/qmp/qerror.h | 3 ---
>   qapi/opts-visitor.c       | 4 ++--
>   qapi/qapi-visit-core.c    | 4 ++--
>   softmmu/tpm.c             | 3 +--
>   4 files changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
> index b723830eff..ac727d1c2d 100644
> --- a/include/qapi/qmp/qerror.h
> +++ b/include/qapi/qmp/qerror.h
> @@ -17,9 +17,6 @@
>    * add new ones!
>    */
>
> -#define QERR_INVALID_PARAMETER_VALUE \
> -    "Parameter '%s' expects %s"
> -
>   #define QERR_IO_ERROR \
>       "An IO error has occurred"
>
> diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
> index 0393704a73..844db583f4 100644
> --- a/qapi/opts-visitor.c
> +++ b/qapi/opts-visitor.c
> @@ -441,7 +441,7 @@ opts_type_int64(Visitor *v, const char *name, int64_t *obj, Error **errp)
>               }
>           }
>       }
> -    error_setg(errp, QERR_INVALID_PARAMETER_VALUE, opt->name,
> +    error_setg(errp, "Parameter '%s' expects %s", opt->name,
>                  (ov->list_mode == LM_NONE) ? "an int64 value" :
>                                               "an int64 value or range");
>       return false;
> @@ -494,7 +494,7 @@ opts_type_uint64(Visitor *v, const char *name, uint64_t *obj, Error **errp)
>               }
>           }
>       }
> -    error_setg(errp, QERR_INVALID_PARAMETER_VALUE, opt->name,
> +    error_setg(errp, "Parameter '%s' expects %s", opt->name,
>                  (ov->list_mode == LM_NONE) ? "a uint64 value" :
>                                               "a uint64 value or range");
>       return false;
> diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
> index 6c13510a2b..01793d6e74 100644
> --- a/qapi/qapi-visit-core.c
> +++ b/qapi/qapi-visit-core.c
> @@ -194,7 +194,7 @@ static bool visit_type_uintN(Visitor *v, uint64_t *obj, const char *name,
>       }
>       if (value > max) {
>           assert(v->type == VISITOR_INPUT);
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> +        error_setg(errp, "Parameter '%s' expects %s",
>                      name ? name : "null", type);
>           return false;
>       }
> @@ -262,7 +262,7 @@ static bool visit_type_intN(Visitor *v, int64_t *obj, const char *name,
>       }
>       if (value < min || value > max) {
>           assert(v->type == VISITOR_INPUT);
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> +        error_setg(errp, "Parameter '%s' expects %s",
>                      name ? name : "null", type);
>           return false;
>       }
> diff --git a/softmmu/tpm.c b/softmmu/tpm.c
> index 578563f05a..8437c4efc3 100644
> --- a/softmmu/tpm.c
> +++ b/softmmu/tpm.c
> @@ -120,8 +120,7 @@ static int tpm_init_tpmdev(void *dummy, QemuOpts *opts, Error **errp)
>       i = qapi_enum_parse(&TpmType_lookup, value, -1, NULL);
>       be = i >= 0 ? tpm_be_find_by_type(i) : NULL;
>       if (be == NULL) {
> -        error_report(QERR_INVALID_PARAMETER_VALUE,
> -                     "type", "a TPM backend type");
> +        error_report("Parameter 'type' expects a TPM backend type");
>           tpm_display_backend_drivers();
>           return 1;
>       }

