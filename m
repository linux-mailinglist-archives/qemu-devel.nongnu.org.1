Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DC576E811
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 14:17:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRXFU-00042o-Ey; Thu, 03 Aug 2023 08:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qRXFR-00042Y-M9
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 08:16:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qRXFP-0005Eg-L0
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 08:16:09 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 373CERoc004203; Thu, 3 Aug 2023 12:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=HkfnvOAvl135IpNMJGF+fVIHtA4ReeFn7Ntf4/ELbWg=;
 b=OYAaonLKaKce3MHmy5r0BwT8pCry3DUUmevlKJWGxq5E3cI8yX+JDNc1V6YRQRMj0HQC
 skTf+b3IGGtuJ4oaNSwghRtnbV8DWKuyP14YStO7h3l7OlfWfHZJgTKWVdNZgqi0sfgc
 lqQ2S1UFp7TlzSnzsxrwv+LPCxT7lqpIw5SSeySRWM+hX79vMw5S1RaDWLmdXdJo90k2
 8xcE8WMVC6/5zJCVb3VqIpNsarEq0QTRi/k7C1if2LqRc2vodRMnvBkqeTv/bECsbRy5
 31xCy7z0hvdIvmmfc44oA8O9hmEpACmPhi8wsgXsRkaFf997A1fAVC0fgAwHbtFNQLlz OA== 
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s8bur8c8x-11
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Aug 2023 12:15:21 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 373B0Ger015481; Thu, 3 Aug 2023 11:35:08 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s5e3nd25t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Aug 2023 11:35:08 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 373BZ7n85309094
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Aug 2023 11:35:07 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4DF6358063;
 Thu,  3 Aug 2023 11:35:07 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E6DD458056;
 Thu,  3 Aug 2023 11:35:06 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  3 Aug 2023 11:35:06 +0000 (GMT)
Message-ID: <d3391823-38ff-0c3f-c024-26397789ce5a@linux.ibm.com>
Date: Thu, 3 Aug 2023 07:35:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 08/11] hw/loongarch/virt: add plug handler for TPM on
 SysBus
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>
References: <20230714070931.23476-1-j@getutm.app>
 <20230714070931.23476-9-j@getutm.app>
 <51616167-319e-aadd-4033-042c180b797e@linux.ibm.com>
In-Reply-To: <51616167-319e-aadd-4033-042c180b797e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QynLLNHvfWLkNBTJjw0BeuWf0EvCazsG
X-Proofpoint-GUID: QynLLNHvfWLkNBTJjw0BeuWf0EvCazsG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_11,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=910 clxscore=1011
 adultscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308030108
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 7/20/23 13:57, Stefan Berger wrote:
> 
> 
> On 7/14/23 03:09, Joelle van Dyne wrote:
>> TPM needs to know its own base address in order to generate its DSDT
>> device entry.
>>
>> Signed-off-by: Joelle van Dyne <j@getutm.app>
> 
> 
> It would be great to also cover the crb-device  with tests:
> 
> from tests/qtest/meson.build:
> 
>    (config_all.has_key('CONFIG_TCG') and config_all_devices.has_key('CONFIG_TPM_TIS_SYSBUS') ?            \
>      ['tpm-tis-device-test', 'tpm-tis-device-swtpm-test'] : []) +                                         \
> 
> It should be easy to make a copy of these two tis-device tests and rename them to crb-device tests, adapt them, and run them at least on aarch64.

... actually make a copy of the files tests/qtest/tpm-crb-swtpm-test.c & tests/qtest/tpm-crb-test.c.

> 
> Regards,
>     Stefan

