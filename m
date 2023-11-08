Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6B77E512F
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 08:37:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0d71-0005Ax-4r; Wed, 08 Nov 2023 02:36:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1r0d6v-0005Ad-KC
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 02:36:25 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephen.s.brennan@oracle.com>)
 id 1r0d6r-0000Ry-OG
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 02:36:24 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A7LJo1Z000910; Wed, 8 Nov 2023 07:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=RbCwkkb7lswSlze2d7AbaJj+iiilMuLTMdteJwdfHe4=;
 b=AzhyhAjsMjcgEFKl9l8enAecTfgK6rTbohXIzkw/+jmJlwiCNd/VL9y7s5znchKV+m5e
 BmA19dn+kxT0zSPtZuUIN1wMWUWtS4/dRoulg7EwqmZVM/TZpD1mn2BORx3QdSb6KtSh
 T5qqEIvmLSmJ3r642rLVHtPzzIROB1GcWk+yZNhvXfaMKvmKGqy1r36ESLdGcIKeFiv4
 zJlYDg+ftvt1qssGm2kBXXjYx6KEMP2ZARUV+yg/HhtE3c1a3c1yUoc/fLLFSu8OxIdS
 cjjlNsgANo0phxq6M7ea8+ju9Coobdx+Q2UIcvu3U/yA6bfrTN2s6RiSeuBE7fqcPNOp vw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23gtvh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 08 Nov 2023 07:36:14 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3A86A2es011074; Wed, 8 Nov 2023 07:36:14 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3u7w1uauyy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 08 Nov 2023 07:36:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZk1sUYpmKJmbxWCTNNA2CACabrPvklf4pWfEOE+1ICIVWBeT4vb7iolwAsT0ubqRei9tNIZvS8YYW7KjQLj3eIY0JksT60iYEzLBy1PKme7Xs5HMB5jluSL20MSQdAAsFRaQ3Bod5v9127yQiXFrfTIQ7mHcEGSQNUD1we0kOuTWsVn8oHbOjazrw6WImRuTevlvwckfWFq/KSpIgPV0iWpBuL2i4g1m8rzYA/7pPY05qapjZx7FsxjNJnYPVH2rPYtnlyuR+3PCW/DkcV3FD9Ihh92Z/FMEH299Y6EeluZImyhpXpZQTXTZskpL0TUky67AZBA6gEaRX45uuC+8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbCwkkb7lswSlze2d7AbaJj+iiilMuLTMdteJwdfHe4=;
 b=iH2ABSJXFvVcD1PRIIG9+so69RlZkc5K9dnc0bdjxJiQIZjsXadpagOJjj6lCFGMby9TpMoqP1bB6MToCY/SC63PyH3JXlJAzMfMX+cLAXweLzw1LOB68NKJHnJJf6x67AEAP2QlP7aljLg0wl2ED+2jAZTlXtvB6C/Cw1xJIc+HUoRSoY1jTANzojqNLq51DBRhMneNbtpx42Alw0fmEpQ6hbUEBdI7bh0e7IMTm64BH55/7n9IG7Y/AHJZukJwFJ7f4KTH/32urqPh3g6NvdyRUflgOg2fhhGoXaanizmsmCLNVq96CJY1l052DKJE/XiQBtsD1jaK19HGfJTHiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbCwkkb7lswSlze2d7AbaJj+iiilMuLTMdteJwdfHe4=;
 b=E04Y9f4r7UYUY0X8AALSFDsn2xN0S9Dju3poO4TuajA1A9Gi4JiruduijO8sPA/uco7l9TB3WvVClh9onuUHIpjqvgMjQ8apJ22iY3/n94hJoHfRwzVqN1ztA/XmTFZ9du0NZtV0osXKvtq6rBFKAADVXWJQVOOt4I314DUM10g=
Received: from SA1PR10MB6590.namprd10.prod.outlook.com (2603:10b6:806:2bc::13)
 by CO1PR10MB4690.namprd10.prod.outlook.com (2603:10b6:303:9f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 07:36:12 +0000
Received: from SA1PR10MB6590.namprd10.prod.outlook.com
 ([fe80::cebb:4172:b91f:abe9]) by SA1PR10MB6590.namprd10.prod.outlook.com
 ([fe80::cebb:4172:b91f:abe9%5]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 07:36:12 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, berrange@redhat.com
Subject: Re: [PATCH 0/2] dump: Fix issues flagged by Coverity
In-Reply-To: <20231108053731.112043-1-armbru@redhat.com>
References: <20231108053731.112043-1-armbru@redhat.com>
Date: Tue, 07 Nov 2023 23:36:10 -0800
Message-ID: <87zfzo3ded.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::18) To SA1PR10MB6590.namprd10.prod.outlook.com
 (2603:10b6:806:2bc::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB6590:EE_|CO1PR10MB4690:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dc949c7-6de4-4f3d-86d6-08dbe02d616a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 83sPgw3oOAS9k1rpJfj5PTWKjGUjqISF9j5iHLF3LxcrWKrzm6m2jPtjOAf2yBjhhwqTmtNugprP32X+UfThDn7XNdiiJUivQZuP4GUL2ks8dUK3QNDyWXZwWncHNe2Suz+5ihCfGD8vnvsMXDirsmXM3xCKprrg6JabLQSEkK1FsfqZBbJ2dvYlCNgbSHzD+8NTgWGUcVHH2iZgDyElJlwsc0HBgaBTWDNDuoJwQdHXJE7glKbdwnQ2BqmBUW+jzyCVN9anMCfUlx4E1sHNcsl2afnzylbFgmCutWm/F1j9yBFKeYvN+BuvEq48Y5rbzOgfZaSLEpZXzHCZUPkSsCy45AV0sf93A1Vfn1GSlYF6CdWOFEaSoKM1h6MP0hazCmMy63lLcl+8KllBzVB/FO9rLymtT3trQ9RpV14ICpTTld7QsVSH40eUVP0+m8AReUBuxma5Ke0cO06BGW/Gk41GzRMWfhs476E+EjR07Rwly1QvWDAZBZjTyLl7P5S9ldvOZNkjiq952IaYMMPHN5aCYnKH7wO7OsuTnLvja1G8ReqLADbDxfcSMZ9pohWK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR10MB6590.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6486002)(478600001)(86362001)(38100700002)(66946007)(6506007)(6512007)(66476007)(66556008)(316002)(2616005)(5660300002)(2906002)(4744005)(36756003)(41300700001)(8936002)(8676002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?59spNhQYxQhk9vid3ywnyaZcstV7cs8GVN18Z2fEYqbmVMfAaOLxbaDUTL4x?=
 =?us-ascii?Q?EIcAARczMsiWx8wem/9GaCpkMU14zDB6gUD7OaC9zJQPCC8x5ylS7PevLjku?=
 =?us-ascii?Q?Ywq3OKbhZAvuEzJtrwl+vDOEXHvhFhVyE3UvKgEa/1v3M2qrEXePTdlM8069?=
 =?us-ascii?Q?Q89zWykuY3I/Bpi2d3ITign5WyZveXHsfiCbkmyZ7HX+1XfmKKhKGFVxS9xU?=
 =?us-ascii?Q?JGyerhBt3c/7Kl1T1gPnG0O9PEiyp3tXAlSGpQnsNjhn23cCqOznqXZ4lw0r?=
 =?us-ascii?Q?W8bFVU3sMP7qlu5je5ZbQPcZyVhLSTqnQCcbIlIIpQJRaT9QZ16etICbtTLz?=
 =?us-ascii?Q?uDEfocgG6o3fRu6/lDJQqVMFvkfvrzGXdYvPHGMzpWniPnjlF/HaKQz9O7bM?=
 =?us-ascii?Q?psWX3CqK9MkWS9hTR+bLffSuylR4fY3wPFND/4Pqi4RpaPg3Mhp+2fr1IhDj?=
 =?us-ascii?Q?n4sgNy/yF/0+27c14nqYbcJVL/NmFJw6wu1cOPWAqGlQKGFFQengT7j8zG6k?=
 =?us-ascii?Q?rZBWF0pfjXyxRhHcU0TXgYTxsh6smD41yp+fxcIv0XuC8uvXbCSD4ZmraBT5?=
 =?us-ascii?Q?KaQaQ0GTD173H6Rhj18ImzLM+3k3ynXfwiefJD+tOmxSu8X/P6ft8eCC+QEP?=
 =?us-ascii?Q?BDqJsnW1VRWKkWKaA5fxeBoWKX3TjYaeWN8t3RKg2yKyQNxCvBR4D8rFMR3X?=
 =?us-ascii?Q?rjROyMd5k8XguiqqmQy4n1+ped+WlHee9G8asJdGjFMwBcZeOwrh4ydVAu+4?=
 =?us-ascii?Q?Qw9c5fr3uVQT59VpCH5PE2A0HU5py+E2URndZ2hnx1voYEdWdRqlX4OMlV8L?=
 =?us-ascii?Q?belwaSL9TUdOuIowDaWGcy6dBDG47mi/GdIVOeby/p8rqPULGhk/MJHwfEw7?=
 =?us-ascii?Q?UaNPwNIaVaYYYSGCzyLM4PWnZQWB/8PX9t4A12aNvu675rpOF0hlkdoOvLLB?=
 =?us-ascii?Q?ii58+Z3OvEIBddNMij/5pp3QLvbfbSjSp/cf0bEl9jjBllRwNmzhT5Rij3c+?=
 =?us-ascii?Q?tfnSYZpH+UekuYMeBBogIdvMGoCepoZy3zIMmvaX+Tc/hfTn5jAIzENeCIYc?=
 =?us-ascii?Q?joqWe6XOKCj5D5VEBD64cSEhZ/9auAYGYYYfYtgNB8Irlt/dXxMnARtAH1PR?=
 =?us-ascii?Q?8ZQN4SmdMsm44LRL7CDxoaFPn+b25gvNPdH6hAg1Lo9LJdGJPlSoYtBC1Ep2?=
 =?us-ascii?Q?wyRR2ibTSX6sLETZt5SmQzg41VX8YcOcUD//+0oE23Fi/YpCv2t7F2wHyXoH?=
 =?us-ascii?Q?NYrACk9zXfT7noH7Cs1b2zcOvRUeAOOp9HPaE1ITnobJEt/bJ3AWpb8jwaqc?=
 =?us-ascii?Q?g8y/2J2Ac/Pc6O0Uz2O48SzHF6ANpfAYtbZtg09bu+I9vmbQsSHb59vAeOh0?=
 =?us-ascii?Q?1LU2Pz/A+5xza9L2rbzHUfeUU7e8Uz2Sd/p7YToLX9okZmQN9h8CYihOhq/U?=
 =?us-ascii?Q?dk1sY8lktn4ORDdefU5JFIesTDfQccS94ySlMAVBGQzzNDXs1iUyheMhDv3q?=
 =?us-ascii?Q?PHOjhhyLAHUpJfsW/rli2ug2te+Sk4ZbRVQlBr+UVNpmBCR2T5OQ8Z+Yz4Yi?=
 =?us-ascii?Q?lwVgh5UytVdVkddzquOooxawlxfVM2bsZdvzD8pq2lbgCidPRsrP/Rut+2oE?=
 =?us-ascii?Q?hYYc/TAcU4L2zjx/SWxS5ak=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DzdMcylAa0qIm/ZdetsnkoK7wUVC+l82gmo9wL8Amais8a4FX8+VcwIEIae46kww59lhLkrMDs9Lk7o3vpsCJU+ZBm2Sc6/oO5AzN3jw1o8nNF01QW1zZL4MqD7C2aycwqi1NoRY4hofJ043rrgpCs4/JBE0LWrErFlKI2nwTEseOb8Vhkctpg16nhIm/y955N42JToUGwOZqgACikUIzTaDXTqYs+tOgM40IM7yZcXVIHeKqtWDWdQyYeHdyFRgSiUabHGY1BU5j8CwsogXRbrzZrHS7XPmAxDSVnVy4MhgyckM4zZR+BiZa2A8MFtQ7Yiae3GaQxW9zjpaz3vxQmwICMkvLN2pUHJ2DQsVltrDF5pjSCBl2rlh6Oo7KG3HHSFOYAQR/ha2TW27XqZx66dGc9+dNFkD+4ACANUrHLQJf9uC3NDa26FMxpWasaWIK970i5IPUuyo3Hdu3QrDfWaxArGMpQnUGM8RZVx5vxTsmLodCK4Wvn7Hdk2E4LUnG4lqIuAPYdo+6CV2bpEj9Dqcn3LOx7EN6EQRPdAQmMCXTyjNFBVkA1N1SsWvGzWE23KNUmoGd4euFoR2V0hZ3kvb1k91ieElTmbYUWD0RnBqFnQBHLqHi5EHMy5ODze5kYXqNH7vJZMPPhUOT7/N4wk2C5Tuquil+ZV55w4qb8qxoIXkgdWKQyb8OnTWuqXFGLfR32oXsJF8sGNxEaxV0Z2AGVfEgk/YvLxHTCJxuzetJkpRmGPl1fi3GxvxPEl2vl+Ocni+2TNPfEd0sF4oQQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc949c7-6de4-4f3d-86d6-08dbe02d616a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6590.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 07:36:11.7823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ue0wpwOyIAdUmBwtMggSjiYGJw9UAXn7cB4ub76ShojmRX+KJBcfzInhEvaf/SvuWLu8Mzr3Mr1RX/jaa2t4uJzDyOLOSqAim1P/amrdn+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4690
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311080061
X-Proofpoint-ORIG-GUID: zkxdq7OQZFifh3HUeNSQwsVKn2v53XGV
X-Proofpoint-GUID: zkxdq7OQZFifh3HUeNSQwsVKn2v53XGV
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=stephen.s.brennan@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Markus Armbruster <armbru@redhat.com> writes:
> Markus Armbruster (2):
>   dump: Plug file descriptor leak on non-seekable file
>   dump: Fix HMP dump-guest-memory -z without -R

Hi Markus,

I'm a bit late on the uptake here as these are already queued, but thank
you so much for finding and fixing my issues. Sorry for the extra work.

Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>

