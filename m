Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DEC7BB6C5
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:43:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qojBV-0003fD-QX; Fri, 06 Oct 2023 07:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qojBO-0003QI-J1
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:39:50 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qojBM-0000kf-Pl
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:39:50 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3969Dstu019448; Fri, 6 Oct 2023 11:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=UhuViuJ2iFvGgcdgNAsWWsItHfAgA2ReEvUmp4C1NNM=;
 b=lhfZPdXI4S2QLpuE/0OV+N/d7TK12lLZK0xWOE6wls9+SUP6/GyaeUFQ4nELpD9cXqjA
 bpUGZTehBlvnRF4W4qG/YpUmKZIFyMgvAuRw/pmkoX6i0yhE86zFgwixqlMcfYe4gNvn
 IthGM/Cu/m0YsgJqGIt2+yDrlKjfQLSnsEjILeICUooL3G1c6v3jliZCldalS//grmIw
 DpQCGWnzEuwKjdmxBjkqcFM95FOXtoePl/saty7Rp05Y8H9Q086l2WWnsqsH8D99DHEJ
 d1Ge6hvVsJATdpSOqOVKBiJTYVpOoAWaAzQRTu0VtNMaB1jH3fkFA9EX4QGDzwA+9rJy kQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tea3ekn3b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Oct 2023 11:39:46 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 396AmuJM005931; Fri, 6 Oct 2023 11:39:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3tea4ajgt1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Oct 2023 11:39:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGYTKthlzi0iY2HGZ1o1UN7r9p1gCrDB+2RdI0gHALXg3IWLObGaYF8XvoPdQ8Af6c7cYkk+02w4k+Z0UiaT0yDeDzvrKh3+CFmUHT1gdlC7H4Ys1elBsRyd6hupMOvWtvD5HccgAFFzAMM3hiTLkHXgEn6NtmVRs36bCm6pauMQ+J13CTkAyGjiITJr7XuXyKxl/LiO3HWrBDvUoyCyFnDZQJtvJlo41AzbVIua/guxiwzozQDqKmXmx62Czl/9Av/j10nqc5Q2maRBmVvWapQcePJq4fA6BAO8Xsu6tjX9Fw11I0kqTSaCUKnA1fI/5owLe2cHlXWvMz/o6/llFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhuViuJ2iFvGgcdgNAsWWsItHfAgA2ReEvUmp4C1NNM=;
 b=gpfe/Q/11qbgeYuxoABPviw0vF57XgPRaVe8+z5w1ByHbOvyniP8VOhaevah0k32LsKiIBj9pAHqHcV40jm0il8A4xQWzX24tXrnFF2TzeDT06ehE6MgVDKiKu6iIatn7MfC/r0a4hH3lWlRAFfhySviLs2gvNGwxCQWrpx2BhpjnwVBxLkng9gFtQ2hcrdyrUgSLAeg62XkpCdnla3jCxIFVHQu2JBXe83wtDhf1z6MD02e2jTusdZM5xQSqHlWg7qsiq6UOryWq4A6b/tp6lL543cPG7mdAFmnIP9GswyqEztNqTwanh1IBvoEbNcoetvlOZ/HSodLdYUgEKYQeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhuViuJ2iFvGgcdgNAsWWsItHfAgA2ReEvUmp4C1NNM=;
 b=sVgXp2fTLSpphwM9EC5btmPaiIGhiHK66CGW8FPyeVZZmTGKHbpkYSL7H9oq8gWrYqTtbwCxN9PGlMQVfhnWC8pge6rAkG3rhYhNLOJyvb9EhR1eIzel7rJZJzTlAykUVNHRK58GJnUJXSR/eHmvn5vvdteOLwmw11wlIkJ3vHs=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by DM4PR10MB6839.namprd10.prod.outlook.com (2603:10b6:8:105::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Fri, 6 Oct
 2023 11:39:43 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::64b1:cd15:65a5:8e7d]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::64b1:cd15:65a5:8e7d%5]) with mapi id 15.20.6838.039; Fri, 6 Oct 2023
 11:39:43 +0000
Message-ID: <e8fb69e0-bbae-47a7-ac38-61fd7d366156@oracle.com>
Date: Fri, 6 Oct 2023 12:39:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] migration: Downtime observability improvements
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
References: <20230926161841.98464-1-joao.m.martins@oracle.com>
 <ZR2emE8jdcYRLVUr@x1n>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <ZR2emE8jdcYRLVUr@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0025.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::20) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|DM4PR10MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: 73b8a029-fb36-4a26-245e-08dbc660eee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m4pqabYowuZQ29PsDFKoFKKgKl8Y3oxNS6YNREoWzf2B40svV4KERnrI3CMMko+fA93/VvX6xL9Pom6TZeeU0gGytklZaRGYu974uMER67+2SvcOP0KGMbzGPB+kFXZUk8RC3fEIAkf4vkbVcylPiUEa1oXM+P0gM+Bxr449fQkDeVwi/NubTuGrowbk5SXOCeUs5rub5Zy+btzgT1jDKH7hjlpEawhzHzk4BO/7UyGIMlC1l2FBemP5tupCLzXZXkqviwQSotN0rihv4nPjuVcUv5UsQSSTYW8hSsldgtW9aFSEXVqPIbVzw7S3eTkUZt2HUGMraBCQmHvfVXQjNJFpyUQ/bVw0jtXt85E3D1wVk041q8WBSofL/f/YTfxHAertEIyZm2/P1hcW4s29FPoO2r3/hav6YHwlHMTRb/QkaB9MM/pAOVvk3+L2AMP/cmW+//zFpmESM8fCOxUS0McslkfIxlnYJ1pz6I6qTXrU0UE5ihFdeSpYLxXieMc/YFl7TjteVsV74vtVogOZcYrO1ZEFpodZ2M/j0kEXQlwVUvTJRZo6+svIB7eSfnJUJu35Nae1sUPINqS5iT7CCNOH29skcRlcCMRaIGytTyuZzy8p4biWlUMbf3aUFN8LlTaflJGXYDP/oOIyxA2IAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(396003)(136003)(366004)(39860400002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(31686004)(107886003)(478600001)(53546011)(6666004)(6486002)(6506007)(66556008)(6512007)(86362001)(31696002)(38100700002)(41300700001)(5660300002)(2616005)(26005)(54906003)(83380400001)(36756003)(8936002)(6916009)(4744005)(8676002)(4326008)(66946007)(66476007)(2906002)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak5FRGNPOFZmcGlyblAwWS9rVEdlQmpBUis4UmtOdU5rcHQrK0JDNGFzalRp?=
 =?utf-8?B?UVRNWmp0dlMxNkh2VGtKVXU4UnJ5T0pheFNYUkI0RVNRVFFpdHZKS0F3cklz?=
 =?utf-8?B?MTBUbHlpMXdsTUI0dUpndUFIYXRqZXZrbUJ5aFJULzd6S3RVTmxJQitsNnZB?=
 =?utf-8?B?S3U0VkEvZHpJUVhsRzlKWUlSNjhHTjlGcFBaaUxjdWJqdXFOWjdlbzY2cm9O?=
 =?utf-8?B?VkFNWUhWQXpFYUdGNHRVdkZ6anF6TlJqRmZKVWNaaEZDaGdaVHRVZ2xQaUpH?=
 =?utf-8?B?SVdHT2p4bzlJSE1DSk9mZnpRN05UK291ZDl5YThqcUsvaXVRZjRVSmFhS1pV?=
 =?utf-8?B?YStENXJFY20vQ242bjU3ek9VRmxvSnVscEwyN2EyRFRvQlZqQWdzNUVjV1E4?=
 =?utf-8?B?bGpkeXFianREdHhqNUlEc0dKeWh5cGtpYzE5cjdZUEhHK0d1aDVFMjFxK0o2?=
 =?utf-8?B?VjExdmJZNS8zRkN4Z3BuTHZvMmhSaFF4WUFHbjhaendQY2xHUkJxcDN0cWto?=
 =?utf-8?B?dmRmak5LWUdSak9Gd0NadTZybkZ0eWthOUhRalpTQjdQdUd2ZFRBVCtNY053?=
 =?utf-8?B?QzdaMVc0b2cwN1pyRXhSaUpveGdBVytvdVRaWWhGeSs4VDNhcWtudFRZMml0?=
 =?utf-8?B?V0ZHTUdVMDRzTWV2QlVTUWJRQ213NWJ6cDYyRmpqR3Z3TEtxaVpxVWNnMGZI?=
 =?utf-8?B?OFZscDlMOW50TXlSSTdVM2ozeFc0TjhWY3BqZm05SWgzV01RWXhGTnpJaGRr?=
 =?utf-8?B?Z1loV0VlWGZ2eTZXeURRMVFSUWRBUmNhbElERUxMNEZxekxuL29QRG1WOHdE?=
 =?utf-8?B?bnhNTFV5c2NaRVo0QlpJL3R1Rnp0RnEyaDVTTC9zb25tU0hXdGxOMWtPdVNM?=
 =?utf-8?B?VGZmTm9DdkNnRG1LZEV4aFBJaCtmWFBKNkMzcUxGbklhdUwwcnJzY3lxN1c4?=
 =?utf-8?B?Y1ZSb1JMVDdTZnh5NG9vMmhaYmxoN3lrNWFJS3pZTjhXZ2lRTGZ0UDhHQnM4?=
 =?utf-8?B?Vmt2R1pLNVVJU2d3SUJQVXo0aVF5c09CZWUxcS84SVNaay9xQzRuU0xaaHNR?=
 =?utf-8?B?NFNBN1JINVMzQjZIb082QXBlTXhaREZwNzBSYkI5MkpiazZNcGlpTkFtT1B6?=
 =?utf-8?B?cXpXdzMyR09LUlhHem9GMW9ROUF0SHkxcW5EcEsrYTBwTm5HNmtDUUpLOVRt?=
 =?utf-8?B?TUFCMTlxNUpvdTBnaitYWnZ0ZnZQdVdTS0xnQVNDam5uMmswTFNLZkc5MFZX?=
 =?utf-8?B?ZHk0Q29acHpub05qMEZ0VWdvZ1UycDd4a1g4cExOZGVSMmIvU3Y1QU8rREhW?=
 =?utf-8?B?TFpBNVJlQitpcFJpVms5c016OW5RNW9LOXlMUG9RTlFLeFFUdlpJdUdBUGNR?=
 =?utf-8?B?WDBnSlg0N1JMZjd1RlkvcWxlNitod25IK1RCN0Q1TlFJTlFHeFVxYTBMTHh6?=
 =?utf-8?B?cWVHa0VUTENtaDhJbS9DeDFGbklKei9MZjEybXdSdHZKSEpTRVhUajduai9p?=
 =?utf-8?B?eXFIZ0F4SzBobTlHYWlSUncydEVZck0xdHAzdWZUaXNuVkZoL3Z4QmJJbVM4?=
 =?utf-8?B?eTFzdDNNTU53cS93czRYREVGMndDNzJ5UTMrZUFWczlJMWJoaGQzazNhZE5S?=
 =?utf-8?B?SHVhTjBQeFZDaDEzdTMxd3F6dFVWTDJBRHJTeE9vVTQwUU0wM3MrYkQ3emc1?=
 =?utf-8?B?MGRzSlNJMFAyRXlQNndkSXRmWW1URWlmNG9QK2x3Q0NvNTVsYWpId2gxM0R2?=
 =?utf-8?B?S2VmS3ZuajNpNmdsWUlSc25KeitKSWk3ZVp1Q0o5RzhNVGpNOGQzQkdrRmZv?=
 =?utf-8?B?VmVWWUhlNmF4cmpFdVBnSnVNcFF1SHZmTHhnaXJnOG1COEV1aERVRWluQ3ht?=
 =?utf-8?B?TWxzZDlKbTF3NW01Um5wYm9GeW0zYVZ3K1Z4bU8yc3M0Y2xJdS9jcEs5dUhE?=
 =?utf-8?B?NDBTdUpHL2JwWjBtVVZ2QklIZThIMjUrSkR5Q3AxL01yL2R5dldlZmJuU3pn?=
 =?utf-8?B?K01EaVFicUJWRDM1a3JMSUdXRktWK084V01jUGY1MVN0Zy92K0NtZi9KWmxC?=
 =?utf-8?B?aWFqMTVFckk5Rit4Tm1LRDJxclJVSHQyeTcza2N3L2ZOdHYvOEphbWxudmE2?=
 =?utf-8?B?TjI5cGVCRVRJMTF4a0xCOWVoekVKa1FjRXRKMVpheG11NStiSDk0eGpIaGc4?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cwdWWk66RLsrNMQKO3GnQDwAgQwAY9bCe63ZDBE9cEvbTygMDt0GMNySja6YMMHAOF2VjCQFzz0FaMpmL92PbEifbQEVuCY9jZTLcDozIxLzz9cSvWCM4KsAohOa3bN2XGcptUH0Ol0sBCmMvam/ra3hJzzHT4YjSjRRl9K9ocIMLl9bjvEwHDV53q3964Ax/rJgQYlF7d3ujuE3BbHzlGA8c6jSJz7LEJIiIGP6/Rt4a2aHNCpp3JEFiKapxjsEao6wQLIHK3oompHWfMW0YmM+9PASg00L+cr6YTZ94XHdnoftKBxz6YAhTyTCnKuLcqxdK73RTvKJ/BT0xSvREftMwzX59z//b79q7kQ0qovevzXJev6ca1jluwH4f6wo47STmQuWn15OhtfKkKycTu6Xrd/NsZImEt72Mx0Y8Sz7g3gC7wGt9qRI21/3asg9uzplkPOzMhSfSv7pHh+r+Zjynvge03IueI1aavSqmavzi66BP0yk3js0F7bXaWvmAWuNaLW2t+PPOBS63CdcgqBvX/+4o1WzRZHC6WQ8aV8CCk5MDmra0i93dvRY2y08IvJsDZeFgJTy8EyBFd5W64TAgLkugzso2JHyoWjzj1ny1dRLPV4RAl1LVFcH8yiVrwhu5SO2WtXrlpUPrna9WrWzaw7U582DagGYkxfKV23fVh8KQ71/JXbajCRlP1SC/cnY+lBLIUgBwjFDrV6JvurT3zcMzaVLXcWbIKbmJTDkVzsm2Tpj1YaIdD2iLSYqYj9Ysaq+3oS7VTXVHvKWSXLCatZKWi0p36qzaIWMjNnDedSg8sKB4DDfVNc/wHhJ
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b8a029-fb36-4a26-245e-08dbc660eee2
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 11:39:43.1694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gkAv8TrEUDNnT/EQzbHViGQA7kShahnVbMUWCPNCrSJsT0glphl0v/XbJ3SSsMJgddP8kEWnI09z+KM8oh1IJYzFIsfh0vOkI1sR4dDxWbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6839
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_09,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=844 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310060086
X-Proofpoint-ORIG-GUID: pf39yk8MqXEz1GJWFo5ajlQgtAOUFNpY
X-Proofpoint-GUID: pf39yk8MqXEz1GJWFo5ajlQgtAOUFNpY
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 04/10/2023 18:19, Peter Xu wrote:
> On Tue, Sep 26, 2023 at 05:18:36PM +0100, Joao Martins wrote:
>> For now, mainly precopy data, and here I added both tracepoints and
>> QMP stats via query-migrate. Postcopy is still missing.
> 
> IIUC many of those will cover postcopy too, but not all?
> 
> I think the problem is postcopy didn't update downtime_start, however it
> updates MigrationState.downtime, and probably we can start to keep it more
> like precopy, e.g., in postcopy_start(), where downtime_start can be
> time_at_stop (or it can be more accurate; now it's probably fetching the
> timestamp too early).
> 
Good point!

> Basically if we want to expose anything, especially some qapi object, IMHO
> we'd better make it work for both pre/post copy because otherwise it'll be
> hard for mgmt app to know which qemu supports precopy only, and which
> support both (if we'll add that for postcopy too).
> 

Yeap, I totally agree.

