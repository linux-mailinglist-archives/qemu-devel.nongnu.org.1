Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F297A0EE2
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:22:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgspr-0001r3-VQ; Thu, 14 Sep 2023 16:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qgspq-0001qV-0K
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:21:10 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qgspk-0007cQ-FA
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:21:09 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38EIdZtS021347; Thu, 14 Sep 2023 20:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=8sumn9rMWCh5+MWD3jBn0mSrSWZ90sthWa4krjo2tqA=;
 b=dxXxV84S7EUULosV7WGCpDIPsG1pdxXSPpTtw6quPUKhHE1Y6PmzG8bIV8/0eWhCCq5S
 e535JgJWrUEM8B6lrHt6v3ybsxADcT3f5Tcqm0TR54MPbaLOczAcN1xgjfJg8S8KtA9w
 +mD+9pNxCH2Sfk+Qg7g4NcKOphsFOezmtlRtrobXoVVP/Ng2347XcKU8RSID7K42UhZ5
 kIbGbNAnT76pxvLgCMfNtYviKol2u0nXteIsb6YjYdvn2G6Vd1oMZrvLRy9bt25cBunx
 7NjHwtCp67dbAy58gBIuB3PGABH6nr9ul/Ws18Bqz/KPR9YoUvkx8MixlIJj3vF/OCue rA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7ked2p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Sep 2023 20:20:59 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38EJkSMZ030353; Thu, 14 Sep 2023 20:20:59 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3t0wkjfyus-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Sep 2023 20:20:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jiEJbsCD1I6+NICEjAKYrM5EGVzkTzPMm1pt81LM/pJB3YcDjH5PZuAFbfLdC3IZAoBtBDufl09zrz49ofZ6laIHt/OxqRMu1dWRkkbet8ffkJEPSWocyhcOfMLUauW1Y79+IRNXhQqsuBWmZYYPz3bvvR9IuxQovHwnd4kfHxhkcB49sDY8yWChopyVWkTJsVl/QSjg9NREoGzRG3XcTQwPN2k9Pr6kQaJK24LiDfWDQ0Dra5OedYwQeEnF7BZi2nlHU77gFiz0BfaO3986mm2WgXKFsJfBWSi8CMOVtTO2yVrh5fvYdKypUXhIPfBsTffTJAzD3ub0vGMCR8tVJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sumn9rMWCh5+MWD3jBn0mSrSWZ90sthWa4krjo2tqA=;
 b=YA35+Xpi1JdYaDHn0rCA9dMzWAfodLfIE0RIyK9TPA3Kf9De7bqGFP0fhSbOsMFEho4wsbU7OpS/Z8KoxWXQ5m3dTTga/I0mqs+KczDtMkIy+KtDEt+Db+i/zQAw2bZMkcMOGxF4kjDF88maudfZ6X1SUUoqPMfa6jIk5+nuOaRHXWVwe75L9a9+Wu0408Hv4pf+bODYB+CkyUhEuYveAe3L7DZ2zXeZYB+h5dW3lQZEdI3Jsd0FkFKq4K8UxRNE0Vqr/4ipK6YyiJ3wn8I4NTCRfwrqIVLL/teKDV5TmaYbjzJcve9V93HAEGrEEz7RaRQWN4jEqpoGMcfzeJDJkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sumn9rMWCh5+MWD3jBn0mSrSWZ90sthWa4krjo2tqA=;
 b=H0xANFEIQuIysxks2dYfiPregloAFZ9qSkKboz/m9KMsCxtYguzfZPeepDoOyg18F3qfXypHxtFJUX2JEKQq+i7FuLId0EpRWTtHTDHwpupEpD1Dx6AgIDwbINtzAlfLRp/q0ANNRT5LwUcsp9crw3PoYgfSNmaAkdbWydPxHUk=
Received: from PH0PR10MB5481.namprd10.prod.outlook.com (2603:10b6:510:ea::5)
 by PH7PR10MB6674.namprd10.prod.outlook.com (2603:10b6:510:20c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Thu, 14 Sep
 2023 20:20:57 +0000
Received: from PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::487d:5c37:8928:9885]) by PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::487d:5c37:8928:9885%4]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 20:20:56 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: qemu-devel@nongnu.org, peterx@redhat.com
Cc: pbonzini@redhat.com, quintela@redhat.com, leobras@redhat.com,
 joao.m.martins@oracle.com, william.roche@oracle.com
Subject: [PATCH v2 0/1] Qemu crashes on VM migration after an handled memory
 error
Date: Thu, 14 Sep 2023 20:20:53 +0000
Message-Id: <20230914202054.3551250-1-william.roche@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <ZQCxg+M2IpecRT8w@x1n>
References: <ZQCxg+M2IpecRT8w@x1n>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0122.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::7) To PH0PR10MB5481.namprd10.prod.outlook.com
 (2603:10b6:510:ea::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5481:EE_|PH7PR10MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b6642c-0728-45bc-97c8-08dbb5601a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7X4NNTx+zJpFS8j4Dlbs88oRKDAy6gtBSvd9gdbiKrVhZ1ujHadqkuPf89pZSaHVRixaw4NXd4hUTurvT8Bc3CXJ4ftfeN1S/V62h2zepZV/AskOWa+Za79/8ETwMvM1V8tQM9zzMGPLn521hur4/tGetNtZ7iqfDJKiGGi46CwZviFu4I2SGpp9SMkRmP/cv+foVrVz2aJv7bP1Qtg8ZaHWvvUKr26yP+pf+hxQk0dEwLVOLR8W+BcUWeCm8X2DxTguiR9A28tMnNr+G27L6ksgSQsjfZc9FLNGS+fipFvjqrRrJHpzd8qO6tiHmvqtrLwEHvpBoCdkX8GtR7pMRJIkZV1BkgbJuyg1K96PNhJhaGBBBFNqnHaY3F4ioGEAFFAqpLsk3G27OOpc2TBVYJCl8ZixI4axrf7eSGc4Wyk1dW0LabgrRG8LXsigpX8BA5EfeNso8XUifREPPwHaJtf2sbePCxmgQhfNEsgGrH4QbCZfhKfHg6GoUtBjanZWN6y0LLu3AGoJsgbr3vXEdeKCzyDB4pWtROnqh/4enblhysQfyuaQxYo8bE7blQ2t
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5481.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199024)(1800799009)(186009)(66899024)(6486002)(478600001)(6506007)(1076003)(86362001)(38100700002)(6666004)(36756003)(83380400001)(2616005)(6512007)(5660300002)(8936002)(26005)(4326008)(8676002)(41300700001)(66476007)(66946007)(316002)(66556008)(107886003)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B5gJ/qXr6/J2M2nlMPidlB0cg9PTW9yd+CJMieW9JX0WdZhX+NkJSnxhwIBq?=
 =?us-ascii?Q?G0FOjPoeS83ULmLxCB5EMWT5FtGqUeTDcOy6RgFQIJYjSeVwCSGxpcoLfJvw?=
 =?us-ascii?Q?nLP9ZP4RiM65ZPPYKMvpcbfWSsnR8EN8IxVY/WXzDOIc5o12qN2s8iK1m8Yt?=
 =?us-ascii?Q?u361HORtxsI5vxgkeFfbdo++yMG0/+tVqyLhFzKSMBuD2tGzThE/Sv+rRgL4?=
 =?us-ascii?Q?d0qBwZGE8Z8dFuztrZ51mLTATQxxihTP+T3ztROeMeBQjfxgtJxfcF1WAfNh?=
 =?us-ascii?Q?7DqWct378xQIAVL0cB7yj++21D26S9UryQSQ0eAvZfiQTAoLescK6tljMUWQ?=
 =?us-ascii?Q?6hWCvSHIHv7U8/BnsH6MNjKem7zwI9VDpG0dGy1EWGTHs9hDKVhyOtj+XLHB?=
 =?us-ascii?Q?IOT0OZ6cN/VyYinqI5lFaBKs4QANwgqjgNIJkJbSejSseGv4bBYIiH+6k/tC?=
 =?us-ascii?Q?5CPvfNx63e/jLmzyo3lCYCWVtRm/Os+XxS2HAnYNHMvbNd9DmHGwPhkAkENR?=
 =?us-ascii?Q?LINOYlaJRGPOaGyvXnTFuHrIbpQy3bS/DqlaeteRqAM4JfpsrYNlxJpFcCwp?=
 =?us-ascii?Q?5dr5d4er6AgVnoxeHoaffF1hbJTvt+eCAfI07TPeHC2nLVqzffkfGFXj4S4U?=
 =?us-ascii?Q?Ekh4teBgpuBAXlf/JhtcNi7jHD38MYc4jSAo4U0xO66T6kDwO81dNRHidAu1?=
 =?us-ascii?Q?akuVbeRON0h9CivhymveIWjWh6fMU0oSepLaDMpLkm66th7Apase73NU/un6?=
 =?us-ascii?Q?RW9oTNSaEukQuDrYysyEy1MfxK1cdRXFg6pkysYBZX7EEF1HHa87bLGjVR5Z?=
 =?us-ascii?Q?6kdFIuq9OigCFBUMrDuJQAlV63B+pqp2PqNqJpTCSkn+zjYhamZJCw9lEIdu?=
 =?us-ascii?Q?2/qKMeXrkpKsHftw4VYu1iMaW2lzfC+2mClmV+1YKiqSaEFoq+y2FZK7Lflu?=
 =?us-ascii?Q?EwzQtgsjIR8dA0lSgRr8Ye5CkBbfla5t6wLSnlro1kg8sXoOWW8jScwCmiGI?=
 =?us-ascii?Q?PySyC5CYrY2E16IufNqP11MYWk/bhFGIPQ3FdTFvr8cOBIEEQlgyDTjHpu0H?=
 =?us-ascii?Q?cAghgxg5USK70ViRjeMHnidZkH3cBiD4dQdqguX9VFz5CN3trsw6zxp06EGV?=
 =?us-ascii?Q?FlZJfBkQXMOkgMPUU9110+8LMqRIuZu01EJZ9eX0Pn7AZpuPLQj6dzHH/9H8?=
 =?us-ascii?Q?O1vSUmRra2d58Zz3uQPu1a0fdo5v7i6W5ud7p7rsiBbKfuOkOH8XwU7xKpXx?=
 =?us-ascii?Q?zd96tC7MpkjH4N9FA2u7RT1d6I4GM0oIQmImjAx39RX8oHYURuWMUApPaTCv?=
 =?us-ascii?Q?VRZ1uVmcdICqGU/Cv4J0BUKC4P3nVUDZSfVrQMwThmEFniydrKjXZmgh1ooJ?=
 =?us-ascii?Q?9M217FuM3Jq3yw2s1yrA296cAbSsc6krnLMec4nyhuo+LxzzXj1WvYbtV+V5?=
 =?us-ascii?Q?tc9kiR4SoHFI/pqYudNRfa53l0Ocy6WFdHDFtKgTEUaFO5GG46bqEoEpmyHs?=
 =?us-ascii?Q?PoquBdSKKR2CLXJE0nuGwVmVNVGGhsYyvncPEYGOGawhRlMu8I2kYqR77OsI?=
 =?us-ascii?Q?myqSYsJn+zhZP5tGbve4aQVU7tktBnt2ReaYQ7VRCD2q160uXPN1IV0WlYB0?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ATQ520p1VCOmNiyMpFAV/fQCeLzMBo9OJXdzAYKxpOj5DbvPbHyhzpO2tu8gJp90LPbodvYx292q37L39egW/0+rtPgTdZrgqvksf7KV3zujevGCvho2eP4em5/otjTD2SSuCXuJJYE8fEi+OZjEsc83vPCBYeLkHe1TtJCLHNIZkoQdPUTcq6Bbhovx8UTm1zlzpcJyYeXyChikrB99ULX48LlP4Hqzd9JEyxVwe8SxILYhEIUYKnVsCcEWU6sCdrJLT6MtO7rNLRD5tT/5jsn4d1CucWBMF9WVoTb+8CIws8yV+h5+JdD6dV3LZO9hCMhrD/bNKtT5Aw1XqA9AXFdhoxe3xw8pXs5GATDfhDc8y0foqlfrS6ASq1lIevpNs7z9myinHaKw8ZNLYWvxR7FpW1L5OqWsA5U6nzZg4wpLB/MxGo4QIS9shfGV4a9576Lv0daWkoPFteorc4+sCsw1yH9SQPGb+Qys3jloXvgboWoIGmqu+sNMha/u0TGY+Xn34+qx42dWGZChQioWsBIgDtLxEipwO6cvIJAiwrcWEM+4yLNn3ehZ7ElJSOgY6HI2aLnngNL3EW2OoPmnikAzpedCFyvoKXk7UsRjPr/U0eb/K7HDNtgLbVif4VgzzL6Uqij3K+ClJeeSXT3SrqD1mdGSvxUqroBhRdvANxRLsunyMZLlq1mZjI6DgvNMB22b9MWvF3aYEkjtLpuKkOrfpai8Osms6WW5M979CwG7BA1l0pgvdCaERqe2fJkA/wcdfYEMDxjmMRR7g0S5VA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b6642c-0728-45bc-97c8-08dbb5601a5b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5481.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 20:20:56.7841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +f6uEWhmNMCkTgHNNWMQR8getOT0tJgw99k41PQTw9uTlHdZCTpoDOvYLSrsJkoXcewaJ5Jo66X3F75F7BNYf/EGFd2KCVoX+9eQK61RLUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6674
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_12,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309140177
X-Proofpoint-GUID: T5_BmfOW7LEU7sz8TZxkaTSq4RMtPv97
X-Proofpoint-ORIG-GUID: T5_BmfOW7LEU7sz8TZxkaTSq4RMtPv97
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=william.roche@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: William Roche <william.roche@oracle.com>

A Qemu VM can survive a memory error, as qemu can relay the error to the
VM kernel which could also deal with it -- poisoning/off-lining the impacted
page.
This situation creates a hole in the VM memory address space that the VM kernel
knows about (an unreadable page or set of pages).

But the migration of this VM (live migration through the network or
pseudo-migration with the creation of a state file) will crash Qemu when
it sequentially reads the memory address space and stumbles on the
existing hole.

In order to correct this problem, I suggest to treat the poisoned pages as if
they were zero-pages for the migration copy.
This fix also works with underlying large pages, taking into account the
RAMBlock segment "page-size".
This fix is scripts/checkpatch.pl clean.

v2:
  - adding compressed transfer handling of poisoned pages
 
Testing: I could verify that migration now works with a poisoned page
through standard and compressed migration with 4k and large (2M) pages.

The RDMA transfer is not considered by this patch.

William Roche (1):
  migration: skip poisoned memory pages on "ram saving" phase

 accel/kvm/kvm-all.c      | 14 ++++++++++++++
 accel/stubs/kvm-stub.c   |  5 +++++
 include/sysemu/kvm.h     | 10 ++++++++++
 migration/ram-compress.c |  3 ++-
 migration/ram.c          | 23 +++++++++++++++++++++--
 migration/ram.h          |  2 ++
 6 files changed, 54 insertions(+), 3 deletions(-)

-- 
2.39.3


