Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F55F7093FC
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 11:47:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzwh1-0000A1-L8; Fri, 19 May 2023 05:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pzwgx-00009I-KH
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:46:32 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1pzwgu-0008RG-Sj
 for qemu-devel@nongnu.org; Fri, 19 May 2023 05:46:31 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34J5ECPG005134; Fri, 19 May 2023 02:46:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=proofpoint20171006;
 bh=AML5V1W2qYtBY5E//HZroVr6nI1KHXS1OqP9uCSahSY=;
 b=M7elDAdb1WsaAvZdmFKS+ix45/aw03MmVzCUrGweGoLcP70S+J/w5AQ7Rr//R5AkmX7H
 jJdVlvgKu1QKVa0Gu1YBxsDR/LMy/oC8LZKr/xmyAypRgWrSmCCOZlD/Wu5fJEgaC02q
 VZ3mIeSt0sFdFmvGIrZRtVa/aZtrP9rTfs0AkY3y9WG4H48Ikxdv1w8I4XpvfWw/TfFs
 Rt56Vcp6++5/CkwbH1Vp2ZOFcHXI8GxD6APw/KaezmhGQEVOz48HV3BAkWJxiohCfZRG
 cadUqYKBkFHSTFXRWWWwRnkP+9oaOIy+Bur33hO3jZyR8vT3lUJVVwGIFrKzCkOeRlev kg== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3qmw0vda29-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 May 2023 02:46:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOscLAeHpku3mQrTizaPBA1ChdGxx7U7+KVCJ/U79vc2WCMG8xQX1M4w96DadznBxC5x8p7NMj4DCD3TODFhH6t+ITJmmCexOQC23QdnuAs1AOKDitbKMMZNp9g0IlkDq6bQCmlzAzClEgjvD+ir/itZb8oQpzRuvsiZKAMtZQDh8mj+r0XQrunK1WumMFCfm8mSI+xTw6LpJ7HB7QQI0f/Yp60qpL2uMiIYeLhj0Sx+asfDMoZRwz6qDmmpL+ThgTQ52+zXKgR7jPU5cYPZTN+WA6DD4lmf/qHF3Yx6r9LGBJeC/hp7Ujs5xhjYyX5XLH3G0m5dg7kSp0FMaOZm/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AML5V1W2qYtBY5E//HZroVr6nI1KHXS1OqP9uCSahSY=;
 b=jUywp+RAi+U63jcp0K5alfo5o/nMGQqahWoHbfnB5h4WL109QBhqbBpFcrpvxTy6bBjI7CJzJupb5KC/6h+0NLPU6QTxARo5FhtJYhNksqa9lfVQMgBvsUBMwFW7TSJA7ACH9gcqJPAfFwFCdM7uWxQRgugmzSNn1G5aDGzajfN3sSauF94bWdeJXwIvFvilbgtGoWGgLGF10O8ccA6Xo8XDGd5LxwYZ/e+J2m0nqT+N/Aet0QmvjKPToExg0/8RaTihTB6aXYM7NFGmq98+KxKtw+5KfKWHvWZNavEZUTxRGSr2kFXQGJavIif4vrvo94GcjFWGFCVIQyTc0aMu/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AML5V1W2qYtBY5E//HZroVr6nI1KHXS1OqP9uCSahSY=;
 b=VTBshwIFxD6mCWjIpC3Jwki65k1HdbeymYvLAKlj6zzL+/LB67oTU3xR1oEbQO6FTNWwb4kx/fGY2hCYQExqLLBop2Eh79bXeYb1kxmPTAvlEGe21kmXpvp2vxR6IIBzuH1om/qeX/dLmcgS4WwFeRx9fv/P3OkSd04YXFfOoRaiUNui3+h9KCeFOX7CJCf8d1yVS/MFkfCJF0EcOTL7bU9spgH99S8xgnov61n7ejNZjAupTy/Y54MB3lnXri43sjBdNBPkGQLSmmzqTufrEeKGMo8H6ZmGTaSag+NuxUqLfPWWkVLbnlfUr1+gXn73mAyMY+H5PH1CTOkvcV0xbQ==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by DM8PR02MB7912.namprd02.prod.outlook.com (2603:10b6:8:11::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 09:46:23 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::4500:569:a3d6:71c9%7]) with mapi id 15.20.6411.019; Fri, 19 May 2023
 09:46:23 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v5 0/9] migration: Modify 'migrate' and 'migrate-incoming'
 QAPI commands for migration
Date: Fri, 19 May 2023 09:46:08 +0000
Message-Id: <20230519094617.7078-1-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:a03:180::44) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|DM8PR02MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e192e4e-fc07-4946-75f4-08db584de7a9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d1oY3XwB/FfYHjRRP/Sjb1H7Nn2HmLHsCqw9/jeGHlRo8B9tTqwix+occ9vd221j56YRNyNc8WeehY6fLhaIONqgtaN32t8hQjusvVaZjTDvrraWdBdB/EReKCDjLMmXf76mturKphf2DTuyfkF4u5p4Oc+gf7elNiNn87fG/0M6yU/56IQePS9j20pWtDmZ9s8RHGapxSe0dxq4ZjYwXDT2aQ5EHcwofE8DTXQOwFcw2XbsxmYmwkoev9WAC/wMW0TIPdDNDWRAFoh5slDrJoCNizLJJ0PWeUHC1xpZhTRUWjFw1i9H52W7x5TYavZ0DLJi042RNILOAKoXBSRXHCXy6iiOuLDN6sbw8IKVwHiYd1gDRYx49W5OFqRSb9qS68mPB+BZ3CnNyzNqBdvQP5dAwSjwwBjuQcNMweisXEqSAxzKh8DwypHTL+f9KJv2Q+Q3RVxgSGnkupxwlOrkP0YJbBjeqje4mvg8ehffMFTWS318iWxVRfBt4tSJSTfd9lbklm8UHb0/oZFuPGeD9oc3W8poi95Ws6UKMkkhNWLES6bZk7SCwEaixDSI+cAmheWz3jiMV1XaqZA9t6rkUgUWbvM6WI4MvQhvLm0KoQeDK5h5fdUt4M+WDI5dFQ+kBWYIsEUBm8qo04g6tHol9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199021)(36756003)(44832011)(8676002)(8936002)(5660300002)(316002)(41300700001)(66476007)(38350700002)(4326008)(38100700002)(6916009)(86362001)(66556008)(66946007)(966005)(83380400001)(107886003)(6512007)(6506007)(1076003)(26005)(2906002)(186003)(52116002)(6486002)(478600001)(6666004)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWhiTzdZMXg3RloxQWJ4SDFxNGdpKy9CdmV1QXg4cGJZWFNTSkZvejQ5dHNB?=
 =?utf-8?B?L2xuQlZsOExKNkZxM1JVMmttNjhhWTFWNHN0eWVuWmhQTmdhNzdVbXE0aitr?=
 =?utf-8?B?NlhTSVNnZlFLMEZWWE1UbWdrWXZYU0N4ZlpPUzM2Z2Y3QStTcWVnNXdaM2E4?=
 =?utf-8?B?dytGR2xPME8vb0s0OWhHcEF6M21aT2JYa0VzaEN5c1ZENTlWMXZHMXV4L0ts?=
 =?utf-8?B?aTNLbkFyemFNeHJnVEJxd211dStBWXVXaHdGNjdmQWEydWtLdUhSTUlJajA3?=
 =?utf-8?B?NnhxTDNKR1VMR1RhSXlKaHgzWEhLWmw3dW9XUEhLYTV0UVJTeFRLdVBZNVJN?=
 =?utf-8?B?MmNnaVNiem9mWHpId3hsOVZzUCtueStmdloxVHk2SjM2RWVaQnhiZ05BTXVz?=
 =?utf-8?B?T0ZwclJPRFNUV3hBZmc3TWlBTXVBR0NGWnZRTzhRQjJ5R3VxMlU3NStYbDVi?=
 =?utf-8?B?ekhBZC9VY3UwUE5iUTJIOUY1Y2JxckQyZTlKVm5ZOHhveFJmeFRmaW9NYnBp?=
 =?utf-8?B?bUZqR0E1eXpGR0VrUlV0MkNSbXZ6TFMrS1pWeHhYRVlYZVo1MktRREVmWkRS?=
 =?utf-8?B?dGVxV3cwSklKUTRGOEpjbDh1TEp2Qk5BUTZ3cnpMVW5kOGJPZFhYaXhDUGdP?=
 =?utf-8?B?TXlNK3pvajMvTmlpd0lHL0FTWk9TZ2hpRHBIalVldG5tMzQvUFNRcytUcnhK?=
 =?utf-8?B?YWhMYUZNRUgwS1ZUMjBTWkhwUzd1anp6d0xHcURDSnFZUlJrakkxVjNPMVFQ?=
 =?utf-8?B?N0hsRlJiTjgzTXdVbU02blZKUmtQRVprVXlyWlUzRUVaMzFTZDJobzVXNG9C?=
 =?utf-8?B?ajRHekErV0NRWXlrQy9OazAzU2hoVFdyUm93c2doa2JvcDRVNFBpejJUdUlT?=
 =?utf-8?B?OUI3SjJwRGVRa242Z09WVG45WFk0MU1OT1kvOS9zN3ZZQ3M1QW9RczBKVEJQ?=
 =?utf-8?B?dVZUV1pHSk9Ma25URzFyR1pJNGdhdGl4bjZXWnpoQklFNzdaekd1Q3RsTUhM?=
 =?utf-8?B?T21oSThvckEyOXY1SjljRTFJckJpdU1kTjc4bVE1MmNJb3dJVE5peWZnVExS?=
 =?utf-8?B?alN2REQ3a25teEJOV1NUNjVhQ1dzcTdiQ3VxNUxZaGxEMDNVTG54RWVjaHIv?=
 =?utf-8?B?UU8wYjJZczVVTFZqdkZIa045M3NkL21lUTNTaHFNUEgxNUhvZ3hUZVRYc1lG?=
 =?utf-8?B?cklYWk5lZVNpelpUWmlpWS9MZmR3dkVyMmJ1QXc4bklFVDFjWmtQNFV2aVlN?=
 =?utf-8?B?OWxKM0Fmb1JmUG5oS2JzS1FscE5xd3dtZENITUFVdG5BR3ROTDQ0QlBXdnBw?=
 =?utf-8?B?Y0EvZThwTFBXRVB4L1MxVEJxUytLcmMzc2IycHJBZktvMk56UWtRZmQ1RkM0?=
 =?utf-8?B?Ykd0Q0FXb1pQQ0UzRFpCZGJTVGt4OFZPQmlPVitmVU5qTnB0QjkrWld2M1Jw?=
 =?utf-8?B?NEhtcU41b2FTMnVJVW5Ga0o4c0MyR2pQTzhpREZLMG9UTDAvKzdXWkJnbC9G?=
 =?utf-8?B?Y3RNcEZMcFlORE5uRTlid0pNbVFCWndLZGc0MkZrNmJ6bzhYK1p3RElSMytv?=
 =?utf-8?B?WlFnV2llZEF4ckJ4Z3ZibFRwS1VpaDZ6K21TWVduaU5Cd0ZxajhIN3lqZXM1?=
 =?utf-8?B?dW5Ha1kvRlZlaDlzdWJMZUJacW9BOEJTMkEyNGVOZHBsZldlWDkxdVViMFNz?=
 =?utf-8?B?TFFzVmQ2d0NGNm9ML1lDK2htN1RCTm1VOExIM1ZQU2lvMWhkWlZmNE5mSElF?=
 =?utf-8?B?cGZ4SFZ2ZVZBYW9MUnVWcDdnNUNVTk1PQm1Kd2dDSy9seXY4Y0JQbW15K0lW?=
 =?utf-8?B?NzM0eiswZCtMYXN2Wkp3aWdieW13ZGpubmFneXFpQTEyc2I4MzN5c2x5aVU5?=
 =?utf-8?B?YU5UeHRrdDROTk9TN09JbWx5T3VBL3ZLa0JKT1FMOU1WLzBUQzBlNFg1OFRC?=
 =?utf-8?B?S2h4ZGNpMVBQV3ZRS3oyT3BQa1BjU0x2K2xKR3BibjhnbVN4RXdER0M3b0t3?=
 =?utf-8?B?UnhQZU5HTmVpdndZY0E2Zk5PQ3dwM2lZbWtsNEJQL1BGVDUxMjZUaWxLeGhi?=
 =?utf-8?B?dmFna1lNK0lXNW12YVFVeDc1WTMzaG9FcVJUbjFPYjhYWTA5OHRBdlVlYjFK?=
 =?utf-8?Q?mQS+9PmANwgNL3p8KTx6sjDxv?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e192e4e-fc07-4946-75f4-08db584de7a9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 09:46:22.7688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nOerhdSroB6hBLVPJVMih0e7tb9cFFQqJW8MGruJMa1WA5DM5LQ6eHKMjeZFBvDq9f45XP6sicYIHoIK4ZQxOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB7912
X-Proofpoint-ORIG-GUID: 1qoBaV_wBTuE3ps8j-e_jQJ4g7goBluG
X-Proofpoint-GUID: 1qoBaV_wBTuE3ps8j-e_jQJ4g7goBluG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_05,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This is v5 patchset of modified 'migrate' and 'migrate-incoming' QAPI design
for upstream review.

Would like to thank all the maintainers that actively participated in the v4
patchset discussion and gave insightful suggestions to improve the patches.

Link to previous upstream community patchset links:
v1: https://lists.gnu.org/archive/html/qemu-devel/2022-12/msg04339.html
v2: https://lists.gnu.org/archive/html/qemu-devel/2023-02/msg02106.html
v3: https://lists.gnu.org/archive/html/qemu-devel/2023-02/msg02473.html
v4: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg03064.html

v4 -> v5 changelog:
-------------------
- Improved majorly on cleanly freeing objects across the patches by using
  g_auto(), g_autoptr(), gnew0() macros wherever necessary and preventing
  unecessary use goto statements.
- Simplified error statement propogation in migration code flow.
- qapi: changed version form 8.0 -> 8.1
- For HMP commands, decided to keep using URI syntax forever, so depricated
  implementation of migrate_channel_from_qdict() for converting URI ->
  MigrateChannel struct, as "char *uri" is already getting converted into
  modified struct using another API in the workflow.
- Additional tcp test case for multifd with modified QAPI syntax in qtests.


Abstract:
---------

Current QAPI 'migrate' command design (for initiating a migration
stream) contains information regarding different migrate transport mechanism
(tcp / unix / exec), dest-host IP address, and binding port number in form of
a string. Thus the design does seem to have some design issues. Some of the
issues, stated below are:

1. Use of string URIs is a data encoding scheme within a data encoding scheme.
   QEMU code should directly be able to work with the results from QAPI,
   without resorting to do a second level of parsing (eg. socket_parse()).
2. For features / parameters related to migration, the migration tunables needs
   to be defined and updated upfront. For example, 'migrate-set-capability'
   and 'migrate-set-parameter' is required to enable multifd capability and
   multifd-number of channels respectively. Instead, 'Multifd-channels' can
   directly be represented as a single additional parameter to 'migrate'
   QAPI. 'migrate-set-capability' and 'migrate-set-parameter' commands could
   be used for runtime tunables that need setting after migration has already
   started.

The current patchset focuses on solving the first problem of multi-level
encoding of URIs. The patch defines 'migrate' command as a QAPI discriminated
union for the various transport backends (like socket, exec and rdma), and on
basis of transport backends, different migration parameters are defined.

(uri) string -->  (channel) Channel-type
                            Transport-type
                            Migration parameters based on transport type
------------------------------------------------------------------------------
Het Gala (9):
  migration: introduced 'MigrateAddress' in QAPI for migration wire
    protocol.
  migration: convert uri parameter into 'MigrateAddress' struct
  migration: convert socket backend to accept MigrateAddress struct
  migration: convert rdma backend to accept MigrateAddress struct
  migration: convert exec backend to accept MigrateAddress struct.
  migration: modified migration QAPIs to accept 'channels' argument for
    migration
  migration: modify migration_channels_and_uri_compatible() to
    incorporate newer migration QAPI syntax
  migration: Introduced MigrateChannelList struct to migration code
    flow.
  migration: adding test case for modified QAPI syntax

 migration/exec.c               |  62 ++++++++---
 migration/exec.h               |   8 +-
 migration/migration-hmp-cmds.c |  16 ++-
 migration/migration.c          | 183 ++++++++++++++++++++++++++-------
 migration/rdma.c               |  34 +++---
 migration/rdma.h               |   6 +-
 migration/socket.c             |  39 ++-----
 migration/socket.h             |   7 +-
 qapi/migration.json            | 145 +++++++++++++++++++++++++-
 softmmu/vl.c                   |   2 +-
 tests/qtest/migration-test.c   |  47 +++++++++
 11 files changed, 426 insertions(+), 123 deletions(-)

-- 
2.22.3


