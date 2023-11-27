Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 236807F96D3
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 01:29:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7PUl-00076q-Jb; Sun, 26 Nov 2023 19:29:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.christie@oracle.com>)
 id 1r7PUj-00076M-AC
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 19:29:01 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.christie@oracle.com>)
 id 1r7PUg-0001H2-HX
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 19:29:01 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AQN0BDc030839; Mon, 27 Nov 2023 00:28:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=FB3Lu7Ud2CBK/i3Ofh8tMI8Nby9Klyuu5mB+bwlIMQA=;
 b=TW5cSgDcdB4NAEV/gr+7tzfRn/LCjWFQO4MYdagC1IlYtZat5VUd+5mYT9Ds0S+ZPpma
 Fw+anRwAtYSM6+ZFNoldRdZjaLqf9zuxt1LZ4xDkxTol7IPi1ZNln5TTRzZpXOOKu86U
 7gTcPBkq8R0UCb+IAhO4EHzB4/RFe3VZ4/NrJEUGnYtlG3qr8PIBihkekApirkbqGKxI
 eMLRcgV4P5xV/8hitF94rrZrEpNRfZZ132V/CuaWWaVOrNv2KvR0TSCRG2PtYHw4hB1Q
 /w+PdkIJmYNS9NJP6z1G212H0HhvoqruqDSOYbfaaaxokI/GF4DFqh1IgkRklxqXWG6Z Vw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk8tbsrn4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Nov 2023 00:28:50 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3AQL674B027254; Mon, 27 Nov 2023 00:28:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3uk7c4c3re-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Nov 2023 00:28:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMoCsHwov6Tl2gdIzNQsyGDMhXSd26QVwRd7rg3uHaPQ4DkWLe1TGw7DQO34rbhOhRBSSGZfs9SaSqwri3x/NEKRTxJTPoK/IDTZLHbskPnSwNeIpVbsoj6vpGiglshS6eUa3EO4TKk7SoWwh+kGWP5UCYWPa8Pe1qoObqLgh4Mm2MVs561m69+BnAMd9p+BfBqwbg8ZoGTTjZNBs4CxtQPyRs1y686Djr0Z4sthRXrFmrOPCzJOuFKD91wU02nZasjqaqFHLA8WUxdubtgYZXoR0gwcrrhs0Ept9G/hp5Rnh+MeDGNyqYAbqBeEHzjkLRuUVD/K1RmueJBfoDZtEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FB3Lu7Ud2CBK/i3Ofh8tMI8Nby9Klyuu5mB+bwlIMQA=;
 b=ZUd7e6DTAFmq50VvsAs9+gmifwX9cfvx5g+Ixhr4anCfx39P0OMfS6IrklBDRMJbFIMCz3DJImUs9j5wOCTgw53dmPbLkijgbs68Zlr+uMcdUYiLmLbTsq51X/LzbaHYslNmSwnw/CcMoVx3gQ86NM/ya64Dw8yErQm2/zT0yR1YBaQZeFeDNzQrECQojEXX3FhF+Q5if1+0gygZ9nh8ejt2Ux7j5gOGOeo8oKkIxrAcJv2HBnuhoRQ9cHU1wcVhTo7T982mA6FlxsycM6G/IiNn1HXmNLI0GleFn1y02iZzB5Id7BQAyRBJwUtfRd1L37qOT7KFfKoXlTg9zzsylA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FB3Lu7Ud2CBK/i3Ofh8tMI8Nby9Klyuu5mB+bwlIMQA=;
 b=vgPF7Rqf8MOU6jEMKxg4gXN5+lt+S/VPWF63G4JYlzvez+r7EDJEK8M3bMwctagipqIhYq/fgnw/dZXp7ofBK9xrT1SnZezn5H8G1zDlnuFBD7BRptERtU8S1sJyyPuP8knl/MH3ENQx4Zhl+jRCKFSCjb3cm4nh/1Q8q/Kg22I=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by DM4PR10MB6863.namprd10.prod.outlook.com (2603:10b6:8:104::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 00:28:47 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::449f:4fd9:2d3e]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::449f:4fd9:2d3e%4]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 00:28:47 +0000
From: Mike Christie <michael.christie@oracle.com>
To: fam@euphon.net, stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com, 
 sgarzare@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] vhost-scsi: Support worker ioctls
Date: Sun, 26 Nov 2023 18:28:32 -0600
Message-Id: <20231127002834.8670-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0274.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::9) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|DM4PR10MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: a651c01c-9dda-4356-31cc-08dbeedfd1e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D0lnHNckrMMsNuxy22VLvPwR1AIlZb0NDre06TQ7ChClK8quufrEKe1Km5GvoNn4w+q2IM0XjEru1+tqcItqugHPDqxFRUcYaCinpglJLiQ9uJD2AKdbh6TvXvrLL67kyi0FuoAjP4ZZ4+iv7Xsm2kfQ0mFOxZH5h+YD5fDXMoSa4A8q/rHAQD1lrTyH/axYMKjdIPMaDIrFN8dkj4U9Nm19RPnu6ORApN+axNkcnmrbzGSUwFEWyJOqe7KXInbPUnHAGve5qWU6BmpHRW4zsh1qBilOV2T8bQSDRzYtAW6a6Kss/lDUqKBGE+OjUB+T1ckKhB/WGw43vGXYL3+wtd/pcodhMH3sixezIOzEO0iGcZlVKcVWD5YPrjUAywq6GwFrr+iPg9F3RghPEwcKO26f5eu5zRIKaizWVaMa2C41I7Vu57MPI2L5j6i21ApMe4NdUvMBlvsu0G2Zwst2jhZ/CCrnoUfTIR+wTqkKuze4G5Lkb4QegSpdVywzRsF9JUirhJo42qylUFAFpZPBod8ThIfSHFEI2XfAaJZXHQ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(136003)(39860400002)(366004)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(5660300002)(41300700001)(1076003)(26005)(8936002)(8676002)(2906002)(4744005)(478600001)(6666004)(6506007)(6512007)(2616005)(38100700002)(83380400001)(316002)(66946007)(66556008)(66476007)(6486002)(966005)(86362001)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xKVqy2WN4RpWxqUHcyTOV+h1FjKCvaA0fvhWdu9RETF06A/D/ZREV1japjgL?=
 =?us-ascii?Q?nH6xmG8X6C3OYr7IUIS4v8NOaotwQDYvaMoX9JI93omVU+k/Jmr55Jyu7PZG?=
 =?us-ascii?Q?Fqm1w9Y8/Po4x2Tihs6Ff9aMuOpHXdGeByvz+RWdqyOMv+k7ROzo7SGb9L4M?=
 =?us-ascii?Q?MIEcSWZsWVUAtPGTM6OLfl3O2YlXHzlB0PaXrLv/IKvAaVotZmIsSoQPNcXM?=
 =?us-ascii?Q?gRNF3YtKnXuX0PVzMN6XrzETXeRFUFFFKuQNECtLLVzE+g7DDRvvR2UMAebe?=
 =?us-ascii?Q?UJsxL0M18t4230IdK0RIMyRDEAGx5G7yavn7/0TJnBf1oBV74gjtFfB4CMzO?=
 =?us-ascii?Q?m9RbNXGM2bxh+YTzuYmaPhnBqjEm7QdOUWzpMxE3VfMfqWqLmDX/XOaOgMdy?=
 =?us-ascii?Q?9wCvhU6pr+j1JsqD5nFSy5CDPmZ0TdKB2ooK79o8FGayZKLh6Ddb1pBKFvpk?=
 =?us-ascii?Q?cv3KCcGLMaCU2XDqvtIvssavGen/AqDrzC2U3Q59XKoJmZYPYFY2ii1aPKsw?=
 =?us-ascii?Q?nYtxtpBy9diPlWesN+c1b31gSNS4+OSGmqXXvqSth1iniLQZo1wfZwOeWO4h?=
 =?us-ascii?Q?Mkl+sZtOwLjfAmeUPM0GFUquqCOp2dwRPa6t5IQ7xbW198wHhmBu2iUjO9Hv?=
 =?us-ascii?Q?vBR7Ral0lJK4bFPfRJD/ST0QbfudMGmIU1SA7pQAscfbEFT/IpyjMOsna/eF?=
 =?us-ascii?Q?Q7GRUyJ8FYgQaPmWB1gBLPPL2pxfawq93+1DidM1ODRN0XTvfoTdXFRGA6cU?=
 =?us-ascii?Q?xsOxPxeTBFixt+yO1tCyIgPF+4fomQ9RQyRbLXXvj6tnLF4tCYs9ZLmAVTYe?=
 =?us-ascii?Q?D6aSIoPgMH97+Otty9lVtZwAN2CZ3Olx8p1KWYhBZKLMd9k1CU2uBbva4Yo6?=
 =?us-ascii?Q?ruq2tCXXL8QWGu8L+/xE1a4pgZCnL9EuJ+OqDF+0CBSyJ+7mtLio4WYuQM8u?=
 =?us-ascii?Q?+CLGTnRARV/ZC3FcUVQ2xXrIKHJ0CDfPldMGXJ7XVn56GOr2+G5EtxpTIZv3?=
 =?us-ascii?Q?Bbsgeefyc+pqc+g/BjnVeBe5VMyUlzIgPbBFgl1Q+mg23H6lKSnlysGXj/ew?=
 =?us-ascii?Q?xFfmKEwwx/b7CiAMRUyQRLJmLYEOhiSU/sp4iN9zSDtfcb0BUN7Qkn17p/vY?=
 =?us-ascii?Q?l27V5BK457uR6/ZSj09gFoTfHow6O1e3NX9bTZQJviwPFuObFfO8Up8FpHQ3?=
 =?us-ascii?Q?eWkvQKzWsE/0CyLc0/HW/Ea/huRHVRrUaF89OuFasZhmIHsHlQoAMs8C6pxC?=
 =?us-ascii?Q?8Absrt8Do1a3aUkeyqnFtvfWr9x5pz3ixCm71XbQWwfE+QcRHbVNLvcrsA6h?=
 =?us-ascii?Q?vt6IfHWTbCrEbfGrGfqIJ20g2TUd7l+DxIekDMq6W4l7+2aPLDDi/oilmwze?=
 =?us-ascii?Q?usXb3qbR5aKfOddS3qax1Y0zUCNcsYVAAeUZhkDkKIxQf+NY7aTB65MhKmb/?=
 =?us-ascii?Q?9BSCcPivHdIaPX1Lv4BZIMc2g6Yq1g9te4Nlg8FyhUr88j4uzYxvCpnpBDiV?=
 =?us-ascii?Q?S91hink6MfSLq5D02Nm0ZcAADntFIahFLEhO3plO10WjfwjD4btC46kR/rwK?=
 =?us-ascii?Q?+ZyDRWhVWblbl6UKlPJhXbkPRtFp6wmvcYPI0Lg4aollWHywAWcgUGC5awzk?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3aJHlguR5MDWyFd9jtjPsvlqwDwfKLa6ajOqdOX3pcT5T/N/70mJDw7xbJmvDbBAHCCs1QlRhUh1wDs/FxQhccZS60clnIOB1E7ETrRPHijRaUabTP/4EGR06RA0dJI9a+/5hPEhhtxscHEHx1IrPitWDsTajRZQzomAhFnDhzAArYCkoF1nNuhMr+N7Bp4C6ve/aMysDeKCGBp2/NEZ7wxkk2i+0DC2jjWqp82mvlLUg5bqamZKWmCfRCR7oM4xWsV89kMXq98XxvsWLdthgNU/Z6RQLK5Quk+ZwyQ680R7CeMEiN2sm6RYTAcAFVb32l9EVG1TQJkxMgC+G+ouls2hI1e60jTDSi0dpPQekFRV1xytJj5JaxBdwQL7+5awNsFz6Lw0/VfFt5WBgMKt7VNjj/uwAqIc/ssqxj2NP9+D+qGaLCPI2jcpslgRd0FBp8pwafJ94a9jxoGUIeNVdHKLhayvmSfOynkDyrVKg4ohtWA3Lk640K75+jdMFvZB73S8jxKE/8ri2rC65/Yss3iOrDmvs9bH7dUwW7+OkLWMlrFG6FPHt3qQBqh/qHkBB/nMDHVqpyPidEsMdLtQ8Sk8Q3zreMJImTsuUezq3KQfjnCr2xL1XKTZtuhg/z1qRS13gXJJJTvYWQh4qMnIZh9kKALxoejvwLOlrEQExO9cruUlHUu1on6Lj/EoONzpxHEGUUR4HeelYGXsfg0xmBnc6G4dU/iQkYzUeuefV09tlAe289K0Y5OCQDwReVum1h4LfM4bZRHTfDjhUOEtXBXsnsg+7SXogpfxGUf3fYCaFjKZlDg3ynmZAhtLHK12
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a651c01c-9dda-4356-31cc-08dbeedfd1e3
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 00:28:47.2283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WsW+6lgJLI5msiqMDsYdvj+leA6ULbg7AUGUExmRleXP8d+gupHDYbGDRLWBqw26aHA63TIw6cryTc5QBtzRcEdaH671dXjNZAAhDLa3H80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6863
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-26_25,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 mlxlogscore=742
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311270002
X-Proofpoint-GUID: hkxidkQJv6a8aAhcAzAPnxmI2SCTUDrK
X-Proofpoint-ORIG-GUID: hkxidkQJv6a8aAhcAzAPnxmI2SCTUDrK
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=michael.christie@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

v2:
- Make config option a bool instead of an int.



