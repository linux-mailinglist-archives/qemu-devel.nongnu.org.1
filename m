Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D7375815B
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 17:52:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLmz0-0003th-BP; Tue, 18 Jul 2023 11:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1qLmyz-0003tZ-3J
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 11:51:25 -0400
Received: from mail-sn1nam02on2081.outbound.protection.outlook.com
 ([40.107.96.81] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1qLmyl-00089G-6K
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 11:51:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+h8u6E8duMRrRvv8zotFKo/A17Iaxv2QdKfgx4oqwxyVYcUuF7LjB6IE9IALwXHZb6Wv702v414nKh+gV3lMz0N74VYyV4umVgljPSKTAdMZ8poasnP0+2LiqFwjp0QZLzZhx4Wif4IiWN+fB+0q1J61KyY5qbv4Ld/TG1nzJzxzEn6bmDOKMlOmBn44eL5hj0C0/DRxF5OoiLjpCIHkK7yKqHJM5mWHeFdL5Amrjhm3BOsx5ijAUxeSKbg0BoQHpCMQ+8kf7xOkGcLzpCroQLvIjmkciEgGVBXWWShrgCZqjgOVI/APAfxiBx/zEAfktbb8AK5V71c/VSPTorDOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rS/ADDMnKDiAQYgw4NlNPp2xngvuToUh00if4zsEA0=;
 b=auOUH68Z0wZihIw6jvH2g6+AJiDy+0DJByMLmj5Xb7VN7QI627RxIwCi4zHTMVrs/qSGe0gsLV1KI0yfduoWhO1nux7OcJ11o3+JDjHFSh+pGSVhbEJ2rhkZEhvAgFK2ca3jJnJTqHGHs7w02JJu2xSU7iDVEs+L0WgC+OMXo85cFe9nAYHCkZbA0wLaSXS9oIryT4NGrNxN8a6kJvg3+hTJpZtOhvmsGZOGLVgG+er9ro+2xf+vNqM77jGNjO42PFOOV6g6EAucauimo4omxffp2FiJ3DE6Qmn5IPp3kKuqRKrK5EvF8mm/U6lk3Tu9WOr2kcNe3MxPrbCzsmqvSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rS/ADDMnKDiAQYgw4NlNPp2xngvuToUh00if4zsEA0=;
 b=X3+uh4wWbZcJ9KD362DBQ2fQprdlP7C6Qh5Sv3NtQcCisa1pPnzpwHcTbFzQRBdPGHGtB2Oq4Ys8Jw2bYcW7n1uJ70JB0YGvmJP6MHqpEuuLY2TsKRJA7grBA0wORRdpZPws/jFGydFgUMh2GxL0N/kxMxSNf66bCKtpR1xZ/HEJQZJp5gUEmZDyFI7i0ugiQoJ6H5LfgUOPYj/QN6fIQkG3x1z+YFzyEStztruSfHbFeav5D6XTzTsfEeJj64yzIhANF0oqXpkE/Bydc7ewRO+VXAl8By7V+DtD+3/egbVMyLQs8+uice4ZLb2ut0/21V8L4s7rhmgbRcesFF3zBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB8601.namprd12.prod.outlook.com (2603:10b6:806:26e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 15:46:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 15:46:03 +0000
Date: Tue, 18 Jul 2023 12:46:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>
Subject: Re: [PATCH for-8.2 0/6] vfio/migration: Add P2P support for VFIO
 migration
Message-ID: <ZLazufgTjVliQ9mJ@nvidia.com>
References: <20230716081541.27900-1-avihaih@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230716081541.27900-1-avihaih@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0438.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e13baa-7b3c-4b0f-bfa5-08db87a6175c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +J5g/z1OB3/skPz4pumGYGBsHA1UXcbwk9OEmbURxZEeCswE9YqWGeCOSQutVkyMBlOvV4C6fYUgKSmxJWIfho82Yi72z0y4/pRTIQn4t/ee6wlQtO/RsR24vscyEQbZ2xxoZ0/MK9hm6ebOln1u0TpEPR5Tkb/WHDjoiy8k1vKkC7oxxNKLIEFbdisLcf7BNRanvKgeUBkt2HdqHdknvzEfAAhBivOiJKH8+A+QzeENATBrXqEH7vN9ryn2rhGBmp2Rc+fLBP4DmEb4KP3WxYFpLIDqCqVJjHKuul13ofbvmDBaqKChlE0BmoEmDv4ka/6PgZAdm3x1OJ00LS+dGZV0G8Vw47+Trd+pVvYVGQPK8cPYUYS/kq8r02NMZNQRTYXUFenWogK/uHuOdhQ2UREKJtrpR8G3j3rBclW2dmBZ0QWd+8qme0Zi6pBx/QvqNQS45tIH5+1XfH6kSiB60t0144qQS4Ost4kPczuyTI3zJFE7IcYjh8bzh7CdioiikSfU/KXCN10JGOX26FnlE7QXcNu+FyxyWlVnGAcmiZ8u37j35q7Vgjexvwmoh6VP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199021)(54906003)(37006003)(478600001)(6486002)(107886003)(6506007)(186003)(26005)(6512007)(2906002)(38100700002)(41300700001)(316002)(66946007)(66476007)(66556008)(6636002)(4326008)(5660300002)(8676002)(6862004)(8936002)(86362001)(36756003)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NPXXi1ynf4l/YOIjdc2uo9HBJ/B2i0vcrTyeWSAY2sYgp1aBdpExYXS8bPc+?=
 =?us-ascii?Q?sS2QlhOSi6Pe8b2P0mnXSxpTfDVISKkYmoXoQ6rTdiMq2xNqxkJWLR/Pzgpn?=
 =?us-ascii?Q?aG+GyWYzpGZvNgrxNpo517+YAJPrd7e/ULmSu+xz1Nkr/x4g/3V+YwoyWzEW?=
 =?us-ascii?Q?Tpqp4i4R0ZRGJF4Y5dL7VPqFonkzEh8afelKvECCFIhpwOwivCejOHT7QN1A?=
 =?us-ascii?Q?+alauFwkTX2dNwyKBX+OpTHtZ+EyeHH9mk8np8pDvlOrriJEETWWXlAn+y0E?=
 =?us-ascii?Q?wH1jYwOctq4TqJ0Za2bmMl8WT3Tz6jNVGB1R0OpL3GXCIy5HPWvEwBjrG/CF?=
 =?us-ascii?Q?3o2rKdUIMengDp6NBwwyYaLbQaxEbc+7lHzw6GlbeittGEL0QiSPQIWMArpf?=
 =?us-ascii?Q?dxw8tlfkIUMulydeZgJhT7bS4y+aQA8g6TO3kohwDh8egNSZlc4NLgVobjNc?=
 =?us-ascii?Q?P/W4inWWl4l3YPYLX/wPTHX0S8FYVVtRQiUmBjTrVq9rfFR3m6awFzINVRgS?=
 =?us-ascii?Q?rA0+rJHPl80wVlgLelaQ/tCjodUOJBahRNTfs7GanXfIlkNa3EddoRbIKwJE?=
 =?us-ascii?Q?7EyYTC/dCfz6N3iZbGVdmGcIlBLQx6aiIncpJQ6F00gIq0eTZMCW1rFURUzm?=
 =?us-ascii?Q?rdgKQNg1T94rNcBIzOdX+prOelNGmEW+TmZ04+Zcz8r2jM1mR+bNUIzETG5k?=
 =?us-ascii?Q?z5zl3vpp9VMyFIYvUYe7C6ByeYkVJKUQWiq8N/9Km5AxhtjtDIyBisSeTdXa?=
 =?us-ascii?Q?T/dyvNL/CFWNGW4mZp4qHQSrhziw1IiNHzIfLBBSZS7B420lr1I5TAhMs4kP?=
 =?us-ascii?Q?3tV0T5fknV2CaL2pvTN915b05Oy4S2MXgrMyd/f5i1krqdmAoJvN17XEDofI?=
 =?us-ascii?Q?gZU80WxrMwkgy7c9EOw9Wi8mbuoD86k5mliI3c/8B559QFWTx410hAdplSFh?=
 =?us-ascii?Q?n32d7On1J2xK0fbNDHkZsCiQ5qVFdknghK+caNelxMmxM7ExMaDoueTpSiaW?=
 =?us-ascii?Q?+uprR7lUwUG/yhQ1Jurk9NwIOgybx7UWjIgxNuJzB/op/9Pls0D9a1+yLew9?=
 =?us-ascii?Q?lh7ej6ACpLQAK3ZLi2kR9ZgUmrJBo5y0DooRmKCWIOnmzy/vB194XEMBqvFt?=
 =?us-ascii?Q?9oXxUXTN3Pnzk8m3BC3y/FWJK3hHdzl3RAVKuqEZLZRzrZMsRfWljMqa98zZ?=
 =?us-ascii?Q?mAUGgH1tC1W+5WSPT4GbxZ/5JJDm4fdIucmKP6lWhafgqSd25zGCA7vqVRJV?=
 =?us-ascii?Q?zQKHa2+JU4hhkvRP1o6iSLfF63wFlde2uiYsvIMy51v53V4Y4bYDiNK6IGLg?=
 =?us-ascii?Q?tHRwzUUjI+aUX3L4TmSHvw9a4PqtBmHZ3muUfSTW6LbXYNJV+jSfZlIkQx49?=
 =?us-ascii?Q?GFnHxHrn2JuL7brMonPhXvb4r605jgtdDQVuUnr8Gxq3I0jMlciyA44L54gP?=
 =?us-ascii?Q?x6fLaK8zF/5duNCDrzsopH+Q60YvEz6RO5iD+Kh04SNB2MGylfGDGjSEZe9I?=
 =?us-ascii?Q?gDHwkNY4wfOm74m+uWUdJTs/Hzb5IYxAD6ghSlBgE44cdAvEQ5Yu8Jy4Nnjv?=
 =?us-ascii?Q?jPgd4tw10F26+3i7DN7BDoRFtbbXHDyj3bOoYiOp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e13baa-7b3c-4b0f-bfa5-08db87a6175c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 15:46:03.0824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxXXIIw8ako4fgD/cTzn89MfARn2OhMyzVJdWe3t3O5kZjkEyTYAXJF7/B5kckFa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8601
Received-SPF: softfail client-ip=40.107.96.81; envelope-from=jgg@nvidia.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
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

On Sun, Jul 16, 2023 at 11:15:35AM +0300, Avihai Horon wrote:
> Hi all,
> 
> The first patch in this series adds a small optimization to VFIO
> migration by moving the STOP_COPY->STOP transition to
> vfio_save_cleanup(). Testing with a ConnectX-7 VFIO device showed that
> this can reduce downtime by up to 6%.
> 
> The rest of the series adds P2P support for VFIO migration.
> 
> VFIO migration uAPI defines an optional intermediate P2P quiescent
> state. While in the P2P quiescent state, P2P DMA transactions cannot be
> initiated by the device, but the device can respond to incoming ones.
> Additionally, all outstanding P2P transactions are guaranteed to have
> been completed by the time the device enters this state.

For clarity it is "all outstanding DMA transactions are guarenteed to
have been completed" - the device has no idea if something is P2P or
not.

> The purpose of this state is to support migration of multiple devices
> that are doing P2P transactions between themselves.

s/are/might/

Jason

