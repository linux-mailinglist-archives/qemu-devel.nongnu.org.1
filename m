Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FD573FC02
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 14:31:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE7qJ-00081d-CE; Tue, 27 Jun 2023 08:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1qE7q5-0007rT-Te
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:30:43 -0400
Received: from mail-co1nam11on20621.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::621]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1qE7q1-0005kL-LU
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:30:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0QLRGWoqjD/HDco0AMAfqhefps93jvPekIs90VVHFKZtTWEu+XxlnTUAlY9tTaK+lyZFYakZNPOUahLxS0tlyjkJlRFJ/WTKM7imdG5wI+8lVXWV6D7NiVX0EzfSX+r1ChQW+X9YqJXXNrLIVN77si3c9ag/eszOZUZhEflBH+xSyXBjWjVt+AEZtGuYj9RSDPt+o0trzWgKk5lD4KP691Zw0LGenxSJuvr3QgT3Mzg+JO/lDZmwpZWJSZ02FJSqwHAwLGF7Xci0hYEJzl1x6d9irH1WJwSdjTBbxsCGkQvMWCWBg+LHfvz2CmBXyilHXoVQEm064+tQ/Z9qDfhIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mOLiwDv22HcM0U7GC735JK8uFqp2/nimk9xlvxxo0I=;
 b=mk0jK40YGsU2YcyXUN7+7Su/WPiBD83fsB6P6ND78U+gHqqxF1h4UBxwrMRxL/Wotx5WSkYMY8HFu92tXAhSgiXy2ZtKIT+i0lv1LbDuiqvgIwugbGng/gdTY1PGOGEE1nzz6sGo74Q0QZqlDubtYnYjPjhl2YgcRkDyfel0kzlZw/lMKz4tAtqqjBUXasKto2kHgdS1gvf/Cr1hJp0YTQAaMMAQ6EvtbKbGxQEAb5r6N7P3MaufJLzG0hY8Vxy4gnEGsuLz14hyXDwwAw6MeT/3XdTDjHRT8XiJufhzqv1xqCl1gwb9f51NzF+g3ZSiT/4Ih44Xqj5hB9Gdzm7Hxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mOLiwDv22HcM0U7GC735JK8uFqp2/nimk9xlvxxo0I=;
 b=GiY94PNBG43h1AKc1oyzt+p3fxj6L+6JH4+u0gjBkoEawJBZQJ1yso8NOOs86FO12GhzbkEKEIMfEM8Ll6OTYJPcxwGronyot3hHD4Ycbnm8EtYYuudEmeBqp7Qixm7qWs5jtnXMXG+e6l0i3xBOoefoQIzzixqs5pzZXiTKbbnbiz9pAMZ2ri9iyYybOmJCE2/LISO2TP+eTM7QrNm8+cCZGrpVnRgfkmT2VJLL7HtZEm+MWSwcapYF4KjGdVVlQ7ChXejCbY+W7gis1oUtyEapq6z5JK54VK/wyIEtLjPg6QoeqTyuRNhLmpupxZuHBQbVu5uZAVfC2IL26VHnaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7121.namprd12.prod.outlook.com (2603:10b6:930:62::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 27 Jun
 2023 12:30:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 12:30:23 +0000
Date: Tue, 27 Jun 2023 09:30:22 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Tarun Gupta <targupta@nvidia.com>, qemu-devel@nongnu.org,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH 3/3] vfio/migration: Make VFIO migration non-experimental
Message-ID: <ZJrWXkM3FmEPtLMC@nvidia.com>
References: <20230626082353.18535-1-avihaih@nvidia.com>
 <20230626082353.18535-4-avihaih@nvidia.com>
 <cd94caa3-cb16-f44e-6ffc-2e8fc37e9441@redhat.com>
 <62b1ce2a-8191-fc6b-c7b7-e4c787deacf5@oracle.com>
 <78ef9a6d-25ac-e0ac-ca52-5a0673df661e@redhat.com>
 <20230626112729.06dc48d8.alex.williamson@redhat.com>
 <976b7037-ee62-f86d-5772-6a2deca0816d@nvidia.com>
 <0a6e8496-f3c8-567a-c886-b8ea604c799a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a6e8496-f3c8-567a-c886-b8ea604c799a@redhat.com>
X-ClientProxiedBy: MN2PR16CA0046.namprd16.prod.outlook.com
 (2603:10b6:208:234::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: bde1195f-a090-446b-4603-08db770a474b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q99onbmostqP77/yAJFaot1ul/0skhRwA6XbBhi/kI5Qib/QScLDbdscn/UfUnIKSaeyYpjxvLMXAHpmfManqPIHUtsPxomrjIX9MQoZ553Bj6nvsrSX/T9+B0gq2HlMor9H5I5Yo3DEgwYr13WowSpIMvC3spSV3xeJIGP8SmR9O0mgaU+hwGFUcrRauM86XLgPRikn5dcpQFe0nw5D5ZXAUhXiUyfGDjiD5ml4Rt32dhJBZKK5jjKGLXryhWV5twRDsBBoSXbo38m8KwXOxSze8fftaZkCXI138nPDNjdeKM00GkDQN+oGBxKdTeV8Co6UUfwI/yfTco9vIWkD49kv7Sgz80pAOfMijsr6PeMvZnJA+pCGiO/3slHH8tq/QEG0YY3A2Nu07/cqHTnXcuAJb5vbmC3jSlD0KeKVguxcz/4Vt047qjQPuKwqpDQ6VLZma/4ijM0n8fz6gSvvs++9TrbNghk+OXumsN8bylJs61CaheGW0ellpG9vzd/Dn4KezFRJdNa1IfbdM/EVHp45+9yo++QznDGqVrpptL3uN5e87WVEnspMmkHbrVGx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(451199021)(36756003)(86362001)(478600001)(54906003)(4326008)(66556008)(66946007)(66476007)(6916009)(26005)(316002)(6506007)(41300700001)(8936002)(8676002)(5660300002)(2906002)(6512007)(6486002)(38100700002)(4744005)(66574015)(186003)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L05aZHoxZW44VlFpQ0xXMFVpOGp3eDZuaHpxNnppNWFwQ1NqME5ZS2tCU1pR?=
 =?utf-8?B?SGdpME1ZQUUvWUxLeGFvazgyazZkSVN1WGNvZVlsWVlEbDdjYWtBZFAxZDh2?=
 =?utf-8?B?TS9wblNTQm16NnRLUTZyQWFSM3IxeXlhUzQ2eTJuUmphYjQ3enp5MFowTFRO?=
 =?utf-8?B?RTdxK1A0Ry9ocXdEbTd0eVJlNVFnTGh2d08wMW8yRGdJSGNiK3NJZmt2NUsv?=
 =?utf-8?B?YlQ4d2s1bDVmbjlRVkxUUy9DTHhDSEowT0IzSmt3b3NBcWdtZmFaLzMybVlE?=
 =?utf-8?B?bEpOS04zOG45K094ZU14bUFJZGo4bVFjd0lWalpVS0dBT0phTW9EY3ZNTVBu?=
 =?utf-8?B?bjQ0Vmk4WXVDWlFIbytuYnQ1RmZndUNKVFc1aGRBRjRmTVNtV09Wa3JUemdG?=
 =?utf-8?B?akJzNFFHak1tb2dTMmVhVmFkTDN3NFdFcDlLRmNOR2tMSkxlcVVSOHBabXBm?=
 =?utf-8?B?K0JWUmdOcVVZeitIVTUvUHlmN2p0MkRIS3hFU09tbUsybk9yeDcvc0krSksr?=
 =?utf-8?B?emxnbmNidlpBTEs1amZBS1hqK3NMc1c2RVNOTTVuUDJPdDhBRzJMWk1uRjJh?=
 =?utf-8?B?N1FsYStEU20vUk9DNlhPNzhzVmdYRnZOVnhiKzZKNWhMM3dXamFBdUcvTkhK?=
 =?utf-8?B?VkFveFVuRWJDclBPL0ZDL0V6dWpqT1EyUEllay9XYWdRMG5iYXFTZWhqa0hJ?=
 =?utf-8?B?alMwWFczeXd4UFhJZUNSYW9EMVV5eWhmYTdrMjJqaHhCaFd3OWY2M0JHTEl3?=
 =?utf-8?B?TjJhMStVbStTajZ6bzVWUCtIckNvQjY5OU9ZdDF5MW83cEVnK1MzUmw3bVRW?=
 =?utf-8?B?TkR6OTJzUk9UaFRjUVA0VzJONTAzeXpCdUY5ZUsyazhHZjhiaGFsdlJDa3h0?=
 =?utf-8?B?bUQzYXJMa0JBUWFEUWVpNmIvR01SOTlMdzl0Mnd1aVFzRzBuZEFYLzVKZWQ3?=
 =?utf-8?B?WDAvOWFra0xITWdmckF1bHM5ekRadk5CS001MnFBeE1QMjNoTUtacFVpRnFt?=
 =?utf-8?B?ZjhiUWdrVUhvcmErbE55QWU3S2NmTkdIdmV4QXA3NmxPdWE5bGlTRVVVVzVN?=
 =?utf-8?B?alZyUkNZOUZlaUVPVmgzQW4rU3NZN0V5RTlNMlhHdEhNQTFPWmE0UzF0RjRx?=
 =?utf-8?B?ZEhvOURBcXZlUVpBM09OczU5bGlnRUxVMGFUVjRuL0l3elFCaVZlSWxtYTBq?=
 =?utf-8?B?SjdRd0UwVXBmYnNoS0Q3dTV3SmF0Y29lSVI1UGlOQmdOWnExZzNpSUFBY2wy?=
 =?utf-8?B?K0UvUjdDOE5mSXpvaXAxZnZ1QVZ3TWVnQzdKb0NJdGVlb043cHlNZ0VmNld5?=
 =?utf-8?B?R043QWFwY2hvVnp3cDZrNlQ0ZDBDZnV1L04rZ1JReU1iMitISk5TZWQ3WXVQ?=
 =?utf-8?B?K21jUldMb0x3elNueWVSWFUzRUpKb1ZaVmhXN1FDbG96MlphQTMyQ2JnNHVP?=
 =?utf-8?B?a2laT2lYMnp4WFJ3Q0hYSkNudnZTcUw1MUl1NytYM2tWQjdCNGtzdFBYck1a?=
 =?utf-8?B?dENLQXZ1SzBJdDRod3c5dkJYaC9qSWY0NGNrbjUzcVdteG90QkxBVXord0tw?=
 =?utf-8?B?b1Z5a3BkQjhJdkxJYUoxaTVSODRmTTNOV3pyNkJFT3E3Z052Zi9NU2hqSjZt?=
 =?utf-8?B?dlNmWHdxUWdHRG1CaFVsTlRmY3lJaU1pZjNaOVlSRjRmWHYxRFBNaTd1QzV0?=
 =?utf-8?B?NGd4RnNrL0laU3ZGM0dFaHI4K1dmY0pCd3ltZ0lmM1NnODNiZXRIYTRzZUlB?=
 =?utf-8?B?bjV3NnhwMzhwNEViNmNJU0N0L3Q3ajhqbjN1Y0lmRkJzN2FLQVkxN29PNUln?=
 =?utf-8?B?b3pFdnRZcVh1cHZvOThoMWd6MTBvMmdmTEFBeXZNWW8xY2NIVlo3eEdnalBI?=
 =?utf-8?B?SmQ1YnZ0Yk1UeCsyMm9iTUdpNmkrNTFER2NNdWhKKzZCNiszdVJDQktiMlha?=
 =?utf-8?B?QVkzY3Jwb1JDTW5UVU9VOU5tNGFxbHRBVjFMSkEvSG13cExrbWozdzhCYWpx?=
 =?utf-8?B?aUlPUGV4OVZySEtPRjBQNnk0SVNBUm9zZDJHdWNDUDlBOURpZWdZTnRGeG13?=
 =?utf-8?B?cmxDdmFTaUxnUXN4OWZpK3hQRFF3aFVrdWVjYTNPQmxmWlczbkNLbEVGRFdy?=
 =?utf-8?Q?mal2PaqVrdlkQgS0SE5OK9isk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde1195f-a090-446b-4603-08db770a474b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 12:30:23.4107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1AbFIVKHXQ9fgrzeWUMrof74Ps38KdMEFJIaNKIK3o4OvL+rAcefpGk86WOE1y73
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7121
Received-SPF: softfail client-ip=2a01:111:f400:7eab::621;
 envelope-from=jgg@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On Tue, Jun 27, 2023 at 02:21:55PM +0200, Cédric Le Goater wrote:

> We have a way to run and migrate a machine with a device not supporting
> dirty tracking. Only Hisilicon is in that case today. May be there are
> plans to add dirty tracking support ?

Hisilicon will eventually use Joao's work for IOMMU based tracking,
this is what their HW was designed to do.

Jason

