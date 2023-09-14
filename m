Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E5079F610
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 03:04:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgalf-0000m3-Mh; Wed, 13 Sep 2023 21:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1qgald-0000lq-Eg
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 21:03:37 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1qgalb-0008SW-KG
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 21:03:37 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38DMqOjG014714; Thu, 14 Sep 2023 01:03:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=KlqUrq9G5a/uFnwd8HATwVepaJrR2WQP413pDAqwaDE=;
 b=xZHVQrIOAoYaZQu4r6ADnJwsTbWYwybaEV0MUk4TA0lUvNO4GHby7SuNJ5ow1gH6qeVU
 A7q2XePwijOaZ44AHBVgBqPOvtcA4g1WbfHECwnIdiahP8vIfATaBCUOPKJQ/HiuTBv9
 /y/16OWm/GKbdhJEaBqujUb77KHtDGHZSRip3phB4CwI60u4+BUKLRb5obdqhBds8b9m
 GaEvY9FLC46+nxXpPxganXRl/XDGLz6jSlHlrGiSlMthNjmdD9Zdt8xr+kM+iMHVvMIM
 vw7XYL6fXkIZKpJw+F18hgGVZr++6IXkRZOT25sa4wcpD2ocTTJUqCT4TSnBpg1tTA/B 4w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7pkfxf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Sep 2023 01:03:30 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38E02nLp033154; Thu, 14 Sep 2023 01:03:28 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3t0wkh9x4v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Sep 2023 01:03:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzClQrZrRDu8m/cRd2aVkvkWYtiKhYPpCUXOiH2TPYEY6I7uP//R5vftqVz3VZd0mO59SlMtwv5G8+jrOTRu5NZgpUyAQF30cKs4jaMazvtgEYah5etyPpYQCgV80aWgHMk5GdAgPYpTwNw948XW57xKNEDssnhh+2g1yJwpQ/GjNcaGhMxaNpAJtElrhB+COgCd+EIchEQXuYKXnn9lEhcjr0yePYaX325yjGIce1VFPmGaNS3TbO9FLHHAcvPHFRHa3Awmfras12YiZcmRFTBShjqbyUzEM9OTx0zxxCVlFLZ3gtOqwjMqzqHSwq8d+uXMbrUeCFLlXYsi67ZZvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlqUrq9G5a/uFnwd8HATwVepaJrR2WQP413pDAqwaDE=;
 b=ff2Kbt1QTZWyzmC7fYRnFAFXy1xkacAvGyzqPOpPsN+FXrgS8roYW+GVIScbkHge6yOEyqC7JUIYIyPid8E6ThnUbRvJ1BOnyK55ZmoagnYQd/2Yd8EHEMR7GWHxhSr7kpZGghZXUZqZcvXSau29XOc9wCf3kRm6ug/dueYfOmwtAALs420g3pGJ2Pm6jfp9DKuDnLuHVn46SAeO3i3Y0rARPoAr9OTWKTseWUShAYtenzE7MdubCq2qfZw/eK4ACLRe7limVHV9DEeiLmkIMe0iwxKBT0NBFKt89tpGIZZaoHNJ0ug77GER099CYlDEK4MJLrL5TZ9rPUdl8yb6QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlqUrq9G5a/uFnwd8HATwVepaJrR2WQP413pDAqwaDE=;
 b=Zxp0dZ/q1tykje7CjrybRqxYkxPmB880abn5tXpv73VhT/KF4cuUOb5pzHNyEXVQynb/k66QWgSKQIgS6yZ8irkdhevHtbyg6tcau0v6c3yrk7KZZAx3MZr3SN2PqrAdYplfv4zI45JuDGKXJKxsTeWTVyqsObu0MI9rFKPERuM=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by LV3PR10MB7963.namprd10.prod.outlook.com (2603:10b6:408:20e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.38; Thu, 14 Sep
 2023 01:03:25 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::35e3:7e4c:72b2:cf74]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::35e3:7e4c:72b2:cf74%7]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 01:03:24 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: qemu-devel@nongnu.org
Cc: linux-debuggers@vger.kernel.org, stephen.s.brennan@oracle.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Omar Sandoval <osandov@osandov.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 qemu 3/3] dump: Add qmp argument "reassembled"
Date: Wed, 13 Sep 2023 18:03:15 -0700
Message-Id: <20230914010315.945705-4-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230914010315.945705-1-stephen.s.brennan@oracle.com>
References: <20230914010315.945705-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:806:22::32) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|LV3PR10MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: f27d36c7-2ad9-4df7-2a89-08dbb4be65cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aMvbgWZpatx3GAd0v1q/g0dXqS5TbDdeGJDFXPpm4bus5hZ8QfVh7bnxWUBEvxjDEppet/Y124iuaOXmGMnbfkIuoSoho3+OeNjzEuDthkSJ1ebpTfAgMyHXYjXGmJq3PRs1YNidfdjGsP05x11tx7sMLw3BjhicuKLjqQiTOTqb7bsYmuUxQIjpQoa5m6bIvFT9m+vxbQ2PXjRYbkFq1qN6FaDjuJPV8/gPj9SBlbm658hTMUF/9Gm32eN8JCwl5bh32PlfMJdP72iwmcVTPBTSsrtRrumEqZ4G9+gBC5S7bw0Rp21mf0WihE/PbogwgkZQk6VpdpRmX/h+raRLiwRx5g8HEjWS8lXKc+1sWxBZ/BnoABYytcTmZSv/+ntWeAfvoc/Dl/ANm0ynP4gTJxBHCh5wTWI4dpLKFNdtgrSyxttgyMxpvMCd0uqN2ycAUyRFCUxuUV2PBDtru36UzFcvX01aRa92Y5KpFDwlYCRAGSLz+v5W2HvOBO4NdNpXcHoKTjGQToQDDZtApss0CBFwIY/LP6JYWw/Dl3zwdsMFepsNRFGkNT/j0BP40nO2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR10MB6597.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199024)(1800799009)(186009)(1076003)(36756003)(2616005)(38100700002)(2906002)(83380400001)(4326008)(5660300002)(478600001)(6486002)(6506007)(8936002)(54906003)(8676002)(103116003)(6916009)(66476007)(6666004)(66946007)(66556008)(41300700001)(6512007)(86362001)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cKFm9O+kAd+NbL5DMpS8p61cqDEYpSUBLGlJWSg96Dh3zwCH9JMYtnpP16gj?=
 =?us-ascii?Q?WuG4UVjMzEH6Rb7p+pCiAibPjWZmZbuFZqUAAYqxeLqMINCHV3kM9b3mhZiu?=
 =?us-ascii?Q?YkiiJEKnxnHe1ia6uFQ2sPulHl/w3cS6awre8ursqrJVfm1/4F1ZWp0ezMUP?=
 =?us-ascii?Q?J8rgJgIWPzC2LQhyaCXfUxTijqpM/AXM69LOeUgJq6RHi+VBDaVL9ggZ27mq?=
 =?us-ascii?Q?W/sVXsfNLWs+SPtYvSnXsJS4MLuedRe0yuUkCI89ccNj4a9sXr6KsQCvZcCu?=
 =?us-ascii?Q?Nm91t31Ob0doiIg7ku9ivWT/uuRcJYlhDyBWD6/XPuYVHNLpaPeByBK/t+JE?=
 =?us-ascii?Q?1RYI8SB+N2959KrGcM5gqItvMRxFr8dhlKIXZvVM9+7BQ/tKsiFIMuALDtMa?=
 =?us-ascii?Q?ES1BHLWGIIjsGZSbxNhxkvCLp+Z+7JuCD7ejRaGJyg0jPAZZuKOMp35rYX4X?=
 =?us-ascii?Q?bt2jVhtiq54MmhjfIQg9Zi/v34jEqmClbqektGuNYA8s+rPiw0dvEYyA7tvQ?=
 =?us-ascii?Q?zMHGxSPMlVlQTEaZO6k3QW+jlR31PS08VIDxgrUQywWgs7d2tfZ0jMwVO2YB?=
 =?us-ascii?Q?ZxZUipQxPiG8pMPmRsSPudjWUbOZdfu/ezKfKlfaoOIdT+8P5F+pFMjoTYk+?=
 =?us-ascii?Q?+fAtsHhurA1TLAzrAwgjeTnw6XHCBCakenDUwiqwsXsuMpq5Zh5qlbX1nk5h?=
 =?us-ascii?Q?9p1YqPe1HSCZkymcWcNvUSsZrDYNP9faTahTZQfYxxNNa8xq3K+ejr23fCX2?=
 =?us-ascii?Q?N/mBSIVW4u6DXmIRHDxugFXFwXHhcrN77bRArxF+HVODQ6kh6AXR3H3bVY7E?=
 =?us-ascii?Q?rrD0JqxO/wxxV6phg/cUfhtIhLM8i1Ysh3WSH0QqiI2jLGV7BDpodOyQ7MBX?=
 =?us-ascii?Q?ZrVbowj85oaO8882zWyU54E31if00greI7hC1lpgujHvE5uXUgHBxeORCRpX?=
 =?us-ascii?Q?/1C92vZwyIDMb9F8IlvUoRFQKnaONBcKTfYemHPyFF2HjgG7O388RwQinTeD?=
 =?us-ascii?Q?umzY9qZiBcBEF4mIOIECDyJ56Wok1vPgWicSyLXJUyMdMsf7/g2LZQww3Hdh?=
 =?us-ascii?Q?+z+seIsUfX8iqKgKHC6lCkc746tARZPfFzAWPiCvDb91ba8QWil7LfuAbdaI?=
 =?us-ascii?Q?jsnv+hnn7inOjIv2hr43JxFujhHM50sfGEOGeisJewkcDJf4Hj998iqkxNs9?=
 =?us-ascii?Q?qCNJhhKsphyCxhbSh6wC5aghp8071/e+MdXCJsPsH8vHsJgYTjEx/hhGJUhe?=
 =?us-ascii?Q?2aXqDvb3YHuVoU8j168StVMloqPFr/eMj6I56xUrZDWdJQ+3+r+eHv9SuSzz?=
 =?us-ascii?Q?0/w6X27L3qjm7k8VN1hXkWq0U2V/MyU8L7A80Dx3P/l34t/bb29lIr1u7MSq?=
 =?us-ascii?Q?L4ysz1QaZNG+lQQMskmTA71RL+nsFDCLyrD0/VvQyv75NTyrmYKtjpmYHByh?=
 =?us-ascii?Q?NhkpeYy0ur0kHVAZP6gXqUcKExrITQw1N2RO+x+3peeCnf30ycB4w20n26nU?=
 =?us-ascii?Q?J/XCspVwCqh3dVNHIhg2e4wNoj+wz/0mEHwwhhZtnjtqp41OAtgvpTVjS0pJ?=
 =?us-ascii?Q?VxWfwo0eAVxwFs+b3x1yNXSV9t6x2Ejn3y9JrV7PXAjCZEpPoK9C9QaIkqkn?=
 =?us-ascii?Q?oZ5T5W8QIHMi8vN49aPky+9k+X9+BNfyXx8q9XOj/xzE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kcv0tOxI3aYpT3YHLh+t62H4SR808x5ah13GO8bWuuQU3WOT+54prDiOXQdDV9quirpyHn4r9qwyA1u70r7p3kNStLfvoiCFDL4KRff0UbPUVGYaV3B9AbicPyh4FEExlPGP+ZmgVbNA5zlnp5j+SV46A3NB0W6Wzpl9+Vs5ZSpO3m6Bjn1yLYLnAKXx5H2qeekGR7zxiBif8nnoscp8GgZ5lGaUEKJRh22CDXQ3dC/9W12PYkiM5yNPsnOrqNZQjyYM+LcJ/of3M/MQRy9BPkHrDb268qgHtftpRV7KGWw5sM8qUEw2kTUSOTq5BBmt8umU5UNVwsJ26OKb1njCCINcGWe5zMQdiwfHaOmw7DNs/Q7gMvpozm/W6mg6UTEGqm1gXzbafY19dzLDfMOAqUQCbkZ094/AtzyBZsXLZsaFhaIYfIQzCvj4/k1cC3P5nJKeoaNOIIcE+GgD0s2wIbA807W/NLMqrsRMBlcciBPKXih1QD7QKYo08281x3dkBVy5LnEtNzF2Ayazycg3aNB4SwmVwNYGUmMS0y2wQsXo/rCY5k1OqkaGTUQjwfeyJHrbEQ+k8m38mBp4z91GWEiF43J7LfhTueTJWuWRlK62bfZGxOUk51PAzIdhOM1zoG/SxI7Jm+J7pUEz8j4mWtU389eKD3bMhuUMTHPGKDjaXKMUVpFdaCwzxWgJW4MgeEf7uygKywfuB1NVWJ633xui702xss/wR6b1EFm8wQGX+La0taGb10a9vk3d2MlGk2e4CWpBogWq8KiXuD0U89CRer5TrdRQ9nziq0yHk/xLy4KXxVGp1h9CHD4GNAr2NMjwo7TkwtHsayRBMHwWB1jn1WLSqT3eCRTkWv3mgNU1bs6v5JJIMaoa/4j0gQD/
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f27d36c7-2ad9-4df7-2a89-08dbb4be65cf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 01:03:24.9261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V2hEKuFmjtcA9GYPb92wNE7I2AbDfaxy7rv1M7+y7C4Y2y6tGAHzq0fFGt2hImgGEo+j4eJg1apP8QJJ/VaKUjjdPHvF/3Ar1D/RpNogow8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7963
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_19,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309140007
X-Proofpoint-GUID: ZdebC5wDPqJlfr97gsOWmwxhUqAUn1iy
X-Proofpoint-ORIG-GUID: ZdebC5wDPqJlfr97gsOWmwxhUqAUn1iy
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

This can be used from QMP command line as "-R" to mirror the
corresponding flag for makedumpfile. This enables the kdump_reassembled
flag introduced in the previous patch.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 dump/dump-hmp-cmds.c |  8 +++++++-
 dump/dump.c          | 12 +++++++++++-
 hmp-commands.hx      |  7 +++++--
 qapi/dump.json       | 14 +++++++++++++-
 4 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/dump/dump-hmp-cmds.c b/dump/dump-hmp-cmds.c
index b038785fee..1d882e4bd8 100644
--- a/dump/dump-hmp-cmds.c
+++ b/dump/dump-hmp-cmds.c
@@ -24,9 +24,11 @@ void hmp_dump_guest_memory(Monitor *mon, const QDict *qdict)
     bool has_begin = qdict_haskey(qdict, "begin");
     bool has_length = qdict_haskey(qdict, "length");
     bool has_detach = qdict_haskey(qdict, "detach");
+    bool has_reassembled = qdict_haskey(qdict, "reassembled");
     int64_t begin = 0;
     int64_t length = 0;
     bool detach = false;
+    bool reassembled = false;
     enum DumpGuestMemoryFormat dump_format = DUMP_GUEST_MEMORY_FORMAT_ELF;
     char *prot;
 
@@ -61,11 +63,15 @@ void hmp_dump_guest_memory(Monitor *mon, const QDict *qdict)
     if (has_detach) {
         detach = qdict_get_bool(qdict, "detach");
     }
+    if (has_reassembled) {
+        reassembled = qdict_get_bool(qdict, "reassembled");
+    }
 
     prot = g_strconcat("file:", file, NULL);
 
     qmp_dump_guest_memory(paging, prot, true, detach, has_begin, begin,
-                          has_length, length, true, dump_format, &err);
+                          has_length, length, true, has_reassembled,
+                          reassembled, dump_format, &err);
     hmp_handle_error(mon, err);
     g_free(prot);
 }
diff --git a/dump/dump.c b/dump/dump.c
index fb9040cfbc..42d4015fb3 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -2089,6 +2089,7 @@ void qmp_dump_guest_memory(bool paging, const char *file,
                            bool has_detach, bool detach,
                            bool has_begin, int64_t begin, bool has_length,
                            int64_t length, bool has_format,
+                           bool has_reassembled, bool reassembled,
                            DumpGuestMemoryFormat format, Error **errp)
 {
     ERRP_GUARD();
@@ -2119,6 +2120,12 @@ void qmp_dump_guest_memory(bool paging, const char *file,
                          "filter");
         return;
     }
+    if (has_reassembled && format != DUMP_GUEST_MEMORY_FORMAT_KDUMP_ZLIB
+                        && format != DUMP_GUEST_MEMORY_FORMAT_KDUMP_LZO
+                        && format != DUMP_GUEST_MEMORY_FORMAT_KDUMP_SNAPPY) {
+        error_setg(errp, "'reassembled' only applies to kdump format");
+        return;
+    }
     if (has_begin && !has_length) {
         error_setg(errp, QERR_MISSING_PARAMETER, "length");
         return;
@@ -2130,6 +2137,9 @@ void qmp_dump_guest_memory(bool paging, const char *file,
     if (has_detach) {
         detach_p = detach;
     }
+    if (!has_reassembled) {
+        reassembled = false;
+    }
 
     /* check whether lzo/snappy is supported */
 #ifndef CONFIG_LZO
@@ -2192,7 +2202,7 @@ void qmp_dump_guest_memory(bool paging, const char *file,
     dump_state_prepare(s);
 
     dump_init(s, fd, has_format, format, paging, has_begin,
-              begin, length, false, errp);
+              begin, length, reassembled, errp);
     if (*errp) {
         qatomic_set(&s->status, DUMP_STATUS_FAILED);
         return;
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 2cbd0f77a0..c3062da470 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1085,14 +1085,15 @@ ERST
 
     {
         .name       = "dump-guest-memory",
-        .args_type  = "paging:-p,detach:-d,windmp:-w,zlib:-z,lzo:-l,snappy:-s,filename:F,begin:l?,length:l?",
-        .params     = "[-p] [-d] [-z|-l|-s|-w] filename [begin length]",
+        .args_type  = "paging:-p,detach:-d,windmp:-w,zlib:-z,lzo:-l,snappy:-s,reassembled:-R,filename:F,begin:l?,length:l?",
+        .params     = "[-p] [-d] [-z|-l|-s|-w] [-R] filename [begin length]",
         .help       = "dump guest memory into file 'filename'.\n\t\t\t"
                       "-p: do paging to get guest's memory mapping.\n\t\t\t"
                       "-d: return immediately (do not wait for completion).\n\t\t\t"
                       "-z: dump in kdump-compressed format, with zlib compression.\n\t\t\t"
                       "-l: dump in kdump-compressed format, with lzo compression.\n\t\t\t"
                       "-s: dump in kdump-compressed format, with snappy compression.\n\t\t\t"
+                      "-R: when using kdump (-z, -l, -s), try to avoid the flattened format.\n\t\t\t"
                       "-w: dump in Windows crashdump format (can be used instead of ELF-dump converting),\n\t\t\t"
                       "    for Windows x86 and x64 guests with vmcoreinfo driver only.\n\t\t\t"
                       "begin: the starting physical address.\n\t\t\t"
@@ -1115,6 +1116,8 @@ SRST
     dump in kdump-compressed format, with lzo compression.
   ``-s``
     dump in kdump-compressed format, with snappy compression.
+  ``-R``
+    when using kdump (-z, -l, -s), try to avoid the flattened format.
   ``-w``
     dump in Windows crashdump format (can be used instead of ELF-dump converting),
     for Windows x64 guests with vmcoreinfo driver only
diff --git a/qapi/dump.json b/qapi/dump.json
index 4ae1f722a9..9cc7c3ea93 100644
--- a/qapi/dump.json
+++ b/qapi/dump.json
@@ -69,6 +69,18 @@
 #     to dump all guest's memory, please specify the start @begin and
 #     @length
 #
+# @reassembled: if false (the default), the kdump output formats will use the
+#     "makedumpfile flattened" variant of the format, which is less broadly
+#     compatible with analysis tools. The flattened dump can be reassembled
+#     after the fact using the command "makedumpfile -R". If true, Qemu
+#     attempts to generate the standard kdump format. This requires a
+#     seekable file as output -- if the output file is not seekable, then
+#     the flattened format is still generated. The standard format is more
+#     broadly compatible with debugging tools, but generating it requires a
+#     seekable output file descriptor, and could use more system memory due
+#     to page cache utilization. This should be left unspecified for non-kdump
+#     output formats.
+#
 # @format: if specified, the format of guest memory dump.  But non-elf
 #     format is conflict with paging and filter, ie.  @paging, @begin
 #     and @length is not allowed to be specified with non-elf @format
@@ -89,7 +101,7 @@
 { 'command': 'dump-guest-memory',
   'data': { 'paging': 'bool', 'protocol': 'str', '*detach': 'bool',
             '*begin': 'int', '*length': 'int',
-            '*format': 'DumpGuestMemoryFormat'} }
+            '*reassembled': 'bool', '*format': 'DumpGuestMemoryFormat'} }
 
 ##
 # @DumpStatus:
-- 
2.39.3


