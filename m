Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6011C7E09A7
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 20:52:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qz0Cc-00057Z-JQ; Fri, 03 Nov 2023 15:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qz0CT-00054n-Br
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 15:51:32 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qz0CL-0003Qf-FU
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 15:51:22 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A3G7RsV006604; Fri, 3 Nov 2023 19:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=rE87bxc9l7LjL18emTo/c/3rps1UpkkOph8RyaIe0l4=;
 b=HiUHJJ63BW7uH2irnklHHLwqFh2BywY5bqoHCXgtR8vqPpWP4jfn19jizljOe03EooaL
 WnUdEKQ5O2UDZK4AhUHwwgugDCVHQvmzvMhHKeUqkej+bW/CPaK9dgn4NfNS1RxWMSTm
 Wg4dtHnPwBoI+z86mr2vjwoRRLUIiENIIssROnZelm/PkF8s8ZM8d68wOeVEmKrCaUGm
 E+oCRC/vOebBKQBMHM69nzPSsanGgvzo4eGgD7gcq+q/3VXYA1AscFmIpFNXTMJRebPm
 lGUyTy/KsGMkp1jC0P0MH0vovQQP34QmuoqFDZOyokhGjQoXEHq3viscxQ2ONLTlGEqJ mQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0tuumq1r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 03 Nov 2023 19:51:06 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3A3JXkQs009187; Fri, 3 Nov 2023 19:51:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3u14xadxee-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 03 Nov 2023 19:51:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4JIRBM+wG3QUzvFYCVrkZBgP3MHS8YmBrdHMyVZvKiyizRgL5vk7hFuKbvWWoW+M4p54p2wAIzpOnSgLGAM8QVpXGQHUhGaRgVkAd2APwRTJz+5f5rGSaqQjva7Mjlsmg2P2IkLu/ovvh622Mfqep0QV53uhtZfpyR1t39rIJJ0KJXiRUjho51PBkOzii5/Y/NsUJoXPQTi8DM9zMki4hPD0jeSBnz3oRviA+wRMa9GsexFQh8KdPJ0Qy4RxZQYjRlYFOoCqO7+ZnMh2cLZKlbV0JaK5aSS1GcOIFOWhi83OJfy0df0EHIsjtX3ndJ63HCUmkSyJxqb1E+IyoTraA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rE87bxc9l7LjL18emTo/c/3rps1UpkkOph8RyaIe0l4=;
 b=eZRNhDgkz9Hc2d70fRRMXdvbccJunufOE/UffUQ2SmK4XkNSL+uNWCFtGDnvpEz8RVeyHjtwng1chBoWIAk3mNDSFe3MCBdkVtnyeYZokLilLLlkuYOq8czXVpnvZfAca7CGzhXPYmj/I1V4lOjV5SlCOGYWlw4WbaEFGkjlvsRuOa5x8FCptwsRuMH4DQ9mcZU4UeUxT8HdtMtWwc8ZYXK8o+u7GQ6B0hHwjgZ69zvEyhThY0CTzZd92xss7q8wUvHPuyC1+y0jJ8P6dUcB6BIKZQCo0ssiS7HTu3AFzM/s6ymG9H/UJFlP12jK0SE1iywbcreO1fTItyDlscz+uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rE87bxc9l7LjL18emTo/c/3rps1UpkkOph8RyaIe0l4=;
 b=cifmP8Q27s6X0vfnMaYsuRFuYwaD3OyuIsTLnBxWD35KfR3t9ebt2kGJk8AphYPDlZ4FATxJJGON9lv6Ia/BTdEf4bwDMblnHQHaNrEK3bLCAq+ZrWMQxY9J/p6W0UHmZ5o3ApGF0I+U9h80dOb61pi5myGvuSNvI9LDVIKzT/I=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by BLAPR10MB5315.namprd10.prod.outlook.com (2603:10b6:208:324::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.24; Fri, 3 Nov
 2023 19:51:03 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 19:51:03 +0000
Message-ID: <3d45ebc0-de9f-4051-9c08-47e40fea65da@oracle.com>
Date: Fri, 3 Nov 2023 15:51:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] monitor: flush messages on abort
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <1699027289-213995-1-git-send-email-steven.sistare@oracle.com>
 <ZUUu2IuUQ/Od7+Vr@redhat.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZUUu2IuUQ/Od7+Vr@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR04CA0031.namprd04.prod.outlook.com
 (2603:10b6:a03:40::44) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|BLAPR10MB5315:EE_
X-MS-Office365-Filtering-Correlation-Id: 015c5719-3efe-494b-e5f5-08dbdca63635
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uoTlZIJx140DwoeYhoFapCMiwjmiCS2mEA7dh08eFE9qVwJoUekZ48tVTOB9B6p+we2QbUSuw+PhTPdFYvL6dTapw5ptp6J856b6rRUHQNhnzUoO8ywpbeXPiaukLNnxeV+C0DItq1XfxnJTZUAjXeUlh6WRZtGk7aMeUkviyUSaMjh6A95KU4A1BfdrV3B8OoaUzvDIPAY6V1OYkMbjNJS7hlVsKlKEzsvkIYA8Cc1WC9xRN6XqoU5EHCt3zqvjlIwY15ipOXsENv9Ir794NR4kc2VssmFX74HnZaw6FohfuPycWZkwvc1jwrWVecAOaCQ2GNANtmzvufkjKEMua3PyUpiLniuvHP5HHfEoh+465MUwXFXQ9etN7u4s/T/BdDd/WeerSpcrTxD6qXeuzLNXqrLAJtrEu1Lee87Vl9fmVAzOFRfEAO94M4N7RoDzRGu/t/CLZLQp7xLH7Ks6mLyOJHQY45Qq9GkiNIwPv1ruu8aOp8dS+TcgaaZygl3U6QxytgJmc75c2Ud92EI6XTK7dX54WRZ+mXmrTuCAHMxTzB6d+7EuOJxIrS5wpEuZXRrOxyPSECeNtbVlcrb8O0GTi28yoaKNzskaZfO9tYKYDTfRmPj7VYKsx29y8EwfLJO/iv3VFhyLcUUYxYwbzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(83380400001)(2616005)(26005)(86362001)(6916009)(66476007)(54906003)(316002)(66556008)(15650500001)(66946007)(2906002)(8936002)(4326008)(8676002)(31696002)(5660300002)(44832011)(41300700001)(36916002)(6512007)(6506007)(36756003)(53546011)(478600001)(6486002)(31686004)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkI4S1pLbllOalVmMUFoOW5QaG9WVW0wTFRwMHhKV2ZrYkFwWDlKNTVZZG51?=
 =?utf-8?B?V21FSC9waFBkanR1KzBKVUEzR1NRRHJPa3BRbkowdjRPQTcxRHQ5MWpBcGdn?=
 =?utf-8?B?K0ZreUhwZGpTY25UQUNyU2ErTnhQcy82OTRFTzZHek16dUlObWZWZzE2YzJN?=
 =?utf-8?B?cEVDOGdHSmxMZGd4cjBnR1FUVENwU2Y3SnlBdWNwQlhCeE1tU0E4SmhnVDFo?=
 =?utf-8?B?NFpWVFdxL0FrTEFRQ3ZBd2VlVDZlTmZENjMwNERmdjlLSEVuNkRWalJKNVVK?=
 =?utf-8?B?YTkxcjZML2VoY1NSdk0rY1g0YThRcVBJdUNJUGxXenQrbFhiL09GZ1dsK09u?=
 =?utf-8?B?dy9mQ0Fzek81VE5wbWl4bW5xLzNMNnhLS0xmNDlZRUwwWmt4Y2J6akN6aDdZ?=
 =?utf-8?B?b2s3M2p6MVpBalJha2wzRmVMUUdXWXp5R2V2cUlYRnhuYzl3NTYrdGcydjBU?=
 =?utf-8?B?Zy84dUhuM28rcVU4ZE5RVXQwSFdCbDNhUmZBZ2YrM0kzTFA2d1VJck1jWDlo?=
 =?utf-8?B?OGhzUGszYnFncjk3aEZFamhsWkRRT1RHQjlhRUxlc2RIR2FMQUNOckx1NFEx?=
 =?utf-8?B?R0RNSkZWNUtEblF4UVphbTUrcmhCTWdzMUltQXFONFBNbTNKWk1jZ3RUR043?=
 =?utf-8?B?b2w4SnNNV1Bld2tvekQ2MU9JYTh1SjJLMFh5T1FYSnlyTldvdHovaGVPMmdW?=
 =?utf-8?B?ZkNNYjl3ZmxObXZvbHBldE5MZFIva1RCdlNHSDZwbWx4bHN0bmRxNWphNVFq?=
 =?utf-8?B?SUJTWU43Q0dqeDNPc3JzcS9QL0QyWWVLWXc1YTE5Qm5EQ25POVFTeDBlM0NU?=
 =?utf-8?B?SUVDTjNGZUJVWWoxL0ZXNGZ5Q2lMMEFnKzcwUW9iSzZtbURzQVJ5elR1aFNB?=
 =?utf-8?B?ZWcyN0p3d1d6YkJEL0cwL2pvdnkzMHdzN0dsNk1sbVJWUmUvUHI5aEE2VFVT?=
 =?utf-8?B?bHhSRllDcCtrd29FMlltaXJVZk1VeVNVSUEwS1BTdFFwa3I4blFCU0xhV2dL?=
 =?utf-8?B?K2NEMUU1TmdjYkVWbHNMbkE4ZVNWd2d1NWJhTnh4a0VpRkhiV0UydTZHVWhu?=
 =?utf-8?B?WUp1V1pUdVhvcWRnd0w0SXFqUCsyYmZpRHNQTFI4dE9yN09CZHNxa3Nna2tT?=
 =?utf-8?B?L2VFMFBKaGp1M0RITEdIeXlmOVI1WWxzZTd6Z1ZHNGJMWjNSNFc0UWptNzRz?=
 =?utf-8?B?MnJDTEp3ckRaZzZuNDUrYjlPdmdsK2J5YXowWEpkelNqaksxQjc5MWFtNDNv?=
 =?utf-8?B?TytZYStWR1ZNbzJTTWVTdVZaa0djODQySFE5RUJZaks0bS9QMC94aEtEbDFD?=
 =?utf-8?B?MTJjd2JMdHE3U1NRbWk1Y283T3hGdGNmWFlodzVkQTVZQkJnUFd2TXVlYTFK?=
 =?utf-8?B?RnZseENxdnBramR2VkI3dFNMYTJKSGRqQzRreUsvT0xBZjhtRHhzR3FSSS94?=
 =?utf-8?B?alV2QkVWSVppdytvOERjTFBkSXdKWGRuZUhaeis4eXJjb3d5YS9hd3Z3UndH?=
 =?utf-8?B?MkM4OG8rQ3ZPbmR6L0VnMzF1NnhoWjU5aklzUWRFU1g1OWVaSVZSRk94bUtr?=
 =?utf-8?B?L3UwZ1grVWxjNWU4YlNoYWlvdWhQU2l4Rk5MV0tUSkhrbFJCN1E5VklDeGtY?=
 =?utf-8?B?UmZ0cUJ6NjFJTlV1dGV3eFR2RmwzQ3ZGcU9vbEF4ODN6Y2o4UzB1VTFkUDdK?=
 =?utf-8?B?eEhheXFqaTB4cW5jK3lKT1J3MDk1STlqZUJnSFVkVjUvSlZrZ0U4Zm1jNTli?=
 =?utf-8?B?ckJ4aG9raFBXUlRIWUxMRkIrUHgxNktPY3JBOWd4T3pnRUJnT3FKbklJRmJR?=
 =?utf-8?B?Y3Y3TVY4VlkxQVJibUdhU2NyYUFTTXVKM3RZN3BPRXFEaFBhYXhBMnJCVDRl?=
 =?utf-8?B?Rk1vN2pMMW9HNUZTd082WFBQWlZ2SC9uYnpPR3pRVTA5OHdCaWI1SkxGRjhD?=
 =?utf-8?B?KzdnMXVkcldWSk96aUwwbFpPbzc2dzcrcUFGdWhSaVQxKzhaMVdVeE5vTUhr?=
 =?utf-8?B?bE5NNS93WHQwOUI0QmE5UGNoUGxFckJwQURENnRtckdhdnNYd29GNGltSStZ?=
 =?utf-8?B?OUtnQ2l5Y1FpOXRSei9yUGxJTDROUVFSLzk2Yko3YUhrajVJc0EyeXUrelhL?=
 =?utf-8?B?Q1lQYTgxQ0JHbFBXdTV2THBscVJ2dk1wUEF5d1kzemxGc0p0LzNZRTlSZHBX?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: js3o4iUd0K0TKcRYikUWbFp3Aa/Enot+2G7i+2zY4Z4v9HPuPxsBLWOAXP7VjFMvGSQVhCA9UKKySEQsb62pZZ9apy36s/9QMLCzrpRs5svUZrMD2vay99SccQxJy9dJm5UqEjj341DtTl/KqoVl3XuR1HEqd4K+tvUc5CHC0aHeEc1AzpfXgVvsCFa8jonjB/PaDp2eZ6ei4eU+nvNtfs3Mqy2X2VwakoxLtS3Qe3/ihmQqTm+2ueGuehRrIb63dgNNu74nlrKY02JqSQHYdEqysotyAoaUt4U+V4YtbNByYPyvXEjzrporbgvfjAR78TP9bv0tLda7qcjhFNqXeAHTTrD3kDmUyhEkB2Cz1qY1LX7jVof0c1fn5V+FWL+OET3lgNSTOn5R65hPowjkd3/u9erG8c8e037OLmdNQwUPxbbb1f4fBb5PJzS1onIO1723wdl/c4KgPKjDMO8dE7DRj2QRmAdaN8KVCC20REfQcxfe/8zzRr/U9zB0IXgFrGhifihmDj58/ZVMwMT0C4biXxmJsXf2HcfHqO4hoPmJV7Gxm4dVP0Hnu5k9mRayunq2Sdqit6nrhOkPKxaXEUGREqhd1KIR6GFcDNttbCmVREKqJ4kv/pmLSoBiqRYghU26DcaQ1YAukQQVNyF64KdXtLv2HaKGUQpfFmxkgi3Z4thc4wr7yQXUkhvOOj7WQmGaK0zmd7DPtMBHz4N0HQlxVvX4QjnIeYXblr0AOpy/e1AjCkZyv4w5Td7wBZXlbREtAhg+vrOJ7NU8BupiQ11UD55wZY5BCsa1EiCcM2vzW2+0KVKPdvIL7RU5KgmdxfTsSALtIf30TUBIzrrwdg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 015c5719-3efe-494b-e5f5-08dbdca63635
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 19:51:03.6669 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anBAd4tO2RVdHpahHWgmQkSkWTNon0LcSbd3v4rjpoamxXw4OCgZTrq3UHv9/cVmTZYYm1JpGUPTb34yNx6Yp459irQpP3zOtpTcascY5hs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5315
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_18,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311030167
X-Proofpoint-GUID: _tB5gP6ZR2eSTqWaDjJaV7DnynuGO8kb
X-Proofpoint-ORIG-GUID: _tB5gP6ZR2eSTqWaDjJaV7DnynuGO8kb
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/3/2023 1:33 PM, Daniel P. Berrangé wrote:
> On Fri, Nov 03, 2023 at 09:01:29AM -0700, Steve Sistare wrote:
>> Buffered monitor output is lost when abort() is called.  The pattern
>> error_report() followed by abort() occurs about 60 times, so valuable
>> information is being lost when the abort is called in the context of a
>> monitor command.
> 
> I'm curious, was there a particular abort() scenario that you hit ?

Yes, while tweaking the suspended state, and forgetting to add transitions:

        error_report("invalid runstate transition: '%s' -> '%s'",
        abort();

But I have previously hit this for other errors.

> For some crude statistics:
> 
>   $ for i in abort return exit goto ; do echo -n "$i: " ; git grep --after 1 error_report | grep $i | wc -l ; done
>   abort: 47
>   return: 512
>   exit: 458
>   goto: 177
> 
> to me those numbers say that calling "abort()" after error_report
> should be considered a bug, and we can blanket replace all the
> abort() calls with exit(EXIT_FAILURE), and thus avoid the need to
> special case flushing the monitor.

And presumably add an atexit handler to flush the monitor ala monitor_abort.
AFAICT currently no destructor is called for the monitor at exit time.

> Also I think there's a decent case to be made for error_report()
> to call monitor_flush().

A good start, but that would not help for monitors with skip_flush=true, which 
need to format the buffered string in a json response, which is the case I 
tripped over.

>> To fix, install a SIGABRT handler to flush the monitor buffer to stderr.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  monitor/monitor.c | 38 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 38 insertions(+)
>>
>> diff --git a/monitor/monitor.c b/monitor/monitor.c
>> index dc352f9..65dace0 100644
>> --- a/monitor/monitor.c
>> +++ b/monitor/monitor.c
>> @@ -701,6 +701,43 @@ void monitor_cleanup(void)
>>      }
>>  }
>>  
>> +#ifdef CONFIG_LINUX
>> +
>> +static void monitor_abort(int signal, siginfo_t *info, void *c)
>> +{
>> +    Monitor *mon = monitor_cur();
>> +
>> +    if (!mon || qemu_mutex_trylock(&mon->mon_lock)) {
>> +        return;
>> +    }
>> +
>> +    if (mon->outbuf && mon->outbuf->len) {
>> +        fputs("SIGABRT received: ", stderr);
>> +        fputs(mon->outbuf->str, stderr);
>> +        if (mon->outbuf->str[mon->outbuf->len - 1] != '\n') {
>> +            fputc('\n', stderr);
>> +        }
>> +    }
>> +
>> +    qemu_mutex_unlock(&mon->mon_lock);
> 
> The SIGABRT handling does not only fire in response to abort()
> calls, but also in response to bad memory scenarios, so we have
> to be careful what we do in signal handlers.
> 
> In particular using mutexes in signal handlers is a big red
> flag generally. Mutex APIs are not declare async signal
> safe, so this code is technically a POSIX compliance
> violation.

Righto.  I would need to mask all signals in the sigaction to be on the safe(r) side.

> So I think we'd be safer just eliminating the explicit abort()
> calls and adding monitor_flush call to error_report.

I like adding a handler because it is future proof.  No need to play whack-a-mole when
developers re-introduce abort() calls in the future.  A minor benefit is I would not
need ack's from 50 maintainers to change 50 call sites from abort to exit.  

A slight risk of the exit solution is that something bad happened at the call site, so 
qemu state can no longer be trusted.  Calling abort immediately may be safer than calling 
exit which will call the existing atexit handlers and could have side effects.

A third option is to define qemu_abort() which flushes the monitor, and replaces all abort
calls.  That avoids async-signal-mutex hand wringing, but is still subject to whack-a-mole.

So: atexit, signal handler, or qemu_abort?  I will go with your preference.

- Steve

>> +}
>> +
>> +static void monitor_add_abort_handler(void)
>> +{
>> +    struct sigaction act;
>> +
>> +    memset(&act, 0, sizeof(act));
>> +    act.sa_sigaction = monitor_abort;
>> +    act.sa_flags = SA_SIGINFO;
>> +    sigaction(SIGABRT,  &act, NULL);
>> +}
>> +
>> +#else
>> +
>> +static void monitor_add_abort_handler(void) {}
>> +
>> +#endif
>> +
>>  static void monitor_qapi_event_init(void)
>>  {
>>      monitor_qapi_event_state = g_hash_table_new(qapi_event_throttle_hash,
>> @@ -712,6 +749,7 @@ void monitor_init_globals(void)
>>      monitor_qapi_event_init();
>>      qemu_mutex_init(&monitor_lock);
>>      coroutine_mon = g_hash_table_new(NULL, NULL);
>> +    monitor_add_abort_handler();
>>  
>>      /*
>>       * The dispatcher BH must run in the main loop thread, since we
>> -- 
>> 1.8.3.1
>>
>>
> 
> With regards,
> Daniel

