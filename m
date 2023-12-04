Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EB3804278
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 00:18:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAIB9-0002Ls-H4; Mon, 04 Dec 2023 18:16:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.christie@oracle.com>)
 id 1rAIB1-0002LW-Oz
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 18:16:35 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.christie@oracle.com>)
 id 1rAIAz-0007Eb-DA
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 18:16:35 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B4MoD2N004790; Mon, 4 Dec 2023 23:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=De/CiSuYl1RMsvOdH4u5lpdwzUmtWE9lejwG3iDf0R4=;
 b=dAO8ltSJh0fkXB1COIiVbGTNP3+TohCb3lOuGr4GhZ0nhldiPjFK0V16Mhm2nwxfWDFy
 v/hD15T3B4eBejdPs4fmRLfa44LEMW60BhHfgzBM/XVpEIbj2yyUYYvK7r23wC/3oR/i
 HEffYynKEJ8Db+6K2yTlhLiA5qCxaYWbZdFNknCEJaESu0BGxCisK98TEy9hNFScMbyr
 yMJpaSsh2evlV/dO9ZVabxxHIsMkYttybGrsVI001OLTG45H2ACh+EtinnH4ksdYZKNk
 vNX4MlITr7gzERgA8zcX8Xb9cJb37LpybTesunYCiSBWcChckQMsVR1MGG99LIz7wrVy Qg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usqnf02bp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Dec 2023 23:16:30 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B4MIqXE018427; Mon, 4 Dec 2023 23:16:27 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3uqu16hnch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Dec 2023 23:16:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aiK3RXMDEVgzQfCE1sSEk8owGsbN/KQkGgGmzR+f0yfg2Z+ojGRLsFjFVNDjMDsi9TzpjCarP2U3rChR7zpgWbxcho9gJgHtuxhb6F90XehMVVJYmYQpoXgw6QRhjIqZd9Y/+VR48AL1+ygAGa9GsXKz//QJXdINB1RrBHhEEN7ZXPYcb1Rcho+aKNuYfNkaWtdYwhIn4IVUOZY7FTStciLikQRZL8WHH8OD4F59HOVML4H5eSWzpsPnXyzRA9JB/ra9vDOob0RVEqQxdU9gD86BqhgMJH/6H+QVbASVxF039yH+deCLfXgeLWQke1Q1iJt539vwzgkQgS/19NJ5lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=De/CiSuYl1RMsvOdH4u5lpdwzUmtWE9lejwG3iDf0R4=;
 b=Qd7p56zNzdMrDEAia8ax4yrlZQde/LWhBACPxcU56/q0iQObdEV8hFqrXEccLp5a+FUO4wX2RIejsaKswJk35iEOEU7T5R0I2mcXGw0hRJ4Mu+DKE23GZOD/cYfhDWUUe8FHwmH6COEUYXx9ok0r/5pwmsm11kgLJRjCgUmqk4bO6Qa5uygERodxCPy+HJxsdhG5QsG4pzJhgLOor5LGCoPtr5pAlEpHbS0vETnq5M2Gi4wDDgLz9MzutFr+GIiKifYH2KnSVbk4resYkX/MNEFzgxisvlpTwkAOU+/Ik8EsMJ5QdueY5PGLVZY8fvxrVMWAqVtvNmWtD27lf7W3qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=De/CiSuYl1RMsvOdH4u5lpdwzUmtWE9lejwG3iDf0R4=;
 b=VY7rH6dMyGLsKjE0/9JUveQuL1/BKJ3QiCvaKgO+PaXe+Eg3DuyyOQNJ7jYqmhmjpZq8ue4bdOcwbNGCU+knvb6WRZD7GtLuixQCzpcKmWdXLWBp/Y6nRZSK40UZYE64qhlG1GSkQnDUuUX4rfQW+aQUAxWOYtQK6QqQ5uhqSBU=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by MN6PR10MB7466.namprd10.prod.outlook.com (2603:10b6:208:477::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Mon, 4 Dec
 2023 23:16:25 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::449f:4fd9:2d3e]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::449f:4fd9:2d3e%4]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 23:16:25 +0000
From: Mike Christie <michael.christie@oracle.com>
To: fam@euphon.net, stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com, 
 sgarzare@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: Mike Christie <michael.christie@oracle.com>
Subject: [PATCH v3 2/2] vhost-scsi: Add support for a worker thread per
 virtqueue
Date: Mon,  4 Dec 2023 17:16:18 -0600
Message-Id: <20231204231618.21962-3-michael.christie@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204231618.21962-1-michael.christie@oracle.com>
References: <20231204231618.21962-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR07CA0090.namprd07.prod.outlook.com
 (2603:10b6:4:ae::19) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|MN6PR10MB7466:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ce50e8d-9eea-4879-ef7f-08dbf51f094f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +iwBqTIJQ6pA9LgcubkF4a7AW5yGBpsKTb56HRQAOw8/wvox19VVTJJxLX5O6v2kibhyTNEXOqAGOdnWQz91HRNUwMSkfYhinx17GUTP6Wo39zByt65glBmvfCaHRyapuw8U3V6mez4A3J897kljgjJNztIfW4/53FT9hagK1ySHg9S0PXbe1MtaY9oNfCjz4/U4HSp9yE0vj5aDyi/cGUlK82EvlHNOL5MqSl1WuxJtBtwskaWtSs6+mnB3EyPsTDEIWcETkQLf0HumjtdfOQQ+PdIXs1agV3ppAhwmhZuw/xnJbg88gG9Wx1EC89vALvKjHX4AntytZXPgRAQjT+ePnEhW4IXrz9MlNDVG+TqHrSO2Vs3AKO082FBXQunRwfA2K/GT8CEnYeuAvVvUOL65fVo3EjtbsToNGzZO6w7X5deiG2HhyeIhKIHz7ANmM2YhPoplcS37IH1esM+IazomVsm2AdoEfie+jdYpHjdZGfEQGez3dwi/GHopCdyYfS2OzpTeuhnyPbXpu+EvzoIsBufgcgsqtqj8n3AZOECrTfok2vcOo61rFyCYtbe2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB7243.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(66556008)(66476007)(66946007)(4326008)(8676002)(8936002)(316002)(6486002)(478600001)(6666004)(5660300002)(36756003)(41300700001)(2906002)(86362001)(2616005)(107886003)(26005)(1076003)(38100700002)(6506007)(6512007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fpyCURnSnNaL8vSSVktnPAR79vS91taKMrebJHRuvpWc1NspAjDnS8NDXDZk?=
 =?us-ascii?Q?78oewxesP0S0x3qfDQcVYyj205kVNQR3B8b7ieoEZi6CgguiEdEZdz4+ImRM?=
 =?us-ascii?Q?rEy4qWaI8+m3+zZXA/f5207vncwThTFoDJSTK6TA12IT2w7KgtWumy7ZkcdI?=
 =?us-ascii?Q?o7bHdsLw9EgAGuCopc5wMPvWIBnBHk8TnAJINcq+KDRauSnXyNHdkcWd+e5C?=
 =?us-ascii?Q?GOOdMJwsMmmDmRDt+EDWTkpyNz0tqt1NfwivmWYVutD42yfz38bmMFNuwi6/?=
 =?us-ascii?Q?REVlXNFQCC/NHgxcnqvumgRdzwxKuiQS1nqzJBQGWTW9Kbbp6t5V6Mb4Wyut?=
 =?us-ascii?Q?7XvEE4FcpqJL5ZlW47aTaQNmn6YEOtrU12QqnmeuueY+7z/vvhIv07WaAmqX?=
 =?us-ascii?Q?tPSkH717THdV9vD3pPNewdeoVrEUqzX3VurBw9kX3UwObQSBlS34AJW16neh?=
 =?us-ascii?Q?MGOfefvUOVMyREFxTrU8f4ukhyr6zX46cc4VCCBQl3zkzgIEGCJGNQ8k5f6a?=
 =?us-ascii?Q?U6MrOUnLitOSlEMKOklzlMtcvwEkTVCokmFQ3/2reAz7QGwJ2hYsNdusPmwe?=
 =?us-ascii?Q?/1ibwh02JiyEwPwCO9QuFFERmWYUsy6ACrAxSDIto0SwLVcd2Wq87TO4ayi6?=
 =?us-ascii?Q?G8fz+WRGlRO9O3ENDoeeHxrX4Gp8ORAI5Z54sXpnwvojzc9wYj8lbtqX4mYF?=
 =?us-ascii?Q?qjOz1N2bLaGFvYP9sQLWsKmj/sl6d7TwhgXenNR1kqtlzqkV+7gNoJfaKIv7?=
 =?us-ascii?Q?3tKsZUWWetArGgWBFQc1loMaJQ01zSyvlK5Spvg8pYR72nczKhKYJ/IZaRZm?=
 =?us-ascii?Q?hHaCWaNhC2yJwWntzKCiMRY3MuksSlmzzpOgP6Knb+gm/4J/OoofZSWFyo0j?=
 =?us-ascii?Q?VuwF+f4kPSiRvnEjpXdRY5JkbLTy4/rr94SbKKZQHPN/BaiWiSmoBu7Zmc5B?=
 =?us-ascii?Q?N50QDr4Qe+iKG+qQT+w56BHQ5+QjGIjo1FaY8yucs8vV4pFtzLlc5UgnJr9B?=
 =?us-ascii?Q?DggHxqHm514jznba9lWINTjXUffNp/7656TIwTbR/Tscu37G0QUV0EnpuZG5?=
 =?us-ascii?Q?moGN6tGEV/2rpGzpC5YWiwa+XoJSmtBbN7bLGEenHDwm2cwmXOftoT0VeyOJ?=
 =?us-ascii?Q?eohstx6oa3ioELwdC2T5cB5KRHuuxB5szAWaQoYWRcJK5X4zV+2luRX+5gPe?=
 =?us-ascii?Q?82MJOMqeZZQgP8JwV3YgIXnfctZZbrqxEaNgOSn9vzhvx6YXv3j3GGMiOI9F?=
 =?us-ascii?Q?MqxBmXalcJI+uvI1F9BRBke/1shOWQJdiH2cS55YJGKrDoESpk2oAxuXCiaU?=
 =?us-ascii?Q?NnT/CbBYh8xwrfib+V0UWpaHUQLfQk2DG+x1s/AqSJyJojuickvf5F69yhS/?=
 =?us-ascii?Q?UuuYa0q9bJfzlgdZ1iUEaSb/PrjdeCyU/evyhFrnRcR87ls9iWeD8bbqm3P4?=
 =?us-ascii?Q?3R5ETh+UG8XnEBa5HTNLA87atqIAG7gkrTQEAhg7US7yKCQjufw55wDou2Q8?=
 =?us-ascii?Q?PubuPwim2sZfeSq94i6SjiHHf0x5mw5/F3m/xF+L4Vvcn6A5Lsm+qw1Nu9vt?=
 =?us-ascii?Q?wiNz6jjXWYvJdFxOKuPc3v6tlih6YOOt+TE0hGgQd3TM3Bnadj7NRvtdK8zN?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YrHX7nM7rhuFinDQCh3oMMafbwfRJ3T2FQn/aPq3iaY1n95UPMgYhnFdRUPPiKLQDrTDFFt5RUlo5RgXE+DBrDEyZDmSBalMyUmSQrNrKcvBR/pP9H+bSj8cdRVlVvjFjmbebgwqhR+SmhfBgcoPvMPaIB/kmQZoBkc+4FUaR8C918EEsDPnp9qxvtDHKLxbgb9NEYdpaPp/m5+ZjfOCN14ZDk8RZn7zdF8mXPtPZqWsNSjMJwezWHrC2zhzWwnIyM7UZW7V0pRoMU01lwsdTAl+ujgH1hMkwIOZgOLgW163FpOobS0SIyNXvUzQIJqRqfjlM8CwMYCB6T7QZQACny/AorTR9PtwtVnIlcBSq0XzC+3qmSwlqwzJmwjgxHoeuDlnZd1mas/8y5ED+Eztp8GDiBFuM+iEAAm6sbQUT5ntuKdrn6O+Sa739gTcoY0IJ24CzgYUdzejhq8tzEHrritx7sy2YOu9VLi+ivTssYvC8V1AnI3Lu5vuplS01mYDQZkWzd+ExFzffFed/FM6AqyP0HnEImDxjDcaJOFqmRPpo5HwSCFS157ZsGrrzHhDPiaS+kDNUU0/jQjGq2v2SsmewUh7KHqyPhJWKJJDJPRVmDBNYFUwY1zzgoi6H94xjFCrLeCR920W4MdIm5QxRxmXS+jNjkdBctGYbH7BsseqLZMAJaHe4KFeo4nVD0EUkzHGkp94EZ1xo0GAtaBX5MINdiNUG+GuaVtpBPa1jBAxUQ8nblJpoZ8xww1xkSg3OuQ52cK7FHC0US2ixPGWwzwdEWGWNQJThm7qdGVghW88QHhJ+eg2Jqj+4gP9S63N
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce50e8d-9eea-4879-ef7f-08dbf51f094f
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 23:16:25.3041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4dPtJgf44eMJMCTX3KrOVbrDJqNfpucC/jZmsuBEHmbkX0+EauuNXco/+Q7uTp6930AFbnvGSerqnA+Y6GxWmc4aOAmly8w4N1VL4DqMFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7466
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_21,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040182
X-Proofpoint-ORIG-GUID: 8nndg8F4231XkG2M-sNOJpDWvL-d_WAZ
X-Proofpoint-GUID: 8nndg8F4231XkG2M-sNOJpDWvL-d_WAZ
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

This adds support for vhost-scsi to be able to create a worker thread
per virtqueue. Right now for vhost-net we get a worker thread per
tx/rx virtqueue pair which scales nicely as we add more virtqueues and
CPUs, but for scsi we get the single worker thread that's shared by all
virtqueues. When trying to send IO to more than 2 virtqueues the single
thread becomes a bottlneck.

This patch adds a new setting, worker_per_virtqueue, which can be set
to:

false: Existing behavior where we get the single worker thread.
true: Create a worker per IO virtqueue.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

---
 hw/scsi/vhost-scsi.c            | 62 +++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio-scsi.h |  1 +
 2 files changed, 63 insertions(+)

diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 3126df9e1d9d..08aa7534df51 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -165,6 +165,59 @@ static const VMStateDescription vmstate_virtio_vhost_scsi = {
     .pre_save = vhost_scsi_pre_save,
 };
 
+static int vhost_scsi_set_workers(VHostSCSICommon *vsc, bool per_virtqueue)
+{
+    struct vhost_dev *dev = &vsc->dev;
+    struct vhost_vring_worker vq_worker;
+    struct vhost_worker_state worker;
+    int i, ret;
+
+    /* Use default worker */
+    if (!per_virtqueue || dev->nvqs == VHOST_SCSI_VQ_NUM_FIXED + 1) {
+        return 0;
+    }
+
+    /*
+     * ctl/evt share the first worker since it will be rare for them
+     * to send cmds while IO is running.
+     */
+    for (i = VHOST_SCSI_VQ_NUM_FIXED + 1; i < dev->nvqs; i++) {
+        memset(&worker, 0, sizeof(worker));
+
+        ret = dev->vhost_ops->vhost_new_worker(dev, &worker);
+        if (ret == -ENOTTY) {
+            /*
+             * worker ioctls are not implemented so just ignore and
+             * and continue device setup.
+             */
+            warn_report("vhost-scsi: Backend supports a single worker. "
+                        "Ignoring worker_per_virtqueue=true setting.");
+            ret = 0;
+            break;
+        } else if (ret) {
+            break;
+        }
+
+        memset(&vq_worker, 0, sizeof(vq_worker));
+        vq_worker.worker_id = worker.worker_id;
+        vq_worker.index = i;
+
+        ret = dev->vhost_ops->vhost_attach_vring_worker(dev, &vq_worker);
+        if (ret == -ENOTTY) {
+            /*
+             * It's a bug for the kernel to have supported the worker creation
+             * ioctl but not attach.
+             */
+            dev->vhost_ops->vhost_free_worker(dev, &worker);
+            break;
+        } else if (ret) {
+            break;
+        }
+    }
+
+    return ret;
+}
+
 static void vhost_scsi_realize(DeviceState *dev, Error **errp)
 {
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
@@ -232,6 +285,13 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
         goto free_vqs;
     }
 
+    ret = vhost_scsi_set_workers(vsc, vs->conf.worker_per_virtqueue);
+    if (ret < 0) {
+        error_setg(errp, "vhost-scsi: vhost worker setup failed: %s",
+                   strerror(-ret));
+        goto free_vqs;
+    }
+
     /* At present, channel and lun both are 0 for bootable vhost-scsi disk */
     vsc->channel = 0;
     vsc->lun = 0;
@@ -297,6 +357,8 @@ static Property vhost_scsi_properties[] = {
                                                  VIRTIO_SCSI_F_T10_PI,
                                                  false),
     DEFINE_PROP_BOOL("migratable", VHostSCSICommon, migratable, false),
+    DEFINE_PROP_BOOL("worker_per_virtqueue", VirtIOSCSICommon,
+                     conf.worker_per_virtqueue, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
index 779568ab5d28..0e9a1867665e 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -51,6 +51,7 @@ typedef struct virtio_scsi_config VirtIOSCSIConfig;
 struct VirtIOSCSIConf {
     uint32_t num_queues;
     uint32_t virtqueue_size;
+    bool worker_per_virtqueue;
     bool seg_max_adjust;
     uint32_t max_sectors;
     uint32_t cmd_per_lun;
-- 
2.34.1


