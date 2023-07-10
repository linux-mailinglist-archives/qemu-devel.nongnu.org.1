Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3909274D56E
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:29:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq03-0008Ee-EJ; Mon, 10 Jul 2023 08:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qIpzz-0008Di-0X
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:28:15 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qIpzu-0000iv-SH
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:28:13 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36ABubWY012686; Mon, 10 Jul 2023 05:28:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:content-type
 :content-transfer-encoding:mime-version; s=proofpoint20171006;
 bh=IWqPFyaskWa/d/pMsu7U+Bxk46OYlbh9cOcPu5VlnAU=; b=AIDaB5YO3IT9
 cGPkDs0nJ8ih0eGMucPoKk+ZnldWXuZTHS1wF7sqLCXzhI/R7++o8y+M4wb3DjNB
 G5ixmglPTQCFL4jD6YvOvCFcygtmFyEBS6xhp6fR5pvPHwD4tooj6FRjEGq85cOI
 t/uxys5bI1k5l647yVk61Eq0M1gu7JxI8+csPZ3qqMD1vldnEU9SlwjdCtGgVu1Z
 85gO2Pr/MyPwUvHKCkxO7D4qUKRVS4G37K/AFshhgiVzOQG0vAUfm5XBbkJxpJ6o
 Zhut0HhGIJNu98yLFAbqfLnkyuBrqTkUVlSLeu8jRr+H/frAWCDwVi1pWzrGlwL6
 mOB1oX/dfA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3rq3q4u167-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Jul 2023 05:28:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCIeT1/hTLWfhR8beZo9JymaacBVYKKWANPp+Yz7Eho4kcYLq14M8DKFSJW5TTUTwI4JvGpCBuTQQo6MzSdvPmIX/8wUWTs7IT3gNybZ7s56sojB9XXHbJkG13/eceBeTEu+upCk8EQRtrjcDLQy6hDcEoil73pSjYoobuoHsRh2bNJuxJSuGiKDRVsFUE7C5xGXIBTSuOSLAuQcyJY5Awox3OsgtXwHLnhS0OQRI3L99K6G+7GQuNRQEsN8B7K6sgzK8s7RBJf58TBr7TooAAgNxS+Xn/WeJRvf82j9/7ueY+bSJgp4B6qlhacMR+0WSA6e/Z8vwRA7hXoIJ088Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWqPFyaskWa/d/pMsu7U+Bxk46OYlbh9cOcPu5VlnAU=;
 b=e73LG7gwqT3NiT5SMWKPUhCOlJ2IWOR4xZ8jg7wfSuFV7dnCnLKzm2YD5hRk5L+r8ICOmTL+okoJ3bdDj12NcvR/hXeH/Utfs9ZzIa2BdJ1gRi1jKssvunjiqDyw6nlvtqGtauu66//osolDamz4kA3RCuY2ZKgHVUlcXr8TEk437VVbq47YXOGouQs8txiCACbmCmrbJWqFSCCzvv3ov7us+YcHglQ2R+4XkuRIr6svvwp5xMYospvcbpgWicsCzE67rOG6chQZiPFo9x4DbXRQmbfKqG2skyZWNWZ/bbIKF8HbiwjYt0KRtVaGkZB8mHLmGoY6CnUBbJm+bQMGqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWqPFyaskWa/d/pMsu7U+Bxk46OYlbh9cOcPu5VlnAU=;
 b=grT4LrnNaFu5mopcXCUtu+YrUXq3HFt6vx5b4wrCqPRdrrYjSYILQgZcY8rR6VS+GuPvdrdbk3aZZuM9+4KxnsnLrE1lf7L84/94xb3n0qh7PIP4HppIfx5Nb9L3dx+kffDZohoIa7MC0jdp6XEFZ/Qw7aKS6nulJEz0CqNIw80MXtqbVinsU4WXLCF+4p1RvxslAefRuBmVD/+aW5yVOw/FgjexP6c6k6v/yl/lMS45EGwc4k+rY1kQQYIsrbQOVFjh1kFlLdfvC0evDpZHI49xHtdgeyMUFwUsCm0CWJj4j5XjtkhaXde5SNMXxU1nOot6zMUP2Q2MXswFjOovew==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by MW6PR02MB9934.namprd02.prod.outlook.com (2603:10b6:303:23d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.13; Mon, 10 Jul
 2023 12:28:02 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920%7]) with mapi id 15.20.6588.017; Mon, 10 Jul 2023
 12:28:02 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v7 0/9] migration: Modify 'migrate' and 'migrate-incoming'
 QAPI commands for migration
Date: Mon, 10 Jul 2023 12:27:41 +0000
Message-Id: <20230710122750.69194-1-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR15CA0003.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::25) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|MW6PR02MB9934:EE_
X-MS-Office365-Filtering-Correlation-Id: 380a9ae1-23a7-4c95-2c8d-08db81411a79
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SdN6NHnULicojv/Z5TTIMxefmmUZOM7wcFoVfeU9M4k6dPc1QNaZiKT84P4VUq2cDVn6QMbEwBdinoBwg8zEJ4n9H+HQT7Eyrtdhec0cl+DDvJIjI+685m5QokTbzeJ4Wh7IC9tXGBiUxd5xGNnDH05fyfKRR2MKuNQ2Kqy5zLyPGqXS1vOeeF24AZjy4rcICRHwxZgt5xn+Qt4iX20VV/kfaunEweWaG83Gdf3yMk2OU6PNFbBUhwzmYpqBWgoc/Qn9b2qYaWK9Ffnn0ZsKsAzcQ1QxoQqTzxW+CqdhntPF5tw1o8sHUz6yaAuR35E3iRtG7wkFxHINXR18uDbcZj6woeI3Cbflz0c5E3KZhYt89rCu4o+ukP6s1ejPz2KEV23uROvZfLneK9cnXhI1UzV9vsWROs0azk0wIV/z12KsILxd3x/fnJFTb4iZbHjaqcdwsXf/fsaaOGj0t6PQqrkEtT4lZ8dxnIe5tt3SyBskU+PJxvYXf+q2XmrjoSRJTscoIjWDjliyYCy8YVNIEsuAn/n6TtvVuaavTsLTHkHnvB083/BrQ/UtbZYXNTBymkyiK5BsHuPaKplQFngVZoTdX3TnWlWtRjHEC3muLwNuK//ul5hrQ2K2AabaJ+yNBPsNv+ZWDMFX9KvljONgXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(136003)(39860400002)(366004)(376002)(346002)(451199021)(38350700002)(5660300002)(66476007)(8936002)(8676002)(44832011)(83380400001)(38100700002)(66946007)(66556008)(36756003)(2906002)(478600001)(6916009)(86362001)(4326008)(41300700001)(316002)(6666004)(6512007)(6486002)(966005)(1076003)(52116002)(186003)(6506007)(107886003)(26005)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGJWNytsdDlwU1ZmN0NhTFpxU0t4UndVSW5PQThMeGpjR2FyUm5XTzlKOE1S?=
 =?utf-8?B?Z1JYR2xFNnZYK003WDFjRjgxVmxHVVQ2Z1A2SGozQlFDOXdMaEU4NXkxN3NM?=
 =?utf-8?B?V3lrb2VuYk45OHRBMXd4ZTZPMStJMmJOME4yZVdWb3ptVzc3L1JvMXVTN2cx?=
 =?utf-8?B?NG8zTTVtZjlNQVdmVm90NUZ4eXdnVldKQzJvaCtTVll6RkUrczVoN0VyM1JN?=
 =?utf-8?B?RzRKUGxuQWhvaTFXWmkrRHFvTW45eVRKV0ova1BISnl6SU9OZTlsWFJjeGFE?=
 =?utf-8?B?TTNaRUFSbVB2eStIZFFoU1Q2ZGFCVG9QTWlkek5yWGlYeGdubE42eTc1R2hp?=
 =?utf-8?B?aVk3a3hyNGhBU1Z1aWd4ajZWdFNBcWJrWjJoV28xRnoxS0hVV3o4L0pVT0FL?=
 =?utf-8?B?SWRnMVREcDFJMENSL2ZyOEV2RVRFdkRtMDJOcVAvMThyYnBIb2dORkpNT0ZC?=
 =?utf-8?B?TmZDY05oU1FGdlJlUXhPRVZoN2RKdDRTa0tuNFc5U3Rka052L3FMS3ZqUkRh?=
 =?utf-8?B?Zkprbks3cXJ3VFl3d3lXZzlVTFJMZnJSbG94cTJ3dElPS2J4QXFIbTBrYmFF?=
 =?utf-8?B?ZVpkWThtNWErZVpuYUdCOWdpVWl0VDJDRU1mL2JzYjNvSjZnNXdjbmFRSTcv?=
 =?utf-8?B?Z2JnWTFwVkhrY2xnanc0Sjg1RzZnOVQrM0UxeEViMnpXRjFBY0ttVzN4K2ll?=
 =?utf-8?B?YytkU25nSUN3K2c4Sjcvam1ueXVreUNJdG5OaDYvL1dqdG1jR3hnZDZURE5M?=
 =?utf-8?B?UFJKdzhmd2pia0FVTjBkQzVXUFE0U0hLT2p2djF4ditsUnhRanBwb3VCWmhR?=
 =?utf-8?B?a09zOTFUY2hBVnpjeFV5WWlob1lMK2s1RWtlcjdlb1k3RGFVWHdhR1Y2MHpz?=
 =?utf-8?B?QlpPWEdoNG50QjM2aU01cUhzZ0ZPYkdKd01Gb0E4QUJrVVh3MnFpRThLTTRw?=
 =?utf-8?B?dGNEbHN1d05JM2FFakE5SEUvZlMvd0gyTFQzdmtyVllMVXZHYVM1KzlDeFk4?=
 =?utf-8?B?RmlMcFNtOUM5cDFGcVpjWmJDTXltZWpPbm5hZlJ3NWdYalJVaC93UUozYXNk?=
 =?utf-8?B?NFd0MjlzT1c2V2QrQWZCS2lOMGYyRGs0SzhxSzJWNU5EYlVmalJZSkF6bW9J?=
 =?utf-8?B?TWsrT0RGaDhDbTQ5ZnI2V0NNUmpyMDJWMEJMSjJYTy92UXU3alBmZWFuSkFz?=
 =?utf-8?B?MWl1NzFQY05kVnRWV0k3MXp2U1dqbEwvKzE3V0xTK1NyZktWNE1PZDMvMTZx?=
 =?utf-8?B?RjFWdWhXOWx6T2Y5UTYxVjlsc3VlakJwQThvcUcyRzR1M1ZMQVJqczJoSUFP?=
 =?utf-8?B?RllXRkQ4WHZNcG9qNXJsYXUrZmFNdDI4UjYxR1NGQTQzb1gvS1VYRHJDMk5x?=
 =?utf-8?B?RS9UcTNxdy9kVkVOM29wUzNJN3dLbGJ2QjNPRnEyWUMxV2Y3enVlNDZZdWdo?=
 =?utf-8?B?ZTF1QVNOREF3dFdUVXRMdER6VjcrdGRJYnRGcWRFUUdJbVp6RUlORG1wNlJU?=
 =?utf-8?B?RVpsZkRPVUh1aE5pUzN2dUJZUTJNcmpxT3hIRG9MTGhIY0x4Yi92aU92ZmlR?=
 =?utf-8?B?bXFXVnBRTTlCcHRGalE3YmFENUpKUjZDMUpmeVREQVhyZDliRVk3RUFkWkRT?=
 =?utf-8?B?cDdNaTNkRFExWmJac3VrNWxEZ2JpY3Y4OFJFaG8wd3RGUW4zSlJMMnlyTE5Y?=
 =?utf-8?B?M0ZUM0NsNGZPNkxsMWx4YUtQQjlHeGVTWm84alFuZEpvemFtc25kTGE3MUNr?=
 =?utf-8?B?R3N4V3JUSjhjTWxWSEoxYmwzSWw0VUhsdmY5L1g5SGJxREJMVW9pUkhTL3NO?=
 =?utf-8?B?WE1ZanhWSFEreHI5OHVMWi9xMjR1UVI1UmFCVGJMaThJSnEzKzRWbVZZRDc0?=
 =?utf-8?B?b09zN1FvSVc4Q0kzcStkdjR6WmpLN3BFNHgxY0ZEbjc0Uk93TTRkU2o5bTV4?=
 =?utf-8?B?bEtxT0xESDdXclhCYmxNcFNvWS9sQmFNRVB0aTZhSW9oRTBpM3dVYlZpU3hC?=
 =?utf-8?B?b2tSMzRKVkFaK1dTc29OMFgydDlvTUc3ZE8zOEFaajlMUXRJSzlnQ1ZXWjZW?=
 =?utf-8?B?ZmgwbVpnY1JoUENpMmFoejlNUWJWdTR0Wnk0bUdZZ2FBdStRRHNnclFLbzh0?=
 =?utf-8?Q?xQ49xbrfmf9wtjLHQHLDSbaIJ?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 380a9ae1-23a7-4c95-2c8d-08db81411a79
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 12:28:02.1404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dcfOJ4kcdbqBlmwZlm8oP6giuCYF/SEpJK/Kmzyl0QZ43DJxgaAatOTlOozT5yF3Ru3sznyJDxIb3RldEH9SKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR02MB9934
X-Proofpoint-ORIG-GUID: QwE5-H4-2ObklTrG5Kog7mHQiZGEKn16
X-Proofpoint-GUID: QwE5-H4-2ObklTrG5Kog7mHQiZGEKn16
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_09,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
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

This is v7 patchset of modified 'migrate' and 'migrate-incoming' QAPI design
for upstream review.

Would like to thank all the maintainers that actively participated in the v5
patchset discussion and gave insightful suggestions to improve the patches.


Link to previous upstream community patchset links:
v1: https://lists.gnu.org/archive/html/qemu-devel/2022-12/msg04339.html
v2: https://lists.gnu.org/archive/html/qemu-devel/2023-02/msg02106.html
v3: https://lists.gnu.org/archive/html/qemu-devel/2023-02/msg02473.html
v4: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg03064.html
v5: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg04845.html
v6: https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg01251.html

v6 -> v7 changelog:
-------------------
- Formatting, improvemnt around migration qapi documentation.
- Change of notation addrs --> addr along the codebase.

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
    incorporate new migration QAPI syntax
  migration: Introduced MigrateChannelList struct to migration code
    flow.
  migration: adding test case for modified QAPI syntax

 migration/exec.c               |  72 +++++++++----
 migration/exec.h               |   8 +-
 migration/migration-hmp-cmds.c |  16 ++-
 migration/migration.c          | 182 ++++++++++++++++++++++++++-------
 migration/rdma.c               |  34 +++---
 migration/rdma.h               |   6 +-
 migration/socket.c             |  39 ++-----
 migration/socket.h             |   7 +-
 qapi/migration.json            | 150 ++++++++++++++++++++++++++-
 softmmu/vl.c                   |   2 +-
 tests/qtest/migration-test.c   |  45 ++++++++
 11 files changed, 435 insertions(+), 126 deletions(-)

-- 
2.22.3


