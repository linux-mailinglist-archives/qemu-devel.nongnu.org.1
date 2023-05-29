Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 858D071472A
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 11:39:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3ZJu-00056Z-ND; Mon, 29 May 2023 05:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q3ZJs-00055z-Re
 for qemu-devel@nongnu.org; Mon, 29 May 2023 05:37:40 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q3ZJq-0008F5-PB
 for qemu-devel@nongnu.org; Mon, 29 May 2023 05:37:40 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34T8qm6i001506; Mon, 29 May 2023 02:37:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=wGunqQDUybE5KYyKSPhlJJmxMVvBarKdix2x94HuLLM=;
 b=Ud+5ZI3EcKU05dEepCG2HmqhhBEJKY178WS93ukQXmn8zs2+pHeTaXRIO6IuNbFiKdTj
 HaPablv5QoZd7r/97+3jrKkcxxdXitrnypijrmJw6yXnEk3uC+U0i1ib6lHvQ9Bnxpif
 eG9z+W0icAZaxx/dDCidfIbVQzW9XEeiRaIJJKF86k8qugFTrc/QqlJFIrpD4hKEiFEi
 am4+BsrHnmRliBysC1EUWfLG8jHCejgea1R2QZg9mc4G5hiJ5ZpZnbhqPBn+fRmsihz+
 4M9FvhDShVVp/Sn9Docqjy3JUsLcwY26Wq7lLRgld1BVIdXse48BkwlJChTfFCvccXbl uw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3quh6ccub3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 May 2023 02:37:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIndXJ98qxq/tzUcN2rONbnEokmo9BmuUPdQa4Gkc9Dc2I4h9RO5szgzNP2myu4FfmedNtxrq4FiU2c7f07R+wdpySWXGp37SCmbVs+Dwtb85IzHB2+ib2+nPW39eHSpEdMehAE563XaTV2w7IRIxwmi98rKYRZzKVVfgfhNc/NmMWULQHm0KFBtnaeSPnb483vinJuwmJz0MguFD0GN+rloVevKcLJCvr+TyZ2qi57BiehP7Q5OVETOxEge1zpdx3mt0sfj6HO0NinBBE9SMWgPfvOBm1SyqoN14wFvLhgcR1zeHhN0bb7mOkOQ9lF9BpDOpOGmZKxpZV6yKx5jzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGunqQDUybE5KYyKSPhlJJmxMVvBarKdix2x94HuLLM=;
 b=VrOdeiNiE/gYGfjQTN52wNbx6z6HttkmKssyKPm6jmIcXIouCfXwgWBTMwf3u0TkzFk8nF3sOxjkNUO0vHbvE7RTqzrtWwNo+fhdHHG/5Y3/NB6Uhi/SpHnn+uPBXRXnVuGp4WnkCPtcA0ouocYOBPopq+1hy1u2rqasTSteAZXn5QCQpD8sXVcXqzXBSYpVXzjaw/3Y3Up+p4F88TKliW+ZJSf/53nYEw8VgaDqrTo+oLJB168nGmPw9pnABnS37v3bR8AmQF9WMBkr+PdpzGwrAzipZxB9fuFE3fWLl3pr2KsnZ9CjkA+q+s/HfUWQpMBLxKz7vK62k2+cLS1q2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGunqQDUybE5KYyKSPhlJJmxMVvBarKdix2x94HuLLM=;
 b=p82y+GatlghJs+uR69kgfmvK5nTn+GlYzOImW6nFg1UH81hcyBka087ro3izck2FtTJuW7N/6yf/fkG/1BicYfboLHTs22cTwmfylCTh8jto7urVEmqEIjYZQOzYH4rvSzxK7AEPvfblDA0w4Qntq7sZzF7TuyD2YDtkdUmKVw5ulfuv9PaX3HfzVR5hBpC/hx9hJPn6fm5b+vwAdMc3WkgvepQhCboWE64H7NzEYZwK8SzW7BXTS3seMED0RlRmkTP9DBWBDP+1+aL1RjxAr6OCBzCV5TitadfIJWF8hHLtuRBh9Y+ffcbqfLBar564od30vrUNcLE6ITW2bmOIsA==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by DM6PR02MB6665.namprd02.prod.outlook.com (2603:10b6:5:214::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Mon, 29 May
 2023 09:37:29 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::1a4c:7e55:b776:43cb]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::1a4c:7e55:b776:43cb%6]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 09:37:29 +0000
Message-ID: <af2e5fbe-75f5-d6dd-df8c-8894cc5b0056@nutanix.com>
Date: Mon, 29 May 2023 15:07:17 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v5 1/9] migration: introduced 'MigrateAddress' in QAPI for
 migration wire protocol.
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, prerna.saxena@nutanix.com, quintela@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20230519094617.7078-1-het.gala@nutanix.com>
 <20230519094617.7078-2-het.gala@nutanix.com> <87sfbkjow3.fsf@pond.sub.org>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <87sfbkjow3.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::13) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|DM6PR02MB6665:EE_
X-MS-Office365-Filtering-Correlation-Id: 14360989-215d-4833-d6c4-08db60285162
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J2DPpPr+L3f9AysKyqBclSGQ8wGu2tAP+7WZW2QrbI4y5SITP3aYW0F877ZlxOo3unbaA5NGJgnCeb1Kx+Q0yvxDVBZgmsFQDt+KzPxRE8ulOr+NOPgVrXjRh5fJm/QPGCRhj32nxAD4mUb8DAzmGuXcHfdFhfhlCkGKkiUI7n9hPa6TR44GmN/n/TisUAdO2Om5HC2G2F4cR30wYfoMP9QXnHa3TtWbBHlZfWH02GzL953PNhlWl4krvnoR+Mjh91q0SO0VNVLUjhuPbLJP7ZUulI6XgiWCwlpK0zQKleNYoo5qAx9XxqgKhLTYMLa1RJuocq8pMUQvZPh1QozpOIeMabrR52jpRus2fqzqIPtXjmM4uTVJQWBYngZ0xAM79DWOF1uhRQFJ3esu5OZa1fFmgkrR/vqNIqOUuU13N1wt5i+4AqxxklXqDr3zP+hrtG3MM78bY7JBWqTk4R5VyeKW0oMkJ0EPViWPWvkir/jmNrS2YDgG3scN6BacrQTDZMkazFNMwOPnnemixUIjPJ2OgXMAuDZOsy8aMGzTfneK1UmXj2pRtF31vIzjoJFDx21T8pFPK918/1bNAEaLJbRVaR0KiWzoLTVMy4G7HJ7i3drdkzPqs+/qSd2mnhTsaDY0zZ/1qOYPVyht1FRxVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(396003)(39860400002)(366004)(346002)(136003)(451199021)(107886003)(31686004)(53546011)(186003)(38100700002)(41300700001)(26005)(6506007)(6512007)(6666004)(6486002)(2616005)(478600001)(66899021)(66476007)(66556008)(66946007)(4326008)(6916009)(316002)(44832011)(5660300002)(8676002)(2906002)(86362001)(31696002)(8936002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0hHc2tWdjVsWVNHNS9XOUFFejM5K3R0cXRMOVdjK0JUU2V0ZzliNEtwSUNT?=
 =?utf-8?B?VmtMVFhqTVg5MmpldmQwVVF1dlFMTGpzU1Zkd0h1WEZJQU9rVXphYnVHTHlk?=
 =?utf-8?B?UzZ0QllNeEJHMFViSHRPTnpqZHpmWk9GZ1BFODYzRGFjS3daSDJvMHh0WjQy?=
 =?utf-8?B?bnlISTVvc1VGdlE2ekRNK1NYVXkrUHh6T0FPcTI4ZHBkMEJ2ZVMrRktMYmlO?=
 =?utf-8?B?MGVCQmJ4aGY2NElzNWtXOEQxT1YrUG82R2hiblVXZ2tYbC9DcVFmT2Rxbng1?=
 =?utf-8?B?bUlGWmU3UDZ4SXNYS3BvTDBRTHlDdzNMT1dYTU14NmFoME02azJaeU5hejVB?=
 =?utf-8?B?TzNDSXg3WVM5SGxvK09sdUhsWHFRVlpHbFpOdjlyWHpvTEhVQWZTQjFHUGpi?=
 =?utf-8?B?aUN3YkFjQzB5RmFFQUZCUWRrYXBuWk5xQVYxZ1FOVG5qQk5hNTMzVldSMmVw?=
 =?utf-8?B?WUdNWEZLWU1xZjA4eXVOemMxK09nR1c0VVQ5OUI5S3NjS3JHTk5KZWF6WjZY?=
 =?utf-8?B?QnlkTmxHRW81a0dRdjlBUVBHamVTbW85dWp4R3ZlM2NOTk81MUNvZE1NdmxK?=
 =?utf-8?B?WXU0Y3JUYTBqMEtiS3MzN25SUVM3T2Qyb2RhK01HZkp5T2xqMmc3d3BlOHRW?=
 =?utf-8?B?bWxBR2NwUDFsdnJWVVV6RVg2S1JIL2k2MStsSnNoNEY5SDIrZ3BacmhyVmpL?=
 =?utf-8?B?a0FQcFkrK1V3TDZNOXE5dVJ0d2tXOHVPcEVXUEtZSmpXM0xyN282dk0rcW9Y?=
 =?utf-8?B?bWVBbWh4QUJ2bXl2YU1iSjMvbVJhbkE0YjdMR2FjcGswc0xuMXVsdVNCN0Yz?=
 =?utf-8?B?UnpscVZGVzdQZmRnWXhwR2ZZYjh6YSt4T1ZqRG12eHdFR244V213T25ZaUpW?=
 =?utf-8?B?bEp6SW82S2w5VkhXN2NPTGN1am5zSyszQlNkSWZzUHJBK3RvY0wwSnZZVkYy?=
 =?utf-8?B?ak5pOFhCY0VYZzhzdUpxQlNlUm0wOW9rOXlMY3BDRXU2QmxDWS95ZHZaTjhU?=
 =?utf-8?B?Si9NSWNWb0pVd0tpV2pUNXJJNkJNS3VXMlZXWUdpUitiTC9tNFVlUlNURGhs?=
 =?utf-8?B?ZC9ROWdubExBbTNWZHg5Q05PVmlRUVJtZmtDVm1LRm5Fd2gyalpqYmlEMDB3?=
 =?utf-8?B?dGczT1FicnJEMWxmMkY3MHFWOHBKZEpQd2lsTDhhcytKcFpJenlBZU1lNHRQ?=
 =?utf-8?B?c1RqKys0NC9IdHNIQjFQWERMV2pyQXF3ZldXcDBjWG50UlJzKzl6Z2xUcTJL?=
 =?utf-8?B?U292dytxbEFtZUxGcTRFb3p3Ny9vYUJxNG9oTUJyWWgzRUtjWkhHZnpZRHZG?=
 =?utf-8?B?UGw5OXdjZEYyc3Q5bnpla0N6R0p3MFpubWUwWnMxUThjV3ZaRVhrS3MzZkM3?=
 =?utf-8?B?QlMreGV0OFFMdzFYeUxDb3B1eDJSbDhhMVVQZm9RbHNWWTVwUnVzUEJGTVNz?=
 =?utf-8?B?SFpLU3VQV2JOcmVSbC8vbndZNGZYejExSlJXL2o0c1MyZ0ZtcVd4a1dld1hQ?=
 =?utf-8?B?SEJpblhNbGlrNEFvdlpCZEl1OTRhZkE0QU9IKzF5SkFwVkdJbU9WbWtobS9Z?=
 =?utf-8?B?ZWt4YkhhYzFXdlgvUFNUMjQvR2dZaGswMXBVVGxXTmhKQzlsRVdGbUVwL1lN?=
 =?utf-8?B?cmh6RUVRSTVGSmdXcmJxam44ZjNQSlorYUZvRmpnTExxdXk2cU5mdmdONGJs?=
 =?utf-8?B?dEk2bllPT05BTmxId2pYYkxHRFdxRWtNM3V2SWp1U2k2eE9PbkVrMXQ2S0o3?=
 =?utf-8?B?QjRxV0tPOXpnQUdoc204SFV2V0piVVFYMElmQTlraHdwSFdwaUkvV2ptRmdB?=
 =?utf-8?B?RG96OVhRZjl2NXVnSXgwTlo4Y1BaUVlpT1FqU3NKM1dFWU1uMU1VWjg2MTls?=
 =?utf-8?B?OWI1ZTdFcHVSaGdoUTB2MTFzVmFJKzNHZm5Bb1JId0pDbTBTa0tZWm9XVy9l?=
 =?utf-8?B?bjh2dElYTEdmN1d5Q2d4K3kydloyVCtFREh1enZiRHdiQUcvWmVKQVZEMy9a?=
 =?utf-8?B?WGp0ZGNFSGIwQmdJMXRtTnpwMkViNmlBTEg0UHkxZHNRY2NxSXdhQS9YdDZh?=
 =?utf-8?B?NHFscVYyMktxUlY1YUxPWVdpOVk0Z2w5bTdPTFJpa0MwM2J1d0xhZzVVeXlE?=
 =?utf-8?Q?coEQcDI4E70IewPj/PHfSbAtb?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14360989-215d-4833-d6c4-08db60285162
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 09:37:28.9683 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l9YawpKiVkHiKvv25n4q03/AFm790PtmUAKEqY2G/CeHqvXU/5bCI8TGI7zZZAuETIjdIk6Nr+wFXEZMzqkxTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6665
X-Proofpoint-ORIG-GUID: IAvLCXn78jDXKywRa4wOWQrzYUvPkk7u
X-Proofpoint-GUID: IAvLCXn78jDXKywRa4wOWQrzYUvPkk7u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-29_06,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.164,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


On 25/05/23 11:04 pm, Markus Armbruster wrote:
> Het Gala <het.gala@nutanix.com> writes:
>
>> This patch introduces well defined MigrateAddress struct and its related child
>> objects.
>>
>> The existing argument of 'migrate' and 'migrate-incoming' QAPI - 'uri' is of
>> string type. The current migration flow follows double encoding scheme for
>> fetching migration parameters such as 'uri' and this is not an ideal design.
>>
>> Motive for intoducing struct level design is to prevent double encoding of QAPI
>> arguments, as Qemu should be able to directly use the QAPI arguments without
>> any level of encoding.
>>
>> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
>> Signed-off-by: Het Gala <het.gala@nutanix.com>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>> ---
>>   qapi/migration.json | 41 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 41 insertions(+)
>>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 179af0c4d8..c500744bb7 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -1407,6 +1407,47 @@
>>   ##
>>   { 'command': 'migrate-continue', 'data': {'state': 'MigrationStatus'} }
>>   
>> +##
>> +# @MigrateTransport:
> I'd prefer MigrationTransport, because "migration" is a noun, while
> migrate is a verb.  Verbs are for commands.  For types we use nouns.
> More of the same below, not noting it again.
>
> Actually, I'd prefer MigrationAddressType, because it's purpose is to
> serve as discriminator type in union MigrationAddress.
Okay got it. I kept it Transport as they are different transport 
mechanisms. But 'MigrationAddressType' looks cleaner and comaptible with 
'MigrateAddress' union too. Will change that
>> +#
>> +# The supported communication transport mechanisms for migration
>> +#
>> +# @socket: Supported communication type between two devices for migration.
>> +#          Socket is able to cover all of 'tcp', 'unix', 'vsock' and
>> +#          'fd' already
> Migration is between hosts, not "two devices".

Here we are just talking about socket communication right ? So I thought 
devices might also work.

Will change that to 'hosts' as this is in context of migration i.e. 
MigrattionAddressType

> The second sentence confuses me.  What are you trying to say?
I am trying to say that socket is a union in itslef right, so it covers 
communication transport mechanisms like tcp, unix, vsock and fd already 
in it.
> Also, missing period at the end.
Ack.
>> +#
>> +# @exec: Supported communication type to redirect migration stream into file.
>> +#
>> +# @rdma: Supported communication type to redirect rdma type migration stream.
> What about:
>
>     ##
>     # @MigrationTransport:
>     #
>     # The migration stream transport mechanisms
>     #
>     # @socket: Migrate via socket
>     #
>     # @rdma: Migrate via RDMA
>     #
>     # @file: Direct the migration stream to a file

Should I change from '@exec' to '@file' ?

Other than that, it looks better than what I proposed. Will change it.

>> +#
>> +# Since 8.1
>> +##
>> +{ 'enum': 'MigrateTransport',
>> +  'data': ['socket', 'exec', 'rdma'] }
>> +
>> +##
>> +# @MigrateExecCommand:
> Documentation of @args is missing.
Ack. Should the naming '@args' be replaced by '@filepath' or @path' or 
something similar ?
>> + #
>> + # Since 8.1
>> + ##
> Unwanted indentation.
Not able to see any unwanted indentation here ?
>> +{ 'struct': 'MigrateExecCommand',
>> +   'data': {'args': [ 'str' ] } }
>> +
>> +##
>> +# @MigrateAddress:
>> +#
>> +# The options available for communication transport mechanisms for migration
> Not happy with this sentence (writing good documentation is hard).
>
> Is the address used for the destination only, or for the source as well?
>
> If destination only, could it be used for the source at least in theory?
>
> I'm asking because I need to understand more about intended use to be
> able to suggest doc improvements.
This address will be used on both destination and source. In code flow, 
in later patches, changes on destination as well as source have been 
made to incorporate same definition.
>> +#
>> +# Since 8.1
>> +##
>> +{ 'union': 'MigrateAddress',
>> +  'base': { 'transport' : 'MigrateTransport'},
>> +  'discriminator': 'transport',
>> +  'data': {
>> +    'socket': 'SocketAddress',
>> +    'exec': 'MigrateExecCommand',
>> +    'rdma': 'InetSocketAddress' } }
>> +
> Aside: a more powerful type system would let us extend SocketAddress
> with additional variants instead of wrapping it in a union.
Markus, what do you mean by additional variants here in context of 
socket? Can you give a small example.
>>   ##
>>   # @migrate:
>>   #
Regards,
Het Gala

