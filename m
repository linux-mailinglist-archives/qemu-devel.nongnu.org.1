Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8D37C5B86
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 20:45:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqeBx-0006aI-Th; Wed, 11 Oct 2023 14:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1qqeBp-0006ZN-Q4
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 14:44:14 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1qqeBo-0003CM-26
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 14:44:13 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39BI2pr9017083; Wed, 11 Oct 2023 18:44:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=CtLRbt+75F3pO7Kcc31r9JG+1eL9ah/zDdz26nkC+NI=;
 b=UFqUrxoytvW4veelBkDMKe6qTNdYJcXK8GOgZijU9HtfUOXZgNcMljQDH1vBBf3d9Did
 f+LPOlDvNJrmyWbybo0DrXNMcGid6lDORaEI//Q07wQu81wVnVx760RWpDikVrFVLUDJ
 RlE78NE0R2zwbsuQTD15WgzKei19p16goNQm29y5mrNq9nY1CL6Y51eP9f+k8myLVRnS
 c2p9a5BOvBMKBCa3U+sL6vbcCUv3rn6mkGlcx7xmHJppQvV+wiJ5/Z4bLG2TE2OppqtX
 EiXKzzMiGoKBhbFPY8ax8NmCICdbEG76j7z6vB8CJlc80BJCQzcJJkoZNlVeDjSoEvPR 4A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjycds3vt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Oct 2023 18:44:11 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39BIGue3018050; Wed, 11 Oct 2023 18:44:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3tjwsesxn4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Oct 2023 18:44:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVKFV2TfAXH59kCg7AZkxSwrGnKfFNl90X9XUA8TvTm3dP8t9Gg/uKPiKG8Ed4QT9JOPXJdv2Cg9Dk/F9SykIN+wAMzv8Gs9KGkxHxUPgPAJAnUtS03/ip+9Y2g5u3GokdfdgUsXDIYMVkWUdlpw1Z4ZnjLxEmuuiLL5nPjp/Y1ZqLwMQDlKPMHqB5TW1iL3MuyRtYdSgc3gRfBFrDQwGAY9arnKobZDD4NY2cFKS0NsyY6n+unoVhq5Nla6tFKSrBLEE6CJr2VukOw+dlDbAMpYgpXK4HAwPylMcJW31SQhG7RarAmY74L72zqZ2EQo3haMiYHz08doDB1S0FTqDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtLRbt+75F3pO7Kcc31r9JG+1eL9ah/zDdz26nkC+NI=;
 b=Dd5ZTl4acwLbZGwUo4PMkvOaStGnbTMlCCqgf1ekYtl/FZomXmijf+pAsenrpBIe8Fc9Ee8z+jXkO5yPB2YH7rTOFJGTZivwHKCpdsfk5bOCwuVFsO+a+tSWQHEAVIveWdVrF/i7aBFgbJhM9cjmbuiS85NMN1Teip00SVkroJu0fxkvPEZDzdL3l95OCVA5VVYSoXF6KCRv5dv3HWfpS5EznoK355pK97/86KZoy8N0mTttJZwBVEQDqxMYhlnTpRvYnnV02c3wqo70JO3Chbf8PfOB1Yv5eAFMYQoi/OvgbLx0EO7JZLemK/Xwdjxzz7SXP2xaASVJ6E4BlOsAaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtLRbt+75F3pO7Kcc31r9JG+1eL9ah/zDdz26nkC+NI=;
 b=qSer6bzvZFkRDFS2li5blChu7M5x14JCBpEK7vPLYuT3bUbOqwQrVsuJ/H0j4bBJ+GrmPQxSvMEFcdXaVBYZQpKrxXBn4Ut6wpPvkMwO+XuoRWor8W3lbu6TLvzCbPAPCj5PnffPoBZeczmD+nAFoGHvO0t45559W/xNMSfzgLE=
Received: from BYAPR10MB2869.namprd10.prod.outlook.com (2603:10b6:a03:85::17)
 by PH7PR10MB7056.namprd10.prod.outlook.com (2603:10b6:510:275::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.43; Wed, 11 Oct
 2023 18:44:08 +0000
Received: from BYAPR10MB2869.namprd10.prod.outlook.com
 ([fe80::427f:78d:bdc0:3798]) by BYAPR10MB2869.namprd10.prod.outlook.com
 ([fe80::427f:78d:bdc0:3798%4]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 18:44:08 +0000
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
To: 
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de,
 leobras@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 4/4] multifd: reset next_packet_len after sending pages
Date: Wed, 11 Oct 2023 11:43:58 -0700
Message-Id: <20231011184358.97349-5-elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011184358.97349-1-elena.ufimtseva@oracle.com>
References: <20231011184358.97349-1-elena.ufimtseva@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0141.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::26) To BYAPR10MB2869.namprd10.prod.outlook.com
 (2603:10b6:a03:85::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2869:EE_|PH7PR10MB7056:EE_
X-MS-Office365-Filtering-Correlation-Id: cea1e51c-94f6-4706-dad9-08dbca8a0d56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nB2cwI+BM62ww0wMShC+SHhnMysby1CT4VIf8hJKdJA8IeMlZy/Sk1UWXTlkKhyYMKmdidFMJOeTskpr6VSRTebqiutUJDQf5w75ppSrERojTB+uyNLga/epkqAzTgtGkaKCDqWqXRXoZ+3Q7J5UhZTsMuNXitggzBWuTS66+J3tEik1wekOL2qpN00OCm6EG/fa6RTpGz1P5Lbm5HvK+GHVx8IXogIIKaGtouLklHAL7fLGlQR0x3s4ehFV2LSa/KdsHIJdxzLyo5sqIhiEkFMkvGfY3neQ32vGynoLhgT0ZtaX+ErqI0Mip5n5ikqrwWV+5TJK5sOaO+26FohLdwi/be788K6Nc2FBjfsHHsbXE+MU5gno065cZsfxPTdJJOKxUgF4hOQQqYbXeQHjGxYmM1Rs4pIyPWQm+p6zaa8NegV+Ag6kDYlGE1VxNiK8b4maiI3D5PtEescgBLN3lxkSq8g4k7kOJdVeO/3Zk7qffNOgeaN3zY59GEiS8GdlUCvy+lL7XAGo1bg7o/zM1uRKaF+Lk+wtF7WFaBQSqaJdJaJF/39NusNGFakPpdX4++EuLs/udphd0fpe11kaDw8ETdsy56xqAX3PrZ3octE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2869.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(109986022)(451199024)(1800799009)(64100799003)(186009)(4326008)(6666004)(1076003)(8676002)(6512007)(38100700002)(36756003)(86362001)(4744005)(8936002)(2616005)(6486002)(6506007)(83380400001)(66946007)(478600001)(2906002)(41300700001)(5660300002)(316002)(66476007)(66556008)(44832011)(266003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1w/VJqBkHDADKAV5pN11Ps45C1FpNE0Q0xHPF6LNG3Q5SGVgtFF3xYfxQ/Tx?=
 =?us-ascii?Q?rj+FZj0ic9nY7bR0PlJo0+JJV3yFGwAK+qWLLFCBvng975iv3xxTnOMMb21p?=
 =?us-ascii?Q?xsTaLciOsH/gAwnlEsotP0u6Xfi0s0Rp0OHkFt4naXIdm8++eOH2LqMrGQdv?=
 =?us-ascii?Q?H7B6bJJz9UjjmgyW9gORZ5D6RKj/BGsYu5TdMnBLWJi7KYzETiXF6GFNW84n?=
 =?us-ascii?Q?P/x6lhKcJvFjgnymA3+DjrZeU4eYxvzJB9xU53LXIrtfWjtlQguFcEcuOx+S?=
 =?us-ascii?Q?XlP1WNx+oPcVhKZQgV8HNTbII9ZQmpE/f8cD/bo+qGeAdbRu2hdgLR7/znfO?=
 =?us-ascii?Q?o0Ubp4xF6NXPFGEE8uAwSPp+e4XuEgcC+NHWBgkT6BYZJnsjQ3tTw95Uz7LN?=
 =?us-ascii?Q?DOVPwyNzG/218xoZu0Afsg5taOLCebzr9sxm0UbB//Ks0T0du57oFPWdcoY/?=
 =?us-ascii?Q?QEzVMwjQw5Inj06Id7L//iSfcIbYpXLvbhonpYi8sfWQLrDUaW1uNEvaiyWX?=
 =?us-ascii?Q?ptyDf/lMvNCLP9ce77t4y6ESwx0U2gn3ENGWXuD58CvvazU35GV5c+zDt8uv?=
 =?us-ascii?Q?+6l+oNDqlHmp6Rzca2VFmjeZbK+IfhWK9W7EujHU3TvLky42i3f+MLYmoyxF?=
 =?us-ascii?Q?7gpSPHY13eb3mE8uhu8cZwpWfYzgiHM+huKG1Ztgev3yFQw06dgPBvVMl1Jb?=
 =?us-ascii?Q?cKJb8IhYY2skNUyoL3z8TmK95QhM/vtR418hhPttHJQRLuiUZIbrvH2hQZEx?=
 =?us-ascii?Q?ktgUyNKuIMxMZwQKViXn0f8WI/93PZPe+9R+sY/iDOVsv78O9KY9nRSDUxBG?=
 =?us-ascii?Q?rhyiuAQtB9vyzqCXDmRhx+/WJZ+6YpxvLLv+WGyntigVjx/R8t+KHEA4t452?=
 =?us-ascii?Q?NqZZmM55zTadl+NQfNitsrq5wfLUpqTO081uBS3q2Y4lCEVlEoSZQ6snV9YD?=
 =?us-ascii?Q?Y5nJylNaGLdvc1/Cyqd9jTmQ8eQGRO5vPZA8FGh0R5lOONOnGgnO2QbXD0Sa?=
 =?us-ascii?Q?3RBi5uXh9kMDVOzsNwSJ9OWfFYP1oyQzhb8oqkTklkb45IM6r+sh/pkMCWlS?=
 =?us-ascii?Q?N+noMMCr7fc/aesiNT8i7TWXTEyE7vtEMy5aKs/BuzwOzyWQAakJFHuy4goc?=
 =?us-ascii?Q?I/NHgeZrhwI/Xe2snHkT0ROEKu/Z3AF6SrRBLrkRGM4C80yoD39mIPFuyCK8?=
 =?us-ascii?Q?Bq/nXRK9OKyvHrmOuu2DjyqQoIKqVTyBhtHDHIoYnSuYStGx9xJ9ox7bQUt3?=
 =?us-ascii?Q?ky0CBBKMF2rjXZqCPD+KwlwawXMpH2z1LzWlO8tiMY8NgHXIuLi65Se341I4?=
 =?us-ascii?Q?wGimhrkLOoX5UouLuSmGNV9MJaqlaUhNoBaxlhh3yFlFtDiNtqQm4ABRxhe+?=
 =?us-ascii?Q?PJf+TsCzc1qEPw7nmKW3Iqu/Yo0Bj1hLf0uNbWrzAlVvlLgRIg1yTNPN92MD?=
 =?us-ascii?Q?gH8JuvUNheNDZR3XnohPbQg+QT/8QXnWZlQp8EHyFNhFjsyl3yvvGOp457P6?=
 =?us-ascii?Q?Bg/+AygS4y/zg0WFRQl9ErzOJ/pRQzQCSubs1EcntlGHAZrQPhOFVKnSIgnc?=
 =?us-ascii?Q?Ic8BJNxTbJbUVaMuOivd2LJppALngpdb2jMxGuK5tsvQM1f+8VNc1monkzDE?=
 =?us-ascii?Q?HPeuO/EVIGcclDSz/Sft+l+Xf0Jg01D8sMc+1Tw94UkiBNxnJPdvOHSiZtHz?=
 =?us-ascii?Q?I0S0Hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SWIVzcUSp+61JVedn5WE4kysWBaxPKL8+EMNAYMtfL1luBQY/DBDt+jGpHgj7RTZLCTrDgd3mnItijuadkm6RYoFBsk/xBNG7jHwIe61BMBpb6c1yP+uujx9+NbJK3x1SNPMkviDl0rF8T1HhNF5UkN4I1blLgwJ1EMfJETpnPBSxvUHRW+nPL32O5Vs6jC3b0jWcddoC53hax/r2EjoYiRHZIdSTLiqoRXDhuUOpYbCDt1ljbunl1Uhg54EE1qaxRvWMRr61HRthDkMCaJvN18cPAcExciJqgpkr+CncHCrjAGvZIuPOZjXCykFkp1GqNwCxJVjbd0IXqwnhI4eBs2YoqrPSbrZ5yN/V1EeyieI/D+sE5LOon0ZzfJEzsL9B0QqX7lG2La1K/G7SsRHqB5NfUw+TD9WMtR401Z0iwNnNVorCkH8Era63VXTEGnaTC1+HXZKKaOGCWHHp3QzBPjAcCBtbT20f6kWd6SREGMSG/BIVjq9zkZa2+/sr0ig+XrFcZe/5t8h024V1bRZojOiGCK1q1F71MdAImXvWPCTUl05kIQtuIdT6JTPaNfTzMJSfCvZ/BhgnBLb+VQYAEDG6BRpGaJMDKAZlGEeCWRt+XLeFohOebOstoQcou2bFTbqsiabgBAK6simrUj76styyB6Zg3vbPEbe+8u3nidUsajjf3+xBpWsOt2lMmrQeQXFT0bRyRlm7Iqdof9F0PJw/cJYPVrfJoyMu8VOvn7KbqWvTIvBeS+ZYqBIYJwvd+XNQvsB9h5kxGgv6tY4g+MRk4olgKYXqD3mnujC7yM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cea1e51c-94f6-4706-dad9-08dbca8a0d56
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2869.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 18:44:08.2723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FI3jm931jbdbtilFKqDrQIsbmCh/yOfEcKP7dyv/2jiNksORlGsLz1lQm0fvJZ0wUznggnJjeQvxzsEZaeN3+rI83/8yjyQRqvY/6M/ORE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7056
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_13,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110166
X-Proofpoint-ORIG-GUID: xzY12e389f-_Tb5xzW3oaUX2zCuecOyX
X-Proofpoint-GUID: xzY12e389f-_Tb5xzW3oaUX2zCuecOyX
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=elena.ufimtseva@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Sometimes multifd sends just sync packet with no pages
(normal_num is 0). In this case the old value is being
preserved and being accounted for while only packet_len
is being transferred.
Reset it to 0 after sending and accounting for.

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/multifd.c b/migration/multifd.c
index e6e0013c16..c45f5015f8 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -730,6 +730,7 @@ static void *multifd_send_thread(void *opaque)
                        p->next_packet_size + p->packet_len);
             stat64_add(&mig_stats.transferred,
                        p->next_packet_size + p->packet_len);
+            p->next_packet_size = 0;
             qemu_mutex_lock(&p->mutex);
             p->pending_job--;
             qemu_mutex_unlock(&p->mutex);
-- 
2.34.1


