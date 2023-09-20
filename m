Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 551D17A820E
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 14:55:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiwiY-0003s1-WF; Wed, 20 Sep 2023 08:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1qiwiS-0003rX-3I
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 08:54:04 -0400
Received: from mail-co1nam11on2062c.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::62c]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1qiwiL-0005RB-7g
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 08:54:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcnLyGwqbYukpxaAR++Yd5p7D8KQR7iWEBDEUotH2dgNkFllQuNS8sEUZvS4NjYOc2c97gt9PDd/oAUrH9GQHuOFoOa/dqOvfXA14gS/BH9A7WupPKPlXSp5OlYUi3VzzDu55zQnxYoqFdBNt09h2UZZ6bkjsoX880jBHsx4ykGOtucoegZhad6qITgekbExa+qa3E++XvP0kxv8SfIXY8wd5kpm7eAhb40Hq/u3NrvL0QOj9aPRrDLdQGP38sqlEZtrwPCqqB94JKFee1fPNO+/DSilDubh5NVmcKEnhVOG82DsGEk8hIryC8mkZ0FPTlDYH41zIJeXirocpex4mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWcHkolY7FtCojgPmPEl92j93T7zPI/P6OeYoJFivmg=;
 b=mW1eGjCxLxu/0XMOwjEukjc4+blMqrawM10tACCwxbf4TbfF4Lp8zbJtRZUOM1i5eKofHrWDC8fz+7e/6ynxlTGcSYlgXK0HZ0OJI1T53+jebK4TvJz7r9xofgx/aZ2OIfzj/09GBk2ylytMxW1l6CqW7ARH98U1U5E99/ErJioew4Uq8x/MHsPPXfQw44V/t5I+OoExXCeMziTdJdJ3eO7yaVcZj9W8Ek0LY85/tBLyHUUVgWpMXP7gW77CLtkmnc7BHgaahOup9L6qthxTOZnIiO9oiOHJyyxVVy4c0jJdfTyHZ4yo6fM4XvqHFd/Z5V6RUTYXVzTW2CMuocqSUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWcHkolY7FtCojgPmPEl92j93T7zPI/P6OeYoJFivmg=;
 b=Q4aAolfCfNtnTl963VttQ38kTFkQf4ITF9geOGVxnecMLhjarV4L0lvDCPbGiljB0YMkRZuYF9AMYGk0w7nd0oguLiTBny+OAIpyP8X6D5n+mVTS2ytxbQVkK0TPCweuBy0B7K8n/mpdyqagiD5v+wOYqrcAUmcs1WJFO5ELRWEr8KEE03lgb23qegxU0WP/yE20RqqSJgbqD9tZcJwpog2XyVrt1g8cpvhkXGKR1lPKKYmuiN97pCqWMUTqI5P5FSKDo3QGw4Wb13c78bh8rLHJ1PxOkZn5dB9YvKzvQgTET1xKwRbhr+3ZOimqLogUFNKwD/ZKCh1ozfXnNLF9wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6788.namprd12.prod.outlook.com (2603:10b6:510:1ae::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Wed, 20 Sep
 2023 12:53:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 12:53:49 +0000
Date: Wed, 20 Sep 2023 09:53:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, clg@redhat.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
Subject: Re: [PATCH v1 17/22] util/char_dev: Add open_cdev()
Message-ID: <20230920125346.GT13733@nvidia.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-18-zhenzhong.duan@intel.com>
 <ZQrn5oyrdIXw2A7Y@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZQrn5oyrdIXw2A7Y@redhat.com>
X-ClientProxiedBy: BYAPR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::41) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: 69bc1fd3-daa6-445f-9625-08dbb9d8a23c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ODB3jTEs0bks65LRBgqts03KDqT8veMn/Xjh6nCYfibz3lbcFhs93x+6dXLMhoakeUTHTmCIYBnnmHWffQsksnlPJ33WJIH+iz0uZ14WBZtLbBMn0LBj4ILCFLL1VlF0BTIgXos4co1FIZL5ixxXjCWvbh+mt9mLkgsIizmcAXw2J5GQ3gxO0/fz0048bMcmGtKgByR4FlzQZ61Nq27eS1OWKxFS4AB+aTpbuKMcF2dk/P4WPlwJmryD39Ysj8/mcZUUy4CF4bkkp903cclI9zL+TMNFQVe3lm2WGaSDFsMvNdH7MXCOiEApMQC9e2eagN2zA8/hWubJmBSp6yS/vTVFe8dDNXAHCIc4Sn6GgODX51HzZwi2o/Uh+xv/k1o8FJJ0rgqSplt3rogi3VnvnvreEbKQHPTFqghWwOtjmIrnKhnVN0srToI72HcXUHM/wqtrS8olz+MF0+KLxU2bUOOK45RXqfvHxR9GTaCHYd2XeUA1/oMkKXstu84SNfbCWTRD8r/YSzY69RVj+QQA8vOTzRP30Ocmfb3H4ijd7HU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199024)(1800799009)(186009)(316002)(4326008)(6916009)(5660300002)(41300700001)(6512007)(6506007)(6486002)(6666004)(2906002)(8676002)(66476007)(66556008)(66946007)(7416002)(8936002)(66899024)(478600001)(966005)(33656002)(26005)(86362001)(83380400001)(36756003)(2616005)(1076003)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWJsbFJ3alVFZVhqdlpJNFhYTFhOaE9TVmlSM09MZ1ZybElYNTByaXlZRDd2?=
 =?utf-8?B?Q2d6empsVDZqNnlVOWkwdWI3OTF5by9td21wRkNHc3BKN2hRQ1lDSkhqeEhV?=
 =?utf-8?B?SG0rWkZyUkp2dXRCRlFFSGtMait0bllDdDJFeTF3UC9Gci9Id3B5TzQ4dUxF?=
 =?utf-8?B?WWtKYTJOdkZkU3hTQ0tQR1ZsMnVzdmdsSzdOcXVEMmhOWE9URkZaSHQ5N1Rm?=
 =?utf-8?B?S0hWSEN1aHJFTVVjMXI3Tlh5L0lmMElZRG1ZK2RFT0lydGVpeHpwZXh6YUVp?=
 =?utf-8?B?SnZBM3lMam56M0RXUmxXRFE2a3ZaSEhPYjZaZU0vTEwrSEJ0YktVdHZxcFR5?=
 =?utf-8?B?clNqeUFmdjRPb00zQXo1T0xueDI4bE4vQlJTdXVOS2x5a1VKVDBnUVFvS09n?=
 =?utf-8?B?UmwzUEFFaGNxUVUrT3B6d0x6WUVNUGdhTmdCTzZMQlM0cW9MSWFyL1crbm1X?=
 =?utf-8?B?TUVzLzU3bFk4WDI4aGg2cU52VXpkY0g1Y2tOLzdXakMzRzZ2d1UxMUdkWnFp?=
 =?utf-8?B?T3IvWEVobE1lRHY4VURaQXI5R3JMN3hBT1h1QzJLMDRXdjNRU3p2RVBlQmFu?=
 =?utf-8?B?SWY4dzVSaVJjOG9SbkNaT0JIOWVkeHRHUytaWHpWYjFrZGtVRkVLMkxEckpV?=
 =?utf-8?B?NnpWV0JsblB6cWZvVzE3bWtIUXN4MGVKcStVajlOdWFROGVVdC9yVkIwZk9I?=
 =?utf-8?B?OWZlTkZRWDlycUtYbGR6bG8yQTFubmd0emUrWGs2Rms0WHZocGhHenB4WEFz?=
 =?utf-8?B?ZWNvZFRhZFNZcTRWOUxhQWNzTkdPZzBIdFVrS2gxTC9UQkV5K05uM2FMeDYw?=
 =?utf-8?B?empQbk8xWjR2L3Iwdm8wR2dRMFh5WXlTT2dkeThIUEZBUkgxUE1tUTRPZDA1?=
 =?utf-8?B?Q2pOTE0xVUg4Ump4TDZjNFdUdUt1OXZ5U3crQithYU04cW5NcGM3d0RWZ1pZ?=
 =?utf-8?B?Yyt1My91b1U4OXAyOW1hb3ZPeEVvdjZ5RVB1bmg3c1ZFRUcyMmMyM08vM3gw?=
 =?utf-8?B?RVZjdTdSQlB2dTBuYm00cHFXdTUwV0lTcEo4cUFIVUtXY2VlV2ZXMXhtV3Rw?=
 =?utf-8?B?Y1I5OWNvV2Rhc3A3QXFWR1NnNmsrTWtwZkgwYkVwazNpNE9FaW1VR2ZTMk9y?=
 =?utf-8?B?QW52RFh4WFRac1FUTURyWkY4QlBrbzBmUnZBY0ppMHlQK2JxMlhRQmg0VmQz?=
 =?utf-8?B?VHlzUCt6cFVpRXJ0R0QzRFVMa2tSdW9JWEpndmlteVJ0ZUl1TjU0K20zcDBz?=
 =?utf-8?B?eUJ2bkkxYlphOWNPaFdwT2pRU2tSQnRtRUpXaDBBQ2h5MGlLTDVvSDNCbTJW?=
 =?utf-8?B?YVcrN1MrUFp3Wi9FVXZXSCtSSXlLN0dGVHRUYlBwcURMNGdoT09ZZ1NFS09Q?=
 =?utf-8?B?MTllcEM1cW5nWmcybTBHd0tQZThWZ1ljaGJlaUI5dnhqSjkwSytwLzdxa3Vq?=
 =?utf-8?B?R3p0WWxuQ3UrcDVLcWIwWU5BaHhNRzRDdy9JWlNMZWRxM3JENDhCeUZiTEFM?=
 =?utf-8?B?S1hXY0JUYk9NMnJMVUZ1Yk5meEZHWjZteUlmczEvSVBoQjBtY2ZORSs4aHVt?=
 =?utf-8?B?TURvRG14d2dZZThhSHdYMVdYaGEvU3hXQ29wM2JPelRLU2FQRW5uUENQOWJE?=
 =?utf-8?B?YThEVEM4TzMySHU3ZlZNK1F3cUtENTBqVzNseDdOdDRiK3BHTVFsYXFVUktI?=
 =?utf-8?B?b3pRcHc5SmE3WkhzaUNRcTQvR2FkQmdWUzFtSndzbStpTGlWeGN4N2ZpZmhi?=
 =?utf-8?B?WmpNWFJMb1NXamFHLzR1OTNUbjBDY2FSU3NzWXJzOXBqcW5LNlBVVTNQODlo?=
 =?utf-8?B?RG55TnFUbVBGQzRqVFdMMzEwZ1RlYmhMRDljSzBJc2NKcktuQUgrNUQ1NjFw?=
 =?utf-8?B?MmRBLy9YUGk2dG0vd0NlNWVVYlZJUkp4bFh5Y3NWd21CT0I1bzZTQk1FOEJI?=
 =?utf-8?B?RGJaUGV0YUg3V1lYV0J0VVN6aXZaNXlVdmZqY2tFWlkrczU0SVlVbGVKS04x?=
 =?utf-8?B?SWYyOWtPOVBxKzhWWTZPWFZocnJFc2F2M3NtcUFyVDJWMnlvWE1SeWMwODRw?=
 =?utf-8?B?VGxoYlBBRW5kWEJQamozUjByTm1kNXArRzZJQjR6aXFtWUVhQ2VwcEdhWEQw?=
 =?utf-8?Q?jSvvKe7cA2udI+RBJ92m6jSqJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69bc1fd3-daa6-445f-9625-08dbb9d8a23c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 12:53:49.0164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30q/84uNX7rRREodJ0nc5Dp2+wakelccqV7eQvpJjNs5UthpXIsSpd/jTBJfpQth
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6788
Received-SPF: softfail client-ip=2a01:111:f400:7eab::62c;
 envelope-from=jgg@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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

On Wed, Sep 20, 2023 at 01:39:02PM +0100, Daniel P. Berrangé wrote:

> > diff --git a/util/chardev_open.c b/util/chardev_open.c
> > new file mode 100644
> > index 0000000000..d03e415131
> > --- /dev/null
> > +++ b/util/chardev_open.c
> > @@ -0,0 +1,61 @@
> > +/*
> > + * Copyright (C) 2023 Intel Corporation.
> > + * Copyright (c) 2019, Mellanox Technologies. All rights reserved.
> > + *
> > + * Authors: Yi Liu <yi.l.liu@intel.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2.  See
> > + * the COPYING file in the top-level directory.
> > + *
> > + * Copied from
> > + * https://github.com/linux-rdma/rdma-core/blob/master/util/open_cdev.c
> > + *
> > + */
> 
> Since this is GPL-2.0-only, IMHO it would be preferrable to keep it
> out of the util/ directory, as we're aiming to not add further 2.0
> only code, except for specific subdirs. This only appears to be used
> by code under hw/vfio/, whcih is one of the dirs still permitting
> 2.0-only code. So I think better to keep this file where it is used.

The copyright comment above is not fully accurate.

The original code is under the "OpenIB" dual license, you can choose
to take it using the OpenIB BSD license text:

 *      Redistribution and use in source and binary forms, with or
 *      without modification, are permitted provided that the following
 *      conditions are met:
 *
 *      - Redistributions of source code must retain the above
 *        copyright notice, this list of conditions and the following
 *        disclaimer.
 *
 *      - Redistributions in binary form must reproduce the above
 *        copyright notice, this list of conditions and the following
 *        disclaimer in the documentation and/or other materials
 *        provided with the distribution.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
 * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.

And drop reference to GPL if that is what qemu desires.

Jason

