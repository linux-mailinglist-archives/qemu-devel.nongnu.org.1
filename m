Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4B570496F
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 11:37:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyr6V-0006qr-MH; Tue, 16 May 2023 05:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1pyr6S-0006qM-PR; Tue, 16 May 2023 05:36:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.edmondson@oracle.com>)
 id 1pyr6Q-0005kP-Ci; Tue, 16 May 2023 05:36:20 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34G6T8WP009211; Tue, 16 May 2023 09:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=ukg7X4Iq3U9seyfZgNIN8/2hN4J64znKN6dl6zLn54o=;
 b=QdApyT5lPOtAu58IGqZEz2SCfmFQNMKuoAwPJPQGgpFyPhQywmI9P7kHuodmBNGh7Syc
 e17jTMnNR17guAW/+cK3ayAe1EMxaA2aQWYPgwq/gZRgrrYT+H+Mqv3+nxZBo5ZNmmOA
 LqSZ2pFjjXdJq32sPZxyvUCmG8k4nvroKsdxcMiCdIFhCxnFG7gb56lNc+uzP5ccdjxX
 8jEGdXq30lWwZ1frnc0uVb5zyiDG9f0daWc6Ytn3bs3EJoOf+BH4lxJO/hV9c47T7m+p
 oeEdGtnBGaRDxpesb3PxsBoC/ibQcvzjXQGyWtDUrkyxnNKQG4EGWcJbtow5gRk9ATYz CQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1b3tryh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 May 2023 09:35:58 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34G8mDPl023133; Tue, 16 May 2023 09:35:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qj103jnye-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 May 2023 09:35:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsmS8R0uaQtu5uO3g9BHFj8vMwr3oJ8Y6B5Q9vVhJFObSBWeN1YRuVhaJcQ3mgQFhpWtLmzDXbAeRE2KecAJmW9W3kv0aKD8Dj32cN9ocRFx5T4BKFdk+7/YhK9ibPnKyVPr7ZYihbIXF7DJDFIooJ3aG++a5J5FsOJ+4SHY2BOQLRSHyNV4Yuhn2RAe3YawIkra/7dosigfk+FCs73LFTu/3YUAK1Hv5Ve2dbp9Hn88NGaticy90SXnzDRqgzat1YHzMg9D2YX2D16G7y/SEMo+8EUub10PcVvULacPT0z+6hvOoHUCDQ7OBjKeTfItOsDdVFXCRyJfNOPPCPhh+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukg7X4Iq3U9seyfZgNIN8/2hN4J64znKN6dl6zLn54o=;
 b=dexh9DL+kzsku4TWl/YPnx9J6a2LvDOE8LpOwCim0MNJ7RpMNrDKnhnHngIcp02NJt89eA/alP3kZPeE2qmoosG1ozsO+Y4hN8ZgFURQ2Qafz7j7rnW+1RpebMpZOLzIHIBjPppLm76Qo28oDK0To5FiJII9K8Cb8XWBHkeQbnRWSZhtWLupeFT+ZnrOxDWGK7/7Arsi4+CX0aMPcooaQ3Jm8tHCm/4nzZpKH9yyO15hW+HyoZFomArohg0KTBRUgfBvbgZdRJWeueAI4OMsEc8FKJCRYiloZZaRbHmIqYZaQWtnYV2kAZBa8NrNmDIwIwolTZPgcvINj4OnZm9AjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukg7X4Iq3U9seyfZgNIN8/2hN4J64znKN6dl6zLn54o=;
 b=KlBlhEdU7ON6Fq/2ohrfUWBp1m4pKkaGL4WYwj249SOoVDyzpeSyRZS10zOV1t8CQKzk2GnTEDklb5V3kh2SYazFwydHFsVs/eZA74Awbf2auCzvMbpqT9fjKLjhUS67dlTgxCl+bOWxud0ocCGv+gXkA8ASS5g+Wn0VoeydX64=
Received: from DS7PR10MB4926.namprd10.prod.outlook.com (2603:10b6:5:3ac::20)
 by CH0PR10MB5307.namprd10.prod.outlook.com (2603:10b6:610:c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 09:35:54 +0000
Received: from DS7PR10MB4926.namprd10.prod.outlook.com
 ([fe80::738c:b283:c54:57c0]) by DS7PR10MB4926.namprd10.prod.outlook.com
 ([fe80::738c:b283:c54:57c0%4]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 09:35:54 +0000
From: David Edmondson <david.edmondson@oracle.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Greg Kurz <groug@kaod.org>,
 qemu-s390x@nongnu.org, Fam Zheng <fam@euphon.net>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, John Snow
 <jsnow@redhat.com>, qemu-ppc@nongnu.org, Daniel Henrique Barboza
 <danielhb413@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Richard Henderson
 <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>,
 David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-block@nongnu.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Eric Blake
 <eblake@redhat.com>, Leonardo Bras <leobras@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH v2 02/16] migration: Correct transferred bytes value
In-Reply-To: <20230515195709.63843-3-quintela@redhat.com>
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-3-quintela@redhat.com>
Date: Tue, 16 May 2023 10:35:47 +0100
Message-ID: <m2bkik4o0c.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0081.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::21) To DS7PR10MB4926.namprd10.prod.outlook.com
 (2603:10b6:5:3ac::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4926:EE_|CH0PR10MB5307:EE_
X-MS-Office365-Filtering-Correlation-Id: 60af86f6-8f75-4cdc-a92d-08db55f0f1f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T+HCNskss00IFYTArnHl659aEoAWgUMjfR1gs998nt5d9p7UgOBw08cojFcaQKxuvJ69hGh5uEaHrTLFAMkYM7MYIbLV/LLcf2FJAHOtiTGDqYP55MJpWJ3fsHk5inKJ5CiO2d3Jj5obvI7EPoleFN2u3bXK3wCV/xeAsyx7MSJSp2YH148jxCMoy1NMpsVtY2Pnb9bePA3XDP4Y7OJ4Z178QAB1Ljzmve2qD0L4uFq3e4QhBsP7/IWUImjDV2yN92Ah3+u4Sl/91dbGtaBbsYAz/vgNJqBuQq3FThvyXNzEVVNNp0li95nLtwRedmRswxsAJ5n0K6VqwW30yshlmf8DVFiE70Dx3daozQ7Q8+3SEtyB+MwUu7b2UFuz2aJT6TZRi9Gj8yt/95OHeGu48hKa9gqVjh1b2J6xgO/SzvzmHMHDRw58DuqwiVg2/GGO57P4YPcbbEWANWEGIrVflD7q23hxXuRAdpd+Bvi7GqB7DCTC20TjgEq1aLfyi1Ihra3i5KAqQfbpdtxr79BOuSvheH6buY8Z72icPXPqMz7zQ67+Z8fH/NE++YnM0dpw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB4926.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199021)(36756003)(8676002)(7416002)(8936002)(316002)(44832011)(4326008)(5660300002)(38100700002)(2616005)(2906002)(41300700001)(478600001)(6486002)(6666004)(54906003)(66946007)(26005)(186003)(66556008)(66476007)(83380400001)(6506007)(6512007)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mY1mdfxSDX6BSSrTMVoKUWv4CvcNHi8JP97UCoqGavi1jzA3FWC4SakPBPwo?=
 =?us-ascii?Q?3ZOFp1DoN4y6xXtbvpEYaYLeMvg4s/1IRUpTIe/RcNFJ9Ao/bcJD3l5aLMAr?=
 =?us-ascii?Q?ZaIji3m0dVBeP5OzgqJwH1ENT8A7qrsGxqTXFKuwqShUu9B0eHbpnh7vNGTq?=
 =?us-ascii?Q?iNKyKGXcIIOKeKvHd3hA1ZFXQNUvLZxF0+d68dyV7COEZUWV64/w4/0iyNW/?=
 =?us-ascii?Q?v4k5FFUiWp/CrwwC5Dzdy8Y/bO4S8yeMpgmPuqtmJZuq2fUFFpt23fAFYqDD?=
 =?us-ascii?Q?HaI8Gl1jHB3WezF3fwYbrwKBbonYvEC10PnCk2kyJUM8RvVNR/hRx5JuKydI?=
 =?us-ascii?Q?v5JZ4Vu5smR3Wg0XQi0dIIPr7Efuknx0ky24o3g+ZEZW6zWBHBhQln+3ewBs?=
 =?us-ascii?Q?LuIUlqFP7wQYgadLzKpj/ZNxYqCPueb6QmB89Ih+XxnXGc6uADVsoAd0Cfas?=
 =?us-ascii?Q?wh1gmY1ANN2FhSGGsTvtqNmDaq9/uVSyFSv/jf4lzQZl69cD9tB96JMsoaJu?=
 =?us-ascii?Q?JuBhOhX7lmBBp2tiLzFyUWIgC/l2MKUI78LSDYyXanDG69Oh/obEf889GHK9?=
 =?us-ascii?Q?vlinbfG/UnPVYecLZN+qVAAPZZO9IONr1D0VYBQ3ZfuzmMurwPoG9HEhYwLO?=
 =?us-ascii?Q?P0JgPnmsSXnGG7m4Djo44nVBulODf/rtdx+aQbhnD6qbi8sLbt7eYFMzFA2e?=
 =?us-ascii?Q?aOSFJHMG5e8DTKciyOVqXq/Xw9OLwz0BxrianfDYcRAEQfvxpF2hKTplabXM?=
 =?us-ascii?Q?wC003yNSoEjzT6kGyYjZIbJxBUMIeNhDDaMThi9RJKZLCpYTMRObvtiZoLej?=
 =?us-ascii?Q?oF0j33IAZcA5xKvEXybeFWZjrKTuRA5kFONn0Gqs7fxvwAzyZPsN4A/3uvUn?=
 =?us-ascii?Q?KodTdS685/NkdxV7cuutU5G7/Gbd9Ql5kh+dQt1KCke+fKxXk1kioLQwGOfF?=
 =?us-ascii?Q?DqsmXXyMuE+W+OZyIudTe3fwMfZ30BCS8Q05F/yhu4XA/fUHpqn3+Z8iUnwe?=
 =?us-ascii?Q?FzxzB4udfz2nX6pvnx++H4cLuSQREroT87MtKuQ/eo1OeMeftbdEjpdPLa0g?=
 =?us-ascii?Q?X4WWOiFubhghHo8Eiro//HisTi6ALTo6qahT6HMzATEhlpmf3hS7hjlFWCAu?=
 =?us-ascii?Q?iIZNr6D6D4MhK+kdv5kiuM7YFrhHXr1DeSVOGxKzmOeCs/yn/VgV/iEdFbdu?=
 =?us-ascii?Q?9GJgg/RUatFzIEmLJksiWkPYbajkQQ1hxvgOYkzXBRaZQ0bOfsajDqGAewxm?=
 =?us-ascii?Q?RS0seHlrVJ/sFTTI7zitgLz961cYczUWgRXp2+vfE1dQFHLB7HqhoyBg8Hdj?=
 =?us-ascii?Q?ihDCivCmeDVrUuEun1CKJZO09FzlJoci0x5Ll0i1wusGjg0eXITuf9D65Z/9?=
 =?us-ascii?Q?wKZ9KfnmRz69DPV2/IRriFUFm1DlKo2ixpDDpGqGCEQOrDWbl3FLtERfoh+b?=
 =?us-ascii?Q?QoGV4YuOi2sAq+8uSVu+nFyWz6Nt6tx5J70ElAV9oFMP75x+bG/WeGtXN6Gp?=
 =?us-ascii?Q?BbDbfiFjsxyFbB5QgatsbV1GFG1Ohm98Rk59p5Rb0OykzBIPVxoGRo0sCDZu?=
 =?us-ascii?Q?Dey6gfJ2Z3huz9etgrx5U3No64mEHN6b/zpdOUMWWQb9l98MnBWJ80UsmNQu?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?92QcemQO/GYPYSw2kkSCDDlRlJYpxf9JeP82AsV6pUBMoqi0Zhs2VcHSbE+r?=
 =?us-ascii?Q?Gg9XsChx/feDzSaMgfoQoGrCRYDP2S9cCfItbSvJuIgiN6cRMBoLw+Te9YNg?=
 =?us-ascii?Q?i1jZdUT8k79uPCyD/zkuXuS4QLSAjQELgbXlRfAMdaJ4pHR94krPuCkER5bv?=
 =?us-ascii?Q?xRLKo4JRrV5mNVMN1EcIt1hwNpBdvEEMVieUPi15BSPcvMbNE/fxX4VS7IL5?=
 =?us-ascii?Q?l8XlJPj7PZeyV8y3fC2f2Ioys7wa/ynX/d49LreU1bovNwm9T5/ggLxxeMZG?=
 =?us-ascii?Q?M/vsfpRJdIl9jb7/Drd9Au/rYhLZ7BQIoDyRzQcJfvB4IDiag1v2sNQCAZyn?=
 =?us-ascii?Q?OikSHGFM7EpiUk+ndQD3peX0dj6wc14V7D24crIvvb78BfXdUHi/WzMBeEzz?=
 =?us-ascii?Q?RT/F/OAbWKPxafD/qvjIbqnNFR++e+NtJHl72OpB8x8dXHJV9TRuisCkhAdL?=
 =?us-ascii?Q?+J42I6COciVQkiTVgvfWa/OwggftKrJkEmzHgJI0dQxqW8e6hYla+ELIppm3?=
 =?us-ascii?Q?5ywjYuh2mNEHVk/gVdsTZpH9oMA3oeJ+uNfbE+7VIJjt0K6NUZ7k6g9vLJut?=
 =?us-ascii?Q?Jl5SUnQwkN1KkBpPWH6F7WRcDNsENWVZOacXMFr1kkK8TMcAtjLqLjQyIX7u?=
 =?us-ascii?Q?s3xRSI+mrHa/pOOpPTWvhe+XsfcfYWNwHVPxxkg7xf6XQ1qIEYjuOkw5xibP?=
 =?us-ascii?Q?GLrPCRftdFbKcKucKIpxiSBhjCUuj1N0NByU8FQO9+dIrT1Yp5jw4ta8W9Wp?=
 =?us-ascii?Q?3JEvWRljRXabzJpyRa8NoLLFdf4syl9UGMWXAr9620Bwug13routwMqRC5Fg?=
 =?us-ascii?Q?Z+WP/3jvXl3UmQBucJ0LkCS12Ih5c4DtxLAH9znPSBk8OGDjWhisCsWOqsZ8?=
 =?us-ascii?Q?yAlFmiqNyNXOpntiTBAGNXXflNdrFKQw7MyAhVbQX9xeRRJaI0dRSGXkWeOY?=
 =?us-ascii?Q?rVQZPin37lofwbDpUwudgbsb76pdKQymX5e3hiHHXbESHpdxIvuAWam7AGs3?=
 =?us-ascii?Q?bX16lSj0fOtE51FlAEk9KV06xw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60af86f6-8f75-4cdc-a92d-08db55f0f1f6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4926.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 09:35:54.4318 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68CBCX0JHAMhTqbT2l57L4Es2IOts5bFH6LNJNpTnt2pekF/0SGXqYnjye0LFQJBDWvstbbogo+BBvfA76xUc58a2rowPWcRgj9B260BUOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5307
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_03,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305160081
X-Proofpoint-GUID: CVbjjHq99C5OGJGDZEjir8SKv-tj6F0l
X-Proofpoint-ORIG-GUID: CVbjjHq99C5OGJGDZEjir8SKv-tj6F0l
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=david.edmondson@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Juan Quintela <quintela@redhat.com> writes:

> We forget several places to add to trasferred amount of data.  With

"transferred".

> this fixes I get:
>
>    qemu_file_transferred() + multifd_bytes == transferred
>
> The only place whrer this is not true is during devices sending.  But

"where"

> going all through the full tree searching for devices that use
> QEMUFile directly is a bit too much.
>
> Multifd, precopy and xbzrle work as expected. Postocpy still misses 35
> bytes, but searching for them is getting complicated, so I stop here.
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/ram.c       | 14 ++++++++++++++
>  migration/savevm.c    | 19 +++++++++++++++++--
>  migration/vmstate.c   |  3 +++
>  migration/meson.build |  2 +-
>  4 files changed, 35 insertions(+), 3 deletions(-)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index f69d8d42b0..fd5a8db0f8 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -337,6 +337,7 @@ int64_t ramblock_recv_bitmap_send(QEMUFile *file,
>  
>      g_free(le_bitmap);
>  
> +    stat64_add(&mig_stats.transferred, 8 + size + 8);

Push this up after the qemu_fflush() call?

>      if (qemu_file_get_error(file)) {
>          return qemu_file_get_error(file);
>      }
> @@ -1392,6 +1393,7 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
>                      return ret;
>                  }
>                  qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
> +                stat64_add(&mig_stats.transferred, 8);
>                  qemu_fflush(f);
>              }
>              /*
> @@ -3020,6 +3022,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>      RAMState **rsp = opaque;
>      RAMBlock *block;
>      int ret;
> +    size_t size = 0;
>  
>      if (compress_threads_save_setup()) {
>          return -1;
> @@ -3038,16 +3041,20 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>          qemu_put_be64(f, ram_bytes_total_with_ignored()
>                           | RAM_SAVE_FLAG_MEM_SIZE);
>  
> +        size += 8;

Move the blank line down.

>          RAMBLOCK_FOREACH_MIGRATABLE(block) {
>              qemu_put_byte(f, strlen(block->idstr));
>              qemu_put_buffer(f, (uint8_t *)block->idstr, strlen(block->idstr));
>              qemu_put_be64(f, block->used_length);
> +            size += 1 + strlen(block->idstr) + 8;
>              if (migrate_postcopy_ram() && block->page_size !=
>                                            qemu_host_page_size) {
>                  qemu_put_be64(f, block->page_size);
> +                size += 8;
>              }
>              if (migrate_ignore_shared()) {
>                  qemu_put_be64(f, block->mr->addr);
> +                size += 8;
>              }
>          }
>      }
> @@ -3064,11 +3071,14 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>  
>      if (!migrate_multifd_flush_after_each_section()) {
>          qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
> +        size += 8;
>      }
>  
>      qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
> +    size += 8;
>      qemu_fflush(f);
>  
> +    stat64_add(&mig_stats.transferred, size);
>      return 0;
>  }
>  
> @@ -3209,6 +3219,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>      RAMState **temp = opaque;
>      RAMState *rs = *temp;
>      int ret = 0;
> +    size_t size = 0;
>  
>      rs->last_stage = !migration_in_colo_state();
>  
> @@ -3253,8 +3264,11 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>  
>      if (!migrate_multifd_flush_after_each_section()) {
>          qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
> +        size += 8;
>      }
>      qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
> +    size += 8;
> +    stat64_add(&mig_stats.transferred, size);

This is after qemu_fflush() in the other cases.

>      qemu_fflush(f);
>  
>      return 0;
> diff --git a/migration/savevm.c b/migration/savevm.c
> index e33788343a..c7af9050c2 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -952,6 +952,7 @@ static void save_section_header(QEMUFile *f, SaveStateEntry *se,
>      qemu_put_byte(f, section_type);
>      qemu_put_be32(f, se->section_id);
>  
> +    size_t size = 1 + 4;

Move the blank line down.

>      if (section_type == QEMU_VM_SECTION_FULL ||
>          section_type == QEMU_VM_SECTION_START) {
>          /* ID string */
> @@ -961,7 +962,9 @@ static void save_section_header(QEMUFile *f, SaveStateEntry *se,
>  
>          qemu_put_be32(f, se->instance_id);
>          qemu_put_be32(f, se->version_id);
> +        size += 1 + len + 4 + 4;
>      }
> +    stat64_add(&mig_stats.transferred, size);
>  }
>  
>  /*
> @@ -973,6 +976,7 @@ static void save_section_footer(QEMUFile *f, SaveStateEntry *se)
>      if (migrate_get_current()->send_section_footer) {
>          qemu_put_byte(f, QEMU_VM_SECTION_FOOTER);
>          qemu_put_be32(f, se->section_id);
> +        stat64_add(&mig_stats.transferred, 1 + 4);
>      }
>  }
>  
> @@ -1032,6 +1036,7 @@ static void qemu_savevm_command_send(QEMUFile *f,
>      qemu_put_be16(f, (uint16_t)command);
>      qemu_put_be16(f, len);
>      qemu_put_buffer(f, data, len);
> +    stat64_add(&mig_stats.transferred, 1 + 2 + 2 + len);
>      qemu_fflush(f);
>  }
>  
> @@ -1212,11 +1217,13 @@ void qemu_savevm_state_header(QEMUFile *f)
>      trace_savevm_state_header();
>      qemu_put_be32(f, QEMU_VM_FILE_MAGIC);
>      qemu_put_be32(f, QEMU_VM_FILE_VERSION);
> -
> +    size_t size = 4 + 4;

Move the blank line down.

>      if (migrate_get_current()->send_configuration) {
>          qemu_put_byte(f, QEMU_VM_CONFIGURATION);
> +        size += 1;
>          vmstate_save_state(f, &vmstate_configuration, &savevm_state, 0);
>      }
> +    stat64_add(&mig_stats.transferred, size);
>  }
>  
>  bool qemu_savevm_state_guest_unplug_pending(void)
> @@ -1384,6 +1391,7 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
>  {
>      SaveStateEntry *se;
>      int ret;
> +    size_t size = 0;
>  
>      QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>          if (!se->ops || !se->ops->save_live_complete_postcopy) {
> @@ -1398,7 +1406,7 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
>          /* Section type */
>          qemu_put_byte(f, QEMU_VM_SECTION_END);
>          qemu_put_be32(f, se->section_id);
> -
> +        size += 1 + 4;

Move the blank line down.

>          ret = se->ops->save_live_complete_postcopy(f, se->opaque);
>          trace_savevm_section_end(se->idstr, se->section_id, ret);
>          save_section_footer(f, se);
> @@ -1409,6 +1417,8 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
>      }
>  
>      qemu_put_byte(f, QEMU_VM_EOF);
> +    size += 1;
> +    stat64_add(&mig_stats.transferred, size);
>      qemu_fflush(f);
>  }
>  
> @@ -1484,6 +1494,7 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
>      if (!in_postcopy) {
>          /* Postcopy stream will still be going */
>          qemu_put_byte(f, QEMU_VM_EOF);
> +        stat64_add(&mig_stats.transferred, 1);
>      }
>  
>      json_writer_end_array(vmdesc);
> @@ -1664,15 +1675,18 @@ void qemu_savevm_live_state(QEMUFile *f)
>      /* save QEMU_VM_SECTION_END section */
>      qemu_savevm_state_complete_precopy(f, true, false);
>      qemu_put_byte(f, QEMU_VM_EOF);
> +    stat64_add(&mig_stats.transferred, 1);
>  }
>  
>  int qemu_save_device_state(QEMUFile *f)
>  {
>      SaveStateEntry *se;
> +    size_t size = 0;
>  
>      if (!migration_in_colo_state()) {
>          qemu_put_be32(f, QEMU_VM_FILE_MAGIC);
>          qemu_put_be32(f, QEMU_VM_FILE_VERSION);
> +        size = 4 + 4;
>      }
>      cpu_synchronize_all_states();
>  
> @@ -1690,6 +1704,7 @@ int qemu_save_device_state(QEMUFile *f)
>  
>      qemu_put_byte(f, QEMU_VM_EOF);
>  
> +    stat64_add(&mig_stats.transferred, size + 1);

Move the blank line down. In other cases the pattern has been to update
'size' and then call stat64_add() - make this one the same?

>      return qemu_file_get_error(f);
>  }
>  
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index af01d54b6f..ee3b70a6a8 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -12,6 +12,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "migration.h"
> +#include "migration-stats.h"
>  #include "migration/vmstate.h"
>  #include "savevm.h"
>  #include "qapi/qmp/json-writer.h"
> @@ -394,6 +395,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>                  written_bytes = qemu_file_transferred_fast(f) - old_offset;
>                  vmsd_desc_field_end(vmsd, vmdesc_loop, field, written_bytes, i);
>  
> +                stat64_add(&mig_stats.transferred, written_bytes);

Move the blank line down.

>                  /* Compressed arrays only care about the first element */
>                  if (vmdesc_loop && vmsd_can_compress(field)) {
>                      vmdesc_loop = NULL;
> @@ -517,6 +519,7 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
>              qemu_put_byte(f, len);
>              qemu_put_buffer(f, (uint8_t *)vmsdsub->name, len);
>              qemu_put_be32(f, vmsdsub->version_id);
> +            stat64_add(&mig_stats.transferred, 1 + 1 + len + 4);
>              ret = vmstate_save_state(f, vmsdsub, opaque, vmdesc);
>              if (ret) {
>                  return ret;
> diff --git a/migration/meson.build b/migration/meson.build
> index dc8b1daef5..b3d0c537c8 100644
> --- a/migration/meson.build
> +++ b/migration/meson.build
> @@ -1,5 +1,6 @@
>  # Files needed by unit tests
>  migration_files = files(
> +  'migration-stats.c',
>    'page_cache.c',
>    'xbzrle.c',
>    'vmstate-types.c',
> @@ -18,7 +19,6 @@ softmmu_ss.add(files(
>    'fd.c',
>    'global_state.c',
>    'migration-hmp-cmds.c',
> -  'migration-stats.c',
>    'migration.c',
>    'multifd.c',
>    'multifd-zlib.c',
> -- 
> 2.40.1
-- 
Are you laughing at me now? May I please laugh along with you.

