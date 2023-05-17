Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC13706AF8
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 16:21:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzI1r-0000lO-7r; Wed, 17 May 2023 10:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1pzI1o-0000kw-Ni
 for qemu-devel@nongnu.org; Wed, 17 May 2023 10:21:20 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <darren.kenny@oracle.com>)
 id 1pzI1l-0005Uv-SN
 for qemu-devel@nongnu.org; Wed, 17 May 2023 10:21:20 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34HE5Btj030973; Wed, 17 May 2023 14:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=E6zhLFGqdmVAeGUyGocrJIa05gI+DvxeZwSh0C86e5w=;
 b=s+ykixy3XLXdJJivNyv2wFp5nxy2VTxR5ZQNgacUQTNry2FXFSpo5PslncC4FzzWmKm9
 UuQq369QpmpqMv3dOkjA8NebnP1bFd1PfQ7q6SDJBaDHE/Z03aVS6P+tWiFGL1TeBnWO
 XdeKDuBvQCX9nbaVhFLmeOVIdHO/Nepn1Kd03GtHm6NLLjYsoD1BcdJEY1ANlkSXBSBU
 gkzgrcB53IJGWOySPiAOu9y9yER4Iv3x7YInjBSwb0qq0ewK8hW0zaOmnOOs79yKLV4Z
 TIHU82Qx9WmPjodokl/TLFhB2OjgeP8QXF1z4DwofUcaq49d7ZEQzN0PEQY07/qiYipD iw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj1fc5xyr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 May 2023 14:21:12 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34HCfdfF036175; Wed, 17 May 2023 14:21:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3qmm02gafp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 May 2023 14:21:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QA0jgxOojurP2JGJPDEF1Aov7i3iaStIc9mSNZcC9zaZYIITPSkZlyN7YggIoGh95DaBbzg91mbTVjFzWyCRZguaCfqwUFwDdQKJ1P6ruAtqQbn9iylTILTK09gbYLwjUC+kbEAuMRKhvwYU3l5VR4pUm9E498ST6+fkBr9XGl+E7LpQyh3GdnTSTmPu5JB38UCR1EmgLGLB41XS4Gs4AX6SyilEjzZJGLGzFdnr4kavzVuzrtm8D4mOlgzTqyijvz8FGxk+1XX7h6BpVk8mTchKR90c0q1YPVj5SLhaSf0Axjs9RZBoxP0GhBA3j4FHEUeN3S2rgNhQF0gQvzLceA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6zhLFGqdmVAeGUyGocrJIa05gI+DvxeZwSh0C86e5w=;
 b=B/D6K0kh9lQDefcN02K04S9QICCaJwwU7WDC5Cer1wefU91BEhXStyTaFeuq7G9bwdtwlG624iZiWWmORp7785UPFxMUmVhZNxHx9Cvd2zT1c5ay3OpO+0JrVHWs0MnWwD+CXoKZTj3DmDAz+5GbMIoS2ltgoEz9n0UpsyLfgnegAwHvQkzgPPs78Zz/hkPjp7gR0jYQc8bebS6NqG0TUDCAyPhCl+EKaxH3J7mNNDDubnmwO52wzPLoYAeLrAq6/AELOCBRqHUw5otU4sk1SjFpDLoiId9xF17KCw0+2B6DTscpl9xFaSDsYT1BtmIZJkFoRQfg6kWMpxLsbfBqyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6zhLFGqdmVAeGUyGocrJIa05gI+DvxeZwSh0C86e5w=;
 b=xopO1g9ZPgKVtaOfBIwmNseDTOQlPLfjmxQFz+KZKvjlnJVtW4XXqCTn2i59VXdqUILBl4IxPTvaiu/fFumlV/aMbGSsmvvX0Tl14NP2oWkvoPkHgUicCXweNDvv8Fz6NNFlJGwpmexJ7+DffZ/f+QBxwvD34+cqpR2WfK2Numw=
Received: from BLAPR10MB5138.namprd10.prod.outlook.com (2603:10b6:208:322::8)
 by MW4PR10MB6439.namprd10.prod.outlook.com (2603:10b6:303:218::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.34; Wed, 17 May
 2023 14:21:08 +0000
Received: from BLAPR10MB5138.namprd10.prod.outlook.com
 ([fe80::8ed9:9d1:444a:c3d1]) by BLAPR10MB5138.namprd10.prod.outlook.com
 ([fe80::8ed9:9d1:444a:c3d1%6]) with mapi id 15.20.6411.018; Wed, 17 May 2023
 14:21:08 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
Cc: mcascell@redhat.com, Alexander Bulekov <alxndr@bu.edu>, Thomas Huth
 <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu
 <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] memory: stricter checks prior to unsetting engaged_in_io
In-Reply-To: <20230516084002.3813836-1-alxndr@bu.edu>
References: <20230516084002.3813836-1-alxndr@bu.edu>
Date: Wed, 17 May 2023 15:21:04 +0100
Message-ID: <m2v8grrqcv.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: DUZPR01CA0181.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::22) To BLAPR10MB5138.namprd10.prod.outlook.com
 (2603:10b6:208:322::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5138:EE_|MW4PR10MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b12539-f625-4966-e0d6-08db56e1f4f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HeZ9IHlVaTDWFT6G29wpQveXf84O0el90c6TbZqqKKby0XOeyUGf+A0rL8yeXZ0xJEas0lMQRN3y008FJvaTceNUYlgjn5NW9ovnDm3S+ZvcpEk7ucvKm9ohlHtQWC4zc1LJbFtHPdT8V5X1lkGiyZen3125I8Vw4G1cxlbDS3AIk6aOVP+La7Eo4P1ldGeh2tTthvZMIXT+TuypHfkTWXmosBj4DLMf3uQqMkRjAHlAGbZbC+24jpc8HV5ufWPXi8ptXc8/Dy6pWeEhUpIP5TM+WHvafQOlj83Fgqx17PSUP/KRxEu0YU6vJUh1qDa2q7mQjvb2OE32fr/0dNbAqP2WbWNbNHBE2hbK0oMl9PB0H1uVxmAoXYFEeqobrGGQVRxQLgRspYjJEARq3ISo3IAJk1nwjYYgw3SigOPTyAf1pxijbZdBZ4OalrpcSCbbBrCAmPXHvYpwwI3h7EkIcjXAmWn9QmK1vXNvIrUG4ZfK//pHcUAPuYNVUuf8nKxPX51ibVhUi8Hs+aISpSuAAE0SklVcjtQm7O5Na5Bl+l8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5138.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199021)(66946007)(44832011)(66476007)(5660300002)(4326008)(66556008)(8676002)(8936002)(478600001)(54906003)(2906002)(6486002)(41300700001)(316002)(6666004)(966005)(26005)(6506007)(186003)(6512007)(2616005)(83380400001)(36756003)(38100700002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z2tmEWNqEIVYtBka7tMsK4X880KarSwHmla1LawzFqNG8G5IdIaBLK6MDy3X?=
 =?us-ascii?Q?ceVWW5buNMkM4SntDPBzoLuiNkUqfpdudeCV/K0deXyewQX43JCTioCHB07Z?=
 =?us-ascii?Q?YU9E3OjPyn8dJ7WkL9QdZg8ELRC2qOAnAcOBO0Qrw6M5i5tTS7Q8GlohDFIM?=
 =?us-ascii?Q?mDFOz5efHVCV4SxTpT8mVCgfJrsz2QlN+aMT+AuJ6giopwzB73lJMFRh5oLu?=
 =?us-ascii?Q?/1mheMP0Em1ofsGTLwDiw/t14vzA+GpEnDHn8ni0gmuGVi2qWsa4w30KzLd9?=
 =?us-ascii?Q?znOl+KT33Oi+P5dx9IPzZ+Uukf1hq8zuzeq0VcwbI2xfDrCyq/qtv9HXgbBM?=
 =?us-ascii?Q?NVeprtxjodllsCeurmgBH0FaqlwEDtKXYQy/frBmFurrGKUyCi4m5tOaxd7G?=
 =?us-ascii?Q?/d9YqId76xBSLKw5d9e0+VtarGjfMro6+bHLULfmScxwjgmRnWSwi7Xu9uaA?=
 =?us-ascii?Q?A4YDd18T5RMnZyiIz6levP/uRMpO/DKaQvVdLNXyoOxHY47OWm2yrOWRRdV9?=
 =?us-ascii?Q?mm3DMgI7ztAgmhst0veNn1ZIKAvH68846is/+Qx5qYP1jMG+oxd7PHzUJJS1?=
 =?us-ascii?Q?wd4Psj4xNQg9SVcd+oPcc9tuNCKtfQbVr8VHcToKp5lOXE/mJf5k1EY4bsxq?=
 =?us-ascii?Q?QnkmRSL9xg7mugcqSTARvPJbJXwSeDO+qrhKfzoYpDgBahY3mqeyPq31b9DB?=
 =?us-ascii?Q?4fHuDUeLdagezj/E4pV8WbCOqyxoNKXE+lLMzn49Rygqbtg9YMGPwKB+5yto?=
 =?us-ascii?Q?H0HE7UVZjMtM//ngku5ungwrq7t4gwQQXUpgBm2jvQyZSjoK8xBEEnmPk0zG?=
 =?us-ascii?Q?gP6Nazwe6avg+1ksxW6TEkBjn8hnno2bw1cbLi+trtgmL20FqfuKtbvLAhqZ?=
 =?us-ascii?Q?Pho2YKEKFtoC5LNgxHz6BBm965/puGfjAm+TRM7oNfenQX82WDA00skzy0sT?=
 =?us-ascii?Q?6MFlFP3aqVHIzWulMdyDfk4hfUcPPL4pu5lCqhR3DQjmLDHmnjbHN2TABlxS?=
 =?us-ascii?Q?BN7llRmsP9oUgucrDGlXmdvHqtnxDSc4HoB8To49uNJD0cbhe6E6jW5C47fq?=
 =?us-ascii?Q?lLoWDwC90MaJcb3eKFUDdrncobhRx4ZDzHeFW6ZZWXuLwMtG//RKeVLKv71u?=
 =?us-ascii?Q?N84zB3HomPNS/bEJ4o5C0tNOv4hzcVrir1GtZtz1rKW47dE/ofQrHkjBeS21?=
 =?us-ascii?Q?otL2gCxPmRgMIPBxYOLZRP55Rz4UayRCA+Iv97THZ0wfSvmlgd3Jsc5wPWBR?=
 =?us-ascii?Q?/RwBkU083cC8hQKY4JdFWv0dajp6LsUkZwzd+Z27rEg2YUgs0nslsXBtEA0c?=
 =?us-ascii?Q?C1ltapCRs58f+FJKvkzz6LtNfX0UUtA8dwgw+lqqrRF7yaxe7ru3TsAXzOQn?=
 =?us-ascii?Q?qd/Sv637frID8w/NVUelnylH/ptZbN6MIAMUfGXjwKSRCCllzfoFCyNXb1hJ?=
 =?us-ascii?Q?V6MbIDq49ZdxldX9Q89+LNW2k/0zZG1L1V16yRU7/JflFW24EswHdE+s+uG/?=
 =?us-ascii?Q?oNWFHsC0loer9SYU4BsV1IxBtrVZkXMf5EUXN72rwJ422OVOPfP0bS2CHx73?=
 =?us-ascii?Q?TiAwwfhb7JZzOz3bDlD7xffcgANrh5LFiyb1k5L/3MNiEX82kFsznfp2lM5q?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GNw1Qjz5Fttglyxmss9ESv+ts5pyuMc5yFAFQFqrcErT56OGKm5CYZ6jm/sRD+dcPLGiJebBMHdxoJHmlqfpMDPHNxlILo/TY6UN7L0L4B8kgZEmQokAi7jeHy2PBcghuf9HBUQKc/3tpspJGzjeVYhb49W5m+rhfm6HeUy8pkhgfJt/DMTNBL3YC1iOQvclrd418yeGBcu2yrmwJPcrVzv6EfLuO5w67DjnPFbpuLCr4fwB0yFy0QIirZXarIGUiebRTU5EdA4fuDAa4DDqEob6qcdQoI+Qyi1k9thabeem1/u9z7vn3TB++gnrG6O1Pxybu5nTJx04Y3tdLvRURZrnwCKSq0t9JQyWrdG/5HoqBeY+DARRyrAEctauRlMTgNg5ydaWIszL1nQHqPm7rbuJr2NsmTHZjkJMA4AEtCZwZBxNdjXnGzJFDgMsp7yWAaRLFNjqkLNqwSiLH7yiiRjsFbvS3/N1EfplBNc+t8X+/rECaxSpKk/ZxEwieAXnPNhWR7xfStBtFMWRPuM3r+Ads6wvizmF5krOru28SEkBdl5vAOuoyF+xL03FFX9nfHJZ0x5Xo84hlBN0Vg1upEyIhmeJ+im8IBvx2u78i13+U5QKHob5HLOVQ0KxcLcTQDdnM6x6vArN5SVHAQG5N6GaOealj+emlSQcKKjVAhRSRLFnA0KDlwEDxDe6bzwgVj3QeVZ34QuV1kC3n2lS1iMiDR9bzjGl51gF7Gn9KLHHTTLgNAvb0MN07QJPwauHSTfYe6Jt70nj5AOm7t6zVYPbhy+uDKyAJufo3JvjNS2FWvkHvmqqjFGPHhoKXqWAZxEjBfj9gi65jRTCS8Te0A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b12539-f625-4966-e0d6-08db56e1f4f6
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5138.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 14:21:08.3336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QdercDEAsNdogoyNiYCzde6YVIyiWvrszgfI+WTW+TkLwUixYeAPcEeGoxJkG7jEasJtw4RBl4ldNv4i1EA24w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6439
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170117
X-Proofpoint-ORIG-GUID: 2j4Xrb2fXrOtcJGi1xGtKbpMoVLKhsdD
X-Proofpoint-GUID: 2j4Xrb2fXrOtcJGi1xGtKbpMoVLKhsdD
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=darren.kenny@oracle.com; helo=mx0a-00069f02.pphosted.com
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


On Tuesday, 2023-05-16 at 04:40:02 -04, Alexander Bulekov wrote:
> engaged_in_io could be unset by an MR with re-entrancy checks disabled.
> Ensure that only MRs that can set the engaged_in_io flag can unset it.
>
> Closes: https://gitlab.com/qemu-project/qemu/-/issues/1563
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

> ---
>  softmmu/memory.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index b7b3386e9d..26424f1d78 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -534,6 +534,7 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
>      unsigned access_size;
>      unsigned i;
>      MemTxResult r = MEMTX_OK;
> +    bool reentrancy_guard_applied = false;
>  
>      if (!access_size_min) {
>          access_size_min = 1;
> @@ -552,6 +553,7 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
>              return MEMTX_ACCESS_ERROR;
>          }
>          mr->dev->mem_reentrancy_guard.engaged_in_io = true;
> +        reentrancy_guard_applied = true;
>      }
>  
>      /* FIXME: support unaligned access? */
> @@ -568,7 +570,7 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
>                          access_mask, attrs);
>          }
>      }
> -    if (mr->dev) {
> +    if (mr->dev && reentrancy_guard_applied) {
>          mr->dev->mem_reentrancy_guard.engaged_in_io = false;
>      }
>      return r;
> -- 
> 2.39.0

