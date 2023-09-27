Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 407337B0B0F
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 19:29:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlYKK-0001Zw-Bj; Wed, 27 Sep 2023 13:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qlYKH-0001ZY-QG
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 13:27:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qlYKF-0007Gr-Rz
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 13:27:53 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38RHPDKi007332
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 17:27:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=7wXpwdMHv77MTrXmUGP41OZBxUZuXt7K2Uc3AUJc+JU=;
 b=fFYBG3PYXap19QPbYxsl+HfAwVEq3gWjBKNR5b/gwWsGZXmex8JLUh5xLVYjJG8yWOvj
 OXnHffyuRNxgg8msivzgHvBXon7RjziUrtQan3gF3LgeW1gCkgSbCr/+bZnhwjUF3/o4
 grs+AMslqKAQMZKTZt56zRUR5I9MkiVC3YKjMc45EwlKsbvNlpykO/Egf5ZfQpecglZI
 6VnnbdvfMinPGBFsHj2j5EwLinuDh6jF+JbAd9+GQ7TrMZ9P9wYW8F/T/pLxHjgX8iw2
 7+OODAt/jvHbJtgQkJ01HkWTLmeHR1438orjuA19RnGdgbtncUm3nEP51WKvssDAiJQR /w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tcrsd821k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 17:27:48 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38RHQmLX014834
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 17:27:48 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tcrsd821e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Sep 2023 17:27:48 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38RH5eaB008445; Wed, 27 Sep 2023 17:27:47 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3taabswks5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Sep 2023 17:27:47 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38RHRkfm35390106
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Sep 2023 17:27:46 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 605FE5803F;
 Wed, 27 Sep 2023 17:27:46 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 03BEB5805A;
 Wed, 27 Sep 2023 17:27:46 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 27 Sep 2023 17:27:45 +0000 (GMT)
Message-ID: <f05031c2-82b9-4b86-17ab-5e39489715c0@linux.ibm.com>
Date: Wed, 27 Sep 2023 13:27:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 1/2] tpm: convert tpmdev options processing to new
 visitor format
Content-Language: en-US
To: James Bottomley <jejb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20230927164908.12891-1-jejb@linux.ibm.com>
 <20230927164908.12891-2-jejb@linux.ibm.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230927164908.12891-2-jejb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cbc0eJafEmD4H6NeNzao1ae73Q-v4DGP
X-Proofpoint-ORIG-GUID: d1oeScUfKO-3n5CXPhl9K4f0iqE7Aogt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_12,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270145
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


On 9/27/23 12:49, James Bottomley wrote:
> From: James Bottomley <James.Bottomley@HansenPartnership.com>
>
> Instead of processing the tpmdev options using the old qemu options,
> convert to the new visitor format which also allows the passing of
> json on the command line.
>
> Signed-off-by: James Bottomley <jejb@linux.ibm.com>
>
> ---
> v4: add TpmConfiOptions
> v5: exit(0) for help
> v7: adjust line lengths, free options
> ---
>   backends/tpm/tpm_emulator.c    | 25 ++++------
>   backends/tpm/tpm_passthrough.c | 23 +++------
>   include/sysemu/tpm.h           |  4 +-
>   include/sysemu/tpm_backend.h   |  2 +-
>   qapi/tpm.json                  | 19 +++++++
>   softmmu/tpm.c                  | 91 ++++++++++++++--------------------
>   softmmu/vl.c                   | 19 +------
>   7 files changed, 78 insertions(+), 105 deletions(-)
>
> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
> index 402a2d6312..833520e49a 100644
> --- a/backends/tpm/tpm_emulator.c
> +++ b/backends/tpm/tpm_emulator.c
> @@ -583,33 +583,29 @@ err_exit:
>       return -1;
>   }
>   
> -static int tpm_emulator_handle_device_opts(TPMEmulator *tpm_emu, QemuOpts *opts)
> +static int tpm_emulator_handle_device_opts(TPMEmulator *tpm_emu,
> +                                           TpmCreateOptions *opts)
>   {
> -    const char *value;
>       Error *err = NULL;
>       Chardev *dev;
>   
> -    value = qemu_opt_get(opts, "chardev");
> -    if (!value) {
> -        error_report("tpm-emulator: parameter 'chardev' is missing");
> -        goto err;
> -    }
> +    tpm_emu->options = QAPI_CLONE(TPMEmulatorOptions, &opts->u.emulator);
> +    tpm_emu->data_ioc = NULL;
>   
> -    dev = qemu_chr_find(value);
> +    dev = qemu_chr_find(opts->u.emulator.chardev);
>       if (!dev) {
> -        error_report("tpm-emulator: tpm chardev '%s' not found", value);
> +        error_report("tpm-emulator: tpm chardev '%s' not found",
> +                opts->u.emulator.chardev);

still, indentation.


--- a/qapi/tpm.json
> +++ b/qapi/tpm.json
> @@ -138,6 +138,25 @@
>               'emulator': 'TPMEmulatorOptionsWrapper' },
>     'if': 'CONFIG_TPM' }
>   
> +##
> +# @TpmCreateOptions:
> +#
> +# A union referencing different TPM backend types' configuration options
> +#   without the wrapper to be usable by visitors.
> +#
> +# @type: - 'passthrough' The configuration options for the TPM passthrough type
> +#        - 'emulator' The configuration options for TPM emulator backend type
> +#
> +# Since: 7.2
> +##'


Should probably be 8.2.


With the above fixed:

Tested-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>



