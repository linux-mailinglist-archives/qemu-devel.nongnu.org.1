Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFEC78E4BF
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 04:32:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbXSn-0006Kr-O2; Wed, 30 Aug 2023 22:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ray.Huang@amd.com>) id 1qbXSj-0006JA-K5
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 22:31:13 -0400
Received: from mail-bn8nam12on2061.outbound.protection.outlook.com
 ([40.107.237.61] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ray.Huang@amd.com>) id 1qbXSg-0002wR-IL
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 22:31:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaCQNRIu2QTM2cD5WQpvNtCcsvqgGWwEyC54Czdbqr8KadMA/YC2cXVmvWZbiYdbmHsg8cfj/INBF4sUPvxx6xpLra4HLRDvnY96Hjt/+rsTFW7SLyUnACzmAsw2OuoDzpnrOGIwddoVNBJrXL2MySqdtpiYK0g5xTiAWJHRjUUmxC9S0h6UnffUYdnb3xUP/+svSkn3yWnvbhdGPKJbwWUb2lGrJLybJHRmA/uaxpZuv5/JzchYkM5a+mM2DRJhZ2dErHxFgPAwQ8rgaB4RN3H41MkJrFcVGBxTjfNnapZXvTPXU17n6xBQIVTzrEEM8fLDEh+1EAADwE0rG4Gbhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIHXqzlUXv55MiAwBqodTuZICT8DAM/Z61uIvSCkulQ=;
 b=E58opzMahpvvQWi1+oIBUgfsOH1O9ENWANKJQWGAPn4Bxnkh1GmdnCk8oG908gHN0yH9PSZK8/W2GwN07tjNAwI03fu577vdcSnG6mB8jZI+Pnp/OVY8hMqwQL5wVMcE1ttjWb9Yao3Bgb8JPnqqYheDDnBwsRhYbcHBXLk/mV+02DGZ6rJpLOrV0ewHgZ5TZiQqUYSEVKuJN661AHJT8zZBTcJI36Y44cMpByT8dCHlKeTatU+3lqL6xv7QNf8x7N0QsKvLGnksiqH6W/62IBRIN2l2DdVqdSBV1v5IUgh4pgqps4hBesHlJ04dK0Cmq+rayXhl3nZyE11OxG/FnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIHXqzlUXv55MiAwBqodTuZICT8DAM/Z61uIvSCkulQ=;
 b=QroI5Z6uo7TI+x5pUPQgMkTIU5d8fk7eSP5U54+BAZyug+91EKAf6SYh0JgZYIyZ6DtoRa+RA2s8a4bDu3xRGbWJtlAZ3qM74XuqUFfvaxx8Kt0L+ohORPW0QuEshg8/4YkvjSXO/VJoIUzf5OO/dDCvyOxTjdrKCvMw1Pukvfg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by SJ2PR12MB8718.namprd12.prod.outlook.com (2603:10b6:a03:540::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Thu, 31 Aug
 2023 02:26:03 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::da13:5f6:45:fa40]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::da13:5f6:45:fa40%4]) with mapi id 15.20.6699.027; Thu, 31 Aug 2023
 02:26:03 +0000
Date: Thu, 31 Aug 2023 10:25:41 +0800
From: Huang Rui <ray.huang@amd.com>
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "akihiko.odaki@gmail.com" <akihiko.odaki@gmail.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "shentey@gmail.com" <shentey@gmail.com>, "hi@alyssa.is" <hi@alyssa.is>,
 "ernunes@redhat.com" <ernunes@redhat.com>,
 "manos.pitsidianakis@linaro.org" <manos.pitsidianakis@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v13 0/9] rutabaga_gfx + gfxstream
Message-ID: <ZO/6JXmYm/lW9dSZ@amd.com>
References: <20230829003629.410-1-gurchetansingh@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829003629.410-1-gurchetansingh@chromium.org>
X-ClientProxiedBy: TY2PR0101CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::24) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|SJ2PR12MB8718:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c1bc8ff-dabb-4097-fb0b-08dba9c99f32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IR6YODKPePmMhKoGqCQbmx+6tl4pGjlHukIilTePd+X/jGHY9kFbiSgYPfPsRu/k6XeBOO8u9qYevMlDIEM6pRsQUtq2tpULV9kGezmpxnUmfDY05oUn79DouHX3+Pha6+34EXPUqsF5yFNAGArbkogcZ5+T4Tq3CFn/6SdZlDMy1E4RO9jnPF0S5dJ1LGPi+3f1OQ1J6nny/KjquXKdLHJrBjfL5Dy8nWgvQGwGOw9ramZ1lNSwUvaSgxv/KG3NwnAppZr7Q7+lr8/tyCCEapIZU9qSBR4yXGJlCGnnVF9VRLf4qdrXi0y5NjoiBmoZmz3o46fVuaYiOs0x/5crrFh/aRgV9WksXTEt/zjZ+e0xoEQRmrzZ11//b0z/ZCOA/TZxH9tw1IUe0wzhjc/WT6TvjjCLf9u5ZTcTQEexRvgEhTaNL+trHf4j4kHdN9czIQBx5uGRac8SyaUc8abvtlLKs2Q8CR5SIH1/RwYwKI8wcm+1ECGmIk2vkN4spmtap35iDJ4XJ1a9wRjUjaChhjtRSdQgjfZDAN1keifT5oGm/2zk2MiLXN4LeGC4ZEEuz/08a+8oZ0SXwJMbs1SstS5eg0obSVXJ0rJd8rftquI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8690.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199024)(1800799009)(186009)(6512007)(316002)(38100700002)(41300700001)(5660300002)(4326008)(7416002)(2616005)(83380400001)(8676002)(86362001)(26005)(36756003)(6916009)(2906002)(8936002)(6666004)(66556008)(6506007)(966005)(6486002)(66476007)(54906003)(478600001)(66946007)(156123004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0xElkX9ZzUsUpRd2FJ4RQq/AjCS7zVNd8UBrY1Dib1ArxK9zvIZmePwfk2F8?=
 =?us-ascii?Q?blCr0ZFtWUwLU04CBO07tV6bX+0ehT78Atd3o/jQCmlDxqBGRtm2BmL62BXk?=
 =?us-ascii?Q?BrGU+GRxX2BC8ooHBrGcB1PdZCGaMcd4BbX103DFWr5fIu25QkWvaEVZXcQQ?=
 =?us-ascii?Q?qOafXWVyJFsD3uDFSP0kFFJIYngk1IFPSyEGzwBBkh5WZQ5YW3EfZvmtJoiT?=
 =?us-ascii?Q?/12RjCXbJIWsHYVW90xcIENMDlUKLIiM6oY1AEDlBWHPwo/EVdB3iouq9S06?=
 =?us-ascii?Q?RQbhP5qjLcWOMBZx8SuCpIJurKXqEJJCOdvND3sMo8JB8dasCYm1WWDcbxCD?=
 =?us-ascii?Q?rs2bC/WMP+4CkgiAcNvAICrJS3Um4xTVCbOVQd1CQcbBV8OxKIeFbtOVpUn4?=
 =?us-ascii?Q?gzMdWKqB0pd2Z0KccrDSQWaU/bewKKWMwIBIvZn0BpArfNqLtl59RakXy8yo?=
 =?us-ascii?Q?KnPunMNQj7telwThXBa1wicXSzjEhPFnHqm5F+iJwp/2Q4WCmXoePbhXW3+s?=
 =?us-ascii?Q?D5Irb0ATiULnUyWNk+rrDcKUq+N0CUeUmfUdh25DjVAP5i2DC4JguF5NAe6P?=
 =?us-ascii?Q?L28ZwRTJ9bsKIlGjCgFcufRhPCp/kxbdVTq2gqLQWE5qcHmgyiIwmGEQ5eWz?=
 =?us-ascii?Q?6mPZiAs3igM8d0gvz44MU02dUAyENxWxuqwuGTv8sCLeDHatKu9S4Icl+j97?=
 =?us-ascii?Q?+Gxlb0s97yzOX2ZpMUN71mUdOW+nYLmfs79ayaV+I14zrFyacRKyJ6ZInf7F?=
 =?us-ascii?Q?1gM+mlYZzI2siUSpIBDeSRzc1I2wHxxQ++SNCN/0j2eYDNhacmVI1GJB1Vo0?=
 =?us-ascii?Q?C6OPznA5GwXRDRnRaRu7Ycqqz8/0Dv2IJ0uxFcKJjFpqdKVSCXXMKc3KF15f?=
 =?us-ascii?Q?K58z9HDIhhQ5xBYayCYc7DiAqFRGIifgW6rHiwPrQV1s61T3CXU9NIC/hdan?=
 =?us-ascii?Q?e5d+EmfA6OmexIeR/YSp9AJAHnyz0PGhIslHz7Nv6w1u3rPeDlemwD6eXifz?=
 =?us-ascii?Q?xc65SOA3p07O87dhMiC5TLA33wVhC+0lkkViJkUQiDM6vfaAnHk+J1/+Xn8S?=
 =?us-ascii?Q?JvBqTDCmwhv3ogUNVXf0zEhFyvhH0REIfv6M7vRtvlz2noDF5JWrhqLReRYZ?=
 =?us-ascii?Q?B2EYNphsmzVcB9fU8N19yOwXGJMgeWoj+JZin7rTj3HdVc6zZeKXCzl31kLM?=
 =?us-ascii?Q?wg80eNKq1ht/dmLsi7is9shgeUrmm3jXrLiYtqYRp9nwr+t03HJLcZgv3zEE?=
 =?us-ascii?Q?gBF+ZKdlXRG8OEtT6FdwzEHGxxTNydQd4RFBzAL7ZRPDGQVEwveMl8sZvBxA?=
 =?us-ascii?Q?wW5pN0N6Oxiy+2MEXZiphvuZZseQtjoSbL81hG5Zzpl6Yi83rj+pRNOrSRf9?=
 =?us-ascii?Q?wz/9Pb7UKdX0afl4Xo5tFK/vKOe6y7p3tuVMdYMc+z4ciz1kr535nKLvV3Fk?=
 =?us-ascii?Q?z8wPQX5zIsl2205v/uG4AK3vzzcAJAv20WiV9+YWJ792rgj6dEam9mulmwV0?=
 =?us-ascii?Q?nPagkJldubX3bEbiTY+Bxzf7NC9D9+v47Dv7ktY0vGksoC0QvTAx4T0NLgK2?=
 =?us-ascii?Q?HCK1GqD257ilOk1Rq2YZ9XL5qPzTG50Ipovc4LSc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c1bc8ff-dabb-4097-fb0b-08dba9c99f32
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 02:26:02.9810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6IBio27q+a98Ph+gZUwobX0FVrrUqKQhIizDrMHlpABXdogeJCkUSmvvWGtmQjEmUcNPALahOe4FiQ5zEqVzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8718
Received-SPF: softfail client-ip=40.107.237.61; envelope-from=Ray.Huang@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 29, 2023 at 08:36:20AM +0800, Gurchetan Singh wrote:
> From: Gurchetan Singh <gurchetansingh@google.com>
> 
> Changes since v12:
> - Added r-b tags from Antonio Caggiano and Akihiko Odaki
> - Removed review version from commit messages
> - I think we're good to merge since we've had multiple people test and review this series??
> 
> How to build both rutabaga and gfxstream guest/host libs:
> 
> https://crosvm.dev/book/appendix/rutabaga_gfx.html
> 
> Branch containing this patch series:
> 
> https://gitlab.com/gurchetansingh/qemu/-/commits/qemu-gfxstream-v13
> 
> Antonio Caggiano (2):
>   virtio-gpu: CONTEXT_INIT feature
>   virtio-gpu: blob prep
> 
> Dr. David Alan Gilbert (1):
>   virtio: Add shared memory capability
> 
> Gerd Hoffmann (1):
>   virtio-gpu: hostmem

Patch 1 -> 4 are

Acked-and-Tested-by: Huang Rui <ray.huang@amd.com>

> 
> Gurchetan Singh (5):
>   gfxstream + rutabaga prep: added need defintions, fields, and options
>   gfxstream + rutabaga: add initial support for gfxstream
>   gfxstream + rutabaga: meson support
>   gfxstream + rutabaga: enable rutabaga
>   docs/system: add basic virtio-gpu documentation
> 
>  docs/system/device-emulation.rst     |    1 +
>  docs/system/devices/virtio-gpu.rst   |  112 +++
>  hw/display/meson.build               |   22 +
>  hw/display/virtio-gpu-base.c         |    6 +-
>  hw/display/virtio-gpu-pci-rutabaga.c |   47 ++
>  hw/display/virtio-gpu-pci.c          |   14 +
>  hw/display/virtio-gpu-rutabaga.c     | 1119 ++++++++++++++++++++++++++
>  hw/display/virtio-gpu.c              |   16 +-
>  hw/display/virtio-vga-rutabaga.c     |   50 ++
>  hw/display/virtio-vga.c              |   33 +-
>  hw/virtio/virtio-pci.c               |   18 +
>  include/hw/virtio/virtio-gpu-bswap.h |   15 +
>  include/hw/virtio/virtio-gpu.h       |   41 +
>  include/hw/virtio/virtio-pci.h       |    4 +
>  meson.build                          |    7 +
>  meson_options.txt                    |    2 +
>  scripts/meson-buildoptions.sh        |    3 +
>  softmmu/qdev-monitor.c               |    3 +
>  softmmu/vl.c                         |    1 +
>  19 files changed, 1495 insertions(+), 19 deletions(-)
>  create mode 100644 docs/system/devices/virtio-gpu.rst
>  create mode 100644 hw/display/virtio-gpu-pci-rutabaga.c
>  create mode 100644 hw/display/virtio-gpu-rutabaga.c
>  create mode 100644 hw/display/virtio-vga-rutabaga.c
> 
> -- 
> 2.42.0.rc2.253.gd59a3bf2b4-goog
> 

