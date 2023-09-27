Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA5A7B0917
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 17:44:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlWgr-0000a8-LG; Wed, 27 Sep 2023 11:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1qlWgm-0000YG-3y; Wed, 27 Sep 2023 11:43:00 -0400
Received: from mail-mw2nam12on2060f.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::60f]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1qlWgZ-0008TH-Rx; Wed, 27 Sep 2023 11:42:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsss8fwhoB7iOoptpBd4WAL0Qseg+Gc8a38oi/kXhRKEQaausExGpxHX2ISF7eyqATbctWFQ/wmNdHYIGWzxwaK5iDhe1XjTuwQQ/WKmivmbPt35pLSWVOFSE9Tmy8obch2w4g2MLpcpZIgCvEtURjqhwbtnfqaeLX4NOb/oIAYh1Rd9wcoNob8JFIIsY11ztFTyQqS1rxPGkcgWQCvPJz1Aa3R1h9rJ0zGdoZik0dUGE9AQH0URBTBVAi/Z0dS/CzxVDwyoyrhPiyKDpmVHxY4sGATDEsf1cs6OyZzUhzY+VpD3XEPWTTHI2S955OwK3zJa1phed708AsGcn0qkFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZR9u6w9oXRU49DLZgG4YTSoD/swUyaKJnvopTOb2rgk=;
 b=Ahy8oRg/HOhqrwFgBCWmKg6QoglhWfhAvIWzwx3KdC2N2Bqop8eXGF81YU0b8qR8ODRj45dIs8G7SUMcR3MqJ3RUX8RTzcCQLnpiDbhSDSvZlyNbIRTI6Oc82UH1uriJOkGaQL1oPi0IwGiiRyGu3W2MxXP5Ihqa6Dt+q7h5w1sLqXnwR4a6Da77kOBGXakgM39jfapkNSY57wUU2F2XG1GATLnaa5/zGXGCJfDCFlQbsmT+qj987Ef0LpGJY2wWNcFUdYWXsHw5Agvt8vxDmdXYzIIn7TZ3fA1TGtSiIBhl3/sGMam6kBm1VKrfMmt/xOegstVpR0gdTyrAy9RNeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZR9u6w9oXRU49DLZgG4YTSoD/swUyaKJnvopTOb2rgk=;
 b=CfybNJrg8TZEuKz/lz24rTooVRYGD2ozvE1cxVAPXN1+fWdnWO8pY65UVDeWrSsHd0X4xfJFKzQrnJXBlw6zsTgecm0ghQFj7n4qGU9XVOV7FiHnFxbD6hQnDlbYJLzcGOMOqAW8W2UuPgTHDQ5iqt3rVmHHaZwj3Y1f+cxwqUZlmUwzk+dW+As915j5/pUMJ2MszMV6nsLjAISKndrQaTHwfobYWFewZtNyc9CySV5HJ9CNgrfmoyAZPQC4CaSNU/rSG7keZxnR37TIPPlWW1uYkGoKjFA61iQqTqJ4xQXJQu7nBj23d3ZjHyF+XMo7Cg40SRJapFNHcXpJ0+lEgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB9250.namprd12.prod.outlook.com (2603:10b6:610:1ae::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 15:42:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%5]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 15:42:42 +0000
Date: Wed, 27 Sep 2023 12:42:40 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vikram Sethi <vsethi@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ankit Agrawal <ankita@nvidia.com>, David Hildenbrand <david@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "ani@anisinha.ca" <ani@anisinha.ca>,
 Aniket Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
 Andy Currid <ACurrid@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Gavin Shan <gshan@redhat.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "navneet.singh@intel.com" <navneet.singh@intel.com>
Subject: Re: [PATCH v1 0/4] vfio: report NUMA nodes for device memory
Message-ID: <20230927154240.GB339126@nvidia.com>
References: <BY5PR12MB3763FA9922B9059DC14CA80DB0FFA@BY5PR12MB3763.namprd12.prod.outlook.com>
 <b67c18d1-a648-81bc-1144-33fb839f2aa3@redhat.com>
 <BY5PR12MB37636F9E84CF92020769D859B0C3A@BY5PR12MB3763.namprd12.prod.outlook.com>
 <769b577a-65b0-dbfe-3e99-db57cea08529@redhat.com>
 <20230926131427.1e441670.alex.williamson@redhat.com>
 <BY5PR12MB37630E29E6E83BCD63FB3F2BB0C2A@BY5PR12MB3763.namprd12.prod.outlook.com>
 <20230927123318.00005aad@Huawei.com>
 <20230927135336.GA339126@nvidia.com>
 <20230927082434.3583361c.alex.williamson@redhat.com>
 <BYAPR12MB33369DCC79212D6040F00560BDC2A@BYAPR12MB3336.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR12MB33369DCC79212D6040F00560BDC2A@BYAPR12MB3336.namprd12.prod.outlook.com>
X-ClientProxiedBy: BLAPR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:208:335::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB9250:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c6d902d-3144-4f48-ff7b-08dbbf7062f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uBlURUTeWZzzz3G+Larr5yhFjv/VY/E+2jJ4xpT7GCiazF/UCmSMJfS8rmr8hoO1mg75/n/Y8SkCc0QBPNz3HMtpJSYIqE73BwRjoyHe5JTVnhkVnrHvr0E5W+yVGvQ9DWV9YhphRws0I5NfHi1VdUaYGTS/S18c0W5aQmam6Gky2kkWBoOMOMN/PHXTn56r3afHjTnyZCW9XK3vlo5KOOH/j8lJDFr6DrUbysxKNsl8QBB6flo/k5ZBdxDIXITzo3DlSW9BusnxZdmjQogxOHk77rI6d3O+Tef51d6LxK89Ek6tk4+D3wyCHtW8VB+jgY7f1qkS+UCEQa3qpoEdpCbgIR/1TgBiO7F6t6ug9QIbCY08e5SPUUP8o3jEitGnixqcH5A5P4T9gyA0cB4l4cVa/ztbntk+n3pJ2Vmm6+GfqX8NNc0R01SyYmHxBmUFgdqMQ9VdC575Aoc6hvpPDmsRy7w3PFW0sS39nDnwXGLmoT8EKJQM68YFlpUnNCUdCuePzFZYlGskV9BCRFyHIIBK/FQ+ln89xqliQrqhQ8NnnaLdZXKXZ03uwBbWPxQhBePrkYSXVhu15LdlV5CKYoiScP0f4mK4l+N+NGXJ47XXY8a9u9Ovt60IihG1KJXr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(346002)(376002)(39860400002)(366004)(230922051799003)(451199024)(186009)(1800799009)(83380400001)(8676002)(8936002)(6862004)(4326008)(53546011)(6486002)(6506007)(6512007)(478600001)(54906003)(66574015)(66556008)(86362001)(37006003)(2616005)(38100700002)(66899024)(26005)(2906002)(41300700001)(1076003)(7416002)(6636002)(66476007)(5660300002)(66946007)(33656002)(316002)(36756003)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3FQdFBNUlpYbGRBQWpZV0phN0FMQkZvMlFWMldlQm9xdEdiVXcxa1NmTC9O?=
 =?utf-8?B?UnZjWHcwWnptWHlmRmVNUE93SmxlV1lsU1F6MnpKQlUxcUFnUE5PMmtYY0l2?=
 =?utf-8?B?M0FJMWhsSEtHTnE4bzN5WXhXazFnV0hSM1ZGT0VGSXRaNkRsODFYVW1HampR?=
 =?utf-8?B?S0V2VlV3QVlra3NMK0NpZER4ZmR4WHJSM0dpT0swRW1Kd0hTMVdqUzhSZDNK?=
 =?utf-8?B?VWpucVNUU3QzMHF1UnNpS2ZXNFc3MnA3UWtNMUxzSmVYbzVTS04wcU1zVHNS?=
 =?utf-8?B?NjdFODZsU1RzWnpwZDNFdk9TeXdqSnM3dGgzRiszbU1QUzdzNnNwa3pPM1Fw?=
 =?utf-8?B?cllUV2x4aGFnZXJyOUtaL1pQaERtN05vQ2h6R3pKbUlHVzcyUmpidlFhVEJs?=
 =?utf-8?B?dGxPT1dKb2k5UTBEYTZlcERFWldPVUNXY3Y3V25CKzFtQWYxOWswTmxjdWFo?=
 =?utf-8?B?QVJwNFFlREpzVnZONm4xRVhyOS9mdnNFdHB4VjVmL2xIcTRuMkFxQ3EyMXJk?=
 =?utf-8?B?Q2UxRUVNZzh1ZHdmODM3RCs1VGFJemhTOTEzcVd0TzBhWThNbEt2VWdod2Fq?=
 =?utf-8?B?VVBKWVlMcnBPSWVSazhLU3BpUFJRd0RoazMyUUMvMHl6S05wMVBKTUJ4MUwy?=
 =?utf-8?B?M1dKcUhTVGV1b3FHa1U3YWdzcW1paTJJM0NZYmhjWU1ReU95NU9PYktsMjN4?=
 =?utf-8?B?bzhncDV1V1pBY2xnSXVob3dTaFU3ZVlrTmR3RU9tSkJmSDYzWE85bVBYSndR?=
 =?utf-8?B?L2JPQSs4cWc2QjA2aHBXTFdNZ3VUQmhiTG9XOFlnbTNMRnQyWEpBK3U1RkdO?=
 =?utf-8?B?dTQyZlo4YjV2aVBibGVaeWllZmVBMUxtdFdUd1k1bjA2ZE9lbWFoajBoQjdi?=
 =?utf-8?B?VDFZRStHZVZRQWJyR2U4OVdjNm5jNU9ZNHUwVytsRmFoSmV6RHBHNFhZWEFv?=
 =?utf-8?B?NkIvYnNHeTVhMC82d3UwWk42d0VBZjdzdkNKck5XZW9vRW1hZzFHTE1ZTVdj?=
 =?utf-8?B?TjhOeWhOdnBENXpMMmFZOHJqOGtTVXlDSXBJTlUrY2xCY0VxQzBHaVBZbkt3?=
 =?utf-8?B?dnVnbGtnTVhBYTZ3RkxGcjByWkN0ekVHRDYwRWo5TGhZNGJHbDA2cFo0a1Jp?=
 =?utf-8?B?US9RTGo0NnBtWGhBamt3ajNBZ2Y3eXBtWjBHS0JJQ1FVNC8vSGJHNVZxY0Y5?=
 =?utf-8?B?MWVIcnJwYkNDaU1TRXpxT0ttWXd0Y0NIT0ZzL1Y5UmNGVmJJRlNsOUh4eXJ2?=
 =?utf-8?B?djlHcTRQS3dRWVNmemN3RW8zR2FmZWhvNFlQbENab1MvamJ1b0dzNVlVenoy?=
 =?utf-8?B?eHdxTDRsZ01LN0pjMUFBZy96NGRYM1NwUi83Ty9yZTVpQnFLTkxSMDIrZDV0?=
 =?utf-8?B?bmVSNnNtUk1URDVzaVZ3cGVZUVZtSDZ3eHVZcHc3cFNqbE5DZFZ0UkFneVNV?=
 =?utf-8?B?MXlnbjFoRFUvYVlwcHhpdW96RjVHWk8zWVJYMy9hQW8yT0tRc2gxZTh1MFhF?=
 =?utf-8?B?d2lSYjVUNm5QYjYzTnhLeis2c2JKOHFVYzh4TXFiRG9hdmtzVTJBVmtnWnZz?=
 =?utf-8?B?K3NzZWhRSjE3a01GdFZrN1EweDdhd0JRcHA5bzJTUFJHeTNObk1kWGJ5aUdw?=
 =?utf-8?B?aEhzbmlZTldua2FZVFpkcml1ZFppNmVUVE9oZkVUaGt1a05nS3JCcEVVa2Z4?=
 =?utf-8?B?N2Q2cW94TDlOaytmKzJJMHErVjRDK1o3cGE5NEdtbG5tZkQrMmRrRnlEL1Bh?=
 =?utf-8?B?cWxUeXd1VnFQcFFJczRZTXFnUDU0UHVyeFYrL0dXeGhZeUJEcTZtYUdnUGYr?=
 =?utf-8?B?M3VZdzdzMUU1enN0T3MyNGRJdTZYNFJUd0RuMnBqSHNneFhjTmpHWjVvdHd4?=
 =?utf-8?B?SjF1NlpUaGc5aDFsc3V5MVBxeHlXVytEeUhjSU14RDE5d0pMVDF5K2VSRm0r?=
 =?utf-8?B?ZVY3L3YrY2wyZ0RVcTBMKzhodWJNYnN6YTlpZG1RcEkxNllNQU50SSsrU0Rk?=
 =?utf-8?B?VXMwVVdHZ2tsZ1J3YmZFaCtkODhleGFNdlVWbFozQTBQQytJY1hnajNIRzY0?=
 =?utf-8?B?aDJRSzBNRzBpWGlwMlB6eERkM1Q4T1FMTU1aQWRCYXhqdEV3TytmMlczNUNl?=
 =?utf-8?Q?rA/Qw1lHgpBlr51b7g1WyNjoU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6d902d-3144-4f48-ff7b-08dbbf7062f2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 15:42:42.1959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HzcNWZ7+qXA+rDJjdQd+VYqR7Owg7e72prF95gDXsiSqK3SG1MSJpU7jUanwuizb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9250
Received-SPF: softfail client-ip=2a01:111:f400:fe5a::60f;
 envelope-from=jgg@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 27, 2023 at 03:03:09PM +0000, Vikram Sethi wrote:
> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Wednesday, September 27, 2023 9:25 AM
> > To: Jason Gunthorpe <jgg@nvidia.com>
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>; Ankit Agrawal
> > <ankita@nvidia.com>; David Hildenbrand <david@redhat.com>; Cédric Le
> > Goater <clg@redhat.com>; shannon.zhaosl@gmail.com;
> > peter.maydell@linaro.org; ani@anisinha.ca; Aniket Agashe
> > <aniketa@nvidia.com>; Neo Jia <cjia@nvidia.com>; Kirti Wankhede
> > <kwankhede@nvidia.com>; Tarun Gupta (SW-GPU) <targupta@nvidia.com>;
> > Vikram Sethi <vsethi@nvidia.com>; Andy Currid <ACurrid@nvidia.com>;
> > qemu-arm@nongnu.org; qemu-devel@nongnu.org; Gavin Shan
> > <gshan@redhat.com>; ira.weiny@intel.com; navneet.singh@intel.com
> > Subject: Re: [PATCH v1 0/4] vfio: report NUMA nodes for device memory
> > 
> > 
> > On Wed, 27 Sep 2023 10:53:36 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> > 
> > > On Wed, Sep 27, 2023 at 12:33:18PM +0100, Jonathan Cameron wrote:
> > >
> > > > CXL accelerators / GPUs etc are a different question but who has one
> > > > of those anyway? :)
> > >
> > > That's exactly what I mean when I say CXL will need it too. I keep
> > > describing this current Grace & Hopper as pre-CXL HW. You can easially
> > > imagine draping CXL around it. CXL doesn't solve the problem that
> > > motivates all this hackying - Linux can't dynamically create NUMA
> > > nodes.
> > 
> > Why is that and why aren't we pushing towards a solution of removing that
> > barrier so that we don't require the machine topology to be configured to
> > support this use case and guest OS limitations?  Thanks,

I haven't looked myself, but I've been told this is very
hard. Probably the NUMA concept needs to be split a bit so that the
memory allocator pool handle is not tied to the ACPI.

> Even if Linux could create NUMA nodes dynamically for coherent CXL
> or CXL type devices, there is additional information FW knows that
> the kernel doesn't. For example, what the distance/latency between
> CPU and the device NUMA node is.

But that should just be the existing normal PCIy stuff to define
affinity of the PCI function. Since the memory is logically linked to
the PCI function we have no issue from a topology perspective.

> While CXL devices present a CDAT table which gives latency type
> attributes within the device, there would still be some guesswork
> needed in the kernel as to what the end to end latency/distance is.

Is it non-uniform per CXL function?

> knows this information and should provide it.  Similarly, QEMU
> should pass along this information to VMs for the best outcomes.

Well yes, ideally qemu would pass vCPU affinity for the vPCI functions
so existing NUMA aware allocations in PCI drivers are optimized. eg we
put queues in memory close to the PCI function already.

I think it is important to keep seperated the need to know the
topology/affinity/etc and the need for the driver to have a Linux NUMA
node handle to operate the memory alocator pool APIs.

Regardless, it is what it is for the foreseeable future :(

Jason

