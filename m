Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7172E7EA792
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 01:38:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2hQP-0005bT-Er; Mon, 13 Nov 2023 19:37:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.christie@oracle.com>)
 id 1r2hQM-0005ZK-K0
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 19:37:02 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.christie@oracle.com>)
 id 1r2hQK-0007Vt-EL
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 19:37:02 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ADNscgH016932; Tue, 14 Nov 2023 00:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=qEX82htckNmDwkEyFTioB60wFp5l/QXaaVPy9q1o/XQ=;
 b=oOPy49A01dyMoUOnZQlgVku4sHJXpbD3QsmeL1Sql6Oa6i6OryWYLbs4uR5lXgeljx6k
 /E6OTp+mVlQC/T+nlShtyiaL4Wu1NSsc1ruREb89NezIPVZc2W5GjwTNgpTOJSiB8aOd
 PaUnYhEByyuGAB/HQwrOUhYA7mOrSqtdla+LCcinnvp+gsdlWTc5IqBrUEsmGKUywy/k
 qJFS+KWxc/HLu4rO0jENdZYIF63+3NLHuSYX0nXoOvMd4zIRqDapUhNhkERLZV5pUzga
 MrTAdrf+Isv/m575wbuRgX7vWXXQOPXV7pI+MdR0xN61AzpyVMOjqWiZoO1BxU8Tb203 kQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2m2c2jv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Nov 2023 00:36:50 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3AE0ZAGb029856; Tue, 14 Nov 2023 00:36:48 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3uaxqqqn6q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Nov 2023 00:36:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfRo7nFQ/i762OXXtk7hOT9JcR7ytGrav1jVL39S1BX5Np7J/dB4fRSrcAkgqOuhzdu/nMlrr+fYmPTUxqs9nnZyNPfJHOSJMBSZtKNzNlguKeuDafCDoqbx2CNhONbaZGiol3o3wR+VWcPDc4pE1rlRCcnZ8323n/ixQ8n6gBcGc66ZH3lgE7ahwj73T1nMzTAPYzJXiRyptUN4yuSmnLsWoQlr7E9F85w8+c9ReaTEK+UU7dBDNCP9HQ0IXaT68eDo3kupvnpsakUPjoAEQ5AZdTzy6E36rfLMaFY9SqxI+RfxxTddK/74Rw361BpzroZFToW3SIFnSYRFkaRtFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEX82htckNmDwkEyFTioB60wFp5l/QXaaVPy9q1o/XQ=;
 b=RwSRM0jNdvuHdcCF1uqPW9jqpmtx3ljArTnheoYZz6tuTDqdqlY4C0mlHCZanlwi1fVDSNMRIGo9XWeWHnDQG36X5XmoTOsEny9umL6SJpakkjqafVe0xNDZ4LyEWWlEG4A0PEDckPZLZjg8FrJWlnsm64+JUYDpumvWhmfiKSi1B4Xbrocm4UrzGIr7kbfQbp90lNfOlz/w33uzTh224EM3nydsDUW9/1k+hChXaazJIXZOkCEMvD0oh6CboMhLQvuCB1BY5mRqOG1+7DkjLNEZkQmHGMfxLaByxsMYYoOMqH4QUBvCLcnQF8qmCAGICi7usj0skaHCL33ED6fA3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEX82htckNmDwkEyFTioB60wFp5l/QXaaVPy9q1o/XQ=;
 b=aUSJ0r9GVQcekMeBONr6y4uvadKQPlpwf7CrX9N/UZQybDmaJplyS6PX4ut5ufex5otntAu2S04rTMvmHxIaWoTwCbF7LYuSkFXi1wFp70AicIxA8lQdTWJXgDYhbBymQ/hMr6wcUNvOiCqNIE9zy2e8aDVcLAHON5+M3RgSmP8=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SJ0PR10MB5645.namprd10.prod.outlook.com (2603:10b6:a03:3e2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 00:36:47 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::449f:4fd9:2d3e]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::449f:4fd9:2d3e%4]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 00:36:47 +0000
From: Mike Christie <michael.christie@oracle.com>
To: fam@euphon.net, stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com, 
 sgarzare@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 0/2] vhost-scsi: Support worker ioctls
Date: Mon, 13 Nov 2023 18:36:42 -0600
Message-Id: <20231114003644.7026-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR05CA0094.namprd05.prod.outlook.com
 (2603:10b6:8:56::11) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SJ0PR10MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: 83f01359-61b0-4150-dcb9-08dbe4a9c89a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L1r8rEaib4gMLoY8EouIYZXS9UR1p1ts3YnQxhyXrrRJTT2/l3fKXz9JT8bdytEBoxmEouSPuGvSVjw175gTMNQjjNPPoaYFQMZPZv6fozlHgM9rDTix9sHtGmNCgDL16Uy4R3R2vcYTMPJmMx6hF7X0RBuc/iwXxBpldxL/iakbTxUSlYxzlKZC+eTSXhrMaualpVEEZF6F/gex2N023NIkghC4SMGXzcTE+L0oJOPbyAejeQPfipoJa+TYOgBd1ejMraQ7AqyvmQZTor5ML/Zl0gnkD9/jfKjblInIjQlLNarUsECmjIMtSOqf6R0zNEo2OCw9FEpTA6wa/wMprtOKYlGqCREJ9rfy3J2hB1lV3szK7gfqL2CmVPe63q77/BA0AJuqAo8PMW+9XTeouWLdeahMXq99DjtKX9zm9wlTOe/kcNYwv43hrdRrdUsLBOTx/TGu5dqSgoKGk4vGVelGwIfHrSCpSOU7UkXCqv8Q7KwhhY9WfIFgJiGOn355yR4zFBKxibktUrXYarhJuQju75qRLfL8tmDy8SkoyFY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(396003)(376002)(366004)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(5660300002)(2906002)(26005)(38100700002)(83380400001)(966005)(4744005)(6486002)(8676002)(66556008)(66946007)(66476007)(316002)(1076003)(6512007)(2616005)(8936002)(6666004)(6506007)(478600001)(41300700001)(86362001)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4THFbFUGsCLu7jUYFMUrlYoonA1fi/+qHQE9Ys04O/fR7XOigQUUUKdZ2Wjr?=
 =?us-ascii?Q?6OIN2BCT1rOVYCUklNHz5ypNHXeL2bdMtaZq2uU3fKJmU5VtHCNNuQSZJGdf?=
 =?us-ascii?Q?VgSnmc4+xoIt/HJHFsVIaiZjD1keNqqVZdjBQuyPOzZIAyob8XukYXuDMVsf?=
 =?us-ascii?Q?LguIInC3/VNy5HX78RDoUWOpkjyBaez/idOE1NbFThZtx3cUPBqhY5X/2LL5?=
 =?us-ascii?Q?M++qtQsrrqGzHZBTEbVQLfkferMyRC46Br9SPrvOK0/HrWOAhGB9nZ81coHG?=
 =?us-ascii?Q?dp3VPqvCslFxuRjZouxM+KwBccFpKFZv9JG9ZVUxNKEW4Ljci0YO4C+t914a?=
 =?us-ascii?Q?kJpOUnBZ1LsqVJXU5W6GCDdIB4dn47iwkA2dPlXVfnq8RrjWWu8XFzkyI642?=
 =?us-ascii?Q?o/z4bZx0E1ENRQiuh32OFUMaLpKb+UoFxci7ZYx5ey2TcPgY0oSCbC6b9K0K?=
 =?us-ascii?Q?C3u3csVCMi4DLUH2dIlPjSBkgGDaQBV2rD0l7bfJ2+pFtmOHhAZpWHnG2V3N?=
 =?us-ascii?Q?N56PzvuNh3vdQpUYj5mBcSyitv0dGsLAM3ReuBoH/0UDhiYEu+xYePUXx00g?=
 =?us-ascii?Q?PbnmwDdxvMYff8h3so99dcMzEidCV+yEjCSQZgCwslIRD+nFnHmroHH/pEnC?=
 =?us-ascii?Q?V3OEVp/KCynb+QONVg/xx3YxZFwnxEgpizJ5X89bWv3g9KSnHv4oipbrVyr+?=
 =?us-ascii?Q?pX/IOvETgP3v2olKEWmRqte+/VMei9tpAdpBMLpHNsU6pe5b7Jgi2Pi8H+8a?=
 =?us-ascii?Q?KxycStHuqJA2N2Pso4jvzVaD1QHQKYIsbQcndG4eVX/K9FDyXQGry2SIFxS4?=
 =?us-ascii?Q?giYH9IN64hZi++OYP/TLTRekVdH4IsOAO9scerPKaCvmvmN6Qni7BXB1YqLI?=
 =?us-ascii?Q?I3jro6QpYuLif2nIL6jdEadMrOzv593bTj9eJ7hkRxsel2AhoBV3xrApEzKo?=
 =?us-ascii?Q?TMV+NzKjRLKcYOY4sX7cJiIBHPx+3EGwD1u6KFIstZH48RhiMWJ82SvyrVSk?=
 =?us-ascii?Q?IfCIlfLoGWH6hyOaw74QWkw8zdlF3kSbr+KzUm31PgDgA/Z8hHwvXZ049eGf?=
 =?us-ascii?Q?XUr+EMYOR1ip0ae0xFWWqDZMLU9Uh++4gFPN7Xls2na7L7wRW5M8bpemIdfr?=
 =?us-ascii?Q?hpUvev5fsZJAHP/D06Khql3PBx3c/8rf5TT23Xdka3vgDbOFqPbC8vfp3bqV?=
 =?us-ascii?Q?wyQnhTAEgLereHtc6qwOh6gsBakTeAD2TxGcqddxZ6YT3nfczAvct6AmG+E8?=
 =?us-ascii?Q?lGqR4uBsd+rPGKcvWHCvg3CdP+5un3jDd32mT5kzpbz/W0WURXGXw5oMBHp0?=
 =?us-ascii?Q?/yMrhMzQG3+OhUEmvofVHFZeeYXzJV7f3ETuGIP4BHUXYsRMokB5C9talNEL?=
 =?us-ascii?Q?FS5A+wHxvJvyXtGnDnVC65udAm97Byt7hcKYGjURpWAySKSfhiBh9ZCoDuBS?=
 =?us-ascii?Q?iMYFaqtoOzqpayi/2cnoqVWhIjM3a2W/gueJ/DorgOHtrjn54e0KS5Ntm+sj?=
 =?us-ascii?Q?SoPOdCvd4xx+1YDyMguV7ArptRb+a2qRTwM84lKzEqfBJ51NHa2EuCmLvBFj?=
 =?us-ascii?Q?eWFEbM0mdQgHJjQ44BcvMhJEUb6LofqVAG47ymk3uPpG0wlObkRno+fDsF6V?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gGkiZcSux/ecdS0bXhbELzdQNV6cj/Cs0k/87OxuzXsmN60u+DX1oDJgrL1aLu3p8rgihHvmq6sxxxTTN0ooXvuJOvzA84rM7NYPVWG0xb04krKaivRRt3jvCiBsY8flnbJ/IZGA9hwukQPS7rTjVSY9AFgd7I8f5UV0OJ+pcbh6jOnMrfgTQiL+dg5wNVytVMwQgS308BzbVXkycUtHKrukl/hB8PSll2lWsPAF04Y9pyGcjMD/wQOZylO4t5x7evQe+oIFKQTB8J3YkwQ/rM7/Pa1GmZ272tWvLnCiimGunryg6CS4jRgW9ivU+IL9v85imH9ZPb3yVRqztOLbmbBVKs/04gUMyImNOwO+YZL5g6oO0POPDi79MBcbk02Ma3FCc8o0x4B6Gj9nXLlrp7TiXHPEEkV/NhOzZCzq1IhSctEg8BU/Xu4K/gUMYAqRAd/DHRQ4TuB9WcFFcPOqUaNj1hZZjx6FbTENyiN9ako/HpjYx0143+o4f7QjhpaYX1Cin0TV+laVNfj1QW07aQXbWGd//5MHjfGzVL904+tExoAibWnbsNFXq6Zqh0Xc4+f1ew8m9ojpFXb7JCSLBq5BQ1yFXg1SyUXKQufBxKjNPyoCcVuKl8/NKviIuoywbIQ0i1RCKoNNhX9dOXy93/jF1pJ4gJpuSTpx/gMo+Ey5onCeAnpzCboBZDb5Ib99u0nJuLe5lOzYCUPaECeVukOAGwDj4CWXyyw+HXmos1pUTqSDRfs3IhLG0EFO4x4kIDGSgL6cFpW2ZwnT8eSMWXPp9W/OMWLjwcRP3rPRFtDaq8tFIM3UnhgrTQvqTolP
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f01359-61b0-4150-dcb9-08dbe4a9c89a
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 00:36:47.0274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F15WB1dwOu//EV8UPmijss3sPJuz1/AwMlgtumQj85a9fyi644eyCrt5y0/EMqc5uZXLEXjGfcnNGSAlqKT831d7TisoNRyZsT+1E+Vgv/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5645
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_14,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=667 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311140001
X-Proofpoint-GUID: dEXn7ZZpQP-jq2b8_Rgb72iyAq91e26J
X-Proofpoint-ORIG-GUID: dEXn7ZZpQP-jq2b8_Rgb72iyAq91e26J
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=michael.christie@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The following patches allow users to configure the vhost worker threads
for vhost-scsi. With vhost-net we get a worker thread per rx/tx virtqueue
pair, but for vhost-scsi we get one worker for all workqueues. This
becomes a bottlneck after 2 queues are used.

In the upstream linux kernel commit:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/vhost/vhost.c?id=c1ecd8e9500797748ae4f79657971955d452d69d

we enabled the vhost layer to be able to create a worker thread and
attach it to a virtqueue.

This patchset adds support to vhost-scsi to use these ioctls so we are
no longer limited to the single worker.



