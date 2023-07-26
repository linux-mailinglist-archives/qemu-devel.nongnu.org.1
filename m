Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F1A76396C
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 16:43:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOfMI-0003Pm-Jk; Wed, 26 Jul 2023 10:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qOfLp-0003Mb-Po
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 10:18:54 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qOfLl-000172-56
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 10:18:53 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 36QDC32L032511; Wed, 26 Jul 2023 07:18:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:content-type
 :content-transfer-encoding:mime-version; s=proofpoint20171006;
 bh=glm9EXk81mBVfaRz60w+Ixu2V9NtHCoCHbmHB4lB1Nk=; b=hNuVL0d0M22O
 7ELebLF2Dpo45vKmEtsW6Y6tYXhD/cKE9MUayiaVKMYGFuZqIHPVoCf7gHyTLqYn
 mhgnakrGRWXXF7KaP8W7bAuRob0mX3fj1hQmZA1GxNW8SOXyE4tlQGiT9kksJf1Q
 GzVPGiIF6n8e/mhoZ7ujXFi7FffuNC1+0b842geR61gl3SqQlEcW6QjmJxB5ocet
 qMiB7Q5S00H240mM5g+VF1AfVpQNp8zggWvmZ+T2VRUCQy9bV/lLhr4vcwJqGIdF
 GVEd698XXqwZiTrKK/g1qXJkyd3AwW90cMZLRSKDfijVoDmFmSiD0AxjaOr3g1Ep
 iBU524p+ig==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3s0b1707wq-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Jul 2023 07:18:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHK0sxbhQNhQJSKOF4K6Wj9d5S2fCtcxyVNKDSfbvTyagxSxj/L2OOMT63zVVAm4Lv3zKUgNdEVyc+M24P2e/B0gewMqoVe2EK22MuYkwip8GGdZS0yM0LapaP+WLjNWFofqLOSM0/n8oBI5ccWMTPz+ndizXULQFeyCV52p9LIf90dvO/LS/BM9/dBP3ipy4Brilmbrs6xTOdtPKaF0B34GCFUW5bNS9oXbvxOpR74oOB0awEtnF6gbccb9DlmSBERwcOfHxhX8ii8QiEDPlcJDqDLfcKPaqr7XNwJSOR+KSV8PUDzoATu9O3PpVPPpQFwtLQcI0vyJ74QmqQSQPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glm9EXk81mBVfaRz60w+Ixu2V9NtHCoCHbmHB4lB1Nk=;
 b=bhlurgOeGyT+mQJHmxdThTct5jQKG9AYlrHyJ7YxlPcvg41NwdP7M9oDAHE959L2XqDnCIXD2uRgeHbX+bmquPLfATjXbjC+5zyGxek9yVUvFGqSiohrEcl1D4fx7Ycp0aCNwS5RwrV1yla+Rbn6V2jK4odnRel9J4ASRP5tsdyqaQ/3ymHfn0DdoTKQ6rrbbYRXCJw3LDQTHeMZIaRxg5ZwgECST7zflWnqjJIMbu/ncq083GsJ9mQEfjL8IhMYHktB6Fh63f+rmBS5dxWtOgQJT9wJ+r5HLlIsggWk9S5uXxFr8IzBfpG91nMC8slAZzezvdDV794r9EVs1SbBkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glm9EXk81mBVfaRz60w+Ixu2V9NtHCoCHbmHB4lB1Nk=;
 b=rnuwnWSCuPj0cHByldhakKJPlCeq8Y8F10F8OEgc3mJUQjdVHJZ+J6wx0wo4gLvyAP04LBCZd3pMexPXqJZpL0XKrnutq9L2OwqmLQad3U3gCQxcZ3m390+yq+/IPpgdjB47Tq3mnKXQA0E/P3WkDqFe/7SKGLUy75Z0mISjy3RjNtU33/9giNJMb3ZeHE6V722jPa0mHpXH5sjA8S5uaEwufE2TKb/3Q85b/pykhc6/C5FUnEgKAFmLwA0Mk9kxqt97ndi4NBLWCqHEk0OScyEjlTyejVbfo7lUv4tf5g3l5CcaNkgX3sBc9YsuJhRuLAj52WyFw9WolIxE8pRY/w==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by MN2PR02MB6861.namprd02.prod.outlook.com (2603:10b6:208:15f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.24; Wed, 26 Jul
 2023 14:18:39 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::2c:438b:2b97:26ad]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::2c:438b:2b97:26ad%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 14:18:39 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v10 00/10] migration: Modify 'migrate' and 'migrate-incoming'
 QAPI commands for migration
Date: Wed, 26 Jul 2023 14:18:23 +0000
Message-Id: <20230726141833.50252-1-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0096.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::37) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|MN2PR02MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a5ebca4-d0ba-4198-d51d-08db8de334c6
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YX+hHVaZA1eqyXpxzL+/mTjkECRYOd1WwucV003gk7aAKkaxDjvkTgGz8mkXIKHrFofsK6P7QDvmrzc33iemdBsNOhGACeFY3I6Kn4oYX1KOkFJ4sFPrp1RvW6BvmiNqHuCt9RuDRI/d6xYHqv5PX4Ojxr4WrvtZSAObXqzXSsO8hPSsP676QYpsxXIeu0BpU+Eifhc5XIIbW3AXtBXlj1vmSeD6Q1NgBW5/2OU+5o50gtDyx4a3R49MfpRfzTUvwiX3bnRhaQisqvf5jMJIiPBpS29hnpyCi6Xq9lZmsBg8rlH2vDFzaX8iXdgWb0DyCXL0rjsOK0Vs0ubOYJv4GAs3u8NMYrcbDMHn5eLkpUkTxz+Tk3j29S6RminJoWSy/CsENIxmQ2yfDd2sd57zmkaOFGkn0UyoCRdu1w5GczheBIrXTVondI/+8zpsJfywjxK2a0kNxCooe1dFyd3nQz2P4mjh5NTAthOCOuCwTZIOzJ24cWsEmP8+9dPn6MWnzEeURcIapxzM/8WBsb2H35MTvjrWYSu3V4YOqJR/1qvdsZHMP2YozoHVMJel2FdkmGwxtnphw/duWqVYbsq97EysMIUfVjsdXra2yqyhGqKhGo3O8WVa9N6CtCBzYkxKffyeF0HJxgmHL+e/KHNGKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199021)(1076003)(26005)(38100700002)(86362001)(38350700002)(6506007)(36756003)(186003)(2906002)(44832011)(8676002)(8936002)(5660300002)(2616005)(83380400001)(41300700001)(107886003)(6916009)(4326008)(316002)(66476007)(66946007)(66556008)(6486002)(6512007)(966005)(6666004)(478600001)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEtuRXZOTnVVTUd4Si9IVXN1ZUd1enJtUWtwU2lyWFJENWFpK1VwdzNVY1Fr?=
 =?utf-8?B?SHpyTjlQOGVvblVlak1YZjZNU2hOL2szTjc4MHpvWXphbzFkUXA0TGVFUjdD?=
 =?utf-8?B?d3RxSWp1WGJsdTZZVUlRU2VwRDBtVXl2RE14cExINUx6L1J6TzlsOEpTcnZP?=
 =?utf-8?B?OGlaMSsrazNab3FtRVhmczg5Ky9BTGpLZzB1MzFUZDVCSEFxa1NOYlNkaTMw?=
 =?utf-8?B?eE1paVFjTWNyYUF0RUNkbFFaY2xoWlIyajQ3VHV0Q0pIWmdxWi83ZzAzN2dz?=
 =?utf-8?B?cDR0dTh2L0lOeGMxU2ZxUjQ1TVFtTVdiWUtydFBrS3lQbHc5MTRsdWR0R2tq?=
 =?utf-8?B?OWhwMnhNRTFjdWhPQUtUNno0bmNSc2RUcTZPdzhYYXUzY1FGclF1T2gzalEx?=
 =?utf-8?B?aEpjRjlIT3hBNHRGYkJTd0psQzVVTnNEUVlvK1lWVmFVMHVTdU5XRHhDUFM3?=
 =?utf-8?B?Vm45bUY3V0U5amxxTysyZE5ZSmhtcWFqTmpsekN0YXlGL2VCaWtIVUtMSEhQ?=
 =?utf-8?B?eU9STFIxZFgyN3pHQ25ZaDZBTTdENExJNDlzaVozei9ieDl6Q0tnUGw2Nm1k?=
 =?utf-8?B?dElYeFVidjBjdnBJak9jSW1sY2lPV3hZd2Q2b3M5UE1HWDRyRzl0LzFkKzF5?=
 =?utf-8?B?Und0Y2tmd2hDcTh5cmlxWnhEUk92R3FzRkl6QVBNZjU1QTlmQTl3UTdpd2RX?=
 =?utf-8?B?NGFNcXdSeHJVL1NGaTd0ZlJuZUVTWXQ1VDBmb1JuZmdRVDZUM1pnWUZyZ1Yv?=
 =?utf-8?B?d0VadzVvTk9OdHVPNjBGaTJWZUFERkV0V0JUTFdWcDdkTzk0amY0V1F1RUR6?=
 =?utf-8?B?RzljTFR1WkNiTHg0RXh4Z0hEdGc5QVplRW9RUTd6NlEveVBMMHVaS2paeWtN?=
 =?utf-8?B?YVZ2R2tqei81TjlKT212bXJWVW1YUTVJWFlkV2M2R2Nuend3Nms0a01ma2F0?=
 =?utf-8?B?WXJiN3ZQZjJpdVMvMk1HZzJWWjlGbldvTnduZlBuOTZoTW1JSWdKYXZ5aUpB?=
 =?utf-8?B?UFVaNXFoNThaLzM3bXJidTBMSTVnRlczVllPVjg3eTVySk1haHVQRk9wU2to?=
 =?utf-8?B?eWNQbEtIRmMyMjJrRkZBc3RBcU9JR3h2cmpvUE0wMER4SndsNVg5ejFKck00?=
 =?utf-8?B?SDl5VHJvT0E2NmcyODlYazZ1S1U2QTRkNkdnZTVCRFRHQXFveUNaQmhYenMw?=
 =?utf-8?B?OThDbUpuemFRMlZWaHZUZ05VZzl4UVVmL1Q5YlkrWExjOUFxOWwvWnJKNkxu?=
 =?utf-8?B?MnhtS2hUVUsxY1BsOFFsczZOODZKQkhkbWdsM2hrZzRrWWo5RnFEUURram52?=
 =?utf-8?B?UWErVndFOHptNUxFcVY5NG9za3VmNXVIbkpBTFpJUm90aE9rSVIyMzZzYkVj?=
 =?utf-8?B?NEkxQ3B1MU9TNndJU3pLMmQ3UnI4QUQ4dWplOTR0SmVxWDdZY0xaaS8vMWp5?=
 =?utf-8?B?MFNlbFhUMHhwOG5GQ3dXYnJzQ0h0dEIyQmJRNnhGZkE1dDVXNTcyblQ5K0Uz?=
 =?utf-8?B?WmV1dDYyQnZLOCs4RUt0QlNEWGwvS0YxZW4zTGRTbDRuZEVHamFQNjNpRGhi?=
 =?utf-8?B?NjVpaUFncExHUGNtY09MMDhLOEdiS3FWVnl5aEhROGhoZGM0MzM0MWhzUUN4?=
 =?utf-8?B?RzMydTZGUTg2TktSZzhIajRIcWkvQjQxRHRGMzNNR1J6czhhSGxqbHl2Y2lk?=
 =?utf-8?B?RzhEVmlDUHFqdW5neUpYSjJUUjhxcGdDYzE1TnlOL2RsYmk1ZWZLMHkzV281?=
 =?utf-8?B?dkRBTnhPZHFFS1ZLaXdiUGtiUjdyaU9qY2puZERaNEp6dnBIb1NzdEpkY0M0?=
 =?utf-8?B?Si9waWxTVGVpaVJUSmxEUFIyVmJMdURJZEdBUGszcC82L0FzeDY0djc4ODJx?=
 =?utf-8?B?THNwN2xpcmZGZkNad3diNkowdWZkSTRUbzF3TTFKN0kzUlJKcVMwbXJhUGk1?=
 =?utf-8?B?MThsUTY2L3lrY0lXamZWV0d4QlFralNMV3lFcFZrSk51MjZUMS9VSk5kUUxQ?=
 =?utf-8?B?aGV1Q2tMWHdMeTdPVzN6c1pDVXliRXVzb2U2NTJHZGZDWWdrNDlXRGhlOE50?=
 =?utf-8?B?c2dzVFpHYkRRU0VOdDVVVEpoejBZVFcvVFlLejlIYUZmdlRHZXJYdFVHNVZs?=
 =?utf-8?Q?3Rts4D90L6CFU6qO2e+rERhHG?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5ebca4-d0ba-4198-d51d-08db8de334c6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 14:18:38.8426 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTp139po1wu7feumcyBTEyuJEwwuUUOa3fa6AvUC7DXwK6ETfRdJZipXMLyNdFut4W+CVfkGc8Y58DhEjns5qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6861
X-Proofpoint-GUID: R-vXZ-uQQN7-5ut8B-lyzhp-GhxTAESS
X-Proofpoint-ORIG-GUID: R-vXZ-uQQN7-5ut8B-lyzhp-GhxTAESS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_06,2023-07-26_01,2023-05-22_02
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

This is v10 patchset of modified 'migrate' and 'migrate-incoming' QAPI design
for upstream review.

Would like to thank all the maintainers that actively participated in the v9
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

v9 -> v10 changelog:
-------------------
- Patch6 : Added extra checks for migration arguments.
- Patch8 : Added checks for 'uri' and 'channels' both not present.
- Patch9 : Missed adding hmp_handle_error call to print error messages.
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

 migration/exec.c               |  72 +++++++++----
 migration/exec.h               |   8 +-
 migration/migration-hmp-cmds.c |  17 ++-
 migration/migration.c          | 190 ++++++++++++++++++++++++++-------
 migration/migration.h          |   3 +-
 migration/rdma.c               |  34 +++---
 migration/rdma.h               |   6 +-
 migration/socket.c             |  39 ++-----
 migration/socket.h             |   7 +-
 qapi/migration.json            | 150 +++++++++++++++++++++++++-
 softmmu/vl.c                   |   2 +-
 tests/qtest/migration-test.c   |   7 +-
 12 files changed, 409 insertions(+), 126 deletions(-)

-- 
2.22.3


