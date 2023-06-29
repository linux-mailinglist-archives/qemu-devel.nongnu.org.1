Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A86AF7429C6
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 17:37:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEth1-0007Kj-HT; Thu, 29 Jun 2023 11:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1qEtgu-0007HC-T1
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 11:36:20 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1qEtgp-00026k-Eb
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 11:36:16 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35TE7qNM011603; Thu, 29 Jun 2023 15:36:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=ap5KhEfY5HXNsTtZjpGvzMbuBM4kt0oLyYlP4My0KEw=;
 b=rOg/goEJ+5LtUUQjblwKxg4IoheTXtiPv59V4Z+kiedfAkZiDxHX3BTFuAgg0jLwTsqE
 PKXMlt2WPvVrz3FBcd4UxUSYK88DOcUCIZovld+lVB6gChS5Fm8/TcIJB1Zt39/UhI2q
 O8z/AuAVoEfrcbLM0luHY1rUKF9nMFe81ykkkrTP2I6X0dd6DhZ8c/2GGHPNkT5203wq
 lTbrYoy4Ps72GSUuR63Ne2g+BflbZZdXPblktaf7RJgXT/aZ64C+zoqYnLK8NQvXPcgi
 k/3bZPce3kcYjgedSjXgvqyo7XwLFY0wk5z/9P5uiBPEHPmm7WKuQ28QuwIAa6jAeaWM lQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq314wvw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jun 2023 15:36:02 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35TEVKBF038208; Thu, 29 Jun 2023 15:36:01 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpxe35a3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jun 2023 15:36:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLf2KzyB5fHPTPBLctvDf+jYeUM1DxeHQxPe9iHGsEZqULwtl25cqjeuM8o8RzjQqV+OEJP63SZO6td9EgUPe9Hv6mZpV88mkDWBACqZ+XdlIlv3mbv6oG9bsR+BX8/cd2C8bxp0ZB1O2FxCMxQG5o2PzutNFbD3vUD/SLIauuRs+JZgifhvEIx5dEz5PyRNZhPTUfzUi2b6ylM8UTEyK2EFLkudrQK0q7LXEx+Kf8aQIRg5yjumzQQOLoGF8S5376snmPFdkvqk+qvnSZdgy5uqLsFb67BI8UpifJDZmUeuveyLO3EhmPscc0qK8UcNl9/T0TCZkXMKdOpkbJ0Lzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ap5KhEfY5HXNsTtZjpGvzMbuBM4kt0oLyYlP4My0KEw=;
 b=DpJkQbHKjCuJOXcv7uUOhW1MerQ1V6rulxAMDjHZFpCHlCAJ3rQhLUX57Mwu2UsZ3VBkEvF5QU8WZ8Hgwd8zg4uWK08Xm+1FBiBfbOXdPQvaONtoprc4d5c7VWxVPleknrng2oB4M98y41Q+419GVr0BZ7Gyk+aj4VmereLOHDwW3VROwMA2Kj1Jnp8f60W5TCGIyRqbG3w2IPJR9Q4KFD5U0N7WW0yniMg+mDF4GL9JtIAMMIkgX7rjkuU2HBqrjyUW/GYX31R8ON9LjsA5Herkier+CVXIggVtOt5KUIVp/BDzN4ZTLVrCdYXTp6FWIzmNj+7LdsvVx1mGnJvbLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ap5KhEfY5HXNsTtZjpGvzMbuBM4kt0oLyYlP4My0KEw=;
 b=zgPenvjgVDGu3l3hT4dQk3TYN67iZn9NY+YbuOTYttDrDa91vMci9ypfBggt/9nYxeUc8ZB0T0Q13VWJdBMC+vOiXhOE13QnkbL4a3v13jia5uMQ2oHupAtpRGvcEb0xC20elCJhA+HBRdxJmFNSvdXEyBfUfugEfpmRR4jMhd8=
Received: from MN2PR10MB4013.namprd10.prod.outlook.com (2603:10b6:208:185::25)
 by IA1PR10MB7214.namprd10.prod.outlook.com (2603:10b6:208:3f3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 15:35:57 +0000
Received: from MN2PR10MB4013.namprd10.prod.outlook.com
 ([fe80::bd6f:119d:f159:a803]) by MN2PR10MB4013.namprd10.prod.outlook.com
 ([fe80::bd6f:119d:f159:a803%6]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 15:35:57 +0000
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, stefanha@gmail.com, philmd@linaro.org,
 clg@redhat.com, thanos.makatos@nutanix.com, levon@movementarian.org
Subject: [PATCH v3 1/1] vfio-user: introduce vfio-user protocol specification
Date: Thu, 29 Jun 2023 15:35:48 +0000
Message-Id: <c55f5ea0290763724bca1677314f8e2218785743.1688051596.git.jag.raman@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1688051596.git.jag.raman@oracle.com>
References: <cover.1688051596.git.jag.raman@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0071.namprd05.prod.outlook.com
 (2603:10b6:a03:74::48) To MN2PR10MB4013.namprd10.prod.outlook.com
 (2603:10b6:208:185::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4013:EE_|IA1PR10MB7214:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b8ea5c4-a0bf-410b-b8cc-08db78b68888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iWc2FAWtBFWHmT7hpWJ106EhGacShWBQDI6pWtgzKuitZu4Inyi4UlrBvnGikRp9ZmECGstmjkTHSmqaNyYfPnn6aP2Vb9JtKq/3clEUjAXQvHBv+LRMe9UZm5DBYBRdhAv7Q37wPltMPVvgyhr0jUgKThz8NTJ+nynOyh2xeYt5ZOz/UB6a07jJsSBT/km5HZCuTy9catMgvCynzfK0BFq3jhoSqJrUseEoI0UVzvIyMfzlJKj68uBGX/TfYUbZasfpH2+TptJgexBDDpsTBoUvQ/+Nf/LWYArm3upIo0I3DOK7ivw0pin+RnyYD6aKiuSAQUkVJTDMBi9plnvHTeOcH+LtU4Sl5Z0fl5gH5E334OAlkw2CO4x6DvHn8DvzRexfUjp1d83a+IkgbmJHPi5qXlrre7pwjdWUkrlrf9/V4YtHoYUP2JERPwwaelFrh92ebx9o+mFV0cFAfAWqZ0gThGkF6CosiT7/5SPexKxy2q/jAt0lA/Y+59y4L0d/4/qdY2XfETxvNCfLoNIcgOUarfV8/cZW6FV90zSl0+jVpZLRyQC0cc4QKvJTsd7wx/cwT5RDIAPR4A57JJw/pA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR10MB4013.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199021)(66556008)(86362001)(30864003)(6916009)(36756003)(5660300002)(66476007)(8676002)(316002)(8936002)(66946007)(38100700002)(4326008)(41300700001)(966005)(2906002)(478600001)(6506007)(26005)(6512007)(186003)(6486002)(83380400001)(2616005)(6666004)(579004)(559001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7QVuh2O/ZUPBQohbtBR1Es7hh3GH4ghz+uk8DbZmCj0S4ulopOowTcL7hzkh?=
 =?us-ascii?Q?3rsXUKDdHPtev4PRRoUmB0OZp74SwjdcjvEAj26ucqyMUTLr7P1Q/WpGrUqm?=
 =?us-ascii?Q?lmAEqEcodgsn37VzOhCJASdsKVxSUjpUDyExxIyRzFNPITSJhbSsuWP58Vt0?=
 =?us-ascii?Q?prGj9Nt+4krw9wPaqZUZhiFXWDVd466dGV/CJjM1McNYIx+/KwnZ9svRZ+g3?=
 =?us-ascii?Q?S9oRQ0GquP7q/EYbD1x3uZmTCXjTHCq7gwswKm9QHJPCwF016td8iM7ez1zA?=
 =?us-ascii?Q?gwk92qDLsqBuuny1kZRTs3nPyOx45sDBpXBcncZempEpFltTPlkMYhhd0rVf?=
 =?us-ascii?Q?TcGYQL5Mg5O+w4gtN0ubLhN+mgjXQi01loKNqWvzyQqtEFK4Gd7Q1+r2r+zi?=
 =?us-ascii?Q?rC6Ciy98lU60U/WXvKlr5b0xJ/0m2wOCBMKLLtDY1XlXS+cmKO1BfG7BhDOH?=
 =?us-ascii?Q?JDU9PxYxEgI3VR39b5d0vF/fFhAqYqXAzlgA2zIlo1x7S+Jqipk/yFcga3Uh?=
 =?us-ascii?Q?1q3iAYMTkp4Gfn9A0pA0XiVHNZLXin2KKHtvr1N5mmMPkQBWW0AKiqSJ6jnN?=
 =?us-ascii?Q?apyLQP9CpfwUab3QvTHsgUWiwpUdsuZaoi49LNoWzTQljI/L0VhLtf+8o6Nz?=
 =?us-ascii?Q?Pa3KeYHn4TmSFjVhch3Y1Ry6UL4vsUkqnIfR96uEpiCLQRJGICWWmKzPf3Ei?=
 =?us-ascii?Q?UFqin7X4wOrn4WO0nOYT6zGOzJCjX2pJ4/z3mMqeXkC5u21O5y7kX0c0Oj+b?=
 =?us-ascii?Q?8sjujGZafEy4JTvA06QG0KGVyZu9By3Sn7Byo15tglvCLItaPzvFWoDV4DSj?=
 =?us-ascii?Q?vwJk7jDohktv48ood5EiNomweeMOQr4bP2zFFokmbvtioG2CbrarJn1Zi6Ot?=
 =?us-ascii?Q?/ckfgLQ4OSLvS5T2Ur3xTOHrWvngsIjgSBDx7lojxUMKHA6YI3xClsRh00bP?=
 =?us-ascii?Q?huVnDhyv+GuoiyunQnVeyP0ep219VD/z+uBOuAVH5Lop0wsWAvEGRDzqUFRN?=
 =?us-ascii?Q?00aA1tMuuHtisgrwKCqDWYANRtRf98LQ9613r6vCLG3baEiQpykzV55PkiWn?=
 =?us-ascii?Q?rW0myXK2pzTvJ9kTNNDMSmnyIBlPThgxIxBumL+oaFoej4bqYik2LJAUYHKP?=
 =?us-ascii?Q?V6S/6PRQOdqvDKGeumdQqwRj5akHsLuJyT8PV2zUjqLfL6SRgby9xrLnKu9S?=
 =?us-ascii?Q?l0hTzAisGwNbP+RZQJWsrkispe2C356m3N5TbHDDQF5DAsZBXAI2Gctw2TzQ?=
 =?us-ascii?Q?dRzkWtn8k/+MXw/6sAdCtnmugVvvyKf2isKxzDL9jsiPniz5ZLN5YCfZUjk1?=
 =?us-ascii?Q?aaUYXCno1LWAuuPaCKCjUgzH5cFEe2nrOvHvtNRBb9YrwNhnBLMs5ULWum3R?=
 =?us-ascii?Q?T10xrDFrfY0GvFFmRQzzpf1TLMiOJWmRntX88BqnHKCeyvNxy/bTVRtic3Gg?=
 =?us-ascii?Q?y+5/hwhdNdjfP5zPxD+inpl+L35fGIVprymo9wUaYyXxcfYmAhsZn/7gt/Jv?=
 =?us-ascii?Q?F/qUoP+CXVkm9HUppBdM4Z4kZ3MMEGFXgdC6Y2hkPf4scRzV1aaEzFY/VHR6?=
 =?us-ascii?Q?H9MSHqpYTiiYTD+s7LR2GJ8yFpCuh91zhiM2CxIB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: En3anVMQFVze+PZ537FL+maD6I4oUCF/wNHTcBSesaomgaYyqZezdWLIh7VMFJn67k6JcUYomrD8apfizmH3hhG1kwZIpf4UEhc8k8mSr18CKzv+tBX2EglV669IAu3VugMF8iYJ5LiRYmH/itVDtG9/pVNo0k4jaynOsDXBrkDir4flzpqtjNei7+HTaEbAIPS8/rPCHVWhKO0HZXQX0dfKmppEbrug8q+CtQsRjzZoDxSYaJuEwilp9irdX9iW+BkRcHsZEh/Ku6DdZX10Pr9fnCMPWW6mhW9wNpwLnHDA/zRIaR+/VyqBmjEPHvP380BrXQl0MeveFdgPm/FSE0ai7EQI9DDS/jrkVF4nQqS9FpNY7kpBEi+mxnc+30CKaaMe0d6MRb0SJyC9dj63M3ctyA57zoGlbdv/yDhsIJ8edFUFaYZkum1tpWnq8lqfCcVPeejsl7fwqJBoPAxyFXD3wnHo0OZBNwOJkJDvrgIRi8BpeVm4AIIswiX+60ypallaUi+O3+/OWlfjTjOtXsyzgRJPh9otB+AOco+peryaH58JLoYzx0kt9zz9k7pzYhDGKQgPehg6h7WVYO9AFevZ4ZCQZuG2E1fycxpuRqPttmz/9zR2z7zPcB1XwR8kyDW49/MmfEIqy7QFqZZ00+vZryFJ67VXBW3KaalSuVUlxNwIwcdA4rNMYXvyCk5nMNhLuDNeE25PAJK9GoqyMep1KEN0t/GPyOYzN+gCGcc5K8Q8Qx396z2zRh5md+fdOgpFy3pBTQT1fCkuu5BbG/+uKD0pU6aOFffCh505MGXlDQrEo8OcLfEXkULHoPUkG+EsG81fiO95LNiEO493LqkfKIgg9Goq4aWzH+Ze1ryfoY1m7ZdLaKarTpLf7EadnpkQkagK3OjliVkRRtzKlLXsv3r0o79g7qV2Lm5GjZ8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8ea5c4-a0bf-410b-b8cc-08db78b68888
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4013.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 15:35:57.6377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vM4ZNhfCoMW9ks2AxY/05wrX3QT3Ejz5Jy3E9iZzJaonwMa1Ag2wWjs/WfkgmHqpkU9esma9T3VKig0O5Nj87Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_03,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290141
X-Proofpoint-ORIG-GUID: Wvzr5INWtwvbmFD0LG8dmR9oBofzvhm4
X-Proofpoint-GUID: Wvzr5INWtwvbmFD0LG8dmR9oBofzvhm4
Received-SPF: pass client-ip=205.220.165.32; envelope-from=jag.raman@oracle.com;
 helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

From: Thanos Makatos <thanos.makatos@nutanix.com>

This patch introduces the vfio-user protocol specification (formerly
known as VFIO-over-socket), which is designed to allow devices to be
emulated outside QEMU, in a separate process. vfio-user reuses the
existing VFIO defines, structs and concepts.

It has been earlier discussed as an RFC in:
"RFC: use VFIO over a UNIX domain socket to implement device offloading"

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 MAINTAINERS                    |    4 +-
 docs/devel/index-internals.rst |    1 +
 docs/devel/vfio-user.rst       | 1522 ++++++++++++++++++++++++++++++++
 3 files changed, 1526 insertions(+), 1 deletion(-)
 create mode 100644 docs/devel/vfio-user.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index aba07722f64f..70499379c7ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3791,11 +3791,13 @@ F: include/semihosting/
 F: tests/tcg/multiarch/arm-compat-semi/
 F: tests/tcg/aarch64/system/semiheap.c
 
-Multi-process QEMU
+Multi-process QEMU / vfio-user
 M: Elena Ufimtseva <elena.ufimtseva@oracle.com>
 M: Jagannathan Raman <jag.raman@oracle.com>
+M: Thanos Makatos <thanos.makatos@nutanix.com>
 S: Maintained
 F: docs/devel/multi-process.rst
+F: docs/devel/vfio-user.rst
 F: docs/system/multi-process.rst
 F: hw/pci-host/remote.c
 F: include/hw/pci-host/remote.h
diff --git a/docs/devel/index-internals.rst b/docs/devel/index-internals.rst
index e1a93df26392..0ecb5c6301d8 100644
--- a/docs/devel/index-internals.rst
+++ b/docs/devel/index-internals.rst
@@ -17,5 +17,6 @@ Details about QEMU's various subsystems including how to add features to them.
    s390-dasd-ipl
    tracing
    vfio-migration
+   vfio-user
    writing-monitor-commands
    virtio-backends
diff --git a/docs/devel/vfio-user.rst b/docs/devel/vfio-user.rst
new file mode 100644
index 000000000000..0d96477a68b4
--- /dev/null
+++ b/docs/devel/vfio-user.rst
@@ -0,0 +1,1522 @@
+.. include:: <isonum.txt>
+********************************
+vfio-user Protocol Specification
+********************************
+
+--------------
+Version_ 0.9.1
+--------------
+
+.. contents:: Table of Contents
+
+Introduction
+============
+vfio-user is a protocol that allows a device to be emulated in a separate
+process outside of a Virtual Machine Monitor (VMM). vfio-user devices consist
+of a generic VFIO device type, living inside the VMM, which we call the client,
+and the core device implementation, living outside the VMM, which we call the
+server.
+
+The vfio-user specification is partly based on the
+`Linux VFIO ioctl interface <https://www.kernel.org/doc/html/latest/driver-api/vfio.html>`_.
+
+VFIO is a mature and stable API, backed by an extensively used framework. The
+existing VFIO client implementation in QEMU (``qemu/hw/vfio/``) can be largely
+re-used, though there is nothing in this specification that requires that
+particular implementation. None of the VFIO kernel modules are required for
+supporting the protocol, on either the client or server side. Some source
+definitions in VFIO are re-used for vfio-user.
+
+The main idea is to allow a virtual device to function in a separate process in
+the same host over a UNIX domain socket. A UNIX domain socket (``AF_UNIX``) is
+chosen because file descriptors can be trivially sent over it, which in turn
+allows:
+
+* Sharing of client memory for DMA with the server.
+* Sharing of server memory with the client for fast MMIO.
+* Efficient sharing of eventfd's for triggering interrupts.
+
+Other socket types could be used which allow the server to run in a separate
+guest in the same host (``AF_VSOCK``) or remotely (``AF_INET``). Theoretically
+the underlying transport does not necessarily have to be a socket, however we do
+not examine such alternatives. In this protocol version we focus on using a UNIX
+domain socket and introduce basic support for the other two types of sockets
+without considering performance implications.
+
+While passing of file descriptors is desirable for performance reasons, support
+is not necessary for either the client or the server in order to implement the
+protocol. There is always an in-band, message-passing fall back mechanism.
+
+Overview
+========
+
+VFIO is a framework that allows a physical device to be securely passed through
+to a user space process; the device-specific kernel driver does not drive the
+device at all.  Typically, the user space process is a VMM and the device is
+passed through to it in order to achieve high performance. VFIO provides an API
+and the required functionality in the kernel. QEMU has adopted VFIO to allow a
+guest to directly access physical devices, instead of emulating them in
+software.
+
+vfio-user reuses the core VFIO concepts defined in its API, but implements them
+as messages to be sent over a socket. It does not change the kernel-based VFIO
+in any way, in fact none of the VFIO kernel modules need to be loaded to use
+vfio-user. It is also possible for the client to concurrently use the current
+kernel-based VFIO for one device, and vfio-user for another device.
+
+VFIO Device Model
+-----------------
+
+A device under VFIO presents a standard interface to the user process. Many of
+the VFIO operations in the existing interface use the ``ioctl()`` system call, and
+references to the existing interface are called the ``ioctl()`` implementation in
+this document.
+
+The following sections describe the set of messages that implement the vfio-user
+interface over a socket. In many cases, the messages are analogous to data
+structures used in the ``ioctl()`` implementation. Messages derived from the
+``ioctl()`` will have a name derived from the ``ioctl()`` command name.  E.g., the
+``VFIO_DEVICE_GET_INFO`` ``ioctl()`` command becomes a
+``VFIO_USER_DEVICE_GET_INFO`` message.  The purpose of this reuse is to share as
+much code as feasible with the ``ioctl()`` implementation``.
+
+Connection Initiation
+^^^^^^^^^^^^^^^^^^^^^
+
+After the client connects to the server, the initial client message is
+``VFIO_USER_VERSION`` to propose a protocol version and set of capabilities to
+apply to the session. The server replies with a compatible version and set of
+capabilities it supports, or closes the connection if it cannot support the
+advertised version.
+
+Device Information
+^^^^^^^^^^^^^^^^^^
+
+The client uses a ``VFIO_USER_DEVICE_GET_INFO`` message to query the server for
+information about the device. This information includes:
+
+* The device type and whether it supports reset (``VFIO_DEVICE_FLAGS_``),
+* the number of device regions, and
+* the device presents to the client the number of interrupt types the device
+  supports.
+
+Region Information
+^^^^^^^^^^^^^^^^^^
+
+The client uses ``VFIO_USER_DEVICE_GET_REGION_INFO`` messages to query the
+server for information about the device's regions. This information describes:
+
+* Read and write permissions, whether it can be memory mapped, and whether it
+  supports additional capabilities (``VFIO_REGION_INFO_CAP_``).
+* Region index, size, and offset.
+
+When a device region can be mapped by the client, the server provides a file
+descriptor which the client can ``mmap()``. The server is responsible for
+polling for client updates to memory mapped regions.
+
+Region Capabilities
+"""""""""""""""""""
+
+Some regions have additional capabilities that cannot be described adequately
+by the region info data structure. These capabilities are returned in the
+region info reply in a list similar to PCI capabilities in a PCI device's
+configuration space.
+
+Sparse Regions
+""""""""""""""
+A region can be memory-mappable in whole or in part. When only a subset of a
+region can be mapped by the client, a ``VFIO_REGION_INFO_CAP_SPARSE_MMAP``
+capability is included in the region info reply. This capability describes
+which portions can be mapped by the client.
+
+.. Note::
+   For example, in a virtual NVMe controller, sparse regions can be used so
+   that accesses to the NVMe registers (found in the beginning of BAR0) are
+   trapped (an infrequent event), while allowing direct access to the doorbells
+   (an extremely frequent event as every I/O submission requires a write to
+   BAR0), found in the next page after the NVMe registers in BAR0.
+
+Device-Specific Regions
+"""""""""""""""""""""""
+
+A device can define regions additional to the standard ones (e.g. PCI indexes
+0-8). This is achieved by including a ``VFIO_REGION_INFO_CAP_TYPE`` capability
+in the region info reply of a device-specific region. Such regions are reflected
+in ``struct vfio_user_device_info.num_regions``. Thus, for PCI devices this
+value can be equal to, or higher than, ``VFIO_PCI_NUM_REGIONS``.
+
+Region I/O via file descriptors
+-------------------------------
+
+For unmapped regions, region I/O from the client is done via
+``VFIO_USER_REGION_READ/WRITE``.  As an optimization, ioeventfds or ioregionfds
+may be configured for sub-regions of some regions. A client may request
+information on these sub-regions via ``VFIO_USER_DEVICE_GET_REGION_IO_FDS``; by
+configuring the returned file descriptors as ioeventfds or ioregionfds, the
+server can be directly notified of I/O (for example, by KVM) without taking a
+trip through the client.
+
+Interrupts
+^^^^^^^^^^
+
+The client uses ``VFIO_USER_DEVICE_GET_IRQ_INFO`` messages to query the server
+for the device's interrupt types. The interrupt types are specific to the bus
+the device is attached to, and the client is expected to know the capabilities
+of each interrupt type. The server can signal an interrupt by directly injecting
+interrupts into the guest via an event file descriptor. The client configures
+how the server signals an interrupt with ``VFIO_USER_SET_IRQS`` messages.
+
+Device Read and Write
+^^^^^^^^^^^^^^^^^^^^^
+
+When the guest executes load or store operations to an unmapped device region,
+the client forwards these operations to the server with
+``VFIO_USER_REGION_READ`` or ``VFIO_USER_REGION_WRITE`` messages. The server
+will reply with data from the device on read operations or an acknowledgement on
+write operations. See `Read and Write Operations`_.
+
+Client memory access
+--------------------
+
+The client uses ``VFIO_USER_DMA_MAP`` and ``VFIO_USER_DMA_UNMAP`` messages to
+inform the server of the valid DMA ranges that the server can access on behalf
+of a device (typically, VM guest memory). DMA memory may be accessed by the
+server via ``VFIO_USER_DMA_READ`` and ``VFIO_USER_DMA_WRITE`` messages over the
+socket. In this case, the "DMA" part of the naming is a misnomer.
+
+Actual direct memory access of client memory from the server is possible if the
+client provides file descriptors the server can ``mmap()``. Note that ``mmap()``
+privileges cannot be revoked by the client, therefore file descriptors should
+only be exported in environments where the client trusts the server not to
+corrupt guest memory.
+
+See `Read and Write Operations`_.
+
+Client/server interactions
+==========================
+
+Socket
+------
+
+A server can serve:
+
+1) one or more clients, and/or
+2) one or more virtual devices, belonging to one or more clients.
+
+The current protocol specification requires a dedicated socket per
+client/server connection. It is a server-side implementation detail whether a
+single server handles multiple virtual devices from the same or multiple
+clients. The location of the socket is implementation-specific. Multiplexing
+clients, devices, and servers over the same socket is not supported in this
+version of the protocol.
+
+Authentication
+--------------
+
+For ``AF_UNIX``, we rely on OS mandatory access controls on the socket files,
+therefore it is up to the management layer to set up the socket as required.
+Socket types that span guests or hosts will require a proper authentication
+mechanism. Defining that mechanism is deferred to a future version of the
+protocol.
+
+Command Concurrency
+-------------------
+
+A client may pipeline multiple commands without waiting for previous command
+replies.  The server will process commands in the order they are received.  A
+consequence of this is if a client issues a command with the *No_reply* bit,
+then subsequently issues a command without *No_reply*, the older command will
+have been processed before the reply to the younger command is sent by the
+server.  The client must be aware of the device's capability to process
+concurrent commands if pipelining is used.  For example, pipelining allows
+multiple client threads to concurrently access device regions; the client must
+ensure these accesses obey device semantics.
+
+An example is a frame buffer device, where the device may allow concurrent
+access to different areas of video memory, but may have indeterminate behavior
+if concurrent accesses are performed to command or status registers.
+
+Note that unrelated messages sent from the server to the client can appear in
+between a client to server request/reply and vice versa.
+
+Implementers should be prepared for certain commands to exhibit potentially
+unbounded latencies.  For example, ``VFIO_USER_DEVICE_RESET`` may take an
+arbitrarily long time to complete; clients should take care not to block
+unnecessarily.
+
+Socket Disconnection Behavior
+-----------------------------
+The server and the client can disconnect from each other, either intentionally
+or unexpectedly. Both the client and the server need to know how to handle such
+events.
+
+Server Disconnection
+^^^^^^^^^^^^^^^^^^^^
+A server disconnecting from the client may indicate that:
+
+1) A virtual device has been restarted, either intentionally (e.g. because of a
+   device update) or unintentionally (e.g. because of a crash).
+2) A virtual device has been shut down with no intention to be restarted.
+
+It is impossible for the client to know whether or not a failure is
+intermittent or innocuous and should be retried, therefore the client should
+reset the VFIO device when it detects the socket has been disconnected.
+Error recovery will be driven by the guest's device error handling
+behavior.
+
+Client Disconnection
+^^^^^^^^^^^^^^^^^^^^
+The client disconnecting from the server primarily means that the client
+has exited. Currently, this means that the guest is shut down so the device is
+no longer needed therefore the server can automatically exit. However, there
+can be cases where a client disconnection should not result in a server exit:
+
+1) A single server serving multiple clients.
+2) A multi-process QEMU upgrading itself step by step, which is not yet
+   implemented.
+
+Therefore in order for the protocol to be forward compatible, the server should
+respond to a client disconnection as follows:
+
+ - all client memory regions are unmapped and cleaned up (including closing any
+   passed file descriptors)
+ - all IRQ file descriptors passed from the old client are closed
+ - the device state should otherwise be retained
+
+The expectation is that when a client reconnects, it will re-establish IRQ and
+client memory mappings.
+
+If anything happens to the client (such as qemu really did exit), the control
+stack will know about it and can clean up resources accordingly.
+
+Security Considerations
+-----------------------
+
+Speaking generally, vfio-user clients should not trust servers, and vice versa.
+Standard tools and mechanisms should be used on both sides to validate input and
+prevent against denial of service scenarios, buffer overflow, etc.
+
+Request Retry and Response Timeout
+----------------------------------
+A failed command is a command that has been successfully sent and has been
+responded to with an error code. Failure to send the command in the first place
+(e.g. because the socket is disconnected) is a different type of error examined
+earlier in the disconnect section.
+
+.. Note::
+   QEMU's VFIO retries certain operations if they fail. While this makes sense
+   for real HW, we don't know for sure whether it makes sense for virtual
+   devices.
+
+Defining a retry and timeout scheme is deferred to a future version of the
+protocol.
+
+Message sizes
+-------------
+
+Some requests have an ``argsz`` field. In a request, it defines the maximum
+expected reply payload size, which should be at least the size of the fixed
+reply payload headers defined here. The *request* payload size is defined by the
+usual ``msg_size`` field in the header, not the ``argsz`` field.
+
+In a reply, the server sets ``argsz`` field to the size needed for a full
+payload size. This may be less than the requested maximum size. This may be
+larger than the requested maximum size: in that case, the full payload is not
+included in the reply, but the ``argsz`` field in the reply indicates the needed
+size, allowing a client to allocate a larger buffer for holding the reply before
+trying again.
+
+In addition, during negotiation (see  `Version`_), the client and server may
+each specify a ``max_data_xfer_size`` value; this defines the maximum data that
+may be read or written via one of the ``VFIO_USER_DMA/REGION_READ/WRITE``
+messages; see `Read and Write Operations`_.
+
+Protocol Specification
+======================
+
+To distinguish from the base VFIO symbols, all vfio-user symbols are prefixed
+with ``vfio_user`` or ``VFIO_USER``. In this revision, all data is in the
+endianness of the host system, although this may be relaxed in future
+revisions in cases where the client and server run on different hosts
+with different endianness.
+
+Unless otherwise specified, all sizes should be presumed to be in bytes.
+
+.. _Commands:
+
+Commands
+--------
+The following table lists the VFIO message command IDs, and whether the
+message command is sent from the client or the server.
+
+======================================  =========  =================
+Name                                    Command    Request Direction
+======================================  =========  =================
+``VFIO_USER_VERSION``                   1          client -> server
+``VFIO_USER_DMA_MAP``                   2          client -> server
+``VFIO_USER_DMA_UNMAP``                 3          client -> server
+``VFIO_USER_DEVICE_GET_INFO``           4          client -> server
+``VFIO_USER_DEVICE_GET_REGION_INFO``    5          client -> server
+``VFIO_USER_DEVICE_GET_REGION_IO_FDS``  6          client -> server
+``VFIO_USER_DEVICE_GET_IRQ_INFO``       7          client -> server
+``VFIO_USER_DEVICE_SET_IRQS``           8          client -> server
+``VFIO_USER_REGION_READ``               9          client -> server
+``VFIO_USER_REGION_WRITE``              10         client -> server
+``VFIO_USER_DMA_READ``                  11         server -> client
+``VFIO_USER_DMA_WRITE``                 12         server -> client
+``VFIO_USER_DEVICE_RESET``              13         client -> server
+``VFIO_USER_REGION_WRITE_MULTI``        15         client -> server
+======================================  =========  =================
+
+Header
+------
+
+All messages, both command messages and reply messages, are preceded by a
+16-byte header that contains basic information about the message. The header is
+followed by message-specific data described in the sections below.
+
++----------------+--------+-------------+
+| Name           | Offset | Size        |
++================+========+=============+
+| Message ID     | 0      | 2           |
++----------------+--------+-------------+
+| Command        | 2      | 2           |
++----------------+--------+-------------+
+| Message size   | 4      | 4           |
++----------------+--------+-------------+
+| Flags          | 8      | 4           |
++----------------+--------+-------------+
+|                | +-----+------------+ |
+|                | | Bit | Definition | |
+|                | +=====+============+ |
+|                | | 0-3 | Type       | |
+|                | +-----+------------+ |
+|                | | 4   | No_reply   | |
+|                | +-----+------------+ |
+|                | | 5   | Error      | |
+|                | +-----+------------+ |
++----------------+--------+-------------+
+| Error          | 12     | 4           |
++----------------+--------+-------------+
+| <message data> | 16     | variable    |
++----------------+--------+-------------+
+
+* *Message ID* identifies the message, and is echoed in the command's reply
+  message. Message IDs belong entirely to the sender, can be re-used (even
+  concurrently) and the receiver must not make any assumptions about their
+  uniqueness.
+* *Command* specifies the command to be executed, listed in Commands_. It is
+  also set in the reply header.
+* *Message size* contains the size of the entire message, including the header.
+* *Flags* contains attributes of the message:
+
+  * The *Type* bits indicate the message type.
+
+    *  *Command* (value 0x0) indicates a command message.
+    *  *Reply* (value 0x1) indicates a reply message acknowledging a previous
+       command with the same message ID.
+  * *No_reply* in a command message indicates that no reply is needed for this
+    command.  This is commonly used when multiple commands are sent, and only
+    the last needs acknowledgement.
+  * *Error* in a reply message indicates the command being acknowledged had
+    an error. In this case, the *Error* field will be valid.
+
+* *Error* in a reply message is an optional UNIX errno value. It may be zero
+  even if the Error bit is set in Flags. It is reserved in a command message.
+
+Each command message in Commands_ must be replied to with a reply message,
+unless the message sets the *No_Reply* bit.  The reply consists of the header
+with the *Reply* bit set, plus any additional data.
+
+If an error occurs, the reply message must only include the reply header.
+
+As the header is standard in both requests and replies, it is not included in
+the command-specific specifications below; each message definition should be
+appended to the standard header, and the offsets are given from the end of the
+standard header.
+
+``VFIO_USER_VERSION``
+---------------------
+
+.. _Version:
+
+This is the initial message sent by the client after the socket connection is
+established; the same format is used for the server's reply.
+
+Upon establishing a connection, the client must send a ``VFIO_USER_VERSION``
+message proposing a protocol version and a set of capabilities. The server
+compares these with the versions and capabilities it supports and sends a
+``VFIO_USER_VERSION`` reply according to the following rules.
+
+* The major version in the reply must be the same as proposed. If the client
+  does not support the proposed major, it closes the connection.
+* The minor version in the reply must be equal to or less than the minor
+  version proposed.
+* The capability list must be a subset of those proposed. If the server
+  requires a capability the client did not include, it closes the connection.
+
+The protocol major version will only change when incompatible protocol changes
+are made, such as changing the message format. The minor version may change
+when compatible changes are made, such as adding new messages or capabilities,
+Both the client and server must support all minor versions less than the
+maximum minor version it supports. E.g., an implementation that supports
+version 1.3 must also support 1.0 through 1.2.
+
+When making a change to this specification, the protocol version number must
+be included in the form "added in version X.Y"
+
+Request
+^^^^^^^
+
+==============  ======  ====
+Name            Offset  Size
+==============  ======  ====
+version major   0       2
+version minor   2       2
+version data    4       variable (including terminating NUL). Optional.
+==============  ======  ====
+
+The version data is an optional UTF-8 encoded JSON byte array with the following
+format:
+
++--------------+--------+-----------------------------------+
+| Name         | Type   | Description                       |
++==============+========+===================================+
+| capabilities | object | Contains common capabilities that |
+|              |        | the sender supports. Optional.    |
++--------------+--------+-----------------------------------+
+
+Capabilities:
+
++--------------------+---------+------------------------------------------------+
+| Name               | Type    | Description                                    |
++====================+=========+================================================+
+| max_msg_fds        | number  | Maximum number of file descriptors that can be |
+|                    |         | received by the sender in one message.         |
+|                    |         | Optional. If not specified then the receiver   |
+|                    |         | must assume a value of ``1``.                  |
++--------------------+---------+------------------------------------------------+
+| max_data_xfer_size | number  | Maximum ``count`` for data transfer messages;  |
+|                    |         | see `Read and Write Operations`_. Optional,    |
+|                    |         | with a default value of 1048576 bytes.         |
++--------------------+---------+------------------------------------------------+
+| pgsizes            | number  | Page sizes supported in DMA map operations     |
+|                    |         | or'ed together. Optional, with a default value |
+|                    |         | of supporting only 4k pages.                   |
++--------------------+---------+------------------------------------------------+
+| max_dma_maps       | number  | Maximum number DMA map windows that can be     |
+|                    |         | valid simultaneously.  Optional, with a        |
+|                    |         | value of 65535 (64k-1).                        |
++--------------------+---------+------------------------------------------------+
+| migration          | object  | Migration capability parameters. If missing    |
+|                    |         | then migration is not supported by the sender. |
++--------------------+---------+------------------------------------------------+
+| write_multiple     | boolean | ``VFIO_USER_REGION_WRITE_MULTI`` messages      |
+|                    |         | are supported if the value is ``true``.        |
++--------------------+---------+------------------------------------------------+
+
+The migration capability contains the following name/value pairs:
+
++-----------------+--------+--------------------------------------------------+
+| Name            | Type   | Description                                      |
++=================+========+==================================================+
+| pgsize          | number | Page size of dirty pages bitmap. The smallest    |
+|                 |        | between the client and the server is used.       |
++-----------------+--------+--------------------------------------------------+
+| max_bitmap_size | number | Maximum bitmap size in ``VFIO_USER_DIRTY_PAGES`` |
+|                 |        | and ``VFIO_DMA_UNMAP`` messages.  Optional,      |
+|                 |        | with a default value of 256MB.                   |
++-----------------+--------+--------------------------------------------------+
+
+Reply
+^^^^^
+
+The same message format is used in the server's reply with the semantics
+described above.
+
+``VFIO_USER_DMA_MAP``
+---------------------
+
+This command message is sent by the client to the server to inform it of the
+memory regions the server can access. It must be sent before the server can
+perform any DMA to the client. It is normally sent directly after the version
+handshake is completed, but may also occur when memory is added to the client,
+or if the client uses a vIOMMU.
+
+Request
+^^^^^^^
+
+The request payload for this message is a structure of the following format:
+
++-------------+--------+-------------+
+| Name        | Offset | Size        |
++=============+========+=============+
+| argsz       | 0      | 4           |
++-------------+--------+-------------+
+| flags       | 4      | 4           |
++-------------+--------+-------------+
+|             | +-----+------------+ |
+|             | | Bit | Definition | |
+|             | +=====+============+ |
+|             | | 0   | readable   | |
+|             | +-----+------------+ |
+|             | | 1   | writeable  | |
+|             | +-----+------------+ |
++-------------+--------+-------------+
+| offset      | 8      | 8           |
++-------------+--------+-------------+
+| address     | 16     | 8           |
++-------------+--------+-------------+
+| size        | 24     | 8           |
++-------------+--------+-------------+
+
+* *argsz* is the size of the above structure. Note there is no reply payload,
+  so this field differs from other message types.
+* *flags* contains the following region attributes:
+
+  * *readable* indicates that the region can be read from.
+
+  * *writeable* indicates that the region can be written to.
+
+* *offset* is the file offset of the region with respect to the associated file
+  descriptor, or zero if the region is not mappable
+* *address* is the base DMA address of the region.
+* *size* is the size of the region.
+
+This structure is 32 bytes in size, so the message size is 16 + 32 bytes.
+
+If the DMA region being added can be directly mapped by the server, a file
+descriptor must be sent as part of the message meta-data. The region can be
+mapped via the mmap() system call. On ``AF_UNIX`` sockets, the file descriptor
+must be passed as ``SCM_RIGHTS`` type ancillary data.  Otherwise, if the DMA
+region cannot be directly mapped by the server, no file descriptor must be sent
+as part of the message meta-data and the DMA region can be accessed by the
+server using ``VFIO_USER_DMA_READ`` and ``VFIO_USER_DMA_WRITE`` messages,
+explained in `Read and Write Operations`_. A command to map over an existing
+region must be failed by the server with ``EEXIST`` set in error field in the
+reply.
+
+Reply
+^^^^^
+
+There is no payload in the reply message.
+
+``VFIO_USER_DMA_UNMAP``
+-----------------------
+
+This command message is sent by the client to the server to inform it that a
+DMA region, previously made available via a ``VFIO_USER_DMA_MAP`` command
+message, is no longer available for DMA. It typically occurs when memory is
+subtracted from the client or if the client uses a vIOMMU. The DMA region is
+described by the following structure:
+
+Request
+^^^^^^^
+
+The request payload for this message is a structure of the following format:
+
++--------------+--------+------------------------+
+| Name         | Offset | Size                   |
++==============+========+========================+
+| argsz        | 0      | 4                      |
++--------------+--------+------------------------+
+| flags        | 4      | 4                      |
++--------------+--------+------------------------+
+| address      | 8      | 8                      |
++--------------+--------+------------------------+
+| size         | 16     | 8                      |
++--------------+--------+------------------------+
+
+* *argsz* is the maximum size of the reply payload.
+* *flags* is unused in this version.
+* *address* is the base DMA address of the DMA region.
+* *size* is the size of the DMA region.
+
+The address and size of the DMA region being unmapped must match exactly a
+previous mapping.
+
+Reply
+^^^^^
+
+Upon receiving a ``VFIO_USER_DMA_UNMAP`` command, if the file descriptor is
+mapped then the server must release all references to that DMA region before
+replying, which potentially includes in-flight DMA transactions.
+
+The server responds with the original DMA entry in the request.
+
+
+``VFIO_USER_DEVICE_GET_INFO``
+-----------------------------
+
+This command message is sent by the client to the server to query for basic
+information about the device.
+
+Request
+^^^^^^^
+
++-------------+--------+--------------------------+
+| Name        | Offset | Size                     |
++=============+========+==========================+
+| argsz       | 0      | 4                        |
++-------------+--------+--------------------------+
+| flags       | 4      | 4                        |
++-------------+--------+--------------------------+
+|             | +-----+-------------------------+ |
+|             | | Bit | Definition              | |
+|             | +=====+=========================+ |
+|             | | 0   | VFIO_DEVICE_FLAGS_RESET | |
+|             | +-----+-------------------------+ |
+|             | | 1   | VFIO_DEVICE_FLAGS_PCI   | |
+|             | +-----+-------------------------+ |
++-------------+--------+--------------------------+
+| num_regions | 8      | 4                        |
++-------------+--------+--------------------------+
+| num_irqs    | 12     | 4                        |
++-------------+--------+--------------------------+
+
+* *argsz* is the maximum size of the reply payload
+* all other fields must be zero.
+
+Reply
+^^^^^
+
++-------------+--------+--------------------------+
+| Name        | Offset | Size                     |
++=============+========+==========================+
+| argsz       | 0      | 4                        |
++-------------+--------+--------------------------+
+| flags       | 4      | 4                        |
++-------------+--------+--------------------------+
+|             | +-----+-------------------------+ |
+|             | | Bit | Definition              | |
+|             | +=====+=========================+ |
+|             | | 0   | VFIO_DEVICE_FLAGS_RESET | |
+|             | +-----+-------------------------+ |
+|             | | 1   | VFIO_DEVICE_FLAGS_PCI   | |
+|             | +-----+-------------------------+ |
++-------------+--------+--------------------------+
+| num_regions | 8      | 4                        |
++-------------+--------+--------------------------+
+| num_irqs    | 12     | 4                        |
++-------------+--------+--------------------------+
+
+* *argsz* is the size required for the full reply payload (16 bytes today)
+* *flags* contains the following device attributes.
+
+  * ``VFIO_DEVICE_FLAGS_RESET`` indicates that the device supports the
+    ``VFIO_USER_DEVICE_RESET`` message.
+  * ``VFIO_DEVICE_FLAGS_PCI`` indicates that the device is a PCI device.
+
+* *num_regions* is the number of memory regions that the device exposes.
+* *num_irqs* is the number of distinct interrupt types that the device supports.
+
+This version of the protocol only supports PCI devices. Additional devices may
+be supported in future versions.
+
+``VFIO_USER_DEVICE_GET_REGION_INFO``
+------------------------------------
+
+This command message is sent by the client to the server to query for
+information about device regions. The VFIO region info structure is defined in
+``<linux/vfio.h>`` (``struct vfio_region_info``).
+
+Request
+^^^^^^^
+
++------------+--------+------------------------------+
+| Name       | Offset | Size                         |
++============+========+==============================+
+| argsz      | 0      | 4                            |
++------------+--------+------------------------------+
+| flags      | 4      | 4                            |
++------------+--------+------------------------------+
+| index      | 8      | 4                            |
++------------+--------+------------------------------+
+| cap_offset | 12     | 4                            |
++------------+--------+------------------------------+
+| size       | 16     | 8                            |
++------------+--------+------------------------------+
+| offset     | 24     | 8                            |
++------------+--------+------------------------------+
+
+* *argsz* the maximum size of the reply payload
+* *index* is the index of memory region being queried, it is the only field
+  that is required to be set in the command message.
+* all other fields must be zero.
+
+Reply
+^^^^^
+
++------------+--------+------------------------------+
+| Name       | Offset | Size                         |
++============+========+==============================+
+| argsz      | 0      | 4                            |
++------------+--------+------------------------------+
+| flags      | 4      | 4                            |
++------------+--------+------------------------------+
+|            | +-----+-----------------------------+ |
+|            | | Bit | Definition                  | |
+|            | +=====+=============================+ |
+|            | | 0   | VFIO_REGION_INFO_FLAG_READ  | |
+|            | +-----+-----------------------------+ |
+|            | | 1   | VFIO_REGION_INFO_FLAG_WRITE | |
+|            | +-----+-----------------------------+ |
+|            | | 2   | VFIO_REGION_INFO_FLAG_MMAP  | |
+|            | +-----+-----------------------------+ |
+|            | | 3   | VFIO_REGION_INFO_FLAG_CAPS  | |
+|            | +-----+-----------------------------+ |
++------------+--------+------------------------------+
++------------+--------+------------------------------+
+| index      | 8      | 4                            |
++------------+--------+------------------------------+
+| cap_offset | 12     | 4                            |
++------------+--------+------------------------------+
+| size       | 16     | 8                            |
++------------+--------+------------------------------+
+| offset     | 24     | 8                            |
++------------+--------+------------------------------+
+
+* *argsz* is the size required for the full reply payload (region info structure
+  plus the size of any region capabilities)
+* *flags* are attributes of the region:
+
+  * ``VFIO_REGION_INFO_FLAG_READ`` allows client read access to the region.
+  * ``VFIO_REGION_INFO_FLAG_WRITE`` allows client write access to the region.
+  * ``VFIO_REGION_INFO_FLAG_MMAP`` specifies the client can mmap() the region.
+    When this flag is set, the reply will include a file descriptor in its
+    meta-data. On ``AF_UNIX`` sockets, the file descriptors will be passed as
+    ``SCM_RIGHTS`` type ancillary data.
+  * ``VFIO_REGION_INFO_FLAG_CAPS`` indicates additional capabilities found in the
+    reply.
+
+* *index* is the index of memory region being queried, it is the only field
+  that is required to be set in the command message.
+* *cap_offset* describes where additional region capabilities can be found.
+  cap_offset is relative to the beginning of the VFIO region info structure.
+  The data structure it points is a VFIO cap header defined in
+  ``<linux/vfio.h>``.
+* *size* is the size of the region.
+* *offset* is the offset that should be given to the mmap() system call for
+  regions with the MMAP attribute. It is also used as the base offset when
+  mapping a VFIO sparse mmap area, described below.
+
+VFIO region capabilities
+""""""""""""""""""""""""
+
+The VFIO region information can also include a capabilities list. This list is
+similar to a PCI capability list - each entry has a common header that
+identifies a capability and where the next capability in the list can be found.
+The VFIO capability header format is defined in ``<linux/vfio.h>`` (``struct
+vfio_info_cap_header``).
+
+VFIO cap header format
+""""""""""""""""""""""
+
++---------+--------+------+
+| Name    | Offset | Size |
++=========+========+======+
+| id      | 0      | 2    |
++---------+--------+------+
+| version | 2      | 2    |
++---------+--------+------+
+| next    | 4      | 4    |
++---------+--------+------+
+
+* *id* is the capability identity.
+* *version* is a capability-specific version number.
+* *next* specifies the offset of the next capability in the capability list. It
+  is relative to the beginning of the VFIO region info structure.
+
+VFIO sparse mmap cap header
+"""""""""""""""""""""""""""
+
++------------------+----------------------------------+
+| Name             | Value                            |
++==================+==================================+
+| id               | VFIO_REGION_INFO_CAP_SPARSE_MMAP |
++------------------+----------------------------------+
+| version          | 0x1                              |
++------------------+----------------------------------+
+| next             | <next>                           |
++------------------+----------------------------------+
+| sparse mmap info | VFIO region info sparse mmap     |
++------------------+----------------------------------+
+
+This capability is defined when only a subrange of the region supports
+direct access by the client via mmap(). The VFIO sparse mmap area is defined in
+``<linux/vfio.h>`` (``struct vfio_region_sparse_mmap_area`` and ``struct
+vfio_region_info_cap_sparse_mmap``).
+
+VFIO region info cap sparse mmap
+""""""""""""""""""""""""""""""""
+
++----------+--------+------+
+| Name     | Offset | Size |
++==========+========+======+
+| nr_areas | 0      | 4    |
++----------+--------+------+
+| reserved | 4      | 4    |
++----------+--------+------+
+| offset   | 8      | 8    |
++----------+--------+------+
+| size     | 16     | 8    |
++----------+--------+------+
+| ...      |        |      |
++----------+--------+------+
+
+* *nr_areas* is the number of sparse mmap areas in the region.
+* *offset* and size describe a single area that can be mapped by the client.
+  There will be *nr_areas* pairs of offset and size. The offset will be added to
+  the base offset given in the ``VFIO_USER_DEVICE_GET_REGION_INFO`` to form the
+  offset argument of the subsequent mmap() call.
+
+The VFIO sparse mmap area is defined in ``<linux/vfio.h>`` (``struct
+vfio_region_info_cap_sparse_mmap``).
+
+
+``VFIO_USER_DEVICE_GET_REGION_IO_FDS``
+--------------------------------------
+
+Clients can access regions via ``VFIO_USER_REGION_READ/WRITE`` or, if provided, by
+``mmap()`` of a file descriptor provided by the server.
+
+``VFIO_USER_DEVICE_GET_REGION_IO_FDS`` provides an alternative access mechanism via
+file descriptors. This is an optional feature intended for performance
+improvements where an underlying sub-system (such as KVM) supports communication
+across such file descriptors to the vfio-user server, without needing to
+round-trip through the client.
+
+The server returns an array of sub-regions for the requested region. Each
+sub-region describes a span (offset and size) of a region, along with the
+requested file descriptor notification mechanism to use.  Each sub-region in the
+response message may choose to use a different method, as defined below.  The
+two mechanisms supported in this specification are ioeventfds and ioregionfds.
+
+The server in addition returns a file descriptor in the ancillary data; clients
+are expected to configure each sub-region's file descriptor with the requested
+notification method. For example, a client could configure KVM with the
+requested ioeventfd via a ``KVM_IOEVENTFD`` ``ioctl()``.
+
+Request
+^^^^^^^
+
++-------------+--------+------+
+| Name        | Offset | Size |
++=============+========+======+
+| argsz       | 0      | 4    |
++-------------+--------+------+
+| flags       | 4      | 4    |
++-------------+--------+------+
+| index       | 8      | 4    |
++-------------+--------+------+
+| count       | 12     | 4    |
++-------------+--------+------+
+
+* *argsz* the maximum size of the reply payload
+* *index* is the index of memory region being queried
+* all other fields must be zero
+
+The client must set ``flags`` to zero and specify the region being queried in
+the ``index``.
+
+Reply
+^^^^^
+
++-------------+--------+------+
+| Name        | Offset | Size |
++=============+========+======+
+| argsz       | 0      | 4    |
++-------------+--------+------+
+| flags       | 4      | 4    |
++-------------+--------+------+
+| index       | 8      | 4    |
++-------------+--------+------+
+| count       | 12     | 4    |
++-------------+--------+------+
+| sub-regions | 16     | ...  |
++-------------+--------+------+
+
+* *argsz* is the size of the region IO FD info structure plus the
+  total size of the sub-region array. Thus, each array entry "i" is at offset
+  i * ((argsz - 32) / count). Note that currently this is 40 bytes for both IO
+  FD types, but this is not to be relied on. As elsewhere, this indicates the
+  full reply payload size needed.
+* *flags* must be zero
+* *index* is the index of memory region being queried
+* *count* is the number of sub-regions in the array
+* *sub-regions* is the array of Sub-Region IO FD info structures
+
+The reply message will additionally include at least one file descriptor in the
+ancillary data. Note that more than one sub-region may share the same file
+descriptor.
+
+Note that it is the client's responsibility to verify the requested values (for
+example, that the requested offset does not exceed the region's bounds).
+
+Each sub-region given in the response has one of two possible structures,
+depending whether *type* is ``VFIO_USER_IO_FD_TYPE_IOEVENTFD`` or
+``VFIO_USER_IO_FD_TYPE_IOREGIONFD``:
+
+Sub-Region IO FD info format (ioeventfd)
+""""""""""""""""""""""""""""""""""""""""
+
++-----------+--------+------+
+| Name      | Offset | Size |
++===========+========+======+
+| offset    | 0      | 8    |
++-----------+--------+------+
+| size      | 8      | 8    |
++-----------+--------+------+
+| fd_index  | 16     | 4    |
++-----------+--------+------+
+| type      | 20     | 4    |
++-----------+--------+------+
+| flags     | 24     | 4    |
++-----------+--------+------+
+| padding   | 28     | 4    |
++-----------+--------+------+
+| datamatch | 32     | 8    |
++-----------+--------+------+
+
+* *offset* is the offset of the start of the sub-region within the region
+  requested ("physical address offset" for the region)
+* *size* is the length of the sub-region. This may be zero if the access size is
+  not relevant, which may allow for optimizations
+* *fd_index* is the index in the ancillary data of the FD to use for ioeventfd
+  notification; it may be shared.
+* *type* is ``VFIO_USER_IO_FD_TYPE_IOEVENTFD``
+* *flags* is any of:
+
+  * ``KVM_IOEVENTFD_FLAG_DATAMATCH``
+  * ``KVM_IOEVENTFD_FLAG_PIO``
+  * ``KVM_IOEVENTFD_FLAG_VIRTIO_CCW_NOTIFY`` (FIXME: makes sense?)
+
+* *datamatch* is the datamatch value if needed
+
+See https://www.kernel.org/doc/Documentation/virtual/kvm/api.txt, *4.59
+KVM_IOEVENTFD* for further context on the ioeventfd-specific fields.
+
+Sub-Region IO FD info format (ioregionfd)
+"""""""""""""""""""""""""""""""""""""""""
+
++-----------+--------+------+
+| Name      | Offset | Size |
++===========+========+======+
+| offset    | 0      | 8    |
++-----------+--------+------+
+| size      | 8      | 8    |
++-----------+--------+------+
+| fd_index  | 16     | 4    |
++-----------+--------+------+
+| type      | 20     | 4    |
++-----------+--------+------+
+| flags     | 24     | 4    |
++-----------+--------+------+
+| padding   | 28     | 4    |
++-----------+--------+------+
+| user_data | 32     | 8    |
++-----------+--------+------+
+
+* *offset* is the offset of the start of the sub-region within the region
+  requested ("physical address offset" for the region)
+* *size* is the length of the sub-region. This may be zero if the access size is
+  not relevant, which may allow for optimizations; ``KVM_IOREGION_POSTED_WRITES``
+  must be set in *flags* in this case
+* *fd_index* is the index in the ancillary data of the FD to use for ioregionfd
+  messages; it may be shared
+* *type* is ``VFIO_USER_IO_FD_TYPE_IOREGIONFD``
+* *flags* is any of:
+
+  * ``KVM_IOREGION_PIO``
+  * ``KVM_IOREGION_POSTED_WRITES``
+
+* *user_data* is an opaque value passed back to the server via a message on the
+  file descriptor
+
+For further information on the ioregionfd-specific fields, see:
+https://lore.kernel.org/kvm/cover.1613828726.git.eafanasova@gmail.com/
+
+(FIXME: update with final API docs.)
+
+``VFIO_USER_DEVICE_GET_IRQ_INFO``
+---------------------------------
+
+This command message is sent by the client to the server to query for
+information about device interrupt types. The VFIO IRQ info structure is
+defined in ``<linux/vfio.h>`` (``struct vfio_irq_info``).
+
+Request
+^^^^^^^
+
++-------+--------+---------------------------+
+| Name  | Offset | Size                      |
++=======+========+===========================+
+| argsz | 0      | 4                         |
++-------+--------+---------------------------+
+| flags | 4      | 4                         |
++-------+--------+---------------------------+
+|       | +-----+--------------------------+ |
+|       | | Bit | Definition               | |
+|       | +=====+==========================+ |
+|       | | 0   | VFIO_IRQ_INFO_EVENTFD    | |
+|       | +-----+--------------------------+ |
+|       | | 1   | VFIO_IRQ_INFO_MASKABLE   | |
+|       | +-----+--------------------------+ |
+|       | | 2   | VFIO_IRQ_INFO_AUTOMASKED | |
+|       | +-----+--------------------------+ |
+|       | | 3   | VFIO_IRQ_INFO_NORESIZE   | |
+|       | +-----+--------------------------+ |
++-------+--------+---------------------------+
+| index | 8      | 4                         |
++-------+--------+---------------------------+
+| count | 12     | 4                         |
++-------+--------+---------------------------+
+
+* *argsz* is the maximum size of the reply payload (16 bytes today)
+* index is the index of IRQ type being queried (e.g. ``VFIO_PCI_MSIX_IRQ_INDEX``)
+* all other fields must be zero
+
+Reply
+^^^^^
+
++-------+--------+---------------------------+
+| Name  | Offset | Size                      |
++=======+========+===========================+
+| argsz | 0      | 4                         |
++-------+--------+---------------------------+
+| flags | 4      | 4                         |
++-------+--------+---------------------------+
+|       | +-----+--------------------------+ |
+|       | | Bit | Definition               | |
+|       | +=====+==========================+ |
+|       | | 0   | VFIO_IRQ_INFO_EVENTFD    | |
+|       | +-----+--------------------------+ |
+|       | | 1   | VFIO_IRQ_INFO_MASKABLE   | |
+|       | +-----+--------------------------+ |
+|       | | 2   | VFIO_IRQ_INFO_AUTOMASKED | |
+|       | +-----+--------------------------+ |
+|       | | 3   | VFIO_IRQ_INFO_NORESIZE   | |
+|       | +-----+--------------------------+ |
++-------+--------+---------------------------+
+| index | 8      | 4                         |
++-------+--------+---------------------------+
+| count | 12     | 4                         |
++-------+--------+---------------------------+
+
+* *argsz* is the size required for the full reply payload (16 bytes today)
+* *flags* defines IRQ attributes:
+
+  * ``VFIO_IRQ_INFO_EVENTFD`` indicates the IRQ type can support server eventfd
+    signalling.
+  * ``VFIO_IRQ_INFO_MASKABLE`` indicates that the IRQ type supports the ``MASK``
+    and ``UNMASK`` actions in a ``VFIO_USER_DEVICE_SET_IRQS`` message.
+  * ``VFIO_IRQ_INFO_AUTOMASKED`` indicates the IRQ type masks itself after being
+    triggered, and the client must send an ``UNMASK`` action to receive new
+    interrupts.
+  * ``VFIO_IRQ_INFO_NORESIZE`` indicates ``VFIO_USER_SET_IRQS`` operations setup
+    interrupts as a set, and new sub-indexes cannot be enabled without disabling
+    the entire type.
+* index is the index of IRQ type being queried
+* count describes the number of interrupts of the queried type.
+
+``VFIO_USER_DEVICE_SET_IRQS``
+-----------------------------
+
+This command message is sent by the client to the server to set actions for
+device interrupt types. The VFIO IRQ set structure is defined in
+``<linux/vfio.h>`` (``struct vfio_irq_set``).
+
+Request
+^^^^^^^
+
++-------+--------+------------------------------+
+| Name  | Offset | Size                         |
++=======+========+==============================+
+| argsz | 0      | 4                            |
++-------+--------+------------------------------+
+| flags | 4      | 4                            |
++-------+--------+------------------------------+
+|       | +-----+-----------------------------+ |
+|       | | Bit | Definition                  | |
+|       | +=====+=============================+ |
+|       | | 0   | VFIO_IRQ_SET_DATA_NONE      | |
+|       | +-----+-----------------------------+ |
+|       | | 1   | VFIO_IRQ_SET_DATA_BOOL      | |
+|       | +-----+-----------------------------+ |
+|       | | 2   | VFIO_IRQ_SET_DATA_EVENTFD   | |
+|       | +-----+-----------------------------+ |
+|       | | 3   | VFIO_IRQ_SET_ACTION_MASK    | |
+|       | +-----+-----------------------------+ |
+|       | | 4   | VFIO_IRQ_SET_ACTION_UNMASK  | |
+|       | +-----+-----------------------------+ |
+|       | | 5   | VFIO_IRQ_SET_ACTION_TRIGGER | |
+|       | +-----+-----------------------------+ |
++-------+--------+------------------------------+
+| index | 8      | 4                            |
++-------+--------+------------------------------+
+| start | 12     | 4                            |
++-------+--------+------------------------------+
+| count | 16     | 4                            |
++-------+--------+------------------------------+
+| data  | 20     | variable                     |
++-------+--------+------------------------------+
+
+* *argsz* is the size of the VFIO IRQ set request payload, including any *data*
+  field. Note there is no reply payload, so this field differs from other
+  message types.
+* *flags* defines the action performed on the interrupt range. The ``DATA``
+  flags describe the data field sent in the message; the ``ACTION`` flags
+  describe the action to be performed. The flags are mutually exclusive for
+  both sets.
+
+  * ``VFIO_IRQ_SET_DATA_NONE`` indicates there is no data field in the command.
+    The action is performed unconditionally.
+  * ``VFIO_IRQ_SET_DATA_BOOL`` indicates the data field is an array of boolean
+    bytes. The action is performed if the corresponding boolean is true.
+  * ``VFIO_IRQ_SET_DATA_EVENTFD`` indicates an array of event file descriptors
+    was sent in the message meta-data. These descriptors will be signalled when
+    the action defined by the action flags occurs. In ``AF_UNIX`` sockets, the
+    descriptors are sent as ``SCM_RIGHTS`` type ancillary data.
+    If no file descriptors are provided, this de-assigns the specified
+    previously configured interrupts.
+  * ``VFIO_IRQ_SET_ACTION_MASK`` indicates a masking event. It can be used with
+    ``VFIO_IRQ_SET_DATA_BOOL`` or ``VFIO_IRQ_SET_DATA_NONE`` to mask an interrupt,
+    or with ``VFIO_IRQ_SET_DATA_EVENTFD`` to generate an event when the guest masks
+    the interrupt.
+  * ``VFIO_IRQ_SET_ACTION_UNMASK`` indicates an unmasking event. It can be used
+    with ``VFIO_IRQ_SET_DATA_BOOL`` or ``VFIO_IRQ_SET_DATA_NONE`` to unmask an
+    interrupt, or with ``VFIO_IRQ_SET_DATA_EVENTFD`` to generate an event when the
+    guest unmasks the interrupt.
+  * ``VFIO_IRQ_SET_ACTION_TRIGGER`` indicates a triggering event. It can be used
+    with ``VFIO_IRQ_SET_DATA_BOOL`` or ``VFIO_IRQ_SET_DATA_NONE`` to trigger an
+    interrupt, or with ``VFIO_IRQ_SET_DATA_EVENTFD`` to generate an event when the
+    server triggers the interrupt.
+
+* *index* is the index of IRQ type being setup.
+* *start* is the start of the sub-index being set.
+* *count* describes the number of sub-indexes being set. As a special case, a
+  count (and start) of 0, with data flags of ``VFIO_IRQ_SET_DATA_NONE`` disables
+  all interrupts of the index.
+* *data* is an optional field included when the
+  ``VFIO_IRQ_SET_DATA_BOOL`` flag is present. It contains an array of booleans
+  that specify whether the action is to be performed on the corresponding
+  index. It's used when the action is only performed on a subset of the range
+  specified.
+
+Not all interrupt types support every combination of data and action flags.
+The client must know the capabilities of the device and IRQ index before it
+sends a ``VFIO_USER_DEVICE_SET_IRQ`` message.
+
+In typical operation, a specific IRQ may operate as follows:
+
+1. The client sends a ``VFIO_USER_DEVICE_SET_IRQ`` message with
+   ``flags=(VFIO_IRQ_SET_DATA_EVENTFD|VFIO_IRQ_SET_ACTION_TRIGGER)`` along
+   with an eventfd. This associates the IRQ with a particular eventfd on the
+   server side.
+
+#. The client may send a ``VFIO_USER_DEVICE_SET_IRQ`` message with
+   ``flags=(VFIO_IRQ_SET_DATA_EVENTFD|VFIO_IRQ_SET_ACTION_MASK/UNMASK)`` along
+   with another eventfd. This associates the given eventfd with the
+   mask/unmask state on the server side.
+
+#. The server may trigger the IRQ by writing 1 to the eventfd.
+
+#. The server may mask/unmask an IRQ which will write 1 to the corresponding
+   mask/unmask eventfd, if there is one.
+
+5. A client may trigger a device IRQ itself, by sending a
+   ``VFIO_USER_DEVICE_SET_IRQ`` message with
+   ``flags=(VFIO_IRQ_SET_DATA_NONE/BOOL|VFIO_IRQ_SET_ACTION_TRIGGER)``.
+
+6. A client may mask or unmask the IRQ, by sending a
+   ``VFIO_USER_DEVICE_SET_IRQ`` message with
+   ``flags=(VFIO_IRQ_SET_DATA_NONE/BOOL|VFIO_IRQ_SET_ACTION_MASK/UNMASK)``.
+
+Reply
+^^^^^
+
+There is no payload in the reply.
+
+.. _Read and Write Operations:
+
+Note that all of these operations must be supported by the client and/or server,
+even if the corresponding memory or device region has been shared as mappable.
+
+The ``count`` field must not exceed the value of ``max_data_xfer_size`` of the
+peer, for both reads and writes.
+
+``VFIO_USER_REGION_READ``
+-------------------------
+
+If a device region is not mappable, it's not directly accessible by the client
+via ``mmap()`` of the underlying file descriptor. In this case, a client can
+read from a device region with this message.
+
+Request
+^^^^^^^
+
++--------+--------+----------+
+| Name   | Offset | Size     |
++========+========+==========+
+| offset | 0      | 8        |
++--------+--------+----------+
+| region | 8      | 4        |
++--------+--------+----------+
+| count  | 12     | 4        |
++--------+--------+----------+
+
+* *offset* into the region being accessed.
+* *region* is the index of the region being accessed.
+* *count* is the size of the data to be transferred.
+
+Reply
+^^^^^
+
++--------+--------+----------+
+| Name   | Offset | Size     |
++========+========+==========+
+| offset | 0      | 8        |
++--------+--------+----------+
+| region | 8      | 4        |
++--------+--------+----------+
+| count  | 12     | 4        |
++--------+--------+----------+
+| data   | 16     | variable |
++--------+--------+----------+
+
+* *offset* into the region accessed.
+* *region* is the index of the region accessed.
+* *count* is the size of the data transferred.
+* *data* is the data that was read from the device region.
+
+``VFIO_USER_REGION_WRITE``
+--------------------------
+
+If a device region is not mappable, it's not directly accessible by the client
+via mmap() of the underlying fd. In this case, a client can write to a device
+region with this message.
+
+Request
+^^^^^^^
+
++--------+--------+----------+
+| Name   | Offset | Size     |
++========+========+==========+
+| offset | 0      | 8        |
++--------+--------+----------+
+| region | 8      | 4        |
++--------+--------+----------+
+| count  | 12     | 4        |
++--------+--------+----------+
+| data   | 16     | variable |
++--------+--------+----------+
+
+* *offset* into the region being accessed.
+* *region* is the index of the region being accessed.
+* *count* is the size of the data to be transferred.
+* *data* is the data to write
+
+Reply
+^^^^^
+
++--------+--------+----------+
+| Name   | Offset | Size     |
++========+========+==========+
+| offset | 0      | 8        |
++--------+--------+----------+
+| region | 8      | 4        |
++--------+--------+----------+
+| count  | 12     | 4        |
++--------+--------+----------+
+
+* *offset* into the region accessed.
+* *region* is the index of the region accessed.
+* *count* is the size of the data transferred.
+
+``VFIO_USER_DMA_READ``
+-----------------------
+
+If the client has not shared mappable memory, the server can use this message to
+read from guest memory.
+
+Request
+^^^^^^^
+
++---------+--------+----------+
+| Name    | Offset | Size     |
++=========+========+==========+
+| address | 0      | 8        |
++---------+--------+----------+
+| count   | 8      | 8        |
++---------+--------+----------+
+
+* *address* is the client DMA memory address being accessed. This address must have
+  been previously exported to the server with a ``VFIO_USER_DMA_MAP`` message.
+* *count* is the size of the data to be transferred.
+
+Reply
+^^^^^
+
++---------+--------+----------+
+| Name    | Offset | Size     |
++=========+========+==========+
+| address | 0      | 8        |
++---------+--------+----------+
+| count   | 8      | 8        |
++---------+--------+----------+
+| data    | 16     | variable |
++---------+--------+----------+
+
+* *address* is the client DMA memory address being accessed.
+* *count* is the size of the data transferred.
+* *data* is the data read.
+
+``VFIO_USER_DMA_WRITE``
+-----------------------
+
+If the client has not shared mappable memory, the server can use this message to
+write to guest memory.
+
+Request
+^^^^^^^
+
++---------+--------+----------+
+| Name    | Offset | Size     |
++=========+========+==========+
+| address | 0      | 8        |
++---------+--------+----------+
+| count   | 8      | 8        |
++---------+--------+----------+
+| data    | 16     | variable |
++---------+--------+----------+
+
+* *address* is the client DMA memory address being accessed. This address must have
+  been previously exported to the server with a ``VFIO_USER_DMA_MAP`` message.
+* *count* is the size of the data to be transferred.
+* *data* is the data to write
+
+Reply
+^^^^^
+
++---------+--------+----------+
+| Name    | Offset | Size     |
++=========+========+==========+
+| address | 0      | 8        |
++---------+--------+----------+
+| count   | 8      | 4        |
++---------+--------+----------+
+
+* *address* is the client DMA memory address being accessed.
+* *count* is the size of the data transferred.
+
+``VFIO_USER_DEVICE_RESET``
+--------------------------
+
+This command message is sent from the client to the server to reset the device.
+Neither the request or reply have a payload.
+
+``VFIO_USER_REGION_WRITE_MULTI``
+--------------------------------
+
+This message can be used to coalesce multiple device write operations
+into a single messgage.  It is only used as an optimization when the
+outgoing message queue is relatively full.
+
+Request
+^^^^^^^
+
++---------+--------+----------+
+| Name    | Offset | Size     |
++=========+========+==========+
+| wr_cnt  | 0      | 8        |
++---------+--------+----------+
+| wrs     | 8      | variable |
++---------+--------+----------+
+
+* *wr_cnt* is the number of device writes coalesced in the message
+* *wrs* is an array of device writes defined below
+
+Single Device Write Format
+""""""""""""""""""""""""""
+
++--------+--------+----------+
+| Name   | Offset | Size     |
++========+========+==========+
+| offset | 0      | 8        |
++--------+--------+----------+
+| region | 8      | 4        |
++--------+--------+----------+
+| count  | 12     | 4        |
++--------+--------+----------+
+| data   | 16     | 8        |
++--------+--------+----------+
+
+* *offset* into the region being accessed.
+* *region* is the index of the region being accessed.
+* *count* is the size of the data to be transferred.  This format can
+  only describe writes of 8 bytes or less.
+* *data* is the data to write.
+
+Reply
+^^^^^
+
++---------+--------+----------+
+| Name    | Offset | Size     |
++=========+========+==========+
+| wr_cnt  | 0      | 8        |
++---------+--------+----------+
+
+* *wr_cnt* is the number of device writes completed.
+
+
+Appendices
+==========
+
+Unused VFIO ``ioctl()`` commands
+--------------------------------
+
+The following VFIO commands do not have an equivalent vfio-user command:
+
+* ``VFIO_GET_API_VERSION``
+* ``VFIO_CHECK_EXTENSION``
+* ``VFIO_SET_IOMMU``
+* ``VFIO_GROUP_GET_STATUS``
+* ``VFIO_GROUP_SET_CONTAINER``
+* ``VFIO_GROUP_UNSET_CONTAINER``
+* ``VFIO_GROUP_GET_DEVICE_FD``
+* ``VFIO_IOMMU_GET_INFO``
+
+However, once support for live migration for VFIO devices is finalized some
+of the above commands may have to be handled by the client in their
+corresponding vfio-user form. This will be addressed in a future protocol
+version.
+
+VFIO groups and containers
+^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The current VFIO implementation includes group and container idioms that
+describe how a device relates to the host IOMMU. In the vfio-user
+implementation, the IOMMU is implemented in SW by the client, and is not
+visible to the server. The simplest idea would be that the client put each
+device into its own group and container.
+
+Backend Program Conventions
+---------------------------
+
+vfio-user backend program conventions are based on the vhost-user ones.
+
+* The backend program must not daemonize itself.
+* No assumptions must be made as to what access the backend program has on the
+  system.
+* File descriptors 0, 1 and 2 must exist, must have regular
+  stdin/stdout/stderr semantics, and can be redirected.
+* The backend program must honor the SIGTERM signal.
+* The backend program must accept the following commands line options:
+
+  * ``--socket-path=PATH``: path to UNIX domain socket,
+  * ``--fd=FDNUM``: file descriptor for UNIX domain socket, incompatible with
+    ``--socket-path``
+* The backend program must be accompanied with a JSON file stored under
+  ``/usr/share/vfio-user``.
+
+TODO add schema similar to docs/interop/vhost-user.json.
-- 
2.20.1


