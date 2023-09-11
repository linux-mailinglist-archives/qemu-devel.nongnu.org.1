Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7CE79AB0F
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 21:19:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfmPx-00034d-Cd; Mon, 11 Sep 2023 15:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qfmPu-00034P-PU
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 15:17:50 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qfmPq-0008Oo-Uc
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 15:17:50 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38BChSRm011024; Mon, 11 Sep 2023 19:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Ee2gVZyxXPZCe0hqPMqRCEgGknxVc4949hdUWGDseIE=;
 b=dMLnGv0FZ/7viPzT/YS/+b21vi3SyqIIgauBc4Ki/Vysjqp32euQyxZp/NLFQgPisTim
 ylbiVIgT2EjepjJVlNmkD2B08xRXqrm/skudaG2vD+i3kHdTdrvTsSoo1TLV0Ctgsn8a
 JTZqiH834D0S+c7OgnR/cuGVncvW2W7hEztM7MUI4aH7z0E4f3MC94TA+7vkQ9Pw56iM
 1CyQlxfF6+wkK6hdGKicFZ0ymCoRdIBwuea07tdiin8FrtXwBQKJsAHExEaGBMoXCURp
 7nf00vn2TcuNDF1sshx/5/0qr4gr+BYLndCbSmOoaoEf/MS6ijVUt7fHlvvlFD6Q8uiA Ew== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1ju1t8v5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Sep 2023 19:17:42 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38BIucwn004350; Mon, 11 Sep 2023 19:17:41 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3t0f55dyyg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Sep 2023 19:17:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqXirKv2GJnHeFF0vCFTsPPC2v4fvwRJOaeN7iV2GIvlAUMUE1NPU2xftRnnMMDXUwmBAV4tXIOHLOMhfTj4jYYMiDUdFxLMRjYO/fPeJsOwhUjki7hZEeZem6We1YE20A/9uc+6Qm+kamymBy6KhFB8erDb1LJKu0oNEqTb8/BiYy2ZyVfvhMqdDoy3IdhsQlCQ1Vm7lzJYpuu7RkoN5TWJThDkVpue/x6LrjIOpCst/pbXJbj0DWxNFTz0Ea2FQndQLcosdK9BmW6grDQv5lmNSBsShQzLzcoXvks1n9tkAiKLCQANIpA8G25Uat7hHRLDbftEif1lSnnhpbp4qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ee2gVZyxXPZCe0hqPMqRCEgGknxVc4949hdUWGDseIE=;
 b=KHqKh5G+NZ/LELdCGh72vOEVKh/s7B6QK7KS6iJZEi1oaESI7u2S2o3AjBoS0ovFuIZghaT+mG9OFg33C023vzOy1v/JbM3JYeHbe7AM/bL7/O4GcNWt4AOPAaid2Q2IQoO7BCr7KqHELDNkCm20J+SuwP2/44dwlclupKPaxS7m7MWuwd5UijmUIoHbZa1JdGgZyctdLCLYvxRYEUo8uQTg6evVdB8JwwD+BcE+SoByCpxCHwpK8aBuiPO9ada32Y4nxHEFI62qGuMWj9VNr5xUSHe34zKwe9uXMRML4KCR6VrU0Ays2cAaj2kglkYouLUyHACxap+FAvxXDR9hyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ee2gVZyxXPZCe0hqPMqRCEgGknxVc4949hdUWGDseIE=;
 b=dOUn0SB38XpoJKQzyLd5GYptNHlxyM7o4hN1hXQ2hksjQL6u1rfxctwbPZRbEDPOwejCyK055cFqTN6IgONKC7oT9mICL3u3iaXeU4jhWNjaFlDiWllYoTp49+4c3tx8sK0yQNMMezHh48/MMqNrgn9m389dKoZPfd/7x66Pfac=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by PH8PR10MB6573.namprd10.prod.outlook.com (2603:10b6:510:227::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Mon, 11 Sep
 2023 19:17:38 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67%7]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 19:17:38 +0000
Message-ID: <a284507b-9f6f-455a-9dfe-ccaeb974da4f@oracle.com>
Date: Mon, 11 Sep 2023 20:17:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] vfio/common: Separate vfio-pci ranges
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Cedric Le Goater <clg@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20230908092944.47589-1-joao.m.martins@oracle.com>
 <SJ0PR11MB67441FE6EAE5A0AB8992FEF792F2A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <83d2de3c-7a3d-4943-d4b5-1f4a86030512@oracle.com>
 <SJ0PR11MB6744CC7FE6F48E7D17ABC3CC92F2A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <c2a52c37-b6e5-1229-3e22-90a5ad8068b6@oracle.com>
 <20230911123524.2cf53cbb.alex.williamson@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20230911123524.2cf53cbb.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::19) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|PH8PR10MB6573:EE_
X-MS-Office365-Filtering-Correlation-Id: f7f0a192-cd67-4b06-7477-08dbb2fbc2d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NBq6hCxMAVGVfoX+L2E0JFaZn9X4LAljQRWbM7QbwUkLAQywSIn/mP0viYZWv+Hg8MOCNf6bqlXM0v5Caua+o8Jom5vV62s1H1nL4VZo7aoyKvjWGw+qZJ32qVIYA60vWmUYY7pGUpXW/eJePjZI+iVlaCeJNebUIm7Ogf8ZutbgAAxdq7p/PuJEwdm4TWvpRcP/Xg+U35muxWsfbjzOL9QeBJIx7U0taKi0pr42cIi459MkUqT6NXf7K0DGMnuKB+dYG30DMXwc8I08NE+vd93dQuJH8gqHjd8kH/2lPa7sQ+alSqtP48ZXjmkHnieIHHQoibPnP8NWYxNxMTDUR/TI+VQt4HMj2YPqUyJIFihhPtB4bf9z3pb8msV/YxKkVW/fs2bx/AZRAgkrUrDK0JeBfDqpPexNl71ooOzMo8vUTgVvS4tPBOV36KsGxf4HzhzvW8JwnQmFZPmQ3lL6dSPxOaA9MxcdOhMrQz/Y9BzSB7ngU0rwfavC5DoQFeZF4+JwFjMsJiuVxIFJj/DDhI7YkD74C6NqG5DCmbgkT3rhR1EkuT1M2L0IIzk9jvx2X/FiM60xS+N/KltWrJpbg2vmEk6pzmlE1NIEgh5U80WILZbW1mWMx0REn/js96eKa6OZM/h4oEz5z7gh8gEp5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(366004)(39860400002)(346002)(376002)(451199024)(186009)(1800799009)(8936002)(6666004)(6486002)(41300700001)(66556008)(66946007)(6916009)(31686004)(5660300002)(4326008)(478600001)(53546011)(54906003)(2906002)(6506007)(6512007)(316002)(8676002)(26005)(2616005)(66476007)(83380400001)(66574015)(38100700002)(86362001)(31696002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2xSb2ltSXp0UHBQZjEraU93VGg3ZjVicjkvRHh6NzZNS01lRzlXNjcwVkZB?=
 =?utf-8?B?VEdWbFJZWndpSHBPb1JKeEdZN3NXUXF0R042eTVmRHFkVmhROUVFeVhjeVYv?=
 =?utf-8?B?NlJlRFlYMFprdldFRytPMDR4Vkw3bkFrTW9GNmRwZkhVODM0M2pJZ3MxNVJz?=
 =?utf-8?B?NU1kSEdNam1WWGxiWHR5aEE4Q0tkQ1dPNTlrZVhOYmR5bVNGa3dJeUEzRVRx?=
 =?utf-8?B?VEk4U2R0TmhLZ3JROUFXMVNNZW1uQXVIZ2w4bnoyY3ZyTnpyQkE0YkI3UFdt?=
 =?utf-8?B?MjhVRDdsb0hJTHpjcWYzR0tiS3dVcWhRcU5sVm9jY2VLVTdsWTdDR0liS2l5?=
 =?utf-8?B?ZXVudWl2MDFOUWp1VTdNM2xwYjRNajVyOUxlSzB3YmNLVmVwYmZIMUkxTitm?=
 =?utf-8?B?VGxIanIyM2R4cGNGdFJiZTNZMlFwQkJRbzdGYUFIQ2R2TWJtU1RCY1E0V1ly?=
 =?utf-8?B?YTNKTVBCTTQ3QlkwTE1Hd0VLYlNnUWx3c3JiekM3blprT3l1NmJKMFpuZENJ?=
 =?utf-8?B?TmdDWXROODFHb2dNcmMvOWdUZWcwY3dad3JObkxmRFpNaTMwWTdoR20zc1dG?=
 =?utf-8?B?WHE4aVJ2cXFUN1gwRGNVT0txOUlsTmJ6dnREczVaK1ZFd0J5VGFaZHo4RW42?=
 =?utf-8?B?ODFvNTl0RzgxR1pPNWorb0VPZEhBQkJoNlhscmdVQ0JJR29BQTBMOXJTV25m?=
 =?utf-8?B?ODFYSWRDR2xkME0rTzBFQ1U1dzBOYytEc1ZlelFXZ285Q1JpeHdVVlRML3N2?=
 =?utf-8?B?YitCR2NWOEs4T3Z5NHRaNWJOR29BYWR6QkYxTzFDejF5WTBHeFFQMmVERUtK?=
 =?utf-8?B?Mzlra2VtVENMN3ZPdlFQVTNnbVZkZmlLS2IzVzNUdzZUV2Q3ZXlpdnNPZTBO?=
 =?utf-8?B?ZVZ3NUc5bEJ0Wm14SVdxMkNDN3pTOU42cW9BL3RnNHo4RTFaOXZJS2orcnVo?=
 =?utf-8?B?UWV2WDd6M2dDVmRENjFRbFY5SGJQUjRCcG9mRjk1SXNoMnNkNGQyeFpyMGJV?=
 =?utf-8?B?QzYyZEVrOHQ4ZmRPVmdIbGdRcFVWWEliTUVCcHpJMFpUSzFoN0YxNWFmOGZh?=
 =?utf-8?B?VXlhVU1FaFpLdnVCei9jenJ1WEZ6ZTVXazdVaEJkQXJtNjJSd1NvbG9xd0JD?=
 =?utf-8?B?bmRqWncxZ1lPRDlRc3dXeERVMzdjeld5bzRCZ1lMeTJTL095Nk1WOUJVT2VR?=
 =?utf-8?B?bWkvMW00dFg3K0VWL21xOFFISWV3dGtWTXNIYVdoWG5IUDk0UG9oSVlCWHZP?=
 =?utf-8?B?YUk5MGFBZ0NXa0NHb1N6ZjB0UE1wcWVhSm91WDdzUW1hS2dXdGZ1bG4xVGlv?=
 =?utf-8?B?bGxZbVlCRFZIbElUR2pWeTJhZENuaWtLbzBwVUdwRFlqSiswN0xITG1xN2JI?=
 =?utf-8?B?Y3EzWUVYaXRqc3krNjkrOTdvc3QxV1ZDd3BNZmdmcFEvY0doelp1Q1lBUzFH?=
 =?utf-8?B?K0RCcGYxK2o4SzVpT252RHR5b21mdnNUTUZZS3d2UmJNM0lGRDVxY29tdjZa?=
 =?utf-8?B?SWJPWjFBK1BhSk1QN0VnY2kvVW1uWFd4cC9PTVVuVi8zb0M3NXF5ekUzaTNq?=
 =?utf-8?B?WXFrS2l4RUdZZyt2YUQrOThIVXNHakFzWFZndVpPdUJReUczcTlaSkZrVTQx?=
 =?utf-8?B?cGdzdkhxQ1pqWEZiQnd0RzZGejlIOTFHNVhjTnhEbjRqRzRzdURBUXNzWk5o?=
 =?utf-8?B?TFBwaDVPNVZSSFZlSE95aDNZWUR2QkpKaDV2RzcyNC9WSDIwYnRPSVpBWTg3?=
 =?utf-8?B?a3V4cEFJd0hLeUYreElLdEhSZCtUMlVhVnpWd0x0Q3diRjh3MXNQVmp2VXNr?=
 =?utf-8?B?UUdMQlEzOFdCNkVZSGVCVTYvS3A4Zmx2aVNkbWZqSVpVcDlDME45dFFaaW5k?=
 =?utf-8?B?Tkc2cHBQUjVWTXB3ZHZoN3pMelJtNXRFNXRLd3VxZG1EL1N1TEZBY1phRnZF?=
 =?utf-8?B?QkFqUSt5ZTR5VHhWNEJyNmhZUFVvWFRUd3ZuaDdrSXpSQlNRN3p1NEMyRkxX?=
 =?utf-8?B?dUkrWmVPVVVaL0tKOFpUbnU2ZUlRb3dYeHhGQUZBWDJIeGh4N2JXRFg0K0Zk?=
 =?utf-8?B?d2dwTm0xUlBKbnRsald5WVNySEJWTWdlQTJ3ZXhqL1ZOdUpMMFNURndGdUNG?=
 =?utf-8?B?S1FLdmRuSXAwdDRjZDhhM3l3eWxUdkpmdWN1UExTQURQRm1XYmhheW9MTG9Z?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VpWA7LeRgDxTXz6rW6HKaLxAK8fP6o+tqZVc/ccOlDHGw50oVf/TeDu8TdvA5id4FB1lxfQX73LLHNAvY/TCOguF1on/ObMXcF73TereiCOpPRv/lMb75RZ2Q/tBZ/7k+Ng0w7k5c2m2f8xmuJaxa6MIHdpjWgeZ5F6lDEjnkoy5XGBfc9eB5Gi4w7OtyJNEVsfnB3GCAtc5ptRyuT3xvSpBSz8Pec+j03NV9YJa8a+yNTBSXNfHrjRnfYVYX9V+USoPCsU63sOiTAVGY33KsWDTAuFX47zUW2tGpPeq+stdArs4lOsSiD2/Ebj8fOfXxahOwRuusg0VGWrJwZMHfpaonJWHoUcmzgy6V1UaGOPW/1gBqnXLdfQ6qhH0LcJ/Olx8rPvCW5lhMi2CWghsdQd4BEPq4zyrwUDbIWnlZjGNxjxH4A0bBw52Ai8HyXl2INHUNXQVThB4UILh0VfpR0Uf1kvM+UEAzDYjsd02QLtVtX8evWhewlSkot0jSEk5CCH/HUx1l7JIdRB2Foyfmc7cAcIURW0y2WHQAzI8IBYf5lFUH6j1cNVLb8uB15noznCgCTjI3rQO/pt+zxYYRZquqRVSfBs2KfJWeoqi4JKzlOkGQAiAFE1j8+z+KcGCA1drZT3a8YlRjCQfTecFkDE4P508AxVAjYKoC9evn9pAivNS/UkcaqOnvqT+bMo+H+Muek11yCY+2ROb/7dZWXMa+ReFKFyYQ7kxk6a14CUJ/dpV2/4gUh+dIV6wYALuqczX8R9quHiYVVeOIhFLHgvVndDcftxwlcIAuh0jVkPAJgG3Gd8tRKDSUQ8d+99x/QP9l1isOkLpXsLQDU5MAg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f0a192-cd67-4b06-7477-08dbb2fbc2d8
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 19:17:38.0467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pKQDM4tJoUxYyOZANpk7UWWg39rN13hlCzYAs8SyDNkhiUSZreDtPZqCe6HDyoV4r3GekyM7pEtX7bSVgpwlpLtSGHEME95Bk53xdbHsvhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6573
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_15,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309110177
X-Proofpoint-GUID: nPUPvKfd9PrxcfRhxB3pBxKhijJFh4Pv
X-Proofpoint-ORIG-GUID: nPUPvKfd9PrxcfRhxB3pBxKhijJFh4Pv
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 11/09/2023 19:35, Alex Williamson wrote:
> On Mon, 11 Sep 2023 11:12:55 +0100
> Joao Martins <joao.m.martins@oracle.com> wrote:
> 
>> On 11/09/2023 10:48, Duan, Zhenzhong wrote:
>>>> -----Original Message-----
>>>> From: Joao Martins <joao.m.martins@oracle.com>
>>>> Sent: Monday, September 11, 2023 5:07 PM
>>>> Subject: Re: [PATCH v1] vfio/common: Separate vfio-pci ranges
>>>>
>>>> On 11/09/2023 09:57, Duan, Zhenzhong wrote:  
>>>>>> -----Original Message-----
>>>>>> From: qemu-devel-bounces+zhenzhong.duan=intel.com@nongnu.org <qemu-
>>>>>> devel-bounces+zhenzhong.duan=intel.com@nongnu.org> On Behalf Of Joao
>>>>>> Martins
>>>>>> Sent: Friday, September 8, 2023 5:30 PM
>>>>>> Subject: [PATCH v1] vfio/common: Separate vfio-pci ranges
>>>>>>
>>>>>> QEMU computes the DMA logging ranges for two predefined ranges: 32-bit
>>>>>> and 64-bit. In the OVMF case, when the dynamic MMIO window is enabled,
>>>>>> QEMU includes in the 64-bit range the RAM regions at the lower part
>>>>>> and vfio-pci device RAM regions which are at the top of the address
>>>>>> space. This range contains a large gap and the size can be bigger than
>>>>>> the dirty tracking HW limits of some devices (MLX5 has a 2^42 limit).
>>>>>>
>>>>>> To avoid such large ranges, introduce a new PCI range covering the
>>>>>> vfio-pci device RAM regions, this only if the addresses are above 4GB
>>>>>> to avoid breaking potential SeaBIOS guests.
>>>>>>
>>>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>>>> [ clg: - wrote commit log
>>>>>>       - fixed overlapping 32-bit and PCI ranges when using SeaBIOS ]
>>>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>>>>> ---
>>>>>> v2:
>>>>>> * s/minpci/minpci64/
>>>>>> * s/maxpci/maxpci64/
>>>>>> * Expand comment to cover the pci-hole64 and why we don't do special
>>>>>>  handling of pci-hole32.
>>>>>> ---
>>>>>> hw/vfio/common.c     | 71 +++++++++++++++++++++++++++++++++++++-------
>>>>>> hw/vfio/trace-events |  2 +-
>>>>>> 2 files changed, 61 insertions(+), 12 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>>>>> index 237101d03844..134649226d43 100644
>>>>>> --- a/hw/vfio/common.c
>>>>>> +++ b/hw/vfio/common.c
>>>>>> @@ -27,6 +27,7 @@
>>>>>>
>>>>>> #include "hw/vfio/vfio-common.h"
>>>>>> #include "hw/vfio/vfio.h"
>>>>>> +#include "hw/vfio/pci.h"
>>>>>> #include "exec/address-spaces.h"
>>>>>> #include "exec/memory.h"
>>>>>> #include "exec/ram_addr.h"
>>>>>> @@ -1400,6 +1401,8 @@ typedef struct VFIODirtyRanges {
>>>>>>     hwaddr max32;
>>>>>>     hwaddr min64;
>>>>>>     hwaddr max64;
>>>>>> +    hwaddr minpci64;
>>>>>> +    hwaddr maxpci64;
>>>>>> } VFIODirtyRanges;
>>>>>>
>>>>>> typedef struct VFIODirtyRangesListener {
>>>>>> @@ -1408,6 +1411,31 @@ typedef struct VFIODirtyRangesListener {
>>>>>>     MemoryListener listener;
>>>>>> } VFIODirtyRangesListener;
>>>>>>
>>>>>> +static bool vfio_section_is_vfio_pci(MemoryRegionSection *section,
>>>>>> +                                     VFIOContainer *container)
>>>>>> +{
>>>>>> +    VFIOPCIDevice *pcidev;
>>>>>> +    VFIODevice *vbasedev;
>>>>>> +    VFIOGroup *group;
>>>>>> +    Object *owner;
>>>>>> +
>>>>>> +    owner = memory_region_owner(section->mr);
>>>>>> +
>>>>>> +    QLIST_FOREACH(group, &container->group_list, container_next) {
>>>>>> +        QLIST_FOREACH(vbasedev, &group->device_list, next) {
>>>>>> +            if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
>>>>>> +                continue;
>>>>>> +            }
>>>>>> +            pcidev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
>>>>>> +            if (OBJECT(pcidev) == owner) {
>>>>>> +                return true;
>>>>>> +            }
>>>>>> +        }
>>>>>> +    }
>>>>>> +
>>>>>> +    return false;
>>>>>> +}  
>>>>>
>>>>> What about simplify it with memory_region_is_ram_device()?
>>>>> This way vdpa device could also be included.
>>>>>  
>>>>
>>>> Note that the check is not interested in RAM (or any other kinda of memory like
>>>> VGA). That's covered in the 32-64 ranges. But rather in any PCI device RAM that
>>>> would fall in the 64-bit PCI hole. Would memory_region_is_ram_device() really
>>>> cover it? If so, I am all for the simplification.  
>>>
>>> Ram device is used not only by vfio pci bars but also host notifier of vdpa and vhost-user.
>>>
>>> I have another question, previously I think vfio pci bars are device states and
>>> save/restored through VFIO migration protocol, so we don't need to dirty
>>> tracking them. Do I understand wrong?  
>>
>> The general thinking of device dirty tracking is to track all addressable IOVAs.
>> But you do raise a good question. My understanding is that migrating the bars
>> *as is* might be device migration specific (not a guarantee?); the save file and
>> precopy interface are the only places we transfer from/to the data and it's just
>> opaque data, not bars or anything formatted specifically -- so if we migrate
>> bars it is hidden in what device f/w wants to move. Might be that BARs aren't
>> even needed as they are sort of scratch space from h/w side. Ultimately, the
>> dirty tracker is the one reporting the values, and the device h/w chooses to not
>> report those IOVAs as dirty then nothing changes.
> 
> I think ram_device is somewhat controversial, only a few select device
> types make use of it, so for example an emulated NIC not making use of
> ram_device might still exist within the IOVA aperture of the device.
> 
> It does however seem strange to me to include the MMIO space of other
> devices in the dirty tracking of the vfio device.  I'm not sure it's
> really the vfio device's place to report MMIO within another device as
> dirty.  Saving grace being that this likely doesn't really occur
> currently, but should the vfio device even exert any resources for
> tracking such ranges?
> 
I suppose we could be strict to RAM only and its own device PCI ranges
(excluding others like VGA and etc); it makes conceptual sense. And when
mixing up devices with big RAM ranges (*if any* it may stress the dirty tracker
more than it should.

> A concern with simply trying to define RAM vs PCI ranges is that QEMU
> is pretty fluid about the VM layout.  For example, what prevents us
> from having a NUMA configuration where one memory node might be
> similarly disjoint as between RAM and PCI memory here?  TBH, I thought
> this was why we had the combine_iova_ranges() function in the kernel so
> that QEMU simply wrote through the dirty tracking ranges and the driver
> combined them as necessary based on their own constraints.

And I think it was ... as userspace can still pass very random set of ranges, so
h/w driver may need do some filtering. The initial versions took that approach
i.e. store everything, and let the kernel select what it wants to pass to
hardware. But we ended up with this dual/three range tracking to simplify the
logic as I recall. Perhaps how we started (via IOVATree) was the wrong data
structure on my end, and even switching to a simpler data struture, there will
always be the dynamical behaviour that we need to re-allocate the ranges as we go.

	Joao

