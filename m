Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F0E7A5637
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 01:33:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiNja-0003Ar-Ex; Mon, 18 Sep 2023 19:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1qiNjW-000399-OG
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 19:32:50 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1qiNjU-0001Co-KN
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 19:32:50 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38IK5063015370; Mon, 18 Sep 2023 23:32:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=VDjMH15QvTorDnQEicGRQUIbqfla0KR8+0o1p10RMSk=;
 b=KWidz3QC4bmbZVVfS2cq1fodakwFIATS+7mAdcuXxXtJZUGZQMJ0Fu4j2WOmT9bjf+2B
 9ACd7D/lnNKGuPDTyAYOFPa6WYzVpq0oWw+95v5wliCnqfgTn4hbgSOp2acfTvxGlbZE
 UqxRJMqPZEefd0sEI7yzEwybjtejLjDPE6w4P1NnpvqN/rSgLMRG1Cq2p55rwhU/nr+G
 DL2AZ1t7ksogPc24r1kMHft8Fa9oX6FNyFqITH32XUSb+6Srl2BmgSMc8ENOgl/l5gJq
 g6MtBCXuayeznZ3hsdKWw0+1p40KcnGSj0cEzeB21zXnNgKgMH33ctlmNKD9nJLSU0/B vw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t548bbmmb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Sep 2023 23:32:43 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38IL0Z7s030760; Mon, 18 Sep 2023 23:32:42 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3t52t4xp26-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Sep 2023 23:32:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nM+WZwuF0o/+gpp6GGM24HvBuR3VCHIftLqsoQr7AiCgIRqbeyeCb0NuqNfrkDamhvn1esSWtBI1b2Re2AzQ+fJ64T5GKRplRE5b73v1Zz4hKHUyhp8efZ3Wqf/DOvOhUWtvQ+op0ayOU1+wIAV4unGPfc13zejzbONqyl93epIcHzidLp0wMg6rD8wQibdRGK/1kFR0m0JCWDJwj+thujXM2RKy8VK4xzervIXV7K4MrY1QzuPmwFbAMql7EFOKRbI/z0EF18VfEpI4HFNbNCzUFnR+eyq1yqojZ9JrWLlgkSjoanZqXIXz+V+/W4So78oIy/raWpqqjxlDrxXjOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDjMH15QvTorDnQEicGRQUIbqfla0KR8+0o1p10RMSk=;
 b=V+OnD8HyIPue4tIxeWFQ3iPBDrFONn/ZXzV9HY+1o9B7MLiVpCVrkpiq8+jf17OSA5Nljqjq9ZuWeTohlYsbUtsMtjq+rZHluHd3kp7/w6XSEbdDMvDutEunDiw6+WvNZf8AYnz1SuGHoYw3Q+RqVcntQm4yqK3AinDvp2EYMoHrI+EMo+MSkOBSiD5Ap4Z847weXKS6z3LcVCPKrU8/toe8CethOjuNmR4suI/Ke+M28bLaVeKxRhJhbKNah6meOqrPvV4O5c3ZxhtgMZzTUiuHR2JJbuQ5kJkwDoTrSSlVRwtIvmB1P4BGuYUX2RYpQZhwsM3Nk4EGgEgIZoEnmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDjMH15QvTorDnQEicGRQUIbqfla0KR8+0o1p10RMSk=;
 b=qTTtL5Bqo70+cwm9Hl6ckjmjmOQ/nLDUhu2nUmd4gcTFmD8wlSagDub9rjLpf2KPjYbH9jv8JqrvPwBJ0Kqf0ISAd7JkTueDO1BUc1rarrXkMD6BjW9x/wjIz0NNEpaN/d9lNxLrv6397UywKwx7UFF6w4BhuqVh+EDS9iR4KDg=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by SJ2PR10MB7758.namprd10.prod.outlook.com (2603:10b6:a03:56f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 23:32:37 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::35e3:7e4c:72b2:cf74]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::35e3:7e4c:72b2:cf74%7]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 23:32:37 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: qemu-devel@nongnu.org
Cc: linux-debuggers@vger.kernel.org, stephen.s.brennan@oracle.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Omar Sandoval <osandov@osandov.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 qemu 1/3] dump: Pass DumpState to write_ functions
Date: Mon, 18 Sep 2023 16:32:31 -0700
Message-Id: <20230918233233.1431858-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230918233233.1431858-1-stephen.s.brennan@oracle.com>
References: <20230918233233.1431858-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::15) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|SJ2PR10MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: 05baa48c-7877-499f-ab9c-08dbb89f8aae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K++YI9rtlM/IfGqpx+ohrRN7pACs5t1B8dGufC+NZSZZmyKtZ/H9QPjH1MKRF6iaQwckFUATSkyAkVy+qSibbagdTmtijXcfSEj7oZELYXSKnt0gPsYjbsGJUqg+PDxb/f9kT24VyOZ6vvDcE6GBrumbNTt9HNpJtsHEwk6QVf/CXhQAEh7JrFMSLzTMcnRs5TeVyupjgySbQR0c6+Z+j8qnMMEOLa/jrakmE5rb9w560X7DdbZBl5fbUHS9r0msC77W65qg3PwLTE3hpoeyd/YhEgmmeO6EJgtPSMT58rxvQ0+iYOuqx5WA087dsvf3xDPjJSgEj4G8T7LG9uWB7kW4o0lpLPE41aQ4ipG4auAPnJ8V8cRF/5xhq23O7328P1WBxpEgEEAmZ8EiVLpWmThnSD1AhlRJRzphZNVb4CwP9GsZSxm9fhTj6I3xQj1FA9IJfPQ6NLbrgSeFu2yyxDQLNqZO9xvAgZxMYFO75eRYcq40B9YFupWkXbm6KGniqIMd1H3f+Pvcz/QpqkOsHJOcxWEFTkfQD4p9yXAc4BuleulaMH5XZFu9lwtMTsqq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR10MB6597.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199024)(1800799009)(186009)(6506007)(6486002)(6666004)(103116003)(86362001)(38100700002)(36756003)(1076003)(2616005)(2906002)(6512007)(83380400001)(478600001)(5660300002)(316002)(8676002)(4326008)(8936002)(6916009)(41300700001)(54906003)(66556008)(66946007)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9ARfmJ9XHN5rI7z+5Db9vYTZEy3XXGyRDa5rJeY5pbNWOC4X8qcYNR56+y6X?=
 =?us-ascii?Q?JokZU7z3Nu4uXH1KJLbntgGlrEYTrVY3cXCgKCcGuiFR/lmwR7Wt92D7cbrs?=
 =?us-ascii?Q?voR85ccpaK0ofghPmfmt0tFrvEYVncPNhThAru9JcxX2/0ARPu36OYtylxUg?=
 =?us-ascii?Q?6t6vBda3/r9Uq/J7c+cEKos/UK7HVuwSOd9Kf8i/zOYetcHJ04eGU+274iXW?=
 =?us-ascii?Q?u8feQ427G97aIJJNn+7OiZggu9X0j7KfJCj4gkSKJ2W3jcjBu4tKg2JpiW6k?=
 =?us-ascii?Q?oRYaN4KK9ydwFbX4eyDpKKrueIWxVH1u6yLiPaf51DyI1U/v+ZayfX/qrgz2?=
 =?us-ascii?Q?68jyZy/Eonq5Qkx/vCI0f4ae3WTT+IPv/A6vCil37sG1XWtZqnCzDJlv45fW?=
 =?us-ascii?Q?QLSGDZrmoVrSQjKyB3/9d9OQmJ5b49Dt0rDmvt10lqGXQ+o50IPycwTAARlg?=
 =?us-ascii?Q?EwhKS7vFL7vejI5m6sGHbDndBW5ypjP4k/EnBuoTyn1RFPP54s8OJGgsjb3P?=
 =?us-ascii?Q?RWRl6F4YxVCRZiiO5YOSKru8fb21UD4vH4twoE/sbVIgmP6EdAtLTm2Em2wp?=
 =?us-ascii?Q?KgJYIBf0bW5fjWRal1aXv4OdgkSU/oRSDmWFsK8RgLf8zhCPnQZOLwVzEoZU?=
 =?us-ascii?Q?rZZfrBSAxzINI1bmSCHKG777K5Y/KPyb/e3uwlMIdIwGdd4HSuQSx7e8astM?=
 =?us-ascii?Q?dvHCy3KLvNmGslOKWO+jXBGhp903sm6eM+7KarqDHcybo83vNrDoctsID4VV?=
 =?us-ascii?Q?1BKAhwR4cZm9H0GKLyE5Kd/fwi/iEvPvlyjRv5s/cHnKX8KwazN7ln+0disV?=
 =?us-ascii?Q?9tZPC7iQKwLPzJXqX9sUnH4jg1pejfTsB8+JgsausRcWbdvaMZPwR3L8mJgb?=
 =?us-ascii?Q?p5k34fzFSmRkk2xDTVG7RoZJeBMboA0lWPtROFz+Tv6SIlI4qCK3yIgR6R4x?=
 =?us-ascii?Q?W5N9g4ekA0dQt92o8mv+dHQv8tEgFAEnbeMTACEcBXVLUvd+6Gk13zRs+ND8?=
 =?us-ascii?Q?RWJlYOH7xoZHg7TIdW4kYfN6J+G7oDyGJ0RM+JL+UpJksLYjz7G4jC4iGhyN?=
 =?us-ascii?Q?5USqKlC14wRbBcUaEM+N5sMPQbqk61+2KbacrhIAAPBYjvPIr0HNcnyDT6ny?=
 =?us-ascii?Q?sH1FHSnjDgFl3eqKDAdRLA1g0EoNtIbRn1zkkhaIjPlR4qU+dd7Ve8U5ll2D?=
 =?us-ascii?Q?0k5YTPMCF7WZiaNoUEXXfEw9LYbpENErUl4oYqx2MAwdPiG96JFCUsa2sWe1?=
 =?us-ascii?Q?go5r1mIf3rdINXoUC/G2eFg5Fv4E3EUtNlg5ome4u1EZqFtT0Atji24C6slX?=
 =?us-ascii?Q?h3Ue7yrjgl7yjDckRGOk/x5HQnTylx6+mLvdcBrmV7MGGQWWJ42gZnafRWMZ?=
 =?us-ascii?Q?3VEnnKHkTPemoFcMargVWKmVhsV3rsA5IoRB2hemZuC5s/Fl17eTG3tYA72m?=
 =?us-ascii?Q?11TaBfQ75gcQneStrMyYxeKkAWQzq2EG5DYoZwKSZchAzPoxUrCkIq2o/adn?=
 =?us-ascii?Q?j2zzryDAFH6C1rhzX1p0ItK7NuLM8mO1cvhNXI7mLVBBfxdDCJ2waeFCQcj9?=
 =?us-ascii?Q?9x1FPUG2qLAHV34kLm/tFNNUG4ChzziT9qDMd4Gne4wVDzA2lkGe0BRNGarM?=
 =?us-ascii?Q?VUxQSJOOjfZd2n+JJA4n6SN402Zd4Pmu0FxDi8a7GQyi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QAMCnq1nUhK0FzBbJARTVH1RUBImU6yJ0XTHhEE+Eh3nBruvDJ/iekZEuMabC3ORoJqWmATextfzpT2IgJYihiTwt54uAUqUhImJvfIybQyiHPq7ypoHyTH7uUScYhYT9Bg+i5Dd3zwx3LNl5uGBhXxSEMavTndho6afSzHlzZY067AvDXOrqzn1w8q8a7pOLtl8dSfALVoidENENxR9mGDCORm8nUGLMG0UtJeGEJiRyo1FC2AuNDWyHkmBUn/jxrokOs319z9jJR6L4ARWUbFDTdOs/tHhEzS8jEIrxP4ZrUS0Cigje3dizfp8X+x6u5wTD0+ijv2CrgQba8zYE7DdZWVlYUA7rIFIz/JcvHzXAYw00Deq+QsJj1h9rZvBtTKB+Pc0Yhw/TPxU7pOhonvvfuLP8/AITHGEV9SXD9oLVJd5+QIED9P+oBgWzxnsERFjsR8WMG69BEwg+8wfx1z4zNGl+OqJfE6Kc1/aHSKN1+uLEbj8N/fWJNv4Cg5MrwZNKK3nWWqCHHYNt0/Fr5LhMM3EUJ5a84jXaz5V9m3WtwSLIeIT+P18PxN4Z39tD8+RxAisC8gfnIo5cGFWwx8D4YK/DjOKv7SI1zOrwSxGXQ5psfIfb864TOsQMW2n8V9GxjnQB2sbSaCb+PAvwHQJaVU/B4AIiTCfk4r58m5x5ibxFNXWoAX7sale6y5DymTdlG51s4sexVhZYM6U1ygbZ55ITYnD4WKZr32aQuD7cqVWavPs1mpeeInfVvnCZfL4nn+X+3qyh8IoQwooit/mjUCpSMbSFJZPFc5GdbbiRp6QL6n/a1S7tfzNfUq/YLlr/XUC46LFaqz79xoiLXGnCPAN9ojN1A2JwAiunmtfksxaoo00WTz8s8XToYiM
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05baa48c-7877-499f-ab9c-08dbb89f8aae
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 23:32:37.0831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pd65Gpc1e4AkAUHrNCthnC85a/xBXvKE2CNR0Eacvtis7s6E6DYQxgt1BGtY0Yn2L/HTBJrfOUDP1h4ozf61SNX5/jedapxeCp5FrlDhJgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7758
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_11,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309180203
X-Proofpoint-GUID: uZyDOo8JZGQx7Yc5cZ8VpRJv2qooz06S
X-Proofpoint-ORIG-GUID: uZyDOo8JZGQx7Yc5cZ8VpRJv2qooz06S
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

For the next patch, we need a reference to DumpState when writing data.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 dump/dump.c           | 40 ++++++++++++++++++++--------------------
 include/sysemu/dump.h |  2 +-
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/dump/dump.c b/dump/dump.c
index d4ef713cd0..74071a1565 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -809,7 +809,7 @@ static void create_vmcore(DumpState *s, Error **errp)
     dump_end(s, errp);
 }
 
-static int write_start_flat_header(int fd)
+static int write_start_flat_header(DumpState *s)
 {
     MakedumpfileHeader *mh;
     int ret = 0;
@@ -824,7 +824,7 @@ static int write_start_flat_header(int fd)
     mh->version = cpu_to_be64(VERSION_FLAT_HEADER);
 
     size_t written_size;
-    written_size = qemu_write_full(fd, mh, MAX_SIZE_MDF_HEADER);
+    written_size = qemu_write_full(s->fd, mh, MAX_SIZE_MDF_HEADER);
     if (written_size != MAX_SIZE_MDF_HEADER) {
         ret = -1;
     }
@@ -833,7 +833,7 @@ static int write_start_flat_header(int fd)
     return ret;
 }
 
-static int write_end_flat_header(int fd)
+static int write_end_flat_header(DumpState *s)
 {
     MakedumpfileDataHeader mdh;
 
@@ -841,7 +841,7 @@ static int write_end_flat_header(int fd)
     mdh.buf_size = END_FLAG_FLAT_HEADER;
 
     size_t written_size;
-    written_size = qemu_write_full(fd, &mdh, sizeof(mdh));
+    written_size = qemu_write_full(s->fd, &mdh, sizeof(mdh));
     if (written_size != sizeof(mdh)) {
         return -1;
     }
@@ -849,7 +849,7 @@ static int write_end_flat_header(int fd)
     return 0;
 }
 
-static int write_buffer(int fd, off_t offset, const void *buf, size_t size)
+static int write_buffer(DumpState *s, off_t offset, const void *buf, size_t size)
 {
     size_t written_size;
     MakedumpfileDataHeader mdh;
@@ -857,12 +857,12 @@ static int write_buffer(int fd, off_t offset, const void *buf, size_t size)
     mdh.offset = cpu_to_be64(offset);
     mdh.buf_size = cpu_to_be64(size);
 
-    written_size = qemu_write_full(fd, &mdh, sizeof(mdh));
+    written_size = qemu_write_full(s->fd, &mdh, sizeof(mdh));
     if (written_size != sizeof(mdh)) {
         return -1;
     }
 
-    written_size = qemu_write_full(fd, buf, size);
+    written_size = qemu_write_full(s->fd, buf, size);
     if (written_size != size) {
         return -1;
     }
@@ -982,7 +982,7 @@ static void create_header32(DumpState *s, Error **errp)
 #endif
     dh->status = cpu_to_dump32(s, status);
 
-    if (write_buffer(s->fd, 0, dh, size) < 0) {
+    if (write_buffer(s, 0, dh, size) < 0) {
         error_setg(errp, "dump: failed to write disk dump header");
         goto out;
     }
@@ -1012,7 +1012,7 @@ static void create_header32(DumpState *s, Error **errp)
     kh->offset_note = cpu_to_dump64(s, offset_note);
     kh->note_size = cpu_to_dump32(s, s->note_size);
 
-    if (write_buffer(s->fd, DISKDUMP_HEADER_BLOCKS *
+    if (write_buffer(s, DISKDUMP_HEADER_BLOCKS *
                      block_size, kh, size) < 0) {
         error_setg(errp, "dump: failed to write kdump sub header");
         goto out;
@@ -1027,7 +1027,7 @@ static void create_header32(DumpState *s, Error **errp)
     if (*errp) {
         goto out;
     }
-    if (write_buffer(s->fd, offset_note, s->note_buf,
+    if (write_buffer(s, offset_note, s->note_buf,
                      s->note_size) < 0) {
         error_setg(errp, "dump: failed to write notes");
         goto out;
@@ -1093,7 +1093,7 @@ static void create_header64(DumpState *s, Error **errp)
 #endif
     dh->status = cpu_to_dump32(s, status);
 
-    if (write_buffer(s->fd, 0, dh, size) < 0) {
+    if (write_buffer(s, 0, dh, size) < 0) {
         error_setg(errp, "dump: failed to write disk dump header");
         goto out;
     }
@@ -1123,7 +1123,7 @@ static void create_header64(DumpState *s, Error **errp)
     kh->offset_note = cpu_to_dump64(s, offset_note);
     kh->note_size = cpu_to_dump64(s, s->note_size);
 
-    if (write_buffer(s->fd, DISKDUMP_HEADER_BLOCKS *
+    if (write_buffer(s, DISKDUMP_HEADER_BLOCKS *
                      block_size, kh, size) < 0) {
         error_setg(errp, "dump: failed to write kdump sub header");
         goto out;
@@ -1139,7 +1139,7 @@ static void create_header64(DumpState *s, Error **errp)
         goto out;
     }
 
-    if (write_buffer(s->fd, offset_note, s->note_buf,
+    if (write_buffer(s, offset_note, s->note_buf,
                      s->note_size) < 0) {
         error_setg(errp, "dump: failed to write notes");
         goto out;
@@ -1204,7 +1204,7 @@ static int set_dump_bitmap(uint64_t last_pfn, uint64_t pfn, bool value,
     while (old_offset < new_offset) {
         /* calculate the offset and write dump_bitmap */
         offset_bitmap1 = s->offset_dump_bitmap + old_offset;
-        if (write_buffer(s->fd, offset_bitmap1, buf,
+        if (write_buffer(s, offset_bitmap1, buf,
                          bitmap_bufsize) < 0) {
             return -1;
         }
@@ -1212,7 +1212,7 @@ static int set_dump_bitmap(uint64_t last_pfn, uint64_t pfn, bool value,
         /* dump level 1 is chosen, so 1st and 2nd bitmap are same */
         offset_bitmap2 = s->offset_dump_bitmap + s->len_dump_bitmap +
                          old_offset;
-        if (write_buffer(s->fd, offset_bitmap2, buf,
+        if (write_buffer(s, offset_bitmap2, buf,
                          bitmap_bufsize) < 0) {
             return -1;
         }
@@ -1380,7 +1380,7 @@ out:
 static void prepare_data_cache(DataCache *data_cache, DumpState *s,
                                off_t offset)
 {
-    data_cache->fd = s->fd;
+    data_cache->state = s;
     data_cache->data_size = 0;
     data_cache->buf_size = 4 * dump_bitmap_get_bufsize(s);
     data_cache->buf = g_malloc0(data_cache->buf_size);
@@ -1399,11 +1399,11 @@ static int write_cache(DataCache *dc, const void *buf, size_t size,
     /*
      * if flag_sync is set, synchronize data in dc->buf into vmcore.
      * otherwise check if the space is enough for caching data in buf, if not,
-     * write the data in dc->buf to dc->fd and reset dc->buf
+     * write the data in dc->buf to dc->state->fd and reset dc->buf
      */
     if ((!flag_sync && dc->data_size + size > dc->buf_size) ||
         (flag_sync && dc->data_size > 0)) {
-        if (write_buffer(dc->fd, dc->offset, dc->buf, dc->data_size) < 0) {
+        if (write_buffer(dc->state, dc->offset, dc->buf, dc->data_size) < 0) {
             return -1;
         }
 
@@ -1644,7 +1644,7 @@ static void create_kdump_vmcore(DumpState *s, Error **errp)
      *  +------------------------------------------+
      */
 
-    ret = write_start_flat_header(s->fd);
+    ret = write_start_flat_header(s);
     if (ret < 0) {
         error_setg(errp, "dump: failed to write start flat header");
         return;
@@ -1665,7 +1665,7 @@ static void create_kdump_vmcore(DumpState *s, Error **errp)
         return;
     }
 
-    ret = write_end_flat_header(s->fd);
+    ret = write_end_flat_header(s);
     if (ret < 0) {
         error_setg(errp, "dump: failed to write end flat header");
         return;
diff --git a/include/sysemu/dump.h b/include/sysemu/dump.h
index 7008d43d04..e27af8fb34 100644
--- a/include/sysemu/dump.h
+++ b/include/sysemu/dump.h
@@ -137,7 +137,7 @@ typedef struct QEMU_PACKED KdumpSubHeader64 {
 } KdumpSubHeader64;
 
 typedef struct DataCache {
-    int fd;             /* fd of the file where to write the cached data */
+    DumpState *state;   /* dump state related to this data */
     uint8_t *buf;       /* buffer for cached data */
     size_t buf_size;    /* size of the buf */
     size_t data_size;   /* size of cached data in buf */
-- 
2.39.3


