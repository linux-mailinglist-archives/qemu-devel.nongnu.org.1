Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2A37C8851
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 17:10:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrJmo-0006ge-Ha; Fri, 13 Oct 2023 11:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qrJmj-0006bt-96
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:09:05 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qrJmg-0006qV-Oh
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:09:05 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39DE0oA4009594; Fri, 13 Oct 2023 15:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=qWTkuUSVxy5AFgvjiMGiQyV1C10fInoq0uMEYos+80A=;
 b=slXQ17RP4YdsxrJQ2+B4ImDZ2i/ljh4gvIj4fBItZOXi6PNdwS3NlruTuvBQ+L4L5rVv
 vWl/BblomjV9haIuF3FNq536qIqJ8UThAqxcFC5x6gFBJKNHvT42GKLI0Vx8CV5fW2zv
 lZpXeyHKslwMa4jCfaH/N9Ubw40n795sIfLqC5vzy6eiJT9iUhSr7HCQgU2IY8Ui8HCu
 lS1dmkOKCHtKzeXPAu/nKR44yO6seMuizYdN22dR68Nut2bP5iNT0oBdJu8ktzcE7yMt
 3syhqudJmCI7JEhOb49VnjOe9AkxTUQF6iRXngAi35Z1fknqrlfcc19BuHpRO0/YYDdH qA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjx43w7ux-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Oct 2023 15:08:57 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39DF4YqB040239; Fri, 13 Oct 2023 15:08:56 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3tpteaqb86-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Oct 2023 15:08:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Or+TO9SoML9bUMzVi5UgIv6U5GtlhYkFfp1on3SOqY9+tLRaqgQIPz9rLjHItpaMtDiifwUjXM2O2ZmImaakt+czw+k1/xwF74Hj6rD06R/UUhw+HNOKrAimfo2r6Soxd3ZqcCoJrgnNGxBncQBM+eEZ8YPq0nfZ9V1c7Hps7p6LT8Wrelf55Gp6bpg/2FsxlqCPpOdhEwcNIzYw0/g14wYSF4mpYf50INoMBURzevGHUZR9GUzvKXamDhxQ9vpqHXVUWCQj+E0muP8ImPG1ZFiuk1Mm2wrxxzMRcxzcsr5Cfxq3PYOv3YWZMm2yd/k4vY4jOV3Py30BPx60mVitZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qWTkuUSVxy5AFgvjiMGiQyV1C10fInoq0uMEYos+80A=;
 b=UWidBMd3dGCbAmt8vGht7UrU8mD33JBdreeXJ5z4AM97v09bUBAoKGNiNEHjHsym7SE/lMTU66cTE0ACRsZJEluGvcDPZGxSmaIFeyA1M/hx4bymu4e6UPKvYubACGKTi4ckdcUIAdP0hhxc4qCoG3wB3weVcLd52F8zSGESaFH2n4zcR+eICTIqWi2RR72ngy5ZdJ7qbN5Wms5MWLK20Kg3uknXXrbMUGvYf+EG16YT1/++mw8XophHkqEoxklYLUOFa/Q5YFHf2giktayd5gvPtNhlJfUcpehLAOsTz2tBZ3XJ0GIzNe0oA1XQ22RN3GFI/UVUHBy7vqWxfSvPuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWTkuUSVxy5AFgvjiMGiQyV1C10fInoq0uMEYos+80A=;
 b=s09UWhWbPaLZxpPTMT/KlffBG6cbz5M7deQt1c1l0UhUOViLq66Q5P5xS0YMeiFnHSigT9dXjqoxBJmUOvVThLEDzfOsLhjoBU9SejzbP8OvKkkQWesYzSF+q9nDu5jzbpkcxmbf37qlJbwTtHUr+rk3QeSyIIQk1xptw4q+59s=
Received: from PH0PR10MB5481.namprd10.prod.outlook.com (2603:10b6:510:ea::5)
 by CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Fri, 13 Oct
 2023 15:08:54 +0000
Received: from PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::487d:5c37:8928:9885]) by PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::487d:5c37:8928:9885%4]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 15:08:53 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: qemu-devel@nongnu.org, peterx@redhat.com
Cc: lizhijian@fujitsu.com, pbonzini@redhat.com, quintela@redhat.com,
 leobras@redhat.com, joao.m.martins@oracle.com, lidongchen@tencent.com,
 william.roche@oracle.com
Subject: [PATCH v4 0/2] Qemu crashes on VM migration after an handled memory
 error
Date: Fri, 13 Oct 2023 15:08:37 +0000
Message-Id: <20231013150839.867164-1-william.roche@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230920235301.1622672-1-william.roche@oracle.com>
References: <20230920235301.1622672-1-william.roche@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR01CA0020.prod.exchangelabs.com (2603:10b6:208:71::33)
 To PH0PR10MB5481.namprd10.prod.outlook.com
 (2603:10b6:510:ea::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5481:EE_|CH2PR10MB4166:EE_
X-MS-Office365-Filtering-Correlation-Id: 817a5d6f-075c-4360-69ae-08dbcbfe5072
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: of6m5P60WTCywrfqUVD4gyPWvA9OdJS1atYxTwJExP9JXl/NyW6E+9yOwZ2nUzxpxOoRWuRTUOsmvEVS9YVlGSFGDGp7yNGNFbC5nJVNF49k58apNl995oVt1tdgHQhvHd5phPtDQFe43xuF+eTD2lwNioWHn7bXSlGs3f4neqc1UFLcvhs63dLFZEr6Vcd/pVeJvlMXFqN5rPf67RoOQWeMfyofhCa//KbhsyEBLTUbG+RKenCYS/FzAMrbU3vkXUphHN8cpOxz2O1ZtQDYH2aPQzkrFyfGAVhIy+s1jqpgDxlPxTyfogs5m/ezTQzZo16GTBwQrFzDLE9hvSrtdna83obOFJGRXziXEfP5fdZdxC8lMRUQKMMPbqGr3SEIt60r8PvObsQobGh2SS3GKA8nXI1W2baq6+YwASztgwFnWoO1h5ltNAMyKDqpCux19K5B2W4S2KX9naZgjCX2X69tjbeoV/IB3iNYwtOgxHaN0XVeJFlKeBhdMYj7A4GlITyXUOztZ/HMFBDOyMXwJ3zNItNcxChRMaUNsIh7XyY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5481.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(396003)(376002)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(86362001)(38100700002)(36756003)(66899024)(5660300002)(41300700001)(66946007)(66476007)(6666004)(966005)(2906002)(8676002)(478600001)(8936002)(6486002)(6512007)(4326008)(6506007)(83380400001)(1076003)(2616005)(107886003)(66556008)(316002)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zsd41AsEJiIlqXsiYALownPHyu0uw7QQUguyVFH7gOmhSYDwrgTFK8wa0K/3?=
 =?us-ascii?Q?ma8af286Wekj5GDMcnLu7jkT47JQzLudaYr28O3kHlODIp8JNZ9Y9RP8lSJL?=
 =?us-ascii?Q?DrVmGtFigOuHc8Yb70hMQeOLvEFBQra34s2bgWirmt5zs6O3a1yyWqYjxh+5?=
 =?us-ascii?Q?EhdwoRu0iou+wWtwlm7c/X6gSyrXg5EvuaplSR9iSuZIsj+UBhhN2zzqPJF3?=
 =?us-ascii?Q?NoCgcCrPd+Dj3Keim0fX1Tsv5DCNIQLFPVOzeqTwfmlyG9Jg4kK5D56W3uG2?=
 =?us-ascii?Q?F5cAxjkMFOV3Fx7e69BLSeGvC/PAEmua/hyomFxH/aMfcmLxVwtTvT5ffmEB?=
 =?us-ascii?Q?0RVldfaKq9RxABqTggVN0XptVa+lGZ6CPkmzR5FnN5PHMDkDHzt8U8x/+0Ds?=
 =?us-ascii?Q?bFENJO7yVv1lEkwD4urO0z6frj02de4LGOPLt+h5/sUzSKLZHRD2xBjpAx69?=
 =?us-ascii?Q?HYsDmR914DrYcG3kiab4aAMyr8kigaAC2vo4C6UyB5x1J0wer84NTbdk7CX4?=
 =?us-ascii?Q?1RQs/+hLulcYCT9f6JuIuoUgB/Sq/WgCWTb0FoyHnKObIhv2okYODdknaLv8?=
 =?us-ascii?Q?rxPQ9rUosfYf3B17h+vmnVOly6f5z+X9dwph7geMc4IeJl1eBhzc79t7M1Z5?=
 =?us-ascii?Q?uttC9HOLGeIOYoCaHJSEBEGPNkHQYw+TGTSk+QTGyfc2xYx+LNeX+3miLHQ0?=
 =?us-ascii?Q?rXCTX6eUMdDynXl9ymCX+7PiZKnG8fwkVWF5X4SqRiapvVCOCtZhfqwDaXoR?=
 =?us-ascii?Q?D3KErb2cHjROQwwcPoSXbVHetveZdi70OULFB9A/JW6IqTbpWVkNTamREYzh?=
 =?us-ascii?Q?zh/ejFmRsCe2FngafRkRD8DR/ogoaq23ZqZM1KFSXgPemvYBu2UmINTl6Ssy?=
 =?us-ascii?Q?7wHBh5fhm+MJyf9AteiwaMijZcJ1i/1lIQGcUCJ8ta8w5cCJwkAxNzl38S/b?=
 =?us-ascii?Q?K2JTd+EnlPMFecNKcCgXr/xq11Q1iOFrRXCx6+2TMBkaB6IMK4JjJDR2R0fj?=
 =?us-ascii?Q?//RTupPJnIvGgrGw4lTx8jr95LM9tflgOH37RVrgXpT6fnYyBv2Ppeq+sea0?=
 =?us-ascii?Q?FcKGr5/+NyDd1JCYHL0jYV0JPGKXgQ3Vvcc8126mTgaLNsI+L9rBceMYnciJ?=
 =?us-ascii?Q?bV7nYMZd4LRc5NCw7BgdNwZK0IMfjnUVeCox9Pw+eXle7aI1BMyGVkvJ3LOW?=
 =?us-ascii?Q?L6r5OF+Xh/UBBESv140JJoYufamN9AQ1hoPVDXx/pBgqbTC16I9YVznvWOQD?=
 =?us-ascii?Q?jnR+1X+3DdK0wuZVNhEKnMe92QY8kAfMTW6GcRibQJrUc5Pml9tlHCLez+q2?=
 =?us-ascii?Q?elAtySZUVjvz8xzHJ6Vzn4i3HC9zstwT0/a3FskwRYyU+6Mcju98K2xkHlG+?=
 =?us-ascii?Q?TQSwSE690izcfhBPfVjeqSigMjd1lEySp5k8/8tUimzWGxxTLSrVfVAuu2L/?=
 =?us-ascii?Q?vYuOWTvMXlv4XTgiL8VA/hc1w7iUrZvnauQEUo1QUMPxz11nHRkRB0fYsGcc?=
 =?us-ascii?Q?krNeVRhaM2yLrgHoC4tVbBVkyp9SokcwPahTTKRaeYOzl2r2tAT9EGwbeASF?=
 =?us-ascii?Q?hMCucfvVOq+iuA5oZX09yq5+HtjUHa/Ub+CULE+wP4dP+TyfCDZ3eQK6gMgD?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: h7dvr+7Nzbp6lwDLo3fwooUeZXaMgLET8qGBn+ZpT3R2Bs7A9aXMYIi9IJBCLaYUVMEELdvwWkoIM9LmjckzbAHboAeTs9vckHxslMfkDKUEfxDvrzpWJKqDai8DutwTjL67SN8ZFtRc23nhX5mJrK6wvDZDfs5/txa4ZDphuEiWY2Yt7xzIjrQjIIscv1UtK08WfygPE/SNfxxxJuR2avekNHBP9vTBhw3oN7ZXnW9ijz2fy/ntMJXss3LJoUvCJF8DwMf4R8Xuy5T93mlpu+MUVKyjYEKpjTdskyMOqDNdqo96/iFd6Azz+VZ9g4+JJbDCphBa64cS6Dt1m6wzA7bHQQYINnpmOwm9fA9C8cHSUtdGUYff32k1GGKLq13Cj57+DX/0qzmi9S86OLwGvSe/TQTU3jt0QP+gSF0KFVNj17bY+AmoTPK9pQhol3fqqdAeK+qguZxj9ddAsqO8Lts4obpQweJc98ocUJ0s11eP9c93sE/QzjkTyWUjD2gNf6DNpHo9iHr1pB8YQK1PlZ6fK5oUSvzviXgkjUkTFf2PvT0A72vsA2wE0g98DA8nb7r4PfG11cBMbml6/tuV+OwEyMpP3lX0quuoqdQ6170jA3kPrjXVya4tN8FlAPE9lcWbPN+TahPssuqQNrg38QtLlHXh55QTCKPkf8zN9rZSo5+hJQBbLiKKvydvdIBBw2aU/2GgIAuUoQOqRbj5bl6AhM7RDB03VmZJwMtYfSFqdODQKLJz3cNz6lqY8GOHHUozMTQH0m7/HbZMrKWlxAgh8rg6r1/UikQ/rt6GH8yswvV9LX5/Ql4iuTVjEknZfN4r5pO39V7jpg4nVoREuA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 817a5d6f-075c-4360-69ae-08dbcbfe5072
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5481.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 15:08:53.7381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EO7xLUcXh08/W9Rc/wjlrcWRHHWP0phaR+6Mu269I8OV5lPBxDY8bn4cJCuqSoS97ytTvBkeNkXOSQW6JuPTYIAHcvJr054gwPzao3F3cEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4166
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_06,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130128
X-Proofpoint-ORIG-GUID: ZzSmvjY-uQL52p0Msai_VMTTmQpTTnFb
X-Proofpoint-GUID: ZzSmvjY-uQL52p0Msai_VMTTmQpTTnFb
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=william.roche@oracle.com; helo=mx0b-00069f02.pphosted.com
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

In order to thoroughly correct this problem, the poison information should
follow the migration which represents several difficulties:
- poisoning a page on the destination machine to replicate the source
  poison requires CAP_SYS_ADMIN priviledges, and qemu process may not
  always run as a root process
- the destination kernel needs to be configured with CONFIG_MEMORY_FAILURE
- the poison information would require a memory transfer protocol
  enhancement to provide this information
(The current patches don't provide any of that)

But if we rely on the fact that the a running VM kernel is correctly
dealing with memory poison it is informed about: marking the poison page
as inaccessible, we could count on the VM kernel to make sure that
poisoned pages are not used, even after a migration.
In this case, I suggest to treat the poisoned pages as if they were
zero-pages for the migration copy.
This fix also works with underlying large pages, taking into account the
RAMBlock segment "page-size".

Now, it leaves a case that we have to deal with: if a memory error is
reported to qemu but not injected into the running kernel...
As the migration will go from a poisoned page to an all-zero page, if
the VM kernel doesn't prevent the access to this page, a memory read
that would generate a BUS_MCEERR_AR error on the source platform, could
be reading zeros on the destination. This is a memory corruption. 

So we have to ensure that all poisoned pages we set to zero are known by
the running kernel. But we have a problem with platforms where BUS_MCEERR_AO
errors are ignored, which means that qemu knows about the poison but the VM
doesn't. For the moment it's only the case for ARM, but could later be
also needed for AMD VMs.
See https://lore.kernel.org/all/20230912211824.90952-3-john.allen@amd.com/

In order to avoid this possible silent data corruption situation, we should
prevent the migration when we know that a poisoned page is ignored from the VM.

Which is, according to me, the smallest fix we need  to avoid qemu crashes
on migration after an handled memory error, without introducing a possible
corruption situation.

This fix is scripts/checkpatch.pl clean.
Unit test: Migration blocking succesfully tested on ARM -- injected AO error
blocks it. On x86 the same type of error being relayed doesn't block.

v2:
  - adding compressed transfer handling of poisoned pages

v3:
  - Included the Reviewed-by and Tested-by information on first patch
  - added a TODO comment above control_save_page()
    mentioning Zhijian's feedback about RDMA migration failure.

v4:
  - adding a patch to deal with unknown poison tracking
    (not using migrate_add_blocker as this is not devices related and
    we want to avoid the interaction with --only-migratable mechanism)


William Roche (2):
  migration: skip poisoned memory pages on "ram saving" phase
  migration: prevent migration when a poisoned page is unknown from the
    VM

 accel/kvm/kvm-all.c      | 41 +++++++++++++++++++++++++++++++++++++++-
 accel/stubs/kvm-stub.c   | 10 ++++++++++
 include/sysemu/kvm.h     | 16 ++++++++++++++++
 include/sysemu/kvm_int.h |  3 ++-
 migration/migration.c    |  6 ++++++
 migration/ram-compress.c |  3 ++-
 migration/ram.c          | 24 +++++++++++++++++++++--
 migration/ram.h          |  2 ++
 target/arm/kvm64.c       |  6 +++++-
 target/i386/kvm/kvm.c    |  2 +-
 10 files changed, 106 insertions(+), 7 deletions(-)

-- 
2.39.3


