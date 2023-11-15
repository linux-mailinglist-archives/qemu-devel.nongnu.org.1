Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 260F57EC8FD
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 17:58:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3JCO-0005Nu-6W; Wed, 15 Nov 2023 11:57:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.christie@oracle.com>)
 id 1r3JCL-0005Nf-H0
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 11:57:05 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.christie@oracle.com>)
 id 1r3JCI-0000Q2-1T
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 11:57:05 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AFGZoPb009764; Wed, 15 Nov 2023 16:56:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=e3N8o/9iLAk3tcbMbQKCPnIKML40zEmSLjGFBvsf8zU=;
 b=D+K/KPhRKZJJvnOGnq1bQjMIchMhwtoYGmmwbIRSVim4XBZf2MT/7dqB9rzxRnk/sxRf
 VZF+RRwSlXBjfxG+GvAULNl8kIRs+9bwbh+Hye7s44k4Ytz2JhAtulEI30aE/8BwmXRl
 CnKHb4WZsGCP/7AU/OpstWoqqY7A6W7G7yphUTAaEpEVUVgTx2ekwdL8N01FKWQ4Oylt
 e3nHKoO2AFmFMG9CbUaDC+5Qsk5STNG6m4Wl9QUUdNyl+YXDis5EkM8M0xtRCbl5K/sZ
 j4ZInO+KoalJCK2zEpGvsgaBZF4aQMVeNh472sp0uHtsWTzw5T2ZGZUs33jGJiNJSfGL rA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2m2h2tn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Nov 2023 16:56:55 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3AFGNG1B008898; Wed, 15 Nov 2023 16:56:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3uaxpy5tfq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Nov 2023 16:56:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=haP87q8OiygTy/5Y1ZuJz2IqtAGTgj2Nf84tB/XH/qKgy4xUWIWGc8BiorR2xkRwk9TtkImMTqhDCndHG8h6jcZE+fPwfOOd1SZF/Lxb9bWStTN87NCqg/0bVPkabWhhuhfaL4sgcQrQDE7gatxR0cCTPZXrr32o5Bqk+MLN/2PGKVYGp/hQ9HTi/+/AX0KNvPouSE+etpM8W6TePQ6hackj8TwUhW3gdSWhVc3Mz36bnItj54VMB4XNjuPiXu5rMpxtdzoLH3mdZAQ73rSRyyNhU5XZ2uJuTYPfXW7MHJsuSSLR2NpoYYOTKVBUkvC7iyqu4suThh6ke4eFZasezA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3N8o/9iLAk3tcbMbQKCPnIKML40zEmSLjGFBvsf8zU=;
 b=LTh5xhaSYSkYa3WMJvDKX8u8IX0dfGs6PWbflNdYlarNZ33wWFtvNAs7i3mvWKKGobbTwIBrVt6jwlxu127yvNYzcKiPOKK/N+Cf2Sf04o4Kj141JY9cM4D8STCpLNXbIUHAzf7/6ufTCtdi8Nz6bC1rG72tDi5CIirbNrJmxRmUVrN9W7OJVU9zUpV+mPDiBisyi3zQeykV5vpNLw0wAehZ74So6moM/XTqWPC1jI3V2QY9KdrEPbLCEmbs8o1fCH8FO2jwN6YLuyuy9DAhcg6uoe/IPM1he/GUiQsfRxDXYMsr6lNsgximmP7lDO865yL4rpoy3kcwBIiPsVx9sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3N8o/9iLAk3tcbMbQKCPnIKML40zEmSLjGFBvsf8zU=;
 b=rvuna8OetN29DKvdmdsOiwDdB8hcKSwV66tIv7U32AaxRgYOh8qbtoKgfAA77wXCuyhorxd19icFvcNpJS9VWMMuQlCSQed9GfVrUiLZiHbXjxq7+zf96UdCDBcTslTbNOpNhDPX8uo8IcJdOkTuno73BwQvmL33Vy9ei3vTMSQ=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by PH7PR10MB6178.namprd10.prod.outlook.com (2603:10b6:510:1f2::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 16:56:52 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::449f:4fd9:2d3e]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::449f:4fd9:2d3e%4]) with mapi id 15.20.7002.019; Wed, 15 Nov 2023
 16:56:52 +0000
Message-ID: <04faa337-d0dc-4683-a05f-2dee0dea0eb4@oracle.com>
Date: Wed, 15 Nov 2023 10:56:51 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] vhost-scsi: Add support for a worker thread per
 virtqueue
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Cc: fam@euphon.net, jasowang@redhat.com, mst@redhat.com, pbonzini@redhat.com, 
 qemu-devel@nongnu.org
References: <20231114003644.7026-1-michael.christie@oracle.com>
 <20231114003644.7026-3-michael.christie@oracle.com>
 <bucsvfqgs73w73tt4l5z35smccpebjq36hcozpgrkeydm3jumj@zisakm4noecq>
 <20231115125718.GA301867@fedora>
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20231115125718.GA301867@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0060.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::35) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|PH7PR10MB6178:EE_
X-MS-Office365-Filtering-Correlation-Id: c4135dc5-1f6e-45ae-da36-08dbe5fbddcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NzX6ltS7Y6RAOey6hfCy3AGtJ5ieOHylkXF/54iKqmecULY3TioVdqI8Amzd1YL0JQytGifgM7NQ2MhvbC+ce9/BHne3DYQIxx+pGXLvn4RGnYyxqWM6/9JYmHyfd7stQ/vwXlNK6yXy0LRrCtQfy44wkYdFRSXfyOEqfIlDx8qrhVFPS1ipZRyxtCuI32hX7F7GGBNJzNFCmVMyrBCx/pEldVAWB0jHP6fe0evZKmKQFsc/PPTnFDZpaqDR376MYVG2Vk9jwkTdvkDZdAf4HxPvQfYoxj3ujylYA7iGlY+GBCKKtZLv47HQhiewn9WGIdX/3lfA3HAr7sPGehaY92MpMtEj0NQFO+aGlYhcuWeB+mB+zhZoSeZUA+8QkB4C/5KOUiFSKi0kS2zviwC12Q0i5eH8o3x1fYV3DGYuQUo92Ql+8GsfMJjQTv1sJhpxAOSQVCP8msPQH32HSC+qfldMg0jSkPmdpnn1J9eWpjLZVMvIciNhpEILh/NH3MOHzAlTn3YgB0RZzbSv75OD4XYiT6kd+xxQknvWQWuoRB2DKN7ZEtNj+5XEn5gVLRPnZKRPUJB0anGtZdYl3DozsvHDG8mPoqRwCTwuL/tw9fNPmlNNNeEl6rPXvRnrCQRNBLbJEHaLDyx8BSIgy5Bmww==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(376002)(346002)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(8676002)(31696002)(4326008)(8936002)(2906002)(26005)(86362001)(5660300002)(2616005)(6506007)(53546011)(6486002)(36756003)(478600001)(41300700001)(31686004)(38100700002)(316002)(66946007)(66476007)(110136005)(66556008)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1RGMVd0b3dmQnRmY2hPMDBIUmNxT3NJeHpaSG1jN3R5UDNJUGZJN2Rib3l5?=
 =?utf-8?B?ZW9ycmpyMkdPb1JUaWE2M2dQWnJxblp1aDByd015WUtjWFRVY2d1UGhOWkZB?=
 =?utf-8?B?dCtCYmFHWDM2ZHFJWWZYY0VQaU9tVEpTNjQwL1RzdkJENVlPZTdBOGNWaURy?=
 =?utf-8?B?OHpGd1BmYjhGdlFwM3QraDZpLy90NktZQS9Cd1c0bUw4RzQyNjJ4bWlLOGZL?=
 =?utf-8?B?S3pHVVRjRWI3WEdTQndSMCsyRjR5RmQ0Q1ZvR3R0TGczcFZPN2V0cEhjVURk?=
 =?utf-8?B?RFVyUDVFb2l5ckV3TXFUVWRiNGoraTBPV0Z3MVpmSmpCTkpNSjkvdnBiOWZQ?=
 =?utf-8?B?SC9XWllqSlI4c3FReWdYUW9KM0hKbjdVZ2hBRUN4MStRSEFScW4zd3dLeG9N?=
 =?utf-8?B?UmVhaWlkMzhCaEk5bm1vOS92M21KL2RzQjBzZmpMcThqc04wcE9WeEViWGpS?=
 =?utf-8?B?Y3o4WWVvajZCZCs0Y0lqVXNKbStHWWpIa1lZOTlITEtGOHpxYjB5b0VWMEUz?=
 =?utf-8?B?cDFuUjhwTEZOKzllTDFhaUszMU5RRGh6SEhxZko3cVMzRVRuem9rYnJvbkRS?=
 =?utf-8?B?WDMrd3ZGQ1Q1KzFQSW0vOFJFSHFMU2l0bFV3blB1UFVQZjlWV0dzbktIREZy?=
 =?utf-8?B?VVh6eWp1MW1wOTgxNkFzUVArUkpyeUljNWpUTElKUGEvbWFEM3dqTnRXMWZS?=
 =?utf-8?B?NStZcElEblAxQmJqblRKd0ltdExVOFdYaFNVT3FyQkhwd1FIRHgwVzZXZldQ?=
 =?utf-8?B?dGZZTjcxNXY3eFJWZ3lVVXJpWTJOUEd5dzZJT0VvQTkzMmxLQVkrZFlrM0Ju?=
 =?utf-8?B?d01aNnVyQ3F5anFXNUhnVU5ERFlKZC83TFVCQkVQQnJJWXJDV1IxSi95ckJO?=
 =?utf-8?B?eG14ejlBNmpjWGtzd1E0ckU0L0d3a080bUM4Rm81RlFodzYyZG4vL256WFV3?=
 =?utf-8?B?YUdFa0YrcWxrQ0NBNllBOE9LN053TUs5QTJIRmNkY1Z3bnBTSHBuRTY5dU1X?=
 =?utf-8?B?M0hXQmNGZlVQTjZlN3U3K21ybW5SeG9ibnpkRUpKREIrYjdXaGI1OGh6bmZs?=
 =?utf-8?B?cXQ2eTZtWmR1bUc3K3JTRElCZlJMQ0gwWmNrQ3BGS3ZMdzg5RkdJcUo4ZUo2?=
 =?utf-8?B?YXBhT1JYWlRxcXJ4WEI5MTlUcHExTGQwb05vdTdsUGE1WkRja1lqOWIvaENu?=
 =?utf-8?B?T2tmOTM2WDV2SFp5N00rYzlmVTY3MEhsUG1IektkZ05JbGVtTUkrSjZnM0px?=
 =?utf-8?B?dTB5V2FDbUdsOW03TFZmYXFxRUFSUG0rTHp6aFFFeDFleThPVk1EdE1aN3Bu?=
 =?utf-8?B?NzNwY0hjazdlOUEveUkrdFh4TVhIRkIweUliZWVTZjdtMzYvMVArSTJGT00x?=
 =?utf-8?B?a2VnQjJOOHJvTVR5eFJhNWFJMGtDTHdNMWl4Z2k1Vkt0SytRQXZ0V1ROWnND?=
 =?utf-8?B?bVdPc3NqMFBUbmQxSzdaSlN4MjUrVjJkdHY3WWVPTlhUb3NIOGpSZytwZDBD?=
 =?utf-8?B?WFczcVZqTWR3bnJ5SlQ5VkVaa2RDN3lBclpyTWZFR2VMMWMyMEFObnJ4dkJZ?=
 =?utf-8?B?bkdoWHJlcWFoZ0dxL3JrbFRqRmlMQ3RWNHVhV1kwaU5mNmxnZy9vNmhaMXRC?=
 =?utf-8?B?NDl6cTJ4UDQ4ZFB4SzVqTlo1OGtTN3FzU2RIeFFJenJrQUc5em1JWlA0bzRT?=
 =?utf-8?B?Skp6Z1NiKzl1aHVxTnN6V3A3U0o4dlVhbkMxRXVPWkFEWGdSSzZ6eE5hZE9W?=
 =?utf-8?B?TUR2eitaMGlSeUFoUkJiQ0pMazI3b3VmOWFNdGFpTmplOU13VU9IRzFEeHFQ?=
 =?utf-8?B?b1VkRDVDVk9KRXg5Qi9PbkFYZG5YWi85b01CVlVrZnhmY0ZHZVhvMXlDVVU5?=
 =?utf-8?B?QzB0YVFjelhScDhVc09rUXlsU0pyUVQxaXJMUVhBZXRqL0tjekk3VUk3K0FT?=
 =?utf-8?B?UHNTOG1TL3lYeHZoZllWL1dHVnQ0d3ZjZDNoY0xaT3V6N0FBbi9RVTNTMnFZ?=
 =?utf-8?B?dkJ6Y2lrQW1EYXBMWXN5L2JmQVFmODUrSUlpTHkwdG00dS9CbVRzdWpFc3JT?=
 =?utf-8?B?dHlIbzNHM1g2ZFhzcmdZcGRWU1lKZjgzeEwwaTRyS1FwaWhoaFpTbUkrWEh6?=
 =?utf-8?B?QlFVMWhGUS9QN0U5Y0ZEcGQzVTZQWjVVaWhIWGVKZzYrSm55UXExcHowYVNn?=
 =?utf-8?B?VEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Asr42giw2QDSUKBesQHXanOOY99x9NOodmVXdsOsWekVrXRY20arUOWc+PyoEYdXkZv6hxYclim5hU5q8L1piiknCiwVB2CZ2/7HtYeA5IN7RFukjaHdwUYVFgzNXdKjSED3Zh39ih7h69QJeWKXSQCGscNMKdBxQYGTh8fMevhgoOFPb0raTcM3/MUUH/qrMSebRUrXEPCpd/qdUsDAqoVJxDbTm7sA2/LJuRExN7xIKx/unnJB5UwgzTGM/sm8pXaRWd7WiU7nTGSucjHU0pNwjVGaUEUsASHB9zWQhqOSP31mvYwB9KkTcuYaHJWds1SUltX1CtTyItkluyhW1ju9PfrK/jx18cHwS2ErMJuuLpj4lGXGSg6jfuol+XQoZezRLbIvwstPASQlV6Vn/HTpkmKTiJQNPyVaPjYHSbMHfEJknDv41+nu/DWw0IjDL7AQVroMdiHtUdbWQJDBquagIc5RjtROt6ZYGwNH8F0Mi2gsFcwVF40dOkJ4oE3lR2Rslb4BNEskAqaoijN2rPOIO+dE7GyVZrAZi8HuHoCKpBhdtA8eUIinS92DwD2hLGzQ37S/iIkhaOyZGFQJe1AkqwrcLSah6Dawz8IEFHUsyspl2yVUuhHUrgHmGG1TH5QTHxK0z6VuH3P8Xy/M1NjupbdfK2qsxNQAbgUR5qbZcPWlYkJokcGAJWHWkBxkYqiYAt+UckTfxJoS2uv/Cx9l3U4LgzHJU7mN0MnDnzP/akPKhHL/4zzAqPyQwzTe2PmGV8NmevnyScsVLhYhhJj0hvGs9hxnELdY7InUspfSAX+2E74Z54Y9MI1ygXwp
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4135dc5-1f6e-45ae-da36-08dbe5fbddcb
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 16:56:52.4752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0WP8F3gn3wAwkm55D3XYLIMm2h78tChKiJTVPu68z/ND9I7zbtgqQ920TY0JP358RKnrn84V9X3nqQ3mdqUyTlLJ5Cehe7XUSsHJijrfhb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_16,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150130
X-Proofpoint-GUID: JMpR4qzXEwvZzf1v78vUcKCZYV77NnbV
X-Proofpoint-ORIG-GUID: JMpR4qzXEwvZzf1v78vUcKCZYV77NnbV
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=michael.christie@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 11/15/23 6:57 AM, Stefan Hajnoczi wrote:
> On Wed, Nov 15, 2023 at 12:43:02PM +0100, Stefano Garzarella wrote:
>> On Mon, Nov 13, 2023 at 06:36:44PM -0600, Mike Christie wrote:
>>> This adds support for vhost-scsi to be able to create a worker thread
>>> per virtqueue. Right now for vhost-net we get a worker thread per
>>> tx/rx virtqueue pair which scales nicely as we add more virtqueues and
>>> CPUs, but for scsi we get the single worker thread that's shared by all
>>> virtqueues. When trying to send IO to more than 2 virtqueues the single
>>> thread becomes a bottlneck.
>>>
>>> This patch adds a new setting, virtqueue_workers, which can be set to:
>>>
>>> 1: Existing behavior whre we get the single thread.
>>> -1: Create a worker per IO virtqueue.
>>
>> I find this setting a bit odd. What about a boolean instead?
>>
>> `per_virtqueue_workers`:
>>     false: Existing behavior whre we get the single thread.
>>     true: Create a worker per IO virtqueue.
> 
> Me too, I thought there would be round-robin assignment for 1 <
> worker_cnt < (dev->nvqs - VHOST_SCSI_VQ_NUM_FIXED) but instead only 1
> and -1 have any meaning.
> 
> Do you want to implement round-robin assignment?
> 

It was an int because I originally did round robin but at some point
dropped it. I found that our users at least:

1. Are used to configuring number of virtqueues.
2. In the userspace guest OS are used to checking the queue to CPU
mappings to figure out how their app should optimize itself.

So users would just do a virtqueue per vCPU or if trying to reduce
mem usage would do N virtqueues < vCPUs. For both cases they just did the
worker per virtqueue.

However, I left it an int in case in the future someone wanted
the future.



