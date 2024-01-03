Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CDD822FD1
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 15:48:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL2Wv-0001RM-9e; Wed, 03 Jan 2024 09:47:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rL2Ws-0001RA-Qc
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 09:47:34 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rL2Wq-00038E-1e
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 09:47:34 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 403E6EJf030889; Wed, 3 Jan 2024 14:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=lmS+5Lj3Ifm2m/oEsUW/TiPzi7KQMx6dREmeoXS0NHs=;
 b=bQauWxtWBhEdLxmhdWp4do5TxTJMdYEWvwDPi/lGGO+jQoJky0AGafEe31oqJhl9MYFG
 EgULkftKfjAJZWPmgvHlrpN6jJlgYJcDgoTQcvqY4ZCg4XUZYincZ7jDQCkwktVN4Uvg
 yFImsjlMRWA2QX+8+D70febeeHUUpFrCfhmul0RDo2ZgIC36YRLJ0oKF5f4fTPixhtBq
 0zIoOdJUXRAqABh9Twccgt7P63yTJVUvEB9ZKNb1hBPYaVXyCtSwMI/prqulUuWcj1C5
 tL676TIOz4fx7ggqeFsim5hk64I+7z2nvT9MG7nfWHSPLN0QhVPO0z9iAg9Aqgt+RYZM QQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vabrv53xh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 03 Jan 2024 14:47:28 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 403Ehv0n020683; Wed, 3 Jan 2024 14:47:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vd9ksg3ub-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 03 Jan 2024 14:47:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/AIfk2zMg96DutSSQiAK9d/q9jNR+v5Iu+pagY9hKPq8sEHU2Fnr0zm9dXq5H+Cfht2EqWKoTQ3tXz7HHAp4oFHC7PZ/BrRCFZ5RMdtBb9cnhm8/RAt8rXEjjm1U94ByiiReJLoIPvqanyIKHSoeWTR6nDsqXzrZv0QsSpLegU9Cg+z7/9pVVv5o+0N1Dd2kWenCMXDpbHYTt/8ntkeXWYg4Zvp45ioECs6rHKw9vtwrtcn/00iMleAme/t5nT/vnFdrHvxyGHK6izL+65N+HYY2eQ5Z2Ge0N52DtAibeOEkpnh4jLU8BtgHdkYe8bahkLTzP2p7nOwI1ij+BHl4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmS+5Lj3Ifm2m/oEsUW/TiPzi7KQMx6dREmeoXS0NHs=;
 b=V3Fb/bM4MCtCW0XhWfKDAaJPRmeEQTBKRfsHE1O1shYMTmhP5NBj8W5oWAuLKU8ffjfgQCWVEXL8UqJ2hK7CyRDzG7WUMFLwx/eN6DoPWDShVSRxOz2tdJkt4P5/Bttfeqza3wyks5XaOs6jNMhNn0tqdriaT7O8Q0y6aGw5zv1B5W/jzkz4SQT0VwgN4mq0TJk5UHaPW8I3PxkOLDCRkvEsQfwQBAh8y5AGYwg93MpsClQAcL8s66TX7C4LZtKXarl2bniCe0mKboeFS7+hdzZ4hX5VDKqQ6cn0g9V4aJB86gfpP29hM1cknIKzqyR7XZg45Fi91oL2j+HmZtoKeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmS+5Lj3Ifm2m/oEsUW/TiPzi7KQMx6dREmeoXS0NHs=;
 b=wXxnHWBo9mJ3GYAN2fXRs2HZELz+kkTRvNvqE6tMd334LD4KLcCsy4SOsTmnVR3PxcT4Tx+gY6WxkLOaJFaKF/otJJhpdPYZzPaoYhibtRSnrj1o6M7F5P+tOtErUPn4pMRXBC22uc3WqpfY3WalrF0ggLsjfdZknoumt8Q6VUQ=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by CYYPR10MB7606.namprd10.prod.outlook.com (2603:10b6:930:c4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 14:47:24 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%5]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 14:47:24 +0000
Message-ID: <bcc1622d-fdc9-4faa-8f7e-6e76c8a6ec0e@oracle.com>
Date: Wed, 3 Jan 2024 09:47:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 03/14] cpus: stop vm in suspended runstate
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>
References: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
 <1701380247-340457-4-git-send-email-steven.sistare@oracle.com>
 <87bkaiig2s.fsf@pond.sub.org>
 <9d613137-24aa-4323-aee1-0d38b91339c5@oracle.com>
 <87sf3ta31i.fsf@pond.sub.org>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87sf3ta31i.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0011.prod.exchangelabs.com (2603:10b6:a02:80::24)
 To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|CYYPR10MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: 3127b223-703a-40e2-4368-08dc0c6ae60d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BfN8GvHHMmbllpStXQnfQNBdroGlEXUUQVCJefvhlXWBJE+Kj6EojXuXa++Jm0l8eLNDns8AU+jqQtVqzcHVGhXTrARfgafGvxzkjQgNPrNLMkNHc1h9TqaWJSx031CEnKSllOmQ300fBR8HMntvDxUSqgWXdJf0vQ6IfhvtZRof0ta6hmiCMsyZ2kkfk3XPwvCdimiUsl2NbdjuPMtl2EqTo9IKLgUHRvW4QoIFFkLQWJ07hA/T/R9K4b+DVE0OSZOh5I5+P4J+OhEpz531HPUwNA0ESFhTiUfUFp1GGxP6ddg+/PF0QJ+Yd+/zG4KsLcRXgfzwD78iwAap9JNMsSwtXY6MsAMgr5hYsz7zrNInVR/5iiyLvE3nisEsPolGMfauJDQaYPiCTDDHOdA6No9kotOma4wDGSiNSrxhpaCSw/UEBEKvBmTDobMIGXeiICzsCL5h2WJOUzhiXnz/r5Z8a5E514uO1fsUSSKdn5o1tAg65t5wMM9xi8eYLUnPbSAkJVjTvnMDegfAj+4E+qDWSDREhZKPfocIAljQ8vNtU4K1g53eXlOFGE1DOSKcfykDmQ0DHtiRGYUaccT8cmkB3I+f1OhLAYv82kMFPPPHvcBaHZi6j+QJgMRrcJdRr4hrKncKX4DoWeJVHB13LwScAzXroL9BhYk1/Urn/aTcJRhtVVaD2NoX9JGaimML
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(39860400002)(136003)(366004)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(8936002)(316002)(8676002)(6486002)(4326008)(478600001)(66556008)(66946007)(66476007)(6916009)(54906003)(83380400001)(6512007)(6506007)(6666004)(36916002)(53546011)(2616005)(26005)(44832011)(7416002)(15650500001)(2906002)(41300700001)(5660300002)(36756003)(38100700002)(31696002)(86362001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0lHWnRUODEzVVRlR2ZOWGoxRnA1cGN6YlRnd0thVGhVVkNpenpuTUFiSmJD?=
 =?utf-8?B?b0s5cDBDS0FCS1U1OE1Pci9WOE91V2VMSnltZWRtenRBQ3ZjZzc2UEgrS05n?=
 =?utf-8?B?Ty93LzY2VXVOQ3pKKzlZNXpNdFYrWVN2Y3FEREtreFdkRWI3Y2x1bndKM3RG?=
 =?utf-8?B?eUpPL0s0Yi8yQzl6M3RTMi9Ca1ZmVGdKSFEzUm5VaCt1QkVRRWNVM0FySVMy?=
 =?utf-8?B?VjRYaUhmS1o3bWF1VnErWE5obk1UZ3NoOWZFY3FNeXZucDM2VENId3Rzek9w?=
 =?utf-8?B?VnBaRE9kRW85QXRhVForemM0ZXI2ekFmTVhuTjc4amdEUURzS1NoaGYwdDRD?=
 =?utf-8?B?NG14N0xYVS9mRTdSNG5YZVNORmZiSmtUdUJWRzQyTFhYWFg1bUVTWkphb3A4?=
 =?utf-8?B?TlFyTDRXbFRNTStHK1laZk5seUlVeWdsVVRRNkNVeUo4QVBEWklIYUdvM0s1?=
 =?utf-8?B?a3BaU0V3ajF6V2hnZ0lHQVZWeWZCbEVHTDgxMnk5VVZyK0tvSVUvS0g0VnlI?=
 =?utf-8?B?OTIyWmJZZCs3RnZyMmRONGszbDA5UkFsYXRQSGdZdjhkdTR6NTFpSC9yMm55?=
 =?utf-8?B?QmJ0QjZjN1NSYlpOT1VXVnRJVUR5eUJuSi96c3o1S3VIenI3SzZhOUlhT1Az?=
 =?utf-8?B?WDRNTnBaYWE2MzZSRDlwMHo5NUZ2SlJDR0ZsYW03YlNDV3pLVlIzWkdZZ3pk?=
 =?utf-8?B?QVl1bWtTQ0pSaW53dVJ4Wkg0U2VlZWNxL0VLRWlpYmpPM2FFTWdOOHRIeVdC?=
 =?utf-8?B?NVArWlVzL0VmdnM3NG02NGF3b0wwbWxaQk1HRDg0MVc5c1A0d1gxaGkwVGJ6?=
 =?utf-8?B?NG5Ha01jUFpPTEk4OFdBckpqRFNrSUhLWG45ZThsTTdGV050TlpOcVh3STZs?=
 =?utf-8?B?SEZkMk5UM2t1QlRrcEMyS1RqZXVoSWRBS3NuNU9pMkJIUUNJdWg1THZLV2gy?=
 =?utf-8?B?dTJSUTlQc2pIMW5pYWtIKzVGekVVWE5QeDBvZzR3bW5WZkYydU9pd0JEU2JU?=
 =?utf-8?B?b1FmNk9WTHI4WjdHWWFTenBVemIyemQyQ2Jubm5SaVpSVnQrYjl0ZmNlTitM?=
 =?utf-8?B?SElnS1FhZEtpVU1xMFV2QmpYTk1mSDA0Ry9RN0hiZ3FZeWJWbFlJZGxURVBX?=
 =?utf-8?B?YU9iaHdEZVJveUNJaE9TQStNK0lvS3hFZGpDcnZ5eG8xSDc3R2hMWTB5VVJN?=
 =?utf-8?B?RlpBMDZPamsxUWt3VjY1QkRpN2pkaGllVUxUdFBydzNOVjZzYzFuZDdTQ3Vh?=
 =?utf-8?B?aVhvNnAvR1ZiMXcxQmNLQTlnVzdoSEdCUkNrWE40WXJjT2VvWXFHMUFEMDRp?=
 =?utf-8?B?TVYxSXlGaFE2cG9sSjdoSnE2RFNIZEZXeDg5ZGZpMExsOWk4Vm8zZ1U3Z3RI?=
 =?utf-8?B?Wk5PZkpneStpbkZrWUZRMVZLZFI1dDY0Y2dwK0VnOWg3T0lpYVo1NHJ6UGIr?=
 =?utf-8?B?c1FnQWlvQlBBcDhYNW4rUS9TdTVNcFdTMnhGbEY1VGVjVTJETVdjR1NLSDdQ?=
 =?utf-8?B?SWMrMjFydWRJanVBRklkSVRJelZEWXFLQk0zWDR6bTBTNWZRbjMrTk5uQUhy?=
 =?utf-8?B?YVVuNXcxNVhmR0FyR0thM1Z5bUhGRjJ1NkFmUHZrMCtVSkQwZ0dNUmFKY1Z4?=
 =?utf-8?B?Wk5ydm5rbGFneHUyQVQ4MXRYQ3ErREZmcHpVSTdWZTM0VUsrQ2RUQmpLSVJu?=
 =?utf-8?B?RXpjdktpUzlSRXBuY25aY0Exb0NJcVVzc215SERabmRDRk54a09Pa1JoMHln?=
 =?utf-8?B?d253MTZnR21ydGw3bXRHeGpRTmZFWXNMMHFSb0wzTG96OTNYZk9adllOazFh?=
 =?utf-8?B?djdSaDEvclArVGgwdCtUTmJjWlJZaHZwRDBNeHJyQjlEMjhCT2lWS2w3ZjBF?=
 =?utf-8?B?emp2czUwd3ZsQ1l5VGN3cEw2UG1IQlB0VVNwb0VXZmR2bXZ2NWhFcVVFZmha?=
 =?utf-8?B?a3pOeCs1aWU0WFVuQU4xd2pwVklRZEFIRE9GKzJvUnY0aURlR2hGNGNxd25R?=
 =?utf-8?B?WEk0R0FBN3hCN3ZhY3YxVXE0SjVvRW0wMzVxaVJIMVRNeVFtNldUaWpBU3RX?=
 =?utf-8?B?Q3MxT1NTaDc3ZHNETEprb1lxc2hMV29TWDVacDV6N1FpRTN2cFkyVHc5RU9Q?=
 =?utf-8?B?M3hyOW9GNk1YSmpaYUFBTS9wYjRsNnZ6T015NHoyL3dVVFNuSXZNTGtoc0Z6?=
 =?utf-8?B?dmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GmKN9ape/4ABp3pwsJ+K40Ip69wJn2Roy72lOGSO3hMYATT5cQrScM0qqTr5cUpFiVeh/8/FEf/tnpaEQqsGQnhXo0CPIE2qAf/APtNe2yqslXQGi0L9RKsRW7Qlr6LeKKfcUKkXWKssRp2Te8fQJMVfMfV6d+6xSLXXFlXHnAPsJskI1XxlVhJoaiLbXZiCYJE3uu12hJ9L9tJnNhrA8bBJcB4AOcG3zCoxAGLNnOK37CxHxD6DSPLaSF9NB1Z80r7o70+I4TGOsAPbLwDH1h/0XMzC6wruOMPkc6X1Hmj7qBgqdXhiIKDnnLshJ80D7btkuKfWZrpOX1yfIs4KL69XPsCY2yk84o2XGhZJXjXoZoF6C97EZw4w5TCDphcy/IAf2YXPMHQ05SttdzZZtPLgqJaXODFaqDJ6eKLIWKt0jSgw9Hfaet2VaO3gGwNt9p9pg4IiXwqBiSVOARWSc87mBRonSYrLBBr7XuZ1mUarfkfDY7QOw0bWHzpL6Wwh2EVPhVCyvP66WQJDcRUsLrOdmZa/Epv3P+40BPzTpi18AH4iYKw/vEcclQQ3GszihZFEL3i/ERlXWTJottZ6GYgnwjRwNx4K1gLXYNWkqSw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3127b223-703a-40e2-4368-08dc0c6ae60d
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 14:47:24.6672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVAu7hYGfZPMRo7J8EtZN46JbA9Jfz5Ha45aC3Ip6WHmSM5sJKwlFD8DiImHqDMcDEOeGRQYPPtgOwbveWK4ZBaQbZIM7pYwtF/XIgJWe8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7606
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_07,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401030121
X-Proofpoint-ORIG-GUID: Y5xILw--cyfyq5kqf0TEK-xjqDdispXU
X-Proofpoint-GUID: Y5xILw--cyfyq5kqf0TEK-xjqDdispXU
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 12/23/2023 12:41 AM, Markus Armbruster wrote:
> Steven Sistare <steven.sistare@oracle.com> writes:
> 
>> On 12/22/2023 7:20 AM, Markus Armbruster wrote:
>>> Steve Sistare <steven.sistare@oracle.com> writes:
>>>
>>>> Currently, a vm in the suspended state is not completely stopped.  The VCPUs
>>>> have been paused, but the cpu clock still runs, and runstate notifiers for
>>>> the transition to stopped have not been called.  This causes problems for
>>>> live migration.  Stale cpu timers_state is saved to the migration stream,
>>>> causing time errors in the guest when it wakes from suspend, and state that
>>>> would have been modified by runstate notifiers is wrong.
>>>>
>>>> Modify vm_stop to completely stop the vm if the current state is suspended,
>>>> transition to RUN_STATE_PAUSED, and remember that the machine was suspended.
>>>> Modify vm_start to restore the suspended state.
>>>
>>> Can you explain this to me in terms of the @current_run_state state
>>> machine?  Like
>>>
>>>     Before the patch, trigger X in state Y goes to state Z.
>>>     Afterwards, it goes to ...
>>
>> Old behavior:
>>   RUN_STATE_SUSPENDED --> stop --> RUN_STATE_SUSPENDED
>>
>> New behavior:
>>   RUN_STATE_SUSPENDED --> stop --> RUN_STATE_PAUSED
>>   RUN_STATE_PAUSED    --> cont --> RUN_STATE_SUSPENDED
> 
> This clarifies things quite a bit for me.  Maybe work it into the commit
> message?

Will do.

>>>> This affects all callers of vm_stop and vm_start, notably, the qapi stop and
>>>> cont commands.  For example:
>>>>
>>>>     (qemu) info status
>>>>     VM status: paused (suspended)
>>>>
>>>>     (qemu) stop
>>>>     (qemu) info status
>>>>     VM status: paused
>>>>
>>>>     (qemu) cont
>>>>     (qemu) info status
>>>>     VM status: paused (suspended)
>>>>
>>>>     (qemu) system_wakeup
>>>>     (qemu) info status
>>>>     VM status: running
>>>>
>>>> Suggested-by: Peter Xu <peterx@redhat.com>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>>  include/sysemu/runstate.h |  5 +++++
>>>>  qapi/misc.json            | 10 ++++++++--
>>>>  system/cpus.c             | 19 ++++++++++++++-----
>>>>  system/runstate.c         |  3 +++
>>>>  4 files changed, 30 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
>>>> index f6a337b..1d6828f 100644
>>>> --- a/include/sysemu/runstate.h
>>>> +++ b/include/sysemu/runstate.h
>>>> @@ -40,6 +40,11 @@ static inline bool shutdown_caused_by_guest(ShutdownCause cause)
>>>>      return cause >= SHUTDOWN_CAUSE_GUEST_SHUTDOWN;
>>>>  }
>>>>  
>>>> +static inline bool runstate_is_started(RunState state)
>>>> +{
>>>> +    return state == RUN_STATE_RUNNING || state == RUN_STATE_SUSPENDED;
>>>> +}
>>>> +
>>>>  void vm_start(void);
>>>>  
>>>>  /**
>>>> diff --git a/qapi/misc.json b/qapi/misc.json
>>>> index cda2eff..efb8d44 100644
>>>> --- a/qapi/misc.json
>>>> +++ b/qapi/misc.json
>>>> @@ -134,7 +134,7 @@
>>>>  ##
>>>>  # @stop:
>>>>  #
>>>> -# Stop all guest VCPU execution.
>>>> +# Stop all guest VCPU and VM execution.
>>>
>>> Doesn't "stop all VM execution" imply "stop all guest vCPU execution"?
>>
>> Agreed, so we simply have:
>>
>> # @stop:
>> # Stop guest VM execution.
>>
>> # @cont:
>> # Resume guest VM execution.
> 
> Yes, please.

Will do.

>>>>  #
>>>>  # Since: 0.14
>>>>  #
>>>> @@ -143,6 +143,9 @@
>>>    # Notes: This function will succeed even if the guest is already in
>>>    #     the stopped state.  In "inmigrate" state, it will ensure that
>>>>  #     the guest remains paused once migration finishes, as if the -S
>>>>  #     option was passed on the command line.
>>>>  #
>>>> +#     In the "suspended" state, it will completely stop the VM and
>>>> +#     cause a transition to the "paused" state. (Since 9.0)
>>>> +#
>>>
>>> What user-observable (with query-status) state transitions are possible
>>> here?
>>
>> {"status": "suspended", "singlestep": false, "running": false}
>> --> stop -->
>> {"status": "paused", "singlestep": false, "running": false}
>>
>>>>  # Example:
>>>>  #
>>>>  # -> { "execute": "stop" }
>>>> @@ -153,7 +156,7 @@
>>>>  ##
>>>>  # @cont:
>>>>  #
>>>> -# Resume guest VCPU execution.
>>>> +# Resume guest VCPU and VM execution.
>>>>  #
>>>>  # Since: 0.14
>>>>  #
>>>> @@ -165,6 +168,9 @@
>>>    # Returns: If successful, nothing
>>>    #
>>>    # Notes: This command will succeed if the guest is currently running.
>>>    #     It will also succeed if the guest is in the "inmigrate" state;
>>>    #     in this case, the effect of the command is to make sure the
>>>>  #     guest starts once migration finishes, removing the effect of the
>>>>  #     -S command line option if it was passed.
>>>>  #
>>>> +#     If the VM was previously suspended, and not been reset or woken,
>>>> +#     this command will transition back to the "suspended" state. (Since 9.0)
>>>
>>> Long line.
>>
>> It fits in 80 columns, but perhaps this looks nicer:
>>
>> #     If the VM was previously suspended, and not been reset or woken,
>> #     this command will transition back to the "suspended" state.
>> #     (Since 9.0)
> 
> It does :)
> 
> docs/devel/qapi-code-gen.rst section "Documentation markup":
> 
>     For legibility, wrap text paragraphs so every line is at most 70
>     characters long.

Will do, thanks for the reference.

>>> What user-observable state transitions are possible here?
>>
>> {"status": "paused", "singlestep": false, "running": false}
>> --> cont -->
>> {"status": "suspended", "singlestep": false, "running": false}
>>
>>>> +#
>>>>  # Example:
>>>>  #
>>>>  # -> { "execute": "cont" }
>>>
>>> Should we update documentation of query-status, too?
>>
>> IMO no. The new behavior changes the status/RunState field only, and the
>> domain of values does not change, only the transitions caused by the commands
>> described here.
> 
> I see.
> 
> But if we change the stop's and cont's description from "guest VCPU
> execution" to "guest VM execution", maybe we want to change
> query-status's from "Information about VCPU run state" to "Information
> about VM run state.

Makes sense:

 # @StatusInfo:
 #
-# Information about VCPU run state
+# Information about VM run state

 # @query-status:
 #
-# Query the run status of all VCPUs
+# Query the run status of the VM
 #
-# Returns: @StatusInfo reflecting all VCPUs
+# Returns: @StatusInfo reflecting the VM

With these changes, can I add your Acked-by to the commit?

- Steve

>>>    ##
>>>    # @StatusInfo:
>>>    #
>>>    # Information about VCPU run state
>>>    #
>>>    # @running: true if all VCPUs are runnable, false if not runnable
>>>    #
>>>    # @singlestep: true if using TCG with one guest instruction per
>>>    #     translation block
>>>    #
>>>    # @status: the virtual machine @RunState
>>>    #
>>>    # Features:
>>>    #
>>>    # @deprecated: Member 'singlestep' is deprecated (with no
>>>    #     replacement).
>>>    #
>>>    # Since: 0.14
>>>    #
>>>    # Notes: @singlestep is enabled on the command line with '-accel
>>>    #     tcg,one-insn-per-tb=on', or with the HMP 'one-insn-per-tb'
>>>    #     command.
>>>    ##
>>>    { 'struct': 'StatusInfo',
>>>      'data': {'running': 'bool',
>>>               'singlestep': { 'type': 'bool', 'features': [ 'deprecated' ]},
>>>               'status': 'RunState'} }
>>>
>>>    ##
>>>    # @query-status:
>>>    #
>>>    # Query the run status of all VCPUs
>>>    #
>>>    # Returns: @StatusInfo reflecting all VCPUs
>>>    #
>>>    # Since: 0.14
>>>    #
>>>    # Example:
>>>    #
>>>    # -> { "execute": "query-status" }
>>>    # <- { "return": { "running": true,
>>>    #                  "singlestep": false,
>>>    #                  "status": "running" } }
>>>    ##
>>>    { 'command': 'query-status', 'returns': 'StatusInfo',
>>>      'allow-preconfig': true }
>>>
>>> [...]
> 

