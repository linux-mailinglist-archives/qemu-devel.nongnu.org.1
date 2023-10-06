Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 691167BBE3E
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 20:01:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qop7o-0004hJ-NX; Fri, 06 Oct 2023 14:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qop7m-0004h7-Dn
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 14:00:30 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qop7d-0005Jf-1u
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 14:00:30 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 396Cc9Iu024506; Fri, 6 Oct 2023 17:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=eP6hjLDbig2El5k+d7Le4zoQteqtsbsu9Jiv3i7ats4=;
 b=wIWMUX147m9dW+DGh81s76b3JaqcaKi0+UPfARNAOKPLcPnFJeUfXpZ9DZlMY4Pn7j6c
 6NnIekb21fWutRmMGUo4TeFi/GSLXw/I1PHeBb4gwpevgwnzD8+3vxPnKydAldPORtQJ
 PBtAjzBs6b8SRmqF7K2WyV33GtHF68vEwHeMbx/cTJ1FlZVIV37gWMYJFRxKJ+gH2Bn+
 AhDZmbX5adSA6yh73ASAzoJ0JXSoBqUTz6OttQusjlrlpO78adWHJ2ZZ7zowYGnXWYMK
 LUXovia79YNpveWw/goph3pFq5r8QMW4FKr9ueqnPzCTToDklfqbwZaGn8WLQf/RNT6K ew== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tebjc47rh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Oct 2023 17:59:50 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 396H1eMS003183; Fri, 6 Oct 2023 17:59:48 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3tea4axwdw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Oct 2023 17:59:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMlm995jHJoxvxdLlv0qIO4vd+Mq2Mv+7WMuncQDP18Aj2qqRmGjpxQWl2JZoJxKosYjLCJsl8BsCo4yZwhh7ZHe5I0RfG2PZj20X2amnF69uNr5xW2CSY5hIHBsWDGLY3XxasY5DI0lDkjiFIFJwZcGuCS2jsz069v0HKqUbUReJHop+YUns8gzQ/qUrgtJGHdk4lrv5aGK2FEvA9uhGdbpsW2Y3HTgMoGV8EQqSTy6nypjytKEW6gA3jn7ehbGFgPn1TLreOWNLNIAaiQtVjIERALArqZ8+z4Mu3iTn6DN6YPvw+pcukS+2YMWsLtqwgh6T46c7J1ANtqfInrMog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eP6hjLDbig2El5k+d7Le4zoQteqtsbsu9Jiv3i7ats4=;
 b=kaczBOGAxEaIkjkM/cROikbucsbIUhoGIJswN4KrgCc+vLxAEHv5FOWwtRkSLjKShcT70C3T0LylrM3sdzc0ljcjfA5PjBbGBzMpDvn6wRu5aMJOW//Cd+lI2mi1ydgGuewlJ0U/il7YDEKrEL0kN3tnNqAkF3TgwSzg0iyzYtcjBQqKFYqLPsiVPJnawHClFCyo2WWeXeY/V/STX48GDmgZPQK2Wb/IcfEwChoQQCKplneCxLu5+McqZOQVWKHtwsUe6cB4n86FKSjiujaBdDF8YhjWxNJP3qxN5lhf10i4L0lCipJ/NuGkA6oKEXtfEWsWEWsTd5te+N+bO4kkzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eP6hjLDbig2El5k+d7Le4zoQteqtsbsu9Jiv3i7ats4=;
 b=uLfHbhO9n1bez0fLcM1fkFwzn/pN01WAHkZIMTFxx//bGOPjY3dY7i/f6NDBLtBLMsiUn+5ACAq1A4EzpMFWWS1tU9FcOcgihL+A31TrL2wdbZyeQeKJtp0rlWSsEZ7T50NUoccsFtBtYjMpW+pYs5Z7gQm9PTJX9YL/4LufEfY=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by LV8PR10MB7965.namprd10.prod.outlook.com (2603:10b6:408:204::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 17:59:45 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::64b1:cd15:65a5:8e7d]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::64b1:cd15:65a5:8e7d%5]) with mapi id 15.20.6838.039; Fri, 6 Oct 2023
 17:59:45 +0000
Message-ID: <648aad32-cd8c-4a78-9ade-76c900baa6f9@oracle.com>
Date: Fri, 6 Oct 2023 18:59:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/15] hw/pci: Add a pci_setup_iommu_ops() helper
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Avihai Horon <avihaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Yi Liu <yi.l.liu@intel.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
 <20230622214845.3980-2-joao.m.martins@oracle.com>
 <18343982-d554-61b4-fb17-b6955245e9b0@redhat.com>
 <db965f35-e568-44bb-9da4-2c2888928eb8@oracle.com>
 <d09a2778-8097-b6a7-b570-7d36bf29d9d5@redhat.com>
 <4f3eccb0-a3ff-4acf-a849-d54ee8d66eaf@oracle.com>
 <bcf861f4-50a7-495c-3497-87454fc99492@redhat.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <bcf861f4-50a7-495c-3497-87454fc99492@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0205.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::12) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|LV8PR10MB7965:EE_
X-MS-Office365-Filtering-Correlation-Id: 9930f303-5573-415a-2873-08dbc6960640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P6nJDC9D/LiVOaEC6NLbRLXMSUO/KD/FpehfDKVS5wvEe089ktq+cK8kE8XjhqoKjAzoJl9nF+g/WNnD/rAQv6Qv+NtoOut1l4DbY6NIZcf2gm+cgOtdxrlb1s1y1xMLqSTnRmfuvDVFQQfr1M19AJ5WhQVf3IAguhwOOKfr37Xa4eGNGavFPjBCWFw7vGG8UVqY+Xfxo6JzF8x2xuJBicBLhmgy10rqeVo6rGyABIjClZM10Un39JM5l6zd3Re0hSX/XA6c5AEhPDAlxW5ird4TOc7Q0wUcDvJBiqxRTUZ4UQGSz3WtRVzmfn91/cMDra/91kUEhX9c7icrP8xXdKwXUJ5w9Do+QyA+tVrHF4Oq29zbcWq8sC+6nuYrUqVLGsc9XdtDGaDP0EqX3sSACVUYJhq+90T0l7MhfmZCj1uBg1e46Xq5nex5RvOiU28V5jXdF9AH9zpipm75cVU2xdJJydw+s9fUn0tP4mUUwQgxIIkNYmV9siOpqf1xBTszHoje4/PR7MASbbHQ0nCwNljZdgzDiqEa8E4erYEXmsotxl6EKqLuBx6kqDDL3CxQIHa2RjaODdexDTkjQIKU90+D5m9ayw4AQHo/aq2Ar3lkJDMHNm0zu5P4Vlaf1lTW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(376002)(396003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(86362001)(31696002)(2906002)(4744005)(7416002)(5660300002)(31686004)(8676002)(8936002)(4326008)(54906003)(316002)(41300700001)(36756003)(66556008)(66946007)(66476007)(966005)(6486002)(6512007)(478600001)(83380400001)(6666004)(66574015)(38100700002)(26005)(2616005)(6506007)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ME8za3krTWtZcjA1VjVCcnFWQUVNWjd2cllDbXIzejQ2QlJSNkZ0aVgwN3Rw?=
 =?utf-8?B?N2ZWMGpYV080eGxpbFUwVUVSMTVjQUthZndaUWlsdWcrRGFPcEJzVlhsNEtJ?=
 =?utf-8?B?cTd3ekZDdjR6dXh0L3JpYkdhalJVaGs5d0FWa0t1MklpVjZ2NHhPeFRLKy95?=
 =?utf-8?B?UzBBLytldWRBbG9Gem8zRGQ1R1E1Mm9yMDRRYngyeWoyekZSWjNHU0FXYjJI?=
 =?utf-8?B?UlhWdWU3S0lWcmx5eHBwMklma01SWXZBQXBTZ2xrQjJ4Umt0Y1plV2FmcmFh?=
 =?utf-8?B?NEZXdmtIVTkwL2FZWE9uYUZaeVVuVmhsN3RaeXhOZitweWxBcVptaHpmTURm?=
 =?utf-8?B?eDh5dWJNZ2pLOHpnK0N0VnFrT2pKenNVQVV2MGVwc21BSENCeDR2a2NmZVp5?=
 =?utf-8?B?Y3hjU2lveFZERUloWTU2L2dFbll0eUVVUU92c2FtdE9IRGx0d0tqY3pPU2Ew?=
 =?utf-8?B?M3ZCMDAvZHFsYTlHWEZhK2puQVJxQ2dwN3hiRzRMOUcyNXNWTDArdmtQT05N?=
 =?utf-8?B?cThqQ2hSMTk0YTNhOVc5L0xGNkE4NVFnblp6RkF6YVRjK0JZSWp6WmFyUEdD?=
 =?utf-8?B?K3VPSit4dnNtQVpZdnlTdE5tWks5Zk93azdJVnVhd283SkxwK0tFQjVLZ3pr?=
 =?utf-8?B?Wm9kaDBpRXVINmZSVmYyTTZXd3hudUx5SXl5QW5UZm9scTRIVkRIbmJaNC9k?=
 =?utf-8?B?U0JmdHpYVWVtejYvK00wMFhtMGROUGZUTnZUQzhDT1JnRGx2d09JaGdhTkdC?=
 =?utf-8?B?aXIxdHdQM3drMXF3Wm9vR0N2NUVtanVjMEFwT2lvZjJLTmJuUzN3ajdDbWpn?=
 =?utf-8?B?bDZQL20yTDB2OE1QZkJFNEh6djZTNEYzRnVhejFBT1o4Tk5Ldk9RSkdhNzRh?=
 =?utf-8?B?MWZvQkFPN2tPblFPTHN0Qy81SEVid0M5dURDdmI4WTZacnFWeFR5U2tOamZn?=
 =?utf-8?B?QTR0dld6eEJUbkIwbURDYTFYdkVTNi9SdEZZRnNmMGs5SkNISG41RGlKVkcw?=
 =?utf-8?B?VDdtNFljeUZiRG1MUWprU3RyU0t3QW9KK3cvdmUwT2Ywcjk3OXVBeDRUSHgz?=
 =?utf-8?B?ZFVtSU85c09pUzRpZzVQQkhSN0lXeEoxYm10MUJqTTBDZTgwZWtPYW9YUFoy?=
 =?utf-8?B?Z2xDd1N2VkF0Zm9CWVRDRFdjc2lUeHFoa29DbDRlN0I0RHZ4Ukh6T0dWdFNK?=
 =?utf-8?B?eXFwazhud2k4NDd2dEtWY1BMMjBCTDgyUmJFVE9hOEg4eVViN2gyNzh3Q1Q5?=
 =?utf-8?B?VjZjTGNQOGtoMXNTcEpVbkdDZ09XVWdYazBJb2hsbTN4eG0zeHp0MFQwQUxG?=
 =?utf-8?B?SGVRSldMTnNmMFhYMlJHbWI5R21xcWlzUncxdjlEVFBFYmRQMWtxeFBUU3pa?=
 =?utf-8?B?NEdCRm9QVnZrR3ZvUGZmNzMyNUNqK0JHRGRpbVdzTTBYUXRObzVsQlBqNVBG?=
 =?utf-8?B?Sy84c3d4cDd0bzJPODhCMFc0NU9CRmwrS04wQVFEZkpMemRLUWlOd2NyVXpK?=
 =?utf-8?B?elJsZnphckQyMmdNT0ExWFNHaTB3cElyWnZKMWhLZXhVNXA1MnhoWHczaTdo?=
 =?utf-8?B?SzZNeTh6RS9FTGx3ay9sSzh1ejBodFV2RlczbTlrWlNzK3I2Y2hwRm9Oelg0?=
 =?utf-8?B?bGJxR0dCZ293bGsxU0NTdUxuMFJHRFErZm9wMVM1RForV2pqTm02SzZQelV4?=
 =?utf-8?B?VW55OGxLbHdvTFZrMit1ZUJpUWhrbnYxQlpCMlM0ZGc4ZGd6OXJnRnIxT0Rx?=
 =?utf-8?B?TGEvZ3o4dThLNjNoY2g4bWcweFNhSmY3YzdWRGl4STJIbE5OMDJzU2MvbUpv?=
 =?utf-8?B?S0FrQm9HV2lBSDVLWm40NWFhUmhmRjNSeDhQUllqMXVnMklkOU5QNElPL2Rq?=
 =?utf-8?B?aVplYmsyOXVxdDR0blhuT2FXdEdQQXZGbGZRMEUxdU16Y0xjRklpdDh1dzFI?=
 =?utf-8?B?cExRMldrMk5Oa003ejdLVWU1TFdLVkY1VTlTN0dDZzl0NktLWHNQelBLaWdh?=
 =?utf-8?B?N1BsQkpyUWcyNXdxcmZ1UEFXbzBrQTFBdllRZXBrbi9oQkx4NFVCY3hldzhU?=
 =?utf-8?B?ektqZXNpNXloVXRzVWFxa09OUGZWZ25idjZacE9vM0hOeDkrbkd4a1dVQW14?=
 =?utf-8?B?bnNXcXE2T2ptejh4SW4zMS9NbmdUWm1xVGh3UDE0YlBxQUVoTFBVYUVmdXVt?=
 =?utf-8?B?R1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /+tessqo1tXWBcWudCCTlBE0/yxzhIuztM9pfv8LJXHniMoykHTUXaDc7hbKgcQJTD9UIhg5WgJ1YmxK8aJWDyLejqZqZz5nqppDULs3320BT55H6ut0Ca9xERzUbh1Pys+qQKNFpbhyp7B0fD6re99+PI3CuuMvlNud4VyzfbsNzgH53aLDkkWyBOSIC0FAKBWXbmGV1AuzohVeBLPZlgE8tNfydnZLyB4qnlHgz1RRLKfa3c7eQSLc+s53Ex2qzpq148psWrdHKhmPNIUSpmDSDdXnfY9TZcPu96RXb+x0+Z8lqjnCWqMexYNCkWZsj033VNhNwlhspJMv0w4BJNO8V+p9TSgqce/RkFkQ+TVHsnDBlc4cVkNa6a+HgfWCQVru7KzjZpCpCB2jgPgN6oxDTOA4w+WmIZg+ZY1Vu9Nbzv23U35apEfzYh0XuIlYrCUO3FQ4eSjoCyBOUUjl7JtN07rd9s2I+6WZGkM547UvdQDlXfmutFJhtNROC5a3PpMjtzrnjzFYKmybbMrXlRj7vYg3zq0W7OzucCkVRKAOX5SiKBmvPa2Cr2YwhPgHN3lOV0IdRZTz54zrrG6SSBHQPKia0k4ERvsxOHR1LlUDMFdKHcoXBA6eJTPHuTuMrQeJJm/BpnfRUDoPk/I4e5+HqGlh6YWoKnBxHVhty284D5j2a0Y7TBSf0ICYA79PP+wZrLAx/Umwg4XCSR2BhxC2UaSgVRMCkKuYaTJhKZv2E4sOFPMcOjWEr7+RHWRSr/AHJQPB5CoTN8pLVaTESowhKKdgNyNdH217y6YPNaqUaKPHOfq+stVIptO9o5IlcGhYIobOFTeSq+d+C700C7GooAP1VPZj/uBqSh8I83iFAQP/bfbbLz4clvLmACqHGwxXw11sd4YeZZ+AStByEIO2AXj8uOPGsywEf9ofuXA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9930f303-5573-415a-2873-08dbc6960640
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 17:59:45.7363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KE5WcgQvoePvH41bfjKezprqpFRer7CQGAGVmGk78MCj3zjyrYB36G+qZxnJHhmFP3likB02oDOeTqWwh03nvDd/b15a5owUsM6fNxJ4wjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7965
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_14,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=879 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310060135
X-Proofpoint-GUID: pF6JoVxoXgpvrjga09bcjtMIxtVuqFK8
X-Proofpoint-ORIG-GUID: pF6JoVxoXgpvrjga09bcjtMIxtVuqFK8
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 06/10/2023 18:09, Cédric Le Goater wrote:
>>> Getting acks from everyone will be difficultsince some PHBs are orphans.
>>
>> [...] This is what gets me a bit hesitant
> 
> orphans shouldn't be an issue, nor the PPC emulated machines. We will see
> what other maintainers have to say.

How about this as a compromise: to have a separate patch at the end of the
series that converts every other PHB? This way the rest can iterate, while we
await maintainers feedback without potentially blocking everything else.

Also, one other patch I'll add to this series at the end is this one:

https://lore.kernel.org/qemu-devel/20230908120521.50903-1-joao.m.martins@oracle.com/

This way the vIOMMU series is a complete thing for old and new guests, as
opposed to just new.

	Joao

