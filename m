Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2869F704D62
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 14:06:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pytQK-0001Ts-Av; Tue, 16 May 2023 08:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1pytQC-0001Ta-E3
 for qemu-devel@nongnu.org; Tue, 16 May 2023 08:04:53 -0400
Received: from mail-dm6nam12on2054.outbound.protection.outlook.com
 ([40.107.243.54] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1pytQ7-0005el-7t
 for qemu-devel@nongnu.org; Tue, 16 May 2023 08:04:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esEeXfJreaWIbgdiW2ZKBybDHT5h++08+D4bwwAda1OSL/FoEUN92L/xxHyrWihe0Jsr1mixNDo+SXkfQ6r+ZDtelFqL4fxxXRT9m6+Y/6H1kBPDQw1j6pyB16xd8nTuBmnYcZrOVAMUtKrEUOZRzkIhOFY0rCPuPjqovAZNk4az0XZ+UsEMx75glVy4pI/mP1yrL0aYMqO9kY8DMXiZK7HOvIjGDqTffA1VWT4v46tTfVJTE+PvMtl8tF0HdSwrhU7SkPGQGLiqtT0DZIPl7/s5AmCiwwe8Fk3CcI0sqZSLrs05/83Et2XcBJCmwrRuvWP1Ta/69ZImqapQedKT7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bxg5bDINQ9uvoI88Ro17X467NxSbo5yQVsfL5aMDQUA=;
 b=cs3WkEWrk60YdZN0R/3RPAGWd0JMXJotmQNNnHNJXwnXgPlGjOZ9tkrsyipzP/0L3Fxg6lsvOdnTDCoOwZtoRwr5D/7p5f6oAcieZiaXMXAxLB4kSISPIfWsXUbGlpjfI3IScLMsWHY2AusZzZTcjdJSIgNoo4CEONZw8aZEJeeGTEWCB9tvd+Y+Q2j43U5MsphxC6/YLeVWx9l5UJlraTY/VfKxwPhftWAqyNiB+SjAkK3b81+xukk3gDexDzLAwcGc1eNi9ShIUFx008ExbHLrsvkvht7DLoQsSY4zFQX+pgG68LUNvHBHn3ZzacfK2Lsug3c2H63z9g1YSiNhqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bxg5bDINQ9uvoI88Ro17X467NxSbo5yQVsfL5aMDQUA=;
 b=Q7ePD6DIDlNiCYbLUXgfnQvUUD/iPAZ6CulzERiy+KEmr8jbOunM5jq91fzJiyHpV4h0z7PKOLmZP5XqtE85LKDZrq3VJvmdUHD6cgLPtjQEYFalKvJNFQxl+m+BecUVLBeTley/1ZhIcsH1v0XA19iYD3g4dLeqd524YHgrn/kSqm7FqyK5kOaJ7uQG8d9Trc1RhZbm0jz7HMnA2ly7y/OM/xM+kX+kZSKc8ELWtS7L82v50iABbKMK1bqwh5rde3ksANsqjQz8EdvVxtHMwmT3tjFYsUYvxBDasX/ocq9KZbY73yYZ4R3RVA3c1vMT/uKvg8oYq3ttE6PhjsJnkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB5672.namprd12.prod.outlook.com (2603:10b6:806:23c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 11:59:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 11:59:40 +0000
Date: Tue, 16 May 2023 08:59:39 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Avihai Horon <avihaih@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH v11 05/11] vfio/migration: Block multiple devices migration
Message-ID: <ZGNwK+6HmM8lPjAU@nvidia.com>
References: <20230216143630.25610-1-avihaih@nvidia.com>
 <20230216143630.25610-6-avihaih@nvidia.com>
 <e333783cc59647ed93d944b05f12fe68@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e333783cc59647ed93d944b05f12fe68@huawei.com>
X-ClientProxiedBy: BL1PR13CA0315.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB5672:EE_
X-MS-Office365-Filtering-Correlation-Id: 24732b50-bb7e-41f3-0a1c-08db560507ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JaW7CgxWCp3F22d+HAAyXWmbaHyoZs0zcFXeStZIkYLuung8jmC8Ms91OBBabU2/z1/izvy1iRm/eJ9/qzNSWBU+x5eQ0cD0jseMedZoSQBD2MGkMl+H5PfJOoOu73Yhqy3Ta3icyBWQ5GaKioQFGkM1HKEiankGTKckl67Z73q2zf0zAgPE9iwzKKOPJ2bYO4aBJpmZux2yg5UlB1AwN3TiXfsfaGFDAK7uHSXkI6cCiSu48L4oEVGMfuw05HVceuL8XHtgqKaNbwaycEfrDlwAparz9/58ZBxNZ4nHRkdUDSND559KwNIwgsgrELXGJpCHSZhCD8XcbE1crbPbdHkKhzx/o3fstX2kr/F0t3YcZ0HSxayTi5VFwzHOHM+gYbeHJPm2umP46LTkr6+en6HDLgkrxgZLBGA5XSMEJOe+52sk9RF7OXneKnHbOW4SjLoTudnTPnKi2fC6OColf00HlNTvhJ+NlYlN7iqBJvVsIslwHtpYL8JJaRXg6ufLfLNLKsJP71UD1GoiH+xp1j4CtkDUUrY/o/U/jmRcMHNJ8OrWYMx4RG1LYFDVljizYq+o1CvXp4/blOSZPru10Cu65uhv86uyAj01UF33bM0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(451199021)(86362001)(54906003)(478600001)(36756003)(186003)(6506007)(6512007)(6486002)(26005)(6916009)(4326008)(8676002)(66946007)(66476007)(66556008)(83380400001)(8936002)(41300700001)(38100700002)(316002)(7416002)(2616005)(5660300002)(2906002)(67856001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?347wg0p/ALOl3+S9ln+ldjjlHd4K6c9BpWoQmr8EblOnSbBl3yygTAOcqBpJ?=
 =?us-ascii?Q?BBuLHhSICWSGtIKT/njNwbz6vNk68eFUJ8BVgKqjYhpn2D3pjbHtGr8KywjH?=
 =?us-ascii?Q?xp9tV9J6JjgkePrGTxDSWJLjzR0/1SkiX6oY4XqOEegD0YGTqMcjhK1SCScW?=
 =?us-ascii?Q?E5W8DGjJ14RDSdeigk1/9YJTPCUrz3/VIBSim+IaTvUQuD3Dr5rkT4fHIEVH?=
 =?us-ascii?Q?PqKOnnMNHN9HjBatZRbgO/W2eMmCKb4m06I+3mGozS60MmhKfvCxCKaqLCro?=
 =?us-ascii?Q?uxLGQ/+UTA0R3diMxAd9Vrv0zt9Hznei+XVj910Ac3Ql3UkI5ecSkJOzD70h?=
 =?us-ascii?Q?/LzBP8pSlr7m4dIRpWUyoQt9GfoAP6029+PWYzeAJSP3ReFmtXrAYOedFKUV?=
 =?us-ascii?Q?P4UvX5KUgx6OQizKblEFLfn9ZmhXG07cl6Qjf/auPkS5JWknAYgVMqnL+8kp?=
 =?us-ascii?Q?aXmVAjdixATqqyYOorEnC9yiPmEp4h69kALDdK7w+orfWLBatcElm6eRPPae?=
 =?us-ascii?Q?Z1cBLzPgI2gy+0W3vhPiZRrWnco7iMDLERfFy1hXlaae5GzgGBQcUfZcrMPa?=
 =?us-ascii?Q?FVdjKNMQhbw4JvpvxAOjzLdP7e0doODDKjUgcSKieDrblcwNIt8hhWNTp3ip?=
 =?us-ascii?Q?slV8HfyefSaByOblodYfDdhWjNri3ZrwMxd0yR+igvITjfid9WjzdKdd8lG6?=
 =?us-ascii?Q?cf/tJI4JAP44CvpydfCBu31nOCrxCmKm88a/LxcvVK7/t8QjBwGCe0rvbbym?=
 =?us-ascii?Q?bULWN+808DLRqs6jiGcGMCrqPQ9OlrsT+E0altOYx8ket/OQzvfuoMhbD87y?=
 =?us-ascii?Q?1T3cby1NGsDeRJjdNZ3subLrVZ9iYLk61qap4/t8EBpLpSdLQL3Ohb+R4nqC?=
 =?us-ascii?Q?Tx3pS9SYW3qGmh3O4KAXKMf3BmcXtmBEvx8k/rlXIeKwvLNWa9tNVMd5mSlG?=
 =?us-ascii?Q?7ANYUY5JGNQORF7G2kpqhq/sMIx+n76iy/+nr/HW+RibJvnshJE/Ud/tM8Op?=
 =?us-ascii?Q?X6wow5ygnKCRhVnG9VT3ajwjE3tzDzdRVDzNghgWY7P+CsrDGrsUE2HYRkQj?=
 =?us-ascii?Q?N3HBW+Rxf2firqCYMnNPsHC9jO33+X88NpQB+HXrSleoxOaqtJkDdOB+SW7L?=
 =?us-ascii?Q?BIJfrGNJ8+e38D51AZu+Yiyu4FeWM4motjCsO6AU6EkGLHBwcvLYTk7IZT9X?=
 =?us-ascii?Q?q34u3B/7hA1C89vEWZxLRdm05Vgjo0V6ewoKgn5csw3MFM9x79pa+qeWYGCC?=
 =?us-ascii?Q?Y74RPPfo/JztROQ9dusAsdjmaSxpgBs7Yw5bkIjzb8yjMdfbs/EblHmOurCl?=
 =?us-ascii?Q?JpZZkRTs0TRyTS/rW90JWHN/Co7auHhgZMOg60NOkyKI7Bbw+ziZUnRXd31y?=
 =?us-ascii?Q?XKjNFg6BAl/fFs903hJFJ2BdDVBu+CYIYxAKGwdpNbU5qr9coPhYim/dWKYR?=
 =?us-ascii?Q?8fWyK5htBHJPKCKIsfqSFlIqdqwoLapfB/SZYn0v/SZ9hIYFaAEDGmLAlGJz?=
 =?us-ascii?Q?0//VixVI4O3VULfFDvXbUhiltFbvKZAzPvugDHVQEpVqNefeq91MMJNrJq+Q?=
 =?us-ascii?Q?FGQvfXS0+FeHlWuw61gHZiXPA+lzDq5JtbftyFH9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24732b50-bb7e-41f3-0a1c-08db560507ac
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 11:59:40.8149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kAU4YOoSzxomYJidMWfp6dzIM2dPjCotrcKAXJRAA6qMuSwRvZYwxlF1x359ObXp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5672
Received-SPF: softfail client-ip=40.107.243.54; envelope-from=jgg@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, May 16, 2023 at 10:03:54AM +0000, Shameerali Kolothum Thodi wrote:

> > Currently VFIO migration doesn't implement some kind of intermediate
> > quiescent state in which P2P DMAs are quiesced before stopping or
> > running the device. This can cause problems in multi-device migration
> > where the devices are doing P2P DMAs, since the devices are not stopped
> > together at the same time.
> > 
> > Until such support is added, block migration of multiple devices.
> 
> Missed this one. Currently this blocks even if the attached devices are not
> capable of P2P DMAs. eg; HiSilicon ACC devices. These are integrated end point
> devices without any P2P capability between them. Is it Ok to check for
> VFIO_MIGRATION_P2P flag and allow if the devices are not supporting that?

Lacking VFIO_MIGRATION_P2P doesn't mean the device is incapable of
P2P, it means the migration can't support P2P.

We'd need some kind of new flag to check and such devices should be
blocked from creating P2P mappings. Basically we don't currently
fully support devices that are incapable of P2P operations.

What happens on your platform if a guest tries to do P2P? Does the
platform crash?

Jason

