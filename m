Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 423EC7A8FFC
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 01:54:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj70Q-0001O2-Ri; Wed, 20 Sep 2023 19:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qj70N-0001NT-GR
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 19:53:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qj70L-0003JS-7S
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 19:53:15 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38KKJPoA022841; Wed, 20 Sep 2023 23:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=3pSwkADTf6KiV7uL4G/I5Jcszy5rG3yGPRE3vw/4jRs=;
 b=PkuEgaG7FLqyqy0I2Ib4sPwIdK3ZgVoXtrjLehdpis8IMKFEHzpUQj4qhPTTC87kV4qA
 yzZiTn/7sTyNdNgl/JgkFTsg7IO1y2V343siQfmgFgyblHO/+yhGkRHtH01/LhFoP8qL
 UmTBHxxWwFEXHc9Ooxq1BGo+fTForpA4w+FrlrMpKFygeZF90SrddnDiMyr+338RFRDh
 AJFlOfD7EBK8qea5vOwSpele0ijlzWuvcYcGR5vYh5R73+AKGx5zbM7VhxlTgGNcIjiq
 20Y8p0pHFaau0gQcQEekAJ0KsvysInYct/pvD0Qs1jZB+s9xwGdhUFzOQlAiOSYzfJA0 GA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t548bgfwk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Sep 2023 23:53:07 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38KMmShA015899; Wed, 20 Sep 2023 23:53:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3t52t7hn5h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Sep 2023 23:53:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTyR7T+KCUZhVd2k7ylc2mGTVrmPSkDWocBa5HbkJ2jO8dtLmfV40+9o8okmY5wIcogVAmAmsM0yuxewTlQlYHVu0myUKA293HrrIUJnrgsAjndKsVobCGooJvXod5KiognMDc2w25WpZX8AUDa23t4Uk0Jc1KM6XNoFwwxgee4M6reXZu6mptI5InkHtSL3xbN9XYALSP13WGXMjfzcKsi/SJ8h+wv2sCmvQWJyq1s2Fu7LZ1+EuGAOc83eMBJipkcYOOpPBE4ode5/CXHfmRAEOPM+Qsn26FeaFoJAI7+xota7/Z40g37r67I5VQFJxOnVTdk17nZtjPMmhHE13w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pSwkADTf6KiV7uL4G/I5Jcszy5rG3yGPRE3vw/4jRs=;
 b=R2cuyfNK+ZTaojcSpxe2SNgqgFMFU2OdmY63SGpwzAcemdKeo+pzlZJkBawnQs1kUtvj8XPdggJY8T4DVHmepAi05dvqoSd7KWxj3UIfxZclsIHCV0kRqFy/noIporZHRKY1WjucVu6nXh3R3jzYuX+8v4LDlGLsxzo0/u/y5HrKOIrxF694OI4zYUGpew2RqLnwPQUR5WbcThWtbWDdxhTnYJ8jrJUI+Byo1LrRxEQB0jgCe4TTmEGgLAwD4bgV4urBMIzsEqgrDayHluSzQ41bDDOyF4MlDqyKCalbj78S5oAYUe/alX3IHzEegj/TWzXxljbBVC8GU/wv4Q0WLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pSwkADTf6KiV7uL4G/I5Jcszy5rG3yGPRE3vw/4jRs=;
 b=CFutRJ355CW0/t04C430J+kiEc+AqK/cmoMjgGBbcJ4xIl79vZjkLoloBOFCbbH3AJ1BS8fm5omAmzZ4540bxsV/J9WZg5O5Cdkr0mxsRg4jUURzeYKH/HUXf6+sV63qjSfO1366bR4sNRepJHY2gd4ev6TOdnsCZdjXSgZyHkE=
Received: from PH0PR10MB5481.namprd10.prod.outlook.com (2603:10b6:510:ea::5)
 by PH8PR10MB6480.namprd10.prod.outlook.com (2603:10b6:510:22c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 23:53:04 +0000
Received: from PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::487d:5c37:8928:9885]) by PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::487d:5c37:8928:9885%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 23:53:04 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: qemu-devel@nongnu.org, peterx@redhat.com, lizhijian@fujitsu.com
Cc: pbonzini@redhat.com, quintela@redhat.com, leobras@redhat.com,
 joao.m.martins@oracle.com, lidongchen@tencent.com, william.roche@oracle.com
Subject: [PATCH v3 0/1] Qemu crashes on VM migration after an handled memory
 error
Date: Wed, 20 Sep 2023 23:53:00 +0000
Message-Id: <20230920235301.1622672-1-william.roche@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <128792ce-e3aa-a357-5e96-a4d8211193d6@fujitsu.com>
References: <128792ce-e3aa-a357-5e96-a4d8211193d6@fujitsu.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0354.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::29) To PH0PR10MB5481.namprd10.prod.outlook.com
 (2603:10b6:510:ea::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5481:EE_|PH8PR10MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: f48ca5eb-8d95-48de-53d4-08dbba34bafe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lsaTI6T96ejpyl4zK8TCT7SFWhUJRynKUOwvj7SS0bjaL3+ZBGFuJsIb5Xy6zktyQ6zvt7dIiho/sFu6vd4RaQGjT0fKgMDWB/zmx/jj7RndmvRIo8y4UCHaHl7Db9L8ET9pvGCh2qZI75EdRdzG9PXgDkuDYbIjGjewxA/7SIFCjuw/o6cRqrfRry9lFyndk8mEm3jVfoLJ4D/SRa5ev1nbOCbbRtp97rHdT9CUXDF42ydYr/mk1a8mcbX/DcT23Qj5TgB7IWBSLV2L6+tPYK4JCOAUo4TBDY+utiof/+IYXrvKcR7/kPhpxCTI1w9D7B5FnYWj5Zz82wtf94bpppmJgQRcr9PFYgFUvSNO99AlNObmFQ2Vul4wMLmCbawfdGTr32MbUbG4p1rHnEJI84h4ZwOpJkZCITzBeQmFxXTzj69+InD8w8y5QIY9Tcj2ys8DrGrYOz6+rUsk/EXBY3YvVPTftoY1jVNnziCQB9NUzJaqIVNMIVInvMvf6LpvSxDBj17Lw32dHozFiuN9/RG0ADY/gV0enWhd/yvuf7jV4YB6rd1jcZeEBqlwzRfB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5481.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(136003)(39860400002)(376002)(396003)(1800799009)(186009)(451199024)(6666004)(6486002)(6506007)(478600001)(6512007)(26005)(5660300002)(83380400001)(4326008)(107886003)(2616005)(2906002)(316002)(1076003)(66476007)(66556008)(8676002)(66946007)(8936002)(41300700001)(38100700002)(36756003)(86362001)(66899024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y1MW01NlWSYcDtQY2qR6fVA3jqfoByo0CU06+Frdg6ASYaeD1eYa4tmTxW05?=
 =?us-ascii?Q?D1o3/iBdyfVTiY62yAfQY/xZb1O5nHiteAbBpmJxcntN+xaPpbvhqDztQ9pr?=
 =?us-ascii?Q?bIObUzVumpzrKe9D/kybC4Qv3Hm917eGGuAxIjo85SuEg3ilDu86bWUuSr9s?=
 =?us-ascii?Q?5PQW6f/ufj1Minj6drQisQ2+nNFL5gVBkFU2CbaXDbb5tI3+xFEBnXcxGqwx?=
 =?us-ascii?Q?3xGLzfCm+yH+gFx3udbZ1z8Pr/0SuxNxEzPLhPXgh2oGiepWclTkl02zDm+N?=
 =?us-ascii?Q?nI62EafOKp2DgBrhNr+l+CtBeIHJBS4gpOmahob4JyQHkCsI5y9CWZrxNiKG?=
 =?us-ascii?Q?2/8vMDWNDd6zbxL/2xo7U527RoLTWj0P9wMp5RcNXbp+t+VeJGrTG8y9I0KX?=
 =?us-ascii?Q?RkBKjh/NOhuFyUYMltFmcOwepmqe7h71hdijJYmfGSimCX0K+PZSnqBjKApV?=
 =?us-ascii?Q?kZuoKP/tqRHENpd0pi8UqQiWPaLJm4Z496V6wSiSTSH7rFIR4/dhQtH4pznt?=
 =?us-ascii?Q?G1D5AuLlJ6Kvw4PbLsyalwf3JNE36IS+MknXL+G4Cr/5Rk9XQRURpj24+9oC?=
 =?us-ascii?Q?dptYp7jaSSKa6Q09P0YS/cwFwnEMRTl+Y6vHEliQoU2B7acWNpswr/pXy+Bi?=
 =?us-ascii?Q?ItHeEI7Rm+dpx4cqoq4OpWZf++G7HSzRJcLd2YWhsLtfYm0GLyAU8CSnlXkB?=
 =?us-ascii?Q?+e5dnNvptam1052kSufXTnOvp5pns7PHbV3xX7dMUiT4rk+Z0dN1hWHjizBE?=
 =?us-ascii?Q?D98y5w+ShxqfPJUS5Z0RTJPl/LB0PX/k6R1lH2nb+owVSJurcQajmJ7B3vRK?=
 =?us-ascii?Q?u5A8hvhdOKXjP8fYT8OtOFMDE6Ta8dJP1l4oMKsuY6mfPLkgPv7qHsuUzlZf?=
 =?us-ascii?Q?6ph31We+Bxfi+GmwV92lybrKAVUQYagtVINxyRFiraLIkNQnRGKYx5FcAHMa?=
 =?us-ascii?Q?sT7WPPN/ZF74hRo1UZ157voK5DrJJN07do4Cf1EehBWZ5Y8AMd+ovx4NA/nY?=
 =?us-ascii?Q?D6GztIvNWF+yBFXjpnvEMiBPVknMBX7P1EvBg1XyfeopCuWgtYNGECdg80Ez?=
 =?us-ascii?Q?B4l9HAyrshE2fE4I+piKtGPmh7tIk6BKusobxSYHnkbVpa4ISM/MbsV6rQFw?=
 =?us-ascii?Q?SKKwMeuIOW0NqQZf/cse5jpgJtKTthb8mCZSIw0vRCBF+M5foxX5KL93l0BU?=
 =?us-ascii?Q?Oe/BlJZ9ZUpE/xnDhNmp4HEN6LholDQGPjSGxbTZWSPZLd8r3P4PRADALVS1?=
 =?us-ascii?Q?fwyxJ5lUbgVzCCHE7GJYGH3YViBq+u8jIMAPVPhncgtdUX4RlfoYAzRtXiHn?=
 =?us-ascii?Q?ikP6EITkufLSZaQiN3w5wV4uHSwL6kuOaJDXsoTZeqNaD4jxsF9JNVMfyDDS?=
 =?us-ascii?Q?dq8Bm8IhCMwzdDHBOx7QbIlSyKsS62SlGCpoBDG+f+nHvAejtHrHVbeFLy5g?=
 =?us-ascii?Q?iDuZynaGZ9OsifnGV6qP7nQAC3qPqpX9zW40gofd6ew2KkoRiEjzbpUSihIw?=
 =?us-ascii?Q?9a0M7z6SUQgMfrUbjwMqqnzAsc7avhm0LSaUppvUskFjcjynWTGDIT/DarhJ?=
 =?us-ascii?Q?9hqlPnAa3BGYrXSS8ciH1aUyfWPvMfNpP3kkRnVvUy77IUgoxS6qR5cs2XSD?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ChSIBioOq19bNVzZerO03FwQtPrIrvylFF0df1rTMKlAO7RLR7Ac1CI8rH0o9LJVh8R4a+VJ1gUC3dk3vlv80Lu64SRcXMk6yEiDuq5YzxbhPCllrwMiiDnqzduvN4Rd90DSfJ6eckBtl+NVJxLqKs9q3oHwHZiThd3aaA8gom1nMZcA8V6L5STn9O6SdLE6ePR1r3dPnv+Bn6DOVpFGmhBYAzvpGutYsUY13ipoisLlBL5ZGAtIFhCoRSIBJxUwqVb/vZuv6DBuQ5dKd0xf5aobypzJOS17u1NKZEMgtHAuMXD792ii71G0+SVznWnPmsdBARvIrHuD1Ra4IBhEfEvBZpYAeOpeoK4yPirtZ1FFKbzQjW1SedNWsErzpR9VUefIH5qnkyI8sTTAGr/wPnmSRAkzSCyt6Vz6jgBkQinIvF3bEseEAXOskMWUmbi28IfcdpBIncXTCd58j99y2D7fdd8OHxYBWaGwq19gPdaQ7XGJfH1xbEosGpS3JOxmPSoD1WrOMdBUVMlwpUhnuunW3wmCxR6PUNTnXupI5h9KkYmTRHt4c1sSN2NV4grWggZoBfn1GB7jjZ//dLIrXmnHXRH41dAopE6272EawozT6xdTykvIOcN8sCYjf8hVqKWxSVns/6/Mbvbdv3XuRsr5Y5oP/luJGPacE35gaSYXItxzwJ+SFRG1KMBd+Ti7zu7pPat+S6rpTMhZ7LklqqqnFXoXWuCr21WKMf4HwNFKq8YQ6W+IlW+8M0X1GQLxOxz5MQW6Do/N7q4EqcGNGQB7UY0wnD6XqqiFtfV+JBUUyjAULVdyaB7S/dwyvA3wjIoNFehGf0GOZ6vQ5d1bDg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f48ca5eb-8d95-48de-53d4-08dbba34bafe
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5481.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 23:53:04.2833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8LS45eVOaw9WtG+/rNJ3iA6Pa6y+p8zDvlAqSB3AkLsLmrRxRTVaERbL3grFL8i6zSxUkklPIJo1eVfAvVCOm5eYI++qkgPcFHH5ZkRmCyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6480
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_12,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200200
X-Proofpoint-GUID: p0zeB7B_9oAynju3vx6ZcFLWraa9GDZm
X-Proofpoint-ORIG-GUID: p0zeB7B_9oAynju3vx6ZcFLWraa9GDZm
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=william.roche@oracle.com; helo=mx0a-00069f02.pphosted.com
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

v3:
  - Included the Reviewed-by and Tested-by information
  - added a TODO comment above control_save_page()
    mentioning Zhijian's feedback about migration failure.


William Roche (1):
  migration: skip poisoned memory pages on "ram saving" phase

 accel/kvm/kvm-all.c      | 14 ++++++++++++++
 accel/stubs/kvm-stub.c   |  5 +++++
 include/sysemu/kvm.h     | 10 ++++++++++
 migration/ram-compress.c |  3 ++-
 migration/ram.c          | 24 ++++++++++++++++++++++--
 migration/ram.h          |  2 ++
 6 files changed, 55 insertions(+), 3 deletions(-)

-- 
2.39.3


