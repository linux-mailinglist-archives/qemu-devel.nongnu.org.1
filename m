Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D455731A8A
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 15:55:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9nQV-0006Jl-Op; Thu, 15 Jun 2023 09:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kinsey.moore@oarcorp.com>)
 id 1q9nQT-0006Jc-PW
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 09:54:13 -0400
Received: from mail-dm6nam12on2139.outbound.protection.outlook.com
 ([40.107.243.139] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kinsey.moore@oarcorp.com>)
 id 1q9nQQ-0001cQ-1A
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 09:54:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fgcq7r/bBOqf0MSB0IQNDRsmg2RwXMfjvDwt2nPmd4KayXu2Wqu6aNsuRs2x4BWashhT1M4Mzc6Xsbn0fRZl9lVuwuIak3t1+pfWjowbOQTeNpQNfa63u0cv9dE4RxO0EYVp5ej4MGoFrIYjPRshrVuzhgiSLhxoAdB9BmT3Py/F0ob80x9C75fRLzqO1/1mhhqmJA1JoK6d79unaThLHDtNZREFCHkm1uhhpYsHK7hiBIcO2+awf9mlrCfYVoQAiwzP7XZpL/wYoAXQU5K19sF7gJIMDOPSj1k7cpnIedxbljxRE0/AaBaaEBVIcszqHmzHcwzyZNuXYV+GLqcWMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrYveiKZJ1ezTJjyPK+TqMQcgYqzIxUFufaiQOoNgJo=;
 b=PMcYkKzWick6QyPHHKYfJhkbvAPBupavMy1puzYOWAncX/k1IZSKZjXhci0h10j2x7J2JTHzEkshqzmVjJj+BdDBJHDiSenpUp2/+05v70oyHU54n1dvsXOXvYadgsdqK4hwTzq3etP3D8C7gBLeRNuQ1vp2O67newss2WB683OnK/pm+AVc9XqtpUZ9KY/HAz/11FIH4IF63V30s99zYnVvqdIh43Ag4DfGsaDjeszw4DvzVlmnjmoz7fDQnUImEm/jzg1N3Spnm1ePkBhRJ2p0SCS1IYunEpIBsOxO3jii9I5OObYZFjrDcpAtWXObc1QdauDlslnq67uJqJ3GPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oarcorp.com; dmarc=pass action=none header.from=oarcorp.com;
 dkim=pass header.d=oarcorp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oarcorp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrYveiKZJ1ezTJjyPK+TqMQcgYqzIxUFufaiQOoNgJo=;
 b=A/W4SJE/60V0pPJLHN0Y4raALB5xu3Wj/+fPfRRhh12L8nOoUwCVyrz0rCYmrb8zAqxcO8AZ53PI0KSbWFWSKF2TALnfV4gY9f8Jg312ISfsfuNPjMPO1ToPgLpPJKxm5pZbh3AXRMR1dJ9Uc0dxTAEK8V/qwR8lu+ys5D9E7g4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oarcorp.com;
Received: from BN6PR19MB3314.namprd19.prod.outlook.com (2603:10b6:405:76::12)
 by CH2PR19MB4055.namprd19.prod.outlook.com (2603:10b6:610:91::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.28; Thu, 15 Jun
 2023 13:49:00 +0000
Received: from BN6PR19MB3314.namprd19.prod.outlook.com
 ([fe80::f6b3:3419:418b:709e]) by BN6PR19MB3314.namprd19.prod.outlook.com
 ([fe80::f6b3:3419:418b:709e%4]) with mapi id 15.20.6500.025; Thu, 15 Jun 2023
 13:49:00 +0000
From: Kinsey Moore <kinsey.moore@oarcorp.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/1] Secondary Cadence GEM IRQs
Date: Thu, 15 Jun 2023 08:48:46 -0500
Message-Id: <20230615134847.4157666-1-kinsey.moore@oarcorp.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0639.namprd03.prod.outlook.com
 (2603:10b6:408:13b::14) To BN6PR19MB3314.namprd19.prod.outlook.com
 (2603:10b6:405:76::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR19MB3314:EE_|CH2PR19MB4055:EE_
X-MS-Office365-Filtering-Correlation-Id: 4469f669-9db9-4267-b837-08db6da745ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W4RU2DMSED7HtxupPsRzJkLEVYxLXrJsH2OTpmMaZo8pWKf/CSzcH4ZhI+FhG8pYhOhNrPrXoVVRz+GzwhIqDTX2eXHNXO+VfKusRpw81F73DJ4KkGThrVagjkqOwG1Zbp73nnSlCJpyHscgB6PnmF9tOUcj8AdN27sdJwgxARFnVX2iv73+wYGnAIc3K1CSYGt1F+vIcQT6Rw8BbKcg6qLM6HaxdLhT+APbNBe9ZCVHeel9/3bWOpTNuGo87Oqd/6Kzw3o3bbiW29imqhtK5ggZLDUtbw2tv1bXndXqBvdIaaLxxowa1mTah5rR/RjMBVCwu0sqbQvVpnlPFGw8tWIInzTteGbp55vbcZ308CN4uI+ABuSIpZoCtdmsnzRXPR0zDbvtL3DZeuE/TuTE+BYINFBSHYmiZnPQGLoBNQOakqZTmUYARNk2hgqlE2T6VTppN+spRrURyfO8Cp/XG3sw2XyzgGlS3TGpEBhvzugC7vNdBrg/SzJ0kKEm/UY/pudKb6ooDvkp9gFupkv6FhDefHcwnmERIO9hV+m6BT9oGBBvSpqkevLWf3f+nN6lZRCXtCFVoqmVNr8CTNCyLOe56TW+ezQgDoAsHIYzFYtcGRQ8wvITz/L6A04JGia5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR19MB3314.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(136003)(346002)(376002)(39830400003)(366004)(42606007)(451199021)(38350700002)(38100700002)(52116002)(6506007)(1076003)(26005)(6512007)(8676002)(2906002)(4744005)(44832011)(8936002)(86362001)(5660300002)(83380400001)(186003)(2616005)(6486002)(6666004)(36756003)(66476007)(6916009)(66556008)(478600001)(316002)(41300700001)(66946007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1uZEfYXtTCiYB5Tl8ENdSKShkpXW2s63bqRAciNzsrDb/Z87wKuszS82hJ3q?=
 =?us-ascii?Q?tb7GyZNfXuH4xkZ1aSrdD2QWjEryi5qUoPJaKXQwQxqzfXJwHZdcwu1JGYMd?=
 =?us-ascii?Q?RNrSJPAJF8T3P2RCLOLHEkAFVywDDrLfs9l9EkRzJFbihs6MIgA31wbt4/MM?=
 =?us-ascii?Q?T65Ls27xD4lnT20cIA3oR7Y7JetC4ahbHYKOPi3YrvFOI0fGWkYm1xyv0bKO?=
 =?us-ascii?Q?TXWnNKpHoCiQjOxcKF6mioUSjvkdM1jT0lDiFZnNVhP3CmVBRh5EUY+QbqcB?=
 =?us-ascii?Q?FLs0pVz55x8NYPS7VMmOEcGSf/iruU5F2Kdp/x01dj7yjGpK5gXDNTOeqliU?=
 =?us-ascii?Q?UfgA8ibRNlqNXdXUFHYk4x5leEepeYp0FooTnblPUXYtq483w7PnMfi781Sw?=
 =?us-ascii?Q?f+zF4XbsxTy4psdU4L5npeZSt8L+i4Ns+hKKRgs5czyQvDrCKtG7bIlA7ooW?=
 =?us-ascii?Q?HOl7lcN1KuxsGLGogtMPeovyLleu4kobTO7anNWT0aI5eVrlFO1C8GmT4Ww6?=
 =?us-ascii?Q?9mIIru+vVkWMny1mAabOsZxbMNZHXQNS7zDAhDx2HC4Up4p1ux8xSOzG692u?=
 =?us-ascii?Q?LYnl5BG5r0T1YL2leZ6AoBfpglHs0RSxs5HraYZVFiEd0AgHOYlGZPwXNRIX?=
 =?us-ascii?Q?rncxpm9JzM8X6pFMRpTlj3uIjYoFChn2D9B5P8Sws7/LBlnJ2xHLEglHkqAi?=
 =?us-ascii?Q?2PH26KrLl2sbWVNQ2XVdQ7fTWH7nbYpVOrPeoHc8wM6DhlBzPDcIknOPCAeA?=
 =?us-ascii?Q?Ijku+SnbUB38/TCdMTOLbaXaQrxumvOA58E3jSSDs11Ms7Vcj0SMhzt3OHO4?=
 =?us-ascii?Q?u6Oq2oALWujJ4va6VUxEwrezolXlO+JO8yZ9COnNYSA+RdS3zkQmcLs+4f85?=
 =?us-ascii?Q?AAu2Qjl4RNEWtZq0H2PkBK69iE7mQKzyxHjfyM7SYhxZyAD1WNcYtssXnuGQ?=
 =?us-ascii?Q?+UNKwoVXk8RABBV5TdI/cUBIME1AFqs41XiNXqnlTu+7o4NIEKpsYnXPax06?=
 =?us-ascii?Q?sYyEreCkdQCcTaGKwsBfGBRFU65vl2rIVN+e7F4jbXVA24omajyR/tFws+o8?=
 =?us-ascii?Q?4tb+L05nIH2Hc7bSlRM64GSGZod3zxbcfq2wMMVJvYRLAKkRoU+MimN6WmxQ?=
 =?us-ascii?Q?VS9WuTo7VWUvhBqPtg1mbUqpTSDfKX2cI7DaEkjQdw4FqbjKva8HFsiAMmb6?=
 =?us-ascii?Q?36z38Gt+BxI5jSTXDUW5LnGRhqwW8owtUhdhdnjtrzx2iwoGhj9M6whnGk+w?=
 =?us-ascii?Q?Nw/SKMLG6+LeC98C7DloYXPHcUSFw61BtQjnQStlBnrvtcs9Aty8/urXh11Z?=
 =?us-ascii?Q?ERlFDTS0VwadNz/MbGLrhbWxlS0G2M1D0NIQKPyZdHrpB7aBQgC64y/Db2yL?=
 =?us-ascii?Q?Xo4iZIVZ4MLhwPOKTLIv07NCFV8fXH/4/5rhxoDVBmpN9aJlQUyfRGlxitzA?=
 =?us-ascii?Q?aLV9lMKAPuxnjxgskkPA+SzyC7k5kyju11OUMImnvCvXV1Kr2DKSxR440VTy?=
 =?us-ascii?Q?NkFiyM9f6txQGNRnmKuab2okSne9p8niQ1w643/1pxWZZxRB739La9VMoP3V?=
 =?us-ascii?Q?F0LrhwUztIt6Wpg8Y0tbitQBxWTywY3kyRLZyT5M?=
X-OriginatorOrg: oarcorp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4469f669-9db9-4267-b837-08db6da745ab
X-MS-Exchange-CrossTenant-AuthSource: BN6PR19MB3314.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 13:49:00.2569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7bdf32a6-03de-4c70-a71b-8665ba1294e3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JkY8DFnRs6NyItKtoIUtsqNbY9P7LPvoUkXCDKzRVfJ4oq7nqdqoG3NfcxYX5kl7x9Sn4XFXwsNcFH9p5O3ahQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB4055
Received-SPF: pass client-ip=40.107.243.139;
 envelope-from=kinsey.moore@oarcorp.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

In testing RTEMS on the ZynqMP platform, I noticed that priority queues
were not functioning properly. I tracked this down to an unconnected
interrupt source in the Cadence GEM when multiple priority queues are
configured. I'm not sure if the Cadence IP can actually be configured
for separate interrupt sources per queue, so I opted to leave the
multiple IRQ sources intact and connect the additional sources on
platforms that need it. If it makes more sense to route all interrutps
for this peripheral through a single interrupt source, I can submit that
patch instead.



