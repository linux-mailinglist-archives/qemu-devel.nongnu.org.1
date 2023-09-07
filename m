Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CB7797346
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 17:21:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeGo3-0000Ht-La; Thu, 07 Sep 2023 11:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qeGnz-0000GU-VG
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 11:20:28 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qeGnw-0000ns-14
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 11:20:27 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 387FJuEf010713; Thu, 7 Sep 2023 15:20:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=sQMF5laxKu+THbPFb4WU4KdIiMIc1uv9HzcO/4LaP24=;
 b=aAScLmvVfgz9OcvrAR1i9e7SFZ6LykyvcA2ZcTlI/yHowT5ShZt7acSb1dbtCNacodYY
 tHxgqerU7c+pVWVKwK8+gqeDLqloFwpQ/6QvCxpG+zwHqgKBZJoVG97pXcb2B5oS3ZWM
 4MIaoDkZWogFM8Va69Z0aheejJA31qy1YcCrnHlQUGyXY1miX+MLnQLnmFKdJjH4bPCd
 m3Zkx1upW3vuCLbHQkXmzRzLudqHnzXV6+jm3U9Z95Ry625SrMyI0rUFJRCNwBHqXzbX
 fAUjyO0JYdok5lkBTxqRrjXpQcAdamHkvSev5rdQocJt9+V8v2bulT3fUubWH8Mpj+Pg fw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3syh2e0015-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Sep 2023 15:20:16 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 387E4TYu005050; Thu, 7 Sep 2023 15:20:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3suug7uvrf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Sep 2023 15:20:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C01QNCP5ibduD0q6yQW9VxjTm4uma+jq378C5k48Ju0uHS6d4ZjTb6B1wWGbB+7W80Eqj8dNAqJv9mbRYPbRTpjCoR4YUIajxelI2o4K3kjWQQTuAn9hSnTxci3C6Wg456ZD9CPg0mz+e0gyO6SIetNN9taGRd2wL8T9sa7paKqNQlMhDMCAZwIGmsWd0J/8m5L6Mvw3Y41zFaVKFvFlfKpY8rKCQPV4o6GMaSEfn5Wm28v6Lu6X8FXiftRKeCil4GJpYQQhftvzTIBr1EypQ8WROeIa/eoE5ALBpnlLgVKw2XxkmCMPsBeXoact3rY7K6snNEvq61Mj8QyMmyiTNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQMF5laxKu+THbPFb4WU4KdIiMIc1uv9HzcO/4LaP24=;
 b=atPVfQ010hsyvgE/j7YMPVReCQA9li+mhLJS9oQq0y/xLS0tS/vLXX+cg6nvLf39M8t3cGtltbYRXS3buMLxo+g0ghHF3rz32mpUuvf5LrLHuldBHu5B0YdrC6G3szi9bTtdy7ZbkTxJlBj5v8EgoXkXF2uxetsP4yleVSXIJ+kZwMoJoV+bCFVUpXFwj0gTVrwtttRteqkcAIJCFj3Hw64XdoKteXqOwo6ZbJJmEzSnWcCeAET+k2TBwLwlsfGpriCpJ+EYC3OfgVWAj2A2+KJP4jdKxwefPoKbdSU6sKH8GGshG6CoDBGXwZQS2pJHr772YwsMzt5JtJUAWftQ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQMF5laxKu+THbPFb4WU4KdIiMIc1uv9HzcO/4LaP24=;
 b=VlmdLPqzYGiBW3f2iq27qPUB84nSLe6A8Ri8z+HsurgWkBPbsK+nLSjvPWqoRrITElm5mMNMcvaKkK5OMZvGOW+Ou7xHgqJWyZZu5TviPqr3AAABpQb/l8VMxxdTsFAj73w63/8pL5zeZY4eSv85auwNbQVOht+xI/c2ty4i2Nw=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by CH3PR10MB7188.namprd10.prod.outlook.com (2603:10b6:610:121::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 15:20:13 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67%7]) with mapi id 15.20.6768.029; Thu, 7 Sep 2023
 15:20:12 +0000
Message-ID: <e8c32135-1840-46e3-105a-26a6e7a84944@oracle.com>
Date: Thu, 7 Sep 2023 16:20:03 +0100
Subject: Re: [PATCH v4 00/15] vfio: VFIO migration support with vIOMMU
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Avihai Horon <avihaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 qemu-devel@nongnu.org, Yi Liu <yi.l.liu@intel.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
 <48540cac-769f-c092-a98e-e6d8ff632559@oracle.com>
 <d5d30f58-31f0-1103-6956-377de34a790c@redhat.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <d5d30f58-31f0-1103-6956-377de34a790c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P192CA0025.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::19) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|CH3PR10MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f0a8f6b-80c7-421d-11f1-08dbafb5ee5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3FZ7qqYGYheMqfTvEZX2oaiI8WmVk0CSTXN2371ghA+MAidRdoevvyLR3/+9ne+t8J7OQa4mNgDLpVGhFXJ1sCJOLF9ROO19E6WLI9lNKm1c9afK51HKhpkjopYUxIpzF9sYQG0D0Fa92FNCTtQzZyjM/kC5h24xSs4d2ZxTwN/jfAOtLPHr3ZGoO9FJ8eK9Q5IImcbLt04ze9vfkx/kv67RuGuiFQ8zm4cypYuJFjYPfvCZCOeqIip8i+ivwE/na2sZlbz+fwQAVUKNuVNW/VK0Rfdz9twdTaetVl03RLR3mmj+CHt2AMhy3/P4bmFEeYPs8B1dj1Ah+e7rivudN3x8oD0Y2vsQaAtr/6+XJFjn7pKrt1AeT2nFUaxQxG9q3L+6Rr2nr+YO+BzfO93vcvaZg28fQMIFZQIQQsPuSLPJIie1Bau9YeydxSLsRK0jTnA48oCEJ+4p0lSW9f9Wz1glKZ/sBRwroTgg2Z7EubeEEt8g/fr0FODrV4EOJAcHEkjJKDHJYQTuHJaP2poKFvhYo3zYTU8X/67T8Wfy7j76iliaLqTcG8Gbd2D0NK7BYukTk8fe8idCOLc3WS1S2tsK3nRHHdN5CribLpZydluPpo9oyUKaffgud/3kd37x
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39860400002)(1800799009)(186009)(451199024)(66574015)(2906002)(36756003)(86362001)(38100700002)(31696002)(66946007)(41300700001)(66556008)(66476007)(6512007)(53546011)(6506007)(478600001)(6486002)(6916009)(54906003)(316002)(2616005)(8676002)(8936002)(4326008)(6666004)(31686004)(83380400001)(5660300002)(7416002)(26005)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2wxM1laZC9zZ3NMc2psNDRKcmFUdG9YRHZ5VzZaTk9NVEpMQjlpZ1JEaWtF?=
 =?utf-8?B?ZUF6RHFIVVFmUUtmNmMyUTZHYVZtVExZWkpFRThUa1EwME9Ec0dzNVJTak95?=
 =?utf-8?B?cDhKbWhIS1ZHeE8xSHNkQ0pvVlV0a2s4V3NmV2JHeXBaWGJPVnhGUXdiVFgw?=
 =?utf-8?B?OWNmYkYrclc4Ykdhc1VDTFVUQ1dTbzdPUm56bStqb2NtYUF6OU14SElCSldu?=
 =?utf-8?B?TUpEZlluUzBkZXNDSnFNVHUxUWhmKzdTVUNubGpXb0dsVkFVcXRFTWdiWUdL?=
 =?utf-8?B?ckRPMXRwTEdXc2JFTlpPZExhUTF2MXVDblk2cWtDSDZ6U0djcitVTUw5MUxw?=
 =?utf-8?B?NTJPWmgrTGpNbGtsV3o3MFhrTEk2NGpwMHFmTmhxWVZlMjBOR2h5SGpJMHUx?=
 =?utf-8?B?cy84SEJRN1RqRmlpb3JiYlpKVHBHcjdHRTlrcDZPQ0RnM1NaUUQ2dTlESGRw?=
 =?utf-8?B?emJjM3lqUnZkQVpCSjdlMndVNS9EdVpUUzJiaFpLNkR4eGNVWW9NRFhHc1BO?=
 =?utf-8?B?aVFLNWFzLzQzNE5jWlhrN3VVTTBuL0tXSDV4WXpWNEJMT2F3QmRRRktrQmEw?=
 =?utf-8?B?U3dVRUo0ejZZeFFrNU1BRTRCK29qWlpIR3J1enBPK3hyWVNBNGxGYWptT1Jo?=
 =?utf-8?B?V3dENHAvblluT010N29vbW1nV0Rjc0xmaCtUQ1llSDhHOHBPamJnRit3Rjlv?=
 =?utf-8?B?blUzRUZJY2sxbGYxcG1NV09aMFk2Wi93eU5XNm55cGJKZ3o2ZlZhdVlQNUVN?=
 =?utf-8?B?OVRaeEdEcHNjT2YwQklwTS80ckgxbTI3ckpGbDdRZ1FKMjVBL0UvUGNwakVz?=
 =?utf-8?B?MXFmVGFDUk5MeGtiYkdRNkdGNkR5UkdBQURWTE9vM1d1YnlpLzJWNGZOL0M3?=
 =?utf-8?B?TzNFaXJMRCtsWWxrTzFPZ1M3cmNJRzZ6VkRvemlzbk53YzVBWHdydmJxbHVS?=
 =?utf-8?B?Zlk1eHdWdGVFaUN4T2UxOUV5bW9JdklOTXFYOHFnTVRqMjZ2VzBqdGc4bmtp?=
 =?utf-8?B?R0o5MEh6NE02b1NtL0NvRyt2TlkrVVpLaHVpUWtCMmNrck5EUTR1L2J1SEhW?=
 =?utf-8?B?RHlHZStxQWIxdHNoYWZDcE15MG1KVXB0M1AzT3NDYXlnQ2NCWGpLR0xMOXAr?=
 =?utf-8?B?WWNwblZlaXd1VmhJNGR2WjNwclRUL2hOUTVpOW5YczdBUm9IQXhpZnhSNkwy?=
 =?utf-8?B?V3g2RFFCMzc1ZXVyMlFKNHBrM3ZUR2gzYmtiQ2ZvbHQ2T1IwdU9GWWs4SXR2?=
 =?utf-8?B?QUZ4NzVoZjFqRU5NYnpSOGc2dlZ1U0VVMkdFVFFkcGNMYVo5UnhzRjRSazNu?=
 =?utf-8?B?MlJ6ZC8xcDd0cVhlUVJaMzBYNlFWVmtwKy9NK1lsck5WZG9wZlVOMEJYdHZ4?=
 =?utf-8?B?dXQvTlVkUGhKQkJIM0JrMFA4WnJrQzhWRkk5Y1VTMzJCMVdreTkzME5DTXR5?=
 =?utf-8?B?R1BML0VKZkNoZmNuNGRzZFd3ZWExK3lVeXVOUGhMcGhJang2OEJGSUhvak9B?=
 =?utf-8?B?YUZPT21JRUlqMDBzQ0gxZmRxdnJ2aU05TlBHMExjdFkyTVRmRk1VeG5ERUlt?=
 =?utf-8?B?SGx3SVZSSExDc1ZkdkFnalArMVpwNUZwaUNSWGVPdHcxQUlGMHV0dXNKQnpo?=
 =?utf-8?B?RGpVWmZsNThKdTVCckFBdVk2SHdaanVHVFZoR0lMcjgrSk5pWTRPZ09La2Fw?=
 =?utf-8?B?TUJWbk4xMDdSZ1MxeDdQK0pyNGVVR1RxdzIvZlNBWm56OEE5eTA4WHJtaFcz?=
 =?utf-8?B?UnI1TWVxVkk2U3ZSYW5PakhDc0Y2WGt5eVVQUHZzR3dzMTRINXhudTVkUGZh?=
 =?utf-8?B?TUFJVXJYakpVNksva0o4d1JYRmhkRURvQ2lVRTMzUXZoOWg5bXVGR0xHNkh0?=
 =?utf-8?B?VldCRWhVeG9Rb3lvdWh3NC9vbUtQU1lvN1JVcGhWV1N6MDhlb0g0L0lFZjVr?=
 =?utf-8?B?UUdCVUJGeHllVmg3UWg0MGRjUTlzUE9TMWl5Qit4TVZlSjJaSHFZcUk5eGgv?=
 =?utf-8?B?TlE4KzI4SUViVmEyb1JVR1BDVkZVNHpKQ1NrSzlOUFNCK1NnUHZBbmpCLytP?=
 =?utf-8?B?Q1JlZ1loT2tiZFNUN0VUSE5VeUNKcUpBa3JzQ0NVM3M2N1p0RXE3RWxqL0xF?=
 =?utf-8?B?bU0veW4yMlIvSUhBYWQ5Yk55Zk5oTjFCZUNzRkFPZkNPd1dCYzdEdEF6NUhp?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zMJ3irX0mFUoV2nVJLtJ36Dk1/nrNmIz+N4yAXsCii7rKufbHe+tQwKSztaA251E1hddCVa0391ose8h2PqwD94n41+smbT+jlEF6Z+j2nDpkEyHobnxihq881hoH5mWYisd+l3YJ+WIDElZgzrlppOHWnKCiSLw8t/xys2jSWNq+7XuMorRiesY1sZG0TLHZzCy1NesLERchsYKARtQpRd82NteAo+WhvBb7sWZG5npLT68EaUoHXxZsHbWuW3zhiZqp9o8OUY6laPbXthbNnF0ClZaVS1UQp6JtVSFX96IzhLVQj3Z6MfpSjKXP12xxU5rDYw8BhmPD8AFm8WCRIhnjUKQJuSMujigyLbwAmAGslFS4HU98OMJZZayHetGusUt2diuNYsuH1fhHXNsqcpgBaXNYI0LpE+WD1L/GssMixcVRbpUcKVf1Dz9lTYgBghXH5i1Guzlq7zQ4yy1KF22UZbq17vWjwt99zIIUoCHteH+FVBFpwNb5+kXn/dlpAz8FM8b1pePXAqzu6fMoCeXQU56DFCwJhRo27eFRTel7O3+g/E6iJdp8wNJ/LMv+yjC6+kLrMK7dmUnI6oYhcWS3OX2W6TyFfkq1ZPydxpFSbAjWxnPt2LZLwCG5OKsgaaO1UmyNBrikjmmU1fpxG3p+/LjICcYfRmpwl2Ayup+agc77SHswmCxGd+2gDO0Zk81nXxh9m6fbsQHrbJTCrXkBkhCShtTHl57Jf8SmzGXLrd6w9Nu6TrNtigryMku1SjXZsbhKoK+TTGTk0ApSRVg4AR5ggnbG2DP28RhtmZr3TXk3g3izQZielLCDpqAi2jWPJf6/kBvm/E9EuQT+N6CcEshQnkPzwanVZJ1yXMjpgrM0KLU/f3zy1PLFa0gvYZGHomDO6iKjfOxP2QJRqG5npLmRyk8ru2ZtQ8fOWs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0a8f6b-80c7-421d-11f1-08dbafb5ee5a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 15:20:12.8484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5i0/uvwtCxFNltjT+5rB9Bj43ktMBFLmD3/KOcTr+g/UivOEgk499/sIFDqaPNRqrv3zyM09gTbyA8Y43/qHIc6VAn/K4lnAhh/uDiAdlZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7188
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_07,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=845
 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309070136
X-Proofpoint-GUID: 7no901nnSTFVf3O0tde1hYW_lO-pAYTq
X-Proofpoint-ORIG-GUID: 7no901nnSTFVf3O0tde1hYW_lO-pAYTq
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

On 07/09/2023 13:40, Cédric Le Goater wrote:
> Hello Joao,
> 
>> Cedric, you mentioned that you take a look at this after you come back, not sure
>> if that's still the plan. But it's been a while since the last version, so would
>> you have me repost/rebase on the latest (post your PR)?
> 
> Yes please. That's next on the TODO list (after some downstream work
> regarding the postcopy crash). My rough plan for 8.2 is :
> 
>  * P2P
>  * VIOMMU
>  * dynamic MSI-X
>  * fixes
> 

Thanks for sharing

> I think it is a bit early for iommufd and I will probably lack time.
> The recent migration addition is requiring some attention in many
> areas.
> 
>> Additionally, I should say that I have an alternative (as a single small patch),
>> where vIOMMU usage is allowed ... but behind a VFIO command line option, and as
>> soon as attempt *any* vIOMMU mapping we fail-to-start/block the migration. I
>> haven't posted that alternative as early in the dirty tracking work the idea was
>> to avoid guest vIOMMU usage dependency to allow migration (which made this
>> patchset the way it is). But thought it was OK to remind, if it was only be
>> allowed if the admin explicitly states such its intent behind a x- command line
>> option.
> 
> I don't remember seeing it. It is worth resending as an RFC so that
> people can comment.

I haven't send it, largelly because in the first versions of dirty tracking the
situation revolved around whether or not we depend on guest vIOMMU usage
(passthrough or not) vs tracking something agnostic to guest (raw IOVA ranges).

In any case I can send out the patch and move the discussion there whether it's
a good idea or not (it's a simple patch)

	Joao

