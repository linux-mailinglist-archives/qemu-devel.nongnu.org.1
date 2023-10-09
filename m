Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C079A7BE30C
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 16:38:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qprNQ-0003IT-M4; Mon, 09 Oct 2023 10:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qprNN-0003Gm-NZ
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 10:36:54 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qprN9-00033F-Of
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 10:36:46 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 399DB8Lh008843; Mon, 9 Oct 2023 07:36:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:content-type
 :content-transfer-encoding:mime-version; s=proofpoint20171006;
 bh=fPEFyk+73s4t6ODqGWhdkW3FbO3X46SSbpbTgHcsfn8=; b=e3AaKPi1MjOG
 noF0mefjRcz/loDTjUI6dp8A3Wqx5h+bsjGR9/Cwe1SyB+M4Hzh6MVrTPWyZ3FDk
 NyWmMWJ6B//Ip9LOklBio26qSGt9axpDMXCPeSJ3DgSIx4FUiZ7VNGIWoYpz+7DU
 yfMf7136YRESr+7FDYCnelJA/xMZnAcMGLBKxPFCuV+jrPOJFh9Bo/DU+BLdd/gq
 cyMz80IjWv/FzrGzjhRI10pcC2McXgdCwq/9fpaPDQUHRL8PtB6N9K9PTP9tuCkd
 MeO+GTAVeI7gNcqS2OW4lNqZf3DhiaKTRcJFxKp1UgDufMZ/DQ7yt7DJWCvAa43+
 5Wmpozebrw==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3tkhtbtt3m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Oct 2023 07:36:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1ugQMwsYy8WKt6JU2FYoCAGZfzy+RhZcOEp0PUg6qhxKJcK/7ZSV13J8Z/jnqnbV9UT8nlM7jiK/pq3UjwWa9Rny7jjCPeRjri0OJXYAiVFzUY86CfFv4diHeCMLw+zs2clIH+3HfYU1HFOWYV81Ou6ffYX1Vz4ta4OuA5/of2wpoP6fDlrwlCpYLIvsPClg3fcN1LLwfTtxWkWV0r1kBSGGIHhBxZgZb49UHFLsxHcPy2tz1BZzOC17o/QcNxbG6N4JzOLBtTUIBgImjExfTWnKOJ2zeVBoib33LkYrSX6U5BnZB2MKDMwQt2G85W+qIGKzRY8J+V0We4xzEuUxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPEFyk+73s4t6ODqGWhdkW3FbO3X46SSbpbTgHcsfn8=;
 b=RJNvK2+KimHWjcsX0lMWqXiLzkx7iCR7HVoTqlKT4bJh5Lu2FASG4wbDlIfFRQrnpNWpbTiRl0kUmUrp/habc12of1Mn1bbHYGof9DEFK9lbUzGZava0fiws+WnySd9TJQjgo9s4ZhhKnle2gj9e+/oYiGh7T+St1gxD6Q9AA/B6+WvJu3J8DTjXEpTd5HDUXC2ab41uCSv/efbUDFuu2HveKMPX6PtoSIBculT8unnbteRj/XmbeKJRljAuWxuc2vJDe0FJgVXp0IBGO/tuo1UJpUbIfHMBaQkWbT5nRv0uoCOhwrgyYTDO31DhbneegYXWF0mIVmEpYfnWWJGhLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPEFyk+73s4t6ODqGWhdkW3FbO3X46SSbpbTgHcsfn8=;
 b=vnBJLvSUbNVG0GKnrFLf3PPV2SY5QQOPpjTB/EkAJyWsJ5HIFcbZduM0nuyGMh/u9v+tHvssexjErQWWc09Awo63GzU//l876he3a9Pj4ZTFdFkaDrWXTZ2d9fF8cfXNuy2iyYNVOnNaBYtgfvggv9TF8R0MInobVSJuvocVwoWswAhae3Mb2b/xv8qxNu2ocS7ZHYPj4ofIVE38fstCJKUDqorCX6b9l3UaGybb01GWWkk6ZURA1MXNjoLvPELpKxxUsOOA9rh4EEtL8ixO8F/xWHS/XtyXvROkM+MV41tKkL5lywvuKkjSeA5gKA9JxdZWo01QbCyhvzu+ZeLHFA==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by BN0PR02MB7888.namprd02.prod.outlook.com (2603:10b6:408:160::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 14:36:28 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 14:36:27 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, farosas@suse.de, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v12 00/10] migration: Modify 'migrate' and 'migrate-incoming'
 QAPI commands for migration
Date: Mon,  9 Oct 2023 14:36:05 +0000
Message-Id: <20231009143615.86825-1-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::30) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|BN0PR02MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: e8a52cad-4b7a-41e7-c716-08dbc8d51e94
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6tDDjN0sITdQ4x86Aku7nfljZwwOBB9AfdXQWl/NE6vNzuIzmiLRwePPZ995RuJSXICbVYIOMpHdz9KWDlphN6l4XTc8Nk7Fuyw6bajjVIWVSbpq2rx+asXorTwVVzRZyg9tzaE1tfnOCKvUBaENf1IkNjaPjQmVqqzPpYLIuMqpr3uURyn+C//7NaUlMlCHcYVkEJgvJFJwLkKQbqbrHz+R0fk7pN9txHGL9eQgDMt16RBRZxV9Y+x6rv1Ju8HMFneIbSh3kAazrmPFp53vkHZWOWci+S5ypzq+HwV7B3QxelIsMCrJOwzcr8m17RhM0YvF5k5qlrs8jFIKcnNQlmcnJ0+y+HKr37eSziWHeibMvOVOL5fxQcjFlsSbjIoKMlcc/1JOdNal3mbW/4Qh6mv99qIEDiUrD2Cn90DY2WaIljEe75Rbac47l6mOC2OslfC0AAL3yGaIFxq7AKQop5aBDsgSRskYvI3s9+BJdB8M0rxXDD7jjRiHu7DKMGoKx+JFJ/B3FWv4rUdI/+TCjEqnhdTy/DSsu8vfcd/Q93B3IB8Pga1WV9nPojmblN0OnCDZKyoAWFn8bt0geWRjD3s/XU8uHARNcldDKX3JdCI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(396003)(346002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(1076003)(52116002)(26005)(2616005)(38350700002)(38100700002)(86362001)(36756003)(107886003)(83380400001)(6506007)(2906002)(4326008)(478600001)(6512007)(8676002)(6666004)(44832011)(5660300002)(6486002)(41300700001)(8936002)(6916009)(316002)(966005)(66556008)(66946007)(66476007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0FIaXovU2FFVkg5NzRrRlJmeTh5bnBXUk5uMVdBamJxb1p4d0FueDZQd0l2?=
 =?utf-8?B?ZHpNa201MlppQTFTeUd4R29ad2ZVZHZ2N2dwTnJndUgzVm9GcFlSd0p4SFVu?=
 =?utf-8?B?Y24wUEl2RVgrRVNsaXhmUUZuSDRlOWlnU25OMHRScjY5Q255Q2plZmFGWXRL?=
 =?utf-8?B?UGEwaDdtQ0FlbkswQmxUWW5vUHM2b09yaUMyNStNNjd4d0dZdHlCTTZzcVJX?=
 =?utf-8?B?c283U3hCajZxYUd3aTdhbkF1T0pCZ3NsQ1V0b3JNQWFKTi9lL2o2MkJXTi9U?=
 =?utf-8?B?ai9sckNTbFlFU0ZvckdLbHhSa1pScFpUQmVrdzZETjA3dk9jZjlhQ0RGWHdp?=
 =?utf-8?B?UWU5UDl3M2lKQURFUFJIV1hJL2lVK1Z4MXBuSFE2YmJrTHFZMU9pMHRKdFZ5?=
 =?utf-8?B?bTVrWnYwNmVJNWNXUlNDcU5JOEs5azM0Q1dmOE1HTDJUWmpCRjJxNFJYSzFY?=
 =?utf-8?B?bTAyQXludkhYemVEaTY0ZkdQZzl1MU9aRy9ZcldBR3FGdGs1ZVZuS1ZENUow?=
 =?utf-8?B?NDR5eDFqeHlTRHJ2SVQ5MzdDVFV6eFFVNlNBSmhwbmd1c25TaU1zN3dZTFh5?=
 =?utf-8?B?bjlaOXlobXFEV2NBNFgzNlFOWlYrYXVMZFNmOE5KUGNkdlJGVXhUMzlSc2o4?=
 =?utf-8?B?M05BTm1jM05pMXlwTTFWSlV3dlBncjZYRGtBaFVTVWVBSXBsSFRQUjdIalFo?=
 =?utf-8?B?bStlZnBtajU3dzJNQXdPbDFwcUdwc0hnd2FmMmcvY1lkbVp2Kzh0QWhDTXVv?=
 =?utf-8?B?ODcvNjZjN0tYeVdIRkNYVDNQWnFKdnNIZHhpeXA5QzNuOE5DQXFxMmo4bWlX?=
 =?utf-8?B?QUhLMjErQUF4SkFhMytLcFBzZ0tVQUlyVno0a3NQZVA0dnovc2YvVnFjQkhB?=
 =?utf-8?B?eHp0QlNVYThEV2NITVF2K0hFNjJqWGdkNkRzemoxcnhVTE5rTzJuL2tHbFlU?=
 =?utf-8?B?VFl1dnN0UE84RmJUSUcyUU9QbVlCVHdRd1dHQWRyTXYxNWh5ODl0ZCtqbHZ0?=
 =?utf-8?B?NHhOWGt1SkFoS3hjd1M5VDlBN2FqdHdic0FtaG1vSC9jVFlpcDBob2Q4Ymdw?=
 =?utf-8?B?RllXdGlvTHYwWGQxZUZNV09UMlBpNEp1UDRHOEMvd3F2MjlKd1JzM21NNjBy?=
 =?utf-8?B?ZjZQeUFyWFhyK3UyL29MV3V1Y2xFMU1wUCtEWmJuMy9VL2ZrbThwRVo5VDk0?=
 =?utf-8?B?QmpJL28vS1ZWUnN4c0JMNFY4SkdKSzlYK2JWL1hqY1FpK0NhVVY3L2RIanVE?=
 =?utf-8?B?Rlc3a0RtZDRvSWdIQVJsc0VhSmd0V0pLWEx5cEdlRko2MDNWcGRSMjJVVzh4?=
 =?utf-8?B?Sk5SVnl1MWl6cVB5VUJHbjJ1RXVFYnJYNm8zL05EWTNYQldVQjMrOWhwSGRu?=
 =?utf-8?B?QVdNQU5YLzJVRjcvZGJzbWxVSzA5KzZxS2s0ZzdrRTVCSE04WVNQbWRmTDk5?=
 =?utf-8?B?TW15V0E1ZjEvMjVkNVJ5SkZnTFlWSytTS2ErTVJWY3lTc0lwYmZjWUJvWENW?=
 =?utf-8?B?NGhndDUwRGp6WGxVd0g1OWthT05QbmVxRGtuaHVmZXliYlE5bVE1UnFFNlZ5?=
 =?utf-8?B?Q0huY050RTJMWGhqaTUyRVNtcFpTNGJlSnBtTEhoenh5ZEFBYnVOMmVxYTJn?=
 =?utf-8?B?bml2QWVWM3d2clZkdnhvNFFUWlVROEdJRldWZysrODNOOUNwU2NJaEVuVmdH?=
 =?utf-8?B?c2Y1bTZUVWhwODNnVnJ0eitIdDdBNmsvdklPbm80Q2FFK2lJa285VldHTjU3?=
 =?utf-8?B?L3g2VWRSY2NtVnlwU0FGcU1CeHVlWHF6dzg3KysvbWEvMVZhUkxnTnJ6cHcx?=
 =?utf-8?B?T2NVNm9rV00wekJuRC9jNlI2ZU5IdkRvODd4bHVLVmxGUFpKaDFWVnZkKzRr?=
 =?utf-8?B?NFJLMHNPTUIwYkVhemJkeDdONW5ieHhNR3JJaTU2ZG1hOFdnRVpCV1lGUXVv?=
 =?utf-8?B?Q2hGcGNBQ3N0OTk0d2FKNmxZcDY2cENlQUlTK25Wbk9aNkZtd2hkaElRaVhZ?=
 =?utf-8?B?UFJEOXJDQVJpOUlmVXFnd3VBQ3lCNHNicjVheVBmVjU5bkJacklvS2V1UC9v?=
 =?utf-8?B?VHNwT0FOc25POThnNFRZL0dldnZTaFBjRkJqZjhLdlA2VjhGaEhidjI3M3FJ?=
 =?utf-8?Q?ahcrUcZbQaTlJBq4hSLRv8Xvw?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a52cad-4b7a-41e7-c716-08dbc8d51e94
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 14:36:27.1287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lwT2qw0d9x2ZSOjzmBZMlRjWG2RUuN+tU4EYjMy7GordHudaP2GcE6B/JeE3nsXneys12a8sobR0TiaJrLrdcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7888
X-Proofpoint-GUID: pvvRFZtcXOCIyHYZKw7qoxI9PxAyh8PW
X-Proofpoint-ORIG-GUID: pvvRFZtcXOCIyHYZKw7qoxI9PxAyh8PW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_12,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This is v12 patchset of modified 'migrate' and 'migrate-incoming' QAPI design
for upstream review.

Would like to thank all the maintainers that actively participated in the v11
patchset discussion and gave insightful suggestions to improve the patches.

Link to previous upstream community patchset links:
v1: https://lists.gnu.org/archive/html/qemu-devel/2022-12/msg04339.html
v2: https://lists.gnu.org/archive/html/qemu-devel/2023-02/msg02106.html
v3: https://lists.gnu.org/archive/html/qemu-devel/2023-02/msg02473.html
v4: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg03064.html
v5: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg04845.html
v6: https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg01251.html
v7: https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg02027.html
v8: https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg02770.html
v9: https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg04216.html
v10: https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg05022.html
v11: https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg00740.html

v11 -> v12 changelog:
-------------------
- Resolved double-freeing when using g_autoptr in structures that are
  nested into another.
- Overwriting of pointers to an existing allocated memory is solved at
  various places.
- Use of g_autoptr caused make check errors in non-error path while going
  out of scope inside function. Added g_steal_pointer() in the non-error
  paths wherever required.

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

Het Gala (10):
  migration: New QAPI type 'MigrateAddress'
  migration: convert migration 'uri' into 'MigrateAddress'
  migration: convert socket backend to accept MigrateAddress
  migration: convert rdma backend to accept MigrateAddress
  migration: convert exec backend to accept MigrateAddress.
  migration: New migrate and migrate-incoming argument 'channels'
  migration: modify migration_channels_and_uri_compatible() for new QAPI
    syntax
  migration: Implement MigrateChannelList to qmp migration flow.
  migration: Implement MigrateChannelList to hmp migration flow.
  migration: modify test_multifd_tcp_none() to use new QAPI syntax.

 migration/exec.c               |  74 +++++++++----
 migration/exec.h               |   8 +-
 migration/migration-hmp-cmds.c |  17 ++-
 migration/migration.c          | 189 +++++++++++++++++++++++++++------
 migration/migration.h          |   3 +-
 migration/rdma.c               |  34 +++---
 migration/rdma.h               |   6 +-
 migration/socket.c             |  39 ++-----
 migration/socket.h             |   7 +-
 qapi/migration.json            | 150 +++++++++++++++++++++++++-
 softmmu/vl.c                   |   2 +-
 tests/qtest/migration-test.c   |   7 +-
 12 files changed, 412 insertions(+), 124 deletions(-)

-- 
2.22.3


