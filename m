Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 732A57C8852
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 17:10:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrJnJ-00072U-5A; Fri, 13 Oct 2023 11:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qrJn9-0006zD-CW
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:09:33 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qrJn2-0006zo-ED
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:09:30 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39DE0nFC019270; Fri, 13 Oct 2023 15:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=W2UWonwhJLUiL/DU8SA7D1JKPkE/ypyvs/ozde+ZdS8=;
 b=Gm2v5zdX3deSrxysrRD2/g+8/y5FD1awrJCyVAwSAis5mAZUJEsFe8XzW4nyXlPLOubX
 VCS7pcCRvfWrJr+j4N2AUlXQHyBtXiwuk7HWg0T+aAEfKgVMx9gtKntNpI34/Ibip0Pt
 eCmfWPiApPd2ZUdW30iWeDwCpBnhnfUJCa9CoIJ5/fcxs4v9COBZLJ45KgRbnEmnlp4N
 6fiDnkvSkZlMc7TZeHsH6kMLSV+gQ3YGsTBEpM/JWQjQ1lawQNc6rTlPCdawvJwcIGtN
 P+bA9RxVTvAW4hyfmufqtyZhcWFhMRRY5FzFE1AxWr9Y+0z7NDnU52TUMSTS9O8NCzbd Ng== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tmh912j3d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Oct 2023 15:09:20 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39DF8vME021322; Fri, 13 Oct 2023 15:09:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3tptasfv4p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Oct 2023 15:09:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIrB11APN2mr0uKEMhT0KKandDhnsPD8XqkfstR7BPadeJGbFUBoMYyTmBa/SuAflya6Bb8kigfDSD3rCFM6tRJWYSKPBpQMRFOQqoTQUe3vvX5dEQ91StEt673wWI3sL2F3+O5B83X9FZFYlqaMFZIycIyTgkraoqtj12C2N0NKqkVs8i+IIMzP23Y8yilB5xY1tiFFECvYP3m55uyN0FpVuAaYeBEWDMJ6n0LOzKvwpy26IiU94rrLH0aATDniJJc1wYo+MRM9Es4ThjwLzKk0gc3XYJyoRHVve3ByMf4VJIwx1+wrJuBPMXBpAHKpGNZmxA8nOicbaZllQZkGwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2UWonwhJLUiL/DU8SA7D1JKPkE/ypyvs/ozde+ZdS8=;
 b=NnShCQeF3iLlsjafJAGPrwuW4rsTEbfHoASWpZor4PLFxChiMjP63HL84L2iKFxQJmPvVAsh7H2VGHd6OMRbA+BY6T08atDsTDfeGxuIQRxRhwl1a7SanRUWm5Sm4TBryvby3D4cq6LuVMqyGdjh6fVWIhw5RDVt2kJZeWS+rm4CFfoO3sKBT5b9zNuIJZsTX6Z+3YOypucI5wggmAWzW/SIoJ45caSRi/40eAapQsx6Drc7ux/tPa6rv89SmWkS87dQ7pyvKCEtKF09WvHhk6oSPrls9oWuhlKejhtTxUbVg04SishSxfy22R48KTlr/qlUazGSO3xhGJtmr1mJIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2UWonwhJLUiL/DU8SA7D1JKPkE/ypyvs/ozde+ZdS8=;
 b=PWyJRZbW5cgqihWCqT4tGRCf4Xig1Q1tYQI+v/HGhPZIqxHpdXfabQG99N/rFe7OycAsBvUq+ZvRymtMz6QfPx5dsINnSphPxrHybEWDftEdbW8VNDjl6WpbaZV0GBWLrDlxAqMGUNoVKpEL23oOpCAVZDY9iMdzEYOBVDstsEE=
Received: from PH0PR10MB5481.namprd10.prod.outlook.com (2603:10b6:510:ea::5)
 by CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Fri, 13 Oct
 2023 15:08:58 +0000
Received: from PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::487d:5c37:8928:9885]) by PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::487d:5c37:8928:9885%4]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 15:08:58 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: qemu-devel@nongnu.org, peterx@redhat.com
Cc: lizhijian@fujitsu.com, pbonzini@redhat.com, quintela@redhat.com,
 leobras@redhat.com, joao.m.martins@oracle.com, lidongchen@tencent.com,
 william.roche@oracle.com
Subject: [PATCH v4 2/2] migration: prevent migration when a poisoned page is
 unknown from the VM
Date: Fri, 13 Oct 2023 15:08:39 +0000
Message-Id: <20231013150839.867164-3-william.roche@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231013150839.867164-1-william.roche@oracle.com>
References: <20230920235301.1622672-1-william.roche@oracle.com>
 <20231013150839.867164-1-william.roche@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0006.prod.exchangelabs.com
 (2603:10b6:207:18::19) To PH0PR10MB5481.namprd10.prod.outlook.com
 (2603:10b6:510:ea::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5481:EE_|CH2PR10MB4166:EE_
X-MS-Office365-Filtering-Correlation-Id: b319961b-c0b2-4f93-8fd7-08dbcbfe52ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yvUCcGURtAaGmPJj5876gcrk8JeKbzlG3mMkJQ5h5vvTWEB/nEoZTvQlQqGSZYpd84jTV1BNRgh7R4CSDCXIkypz+39CV0qqNT8B0jrp75mSFuiq3dx5sJtRZzPl9Wr+BY77x9A0xGztholH3H8uTa7droYiIA6nyINF4l5/sEX3c9cNx+fjNE8MQ+xaFuVUlJjg+qx77qxrlNSM7wkF5xM9TysJ1lkQue2yxpkAuFXUUndFWDGIbNw4V2o36R6vPUkACAs73Jz8gbD9Le/QgDe6MABb3U3xUySMLm53pgt6Nm8okIVReloawfY84zp6gyt97A3yGXBp83pdIhuV8UMFWoQIOtiXu2QbXuYBcE9BHfdaMWHALiG3Z2RMB/DQdhxVVZ1hWHTWVGmRmFmwHj+9eZdrvLXvqwu9HRGPiQLEZkyNVV1qtlC74aY/p6uDfLZJtsX3y0jX8XZpNs36NrgiYRC6dD7aATgtpkQ27rPWauN1CF2ErwAtTXK/ZIOb3LVboYJbe+x1Dd/q/tt6SooTKbP2TEMKv6bYEdfQ4fdZFBgjds79WM1KAe32Bcwe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5481.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(396003)(376002)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(86362001)(38100700002)(36756003)(5660300002)(41300700001)(66946007)(66476007)(6666004)(2906002)(8676002)(478600001)(8936002)(6486002)(6512007)(4326008)(6506007)(83380400001)(1076003)(2616005)(107886003)(66556008)(316002)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gp4IMu+sEYRfudpcu+11K9Goqe7qbZpccDZnLb+AFXop2ZB1/QQ99pXVPAvJ?=
 =?us-ascii?Q?ZdEZL4G7Zc/NBSRPois0iqrc/AhFdRifLZn9jKtzI3EPl6r7BWASBLyZ6fy3?=
 =?us-ascii?Q?rbKywEfLSt/c/wM5eMSQRdXe0PkFlpSDF7VkEq2qcxy6rW97j6B7sWvOqmnU?=
 =?us-ascii?Q?+Vaz1HO75B2SbEzGpz5YlNE8GBKSX49PG8CpL0IpQvEfl7RkqyQKkDuaE0tV?=
 =?us-ascii?Q?ZE1bnxWmslbOgDtXwV11Z1A381E8CR6EG9AiZmlrpIlgBNkqa/xyV1ImDu8G?=
 =?us-ascii?Q?x/nbuSzAXhw3hiclu32f24O31xAKpGjcAF7GU5Kd7I84DgtPl9oF7axgYCfo?=
 =?us-ascii?Q?Cj/S65peQxGTGzqbfJwAJZRem/CZ9dHUmTH7CrE7EG/LmKhink6gCJy4okTQ?=
 =?us-ascii?Q?L0zDygFPaxkWi+Efuy5vu6/iuODe9WWb03xf51qsCifmLRicobP9+zibedHP?=
 =?us-ascii?Q?6KJ8CH9YfOPBZ/Q6AikF6qDtWPu8bI2ha47ZuW0MVU4aLt6D3zE/UhuI7OQN?=
 =?us-ascii?Q?mNL3AFGCFpJ1RwIf2M69Q3j6WBhpVXA+sqbJiZmXBrlESFQtrq4K0hkwzQFO?=
 =?us-ascii?Q?ZXM/kAlDPovnZTtbBPUXYGKmBpmIFUR1jgXj+/J5aS1nAjNbsn16BjaOc/KG?=
 =?us-ascii?Q?hi0hfiLv7YbFXcE4l1esSUcdLD6UZrDkIlf611yrJhs8aBRLypvzhkFMkWhQ?=
 =?us-ascii?Q?IPG7Qf8obEXaWQlA4DXkYx7t2BIjhP4Gbo6sEMbu0yVev1qN4pk7H6gtoHdr?=
 =?us-ascii?Q?9QpIMxtz0Y4nZ7F/SN8QQ6GW/QMEvLG1kpMm/cagYGibkQ8iBV51cgLX1NLt?=
 =?us-ascii?Q?Pn2TGpfw1VZDnJ2I4r0sN1mYU/rR2ACXx6RpXNPy3P9CKGQkGCb4k0tfq/Fy?=
 =?us-ascii?Q?hJPAX3ogpQ8DKejXVW0UJXUbgkdsYDMZTIlfhSP26EAEVAW6wmX0bnwh8BoB?=
 =?us-ascii?Q?P2fvAYEf2lAcnf6mlndpLsNdILG0CPuuEE+K4PjaXg9aROKH0vg/Gp40LPPk?=
 =?us-ascii?Q?ssXpXVYzKu42YdX6QqqUNjD3eveiZlkI51qzrNc1CRzWKHvmJXcpOEf/EQ0w?=
 =?us-ascii?Q?iUv5OZQ43oOkjNh5Dr5BPzaOk5KSmKXM7Aa4j5DwrqFgbxhtoRiuG1rYIhE4?=
 =?us-ascii?Q?dH8UbyX0HOJ1dqa91sCGa9ZrH1jwchZ4jpbGU6sR0csKYNiO6G3AW0Ep0sFg?=
 =?us-ascii?Q?u4AfDWNpxm3q+bySVnKwmjAEQAsTw/B/47iH/S6sEkuLQ3iMAuz6JHZ1mTV/?=
 =?us-ascii?Q?RdLTjDE2KdQVuWmdQApkSh25k/tqfEi5W3N7xuO/kjqC76YrYzxC9IdUHlQa?=
 =?us-ascii?Q?ASeeMfMT37WjEjenCu5il6g5O7EX4E/k0gxMQwCSqIi7m5a19aiQq33h3h2n?=
 =?us-ascii?Q?E3q6mJ6i9Cnr2B0j288HzTcD4X3xh+JExrm7oHVNE24zSnXolCqCv4bXoL1U?=
 =?us-ascii?Q?yIFf2yOEWezCYIsMLWlwo2Ic0jp5d9XicXTOdC+FMEAU2s9HQulIeaYjuSz1?=
 =?us-ascii?Q?VfSSZbL04iMnZhJ0SGFcEZPmAooMJMogmhJL+XoQzs0l6ciR2NiapL9WGqcc?=
 =?us-ascii?Q?+WVE4kISnk7Zaf9014MhGpQH5kn94v40p/vph87wEIDdgqhydx0/HBYPnswI?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FvYLj5EfMT9BrAUNEV2TtZ0T9lswHdMtl+Y1aNVE9kQT9zKyy4ekQYzFzTDZeqRPUmPppUjnuGy2X6ZIrTKbU+9Y2K+0Xg3utCbI9nJ8KgTfkEPufcyRxRRexoUySkBHTysfEtGwlJZGUrMq4/xpvuLIJzjex5YdT0x5EQkohaMIPt75gDh76vNnfkF/wn5orfQnNon/X1KhK4kMtZSaOESTjaG2j+HKyNB3CkZvAlrAIb8Hy/kF9fsKHclFqyRqz2kYxP1RwtDeiz0K77dm7e/O2E7U3xIL+p/tVfODUcwRjsZL1dwmwGaqi3BstxU3EKVlNr3cz1gbxV7AcfD2LC0ke6auzpqPBuzjR7/daCa5wiI8o+A3yQWPLpVI/FW/fva1Xw2ObMvmA+PuOVEx90IPGivfZNNs0bG/SU9D506QZXrCcm9c421iSOVGN7OD7OcL5oOr1OlaYCPmlRMr1avlHNzcHH9F2SSf/fuBOh4wV7N3zAxSf7K7oKmpUhOiF2SBRigO8JSFscQI4jZeG1vHimdMfxk3TY/wlXgXXUI/YsgxYtrKO17GuceQI+PT7qMmhN7r0AzjThWOzLA+HAzopW5P5htwdAuN1aIvtu/Pzw4P80Ms2MnM5ycEHtF3ii2PLyMlMvSmSCu5p1TYLGOTNF4FVHUrA+zF0ZtqWcqFl52mZOlsHm4QecXsJx8Vs3o/ZbFnUu1dFbVahs1y4diMuw7ancEWl9Ewdjg++PgoG0HvUp3g5Te1nr68CzGTs/RDZzXBA2oumtIArWwFk9NRtdM4E7RubxNTar4h6SKHMaJ8V3D/7Z56x7EhL6G/Etfg+tdlLZBZOrCqhNm3tQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b319961b-c0b2-4f93-8fd7-08dbcbfe52ff
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5481.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 15:08:57.9081 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3EXphpY9A69QmJlSbwnzioZ5+i9e5Ybj9Q/gwl+qmpO4ny5ElUH5tT1F9KaSOd3gKiF2H/9f0Xk7jXDDYGBXxQQAcz8uBPC90BiG0nyK4eQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4166
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_06,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310130128
X-Proofpoint-GUID: gDOL9R2c_BemUkTAtmt4v0KpeGVB8iSC
X-Proofpoint-ORIG-GUID: gDOL9R2c_BemUkTAtmt4v0KpeGVB8iSC
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

Migrating a poisoned page as a zero-page can only be done when the
running guest kernel knows about this poison, so that it marks this
page as unaccessible and any access in the VM would fail.

But if a poison information is not relayed to the VM, the kernel
does not prevent its access. In this case, transforming a poisoned
page into a zero-page could create a case of silent data corruption.

So we have to keep track of poisons not injected into the guest,
like the ARM VM emulation ignoring BUS_MCEERR_AO errors.
When such a page exists, the migration has to be blocked.

Signed-off-by: William Roche <william.roche@oracle.com>
---
 accel/kvm/kvm-all.c      | 27 ++++++++++++++++++++++++++-
 accel/stubs/kvm-stub.c   |  5 +++++
 include/sysemu/kvm.h     |  6 ++++++
 include/sysemu/kvm_int.h |  3 ++-
 migration/migration.c    |  6 ++++++
 target/arm/kvm64.c       |  6 +++++-
 target/i386/kvm/kvm.c    |  2 +-
 7 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 850577ea0e..2829b6372a 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1133,8 +1133,17 @@ int kvm_vm_check_extension(KVMState *s, unsigned int extension)
     return ret;
 }
 
+/*
+ * We track the poisoned pages to be able to:
+ * - replace them on VM reset
+ * - skip them when migrating
+ * - block a migration for a VM where a poisoned page is ignored
+ *   as this VM kernel (not knowing about the error) could
+ *   incorrectly access the page.
+ */
 typedef struct HWPoisonPage {
     ram_addr_t ram_addr;
+    bool       vm_known;
     QLIST_ENTRY(HWPoisonPage) list;
 } HWPoisonPage;
 
@@ -1166,20 +1175,36 @@ bool kvm_hwpoisoned_page(RAMBlock *block, void *offset)
     return false;
 }
 
-void kvm_hwpoison_page_add(ram_addr_t ram_addr)
+void kvm_hwpoison_page_add(ram_addr_t ram_addr, bool known)
 {
     HWPoisonPage *page;
 
     QLIST_FOREACH(page, &hwpoison_page_list, list) {
         if (page->ram_addr == ram_addr) {
+            if (known && !page->vm_known) {
+                page->vm_known = true;
+            }
             return;
         }
     }
     page = g_new(HWPoisonPage, 1);
     page->ram_addr = ram_addr;
+    page->vm_known = known;
     QLIST_INSERT_HEAD(&hwpoison_page_list, page, list);
 }
 
+bool kvm_hwpoisoned_unknown(void)
+{
+    HWPoisonPage *pg;
+
+    QLIST_FOREACH(pg, &hwpoison_page_list, list) {
+        if (!pg->vm_known) {
+            return true;
+        }
+    }
+    return false;
+}
+
 static uint32_t adjust_ioeventfd_endianness(uint32_t val, uint32_t size)
 {
 #if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index c0a31611df..c43de44263 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -138,3 +138,8 @@ bool kvm_hwpoisoned_page(RAMBlock *block, void *ram_addr)
 {
     return false;
 }
+
+bool kvm_hwpoisoned_unknown(void)
+{
+    return false;
+}
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 858688227a..37c8316ce4 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -580,4 +580,10 @@ uint32_t kvm_dirty_ring_size(void);
  *          false: page not yet poisoned
  */
 bool kvm_hwpoisoned_page(RAMBlock *block, void *ram_addr);
+
+/**
+ * kvm_hwpoisoned_unknown - indicate if a qemu reported memory error
+ * is still unknown to (hasn't been injected into) the VM kernel.
+ */
+bool kvm_hwpoisoned_unknown(void);
 #endif
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index a5b9122cb8..2dfde40690 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -136,10 +136,11 @@ void kvm_set_max_memslot_size(hwaddr max_slot_size);
  *
  * Parameters:
  *  @ram_addr: the address in the RAM for the poisoned page
+ *  @known: indicate if the error is injected to the VM kernel
  *
  * Add a poisoned page to the list
  *
  * Return: None.
  */
-void kvm_hwpoison_page_add(ram_addr_t ram_addr);
+void kvm_hwpoison_page_add(ram_addr_t ram_addr, bool known);
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 1c6c81ad49..27e9571aaf 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -66,6 +66,7 @@
 #include "sysemu/qtest.h"
 #include "options.h"
 #include "sysemu/dirtylimit.h"
+#include "sysemu/kvm.h"
 
 static NotifierList migration_state_notifiers =
     NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
@@ -1646,6 +1647,11 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
         return false;
     }
 
+    if (kvm_hwpoisoned_unknown()) {
+        error_setg(errp, "Can't migrate this vm with ignored poisoned page");
+        return false;
+    }
+
     if (migration_is_blocked(errp)) {
         return false;
     }
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 5e95c496bb..e8db6380c1 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -1158,7 +1158,6 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
         ram_addr = qemu_ram_addr_from_host(addr);
         if (ram_addr != RAM_ADDR_INVALID &&
             kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
-            kvm_hwpoison_page_add(ram_addr);
             /*
              * If this is a BUS_MCEERR_AR, we know we have been called
              * synchronously from the vCPU thread, so we can easily
@@ -1169,7 +1168,12 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
              * called synchronously from the vCPU thread, or a bit
              * later from the main thread, so doing the injection of
              * the error would be more complicated.
+             * In this case, BUS_MCEERR_AO errors are unknown from the
+             * guest, and we will prevent migration as long as this
+             * poisoned page hasn't generated a BUS_MCEERR_AR error
+             * that the guest takes into account.
              */
+            kvm_hwpoison_page_add(ram_addr, (code == BUS_MCEERR_AR));
             if (code == BUS_MCEERR_AR) {
                 kvm_cpu_synchronize_state(c);
                 if (!acpi_ghes_record_errors(ACPI_HEST_SRC_ID_SEA, paddr)) {
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index f6c7f7e268..f9365b4457 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -649,7 +649,7 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
         ram_addr = qemu_ram_addr_from_host(addr);
         if (ram_addr != RAM_ADDR_INVALID &&
             kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
-            kvm_hwpoison_page_add(ram_addr);
+            kvm_hwpoison_page_add(ram_addr, true);
             kvm_mce_inject(cpu, paddr, code);
 
             /*
-- 
2.39.3


