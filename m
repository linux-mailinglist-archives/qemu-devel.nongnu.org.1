Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCAE805ABA
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 18:07:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAYro-0004NY-3g; Tue, 05 Dec 2023 12:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rAYra-0004Km-M9
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 12:05:41 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rAYrW-0006HQ-Fy
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 12:05:37 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B5H4Jc2007108; Tue, 5 Dec 2023 17:04:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=9W0krA5wYRtT/tPwlK9lzncetPB6szqZdzc23QCY9vI=;
 b=DoQeHNFDisbqHO2cIOIA59GmfS6zKr0q5lDsCl0l159aweebj0XsIydL2zQSdZdMljro
 f2537bYfYTG40mqr9CC7c8bht4uVj8d3Rk+ogcMFHcXO2g1faj6N3W29r4A6V461uLqN
 uH2WgL0xtTM7Qe2nXdT45SuKvHre8GN3IHA9qaJg17xgDwyV45wK8dah3v7nHtx7jrdJ
 Kk987pCrLVkQmARKVx8ONV4EDYxbyo6f2OuYDMYurrQdD+rfkJYag7IYLpP4NF4lLsPF
 x9w4E3bcsMk6ymoRUZCP5VjhmV5VuB3iNbM6nMiaB2VoxJRJOeDCWGZh7QZ3cMDFuLdj nQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ut0y396p1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Dec 2023 17:04:58 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B5G3YA5039822; Tue, 5 Dec 2023 17:04:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3uqu17u2nh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Dec 2023 17:04:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGq7QFcTpSMwUKxHgRWyIxZSQDn/n3l5Pw5YQ21Qzbn/TW2V2vBauzQ/yhgNXobOBXzInj1X07k0a1HhlYr+nUA4mvemNFwve3mgsYktNh4uN5ZFLRApfqS3cIQBhgLHTP2+0kSSfW7eQw4SQe9OHXAIiugqOhsfc3xrft4meQstkNq8YVXhmcX68o6VTVt8U4XNHemBpnG2WJoWEvPDvVNZ40JFt1xCn5903N77VLgkwQQqd0hO7zODeqvKnlsRNPFEn5QzrFexUAhvh7N01fMkBPXTFw5hGoCEa8rLCFZZIDzva3PTEe9zzxEulmVpIGGSH04L5tbXodhnr1DOWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9W0krA5wYRtT/tPwlK9lzncetPB6szqZdzc23QCY9vI=;
 b=jIfcRbb5gj6T7eY4JFfx3okRbvo4ZOk5UtDdwPukUBTx3rtFWGwwfRbS4aotcTIDSSc7ermhQanpqu0g7eJvAobUlCoC/E44Nf/Mbs+UWJNyNA6vl7SiCICePY6Ak71PWwm2/QLRFecH95Mtjfae4Wk/1oDDfChcQxz3TgdsYgvrtZFEvG4JJGLn31YbvTIu1iffQcDwZ4QMXsIPDRHbJU8bhzxTiAKGD/zc3TcJVXfQTbaYSfChqNwNrYJs+KBADd45qrWv9xmaL6oH7qJzlfXgqlZqdQcHwM5H8EjbAvYLCdD5P/T9OUGBVn0h/0fo/KuG8MyBr9I5JnH6eElivw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9W0krA5wYRtT/tPwlK9lzncetPB6szqZdzc23QCY9vI=;
 b=AZz0v4ygkyRrwOJgXltey9SffnVmypvWgiXnFTCDr6OHILg6yAwM8pIrgvul35YtcheVf0AZ3rCdJaBGyl55QhJyjaaMVZy+WKTGsNRQYkfcutoY3hiIwgFeiY7pyy6ZgCqDy1sGxY/wtQoJPXLeELwdhWh0IGuVYoTQVM1nTe0=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by CH3PR10MB7713.namprd10.prod.outlook.com (2603:10b6:610:1bc::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 17:04:55 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.7046.028; Tue, 5 Dec 2023
 17:04:55 +0000
Message-ID: <d663f0be-d4a3-477e-af3e-d023a2b02ae6@oracle.com>
Date: Tue, 5 Dec 2023 12:04:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 05/14] migration: propagate suspended runstate
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
References: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
 <1701380247-340457-6-git-send-email-steven.sistare@oracle.com>
 <ZWkVbiQNl16hC1LW@x1n> <ea771378-33c4-4d4e-9de2-d39310028d10@oracle.com>
 <ZW4LX9FpfTj77TZv@x1n> <87r0k1n4r7.fsf@suse.de> <ZW4wTK0dld9pPCtX@x1n>
 <87o7f5n08z.fsf@suse.de> <ZW5M19173nTZTLv1@x1n> <87cyvkn7j7.fsf@suse.de>
 <ZW9NcwNropqV_7Kz@x1n> <877clsmw1r.fsf@suse.de>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <877clsmw1r.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0254.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::19) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|CH3PR10MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e63c35-2ec3-496f-ea8f-08dbf5b44e16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LrdP+ZN5VqK7bPqnvdnowoGOfEIUSyT7UgDvJB02Cv5BHumLLndrAKv60ccXbIbVb6/YgNPingMKyV+nNDp3Ry+w6TtSr8IomKhf1nk/UkP8Jl8sLXSXq1Va1T9QoZjrOFYqbhotMRr7a6oKdXjmV86nIw6T4zaDI5ItamW4ZY0FfE90mmpgxxt6cSK4OTMQE8+HZhpB8r0gsUpGvBydzcqKoQxuctx5EjbI/ulLhY3/Wuu92VloJURp8KzNmEsYawsDwudU+Gqfsos0Vl0MQKMRC4nral22JmXQIORCKyvMfkqwrQQxwHVv9BROaBK7M0BxsCfUNpXnyoj5C7eFrwYSANj6MKP7lixjUQ4TEbgimIQNj5cdqOcaRfwJ1LWE7I4pcoSbvyVhI/GxNJOQTZGvbTbTIiirGk6mYaRVlczZMGNyk3C5wRq2n8yVa1LhPvtXk0G3RV0MFAx9NhjVFapRwZhNWG9OQV//TZbzJRFQcY6TyOGkKToYeQSk4vNyh1uDC20OjE1Z8ZzFEzoJXF7E8Ajr7P1YWNP/Z7Y4YI4c60MLUZ5rWU3bS9HLJKgWQbVyZrT0eJJHuoREm+fjLUvNckHknvYku+h9jH8iRhnH9wQ4FVbMerZKJqm3xhzpETGtw2heErdAEpF63soJkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(39860400002)(346002)(136003)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(2616005)(8936002)(8676002)(4326008)(53546011)(6512007)(6506007)(36916002)(83380400001)(26005)(6486002)(478600001)(6666004)(110136005)(66476007)(54906003)(66946007)(66556008)(38100700002)(316002)(2906002)(31696002)(41300700001)(36756003)(44832011)(86362001)(15650500001)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2FUanZlNk9Kd1UvSU80Ukd1Nmdxa2Jmbm10aDRRdVBQUlErQitkY0ZDY1dG?=
 =?utf-8?B?TEgvODd4aFFXWDBibDdOa3ZXNTlDM3IrOU54aERKZjdiQWZKVTFUYjRXcEg4?=
 =?utf-8?B?YXBNc1pmODhMaFZsZDh1TjgyQ3NMM2NoY0hXRFQ3MXJoU0NIUHJhcmMwWmdO?=
 =?utf-8?B?aWNNNDJzdU5vOTJwb3kvOGVUQzlwdWVaOFdwMjlyZnJkaEdmZkhTV3YyeHdr?=
 =?utf-8?B?M29zd0FsamZabGM5U3ZtV013N3V0M200NmNWWEhQNkl2SHRtb3M5Q3hBdFA3?=
 =?utf-8?B?UTY1ZEpDMGV2TkIyV01VVmJORngwL2k0ZitwTTMyWnVrYm00STdQdW5DUlBI?=
 =?utf-8?B?czY4TGNzSkUrUy9PTkFFR21OTUk4QkR1a01HZWxNVXhqZktqcXdNc21YaTJu?=
 =?utf-8?B?ZkFXNHNjdEwvQnFKVWdtWjd3SXU4ZFo3MERLb3l4KytBeXJZYjNpNXJyVith?=
 =?utf-8?B?cUFtYjJnZm9KL2szbVdjUHhaejc1UmJVMGxTYUZZSXZ0NHlXQXEwQVg0WC82?=
 =?utf-8?B?Y0dRRmVpUUJFV0s2L1pPQ0tzS0dFdEFCVW9RbWY1U1ZwRjVyaUdUYzN5Skxl?=
 =?utf-8?B?SXJJdW1SRFR6U1ZRNFJCUTlNR1YrMUp6QzNFWTZtUDh5RldTeGxtc1BNV09q?=
 =?utf-8?B?LzBTZ3o4TUFMVFd5VGlncVQwbEZzMWhXU3FSN3pqTmo4bTVuRndQdEF1dGh1?=
 =?utf-8?B?Um50N0dJZE85YkxEaE4rbG42Rjgzb2IwbWczNXRCSThQS3gwakFOR3NYQ29W?=
 =?utf-8?B?RVJoR2ZwMkl6cVBrV0p4ZUx3K3VsSDF2VWswRnRCVjZFL25ycTRwZkQ1UVVN?=
 =?utf-8?B?blFtbVoreDgvWi94bG5xdU44L3Y2NXFWaXBTYm5wUE5KaE13cDVzS1p3V0cy?=
 =?utf-8?B?UFV6TjRRRGFNQjduOWVNMld1b2NQS1Jrd0JBbWZ2WVlzaEhPVnlZL25MMUtw?=
 =?utf-8?B?UXcvUjdqcitSdCtWNzF5NmdHbE9UeVYwakFmaVMrRU1KN0pYMXp6bkllbWtN?=
 =?utf-8?B?QitibkdNMGpRTEg1ZEVMWlRKU1VXbEdIcVI0dlRuMXllbERZVTNiVDQ4MUpz?=
 =?utf-8?B?MHh2ZjVSNm5vY3Y4enRCcG1oem51R2Y5U29EUlFRQ2FnVktUY2tmdUdBUm1F?=
 =?utf-8?B?V3RkUVEyZTJtRTQ1SnpOczMyMlB1VGxsVHhXWS84WUJlSFRHSy9tTnBodENa?=
 =?utf-8?B?UzcxZVdRMXBzRWpoV0VveFFMdXVnOTcydmZhTitIVWNGNVVPRzI2UktFRWl1?=
 =?utf-8?B?Z284UDNQdzNMN2JwUzIwU0x0bDNkY01pTGJsYzFIeGwweVY2Rk9oejM5Um1z?=
 =?utf-8?B?MnpOKzdWbUpsUlR3eDFPMUMybU5JMXVoK2FYT1JxSFZBTlM3eXdEZk5ydmVV?=
 =?utf-8?B?SjZtYkhZVW5zRCtiLzhCRG1PK1RyYlk4bkU3ckxseHorc01lakJTNDBOQzZ2?=
 =?utf-8?B?OUtIUzlqOHM5T2xKM09EVFBEUERONTRwZXJ5Nnp1a1N3VnR3Y21mN3NtYVdO?=
 =?utf-8?B?NFg2TnlibjEyQWlpT1hHcTFIa3R5empLREgwU1NGSWptMGJUTDJpZjJXZk1k?=
 =?utf-8?B?MFEyYzMvRU5wa01za1VBNENJMjhFenNScFRtSFd2allJT1RQTHJyd3ZmeFg3?=
 =?utf-8?B?b003U1o1ZlRRZVRvUzN2TFBtOFppaVM4VVorVDEyVkZxVnZXWkJsbjRTa1ND?=
 =?utf-8?B?WWJIeXhLWkREN3B4KzRRTUFWVW9lbVU4L2QwSFZieVZHVENpRWlLR0V3ZjZt?=
 =?utf-8?B?MUtkVXFuWFRZQ2szQjBod2cyQzVGUTlFcm9tK2Irb2I3NUdBNDdPRG5jOC9i?=
 =?utf-8?B?ZWlLQXlmV1FZZVJxaHhycmMrOE9jdmUxek9qK24wazA4NCs4dmNuNndVMHJU?=
 =?utf-8?B?d1NrTVlKVm04S3p4am5TWFVHZUZHSVd4emo4VXZEUkNMK2NrWVZTSXR0dHYr?=
 =?utf-8?B?cXNlZk5DdmtZU0ZWeXZ6dzl5TWpUaDI0Q1dhbHBXSzJtYkpXblpJV3UyVXZH?=
 =?utf-8?B?dkUrSTE3VWMrZmJaUCtTSDN4QmVqd1Q3dnYrSE5aYzBaUldZL0M5enFScEJX?=
 =?utf-8?B?NVMrSTU5YXIwbGtmT2FNVEZsWlpqTDJUbDRZSENvNWJOcmpPRk81U2VhTW1q?=
 =?utf-8?B?TSsrbDdCKzFLZGxzUE9aTERHRGxFYWxzMFByc3JaNDJEY1RTVzZMMFI4WjZs?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CUWAdef4OTQfwjzkY8R8ybbuhK8+/sLFeLzCDKAp+0rToPy8d/Fx8BmeZysj2iebP67Iln+LAwE7pMul2tahlUm8FAJZ1JwM2LA+QPkxAcPi8GexF11Wt8RPJABZ9llAnbP0tcBZ7ikeF1lVU2b0Ac8liFml7PjhM6wpSMfgySpEKmxNXwzKM/F2YWYcRiNNE6otgGqMrvHHbFgzi5G0+B02G398ZJnLPtt477np+mITAX665P2GGhuJGHXEFoTFY6hCyP0Lyo10LRj5SuGAnvo5wnvp5vyc6vg+G78Mm48TlGzhg08JhEeTJjK4tjyP2sOzSmEmyjqB7xuIj0J6A63qpe4cEF2kwYkm0vJQQa+yPtRMfWAiVpnpky6BRukkhv+93+vdDZnula2+3vd5PS8ZPZax2lStjUmc+t+RU1JDSQSpQFZbRbEXIwjhf2HW4whvyGGXWInTPild55o02hHD7EndvzfzSF0a3AzFCCb+0hPjB7CNURRzEGS9F1rV9v7dpgyZqcXGRx2QplQkPjCbFl0201mNGZXqnbo1n7Vw1SCsMOKmRjt65LcrPEIC4p9ksHVv6lChDiFOkUhIekrKyJAOIpVx8Ee/ke75xMXrb24/szHw0vYzElg988Rsld/VrHAUtLkCXSU0N3Oil0lIuBcIlDL3mo4Q4KAxUZQOf4g87+xFFH7G3WkncGsS4yhrRY+I3KyjG6/gh9is2ZB63oZpi6OMl+cAIVPj+ozuqbnSWkvAYmdKYFUwzhUIrFYei34guYgCro4gC3lk/IFHse5i3l8XRHYnsEqFH+U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e63c35-2ec3-496f-ea8f-08dbf5b44e16
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 17:04:55.8071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3e/WbD9+wUhtsR9XG5dOWt63/bwpAt6spPpS9/plnJI5Q8xWe5f331sgiWmRACzCkFIrrJRb1HcFq+muNTec1YABUCFyUYapZDfVh4xH7GY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7713
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_12,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312050135
X-Proofpoint-ORIG-GUID: GW9jDNooyd1ScQjNjqu87MWtXYRCE39V
X-Proofpoint-GUID: GW9jDNooyd1ScQjNjqu87MWtXYRCE39V
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

On 12/5/2023 11:52 AM, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
>> On Tue, Dec 05, 2023 at 09:44:12AM -0300, Fabiano Rosas wrote:
>>> Peter Xu <peterx@redhat.com> writes:
>>>
>>>> On Mon, Dec 04, 2023 at 06:09:16PM -0300, Fabiano Rosas wrote:
>>>>> Right, I got your point. I just think we could avoid designing this new
>>>>> string format by creating new fields with the extra space:
>>>>>
>>>>> typedef struct QEMU_PACKED {
>>>>>     uint32_t size;
>>>>>     uint8_t runstate[50];
>>>>>     uint8_t unused[50];
>>>>>     RunState state;
>>>>>     bool received;
>>>>> } GlobalState;
>>>>>
>>>>> In my mind this works seamlessly, or am I mistaken?
>>>>
>>>> I think what you proposed should indeed work.
>>>>
>>>> Currently it's:
>>>>
>>>>     .fields = (VMStateField[]) {
>>>>         VMSTATE_UINT32(size, GlobalState),
>>>>         VMSTATE_BUFFER(runstate, GlobalState),
>>>>         VMSTATE_END_OF_LIST()
>>>>     },
>>>>
>>>> I had a quick look at vmstate_info_buffer, it mostly only get()/put() those
>>>> buffers with its sizeof(), so looks all fine.  For sure in all cases we'd
>>>> better test it to verify.
>>>>
>>>> One side note is since we so far use qapi_enum_parse() for the runstate, I
>>>> think the "size" is not ever used..
>>>>
>>>> If we do want a split, IMHO we can consider making runstate[] even smaller
>>>> to just free up the rest spaces all in one shot:
>>>>
>>>>   typedef struct QEMU_PACKED {
>>
>> [1]
>>
>>>>       uint32_t size;
>>>>       /*
>>>>        * Assuming 16 is good enough to fit all possible runstate strings..
>>>>        * This field must be a string ending with '\0'.
>>>>        */
>>>>       uint8_t runstate[16];
>>>>       /* 0x00 when QEMU doesn't support it, or "0"/"1" to reflect its state */
>>>>       uint8_t vm_was_suspended[1];
>>>>       /*
>>>>        * Still free of use space.  Note that we only have 99 bytes for use
>>>>        * because the last byte (the 100th byte) must be zero due to legacy
>>>>        * reasons, if not it may be set to zero after loaded on dest QEMU. 
>>>>        */
>>>
>>> I'd add a 'uint8_t reserved;' to go along with this comment instead of
>>> leaving a hole.
>>
>> Note that "struct GlobalState" is not a binary format but only some
>> internal storage, what really matters is vmstate_globalstate.  Here the
>> "uint8_reserved" will be a pure waste of 1 byte in QEMU binary, imho.
>>
> 
> I prefer wasting the byte and make the code more obvious to people who
> might not immediately understand what's going on. We could even
> assert(!global_state.reserved) to sanity check the assumption. Anyway,
> that's minor, I'm fine with it either way.
> 
>> I think I just copied what you had previously and extended it, logically I
>> don't think we ever need QEMU_PACKED right above [1].  We can also drop
>> "size" directly here, but this can be done later.
> 
> Ah right, I was initially thinking of letting the new qemu overrun
> runstate[16] so we wouldn't have to change the code. But that's indeed
> not necessary, your additions to the vmstate make it ok. Thanks.

There is no need to reserve byte 100 in the new scheme.  The incoming side
sets s->runstate[sizeof(s->runstate) - 1] = 0 to protect itself, and now
sizeof(runstate) is smaller.

- Steve

