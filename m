Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B42175D6CC
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 23:58:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMy7N-0004zv-3B; Fri, 21 Jul 2023 17:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1qMy7J-0004zR-34
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 17:56:53 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1qMy7F-0000da-Se
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 17:56:52 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36LLQg4T021626; Fri, 21 Jul 2023 21:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=c3l7eOKtw2IBM3OCPxnXNXYEb/uOMDvitUsPM5729NM=;
 b=xj0oEvIrT7b3bxQtW2pZPDsVoJfucTYumgQebcu9eDapo8RlzWl2HgvJ/DhLQ3dK9Hcr
 Y3S28UPNAbML8nJkz86xlycJP8y9gjD63/qoxPZDyIoCZTgvTHbsqiqVhaDwWhG5ik1k
 Uz2Su7rElwYn+VtV7lM006bzhPh58KNtyOQ3lU/od7iGiGDkzgiduz9O00sQX2rNa3ob
 W2e1725NWt+wO6QOpkZSpfYfmWOHWZ1Ce1+nZ5kLaLoHQqcpArTATTe5Le9x7EWne+Rt
 rKLPLxQQO8icR6DGwnBTqPHETEekVd7D6sET5PbOnKVgNbpFiYC2bTrjADJ6ENAGpsaX dQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run8acw2c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jul 2023 21:56:46 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 36LKowlL019235; Fri, 21 Jul 2023 21:56:46 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3ruhwb0814-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jul 2023 21:56:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LH2Y/IgzqFOfqoIdj0/fbXE5FswKTsh3BhdWEtRYHV4h251E6VizeFpCwGxbwOjCgyIT3GSNQ7U0spX/LvzZQXlHHxeh8QDo/J7+4hsD07AEYRe8Ygr3xmAlAd5bD2WcOAwvxC8fliv+f4elOxkRy6WrRRyTdbPHn51N6T2sv75eLB3YK8pDLjOxzFqY0DjOOb4VmbC/xcweuKeWSYNBFmnO/Djd+PhuWlNSKkDc1sMsGJB/Q2ZuuHkXQjgPz/VQyzcKZD9Z2ZNpxgXRXUxfOrYhrQH3pg7FqlsG4RyULLS8anE+3VCItB3fqshHsSZd/2eVWS344uC1hhX/ee889w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3l7eOKtw2IBM3OCPxnXNXYEb/uOMDvitUsPM5729NM=;
 b=VoQSEXiZDDU6VbXFv84g/u9QUGdynyGPlF1G3znJEp/I29dMUyQSqlW1OwzDATV+PxzRuI/NpBQPazEGABA+ytEWLsIbbmo+NUn/iJ8sY1sbCPRRK6vBh6K9+p668QmhedE8cAYfZiMAyvV31LJduiBoUuHlhG0T8nfxL2ZSPTYaPPc73QM4lPA1ssxdZnmP6bhcqbLVX29h0mnJpaYJczFWXI4u5yD+oloSriFBsU3YwxmyBg2ovC3koHJBAgp9Z2fLpakiOeE7I3X2zcgnZ3h5JZZBBpRDYmm3CsEG1hZOY/Oc3SkkKCAZZZLfXgVTVi6cOw5qIJh59kiHiFS1xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3l7eOKtw2IBM3OCPxnXNXYEb/uOMDvitUsPM5729NM=;
 b=fzdB845dXVT06pCBwwMB037Yj1OjZJT5E2V/9ufQ8eE51DxGG7KlxbCzhFcLc1q8Rs4RdHxaWDj/rqcnT7fsG37QGb474IITb/Hx4M80Xbf8jL+Kjlf1tLxt9R1ln/OhHAo51BVC1ghhDWsky+fwJgtTft0cL2FHzO2vi4SuuR8=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by DM3PR10MB7912.namprd10.prod.outlook.com (2603:10b6:0:43::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 21:56:43 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::a11b:61fb:cdea:424a]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::a11b:61fb:cdea:424a%5]) with mapi id 15.20.6609.025; Fri, 21 Jul 2023
 21:56:43 +0000
Message-ID: <34ff94cc-82fb-831c-b07a-f7068a8a8297@oracle.com>
Date: Fri, 21 Jul 2023 14:56:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 07/12] vdpa: add vhost_vdpa_reset_queue
Content-Language: en-US
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
Cc: yvugenfi@redhat.com, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Shannon Nelson <snelson@pensando.io>
References: <20230720181459.607008-1-eperezma@redhat.com>
 <20230720181459.607008-8-eperezma@redhat.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230720181459.607008-8-eperezma@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0161.namprd13.prod.outlook.com
 (2603:10b6:806:28::16) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|DM3PR10MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: 5194653b-001b-4ac2-f3b9-08db8a355efe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QYtU9uDgUk1iD8brZMhSA6ws2jM1vAfF1xST3zPmCMFsMvSunm/GBqV24HGsmUCmi8WUv8hrbOKRa8+OTdNoSAZWj9i6aELuWShW1xX+ryQDCzD9XmLubg1guG/7c9g7OISInlaV+LmmXWdzLf12vU6v1m0+S3J/+iEe4+nteQfbk1D6D0MiWmMJeTDXzasv11/hYsfRiVocXceTA0eSWrizmWFmr13LdSOFglpb0A6ZnJkdnNvj4k0T6cM+MrG9xstaEMUvaIPU+EXXKlnvNwnLKB6VLsySk8JkoUPINVBimFKe/h3qHEdM1PE8AspcIvL42CrJXYEJ4Bq1QoqPuyKhwwzUDYV71dmo+JAWplD9v9ziYwyRV8nsC3enJPSggmZ3qyNAuVf9+qF0EZJ0k3IH4mOhrDVZMc1NETO0tS+WPvwRjKwwulnS651oo7VtrteRtplaivY4QdW7drtU2ON22EfkfLIc6x0RgigLP38CtSTeOx3fGy5sW8PusbsqWPfCg/sAL3wNUf6x1IiK7G4kbpRAnzo5llgbiMKXrznowN40eqDComQI/5jNpvbVkgDtLVA74Sz2Jcgu/uJd9oN0GbXjWz3HE9EmaHFh1Sg68xrx/Q4IDEBnyGeINEg89BVcFrKbURQU36nRmiH94Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199021)(186003)(36756003)(6506007)(478600001)(26005)(36916002)(31686004)(66476007)(66946007)(4326008)(316002)(41300700001)(53546011)(66556008)(86362001)(8936002)(8676002)(6666004)(54906003)(6512007)(6486002)(31696002)(5660300002)(2616005)(83380400001)(2906002)(66574015)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzBSMWZVVXpqUStMa3BVcXZmWnMyL0Qyekw5bnQrQmlVM1lqay9xVlRQUVJ2?=
 =?utf-8?B?L2dPY21KcGhCdFZTVmhtM0lJYWpGUm5WRWtVYU1NRGI1RlVoOHRITzNxeCtP?=
 =?utf-8?B?N0N6OUJXaDVScjFzT1VnWXkwYmd0RnpIcHZFK2JmSHhydkFhRi9GS05nK2FC?=
 =?utf-8?B?MERjcGdOR05kaDRMb29sbVRsUzNRdUREL0pPUFRiK09DWk5RWFU1N3Q0UHFJ?=
 =?utf-8?B?b3NzNUpPRklPU3NnZVdmOWp6dzJHYm1QaEVZcmUyTEdycHpqc1hXKzhlODFJ?=
 =?utf-8?B?UlpNSG5OT01OL29aMmRoUGIvUkttL0JFY2xaMkFhRjVpYzVZU3VFOEFQdkVC?=
 =?utf-8?B?NVd0a3V5RXdLbG0rODExWlZIYnNYRkpmNzNPZkxqcmdyNnJWYnE3UDVhSUh1?=
 =?utf-8?B?NlIzSTJwUXBYd1FDUU0ydzI4QXc2WFFSZEJ2VytkMnZ4TEhlRlUxTDFWYTI4?=
 =?utf-8?B?bCtQOTdPcGJaeklPcGFsTG5yei9HUjRsUnNOMitxUWxGbG1lSU1rOWNCMmhu?=
 =?utf-8?B?dk44VUhRUURCVWdvUlgyejF0bnVFZGEwNi9sRVB6c1hPMStBSEU3QzhvWnFv?=
 =?utf-8?B?dExYR3VhQ1daNEduckdFQVBuWGpTTkJNVmlGVDVJUVA4RlJLVSt0ckhpNk1h?=
 =?utf-8?B?bkRiSzlyU0FwcXJ3SFI0SldjRjQ1V0YvWFJVcjNIeVVLdUkzd3kxTkk3dFBX?=
 =?utf-8?B?Mk9qNGZiVVVGcWxSa2ZRY0VodVFXRm1aSXlrUTVlSXczMUdjVVhrdkxDRFJX?=
 =?utf-8?B?aWZ5M3RMUXY5M0h5SS9jTFFsb1paMHQ3ck40ZnBDeEFKbC81YVgvSGZFZFVX?=
 =?utf-8?B?dG1vMGdBUUxqR1p0Y1lLQkNaSFFIR0tZRXpwcmFGM3dZUWk2OHZneXVTaFBu?=
 =?utf-8?B?RFpSMGdTelFOTHFDb3BiS2lNQnpGWjl2NG9kbkpzL0F2UWROUzVmQW15Qm4y?=
 =?utf-8?B?ZTgwbnBEbHRFQVh4ZDJodXdodVp0c1ZzSDNJNExxaFR6TVBpMElTSmVFQjFW?=
 =?utf-8?B?VW1TZi8zTlhJdHVtc0NIVG54OHJPYUE2WkJFVG5RQ1VkTnB5ajQwTlpGNlM1?=
 =?utf-8?B?eE91ZmxPRVZIMG00N3Rlb1p6MHlLQUFrTzR3WXYvWXAvSFVYTFRqRUx1SGNk?=
 =?utf-8?B?bXZ2TzNIdFFCNyt1MS9EaFVaQTBoSDZZY3JTUmZRMnhlZTkrNXJWd0JLeHF1?=
 =?utf-8?B?bmJ3N2JQTFUwb1JSWElvd0FLR09UVGxhSzR5TGE5bmc2L1VuVUtKN1pYSmo1?=
 =?utf-8?B?MHA5eVk4NU9SQUY4UFF3NGIySGQ1eTEvTWVCT1NMMU0rc2ZDS1B1b09hQTUz?=
 =?utf-8?B?aTR1Zk9IWUZ2cE5Pd0xDUlpRYm1oQU1uWUF6WFhWZUZ5N3BWQUNuNzFVaWRN?=
 =?utf-8?B?UlpUaGNJSmlvUm1EWUU2a3JTbnpOTkhrZlcyYm8xQlN4L1Y3KythaUNQczhF?=
 =?utf-8?B?akhQSGF4UFBrRFdSRithVUt1ZjlXcncvVWxycndkYys4cGJnTGtZbnIrdUln?=
 =?utf-8?B?b0xBRTJXcGZxR2VGUmp1ZHBsQ3N4Wlo2clBqQXJDUmxsVmNxMTBBVkV3R0or?=
 =?utf-8?B?Y3NmOEF0MnQ4VUUrOWhnZCtXVlBOeWFjb3VCYmdwbjZKb2RVU1kvTm1FdFQ1?=
 =?utf-8?B?NTVoSmpzYVBocXQvdEw2eWs3Z0dWVGZSL2pCZmcxVTArZHlNaWRKTFhiMUN6?=
 =?utf-8?B?M0QvQWVzVjlwUGtoWGJPR21xYjUyUFkvdTJoL1BueXZ0VkcxSUVod0tnQTkr?=
 =?utf-8?B?WjJSRnd6Rm5PZm1YaVl3djhlaFd3RGR1RFJQbU45MkRSVk5PMWN4REVTanB1?=
 =?utf-8?B?VkIvMDlyWGozOG1mT0hJT0dONzZxZk5lMEtMbnNQNUYvL0hHcWRiaThLUEVY?=
 =?utf-8?B?N05BVzJ5ZEV5UWNRVU1sZG4zSDdWZkhXOGdoYW15OXJGRGFLa0pWNHhpWVNV?=
 =?utf-8?B?R1l3NHZlb0xIWVc0TVl4aVJoakxrRm1NRGVPT0kzMzBvNFhsUXhDL0VrZ0Fj?=
 =?utf-8?B?aUV5SUxJME5RMWJYVXdHejRQa2RBQ0dTRi9oakhzZUlyczc1bTZtMXV4Nncv?=
 =?utf-8?B?ZTBnREVKa3pOcFpFUEkyTjFubVJpVHlvWjN0WUR4SS9JNlVieS8yRUFod1p2?=
 =?utf-8?Q?T4JJfgSQ3VRNji91pHKkF24Cp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZGddD6deoXmZJ7LzhUwPqSgWIyuqq0RJ3mwsAWkMFJivkgAllBuy6+3m73D1yi8jtQMSFb7N8JJYdawaB+tsj8T41msuYkx4UTyNdr+mZGbs60lZha+tYsYbfiYxHRdJOK7lU4x2Zjq+B/2q1PIajXK3vwzTlXRFt4oxnjyQehqygQ5VJMJKd5shqaOKkulXLRrEh/54AqRXvyMHVxnTMb/1CeiiGxc88lHJUFKt3JSm5+qdfD9lS1q2rPrY2Lkv5wkN3UuTlw+deGqu4me5o//RwkJQmVh5/821TulSg78e0fkJZGQMNJKQzTwHwMv8KPfREfuotiZkwaF9VbVKGKlxf2FlhMkXfXNKt2Sk3IglPPoZmP0xPRgpZFstiFbSYgXkbL78/JBQoC1ySKFdn7PNcRiypfbgQhK5doa48Q50xQS6nbIf/9Z1yaqf9HNeI3LzswsNmvm4byKxachoDol2J72lzlXqSpDrzcPBoe2W2vuPSX8b3eY14RtTL0Tk69CqRC7H2Wl+r2s7yocfLqkZk5D8/X91feOqaqZ8UsS4wN5RPxO1PiCxU6rYPFTr5PH7xg0o5mSnvxCla2VifYE4Qgyt+EZ42VJDX5ygskiAiDUcXCH3/at6yW6nz+IFcsWcvvnov9gdoIR1fVVU1MfPFoEg3ntlc9vW2BIgm9bGnC6BDB+q6ngnYzy7MmdH5P/CvhMGxGf/x6SU4A2Az66eXDGvks6QZz/0NQuX1zoWbEfOFgPSg+/pV4YbhzNKCeEUwBnjtJO39WYrUMfau6dhqWrJeftLTaHDAXWrvIKq5XTJQJcSqcGT/L4ebc1UX2rzJrJv+FnBLQ/7PJRpbg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5194653b-001b-4ac2-f3b9-08db8a355efe
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 21:56:43.7505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+gJaZ8o0Fu03Ip5B0JkHk4nSwMEW6BmC8NBl5nuwMyKrVqdd1SKaCpKBPBVgtGaUj/gZ0ZOWHpBxfwDxwSiDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7912
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_12,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307210194
X-Proofpoint-GUID: 7zefykK-FnRB11o-XfEwMC5RDjwnAYHr
X-Proofpoint-ORIG-GUID: 7zefykK-FnRB11o-XfEwMC5RDjwnAYHr
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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



On 7/20/2023 11:14 AM, Eugenio Pérez wrote:
> Split out vq reset operation in its own function, as it may be called
> with ring reset.
>
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
>   hw/virtio/vhost-vdpa.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 6ae276ccde..df2515a247 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -547,6 +547,21 @@ int vhost_vdpa_set_vring_ready(struct vhost_vdpa *v, unsigned idx)
>       return vhost_vdpa_set_vring_ready_internal(v, idx, true);
>   }
>   
> +/* TODO: Properly reorder static functions */
> +static void vhost_vdpa_svq_stop(struct vhost_dev *dev, unsigned idx);
> +static void vhost_vdpa_reset_queue(struct vhost_dev *dev, int idx)
> +{
> +    struct vhost_vdpa *v = dev->opaque;
> +
> +    if (dev->features & VIRTIO_F_RING_RESET) {
> +        vhost_vdpa_set_vring_ready_internal(v, idx, false);
I'm not sure I understand this patch - this is NOT the spec defined way 
to initiate RING_RESET? Quoting the spec diff from the original 
RING_RESET tex doc:

+The device MUST reset the queue when 1 is written to \field{queue_reset}, and
+present a 1 in \field{queue_reset} after the queue has been reset, until the
+driver re-enables the queue via \field{queue_enable} or the device is reset.
+The device MUST present consistent default values after queue reset.
+(see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).

Or you intend to rewrite it to be spec conforming later on?

-Siwei
> +    }
> +
> +    if (v->shadow_vqs_enabled) {
> +        vhost_vdpa_svq_stop(dev, idx - dev->vq_index);
> +    }
> +}
> +
>   /*
>    * The use of this function is for requests that only need to be
>    * applied once. Typically such request occurs at the beginning
> @@ -1543,4 +1558,5 @@ const VhostOps vdpa_ops = {
>           .vhost_force_iommu = vhost_vdpa_force_iommu,
>           .vhost_set_config_call = vhost_vdpa_set_config_call,
>           .vhost_reset_status = vhost_vdpa_reset_status,
> +        .vhost_reset_queue = vhost_vdpa_reset_queue,
>   };


