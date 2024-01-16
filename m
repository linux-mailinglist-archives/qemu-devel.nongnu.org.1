Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEDA82F817
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 21:37:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPqB6-0005Gh-95; Tue, 16 Jan 2024 15:36:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rPqAx-0004wQ-EL
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 15:36:51 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rPqAv-00047K-Fd
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 15:36:46 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40GKEDoO021920; Tue, 16 Jan 2024 20:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=i3ObCr8hHiXQfXuZEUQF0g7MZ2qfHHYs4bi5VplqeKU=;
 b=UKKmmqfl622F/HJldHqD1/MPJzDKAz6xJ08PhLGrjdmClyuYfgG+I885vhYd9f3w+R+n
 gQ+d+xcBuqZm3zh8EypVqRdIX+FocHt7+6Ryt9L8q6n/DGsnrFhIr7meTj01WRHZ9utQ
 sJgMobsHzukD4MFEfF+5WMG2c/JlO+FOKM6nZ4KDN6PzfQii5D0cZHcrCHG3rmvzXloO
 1eUhu74XiVmxSPSmnMIm4g8WPGK1ObR41GYk2H7aH1b1KVf/zY9N7Vj0pWgTmXXu/Hh/
 JDE3L1kA9eobA8pVyjKbdVOXhsHqM70Zreffzf2FyDoznXomHgPJ3EEbBh8qaiLgq+Iq qw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkq3gwrna-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jan 2024 20:36:41 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40GJGIXe023270; Tue, 16 Jan 2024 20:36:40 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3vkgy8rwtj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jan 2024 20:36:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHeFBDhP+jbqYsQdxuZ4NlN5X7ZAs2IVy7RvQAXgmKJjHA4AnCVBHZ/cLbb7Exme53XERNY60hIP/zTU+/K/HkhX7amIU5qcM80W7fLNriCAUzRpmrQKASt23vMmWt4K4MKWqlfu/MXqHGy8QJddxXwtBRSAtlDFTi09nNleGY8qo+CSI+UKrSKOewwPOkmqwY28sboXgktqJ5OisbWuiNGBHwUYg6iN2L93d2qZwFsZOwMfYoGNXZWzSXljNv7nXWNrH1ka9ODo4J4m2xcgKGJtqA7WR8eWM7g41m7bu1VZWdbN2SOJXXpHIe+yictUyuzAo3jKGMrlFYQhm2wJfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3ObCr8hHiXQfXuZEUQF0g7MZ2qfHHYs4bi5VplqeKU=;
 b=UMh45ye3zW/0DN+5OIhJFRpkv/UNC0+mV/L1Qz4PJi9VLHIAaNVV6TnrfXKvHMGU9BzexHLE+7NSEyVwCSeHCaJIt6c8fLNJgRdzbtRFIDRK5ZREsNhmPWx9pUyBjPSQ+o4KfTPBh09wMvapFWIvk5gNyJR4VWVd1vxfBS4dWEtLVQ0kaP2ACHQ6e6Rgp5D32UHZ8eNTTpAWhEwcBb/WTCg04jS1Zq70zA4tEstu5rYTaFcvZlGHEa3LmclMRrzgFcw4n9xnvsVCqgb48eQPm21lAq/rvY6WZ/wNRHFTtbl8NogQ4SAkqxSdUU87sl9vgr3wEjbblAS6FOft8omEVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3ObCr8hHiXQfXuZEUQF0g7MZ2qfHHYs4bi5VplqeKU=;
 b=RT++8NjTn8NqpUXS6nKuDCI402lMJdqNYLUeVC3eNHYJF/uWHcdbk9nsE9b43xmjELlc3dps6HRZldEaQ5blAnxfjeboOtk5kk4zzcDRgpEfy80hHAASfuOno+VXktSyRqPsSE55qZurH0Iq8WQfzH6j/BzbKmpW/updpF1lfLY=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by DM4PR10MB6208.namprd10.prod.outlook.com (2603:10b6:8:8d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Tue, 16 Jan
 2024 20:36:37 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7181.026; Tue, 16 Jan 2024
 20:36:37 +0000
Message-ID: <64fbaa73-cfcc-4ae7-a231-907b46a22625@oracle.com>
Date: Tue, 16 Jan 2024 15:36:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 04/11] migration: remove migration_in_postcopy parameter
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <1705071910-174321-1-git-send-email-steven.sistare@oracle.com>
 <1705071910-174321-5-git-send-email-steven.sistare@oracle.com>
 <ZaTVOF7aPV-n7gKY@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZaTVOF7aPV-n7gKY@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0076.namprd05.prod.outlook.com
 (2603:10b6:a03:332::21) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|DM4PR10MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: d9cf81ec-c05b-4308-b8ed-08dc16d2d649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PJrbtOZGrf+O6IWbl1uqDk3C5vAFlGWRMLEsItdKouQ3g5as7EKt1BoKHXhETh056XUySBju8LB40W6lqtboyvha6Kx6kBMHpnIqdrp5q73ZdzW67uqDImqUOk8JTPfg1RlYH8Z5NE+CDlbVy8W7ijEcbvfehF5BNfRCG5X0jvidqAJ4ajePzM8rCMkE9qQgrlaMDx8f7ZIM6RGCPF8U2so4w5O8Ws0QPJLS8ccVT0pkImOBNyHPRc4e9qiOCR9vlo/adbd/bW9X9P2U/NoOwpR+dGd8Ogy6oOKDDS6YMjmmQkurUvcnxG452ohCWF/UqLyMHPmntciKTSxkrRgv+rHilujqB5O4xMw3/EAGkRvmBWlDc9KRYrS+H4+5I32+TKLXk193JiMou2a/z1CmermsLN4SDpKqC5x3aX+DnIeFCIqNZsuDpQuTmijI9gMOzJqaATudD//Nt4FdZrEQ/rLfOBriYmFLdResg7OUmlWqTNC43engnnTHSYxl/TkDJno4HOaWEqGbjxJpsXdM5VkYNLTJ5lGGflHhCDs4oIwPUPsMmPc7bZqzZ483/Nzj9fVaYQVUCh6n/HPzVCGOywR1jXjWlOCADImNJn5QBcO7uiDfLWQEKmC99qgptAQPUXBhX/nGSbnC0PARhKXpQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(39860400002)(376002)(396003)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(41300700001)(53546011)(36916002)(6512007)(478600001)(26005)(2616005)(6506007)(8936002)(2906002)(5660300002)(7416002)(66556008)(6486002)(66946007)(66476007)(316002)(36756003)(6916009)(8676002)(38100700002)(4326008)(44832011)(86362001)(83380400001)(54906003)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amlVS2hXcngyNUhTenM0djdwZjNyNjl1MUJ1dWMraXBidksyVGwrZldmVUtn?=
 =?utf-8?B?aGIzZ1VVUHZTUFFvaE41WWphYmVpRG5MZU1rcHpWaDIzdy96bnBpUG80dmZM?=
 =?utf-8?B?T1FwWmMxR2o1ejByRDU4cTVodXhoOEdPZlp2Z2ZYZkVrZHAyNlJGOWUxSkNK?=
 =?utf-8?B?K3l1OUZwM0JnMEdCb0JvZzY5RTFnL01lV0NFVVc3UDlZNklZZjNHZnRtMTNK?=
 =?utf-8?B?RUs3R2JwSm0xOEZ4N2RWSjNpb3R6VEVtc2d0Vm84b25OZEpoZXZocGRxbEVS?=
 =?utf-8?B?a2YwWnFJOXlOUHVFZHVXSEdtejhNT1d6eXVmb0NNZ2VaS281dzFiZjN2Szhu?=
 =?utf-8?B?YjRHUDFGZUNTWDNBMnRyYW5LdFFObER3Y1FlUWt1MGFrbEJGT21TV3pNelZN?=
 =?utf-8?B?QW1CdkRnM1l5NDRLOUdsZldDcVpHYUpCTlp0c25vNzlLRi9EcGxBYmVrUGtW?=
 =?utf-8?B?WjlqYVVtTkt5alIyc1dCNlM0aDBYTVRwdHpBUE1GZFlmZzV3cGl4ZFFCUjE0?=
 =?utf-8?B?MThTaGh4MTN6Z2JIamFCK0dobGtGTGR1aSsxb1JKdnR6QkpJK3owdDlLRlpn?=
 =?utf-8?B?SGdMamVhbERwbUMyWFUxUDgrZzl4d1h6TFpwT0k3RVprT0Z6STk4dUVhYThZ?=
 =?utf-8?B?TExjNTlXZHBtUGwzaHppU3BaZ0lyTTM1eVFrMFQ5dUdrVVlXeGROTGl1TVIr?=
 =?utf-8?B?dzdxM2lSckFIRlA4VVg5c1ErZU1pL29LL1o3cG5mT3MrVVBhMEpGMUlOditQ?=
 =?utf-8?B?akRNZFlqWWNLeGNXaFJyUjhsbGFLMHV3Z1VqaXhxczhCRUx4UkpXeVpSYlMy?=
 =?utf-8?B?YXJFSWVSdTRaOWpmMS9UL0g3WWR0eFBvdWJsdktjL29ETmJXTUJ6dE5rSmlz?=
 =?utf-8?B?SVpISDNTUHNmc2FNUUR2NEVaLzlmN2NxMm9MNlovcll1aEliMVBBUDZQNWpz?=
 =?utf-8?B?ci9MVW94dzlqd0lNdE9lZGtNNkJHNUo5UU14WDgvdUJlaVBjbk9OaVNFR1RW?=
 =?utf-8?B?bCtiYVBRbTVuY29XS3FMU2E2UWwzZHR2ZXlRTXJtalIrcWp3dmQrb1JTYm44?=
 =?utf-8?B?Z3hUbEVTRDBvQzFua1k1Ni82YzAyQTBpRHRoVTAvVkxsN25wU3Y4Y0FzK1ZE?=
 =?utf-8?B?MzZ5cGc4VldJekNESGtSZHYvWUhQRU5qTVpxdTRjV2FVTTVsVkZwd0xodFJw?=
 =?utf-8?B?K1o3aWF0QXQySkVKUmJ2dmgwNzA2WXRJOHZ2MGdGVGUydDA2N2w2RWNLdWZT?=
 =?utf-8?B?bHJxcnVXdTBBZXpQdDNSK0o1TW1lUWJkY3Uxb3ZjcjJtWFJSSzY5UUVYUXlF?=
 =?utf-8?B?WXFnRmo2QUsycFFyT3FWWlNzejc1SWc1d1JYbjl2c2FGalZacmtZekdRZTlS?=
 =?utf-8?B?QkZ3dXk1NTBONHVzbHdVYVBKSU5BZFFEU2FuSHFQaEJaZ1BtdU5QNlRGYjRR?=
 =?utf-8?B?V1YwMHM0S0lUSVBqQmlWa2FxejNuSmpIblg4VGJIMXlYbnRya1A3TGNZSHYx?=
 =?utf-8?B?OHhLVm9Qc1ZuQjdxSVAxRGtUSVpwRFVCUFQydFAwOCt2bW1hcWNKenBBYzhJ?=
 =?utf-8?B?L2JTbXRQRGtkbklVN2lEVDVjK2Rrd0ltWGZYMjRIc09PZURIZ1JPY2xuNkRC?=
 =?utf-8?B?UzJ2Q3ZvMFFYSkdRWGN1THlqQ3M0U0J4Rmc5Z3BoMFFtU0lRK3dNTmtlMXVJ?=
 =?utf-8?B?eEVLWlpaRjRyN1lpOGIvZHkyRjJaREdtb1J6anpHZTJOZmlJRVZJWUp3YU1q?=
 =?utf-8?B?U0VhOXdMVnA1b1Izb0ZLV1ZEVHg4azN0eUtxbHNvUlRNVDNTSWpwS05XMmUz?=
 =?utf-8?B?WTF6WFBUTmdMUGpVTThWWnZVcnV4a1p0ZVJTeVR3YVpzbWxTKzNDWTUzYkVj?=
 =?utf-8?B?clJGSlZvYStpcHdUT2NuTzU1Y3pxOGVmVVJEZFZBa2JyeE9RR2poNFdkdFpO?=
 =?utf-8?B?bWM3cTNhV3pTSHM1SSszc0FWY1JZWkVEbHlyVEthWjR2SzJ5R1FMRi95QThZ?=
 =?utf-8?B?akN3b05YTnVBTEVzeVRZSzI0ODhmQXBrUjFPRTdqaG9iSFNqbEx6b1h5TTZ6?=
 =?utf-8?B?STd6bEdIejQrY3UvbW5ucUlrNTBJVElNdU9zU1NBdCsvbXd6d2NRTUhMMlhz?=
 =?utf-8?B?VTNueWIrbkhWRXBDSUxIS2dPQmpvcUYwTGNXVStIZnVXRThCajV6bGJpK3RF?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: k3aU4n+STUSTyiKn/BBG+uUBlUfdGUvrHW8vpX5BKq1GYDHG3oy4tAz6gk7mdnE7/Y7he4/TfscLZpIqTqZmAZG0AegnCsjMiggQSLwe8mLbgHm7BPL4jgvRETtoj0jr+YlEbEGEKYpZm1tyE/bzun8scGxyrlSm8mSzayWe3OVY9K1rBrrEHKq4dvpT2o36hsgldZXeA99Woet7zayFwkSI1St3OtIFM3BFof/X0Af+2RLmzbV3EYZtG4I2GJpBlJU7hGYKCetptGHb1Ki9fJdPApuPSpUqAduUYYBlhAITVDK11qGEqTl2vOi6Kl0oIFVqn5m4qsWFUTbkarPwgmTOS5rus0SDHPsQXS4g1Rx0MTz2BDdQMPt7zd/ceK5vNk26nvqXl4vXHlTrrfiE9CnzNZCs1pH5PlQhfYTUaBZv6/WWx1oFRtEeuSTOxcu7HW93hb4KDX70e3tTl7oylzrQd6HtFvbm8H2maAbwKz2oeUYlDDUPAPZKguYcZLU0/m1DnhFK0SZhFP1Mt69uSyfqkm+GqHisuykrZndnNqF7ABNx/nC5bgjWW8kvV6Ti3gkOHkckJFyZTmOOzMYxXvmO33/eKxzB5EPYyug145Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9cf81ec-c05b-4308-b8ed-08dc16d2d649
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 20:36:37.5042 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 31yWHT9AgjHrWCKftCQK/zOA7HBZ9HeMjRRUEZN4i8kZ8Te7Gu9ws2Ofv1M0yWU5Y69P6dX4KrnT/7Xt23/ZMrQeKoW5J0+CLDHn1liOg6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6208
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_12,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=914 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401160162
X-Proofpoint-GUID: TXL3Zl8R-lZKifGunpssoJ1LGNTp4Rhu
X-Proofpoint-ORIG-GUID: TXL3Zl8R-lZKifGunpssoJ1LGNTp4Rhu
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 1/15/2024 1:48 AM, Peter Xu wrote:
> On Fri, Jan 12, 2024 at 07:05:03AM -0800, Steve Sistare wrote:
>>  bool migration_in_incoming_postcopy(void)
>> diff --git a/ui/spice-core.c b/ui/spice-core.c
>> index b3cd229..e43a93f 100644
>> --- a/ui/spice-core.c
>> +++ b/ui/spice-core.c
>> @@ -580,7 +580,7 @@ static int migration_state_notifier(NotifierWithReturn *notifier,
>>      if (migration_in_setup(s)) {
>>          spice_server_migrate_start(spice_server);
>>      } else if (migration_has_finished(s) ||
>> -               migration_in_postcopy_after_devices(s)) {
>> +               migration_in_postcopy_after_devices()) {
> 
> This can be a reply also to your other email: my previous suggestion of
> using PRECOPY_DONE should apply here, where we can convert this chunk into:
> 
>   } else if (event == MIG_EVENT_PRECOPY_DONE) {...}
> 
> Because PRECOPY_DONE should also cover the notification from
> postcopy_start(), then we can drop migration_in_postcopy_after_devices()
> completely, I think.

Yes, that works.  I will define and use MIG_EVENT_PRECOPY_DONE and friends in 
"MigrationEvent for notifiers".

- Steve

