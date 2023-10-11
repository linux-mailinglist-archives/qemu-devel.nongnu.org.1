Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBF37C5B8A
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 20:45:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqeC6-0006fA-Vp; Wed, 11 Oct 2023 14:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1qqeBo-0006Yn-8I
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 14:44:12 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1qqeBl-0003AH-MB
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 14:44:11 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39BI2nVq006808; Wed, 11 Oct 2023 18:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=UrRT+q2bKjV59WtmU4YTZfafJ+/E5lmosCE5kpJ8INg=;
 b=uCEE41Df+zWbe2nXUCsj5yGa8Xc0P9ankhd740jQEbzS4eU+h3aEEYZUElz7nwmpdLhz
 Xb6gtL7QOXBCSglZYnLSBgbxnvah8blUOEU/u+D3wYWc8Za/3i2bec2hvEo5LIO2RBQ2
 bBDzvxiOGm1PeRIehshQket6/X3CFvPBr1NnQfPmS/AOeQ+0iwP67NcZR43YjBYHAndf
 7vyToLUdTjQG60AFEjBoQHdc+c2H9kbYcEU/87wsqv5bdaSPAFgmJ23AzeDDNj9c6AuY
 EpQtKtxsaKQgsfMvUktGGdZU8dX+S1li3TxN4etfpTqrSjFnE4lpDWMttC7uC3558sH1 eg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjxxu91b2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Oct 2023 18:44:07 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39BIGtWq002648; Wed, 11 Oct 2023 18:44:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3tjwseffvv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Oct 2023 18:44:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HV2mCEtlGEahkhmvKKtOKIzFxaGqpquG9JVkXntNO7bLQdA5Wwlb7Cam/w6Njue1lN1NcCj26PDR2lrE9+FX2N1VnL610Anyyc6WEN1NpVlApkOA2r8OzmX0lAo42W8Yku9ATx/CmJbJSRacnANRb/V5xx8F9JRV6BWLJs5Avy8lYZk0JwwlPjsV9GeetXHKtKlZBwxuxb6Mg71KHqKS3JbXFB4U06NkpJHu58Pl0xUgMIKQMzFvK9YQoRE/irDrPIvK7qho3vPPZmb88onxl4p+x/AncbsBWrhQG4Jl8lX6KJOYkn/q+Z8WNvTioUFDYUW3VRUFsRMWZJgjDnKbLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrRT+q2bKjV59WtmU4YTZfafJ+/E5lmosCE5kpJ8INg=;
 b=ke6teXctwd/YZ6FPcRjo1e7ivRcNdXhLCHdcDXulWCkJiwW/WjWdnSc/38PfMA4fahc+Z+saGJCYLosdEV8zvOZ8JQeNVam6MeqrrBL/KZOHi9S0+t1r65IdzKhY+BH5Q4uPm/ZSHZdWzq6QDxeV3Vv/6vjUE2H22+CzPspEldgDtTJlaV70ycYGVxX/hV0lRtupa7mZcW4m1xYJTHZuFnSge4vMJVjVOUM9NnT9knJMiLXeALTXqYm3u+rYdYxzLxd3oyokA+J1EpIsZn1DTn2mUhpOnrVyFmptaqa3a0K5tMdl+TLVqETJTXk1oVN6fOawv4A7TK/mPE4F+yzucw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrRT+q2bKjV59WtmU4YTZfafJ+/E5lmosCE5kpJ8INg=;
 b=Wd1+hno3bWGV0xqAu3pPNQUQe8InnrW4C+fgpCKGk5yqaX+CxpM4TJoHJLZShgNTXnMgX/bJq7ZfEHHIvGdaG4dE4nDECrbwMTfPAu9nPuVhJ1xEHg4blr2UmiK3Xrk7hNG+D3YA5XIueOZ28OeEaf59oPaNOdcpXmLsHZFjgwo=
Received: from BYAPR10MB2869.namprd10.prod.outlook.com (2603:10b6:a03:85::17)
 by PH7PR10MB7056.namprd10.prod.outlook.com (2603:10b6:510:275::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.43; Wed, 11 Oct
 2023 18:44:04 +0000
Received: from BYAPR10MB2869.namprd10.prod.outlook.com
 ([fe80::427f:78d:bdc0:3798]) by BYAPR10MB2869.namprd10.prod.outlook.com
 ([fe80::427f:78d:bdc0:3798%4]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 18:44:04 +0000
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
To: 
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de,
 leobras@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 2/4] multifd: document packet_len, next_packet_size
Date: Wed, 11 Oct 2023 11:43:56 -0700
Message-Id: <20231011184358.97349-3-elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231011184358.97349-1-elena.ufimtseva@oracle.com>
References: <20231011184358.97349-1-elena.ufimtseva@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0069.namprd07.prod.outlook.com
 (2603:10b6:a03:60::46) To BYAPR10MB2869.namprd10.prod.outlook.com
 (2603:10b6:a03:85::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2869:EE_|PH7PR10MB7056:EE_
X-MS-Office365-Filtering-Correlation-Id: f96bb171-8d47-4c9e-7876-08dbca8a0ae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F20AReCcUed6vGdqZMuYP6fGKOxZieDrifTRsfY80YsM4rEe8eJIDGdzFE0BAAwuIWQMaTymtJ5REWIZEtDXJl8yPJXCVa3h5hcRk9yznih9oD2gLDo2qpujp77Tic/5WoMj6WAXfS9Nscq70srGVOpKFGY0g+s1iDgzHAnhmkpLwitW59FpSQgGxlBikIXbPaSjNhK/1D7IZG+4BvJgr6BhpifmyxjGWMoLzzTVrc03xWg4TEVmLOWYKRsxTU3ZoqVUCKyARUF+umxk2FFHIVIFKYgVFS6aF+VxzJ+bSU1M3q3AYAeh3G9VJODnOLKWTbaljSwu/uPB2QXNAZxY82UsaC7MKFecDH/+upt5uWbtn+dB/p7GSVnWQwZzllGPR6yeRg/clmgwMUsSPX5tb8I3JkRGvWVsAY0fcgK6PZ0nTZDcHWl/5glFWKA61M+N9hxvWk3C2+ivopAtIVJ0mZoBNY8AHT58YP6uaEj75HA/CQaJZa8uCDHsGB2rM+p9gVQuRUHbSMlBs58Gb42hkLQezXvgLj3YhNWT//jW3/rNytSX1W6iQXXGeQNGRfxtL41I6XVeLj0N12HbosOgpEKx8Fk9cp5lOaShi6Qg8Xw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2869.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(109986022)(451199024)(1800799009)(64100799003)(186009)(4326008)(6666004)(1076003)(8676002)(6512007)(38100700002)(36756003)(86362001)(8936002)(2616005)(6486002)(6506007)(83380400001)(66946007)(478600001)(2906002)(41300700001)(5660300002)(316002)(66476007)(66556008)(44832011)(266003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xKCpSwdBgtAfcctx1szPRXbtKLv61ht/hQU43T9wZFFJ+HJjMdaXaAM/m7iC?=
 =?us-ascii?Q?Fo0QZ8p/WVE2WxsAVBXhXL5AcZ1eJfAwbBPYXKBLi0AuzOit4+/1AKJTGZgv?=
 =?us-ascii?Q?qsD+4hKQC9yjKkVfSWTNu6xlf0k3Jl0g6eNegEhYGzA2viVuQoBtxoJvIVJQ?=
 =?us-ascii?Q?i39iwVGWWwma3AATat9fjLU+1fTGI2eay3xYGAR07zAouAhBqMuodhYlufR9?=
 =?us-ascii?Q?VL92u8jdpKD/rjONUsthZ0oGONsk4WVEmm1oWhvGVXSoxyNJ8rRHAWOSQOl2?=
 =?us-ascii?Q?rdfmaY1XIqX9wQPGmwmhyFgweV5QeXQuQ3TaiEZwBqGhSqYXhd521/FA5iMO?=
 =?us-ascii?Q?izhno/JqQmegDcOwmWkMerAwil8tIDJv1KXV4ovvMEfNCFngKIIubhB8BAZI?=
 =?us-ascii?Q?e4+si6LcHW5wl8dsSagApee7JkOorqabY3qgTnBINWvWA1TwfxMeFNxBgg25?=
 =?us-ascii?Q?k4DkQ/Iaa4q82VDhfLe+84WrQy6hSIx+opS+Xh/Kzzr/pdSP4QrenQSC8Ybr?=
 =?us-ascii?Q?JSc8l7bfMztmPLfB6UsX6hP9/Tcz0NMZxL/vXEOEOBD2sPVp2F1TmO0951It?=
 =?us-ascii?Q?N41RgLdRyAMfbiPvH9RuyRY5LVqc3QTSoESedMse5xMacYLoXLSOOVfZ5yEr?=
 =?us-ascii?Q?QzcTCRdc1kc2DpfOO3rLulhyFO+jPSZnDbGfXJX3iYwSrnoz/bTXWw/h9jWu?=
 =?us-ascii?Q?t9ERN7yF6Ngh3Ro4QWe4O9RNvsG4wo9x4ZkJCVgjFEgaLe+787qKJEUplBUy?=
 =?us-ascii?Q?XATZscNJ6pU2NtKvVhG0XfzCjiJAYq5/gGWIvbH1bJMIRQx39SEzwOGJZCeH?=
 =?us-ascii?Q?hIQASNzgpwJJhY/C9Nh76uY136SvbTPPDdkj5ZoqJdynQRysBYX6O9YHs/mJ?=
 =?us-ascii?Q?SvjZP2s6q7/Zx2zZLSoz7tFNl8GV7J+c5QwWmASJfArbxwe4nHe9boH/NDDu?=
 =?us-ascii?Q?Ognbpi7F16dUFEFMTZXIFvvMROw6bBRpmHZzr8zoXX7lOqtNTC9PDev5wMVY?=
 =?us-ascii?Q?laSQHrQ/+pxYl0SZSCGJ03KvFxLhjEOzlz3cYkVuOEXW2LAxzpVj7PtUc0QX?=
 =?us-ascii?Q?vcn7sFY7bKnepzfoX3iXH/qXHCY5oN7Hk8/9u0HQgGfmUPUBSzmWVJWfJJxX?=
 =?us-ascii?Q?E4SyyWN/GdouC2keMUN77+a4qUTrGUmFZjOqTP+/2j6uygZGUc0mGeAOVuP5?=
 =?us-ascii?Q?tmirM4Yj76r7OpnT/HfyUSHhzJGUB0EQCZbi4EalMspXQo8KIGAWuouUJX/p?=
 =?us-ascii?Q?M0kkA+djO21ptSp+JvPiF9KD/i6chJs0hypJ88OgHZR8d0zwfDZ9Ae6elpuE?=
 =?us-ascii?Q?Cl7ByuxSRVW6gveEx85sqeBBRjWZMeo8aQD07INwsYsZV2ZBmt1qzZLmvDE9?=
 =?us-ascii?Q?+R3179fEZLH7ZxVPvKxuZwMhRWo5vrp771Rn0dboKXP8eR9OJsbzuI7QhQ+b?=
 =?us-ascii?Q?SyLbCOIqFeb/icB9QKqn4/5qrEZWmw7m211oqrcmibMBWGTEt/OIBCcOwD3h?=
 =?us-ascii?Q?RRo7SPwmpDD+mRCRxRARjeVR8E3eLFzlFM5qbfBRyzSQleSzBxwLiB7SofrJ?=
 =?us-ascii?Q?/PfsPI+95cYoMm9f1CF5TU1PxG+c00DQLjXTAacgbnhHp956TWGOx9nDhyHm?=
 =?us-ascii?Q?uPX3HVYUrxmVMXNgHsdFUVqpMdvyPub/8hUpNuCqYM6soBHxnuj6NKdSADUJ?=
 =?us-ascii?Q?KLvLmw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yxtdBHe/W0t4txAGylXhS57a+sGeHVH0ZkAfmtAPVvQWlNOxfkPlTtQZ+P1hIU3lWLGQDwmI/wPUJ6Ag+qZ1RoqFhHPW8wcej1MVH5Tu0zN0l2USDQuTFtbwHqFNDwx0A4MIe3qALSk1viU0xfwL5M/KkpiI6K/nk4yr06NoxvZT77U5VXvWPhlgzzlioFeR7ersuW+0nqYmyn00V3IJXheTuEFUE2I/WwZAJS/BK+IF549OAaLTsMaKz0HHMBj7hWXjo7KCY3eXZDYsutkNk8xKhda3cA9cWl3gXLCYgTNm6pKCGJ85+N1Gj1uEtjp085NX24/5naIp+3Zl2254QsKelvt+44T3ASKCf2lX9RjGY7Bgtcv0KK9mxeMIMVQ8lp2xlRw70DfTseRXZCJyK4Wj5TJ4joDWHvaxVytxRDZG/IHYuOKhgf9bcOTRCoIwvHPcQMD0HNbqIfiwmzrkZ8nPJ/WHIdw1oYWL6td+H+ws2VNwrf3IEXtYIDyNt3eM1n0M66ym0NOzKYCOiP8wm8Rmui3s6/nOSJ8JttEazqdQ7Um2vL62WWUUtLnfiTCt7Y3gZn8Oz8wilr5JpfW4xzAkgYqIXqYzPoQwVYf07S4FkLW+BWKEmFGycLCC/So1o4N5x368KPBhhZUP4NKmc5qKWnELSkUe4h/27GymlxpZdXAXMdSad0vNCvblTKE+VOMUQhYBtanpfmMe1n+b+0iN6KrlTp1uv90TIaIvNGZuByDvZHz72z3s40xMwM/DzU+W6BIqxwB/qHbJqOobg89FUKjFCbk6Dat14MO1QFU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f96bb171-8d47-4c9e-7876-08dbca8a0ae1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2869.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 18:44:04.1167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83Bp1QrP4MX3+O8CrK6TRU+jKB8zHL0aNBU+BAo2hN3WaSjPQOuWZycFnvow28hTMZjDVEIPyBkF1wKsuEdECwLa+VQuN3q1hLK6UQMDY/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7056
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_13,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310110166
X-Proofpoint-GUID: Fswc0CvFBTrlIvgs7sr-anheAzYRFsU6
X-Proofpoint-ORIG-GUID: Fswc0CvFBTrlIvgs7sr-anheAzYRFsU6
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

next_packet_size name is a bit misleading, so add more comments
where its defined.
We send data in two chunks in multifd thread:
 - send the packet with normal (non-zero) guest pages offsets that are
   dirty.
   This uses the packet_len and we increment number of packets
   for this thread that are sent;
 - send the normal (non-zero) guest dirty pages themselves in iovs.
   The total size of the data pointed by all iovs for this chunk
   is next_packet_size. We do not increment the packet_num for this
   thread when sending actual pages;

When compression is enabled, next_packet_size is used to indicate
the size of the compressed buffer on source and destination.

Will be it helpful to rename it as data_size or dirty_data_size?

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 migration/multifd.h | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index a835643b48..37da9b68c2 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -45,7 +45,13 @@ typedef struct {
     uint32_t pages_alloc;
     /* non zero pages */
     uint32_t normal_pages;
-    /* size of the next packet that contains pages */
+    /*
+     * amount of data to be sent to the destination
+     * that is calculated as
+     *  - number of the normal guest dirty pages * page_size in non
+     *    compression case;
+     *  - equals of the compressed data size to be received;
+     */
     uint32_t next_packet_size;
     uint64_t packet_num;
     uint64_t unused[4];    /* Reserved for future use */
@@ -79,11 +85,18 @@ typedef struct {
     QIOChannel *c;
     /* is the yank function registered */
     bool registered_yank;
-    /* packet allocated len */
+    /*
+     * allocated length of a packet to be transferred.
+     * It has a size of MultiFDPacket struct plus
+     * the size of the array of guest page offsets (page_count * page_size).
+     */
     uint32_t packet_len;
     /* guest page size */
     uint32_t page_size;
-    /* number of pages in a full packet */
+    /*
+     * maximum number of dirty pages in a full packet calculated as
+     * MULTIFD_PACKET_SIZE / qemu_target_page_size()
+     */
     uint32_t page_count;
     /* multifd flags for sending ram */
     int write_flags;
@@ -116,7 +129,13 @@ typedef struct {
 
     /* pointer to the packet */
     MultiFDPacket_t *packet;
-    /* size of the next packet that contains pages */
+    /*
+     * amount of data to be sent to the destination
+     * that is calculated as
+     *  - number of the normal guest dirty pages * page_size in non
+     *    compression case;
+     *  - equals of the compressed data size to be received;
+     */
     uint32_t next_packet_size;
     /* packets sent through this channel */
     uint64_t num_packets;
@@ -171,7 +190,13 @@ typedef struct {
 
     /* pointer to the packet */
     MultiFDPacket_t *packet;
-    /* size of the next packet that contains pages */
+    /*
+     * amount of data to be received by the destination
+     * that is calculated as
+     *  - number of the normal guest dirty pages * page_size in non
+     *    compression case;
+     *  - equals of the compressed data size to be received;
+     */
     uint32_t next_packet_size;
     /* packets sent through this channel */
     uint64_t num_packets;
-- 
2.34.1


