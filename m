Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A296D7F1D2A
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 20:11:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r59fa-0007We-AO; Mon, 20 Nov 2023 14:10:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r59fR-0007Oc-Qp
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 14:10:47 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r59fP-00005t-Ii
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 14:10:45 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AKInuv4003551; Mon, 20 Nov 2023 19:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=+NUGIoID7QepFIkrAdJndPxNrs3+aUcwRuzuq4FGj+A=;
 b=4AOdPrWpqt8aBgkm6MGEsweIjCe38jOaKr26dprAXdOQwnB2uS7t2X80cWJJKnqXH3jJ
 7VYMqnHIjJXT4KQJKN8/rO8JHMFXwOEQR+7y9MJTmeQpSWxhWH1/TBTWDffM6qnh2iGG
 7KroaP1ofp5DZzg7J7kJSFAVnL/X67PBOv7YWHnScKm1EEyCBJHIndrNPUjMBkI2mPMZ
 ed8tNb6LNwzjjexPXg/ZvkbgJh0bhIgxVRwBY4PXf0n+OojrM37lMuqaAbly3JneEwyX
 NxpQjhOxou0sAepFN/RmGSjy2VXe1T9ejBtctl8lFlUXSjSchJb79mKh3IOttP3AXk9h KA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uekv2ues9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Nov 2023 19:10:41 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3AKIRZ5l023524; Mon, 20 Nov 2023 19:10:40 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3uekq5twnw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Nov 2023 19:10:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNBA5k6kUl7ZiMXvd8HwXknp1jKC8ZOqqvotTU+WG+f14bNDCZD/bhh3ujqqQ3c1jYlAAtgWgCdkMDfKWRHJnoJwOs9Dmwm7ana5gIYgdreL6FpscpmLo4zJ/0f+Eg1J+JLAQoxAdWeP216e7yjKZxqS9np39RBTfIshvrFOfa4KipGMGHB+BTAR0FAX1YZFACcr8Xhu7xlXKknRWCQQSg51QlhFZZXI7Xty3c9MRZCFoAtakiTtgPcBzKyJ+ycFGQ50URnDIWBXqaqs4bdN6ey1z6mUGsIQ4nCGJLBmTYWm9A/YMZG3YQjXowBOnmdtg9i2AgSTsQzzw0P/K9/eHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NUGIoID7QepFIkrAdJndPxNrs3+aUcwRuzuq4FGj+A=;
 b=jzB4j0AFI9c4a/OhfVFVXZkqUXEZuK+ilAQtgLjWeT0ibrLDZdUBsW+39Giz2Pn597a3rwHZMqcLyxIgdzCGlWbJQ6N/tSc6Lk4mMpP8Fy8tWMvm9cEnn8QJnmjpfbKQ+JmhC16Llswf83EF5biOjbW93ZE81M6A3ajCXMFZiQq/8xWDL4MWKNYhZqYPyGKXYs5KSlPzQiD8OaU/YtDIDmlgUFxzTbcChA7iS7vIhUwZWoJvxDbVtO4ap4P3VdenarCIVG9ahQpaRaIvunRwj4yhSw/9uzhcMHM31tG7dtYhHoWFlWW5Qy9vHItzhmzkDhRTW3UTEaPuDhPzr1ATkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NUGIoID7QepFIkrAdJndPxNrs3+aUcwRuzuq4FGj+A=;
 b=TAbM1EaMZz4whW/Ps/cqIInWUFGf7sU7IarGZijUB0HTBnvf6bk2XM4U0jDeEyO8XoEmk6pFqzDWEBOAn6Qro2ep91RL5nmzPEiE3W6fAA0A0idMdYu7Mz+AVV4keLc1/dGiQwQ4EqOsv4NpDfYmySnkjcJiL+WPW4HCT3tT848=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SA2PR10MB4777.namprd10.prod.outlook.com (2603:10b6:806:116::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 19:10:37 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 19:10:37 +0000
Message-ID: <642d3b7a-20a5-40e6-a971-370553ad10a3@oracle.com>
Date: Mon, 20 Nov 2023 14:10:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 06/12] migration: preserve suspended for snapshot
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
References: <1699900440-207345-1-git-send-email-steven.sistare@oracle.com>
 <1699900440-207345-7-git-send-email-steven.sistare@oracle.com>
 <87a5r85m3e.fsf@suse.de>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87a5r85m3e.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0155.namprd03.prod.outlook.com
 (2603:10b6:208:32f::13) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SA2PR10MB4777:EE_
X-MS-Office365-Filtering-Correlation-Id: f4542a4b-c5d3-4a79-aaae-08dbe9fc6101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sBttStVY1aFp3SOhXoeVixBdIT5405o1cmVFd1v0ioeeaTNn48F94fAjqtyo8dnUK+dUepGrhCqNiSXuy/SCZYcXiUiz73tclgXINHU7tJvTgwDgSC6iGWyrlNdDRWUOpcIIA+yYzOgO7bBabvPRhofsVil776OtLj4UIIDdZalln3WRgYKD9HYKCDCalGU5d017qi/wy3lNMZySN6NsYXt/U3rnDmhLbzhJmEXu2JFKuSDlyQpSBivAwt82ZPBHTwF3HKcZBJIFZ5+NHHSDUsPjmWxcaaoBZXlfg6F5hI+rB+a59hMdeaeERHBEMU/mHlNpq2xO6vgFu8AmTw0DUaR41zrxvG60IF2xvTYXMfDCyc8w3j1b7o3X3dCsXXmxz8Mg5mKAaaVsmcoCd2djeTQs5dDdCYDFeEVgEEsiriOB6JOiDPJHgl3rkJgLIOONqZjKe2n8dmsISp6F5rUZ2dPdEiQnSocymorHdlrajzPNUGSf4AUS35Cx/pL8lKoR0QhU7/8G60C7tfh8v9BeFefM+uDywlmzyd81WR+a5Rtm65J6li1l/6bkmY+B9agevOFCeagjVfhPoWvRJOC/20E9IxIRCNK4DLXwxAVimMLrdmofIYSY/oqaybHqCieNg0Iidzd5A9Y8UoFvev9Mxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(346002)(376002)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(83380400001)(31686004)(38100700002)(5660300002)(54906003)(66946007)(66556008)(66476007)(15650500001)(86362001)(31696002)(8936002)(4326008)(8676002)(316002)(44832011)(41300700001)(6506007)(36916002)(53546011)(6486002)(478600001)(6512007)(2906002)(36756003)(2616005)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWJuMUtMbUtQa0dJeHovN3J4STVFVTJRTzJuOGVBYmVTcHhyQ2E4N0JGbWs5?=
 =?utf-8?B?cEczYWpqWURyUkQyMTJPcGs1QlBycERkZWIzS2F6bFhZRHlwNjBScFJJcVdN?=
 =?utf-8?B?RGdXN1QyalZPc1cwMEkzcFVRd3pia3UvREVpWFd2cFVyb1A3ZzhNc2FsNm5X?=
 =?utf-8?B?VnNEWUVkd0c0TjRsU2ZrK3czczVvSUJaNlI2ZVRpQlFrNEZyUStIbXY3UUta?=
 =?utf-8?B?Zk1RdnFTYTl1R1YzNDRPbTZlUVdmRzRzeHJQVEVTSDhQTEw2MkZQK3MxS3Ju?=
 =?utf-8?B?YU5TNi85QUJmTzAyNU5uTHRwRmRlNjBlYjJIdUlqSDBveFY1VDhQNXh4VU9O?=
 =?utf-8?B?RG13MUFLcmlWVkxtT2todFJMcy9TUEpZbkJ4SFJWMnl1ODRVYXVvdjc4enRp?=
 =?utf-8?B?OXkzaFpVSUFIOSt3bHluNDlLQm51SjVXSFV5TUtSNXRhOU9LOG5aQ01SVXBM?=
 =?utf-8?B?SVdaUHhqRjQ0UjZacWh1UjAzNUNNSEc5VUk3SzNsTFQwRXhvL0M2UGVhRCtX?=
 =?utf-8?B?cXNGbXBHakJCKzF1TllFZWJ0UjRNNWNrOURYNmYva2NHbDEyd2ZjUHh5T2pq?=
 =?utf-8?B?dnp1YkRBc3VuZ09jOWdHVEdXeGdMRVUrOUNuUHJLMGVwMHM1VUZ0OXR5bHJE?=
 =?utf-8?B?L3VqZTh2bHlaZ3ZvMzM3Ni8waXRKdVhTbDM0dk1pYUpZUEZ2S3JYSmQ4Qjlq?=
 =?utf-8?B?VUtzMHdWbG9UT0cxeGY5ek9YaEVBeC9WcElITFNEQVhGcVVseUx5NytyYmRW?=
 =?utf-8?B?M0svSGdvS3lnbFB4V3lTMzhEYUVGSmt1Vjc2SFp5NTJsVWJiSTlzVDgvVlgx?=
 =?utf-8?B?WXdnRC8vOXBLT2NXSUxzckJ1aDFqMDR6c0x3ZWNycUFab0llMVRTSUVMSFhS?=
 =?utf-8?B?UFBDMnlXZVVGUE1zeDhLbHhhUm1oenpRN3FHQUFzeHhxMFdGU2IxbHlHR1c3?=
 =?utf-8?B?RXlQL3ZrcEM2T2hFeGpsL2kxVDFxbmlOTUtIMFJnRFJFQ0FvaFJDVmpvNEV6?=
 =?utf-8?B?MG8rY1VkV3B4TVlHQ2R1VzBoUmZuZDRpUENCYzJsYm41aWdaUTl3MmlLUStm?=
 =?utf-8?B?QWVTODdETXYyQmtrY2VFQTZkY2Y2MDlNRi8xNE5sc2VrTVkzS3lUUFZncmp4?=
 =?utf-8?B?VVpEcmNpSHptWnVoc2YrUVpGb2xKWkNiQjhwc2ROOVN6L3pQWjQxQkVaNmZi?=
 =?utf-8?B?TmZlVlM4Qy9hanl1cUtOc2F1ck5ValhaRlBjUGdLaWY3OFozQW9tTHlud09w?=
 =?utf-8?B?ZEdTcTd2RFVwRWd2QjQ1cXJrS1V5b0R4b2MzSlIrV25JUkxxTStRdEh3VnFj?=
 =?utf-8?B?K1FYay9pSXg4a0RSNmVrVUxZVzFnejFRbHNhVGhRTXNRTlJCbEtwR3VTNjhL?=
 =?utf-8?B?bGlsd0dYSXJvMG9tTjM5MUxiZDBIWVA2RGJ4dDZOVDNSai9sVE8rb2lkbkxn?=
 =?utf-8?B?YUpsN0ZPQTdtUHB0UDAwd2FEMnIzTjBNYjczOVpIN1VQL3daRW43M0ZjRW9I?=
 =?utf-8?B?OFlQV3V1bUkwUkxVZDg5eVRLbTdjZWhRRUFJeEhGMUJyVVFERUs2OEFOdmQw?=
 =?utf-8?B?ZnBrS1hUSThrTytwZCtqQUtiV28wL1FoaVphLyttUDlNNE5ySHJNUm5kdlJR?=
 =?utf-8?B?TUxNaWdmc0Y1TlcwaFovWHRkVVlCUjk5d3Z4S1RjelpBdE41d05JWDV1Zk5Y?=
 =?utf-8?B?c2tVTnAxNk1JanNnRHZKTXQwU01QWXM0RXIyMjN5dm5UUmZZV0VmU0h6c3Rm?=
 =?utf-8?B?MUQ1b3dJWVdLcENiN09iU2Q3cEp0T01zUnN6YWVMTkM0Z0dnMGt6bnRtK3px?=
 =?utf-8?B?M09idG4yaFduMFJtb3hKcU1Gc3c0S3FYT2RzSVkwTEltandjZVBJUENYR0sw?=
 =?utf-8?B?VUpSOTU5OXFJcWh6Q2pmUHVUKzdiY3F3MkhheTZzUmtBQ3JBYzcrb2svc2Zz?=
 =?utf-8?B?SHhaTFlxUXQ1dHJ2MjJlblY0WG14M0JsalgyZnNhS09MQ3ZFS213SUFYTmxM?=
 =?utf-8?B?R2RlNXhOU1R6VWhNSFdicjM0Z3d4VW05YnlSMngzWk9sUDl3RXRYV2l6Q21k?=
 =?utf-8?B?U0xOaWxaQWVzSUs5d2ErK2FBYWNrc3BHQWFsYmxxOGU1TFdHd0ZUWWJDNUtX?=
 =?utf-8?B?QjQ4K3hHNkpURDNlaVhSbTFmM1RJcTFnTDFnWWpNQXBFa3BVbGRMWVdCZnJL?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oT33XIrO+WIW9760NGOqrSOF8mV0EcWH1mPxOYlXKLZUf4VHqXB27lzF6DB3FAs8EMqxkWF5ksJPlpqg5goE6HEW5hsiQBF+9FEATrVfjr00RENPpYzqln1+HvH9oo9Ev7BaO6VvFJ6nAtNderUvcRSXuqLRNJRqjjna9hcYuihRH4RB1fyqT6iDX85chis/I5EUHqOcr5SW9O9OvF+AH2DEfqMiIyKbewS7LFTB1N4tVSQyXNBrPpdxISvZQbl22r+dtupp/RaExjCazNphS0H+6SovKh4R0vfMWl1nvFd/+9nuIrpkxR1PBldJ953iB0fIcT4VSYPUJV9474godSmQdLy84uT1km7jcWgueuzs/Rp+kA+sip4eEhTpvZFzXs6omCngjFOTgtFufQbss9st5KeqZbPynZxE2Hw6WD6ofJdaKePZ1TOVaInNYoS5JgSLdaRqJHhZAh8+QVIZRsuJ53pMsKrnTUqAkA5YdwxuRm81xCN+YIKgdG6UhF18uk0Kj5zL23uUlZ9GSX0ZgbShTgr6qP3mynCKaQYd5vexCqzD93DIhUSbntISUjR/sASZzMZOfhl03kNxxrVOLAUp5MCgxcfDEZNnYSw6T2ZdlU0TAjJMmvnlhAyhNl4vNCeC7kCCuxv7lRxeg9cVD4p7dpR8370tpNEaU43zYTDhPQWEeTvl/0p/2vF24Ij8pA94GWRtlB2cWgKDLhNe1lOAnv50Ba2HKGjUwK4JMaW0PT8omHdPPvDZFUot2244ZSZ6eOJRhzgSsiA//sAqpIeoAl4MT67AVdH7aL1W9NE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4542a4b-c5d3-4a79-aaae-08dbe9fc6101
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 19:10:37.2890 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L1HHC5VpJluHKIlNYe2GAZXfNs4eIxSWmVchMFAgN4HYMWlKHbM9Ext2/YBRTv2u6ejumypIwAWu3GP0kOQJOsVFGbmrbWCS+CGwHxqlE18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4777
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_19,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311200138
X-Proofpoint-GUID: -HZlRyMtIopVbQwTgkqlevVhpF-xiLb7
X-Proofpoint-ORIG-GUID: -HZlRyMtIopVbQwTgkqlevVhpF-xiLb7
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

On 11/20/2023 1:13 PM, Fabiano Rosas wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Restoring a snapshot can break a suspended guest.  Snapshots suffer from
>> the same suspended-state issues that affect live migration, plus they must
>> handle an additional problematic scenario, which is that a running vm must
>> remain running if it loads a suspended snapshot.
>>
>> To save, call vm_stop_force_state to completely stop a vm in the suspended
>> state, and restore the suspended state using runstate_restore.  This
>> produces a correct vmstate file and leaves the vm in the state it had prior
>> to the save.
>>
>> To load, if the snapshot is not suspended, then vm_stop_force_state +
>> runstate_restore correctly handles all states, and leaves the vm in the
>> state it had prior to the load.  However, if the snapshot is suspended,
>> restoration is trickier.  First restore the state to suspended so the
>> current state matches the saved state.  Then, if the pre-load state is
>> running, wakeup to resume running.
>>
>> Prior to these changes, the vm_stop to RUN_STATE_SAVE_VM and
>> RUN_STATE_RESTORE_VM did not change runstate if the current state was
>> paused, suspended, or prelaunch, but now vm_stop_force_state forces these
>> transitions, so allow them.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  include/migration/snapshot.h   |  7 +++++++
>>  migration/migration-hmp-cmds.c | 12 ++++++++----
>>  migration/savevm.c             | 33 +++++++++++++++++++++------------
>>  system/runstate.c              | 10 ++++++++++
>>  system/vl.c                    |  2 ++
>>  5 files changed, 48 insertions(+), 16 deletions(-)
>>
>> diff --git a/include/migration/snapshot.h b/include/migration/snapshot.h
>> index e72083b..9e4dcaa 100644
>> --- a/include/migration/snapshot.h
>> +++ b/include/migration/snapshot.h
>> @@ -16,6 +16,7 @@
>>  #define QEMU_MIGRATION_SNAPSHOT_H
>>  
>>  #include "qapi/qapi-builtin-types.h"
>> +#include "qapi/qapi-types-run-state.h"
>>  
>>  /**
>>   * save_snapshot: Save an internal snapshot.
>> @@ -61,4 +62,10 @@ bool delete_snapshot(const char *name,
>>                      bool has_devices, strList *devices,
>>                      Error **errp);
>>  
>> +/**
>> + * load_snapshot_resume: Restore runstate after loading snapshot.
>> + * @state: state to restore
>> + */
>> +void load_snapshot_resume(RunState state);
>> +
>>  #endif
>> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
>> index 86ae832..c31cdc7 100644
>> --- a/migration/migration-hmp-cmds.c
>> +++ b/migration/migration-hmp-cmds.c
>> @@ -399,15 +399,19 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>>  
>>  void hmp_loadvm(Monitor *mon, const QDict *qdict)
>>  {
>> -    int saved_vm_running  = runstate_is_running();
>> +    RunState saved_state = runstate_get();
>> +
>>      const char *name = qdict_get_str(qdict, "name");
>>      Error *err = NULL;
>>  
>> -    vm_stop(RUN_STATE_RESTORE_VM);
>> +    vm_stop_force_state(RUN_STATE_RESTORE_VM);
>>  
>> -    if (load_snapshot(name, NULL, false, NULL, &err) && saved_vm_running) {
>> -        vm_start();
>> +    if (load_snapshot(name, NULL, false, NULL, &err)) {
>> +        load_snapshot_resume(saved_state);
>> +    } else {
>> +        vm_resume(saved_state);
> 
> Here we're starting the VM if load_snapshot() fails. Is that
> intentional?

My bad, good catch, I will delete the else clause.

>>      }
>> +
>>      hmp_handle_error(mon, err);
>>  }
>>  
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index 78ac2bd..b4b49bb 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -3040,7 +3040,7 @@ bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
>>      QEMUSnapshotInfo sn1, *sn = &sn1;
>>      int ret = -1, ret2;
>>      QEMUFile *f;
>> -    int saved_vm_running;
>> +    RunState saved_state = runstate_get();
>>      uint64_t vm_state_size;
>>      g_autoptr(GDateTime) now = g_date_time_new_now_local();
>>      AioContext *aio_context;
>> @@ -3088,10 +3088,8 @@ bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
>>      }
>>      aio_context = bdrv_get_aio_context(bs);
>>  
>> -    saved_vm_running = runstate_is_running();
>> -
>>      global_state_store();
>> -    vm_stop(RUN_STATE_SAVE_VM);
>> +    vm_stop_force_state(RUN_STATE_SAVE_VM);
>>  
>>      bdrv_drain_all_begin();
>>  
>> @@ -3157,9 +3155,7 @@ bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
>>  
>>      bdrv_drain_all_end();
>>  
>> -    if (saved_vm_running) {
>> -        vm_start();
>> -    }
>> +    vm_resume(saved_state);
>>      return ret == 0;
>>  }
>>  
>> @@ -3333,6 +3329,20 @@ err_drain:
>>      return false;
>>  }
>>  
>> +void load_snapshot_resume(RunState state)
>> +{
>> +    if (global_state_received() &&
>> +        global_state_get_runstate() == RUN_STATE_SUSPENDED) {
>> +
>> +        vm_resume(RUN_STATE_SUSPENDED);
>> +        if (state == RUN_STATE_RUNNING) {
>> +            qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
>> +        }
>> +    } else {
>> +        vm_resume(state);
>> +    }
>> +}
>> +
>>  bool delete_snapshot(const char *name, bool has_devices,
>>                       strList *devices, Error **errp)
>>  {
>> @@ -3397,16 +3407,15 @@ static void snapshot_load_job_bh(void *opaque)
>>  {
>>      Job *job = opaque;
>>      SnapshotJob *s = container_of(job, SnapshotJob, common);
>> -    int orig_vm_running;
>> +    RunState orig_state = runstate_get();
>>  
>>      job_progress_set_remaining(&s->common, 1);
>>  
>> -    orig_vm_running = runstate_is_running();
>> -    vm_stop(RUN_STATE_RESTORE_VM);
>> +    vm_stop_force_state(RUN_STATE_RESTORE_VM);
>>  
>>      s->ret = load_snapshot(s->tag, s->vmstate, true, s->devices, s->errp);
>> -    if (s->ret && orig_vm_running) {
>> -        vm_start();
>> +    if (s->ret) {
>> +        load_snapshot_resume(orig_state);
> 
> Same here, we used to not start the VM if load_snapshot() failed.

Here the behavior is the same as the old code.  ret=1 means success.
That inverted return code has misled us both :)

>>      }
>>  
>>      job_progress_update(&s->common, 1);
>> diff --git a/system/runstate.c b/system/runstate.c
>> index ea9d6c2..f1d4bc7 100644
>> --- a/system/runstate.c
>> +++ b/system/runstate.c
>> @@ -77,6 +77,8 @@ typedef struct {
>>  
>>  static const RunStateTransition runstate_transitions_def[] = {
>>      { RUN_STATE_PRELAUNCH, RUN_STATE_INMIGRATE },
>> +    { RUN_STATE_PRELAUNCH, RUN_STATE_PAUSED },
>> +    { RUN_STATE_PRELAUNCH, RUN_STATE_SUSPENDED },
>>  
>>      { RUN_STATE_DEBUG, RUN_STATE_RUNNING },
>>      { RUN_STATE_DEBUG, RUN_STATE_FINISH_MIGRATE },
>> @@ -108,6 +110,8 @@ static const RunStateTransition runstate_transitions_def[] = {
>>      { RUN_STATE_PAUSED, RUN_STATE_POSTMIGRATE },
>>      { RUN_STATE_PAUSED, RUN_STATE_PRELAUNCH },
>>      { RUN_STATE_PAUSED, RUN_STATE_COLO},
>> +    { RUN_STATE_PAUSED, RUN_STATE_SAVE_VM},
>> +    { RUN_STATE_PAUSED, RUN_STATE_RESTORE_VM},
>>  
>>      { RUN_STATE_POSTMIGRATE, RUN_STATE_RUNNING },
>>      { RUN_STATE_POSTMIGRATE, RUN_STATE_FINISH_MIGRATE },
>> @@ -131,6 +135,8 @@ static const RunStateTransition runstate_transitions_def[] = {
>>  
>>      { RUN_STATE_RESTORE_VM, RUN_STATE_RUNNING },
>>      { RUN_STATE_RESTORE_VM, RUN_STATE_PRELAUNCH },
>> +    { RUN_STATE_RESTORE_VM, RUN_STATE_PAUSED },
>> +    { RUN_STATE_RESTORE_VM, RUN_STATE_SUSPENDED },
>>  
>>      { RUN_STATE_COLO, RUN_STATE_RUNNING },
>>      { RUN_STATE_COLO, RUN_STATE_PRELAUNCH },
>> @@ -149,6 +155,8 @@ static const RunStateTransition runstate_transitions_def[] = {
>>      { RUN_STATE_RUNNING, RUN_STATE_COLO},
>>  
>>      { RUN_STATE_SAVE_VM, RUN_STATE_RUNNING },
>> +    { RUN_STATE_SAVE_VM, RUN_STATE_PAUSED },
>> +    { RUN_STATE_SAVE_VM, RUN_STATE_SUSPENDED },
>>  
>>      { RUN_STATE_SHUTDOWN, RUN_STATE_PAUSED },
>>      { RUN_STATE_SHUTDOWN, RUN_STATE_FINISH_MIGRATE },
>> @@ -161,6 +169,8 @@ static const RunStateTransition runstate_transitions_def[] = {
>>      { RUN_STATE_SUSPENDED, RUN_STATE_FINISH_MIGRATE },
>>      { RUN_STATE_SUSPENDED, RUN_STATE_PRELAUNCH },
>>      { RUN_STATE_SUSPENDED, RUN_STATE_COLO},
>> +    { RUN_STATE_SUSPENDED, RUN_STATE_SAVE_VM },
>> +    { RUN_STATE_SUSPENDED, RUN_STATE_RESTORE_VM },
>>  
>>      { RUN_STATE_WATCHDOG, RUN_STATE_RUNNING },
>>      { RUN_STATE_WATCHDOG, RUN_STATE_FINISH_MIGRATE },
>> diff --git a/system/vl.c b/system/vl.c
>> index bd7fad7..082a45a 100644
>> --- a/system/vl.c
>> +++ b/system/vl.c
>> @@ -2702,7 +2702,9 @@ void qmp_x_exit_preconfig(Error **errp)
>>      qemu_machine_creation_done();
>>  
>>      if (loadvm) {
>> +        RunState state = autostart ? RUN_STATE_RUNNING : runstate_get();
>>          load_snapshot(loadvm, NULL, false, NULL, &error_fatal);
>> +        load_snapshot_resume(state);
> 
> Here it's using error_fatal, so it won't start the VM.

Yes, same as the old code.

- Steve



