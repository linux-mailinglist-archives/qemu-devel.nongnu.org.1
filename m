Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F66C723F2A
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 12:18:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Tjp-0001bg-5F; Tue, 06 Jun 2023 06:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q6Tje-0001ab-VI
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:16:19 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1q6Tjc-0006Mg-M9
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 06:16:18 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3567WVsh006549; Tue, 6 Jun 2023 03:16:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=proofpoint20171006;
 bh=dy9C1unEkvdFUMVnzLI2wqCpwUmWjUS/PyyuUA2GN5A=;
 b=kWdCb8NwrlkSnukikeSKJcWw1T48LdJ0Gy1rFgzt26MUeIHT0OEghYkTMBhJCw+rgDLR
 mJY9BaVp+PeMwpNa+DPZ2PXip14uqUrjL+M1xkYPT5vTJeH+k2xx8zS5K5CyOyXXLn06
 sJqJwA2bTtTGDxqf5kvhF06fomKVeLDFVKozSpPtQwFGgnRvI7rmfzPnC+iCY6PHEDoO
 Ef4UxEziMzxSZ/GzODrnZ1tMA0ScZkxMBNAgFHpLuE0bn2eYHG0shZENb1ixrLgIh3Xy
 7jaTj/v6A5Qkb4/bPsaeGyepLkEv/cCdyN7E6NiarmJT1JyCke7kiiIeAxKHmlmSUYS4 Qg== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3r04ucwdmd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jun 2023 03:16:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIr+Hicpca/XQ99XxLXmd3aHK08FNI2IC8h0gHV0o3do4lubxetG2oeSlTtvVyhuqK0BoIXKULdUTDAgjErrDHK1CppKt1FqQV+zbmQpgahR/8hxutruD3ZQ1Vj0gFVlsibnJzy11woobO0s/yJngMZ5ZX+QdM9QyeRBCvafWuOLmsHz7oVgZBHsNs3p065MssLqc74rZoyuFrGXq8KGTJcXmDdJ6B3ScBnXkWUu+876M4EVYcjmxsUE7QVF6EtUTKq8R+Kp5hOnyKZzYzKt+UFtOg4rO6vKQD4UGDW8xcGQqwATZ+xGfAXpUiFjhPGOlSLxoZbvtMkis1Z47dQtkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dy9C1unEkvdFUMVnzLI2wqCpwUmWjUS/PyyuUA2GN5A=;
 b=KN8IHCxOeJLA5twheyHBt2paBiWO2bdWzZvslkFlaz+IEG/kHrYxgqIg7ZMteeS5UHPvBYz+D6K0N0IOkC0Q8n/8mArTHHTlF6JQvvu0P7MDb4KZeon2ytD2jugcurAJPK+36vxGwsXdoiUNAVQLhC0NcJGo//vx8+MSg9v08O9p+Q/H8D9TLC9wl0hSihtFxvNjjiW6jgXChpYFwjPJ8i2XetJFuOEH0g8XBEpARNGlmiyUIT1eYvsCC2tCqZvZHFYbyAlCZsSYNiSYaCgCwoMqrWTDyCNWD71pnt1bevm9ZzK6T9S+whSvF9//siLg+CaKC8ECttRuY1GRGCljKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dy9C1unEkvdFUMVnzLI2wqCpwUmWjUS/PyyuUA2GN5A=;
 b=zI2862ieDMOaEqoP1/fmykn0z4VSHIvVoVX4E2t8duYfbhyK5msaWG9BLqtV3Wsyk7kLL6EL4xDNg88O1vpLiHbGSVeLRQ6UDY6S+sSnhEPDIn6BHWNrtygeXvOohsCFZA2dQtTA/O2K9mOBWFYouNtg/nR4jXdepj0XPnDmrdz7DCa9PBTht46L7Mrfqb+8b+mvWN6DL8syGqHmgNkzuwvu/M87sZHgfNFAhZKkfKV1CQ9VvsYyxec3/FPp7TlEonY1m6GJkkPIoeBwiA0waLj/nrkgRJV5ACbP3AePvAUABcY7UTK8gslHz4fpczU8zxXQvXe1DNHBMzgrl3UEPg==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by PH0PR02MB7797.namprd02.prod.outlook.com (2603:10b6:510:4c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 10:16:04 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 10:16:04 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v6 0/9] migration: Modify 'migrate' and 'migrate-incoming'
 QAPI commands for migration
Date: Tue,  6 Jun 2023 10:15:48 +0000
Message-Id: <20230606101557.202060-1-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0251.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::16) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|PH0PR02MB7797:EE_
X-MS-Office365-Filtering-Correlation-Id: a094978a-ab30-4aa9-a4bb-08db667708d2
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WRL9spFnSBc4r8QPBqIRN+X+KlQKYxTvmUZHUI88VZN7utTf19NCo9d+VUBr5vOequkZ+EEkGBL4ex7EFy2FYyGRNefxlfqcDeUSK6mnn74sLlAJcLtTAl+9u2j8dQjLcq1HdAuh9M0KIoIx7sVCbn8wvx05dSp1dFDMRq4Oc8mlhR3ZdAIXnf479pRIuDPiTmhzo1OyrRhPl0AsvBwNeqnMqo+cz0nvVA+IIlo2kpBkfWMPv1ic7XU9Ba5G15niV2X1X2GbIyzvZCKaHpFNMdqef2TZNR1b8zDXyMEQsiRDsNokx9xYTBP327CxEBE8uyeMaxxN4/jeiZe7cV4EV7Ab8f5XdJSLRTc6+iWAtbSSadpNFRdKMe5o2Gtvb3boy2fwAbHnE2YqpN5catZ5fV9BmJ5aihapxlFft4VhyqElCRrpA+/lO9k8RYFD3rliBYp8LVRjpkIjO+jWWN1oLrAMFsMguefGKvr5QxtpbzsjM55VFmEbfqrA8twB4emrRGio85UzVKmE/vSU0QnKlNx7yDllVJ6OvCgTYRWcNmH+2rayOXif/TM8pqlp9M9mWDHGwVZK3Ft/AFibiLIRCvcmr2hgoiSLe3isn/Bt6Q0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199021)(186003)(478600001)(6916009)(8676002)(8936002)(4326008)(38350700002)(41300700001)(66946007)(38100700002)(316002)(66556008)(66476007)(2616005)(83380400001)(6486002)(966005)(6666004)(52116002)(1076003)(26005)(6512007)(6506007)(107886003)(86362001)(44832011)(5660300002)(2906002)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlpYNmlPTUhPd1NpaGtxUlcxZzYzcmk4U092cTJwdUZ3ck42MVFWMnVaV3N0?=
 =?utf-8?B?OTJoSkJzWVNEZ0pzckFzeHkrNld0SWZCN25rdzFsL0hDSzlDN296RGp4UHI1?=
 =?utf-8?B?RkRJalpaOXVFWFVkVm1UdHFPNkpxQjhoV3ZyR3NTSVBTVkNRVnFVb05uSkUv?=
 =?utf-8?B?T3d5UGRTUU4vWU9HbGdNVHcwa3oydVJ4VENlcGVyaU9reEhpc3RxSTRXYXNE?=
 =?utf-8?B?c2I3b0JMak9EWGJNWEVQejhxeDVwNlFCdFVDMi80aW1jZks5ZlVTY0V4MGln?=
 =?utf-8?B?VHg1N0YyUjQyNkJ5bDdUWmNyNVYrSHlDOWdPV0pSaDFkUXZ5aUo2MW9TM0x3?=
 =?utf-8?B?L0lyYjhmeW9TRGM1ZzQwNGcyM2VvMzlmaEh3a0tCMHVkbCs4RU1NZlQ5aGYz?=
 =?utf-8?B?SVZ3ckw5NnpKUmQ3NURmMUlPeC9RblMyZlZqVW9zV3M3YlpSMkNjUWlRSVRu?=
 =?utf-8?B?bmcwUUhIQ25IeFRnUk1xLzZ3UDdEaFlYS0RLRnJMbmxVOHhrMUc5eEt4TVNR?=
 =?utf-8?B?Qk45NXg4ZWFQTHRmUE00V05FODA0RGNlYXZLeWNDVk1MZkh3Skw0SXRuVUxu?=
 =?utf-8?B?S09LaUxNcVlVcXN5VnlMOC9idHhKaDc5aVJRQnVDVlpFMjV5K2pyVldMSzJ6?=
 =?utf-8?B?b2pudE9iZmd6NCtCVm9QdmF6WTBqWFZBRjJCZkhzb3NnZTJmZWo3aGYvM0J5?=
 =?utf-8?B?SWY0RFdnYnkvMnNyeW0wcWJzc3NTT2M1UFFwTGdhckFwU0pudUVyUnVidEVl?=
 =?utf-8?B?OG4yU1Y0c3VlWmtsQWsyOW8zNDBCY3Bzd1FETW0wai94TzVYdXBhSVkwazdz?=
 =?utf-8?B?NituVXJuejIrV09pRmtna3JJcFl5L2I4ckR5Mm9SSmVzZFZnL2QxNllJRGcy?=
 =?utf-8?B?QVlqMmZGTllYZE1IWDk1RTlnQUhDaUFwME5XQlRJZThqcTlzOFc0UGpyUUV0?=
 =?utf-8?B?MVlldS81RHB0VGhMSEd4eGlWOFgvT0F4L3ZWOURjSC9LTW42UTZ0YlJFa3lB?=
 =?utf-8?B?SFJMTFdQZGVxeURFa0ZiRklUdlpJVC9Ba2FvdWptNTZVQUMzNUZYY1g5dW1s?=
 =?utf-8?B?WlVsWFh1YVBlNm40Q21lemZiS3ZHeXExV3BNUndBcUF5aFpMYy9ZcStMc3Vo?=
 =?utf-8?B?dEgvdDNmVWNPdHVmeEVrYVFhNzhmMEZydVpnTEdoQUFxelM1aTZWSW5TN1pw?=
 =?utf-8?B?ZFp6M0VQSi9pMEp3dG9vMWZHbnVHRy9iU1NxOHM2YTliR1o4VTA4OEc1Q01v?=
 =?utf-8?B?SENZUWprYzVuMWFVOWpuMlVXSWkwdTdpdzZLL3Y4bTRhU3U2N0k3dUNjRVBN?=
 =?utf-8?B?K3JmTEZ2aVFkaTYrUGwrcHhzc1NLTGxSVHlQQ1V2b3EzbTJLdWhBNmVsem1M?=
 =?utf-8?B?d0RZRXZkaitKeXpsRzh0SDdLQ25ZT044VmQvL1VWcUJLYlMxOHdEMEdLa3Nk?=
 =?utf-8?B?anNLYkx4STR1WWpCMjU1eTdNOWp3K1lIVlY5WWZEaUNjaGwwUGNUWmQ3NlN6?=
 =?utf-8?B?YzBlaFlxZW9Gb1NwcXpkelNKSDFRUGZhUDYzaUpYc2ZMd0RrZEhXK05lcE45?=
 =?utf-8?B?bUdUUkY3YXUvTWlmQUd6YmtKc3BobndHZG9Gb0d6WEc1bFd2MWlqSCsxNW1K?=
 =?utf-8?B?OUhlOTBXejJXRTNXTjIyTmY1RU1XU200SGJBMVdZMlBOeWNpdmNUMTZkVjJJ?=
 =?utf-8?B?QXdDUlIvaFl2bmwyR2hRZ092V2tNOEFDL2pSTDJjWGZqbnkvaVhVdUMrUUsz?=
 =?utf-8?B?TnRJZGNVdUFEYnNHWFNVb2k2QXRRMUs2ZVNuNFZuT01sR2hUUDNWREFCU3Jj?=
 =?utf-8?B?UmJBYVdzVk1OYTlBSXNWVXFkS2FYaFVwbmV2RDM5MmNnS0ZxdUZyMnFrbm1R?=
 =?utf-8?B?OTRVZVVCNnhwZVFRM3UzWWN6ejB6eCsvZkljUE1qTDVEU1MzNGx0SFU5MWNH?=
 =?utf-8?B?bFFROXBPWk5sMi81QXdCTHNsemgrUTJvTlJKMzd3YmU4dXFwc0hKT2p3cjRL?=
 =?utf-8?B?NnpVY2VRWnRrVmVzbjEwNkp4M0UzMW5iaGNRRk5IYy8rOU13VS9Jc1laTUtu?=
 =?utf-8?B?OXRkTlRCR1pKUHc4SmNVOWFUWXcvVE9hZnhZSWtFZjB2eCtaSVhGT0FIa0JV?=
 =?utf-8?Q?MPJqitGVp7+oJZYFyeGOhzf9v?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a094978a-ab30-4aa9-a4bb-08db667708d2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 10:16:03.9717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /GAI3O+njz5YoBy73gRzy1whltQodChdU6343k5VZw7Jk5DYdAvQzk6YGRW/eSMDn+dVbsV31wI3M2cK/KSXcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7797
X-Proofpoint-ORIG-GUID: IZuTy-6rkMmcD9gtyGCGU6JfWD2QkCxV
X-Proofpoint-GUID: IZuTy-6rkMmcD9gtyGCGU6JfWD2QkCxV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_06,2023-06-06_01,2023-05-22_02
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

This is v6 patchset of modified 'migrate' and 'migrate-incoming' QAPI design
for upstream review.

Would like to thank all the maintainers that actively participated in the v5
patchset discussion and gave insightful suggestions to improve the patches.


Link to previous upstream community patchset links:
v1: https://lists.gnu.org/archive/html/qemu-devel/2022-12/msg04339.html
v2: https://lists.gnu.org/archive/html/qemu-devel/2023-02/msg02106.html
v3: https://lists.gnu.org/archive/html/qemu-devel/2023-02/msg02473.html
v4: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg03064.html
v5: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg04845.html

v5 -> v6 changelog:
-------------------
- Most changes on the QAPI side, i.e. Patch 1 and Patch 6.
- Formatting, improvemnt around migration qapi documentation.
- Resolved build issue while building Qemu with compiler as Clang.
- Restructured migration unit tests due to recent change aca0406
  (tests/qtest: replace wait_command() with qtest......) 

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

 migration/exec.c               |  72 +++++++++----
 migration/exec.h               |   8 +-
 migration/migration-hmp-cmds.c |  16 ++-
 migration/migration.c          | 182 ++++++++++++++++++++++++++-------
 migration/rdma.c               |  34 +++---
 migration/rdma.h               |   6 +-
 migration/socket.c             |  39 ++-----
 migration/socket.h             |   7 +-
 qapi/migration.json            | 154 +++++++++++++++++++++++++++-
 softmmu/vl.c                   |   2 +-
 tests/qtest/migration-test.c   |  45 ++++++++
 11 files changed, 439 insertions(+), 126 deletions(-)

-- 
2.22.3


