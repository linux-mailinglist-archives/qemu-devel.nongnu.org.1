Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B337A5638
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 01:33:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiNjY-0003AE-Qb; Mon, 18 Sep 2023 19:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1qiNjW-000398-O0
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 19:32:50 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1qiNjU-0001Cs-QY
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 19:32:50 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38IK4xQ1015328; Mon, 18 Sep 2023 23:32:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=qlIZ4gfnRWCZURG1EtiJ+4pN6HUD69YBYxdsD5TvA5Q=;
 b=mESwYT1jBW2dSIHw9zZpSRD5KNBiDSQCFHJnRAycLscmw2+j8jWJOx8z4t+tG1ScbGnI
 fYGc0+A7+tHRNjSSFkrGA5T+o1tzTxrza3n8exOLPQi1YsHsIK42XCxyQ3X3bUzYqXku
 4xNbMBAdHWmyc+gXFHGOVe3tcE2Uh+Fi9vw6JwAu1ePZd5ifTgGhPUeGIyDWMzdHpydb
 gq7Z6sSE4RkPimPEhOH6OmbrnF68qg47p/8XTZNBZOZvGcbPxGJ601e+qms8rGt8bT4I
 twOoJdnPBllSToZCiOopynB14nA9W6yJsfTLMu++1ZlN89+PGx15p7znpJGKO25GK/nq zQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t548bbmmc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Sep 2023 23:32:43 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38IL0Z7u030760; Mon, 18 Sep 2023 23:32:43 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3t52t4xp26-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Sep 2023 23:32:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJnFz7AaYqmQlRWwaZ6ZrxOil6cUJlHymt+RJl8NlEkWtmk5h4T3csoty9HK7m0WdjbWAAkqbtxg4bLa7PwnevVXYTEirXhCcn8zT5m7BGVwwSp8cyewAkmRV7/1bxRPISv0F7vOqWBQjiJDO4mnSsZ7wZ2SZtmlMpcPtfTshFr4QGJXCwDFa4+YN5iG1qRB05av4S0d4aEm6TE1ztNCuFL8xrXX8HJND4EK+ROiBRQ8lGT6DX/oyJDoFJh0QM9ntKyAT22TrZqtvY1k4Z4YHMZQ9Xzkj08KY8kL3RrplXl/7uxM9qOaSr5JGXQweeF6y6957FvlFJZgAjX7AdLm+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlIZ4gfnRWCZURG1EtiJ+4pN6HUD69YBYxdsD5TvA5Q=;
 b=ah1qC15whf+gHmUEShq6fcqBEhZI0ybGRTNFQtyqmZt9hW1dJZ7taUfSrNusCGAlbTtLYM6tNpTnV6o984VYcZlddRvUMiZX0Tj+648Ww9e8od8D/5XByN5p5/vaQU6yX5jXf0CMcVq73jKz3Q4Y76KuiVDGf5j+d/iqI+kBLYKiFTkSRi4IVsIdjwkxZG+4Pu0IVDfeoGaWnsZ31MQqMukKA3ZVw3XxgHgX0vm9Vc47g1BMgFELrq/W8HTXQCCoJo9ofLMg7HRhQlNNBGcEGpSHUFh1kOjUVluaqK8g8fRx//tdjY24x8p3jKqKEXSzV3W/t6OUJZs4Myo8PsEhmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlIZ4gfnRWCZURG1EtiJ+4pN6HUD69YBYxdsD5TvA5Q=;
 b=XP3CWhLiv0+o+SAaq2KTUBjXvIAYlUqyaivTmEjYjCDe7/j1r0sDMKyXpWL0TkNBrHg1RGL9UjNJsjaBwgk1EQXzYl6yckJ6AJbr8ji2iG1uvabiButq5lc3Pgoou05kZvkuBH+aUHv4cXKVJDlixFJ0tuqtcywwRdttGOG/Ekc=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by SJ2PR10MB7758.namprd10.prod.outlook.com (2603:10b6:a03:56f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 23:32:39 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::35e3:7e4c:72b2:cf74]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::35e3:7e4c:72b2:cf74%7]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 23:32:38 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: qemu-devel@nongnu.org
Cc: linux-debuggers@vger.kernel.org, stephen.s.brennan@oracle.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Omar Sandoval <osandov@osandov.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 qemu 2/3] dump: Allow directly outputting raw kdump format
Date: Mon, 18 Sep 2023 16:32:32 -0700
Message-Id: <20230918233233.1431858-3-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230918233233.1431858-1-stephen.s.brennan@oracle.com>
References: <20230918233233.1431858-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0030.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::43) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|SJ2PR10MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: b84b5491-624e-490b-556f-08dbb89f8bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gkcIGAdQqsFtpdk8uAVhHtu3WOxOwr1qzoeTUHq0orhIjgBzZLOl3ePKDzBt1ft9ME7id0/ihwF0AggEE5YyI12HshGE80JUZnI2FcWMjx9o2bo/do/3CEOECMQtbDywsI68QEeZn0N/8GMgdC2AkYSzU0aEDelNfXtPtKcEJx2pa/3jZ2NHVsF/k5UhbOYLNP0A86Ct+9LvQf6AWu1MaoOYtVPHmT1Z8YcBeBAcYyzKESZqawN5bPvqF2t4F8vDhAw880ptZyvXdPRWJeIu1FU7ZttifvJFBGDLtWINguPcrCwyyHZES3vuBBNMNL9MHrJcHpLBHJLn3clZWK+5Ccp3/d0vtNtA0L8Inzf2/wTiJpaF2K5KnRc99wV9TcPjcBEhZ66C155UgQVPQxnwjSIjkgU4ADfd7Ja7rKVynEbYGM8k9uBHyzx1rrkxStOjGxvZJ3Jnxk27s3GSZKyICOZBdApDH6smecRtSsyTG0cfBnA2Wx8HkCDvv2JgQgnfjjTOrcksR5riIcl+LMb/xAltUect6p5DtDVThiALAiw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR10MB6597.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199024)(1800799009)(186009)(66899024)(6506007)(6486002)(6666004)(103116003)(86362001)(38100700002)(36756003)(1076003)(2616005)(2906002)(966005)(6512007)(83380400001)(478600001)(5660300002)(316002)(8676002)(4326008)(8936002)(6916009)(41300700001)(54906003)(66556008)(66946007)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5p9dGSHleM4upm13J3399T4EJv+3tdW4usvqCn/QOcav6J+2R9vdektSSydR?=
 =?us-ascii?Q?u6+nBuYe5qxAXnrGniR+L6csLlGF/QtPSqQC9LObsGYfD0vUv63mECZpC6YL?=
 =?us-ascii?Q?2JSUbMAPVKvzyBaFNxtVTiusa30eT823kF6/hRG+QVvBTyVkvlDVN9onIpiG?=
 =?us-ascii?Q?ePJKwN6D5vDbg9Qk4Yu75y+v0qTnWmQQSC4EfsgNrvVvl7Bhj4fzVVOpfmDw?=
 =?us-ascii?Q?y7pCiRRQZBDELmthhRPRhJ+yMKJTatLGpmINxcon0jpi5WmnWpt4hNEhQX8j?=
 =?us-ascii?Q?6vPOkwIPAWDNBzcZCYxxxGCxm/9/v2ACMsHGXquASIbl1diULDMhmFpyJVPl?=
 =?us-ascii?Q?cb95th6vYVJRJbEk5d13a9aVsORYqhZ2Ndyt8NXHLSMxjKeEIlwuyVsihH9G?=
 =?us-ascii?Q?ElCNzgXiZbzonrsrLuqEyFLMxqmdaXQQK5GdAI0k+wllZ/YAIx3V4oqnWhfj?=
 =?us-ascii?Q?tHGM1xaV9oQlXxA6M8RY18gl/L639SEUowoETU5IPlgwn03L01OfO7MlKHYA?=
 =?us-ascii?Q?TSmDS0powEiN+LevGTW5/NhsfspZDndjKWrEfLmYdsi3g+wpn5dQhl4RpDDQ?=
 =?us-ascii?Q?u/kn1oPZvMlr3kx8Ie2wQYmNF24EVOLO2U4IBWp4rSiRSdE/2vJ3iMupWyRW?=
 =?us-ascii?Q?ebw75L67PSotQ+jjDsE3dMMIHY8Qawxh0vOoHmvrdXARxGAMQ1mbjPRL2Cvg?=
 =?us-ascii?Q?W+VMK3cuyGc7P0E01Yn7H+ybwA1rec1nwsXGGAvH0SSiXJYgKkzoFjU7AtNJ?=
 =?us-ascii?Q?9sAVRxzzd3O80I5+YEmlXmJ3g0Pheh/uvP5odCJZY1v3zY+5ndoIjZVixfbW?=
 =?us-ascii?Q?Wb0w+K4XYVz7EmX/OITI5Xg7N73pw+btl3UC/GbNpvl16aezLEWqPvKBDxOb?=
 =?us-ascii?Q?vTLQTRstlB8V4NIC7Qd2uzI4qV4bW+14+d87ANT3Z/4ef0hoa3/SXP2cmCkV?=
 =?us-ascii?Q?0Tu5IyJONYMd5GNr1z4tgwdf4b0vpvoFmeJwrWVnLpiLNuSFXNep9IwyjfYz?=
 =?us-ascii?Q?Z+HFymUBk2FAwn53dm/p9IP0N0zBnvFghqAM55sq85LB4pGk3AOaqcazAHhQ?=
 =?us-ascii?Q?llf8RzW5mYgMtV5h6YT6IOU2t9Dhp48HO24Cd3IQqdhGyxPWrl64pqPe7Og5?=
 =?us-ascii?Q?twya2kiEERevreJpHDvpQuI6/wfcndpwqMExKlimBvq+mCW0nFH+sufi5X6J?=
 =?us-ascii?Q?GPZlleB1JCxzeysRXAqNdkzP2dsv5xdlZDHkY/pvt9LjdTDelb1xQ7KSl64/?=
 =?us-ascii?Q?qy/JWpHljg9UGqfUATe/Jrc7oSnlC2oal3I30xFB767tIc9I1kHD6XUqXTC8?=
 =?us-ascii?Q?8iwO9GTm54pkmnEWaQDT5Zwz61svkNKRLs7268u9wxsFDrCQ8IfKAvpJkVTT?=
 =?us-ascii?Q?J86vp3P0R5d7OB5+mZnbkjEwhF5plkuSKP/rCJL032XI4S+/rg5QJRRE4sfA?=
 =?us-ascii?Q?HnXDs4Pz5gSJnV8CDBms7bhofvXAoivirFml31DUFOqxooyCH8XPs9yvwixj?=
 =?us-ascii?Q?CZKbp5YFydby9odjOl16Yeb0mJo9pwpQ75z9FDfHSv/FL0DlZhK9Gvkk5Kds?=
 =?us-ascii?Q?76ayqteS1cJoJw8bDu9SWZI8APiF50s8KWaac+ZeYrKR/FRUKDuljS+I9ppe?=
 =?us-ascii?Q?c3WmymKq7tXRuILVGNemagWws4v8vZSvZWTepq3Sq6KK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bAAAlABQxSQuumYzHdRoupd5uizP8eQZ/SO7mRJxtr3Ir+Hc62maaDTl2zO+6Plfnyd0P5/cJ9LGDI3+T+qNOsEs+oh7ODmHaOxK2sK6aeKRvKSUX0vdA3aQJqrc1tAoSS890TjJXoMSwOeMVI7GFQR5mnDbm0R5c3wVaywt/fz/xxqQ7Udysx1Y/DYEcV0KSIqh/YKhilhUc+5aMjW24rerqHuML0cN6RCEcHcbVJQiao0s+iRDl0QYTRmfxruUa1pDSnvaB810MoaaB3xoeDVIv8XPNNr0wSvWj51mgZvqEdPejMuVNOu/3HjS8pHlWjdnxYzxb3F7Uf2M9c1jxY6X+bFLjSHpgyiI4lz8xhBiADu+nDm1cLVP1jOTdGxteCdnRdlrGItm8A+BTIaV3QZRIO57s4NpLoqHanB5pqLa/Fi44uK+KSSTdCjru+v0aBParVKmrSjfCUaGnJYuTUc0MnPPXtq9vHnXVznNUsvv+AUcedIo3bgkPpZwKGVy5TfO4t/O1ed9trWli2myJ0tZh7TZfs5nQEF1GzbR62zyG92TjP20DPPYqAjWriF/neyYzi5ePApnRJklZ0gMtms7q2LkXZ5qSFRAl9SpxsOU4X4bdkIYxvt1cbOMzYPDn/YljvvvLl0IWJZ1+vwWXJtKEdNe2Pi2Q3ENAa5Ir/vO4jt4pp0vLFJEzZBUhXR0HHVCLR35SDI+BNFBDYLMYq5T9mxslAYGInmMkufWEq/sjnRyNEmZ+zNGFkM2uMpVdk07SL02lO5Yyg6St6iJe3h6GQd91kNWUVn4+GaMiYHxy6nhXhKS/Xr3mG5pcp7lsAUs7ECe5MI5JncEo/eOsUtnSGDxkTjaR9MPThtbHzLcAqY0zkpSoDcnnoje4RSO
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b84b5491-624e-490b-556f-08dbb89f8bca
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 23:32:38.8956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HIyuS/Og2JsGk/5XycnrXtPpA4A6eu2Q7GIwbgzWTy1K+qemwGyGVx4lX87oe/iUImq7oH9xCovWsZuulUw8kM6slMzkrSdry3C8JTWS4no=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7758
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_11,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309180203
X-Proofpoint-GUID: TW7bdm3hyD5-tb50mHVvaRC-bso1CLoK
X-Proofpoint-ORIG-GUID: TW7bdm3hyD5-tb50mHVvaRC-bso1CLoK
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=stephen.s.brennan@oracle.com; helo=mx0a-00069f02.pphosted.com
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

The flattened format (currently output by QEMU) is used by makedumpfile
only when it is outputting a vmcore to a file which is not seekable. The
flattened format functions essentially as a set of instructions of the
form "seek to the given offset, then write the given bytes out".

The flattened format can be reconstructed using makedumpfile -R, or
makedumpfile-R.pl, but it is a slow process because it requires copying
the entire vmcore. The flattened format can also be directly read by
crash, but still, it requires a lengthy reassembly phase.

To sum up, the flattened format is not an ideal one: it should only be
used on files which are actually not seekable. This is the exact
strategy which makedumpfile uses, as seen in the implementation of
"write_buffer()" in makedumpfile [1]. However, QEMU has always used the
flattened format. For compatibility it is best not to change the default
output format without warning. So, add a flag to DumpState which changes
the output to use the normal (i.e. raw) format. This flag will be added
to the QMP and HMP commands in the next change.

[1]: https://github.com/makedumpfile/makedumpfile/blob/f23bb943568188a2746dbf9b6692668f5a2ac3b6/makedumpfile.c#L5008-L5040

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 dump/dump.c           | 32 +++++++++++++++++++++++++-------
 include/sysemu/dump.h |  1 +
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/dump/dump.c b/dump/dump.c
index 74071a1565..10aa2c79e0 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -814,6 +814,10 @@ static int write_start_flat_header(DumpState *s)
     MakedumpfileHeader *mh;
     int ret = 0;
 
+    if (s->kdump_raw) {
+        return 0;
+    }
+
     QEMU_BUILD_BUG_ON(sizeof *mh > MAX_SIZE_MDF_HEADER);
     mh = g_malloc0(MAX_SIZE_MDF_HEADER);
 
@@ -837,6 +841,10 @@ static int write_end_flat_header(DumpState *s)
 {
     MakedumpfileDataHeader mdh;
 
+    if (s->kdump_raw) {
+        return 0;
+    }
+
     mdh.offset = END_FLAG_FLAT_HEADER;
     mdh.buf_size = END_FLAG_FLAT_HEADER;
 
@@ -853,13 +861,21 @@ static int write_buffer(DumpState *s, off_t offset, const void *buf, size_t size
 {
     size_t written_size;
     MakedumpfileDataHeader mdh;
+    loff_t seek_loc;
 
-    mdh.offset = cpu_to_be64(offset);
-    mdh.buf_size = cpu_to_be64(size);
+    if (s->kdump_raw) {
+        seek_loc = lseek(s->fd, offset, SEEK_SET);
+        if (seek_loc == (off_t) -1) {
+            return -1;
+        }
+    } else {
+        mdh.offset = cpu_to_be64(offset);
+        mdh.buf_size = cpu_to_be64(size);
 
-    written_size = qemu_write_full(s->fd, &mdh, sizeof(mdh));
-    if (written_size != sizeof(mdh)) {
-        return -1;
+        written_size = qemu_write_full(s->fd, &mdh, sizeof(mdh));
+        if (written_size != sizeof(mdh)) {
+            return -1;
+        }
     }
 
     written_size = qemu_write_full(s->fd, buf, size);
@@ -1775,7 +1791,8 @@ static void vmcoreinfo_update_phys_base(DumpState *s)
 
 static void dump_init(DumpState *s, int fd, bool has_format,
                       DumpGuestMemoryFormat format, bool paging, bool has_filter,
-                      int64_t begin, int64_t length, Error **errp)
+                      int64_t begin, int64_t length, bool kdump_raw,
+                      Error **errp)
 {
     ERRP_GUARD();
     VMCoreInfoState *vmci = vmcoreinfo_find();
@@ -1786,6 +1803,7 @@ static void dump_init(DumpState *s, int fd, bool has_format,
     s->has_format = has_format;
     s->format = format;
     s->written_size = 0;
+    s->kdump_raw = kdump_raw;
 
     /* kdump-compressed is conflict with paging and filter */
     if (has_format && format != DUMP_GUEST_MEMORY_FORMAT_ELF) {
@@ -2168,7 +2186,7 @@ void qmp_dump_guest_memory(bool paging, const char *file,
     dump_state_prepare(s);
 
     dump_init(s, fd, has_format, format, paging, has_begin,
-              begin, length, errp);
+              begin, length, false, errp);
     if (*errp) {
         qatomic_set(&s->status, DUMP_STATUS_FAILED);
         return;
diff --git a/include/sysemu/dump.h b/include/sysemu/dump.h
index e27af8fb34..d702854853 100644
--- a/include/sysemu/dump.h
+++ b/include/sysemu/dump.h
@@ -157,6 +157,7 @@ typedef struct DumpState {
     MemoryMappingList list;
     bool resume;
     bool detached;
+    bool kdump_raw;
     hwaddr memory_offset;
     int fd;
 
-- 
2.39.3


