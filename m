Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB07706E77
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:45:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzKG7-00038t-PD; Wed, 17 May 2023 12:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1pzKG3-00038a-Ib
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:44:11 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1pzKG1-0007wO-SF
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:44:11 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34HE4Jxb022437; Wed, 17 May 2023 16:44:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=qIzLa1pSOkDksGQ+YF2WRh18rAUuUnSQyy4a6T4pJ4w=;
 b=rzKQh7HH5KILSs66yA3fx09a8Vj1dFB5tgZwY+/Ht4b4Iq8HFojMXJ/bIydg31w0TbYY
 AxO9oD0iBYhotaw5g1nVRbo4fJ8f4O0yh7xhOXRk77O0z1nzAuwoM+ZceT3oIuby+UsB
 RGSmemPhFBJMKn/Ovuwxz6AdP1ffae3OhghxWl6+hRdmK5YpAiCSGZGy75UYdNh7SRGP
 ysmTxzR3Q/q/zuIjIQhS2dwvfZEEBNxd5XKlL4Q//7ytG9KpZ6/2mYw0Axq00fjOgatg
 n01dhWGNXun7XObYmwhkDJ49viBnr3ctGWDo1l5JgSyKr0bj1WIyEmyazn2JFldktGmp jw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxwpgmt3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 May 2023 16:44:08 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34HFVvWF032152; Wed, 17 May 2023 16:44:07 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3qj10bpkpy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 May 2023 16:44:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQVw/q4f1XMxF9yVHMGYnErT15p0LccsHiUyhOZQ9ihXRtC3xtrzQejSmhpPXmQYFH+F7LGABX4pnAqzrfCAK60B6oyEh+i090ftlAEGFtz0s3wCSUZEgYkzMC9W8uSAp2PvanzuWbO0unTMWOBzudgXJx6Oy/v49TC0gnGIbl1VdfLcBnAB8ZRHm5o1O6uX1bQN9AxEDwjr3d2dK2oUETMk21ijMZsMBiey2yeiES6pHrEyD3WH+frf5obJfU+mEVNnQRB2erF+uj6VehqSdkEo9dcDCE9yhrrs478By4aCTVNHyfeWuKpwljCrA73rYsu8x9as8bcvRcMF6DdCkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIzLa1pSOkDksGQ+YF2WRh18rAUuUnSQyy4a6T4pJ4w=;
 b=cpt9jAz52oFYZPu5w5IP7nkzC4pVIP8wG3qflwhn6QE0wE8ikS7Gg2pSVv00h+T7wNsf8sfu7UKz9Y9TBhyVpuFtIuikHjffdmIGg7i3OMiE5UPARocI07VLSqghwP9NJknVmGoMOf556eItJes+1XwheGsFN/tavemZwS4UK4majuK0x89Y1eY12jDoNB7Ex81Jiy18UJoN8++I1DrSAHifXzsVlDSMfxQb1E6N4Ozbi2IAHICZ97UOtMAtLdDmLIhxcj1PRcbHnEPJUEqj210yD4ZWzzeAWr7eUemck76V1Ww5DqdsOumD10mb0GIOBOaDzkydN406BvyxCiNkBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIzLa1pSOkDksGQ+YF2WRh18rAUuUnSQyy4a6T4pJ4w=;
 b=fYjZ9NM1kIZg0YAo2x7DsDLy0qFN6U6vItXT9mR2mD90oyEYRN6NuDHeV4huoEK5YmQ3p6Y3g9LJ0Jwn0Df59Xl5ircKbJHbf3eUW2nVmocGIJ3cFbw2z444eXf4ha3Qc5z7PhOmHIwIaf3xvnh7UrhoSX9TuEl+HNdE/Oi9lYY=
Received: from MN2PR10MB4013.namprd10.prod.outlook.com (2603:10b6:208:185::25)
 by DM4PR10MB7473.namprd10.prod.outlook.com (2603:10b6:8:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 16:44:05 +0000
Received: from MN2PR10MB4013.namprd10.prod.outlook.com
 ([fe80::23d1:65a1:d474:3b1d]) by MN2PR10MB4013.namprd10.prod.outlook.com
 ([fe80::23d1:65a1:d474:3b1d%6]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 16:44:05 +0000
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, armbru@redhat.com, elena.ufimtseva@oracle.com
Subject: [PATCH v1 1/2] vfio-user: update comments
Date: Wed, 17 May 2023 16:43:56 +0000
Message-Id: <7340a298bcda0268b3decdd772ebce84bfcedcd5.1684338236.git.jag.raman@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1684338236.git.jag.raman@oracle.com>
References: <cover.1684338236.git.jag.raman@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0096.namprd03.prod.outlook.com
 (2603:10b6:a03:333::11) To MN2PR10MB4013.namprd10.prod.outlook.com
 (2603:10b6:208:185::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4013:EE_|DM4PR10MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: e0b6865b-85c8-44d4-ad11-08db56f5eda4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rz7AQUCCDcJO+CGdhjoy1tOrcCH8/I7f4Pwmp0eUcI4AVA9byoKCmT9r8pq9uj0mJDWrUq/X1bDs8rEuYF3RDcH/mumhfvJztcnJHOKWugF9TNOnr61Bx0o+C4DDXElQ0sTivhiFFX8GpaAZkqvkQLmEnSoM/sbTMEQy2M906aLqp37R63bcFW3kQwVm4tNSXQiDROgtWlWopDtvv/7JgBKJ26t2VGAhoSj8GeZmSMEjvXFVBErvxsO0c8fhI2KsJFlMrCK7nSh8FJmK/At4NqOZAHAFz3GASrCIo8VC60GyPWCAJHartXya6B0pVqA0F8OgaKGanxVVGRqg4w9sakOX3DLhMVO5H5Yw2CbZKQSSeEwAgmFAvA+xplBkGzpUZ+5D6+lVu6HczpdS5DbPInWjFJ+kYrYPTgUD2YyHV447E66hY83ntCvTz0+oiN0N3sUBYjlpWdypRmnbywqd9WJqkteXDpjfmIKc7qpxRTqDtX+9pLFYRxkhmI8ssrgAX4iNKKtqSIXywlIL/m5+ZiWqqgMqC19TqnODCh3yVcZv9AYG2F5uOznHi8OwQGUb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR10MB4013.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199021)(83380400001)(6486002)(478600001)(2616005)(6666004)(6512007)(6506007)(26005)(186003)(107886003)(15650500001)(8936002)(5660300002)(8676002)(36756003)(41300700001)(6916009)(38100700002)(66556008)(4326008)(66476007)(2906002)(66946007)(86362001)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gqhcpr7B8P76IRWevq8fJKz2STKHbJdlhI30jyEE809ZckZM8NoJrhse+gS1?=
 =?us-ascii?Q?GGeinwW88zG8dw/tP+DROiVrbjblbZkhE74zyeGRPNTIai6JfwNAouEzy+CL?=
 =?us-ascii?Q?yK1WDug44Y6ulKEoKNd7tulbHOjwNukQWyx54wyt3sx5pRoxuJP8ehLU/Shu?=
 =?us-ascii?Q?Brl4A3zaLjSS3HBziwPGMPDQ66m0I1zP653UEeGEbrAd4tu9f1UUsQ4KioXN?=
 =?us-ascii?Q?K4wrSGx2T3f1Cz3uvcvlA5tR9BPAOdCf/o8Pj6J0mE9Sc0tYZlYgc5GbxW70?=
 =?us-ascii?Q?+pzRJzCc6+ObXKdaNExISC5qh6pS425b+zbPi6wClkrLhRY5bOn4cA49PozO?=
 =?us-ascii?Q?dWbJvPLSidQiHYUH4V4znIB0kFgXsvFldXD9EfFb+eQrmioDZDemOgfM5yB+?=
 =?us-ascii?Q?2QCc6Jk8I9XOpI0QTH7W9VgFh3ODWPagqlrO1/Ak5bGNWdJjvaz8SLbJjs2I?=
 =?us-ascii?Q?Y9IMWXBKIf2cD+XZGAt1vviY8KETO7nyuz3ZxzTeZljkdvvKW+Cp7X/5KbBz?=
 =?us-ascii?Q?KirK5r/TfLw6X2Fik5BbqeMo6hPun8gA9feMci2CxQpzaUjrv9or439SdEtW?=
 =?us-ascii?Q?/DDm+lAjmDrxBikkua6WFWmpMjx3wDKSe1wov5OkoulU7G5iP9TxwOftJ3vf?=
 =?us-ascii?Q?pCEz43T/7lKwDduY9X5NfkKPSi+gc4J+AMoZ0r2oHkZiM9f/7dnSXw9pjDSp?=
 =?us-ascii?Q?u8rRQce6HWcdLxSlsVpCnTVHM9QumzwvZ4Hazfh//U9SXvvowraAhxemQ/iv?=
 =?us-ascii?Q?b3LDZm5MDhG2Hhkt91XneTpkFB6X43+3FYR5t7sMxj4GWZfeMeFfnlZYTb7s?=
 =?us-ascii?Q?IwIUDeY9Xri652Z9kuv0aE86xeZ1TEfdlkAniuezsGg14myvPC3UWYI/I2tk?=
 =?us-ascii?Q?nmbZEOKf0REkwMpIyqdImzdAp2sDqSNsbEiuhqqQFf+8aXcY69FEGfNqCayE?=
 =?us-ascii?Q?DdFrfReoOXneZ5HxHBNt8zBva7qPqRAwJwo65YctgZKqLCgjsy61lFzA8hVO?=
 =?us-ascii?Q?KltgBV7i2NvQZB+3JnmMxzFHpRg1fKl6tOqeF/XYLRoUkoeWxQuWPW7OzJxD?=
 =?us-ascii?Q?HzI3wcAzO2/INtXHKqXmA1XwcN7eY54ykoe324NmXw5XAnjMpUlKccUDLW/N?=
 =?us-ascii?Q?nY3pQJKsdU1zngwhA7Q0A8gCAmZAxvI30YdtqF1MuLQWLBn8VPX988GH+nu5?=
 =?us-ascii?Q?S6wTWuOP9fNDoGdxVRNEPGyDWCbDoBj2/dEidVbjaeUjEzAbGz3mhSyQr4tK?=
 =?us-ascii?Q?wieIKpHDMr3PltRXcwZ8pg4mnbyUJB8tp0QYF16j+dpNd4H+mhCWNEZebG0e?=
 =?us-ascii?Q?YV0RTguGJ/McZdoATzie+x/+vANG78c9hPwA3isQxq51W/cbPhw/FVp5FKWv?=
 =?us-ascii?Q?LAzKiAJrzeAXfbO3GBGAwcaaLwWGfuvDFewJNWicZCvNkzcEyQfuxbjaRZXd?=
 =?us-ascii?Q?dGqIp/KVSMtzHw6ZdwiUTWZA5y6Gni5gUC/5pW4AaI11bzDOJoF0Mhb8OlTf?=
 =?us-ascii?Q?kUyMSEOKKH7X84Ww4ykZRZ9SeHGccgJj7KfcEf0Fy6bOrJ4h11RWyu3N4xny?=
 =?us-ascii?Q?d9Gg1RZ6m1ye1RkYzP/cUFk5NN9seQeQ2XBfZnjK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 590C0e8YVsIn/My338Tm9YGVIb9qY2/b7+mRRP46Jz7PbnSTSh5ghu20OhXQkClKXw6nozbUAGeaRbnSdBAbeJlUcOtFxWm2VVwdPuLGeMSWfwOQ5QdA0yQhpgMkRViexg+g+ENF0f1R1/dRjzyB8aScUX6lNHt1yH6NeOtMnKsd9uEMAWRc1fD0ovTjl3Bf4b1A45MJlwOWAfQu9dQAy3Pn/cSnidZxrHqWygKvlz+D6T1BwQqlNo3xDmfhDmaYzS2wfjtekG8OOmwfnVimUuwE6XTgfVt3hckkCe58D7Q0Xci/w4ppyd3OAuGH3AH8mfuwuD3/d//vCn77eIGC5oUr6woqClqj+0ZJdENIjvVrbBj8oj1JaK61ccagyFHQvdQrYJGr3SXncpZPRJD0Db7Um6GIENgz74/S0N8cijcf7k5bExLmHkTsY8WxtwqwZVHe/lwbR+h3z+7HHEVu4XoSiVYCeZi2Bqh9+QBEOgifa3hUAVcP6hpS2qmUQpyaL1qofecLlX1/ZE+QBGE8mUNbVqF1Jn3tGS65YFjaik10kpqSCaclXNAIUkBPDJ3DrkNd2SbZS+Wyjs8vdwNJWKueX09T/OJfmtBVHm4nQ4u2x9XCfXW7w1RZQ6dq5lDBT/narzLtkaZgC2ZQkKNnIjacRcREJLudYXneMRMeSggN0xqkOY+ChPLd2lrHymswghK0EPdViFtwkvxORtsMwou9HaDsBEn5tw4QlrKeDayiFHcHKMjCyhVcHo01U+IC1vQCWQ20/+m9Tb7zpFdNfw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b6865b-85c8-44d4-ad11-08db56f5eda4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4013.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 16:44:05.8170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V6Ev9dYCWAyfPklO4BA6r8mtKBT7kLBz0LvOVmC4axUdGI5xBbZe6eup2rhzm/JHP4m0r/mugynAH+MlIHavYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7473
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170136
X-Proofpoint-GUID: MmJ4eE5-a_vGZ-g-Eo8MWGrbx2nfetF3
X-Proofpoint-ORIG-GUID: MmJ4eE5-a_vGZ-g-Eo8MWGrbx2nfetF3
Received-SPF: pass client-ip=205.220.177.32; envelope-from=jag.raman@oracle.com;
 helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

Clarify the behavior of TYPE_VFU_OBJECT when TYPE_REMOTE_MACHINE enables
the auto-shutdown property. Also, add notes to VFU_OBJECT_ERROR.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 hw/remote/vfio-user-obj.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index 88ffafc73e..8b10c32a3c 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -30,6 +30,11 @@
  *
  * notes - x-vfio-user-server could block IO and monitor during the
  *         initialization phase.
+ *
+ *         When x-remote machine has the auto-shutdown property
+ *         enabled (default), x-vfio-user-server terminates after the last
+ *         client disconnects. Otherwise, it will continue running until
+ *         explicitly killed.
  */
 
 #include "qemu/osdep.h"
@@ -61,9 +66,12 @@
 OBJECT_DECLARE_TYPE(VfuObject, VfuObjectClass, VFU_OBJECT)
 
 /**
- * VFU_OBJECT_ERROR - reports an error message. If auto_shutdown
- * is set, it aborts the machine on error. Otherwise, it logs an
- * error message without aborting.
+ * VFU_OBJECT_ERROR - reports an error message.
+ *
+ * If auto_shutdown is set, it aborts the machine on error. Otherwise,
+ * it logs an error message without aborting. auto_shutdown is disabled
+ * when the server serves clients from multiple VMs; as such, an error
+ * from one VM shouldn't be able to disrupt other VM's services.
  */
 #define VFU_OBJECT_ERROR(o, fmt, ...)                                     \
     {                                                                     \
-- 
2.20.1


