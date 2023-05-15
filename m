Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFD9703EAF
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 22:35:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyetL-0008Ul-L9; Mon, 15 May 2023 16:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.devolder@oracle.com>)
 id 1pyetJ-0008UR-Uu; Mon, 15 May 2023 16:33:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.devolder@oracle.com>)
 id 1pyetH-0005Mq-RO; Mon, 15 May 2023 16:33:57 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34FJsYDA016334; Mon, 15 May 2023 20:33:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=XDOq9HRyH5/gsQSti5MpSosqTuqTxsVXnU7sy+kS5Xc=;
 b=o41irfzVrzFmkcuwPdlY0RVcX7NlLhoRUxMKQrf7TV2BokzvVgJC+ZIbSUKtjNglmYSh
 WImbyujweuskiaTrfei+mJGNh+Q4L4y6NMJIZ43BzH+ZgNDIswRnomFJRbwm1JRvI84k
 ECuUBZHEGKMUQ1T+eqru9H0/iBBI4b8E+eutwnnH8DJkzNbAwcZ+4AmhCKvEmVFS2FwU
 GD6m7CKbmCsbai+E4kAhW8d6Bp35dBYpCEith2KwL8gVj1ov42mOiC1ydRF2ZbwtkThJ
 hAbS6mngK9LBpYTQKwzYfVtedUv0iHAvlE31K26+O4GsvQOggtwL0a30TiE9ntfHlVT+ JA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1fc1863-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 May 2023 20:33:50 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34FJgwW4022140; Mon, 15 May 2023 20:33:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3qj109eb8v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 May 2023 20:33:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9Aoj8DHSFsW6n0MFZgs9622vttnd0l7IZEg3DiirIt7Tzxzl3vl1jLM7CRZkve7wsuAxSmQD5UTqnjEHZNF6VT3XOqu3jtldmPWPmzTERzcdJhFQIR/HH+Mb3IgUyXIsB2brHiITzktg9eEWrmnY+TGduNzEyqYqDJI/LdIMUFaoitXrgjslmLTjOm3nVSwNpCwqh2qFPFwdz612e9pom+7a3QkWNQm6fCmCyuEaryWQ8ZY3DDM42NMgnMJdWTcsM5yyGZRlRaEUhIv8w+elLXdS651aTUJ/Z9eE3Zx3lRDnU9xsTNdTZ3mDaY8gGi6jpYkGjdRlCtjaJ+yPBoMsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDOq9HRyH5/gsQSti5MpSosqTuqTxsVXnU7sy+kS5Xc=;
 b=f353ZboQbNBlW2QI+GkQUKsQ4E/mCiG2wuQP0gI6Pkg+7dQSPNn3+K/RhEa05FRf+nQYBs1FOgHn0p5hi5zzvQogNYp6KWRhdSbSfgCu2RvxA/WgSO28+Y81nBdAKZyClJYwUYwboBMkx6ScEkvNTgUZoxAVTv0PSCgjGOh914OyVBTKM6zclCYeyl8jO4izjVCnXT02FX0d6FQwmelmuigD5HfsgGXnyIet+w5QecGtEyhrJPxsL/bQJbC2nnatqbSA1iMa2v8TvysHLnDecLgdGVi04zgb8m65v0eHaSJFP6CpZIsNsZjvcKAFRpgU/BvgHlTMp++1fPnJliFp6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDOq9HRyH5/gsQSti5MpSosqTuqTxsVXnU7sy+kS5Xc=;
 b=mU9HqUpp94X+wo9KlB/Agqq8YbusPFDq4z7kXVokDlqSCJnJjIDlkLTIZjoVSM/SgGBJyIKnbP0KoTpTK/WgI73pqZhOqRxjCOTgLGMemj/tCApgqUeBCrGdHM0x7oUejsvwiR41qJ5ypu+dv+9z0yJ53MkhJQW/HMI1+7hS7m8=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CH0PR10MB7412.namprd10.prod.outlook.com (2603:10b6:610:184::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 20:33:28 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573%5]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 20:33:28 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
To: qemu-devel@nongnu.org, shannon.zhaosl@gmail.com, mst@redhat.com,
 imammedo@redhat.com, ani@anisinha.ca, peter.maydell@linaro.org,
 qemu-arm@nongnu.org, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net
Cc: boris.ostrovsky@oracle.com, miguel.luis@oracle.com,
 eric.devolder@oracle.com
Subject: [PATCH 3/3] ACPI: bios-tables-test.c step 5 (update expected table
 binaries)
Date: Mon, 15 May 2023 16:33:11 -0400
Message-Id: <20230515203311.2139-4-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230515203311.2139-1-eric.devolder@oracle.com>
References: <20230515203311.2139-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0178.namprd13.prod.outlook.com
 (2603:10b6:806:28::33) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CH0PR10MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fbb3cf6-a31f-4d9e-3866-08db5583a3ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pzd7sIiTIF2BEK5IqiLRJDPTTTurk1Q2HC+C3P1pMhjicjQvZbtSNhQlKgFpLiCWgmGiR6LOHV6qeU1ZZK1KebOJVCDAZDhx0JvPvLsnDL1g8Gdy3aVpp5JIWq4Z+qLWzj5TEzN8rmSa/WpIUIDHTwBhgx3aP+UZjFYiOehbYkQ/qs2zJpaBwVYV1ALMfIKRwI+xuhCSF345jIDErlbzupZKqqPNL6pOqxRey+6TokKtfDSdJm3NfC89ncVblyHKTvzSxug8EFgVGEuAw8RgxtbbBAULf61NGbStQZFkP6rhoOrjcZiUD/7c5s8dlGpTMMwdM9oSObbV9EdVIB4p7J1GD1PWoKdcEQx9ri32cQB2Ryr/tuuEjVIuYkivZp/1wK4fA+BaoS3ikF4rvVH0XilJ1GfynWEl1LIEAEF6rF734VjwBEZJZI4Ru+u/bN+hkEF5mzW667Z/J7gOsttFTiWJZ+haLJLmM3QU12mTn9txDPjRABjMvcTgIW1NTDv5Yx6wPzt3VQ7/0R+YwUrj9kqrD4Iy1rKazu3xUUh/n1KJlzTsKIgc9UIZ9PjlmAAVbH5j9q63yKze+jATchQI5hbjzVjrOGpBlyS4T01r6T0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR10MB4531.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(396003)(39860400002)(366004)(136003)(346002)(451199021)(86362001)(478600001)(36756003)(107886003)(186003)(6512007)(1076003)(26005)(6486002)(6506007)(6666004)(316002)(921005)(38100700002)(41300700001)(66476007)(66946007)(66556008)(4326008)(7416002)(5660300002)(8936002)(8676002)(83380400001)(2906002)(15650500001)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k26KhE/24Yub46ZdnKXAnRVaTqvuEhArpY/e03Rr+Ojhs8O2FlTHmOxitd4R?=
 =?us-ascii?Q?xCEDnUq86KVypKBHRkz5wkLzOur/K3ROVo03XZ/yEYhufMG+gAtal5pPFNA2?=
 =?us-ascii?Q?wx5HzVJq+Cj4SDziKHOHgbfXrPTKOlHvnEqHOyhsALdia2AeU7lAq/QugT0P?=
 =?us-ascii?Q?SwN3l50l4Ou/0Rh245YSRpz3DvwKo5ac6rE96wtj6doLvEETtUxVTagfaA+S?=
 =?us-ascii?Q?uckLgjHHvPTeVeP4L+8OMxq8hVshuP5507JUhaghYH7c2Y7zlZOhtTzfrUFa?=
 =?us-ascii?Q?DKIgAARa0aVbP1+ZUGtWS86G7zu+aqzsl97mioIXtTC7wWqeLg1O42aU1aDw?=
 =?us-ascii?Q?r7jxpO6g05aPEOdmnuOUs5l5d0hQs0LtizwX3IHQPGO1BYfkh3/kfZR+USoO?=
 =?us-ascii?Q?UbGwfRM3/SBI2I9NiqhypGqYix61Iy7GXoUYJfiZ8aht4BZBeeGEK5XJFUPf?=
 =?us-ascii?Q?AFxySeBhEj2If2bmz7bJduzyRqzs/e4KEVHYBBa2ndRZR8bu+0UIFflSKI7f?=
 =?us-ascii?Q?/L7zMtBAnkRq2W5vL7cclenzTWGjpr+bgXoqhfsWaSOQAcFfAogxZvo1XAsX?=
 =?us-ascii?Q?MxiPNU/igeaWH3aqgATR5mjWGfh5gn/tf/rGkVufk6GZa3AowOPl50PuqzdK?=
 =?us-ascii?Q?XAw8mqopJzQ7pY4paVn99UNpPFXr2AFUy62zhBLtOqqFQYj5JVvzwQeEYbTz?=
 =?us-ascii?Q?YxypHZ9PFs1JiZMScy4kCEIZfAKgVqAiJo4vkfEd63Tl31D+lbfYZA93vEHs?=
 =?us-ascii?Q?kCRLJWqz70F/KRjm50igcXJOlWiZ2icgUakpVXLdR1HOx5IimnEioGTlzmJw?=
 =?us-ascii?Q?UZGgzynSJABYjYotZOc3d9YQRdnlTqeOYQxRS/USZAnuxAQMgaCWGiuSTHqG?=
 =?us-ascii?Q?vswYJOZq0/BY6y11blIIoxLbbNTYytDdUxBrwd2u5cdD1XsJ/Tu9Hy9UUXPq?=
 =?us-ascii?Q?NnsN5yMLDhM/1RjuRuChwTavlqc8qIz09RuZMQV2Aaj4AXWi6BDdyAxwr0ew?=
 =?us-ascii?Q?BWOwUqC68myO3xegpuq96ztkxB9TDYuZwLuHjejlHh58fvKgkRK1mYVeWAdy?=
 =?us-ascii?Q?vncnCBn7VKsmptwF37zTwO2YjLus2LCiOrehFOdwNVT3YdFYXDKjDKaP5XfQ?=
 =?us-ascii?Q?o8XshQNlTn+At9UFeT2ccmQiOg2gP8HLWGzflrulHgH6A43iTfn2L+OB0nsH?=
 =?us-ascii?Q?xOkiVIydcPzvmvM+A1+WVpXAKnn1S0vaFBsZnp4bO2bhdA23M3ZmUM5T0I+W?=
 =?us-ascii?Q?vmATeY786Lgcs2vgeXXJdV45FTvgakXzRph823LIUePE7O21J8ZY0eqpjI1x?=
 =?us-ascii?Q?+OBET29ycoVvpEfQlycKtuccKJ9bM0npP39I3rhM9EfsG+ZPBixE+NzxfKUX?=
 =?us-ascii?Q?DtIEpR1ZIzC8M/a8Gz8aKJxCkVOkqw4tpe3psbzIs+R7j86O8LTpoerNgEbM?=
 =?us-ascii?Q?hLZjkHauxHJqJFEyHM6SVLsT7T39yzUTuv0BSHGbIFU1PzQ24yLNJcklcesK?=
 =?us-ascii?Q?Za44u2lAWKwmDaxcoid+dW0eDB1RG0j/MnBUa5rPD1EAPMRDrYirXSSuWyW3?=
 =?us-ascii?Q?/iASyZfy6KjJWXTY30WsK0FR/ceAFMD2Ld3tk7gj1Xt1G3UB8fkwAvU8eSwC?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vhBSqlkyz8JeLH+o2x/masp9h1baCnx/bkSYo/oE2M34VgyRjgVxo7ta9Vpkja4iQhYDs7OjqDbnECt7vGWSx5iTDmI2G1PqbxC73VSD4Zqz3KgmxTZTeCCTTqz/surqiKMI4S69s+5zjG5ROG1PpmKqTfw6bfgVLZf/01th7d/mh9T/zmcpDVPOOYDBF3JoQdfaLGl9yQzkLe/dKkZrk6hhLOdsQ5xw3QRVPxrI3cmJThj6uyuZdtUInC+E0ppD6iRlEh5k/bjLbDVZOQJuTfdpJD+Z12c4WIUjwEnr1xfifi0uRBDWU+Z2WqqfPmFb2IVKBBTxP+kVrcIEOVgdR3+hOgjs9ciOU4FmocloqVIYDkvHUZGDBLmHs/YXr1041S8p3MJGHEAZTqOQvZRDdZOt4A0aq7Z4PONy8Rdk0YMrb6gDHhcBrKD8/Q7TB7nwu3I2ohWUlwXwkSsCR9cBY9HnyOVwvWNWPeFzbJqoMJ6gwd7qo3kDdi1E2gbQQxb9z4YIDuZHQrgbzYKrjpF3RKXsRmO9RiWmX6i1kbIhc98g1atAbXvHlB9iPidbECWZ5OL8EM8wNNKHDu8cgysO+IVt1QxJq8koAFYFLnPaVUbU6o0sQg+hVMA0X+zSY6hffhaw5iIFBL8dZhcEigkm/Yk3GE8XLmmxgCTaK21ZJNIkPa8o0B21hXWVaEtKGMRcSTwE2ZC9l6LkUYiOCG5084RJUrAEcc7BZOQHYIVw7BNFYHzEpmd44O9/T8ysEI2RyAIIBCncZMm8qGrpRdtw8uXqMbqWQ+MTHbCKlk2nhALGba01JoO51gyIqW252JHQwqrJ9LEj7+DlZkEZmXhGWlb1YS34kdopJ0yMG1f5IAH3u/nWcBjopDfV3kugGK64yDD6BTkvea2uXUziH3RZQg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fbb3cf6-a31f-4d9e-3866-08db5583a3ff
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 20:33:28.5253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81+ytgqlhzfHOxlS4v18j8JghieyjI4oReRENS7/afGNeNkisL4QJ7sFWl0ENnRmI4m4r35K9zcN+1YPFOR5Q8baXutq3w9162kS85olF7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7412
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_18,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150170
X-Proofpoint-ORIG-GUID: Y-1rVhTaBCifS853evbAiPI-D5or3iK1
X-Proofpoint-GUID: Y-1rVhTaBCifS853evbAiPI-D5or3iK1
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=eric.devolder@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Following the guidelines in tests/qtest/bios-tables-test.c, this
is step 5 and 6.

The MADT/APIC table diffs show (for pc, q35 and microvm) bumping
revision from 1 to 3 (and checksum changing accordingly):

 Using expected file 'tests/data/acpi/pc/DSDT'
 acpi-test: Warning! APIC binary file mismatch. Actual [aml:/tmp/aml-9UKC51], Expected [aml:tests/data/acpi/pc/APIC].
 See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
 acpi-test: Warning! APIC mismatch. Actual [asl:/tmp/asl-CFKC51.dsl, aml:/tmp/aml-9UKC51], Expected [asl:/tmp/asl-TMFC51.dsl, aml:tests/data/acpi/pc/APIC].
 --- /tmp/asl-TMFC51.dsl	2023-05-15 14:15:26.599183824 -0400
 +++ /tmp/asl-CFKC51.dsl	2023-05-15 14:15:26.598183818 -0400
 @@ -1,32 +1,32 @@
  /*
   * Intel ACPI Component Architecture
   * AML/ASL+ Disassembler version 20230331 (64-bit version)
   * Copyright (c) 2000 - 2023 Intel Corporation
   *
 - * Disassembly of tests/data/acpi/pc/APIC, Mon May 15 14:15:26 2023
 + * Disassembly of /tmp/aml-9UKC51, Mon May 15 14:15:26 2023
   *
   * ACPI Data Table [APIC]
   *
   * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
   */

  [000h 0000 004h]                   Signature : "APIC"    [Multiple APIC Description Table (MADT)]
  [004h 0004 004h]                Table Length : 00000078
 -[008h 0008 001h]                    Revision : 01
 -[009h 0009 001h]                    Checksum : 8A
 +[008h 0008 001h]                    Revision : 03
 +[009h 0009 001h]                    Checksum : 88
  [00Ah 0010 006h]                      Oem ID : "BOCHS "
  [010h 0016 008h]                Oem Table ID : "BXPC    "
  [018h 0024 004h]                Oem Revision : 00000001
  [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
  [020h 0032 004h]       Asl Compiler Revision : 00000001

  [024h 0036 004h]          Local Apic Address : FEE00000
  [028h 0040 004h]       Flags (decoded below) : 00000001
                           PC-AT Compatibility : 1

  [02Ch 0044 001h]               Subtable Type : 00 [Processor Local APIC]
  [02Dh 0045 001h]                      Length : 08
  [02Eh 0046 001h]                Processor ID : 00
  [02Fh 0047 001h]               Local Apic ID : 00
  [030h 0048 004h]       Flags (decoded below) : 00000001
                             Processor Enabled : 1
 @@ -81,24 +81,24 @@
  [06Bh 0107 001h]                      Source : 0B
  [06Ch 0108 004h]                   Interrupt : 0000000B
  [070h 0112 002h]       Flags (decoded below) : 000D
                                      Polarity : 1
                                  Trigger Mode : 3

  [072h 0114 001h]               Subtable Type : 04 [Local APIC NMI]
  [073h 0115 001h]                      Length : 06
  [074h 0116 001h]                Processor ID : FF
  [075h 0117 002h]       Flags (decoded below) : 0000
                                      Polarity : 0
                                  Trigger Mode : 0
  [077h 0119 001h]        Interrupt Input LINT : 01

  Raw Table Data: Length 120 (0x78)

 -    0000: 41 50 49 43 78 00 00 00 01 8A 42 4F 43 48 53 20  // APICx.....BOCHS
 +    0000: 41 50 49 43 78 00 00 00 03 88 42 4F 43 48 53 20  // APICx.....BOCHS
      0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
      0020: 01 00 00 00 00 00 E0 FE 01 00 00 00 00 08 00 00  // ................
      0030: 01 00 00 00 01 0C 00 00 00 00 C0 FE 00 00 00 00  // ................
      0040: 02 0A 00 00 02 00 00 00 00 00 02 0A 00 05 05 00  // ................
      0050: 00 00 0D 00 02 0A 00 09 09 00 00 00 0D 00 02 0A  // ................
      0060: 00 0A 0A 00 00 00 0D 00 02 0A 00 0B 0B 00 00 00  // ................
      0070: 0D 00 04 06 FF 00 00 01                          // ........

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 tests/data/acpi/microvm/APIC                  | Bin 70 -> 70 bytes
 tests/data/acpi/microvm/APIC.ioapic2          | Bin 82 -> 82 bytes
 tests/data/acpi/microvm/APIC.pcie             | Bin 110 -> 110 bytes
 tests/data/acpi/pc/APIC                       | Bin 120 -> 120 bytes
 tests/data/acpi/pc/APIC.acpihmat              | Bin 128 -> 128 bytes
 tests/data/acpi/pc/APIC.cphp                  | Bin 160 -> 160 bytes
 tests/data/acpi/pc/APIC.dimmpxm               | Bin 144 -> 144 bytes
 tests/data/acpi/q35/APIC                      | Bin 120 -> 120 bytes
 tests/data/acpi/q35/APIC.acpihmat             | Bin 128 -> 128 bytes
 tests/data/acpi/q35/APIC.acpihmat-noinitiator | Bin 144 -> 144 bytes
 tests/data/acpi/q35/APIC.core-count2          | Bin 2478 -> 2478 bytes
 tests/data/acpi/q35/APIC.cphp                 | Bin 160 -> 160 bytes
 tests/data/acpi/q35/APIC.dimmpxm              | Bin 144 -> 144 bytes
 tests/data/acpi/q35/APIC.xapic                | Bin 2686 -> 2686 bytes
 tests/qtest/bios-tables-test-allowed-diff.h   |   4 ----
 15 files changed, 4 deletions(-)

diff --git a/tests/data/acpi/microvm/APIC b/tests/data/acpi/microvm/APIC
index 68dbd44a7e35a356083f086df60f70e424c4249f..672764e711d80402890902ba9ded10915770e84c 100644
GIT binary patch
delta 16
XcmZ>B<8ln}barE4U|=qq$Ylcn95e$)

delta 16
XcmZ>B<8ln}barE4U|=kn$Ylcn95Mq&

diff --git a/tests/data/acpi/microvm/APIC.ioapic2 b/tests/data/acpi/microvm/APIC.ioapic2
index 3063c52cd3e9bbed29c06031b375900f4a49b9e0..6f24fdb12ce3f1c13df7ff835e475d8023e20d4a 100644
GIT binary patch
delta 16
XcmWFv;&Ke|bPi%*U|?>X$mIb59$W*3

delta 16
XcmWFv;&Ke|bPi%*U|?*X$mIb59$Ev1

diff --git a/tests/data/acpi/microvm/APIC.pcie b/tests/data/acpi/microvm/APIC.pcie
index 4e8f6ed8d6a866429fc17aecdeafc3fb5ef65fa3..2239ca76a607fb1ff9d392298e2bd6461bba7ecf 100644
GIT binary patch
delta 16
Xcmd1H<8ln}bk1X7U|_DA$dv*BBD@3c

delta 16
Xcmd1H<8ln}bk1X7U|_77$dv*BBDw?a

diff --git a/tests/data/acpi/pc/APIC b/tests/data/acpi/pc/APIC
index 208331db53b7dd5c6205cce0e95427636b86dd64..868a3432f0295257393e45b75483ef4bec455d74 100644
GIT binary patch
delta 16
Xcmb=Z;BpM`bgp1vU|{Z;$dv~GB#s0m

delta 16
Xcmb=Z;BpM`bgp1vU|{T;$dv~GB#Z<k

diff --git a/tests/data/acpi/pc/APIC.acpihmat b/tests/data/acpi/pc/APIC.acpihmat
index 812c4603f2701494f6bb761570323158a20d4043..125d1ff0871f772bc8cfe3e2afbff70edf221291 100644
GIT binary patch
delta 18
ZcmZo*Y+&Sa4DfVrU|?WiE}h6#1^_241Tz2t

delta 18
ZcmZo*Y+&Sa4DfVrU|?WiET70#1^_221Tz2t

diff --git a/tests/data/acpi/pc/APIC.cphp b/tests/data/acpi/pc/APIC.cphp
index 65cc4f4a9aa2676140a6525cdac1e838274b1e07..a2c2a24e5e3cf143b57a8932f78eeda6d7b8bbdb 100644
GIT binary patch
delta 18
ZcmZ3$xPXz%F~HM#0RsaAv)DwgX#guQ1XKV3

delta 18
ZcmZ3$xPXz%F~HM#0RsaAqr^n6X#guO1XKV3

diff --git a/tests/data/acpi/pc/APIC.dimmpxm b/tests/data/acpi/pc/APIC.dimmpxm
index d904d4a70ddecbb79a83a267af8e26f925e9f4c6..9b5922bc72db1fe64819a3970d6ca95543da799e 100644
GIT binary patch
delta 18
ZcmbQhIDwJNF~HM#0s{jBv*$#vHUKF+1V;b>

delta 18
ZcmbQhIDwJNF~HM#0s{jBqxVFvHUKF)1V;b>

diff --git a/tests/data/acpi/q35/APIC b/tests/data/acpi/q35/APIC
index 208331db53b7dd5c6205cce0e95427636b86dd64..868a3432f0295257393e45b75483ef4bec455d74 100644
GIT binary patch
delta 16
Xcmb=Z;BpM`bgp1vU|{Z;$dv~GB#s0m

delta 16
Xcmb=Z;BpM`bgp1vU|{T;$dv~GB#Z<k

diff --git a/tests/data/acpi/q35/APIC.acpihmat b/tests/data/acpi/q35/APIC.acpihmat
index 812c4603f2701494f6bb761570323158a20d4043..125d1ff0871f772bc8cfe3e2afbff70edf221291 100644
GIT binary patch
delta 18
ZcmZo*Y+&Sa4DfVrU|?WiE}h6#1^_241Tz2t

delta 18
ZcmZo*Y+&Sa4DfVrU|?WiET70#1^_221Tz2t

diff --git a/tests/data/acpi/q35/APIC.acpihmat-noinitiator b/tests/data/acpi/q35/APIC.acpihmat-noinitiator
index d904d4a70ddecbb79a83a267af8e26f925e9f4c6..9b5922bc72db1fe64819a3970d6ca95543da799e 100644
GIT binary patch
delta 18
ZcmbQhIDwJNF~HM#0s{jBv*$#vHUKF+1V;b>

delta 18
ZcmbQhIDwJNF~HM#0s{jBqxVFvHUKF)1V;b>

diff --git a/tests/data/acpi/q35/APIC.core-count2 b/tests/data/acpi/q35/APIC.core-count2
index a255082ef5bc39f0d92d3e372b91f09dd6d0d9a1..f5da2eb1e8a93d961b39f665f2e8b02acf1aeb3c 100644
GIT binary patch
delta 19
acmZ1{yiS<QF~HM#9VY_=^SO;&OE>{I`URQ*

delta 19
acmZ1{yiS<QF~HM#9VY_=<Ase}OE>{I_yw8(

diff --git a/tests/data/acpi/q35/APIC.cphp b/tests/data/acpi/q35/APIC.cphp
index 65cc4f4a9aa2676140a6525cdac1e838274b1e07..a2c2a24e5e3cf143b57a8932f78eeda6d7b8bbdb 100644
GIT binary patch
delta 18
ZcmZ3$xPXz%F~HM#0RsaAv)DwgX#guQ1XKV3

delta 18
ZcmZ3$xPXz%F~HM#0RsaAqr^n6X#guO1XKV3

diff --git a/tests/data/acpi/q35/APIC.dimmpxm b/tests/data/acpi/q35/APIC.dimmpxm
index d904d4a70ddecbb79a83a267af8e26f925e9f4c6..9b5922bc72db1fe64819a3970d6ca95543da799e 100644
GIT binary patch
delta 18
ZcmbQhIDwJNF~HM#0s{jBv*$#vHUKF+1V;b>

delta 18
ZcmbQhIDwJNF~HM#0s{jBqxVFvHUKF)1V;b>

diff --git a/tests/data/acpi/q35/APIC.xapic b/tests/data/acpi/q35/APIC.xapic
index c1969c35aa12b61d25e0134bbb8d2187ba42d663..83bd28325af9d6d7619015a9701866b8f3f1d754 100644
GIT binary patch
delta 19
acmew-@=t`zF~HNgj*EeTS#2X%2^Ro9-UT)Q

delta 19
acmew-@=t`zF~HNgj*EeTQDY-l2^Ro9+yyoO

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 1e5e354ecf..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,5 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/pc/APIC",
-"tests/data/acpi/q35/APIC",
-"tests/data/acpi/microvm/APIC",
-"tests/data/acpi/virt/APIC",
-- 
2.31.1


