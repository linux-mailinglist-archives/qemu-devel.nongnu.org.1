Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 904547752CD
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 08:20:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTcYM-0006ou-2z; Wed, 09 Aug 2023 02:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ray.Huang@amd.com>) id 1qTcYK-0006of-5A
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 02:20:16 -0400
Received: from mail-mw2nam10on20626.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::626]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ray.Huang@amd.com>) id 1qTcYF-0007Ig-46
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 02:20:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imOvKPhPS0ljRfF6lVvoQDYDDTM491Ckp0qNP2ofnVMxOMdizR7HWT724R6Ps3I0CcO2SgS5wWKOjlQf8BnuNiKozu0t2SZV1dismneeZKEpiyym48FvQ+k+X6Mc/1J1KsXzmDlbObNt39Ig/+ja9Sty2U0oAHn2n0eKvjZaX8GiSpd4OMumr+9ECzh7PToRTcYOTW+qTRIxCIS25nZmP8ezrLhUmXgxCjTf21r27uWuCfNh58XiUWLZTvjJUCiOH2wnN80ksqp6DTxJHkT3oZcd1hFCIiVWkoM2HZE4dS0K2O+Uf+n/yKVHIrPub+toonQYGQx+o4dRq0euxerh4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFMo6m5U7DKhKENx6bOFHhpsOIpM3lDULf8BC6B90eQ=;
 b=Bmy20kbXRZeSo+I9tBTyFHR6fGZ9UwBRA/DpWF1a3wFaU8z8tqnf2qmwjkhkZVZ/6k2/LHq0fBOa8AdUjAegme001tywgdFEbkO0bNcvLGFAsB3F/dcjgY0njA0j+TFbI/rPeG9dyW5AnRMdZVY+D5v9nLt3nq8wktKk2j2w8Fan4IVH9C6w76vJG7OhRCu5KVOLvlq9yQfcQw0o+pkuwDqPs89p+9Rhw0BwsZL5zdXjwJOfafugKe12bhFdwYscSaS1IC8PE8KMPrB+H+F+twXl3hNL8BZs+uk+R4ZD4dN7UscJstOrvqnCa/VNz+JlvUKiAdkKitTGK67z4nvhyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFMo6m5U7DKhKENx6bOFHhpsOIpM3lDULf8BC6B90eQ=;
 b=I9Pi1w3BdxoWx1YrHpmRdwTuzL1wxxLY4X3Ba52v+i0yUrBjioAQaUCI0jYJ+5xZo1da6WhicC3/6g0zZROmy8O9d5ecfEfxwbNFGsy5lyotYbFqtdUFemijxrLXPwjdNTeTgIplnQo7YxYpUVedS5qt6DsvcewqxiHhOOnTroc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by DM6PR12MB4960.namprd12.prod.outlook.com (2603:10b6:5:1bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 06:20:04 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::da13:5f6:45:fa40]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::da13:5f6:45:fa40%4]) with mapi id 15.20.6652.025; Wed, 9 Aug 2023
 06:20:03 +0000
Date: Wed, 9 Aug 2023 14:19:39 +0800
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "akihiko.odaki@gmail.com" <akihiko.odaki@gmail.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "shentey@gmail.com" <shentey@gmail.com>, "hi@alyssa.is" <hi@alyssa.is>,
 "ernunes@redhat.com" <ernunes@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v4 6/9] gfxstream + rutabaga: add initial support for
 gfxstream
Message-ID: <ZNMv+yjXqi5pWW7H@amd.com>
References: <20230809021108.674-1-gurchetansingh@chromium.org>
 <20230809021108.674-7-gurchetansingh@chromium.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230809021108.674-7-gurchetansingh@chromium.org>
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|DM6PR12MB4960:EE_
X-MS-Office365-Filtering-Correlation-Id: bae34b6d-d779-469d-784c-08db98a0aabf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m7CB1MWShI56xXedzJCwUuRwyXShtLA1n8FceydgWF2BpiKins2sQrT8rJCUtQd0bs78Dfs4hJojmlu9VZ1PBJDRxe83Wheg6Neb6ABYCm6IorxM75Qxr48PYQdlUXhO9K8N/jrWqs1a16nEB59jHsVF19+jAG0qKGXYJn0CwmWVI63Y0MBz5ioBxmJdss9nayZvPYBbPs/SsHvTzNg5fYDlvcH3AU3eSN3cntu4p6R8n5IxYe1ZboPv4eUicrN2MBMJK6PmfpgK9LuFHfVJ25vS5iggEetKupbVBQzoPZDlkvJRaO4YJHv/w2hmQJCklHOuSxDr6ZBJ0jddVvFwFBcJGyBFBscTkGYdpKNquRncG0E3s/PtinhV2COGMXTYFD5ATE8YzBu/7VLx43tZv4qm9I6tLXrRTUNnFju610PHTf33WGIhbURZKyHgni5LNs1NRsSBFVv9vGtOHRmrgCa2jY0K5Do4QQyywPj4dKGgAq9g0kb9rk5CeyMm4EtTVqzwtPKveJJFzA79pRwY1IT7gI0TEjaCssYlk42jZqpn52MgKgOmb18o0/7r4GUxCrTo73P/iMA6dTQItrjj6CyRLYIkDTljOChqSC9SYkIlhDGdIIsoN380UeB2UOa9vKlJQOutHPjfkPemKrZndw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8690.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(366004)(136003)(376002)(39860400002)(346002)(1800799006)(451199021)(186006)(2616005)(6512007)(36756003)(4326008)(966005)(316002)(6916009)(38100700002)(54906003)(6486002)(6666004)(86362001)(6506007)(66556008)(66946007)(66476007)(478600001)(26005)(8936002)(41300700001)(66899021)(8676002)(2906002)(30864003)(7416002)(83380400001)(5660300002)(21314003)(156123004)(67856001)(579004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Ospq6ZlFtlG7lQRZc9aHeeXokCkAc92xVFTYjKL94ZR/gnM5IUIAYEiMTA?=
 =?iso-8859-1?Q?V4DTh3IMuLiS0Bwrs1YK+r5dRkg0Fj0q1dsz/7UFSk21YSYitkIQUR3mpX?=
 =?iso-8859-1?Q?MpVxZGHU9A4QmjzRH7vdpWWDDzMIMNUHgXlREGFzh1ZVkHWC8GgYklhIQt?=
 =?iso-8859-1?Q?mjGUAFeeslq8FbTHsDGCJyEH9k51Z21glNnUZfs8ry/xMnNecMVOp7VAen?=
 =?iso-8859-1?Q?picriBZ1z1fKO8wiCqwmyzaviC/+WHVvppm7pAyna4e8VsxrxZv/1IZB13?=
 =?iso-8859-1?Q?xFn0Lkb4z8q28xGk8wpkFjSws18cq0V+FUph4viT3KfLr8aMMzn3Hkktrs?=
 =?iso-8859-1?Q?jwamSy5EECf0HJCduJvks3KA2GpvIaXKWs2+7kSXov36W+OuWWjTfD2sZX?=
 =?iso-8859-1?Q?mEr8BENnGCF6tZo+hcDq9iCnOl0ErHv/KokgVzfpOMffXmIpgS1BYZJtSn?=
 =?iso-8859-1?Q?jCddnSlnRxVBN2Vyq4paf17dRRNd5pmKsrKWl7+XmbyHSxpm3A7WggN3U0?=
 =?iso-8859-1?Q?LmdbJsm5OR4xefYdZ7U+5GVOnVfmwAO5TQN0foqOqYflZQbuWNLl65/51b?=
 =?iso-8859-1?Q?KRY0Wp3VDb+R6TAe/w8VehzWBl/hRIDbHoJOLxjG6rzfrzmjqE5T5oEsA8?=
 =?iso-8859-1?Q?OsQxgKlgyFlmiMU+MoIKyjh2H4ApRXWiAoQdA2zMPUJzL+2xb7BJ/NQipg?=
 =?iso-8859-1?Q?cnatNR/vQOaeEMHG/LrG2wXK1MtTJBggiUbdQ2QGiShfIWKDFNz2vHNvHL?=
 =?iso-8859-1?Q?Zaelcvh+jQvimbpz8bVlQzyQs6DAz9rS9FIMx9rDo71D74ckmSqaWDhRm4?=
 =?iso-8859-1?Q?t+MK8tQG8BOX76FLpLpJB11IhlaQq/3xUR1guk2NrdKilBLvvP6vtExe/4?=
 =?iso-8859-1?Q?Vn8Cmh6yYhTmFU6vyIz23a6beIMcxg42beTyE1/LEIN48X8paKjoJmx+dG?=
 =?iso-8859-1?Q?KiBICI4mJi/9ToLbjmyxA32r62FeOIlJTX0Ac7BIHdlJU4JOf2/BMEUJuF?=
 =?iso-8859-1?Q?HBx/u1BxWMY/gVBte3HdCisPrvsol/1BhyTtB2woAyw43v/D+Pv1kGNgcg?=
 =?iso-8859-1?Q?LeUTjuGQgMSGZWp/SVv2oa7pde9VtZB5tSqR9HQDS8WrHpNq8Aq+hWt9IH?=
 =?iso-8859-1?Q?RlGTW5ga+p5nL4Kk3QAKOW7Ta+IzpgV13pTvuO+lGZhR1aJW7jW14eSqVB?=
 =?iso-8859-1?Q?w2NypqNiUzlV5KV1Ql7o7Bl+rGaaVepwVb3KZa42Ry0LcFkpUj2QNBtHDF?=
 =?iso-8859-1?Q?S3P/8gwSNM3/MEsw9b3aSkpOJRazt3qNIdSZ8PoYMaU5bwZAAV+in9Y3sy?=
 =?iso-8859-1?Q?wBTNeN19bFRIQDLAp3FLs/qJV0bGNoc1XmJB9IA1TU2ZRG9h0RvbJ/Qpaf?=
 =?iso-8859-1?Q?wp2g42O3njl5ZonhzlEfDnACyQ7fXBAOrsjPMU0yavsr4zV7Seev+uWuxG?=
 =?iso-8859-1?Q?XfY2PO/LUQJAwNkSjjDCNKCErGABbwztQgEevTk6/Nvjh37yFO32wN8OmY?=
 =?iso-8859-1?Q?MfhX6vIvYjFHpXartPV+IIJAYV6i49yx+9KUX1vssUDoXzq7rdFl/8W13N?=
 =?iso-8859-1?Q?4VFc5+GKvtc1nm+7IT7z3B49Mj3N/igWYwLQUT15IER2Tbj3YaxRW9eNU4?=
 =?iso-8859-1?Q?XcHyHphhOg3fYjUYQQ1YVrR6a8HX6lGp8Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bae34b6d-d779-469d-784c-08db98a0aabf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 06:20:03.5554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G6kn+KULN2wrFx5u2oCO4uuuBNFSPqvHnmKcW54PWuSlXMP2trFeC9Chb//ZpOVCw5F4uGBvXUI/SYtxrDs2ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4960
Received-SPF: softfail client-ip=2a01:111:f400:7e89::626;
 envelope-from=Ray.Huang@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Huang Rui <ray.huang@amd.com>
From:  Huang Rui via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Aug 09, 2023 at 10:11:05AM +0800, Gurchetan Singh wrote:
> This adds initial support for gfxstream and cross-domain.  Both
> features rely on virtio-gpu blob resources and context types, which
> are also implemented in this patch.
> 
> gfxstream has a long and illustrious history in Android graphics
> paravirtualization.  It has been powering graphics in the Android
> Studio Emulator for more than a decade, which is the main developer
> platform.
> 
> Originally conceived by Jesse Hall, it was first known as "EmuGL" [a].
> The key design characteristic was a 1:1 threading model and
> auto-generation, which fit nicely with the OpenGLES spec.  It also
> allowed easy layering with ANGLE on the host, which provides the GLES
> implementations on Windows or MacOS enviroments.
> 
> gfxstream has traditionally been maintained by a single engineer, and
> between 2015 to 2021, the goldfish throne passed to Frank Yang.
> Historians often remark this glorious reign ("pax gfxstreama" is the
> academic term) was comparable to that of Augustus and both Queen
> Elizabeths.  Just to name a few accomplishments in a resplendent
> panoply: higher versions of GLES, address space graphics, snapshot
> support and CTS compliant Vulkan [b].
> 
> One major drawback was the use of out-of-tree goldfish drivers.
> Android engineers didn't know much about DRM/KMS and especially TTM so
> a simple guest to host pipe was conceived.
> 
> Luckily, virtio-gpu 3D started to emerge in 2016 due to the work of
> the Mesa/virglrenderer communities.  In 2018, the initial virtio-gpu
> port of gfxstream was done by Cuttlefish enthusiast Alistair Delva.
> It was a symbol compatible replacement of virglrenderer [c] and named
> "AVDVirglrenderer".  This implementation forms the basis of the
> current gfxstream host implementation still in use today.
> 
> cross-domain support follows a similar arc.  Originally conceived by
> Wayland aficionado David Reveman and crosvm enjoyer Zach Reizner in
> 2018, it initially relied on the downstream "virtio-wl" device.
> 
> In 2020 and 2021, virtio-gpu was extended to include blob resources
> and multiple timelines by yours truly, features gfxstream/cross-domain
> both require to function correctly.
> 
> Right now, we stand at the precipice of a truly fantastic possibility:
> the Android Emulator powered by upstream QEMU and upstream Linux
> kernel.  gfxstream will then be packaged properfully, and app
> developers can even fix gfxstream bugs on their own if they encounter
> them.
> 
> It's been quite the ride, my friends.  Where will gfxstream head next,
> nobody really knows.  I wouldn't be surprised if it's around for
> another decade, maintained by a new generation of Android graphics
> enthusiasts.
> 
> Technical details:
>   - Very simple initial display integration: just used Pixman
>   - Largely, 1:1 mapping of virtio-gpu hypercalls to rutabaga function
>     calls
> 
> Next steps for Android VMs:
>   - The next step would be improving display integration and UI interfaces
>     with the goal of the QEMU upstream graphics being in an emulator
>     release [d].
> 
> Next steps for Linux VMs for display virtualization:
>   - For widespread distribution, someone needs to package Sommelier or the
>     wayland-proxy-virtwl [e] ideally into Debian main. In addition, newer
>     versions of the Linux kernel come with DRM_VIRTIO_GPU_KMS option,
>     which allows disabling KMS hypercalls.  If anyone cares enough, it'll
>     probably be possible to build a custom VM variant that uses this display
>     virtualization strategy.
> 
> [a] https://android-review.googlesource.com/c/platform/development/+/34470
> [b] https://android-review.googlesource.com/q/topic:%22vulkan-hostconnection-start%22
> [c] https://android-review.googlesource.com/c/device/generic/goldfish-opengl/+/761927
> [d] https://developer.android.com/studio/releases/emulator
> [e] https://github.com/talex5/wayland-proxy-virtwl
> 
> Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
> Tested-by: Alyssa Ross <hi@alyssa.is>
> ---
> v1: Incorported various suggestions by Akihiko Odaki and Bernard Berschow
>     - Removed GET_VIRTIO_GPU_GL / GET_RUTABAGA macros
>     - Used error_report(..)
>     - Used g_autofree to fix leaks on error paths
>     - Removed unnecessary casts
>     - added virtio-gpu-pci-rutabaga.c + virtio-vga-rutabaga.c files
> 
> v2: Incorported various suggestions by Akihiko Odaki, Marc-André Lureau and
>     Bernard Berschow:
>     - Parenthesis in CHECK macro
>     - CHECK_RESULT(result, ..) --> CHECK(!result, ..)
>     - delay until g->parent_obj.enable = 1
>     - Additional cast fixes
>     - initialize directly in virtio_gpu_rutabaga_realize(..)
>     - add debug callback to hook into QEMU error's APIs
> 
> v3: Incorporated feedback from Akihiko Odaki and Alyssa Ross:
>     - Autodetect Wayland socket when not explicitly specified
>     - Fix map_blob error paths
>     - Add comment why we need both `res` and `resource` in create blob
>     - Cast and whitespace fixes
>     - Big endian check comes before virtio_gpu_rutabaga_init().
>     - VirtIOVGARUTABAGA --> VirtIOVGARutabaga
> 
> v4: Incorporated feedback from Akihiko Odaki and Alyssa Ross:
>     - Double checked all casts
>     - Remove unnecessary parenthesis
>     - Removed `resource` in create_blob
>     - Added comment about failure case
>     - Pass user-provided socket as-is
>     - Use stack variable rather than heap allocation
>     - Future-proofed map info API to give access flags as well
> 
>  hw/display/virtio-gpu-pci-rutabaga.c |   48 ++
>  hw/display/virtio-gpu-rutabaga.c     | 1116 ++++++++++++++++++++++++++
>  hw/display/virtio-vga-rutabaga.c     |   51 ++
>  3 files changed, 1215 insertions(+)
>  create mode 100644 hw/display/virtio-gpu-pci-rutabaga.c
>  create mode 100644 hw/display/virtio-gpu-rutabaga.c
>  create mode 100644 hw/display/virtio-vga-rutabaga.c
> 
> diff --git a/hw/display/virtio-gpu-pci-rutabaga.c b/hw/display/virtio-gpu-pci-rutabaga.c
> new file mode 100644
> index 0000000000..c71173d8ca
> --- /dev/null
> +++ b/hw/display/virtio-gpu-pci-rutabaga.c
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/module.h"
> +#include "hw/pci/pci.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/virtio/virtio.h"
> +#include "hw/virtio/virtio-bus.h"
> +#include "hw/virtio/virtio-gpu-pci.h"
> +#include "qom/object.h"
> +
> +#define TYPE_VIRTIO_GPU_RUTABAGA_PCI "virtio-gpu-rutabaga-pci"
> +typedef struct VirtIOGPURutabagaPCI VirtIOGPURutabagaPCI;
> +DECLARE_INSTANCE_CHECKER(VirtIOGPURutabagaPCI, VIRTIO_GPU_RUTABAGA_PCI,
> +                         TYPE_VIRTIO_GPU_RUTABAGA_PCI)
> +
> +struct VirtIOGPURutabagaPCI {
> +    VirtIOGPUPCIBase parent_obj;
> +    VirtIOGPURutabaga vdev;
> +};
> +
> +static void virtio_gpu_rutabaga_initfn(Object *obj)
> +{
> +    VirtIOGPURutabagaPCI *dev = VIRTIO_GPU_RUTABAGA_PCI(obj);
> +
> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> +                                TYPE_VIRTIO_GPU_RUTABAGA);
> +    VIRTIO_GPU_PCI_BASE(obj)->vgpu = VIRTIO_GPU_BASE(&dev->vdev);
> +}
> +
> +static const VirtioPCIDeviceTypeInfo virtio_gpu_rutabaga_pci_info = {
> +    .generic_name = TYPE_VIRTIO_GPU_RUTABAGA_PCI,
> +    .parent = TYPE_VIRTIO_GPU_PCI_BASE,
> +    .instance_size = sizeof(VirtIOGPURutabagaPCI),
> +    .instance_init = virtio_gpu_rutabaga_initfn,
> +};
> +module_obj(TYPE_VIRTIO_GPU_RUTABAGA_PCI);
> +module_kconfig(VIRTIO_PCI);
> +
> +static void virtio_gpu_rutabaga_pci_register_types(void)
> +{
> +    virtio_pci_types_register(&virtio_gpu_rutabaga_pci_info);
> +}
> +
> +type_init(virtio_gpu_rutabaga_pci_register_types)
> +
> +module_dep("hw-display-virtio-gpu-pci");
> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
> new file mode 100644
> index 0000000000..8ddd3b1cbf
> --- /dev/null
> +++ b/hw/display/virtio-gpu-rutabaga.c
> @@ -0,0 +1,1116 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/error-report.h"
> +#include "qemu/iov.h"
> +#include "trace.h"
> +#include "hw/virtio/virtio.h"
> +#include "hw/virtio/virtio-gpu.h"
> +#include "hw/virtio/virtio-gpu-pixman.h"
> +#include "hw/virtio/virtio-iommu.h"
> +
> +#include <glib/gmem.h>
> +#include <rutabaga_gfx/rutabaga_gfx_ffi.h>
> +
> +#define CHECK(condition, cmd)                                                 \
> +    do {                                                                      \
> +        if (!(condition)) {                                                   \
> +            error_report("CHECK failed in %s() %s:" "%d", __func__,           \
> +                         __FILE__, __LINE__);                                 \
> +            (cmd)->error = VIRTIO_GPU_RESP_ERR_UNSPEC;                        \
> +            return;                                                           \
> +       }                                                                      \
> +    } while (0)
> +
> +/*
> + * This is the size of the char array in struct sock_addr_un. No Wayland socket
> + * can be created with a path longer than this, including the null terminator.
> + */
> +#ifndef UNIX_PATH_MAX
> +#define UNIX_PATH_MAX 108
> +#endif
> +
> +struct rutabaga_aio_data {
> +    struct VirtIOGPURutabaga *vr;
> +    struct rutabaga_fence fence;
> +};
> +
> +static void
> +virtio_gpu_rutabaga_update_cursor(VirtIOGPU *g, struct virtio_gpu_scanout *s,
> +                                  uint32_t resource_id)
> +{
> +    struct virtio_gpu_simple_resource *res;
> +    struct rutabaga_transfer transfer = { 0 };
> +    struct iovec transfer_iovec;
> +
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    res = virtio_gpu_find_resource(g, resource_id);
> +    if (!res) {
> +        return;
> +    }
> +
> +    if (res->width != s->current_cursor->width ||
> +        res->height != s->current_cursor->height) {
> +        return;
> +    }
> +
> +    transfer.x = 0;
> +    transfer.y = 0;
> +    transfer.z = 0;
> +    transfer.w = res->width;
> +    transfer.h = res->height;
> +    transfer.d = 1;
> +
> +    transfer_iovec.iov_base = s->current_cursor->data;
> +    transfer_iovec.iov_len = res->width * res->height * 4;
> +
> +    rutabaga_resource_transfer_read(vr->rutabaga, 0,
> +                                    resource_id, &transfer,
> +                                    &transfer_iovec);
> +}
> +
> +static void
> +virtio_gpu_rutabaga_gl_flushed(VirtIOGPUBase *b)
> +{
> +    VirtIOGPU *g = VIRTIO_GPU(b);
> +    virtio_gpu_process_cmdq(g);
> +}
> +
> +static void
> +rutabaga_cmd_create_resource_2d(VirtIOGPU *g,
> +                                struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    struct rutabaga_create_3d rc_3d = { 0 };
> +    struct virtio_gpu_simple_resource *res;
> +    struct virtio_gpu_resource_create_2d c2d;
> +
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(c2d);
> +    trace_virtio_gpu_cmd_res_create_2d(c2d.resource_id, c2d.format,
> +                                       c2d.width, c2d.height);
> +
> +    rc_3d.target = 2;
> +    rc_3d.format = c2d.format;
> +    rc_3d.bind = (1 << 1);
> +    rc_3d.width = c2d.width;
> +    rc_3d.height = c2d.height;
> +    rc_3d.depth = 1;
> +    rc_3d.array_size = 1;
> +    rc_3d.last_level = 0;
> +    rc_3d.nr_samples = 0;
> +    rc_3d.flags = VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP;
> +
> +    result = rutabaga_resource_create_3d(vr->rutabaga, c2d.resource_id, &rc_3d);
> +    CHECK(!result, cmd);
> +
> +    res = g_new0(struct virtio_gpu_simple_resource, 1);
> +    res->width = c2d.width;
> +    res->height = c2d.height;
> +    res->format = c2d.format;
> +    res->resource_id = c2d.resource_id;
> +
> +    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
> +}
> +
> +static void
> +rutabaga_cmd_create_resource_3d(VirtIOGPU *g,
> +                                struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    struct rutabaga_create_3d rc_3d = { 0 };
> +    struct virtio_gpu_simple_resource *res;
> +    struct virtio_gpu_resource_create_3d c3d;
> +
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(c3d);
> +
> +    trace_virtio_gpu_cmd_res_create_3d(c3d.resource_id, c3d.format,
> +                                       c3d.width, c3d.height, c3d.depth);
> +
> +    rc_3d.target = c3d.target;
> +    rc_3d.format = c3d.format;
> +    rc_3d.bind = c3d.bind;
> +    rc_3d.width = c3d.width;
> +    rc_3d.height = c3d.height;
> +    rc_3d.depth = c3d.depth;
> +    rc_3d.array_size = c3d.array_size;
> +    rc_3d.last_level = c3d.last_level;
> +    rc_3d.nr_samples = c3d.nr_samples;
> +    rc_3d.flags = c3d.flags;
> +
> +    result = rutabaga_resource_create_3d(vr->rutabaga, c3d.resource_id, &rc_3d);
> +    CHECK(!result, cmd);
> +
> +    res = g_new0(struct virtio_gpu_simple_resource, 1);
> +    res->width = c3d.width;
> +    res->height = c3d.height;
> +    res->format = c3d.format;
> +    res->resource_id = c3d.resource_id;
> +
> +    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
> +}
> +
> +static void
> +rutabaga_cmd_resource_unref(VirtIOGPU *g,
> +                            struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    struct virtio_gpu_simple_resource *res;
> +    struct virtio_gpu_resource_unref unref;
> +
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(unref);
> +
> +    trace_virtio_gpu_cmd_res_unref(unref.resource_id);
> +
> +    res = virtio_gpu_find_resource(g, unref.resource_id);
> +    CHECK(res, cmd);
> +
> +    result = rutabaga_resource_unref(vr->rutabaga, unref.resource_id);
> +    CHECK(!result, cmd);
> +
> +    if (res->image) {
> +        pixman_image_unref(res->image);
> +    }
> +
> +    QTAILQ_REMOVE(&g->reslist, res, next);
> +    g_free(res);
> +}
> +
> +static void
> +rutabaga_cmd_context_create(VirtIOGPU *g,
> +                            struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    struct virtio_gpu_ctx_create cc;
> +
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(cc);
> +    trace_virtio_gpu_cmd_ctx_create(cc.hdr.ctx_id,
> +                                    cc.debug_name);
> +
> +    result = rutabaga_context_create(vr->rutabaga, cc.hdr.ctx_id,
> +                                     cc.context_init, cc.debug_name, cc.nlen);
> +    CHECK(!result, cmd);
> +}
> +
> +static void
> +rutabaga_cmd_context_destroy(VirtIOGPU *g,
> +                             struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    struct virtio_gpu_ctx_destroy cd;
> +
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(cd);
> +    trace_virtio_gpu_cmd_ctx_destroy(cd.hdr.ctx_id);
> +
> +    result = rutabaga_context_destroy(vr->rutabaga, cd.hdr.ctx_id);
> +    CHECK(!result, cmd);
> +}
> +
> +static void
> +rutabaga_cmd_resource_flush(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result, i;
> +    struct virtio_gpu_scanout *scanout = NULL;
> +    struct virtio_gpu_simple_resource *res;
> +    struct rutabaga_transfer transfer = { 0 };
> +    struct iovec transfer_iovec;
> +    struct virtio_gpu_resource_flush rf;
> +    bool found = false;
> +
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +    if (vr->headless) {
> +        return;
> +    }
> +
> +    VIRTIO_GPU_FILL_CMD(rf);
> +    trace_virtio_gpu_cmd_res_flush(rf.resource_id,
> +                                   rf.r.width, rf.r.height, rf.r.x, rf.r.y);
> +
> +    res = virtio_gpu_find_resource(g, rf.resource_id);
> +    CHECK(res, cmd);
> +
> +    for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
> +        scanout = &g->parent_obj.scanout[i];
> +        if (i == res->scanout_bitmask) {
> +            found = true;
> +            break;
> +        }
> +    }
> +
> +    if (!found) {
> +        return;
> +    }
> +
> +    transfer.x = 0;
> +    transfer.y = 0;
> +    transfer.z = 0;
> +    transfer.w = res->width;
> +    transfer.h = res->height;
> +    transfer.d = 1;
> +
> +    transfer_iovec.iov_base = pixman_image_get_data(res->image);
> +    transfer_iovec.iov_len = res->width * res->height * 4;
> +
> +    result = rutabaga_resource_transfer_read(vr->rutabaga, 0,
> +                                             rf.resource_id, &transfer,
> +                                             &transfer_iovec);
> +    CHECK(!result, cmd);
> +    dpy_gfx_update_full(scanout->con);
> +}
> +
> +static void
> +rutabaga_cmd_set_scanout(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
> +{
> +    struct virtio_gpu_simple_resource *res;
> +    struct virtio_gpu_scanout *scanout = NULL;
> +    struct virtio_gpu_set_scanout ss;
> +
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +    if (vr->headless) {
> +        return;
> +    }
> +
> +    VIRTIO_GPU_FILL_CMD(ss);
> +    trace_virtio_gpu_cmd_set_scanout(ss.scanout_id, ss.resource_id,
> +                                     ss.r.width, ss.r.height, ss.r.x, ss.r.y);
> +
> +    scanout = &g->parent_obj.scanout[ss.scanout_id];
> +
> +    if (ss.resource_id == 0) {
> +        return;
> +    }
> +
> +    res = virtio_gpu_find_resource(g, ss.resource_id);
> +    CHECK(res, cmd);
> +
> +    if (!res->image) {
> +        pixman_format_code_t pformat;
> +        pformat = virtio_gpu_get_pixman_format(res->format);
> +        CHECK(pformat, cmd);
> +
> +        res->image = pixman_image_create_bits(pformat,
> +                                              res->width,
> +                                              res->height,
> +                                              NULL, 0);
> +        CHECK(res->image, cmd);
> +        pixman_image_ref(res->image);
> +    }
> +
> +    g->parent_obj.enable = 1;
> +
> +    /* realloc the surface ptr */
> +    scanout->ds = qemu_create_displaysurface_pixman(res->image);
> +    dpy_gfx_replace_surface(scanout->con, NULL);
> +    dpy_gfx_replace_surface(scanout->con, scanout->ds);
> +    res->scanout_bitmask = ss.scanout_id;
> +}
> +
> +static void
> +rutabaga_cmd_submit_3d(VirtIOGPU *g,
> +                       struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    struct virtio_gpu_cmd_submit cs;
> +    struct rutabaga_command rutabaga_cmd = { 0 };
> +    g_autofree uint8_t *buf = NULL;
> +    size_t s;
> +
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(cs);
> +    trace_virtio_gpu_cmd_ctx_submit(cs.hdr.ctx_id, cs.size);
> +
> +    buf = g_new0(uint8_t, cs.size);
> +    s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
> +                   sizeof(cs), buf, cs.size);
> +    CHECK(s == cs.size, cmd);
> +
> +    rutabaga_cmd.ctx_id = cs.hdr.ctx_id;
> +    rutabaga_cmd.cmd = buf;
> +    rutabaga_cmd.cmd_size = cs.size;
> +
> +    result = rutabaga_submit_command(vr->rutabaga, &rutabaga_cmd);
> +    CHECK(!result, cmd);
> +}
> +
> +static void
> +rutabaga_cmd_transfer_to_host_2d(VirtIOGPU *g,
> +                                 struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    struct rutabaga_transfer transfer = { 0 };
> +    struct virtio_gpu_transfer_to_host_2d t2d;
> +
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(t2d);
> +    trace_virtio_gpu_cmd_res_xfer_toh_2d(t2d.resource_id);
> +
> +    transfer.x = t2d.r.x;
> +    transfer.y = t2d.r.y;
> +    transfer.z = 0;
> +    transfer.w = t2d.r.width;
> +    transfer.h = t2d.r.height;
> +    transfer.d = 1;
> +
> +    result = rutabaga_resource_transfer_write(vr->rutabaga, 0, t2d.resource_id,
> +                                              &transfer);
> +    CHECK(!result, cmd);
> +}
> +
> +static void
> +rutabaga_cmd_transfer_to_host_3d(VirtIOGPU *g,
> +                                 struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    struct rutabaga_transfer transfer = { 0 };
> +    struct virtio_gpu_transfer_host_3d t3d;
> +
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(t3d);
> +    trace_virtio_gpu_cmd_res_xfer_toh_3d(t3d.resource_id);
> +
> +    transfer.x = t3d.box.x;
> +    transfer.y = t3d.box.y;
> +    transfer.z = t3d.box.z;
> +    transfer.w = t3d.box.w;
> +    transfer.h = t3d.box.h;
> +    transfer.d = t3d.box.d;
> +    transfer.level = t3d.level;
> +    transfer.stride = t3d.stride;
> +    transfer.layer_stride = t3d.layer_stride;
> +    transfer.offset = t3d.offset;
> +
> +    result = rutabaga_resource_transfer_write(vr->rutabaga, t3d.hdr.ctx_id,
> +                                              t3d.resource_id, &transfer);
> +    CHECK(!result, cmd);
> +}
> +
> +static void
> +rutabaga_cmd_transfer_from_host_3d(VirtIOGPU *g,
> +                                   struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    struct rutabaga_transfer transfer = { 0 };
> +    struct virtio_gpu_transfer_host_3d t3d;
> +
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(t3d);
> +    trace_virtio_gpu_cmd_res_xfer_fromh_3d(t3d.resource_id);
> +
> +    transfer.x = t3d.box.x;
> +    transfer.y = t3d.box.y;
> +    transfer.z = t3d.box.z;
> +    transfer.w = t3d.box.w;
> +    transfer.h = t3d.box.h;
> +    transfer.d = t3d.box.d;
> +    transfer.level = t3d.level;
> +    transfer.stride = t3d.stride;
> +    transfer.layer_stride = t3d.layer_stride;
> +    transfer.offset = t3d.offset;
> +
> +    result = rutabaga_resource_transfer_read(vr->rutabaga, t3d.hdr.ctx_id,
> +                                             t3d.resource_id, &transfer, NULL);
> +    CHECK(!result, cmd);
> +}
> +
> +static void
> +rutabaga_cmd_attach_backing(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
> +{
> +    struct rutabaga_iovecs vecs = { 0 };
> +    struct virtio_gpu_simple_resource *res;
> +    struct virtio_gpu_resource_attach_backing att_rb;
> +    struct iovec *res_iovs;
> +    uint32_t res_niov;
> +    int ret;
> +
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(att_rb);
> +    trace_virtio_gpu_cmd_res_back_attach(att_rb.resource_id);
> +
> +    res = virtio_gpu_find_resource(g, att_rb.resource_id);
> +    CHECK(res, cmd);
> +    CHECK(!res->iov, cmd);
> +
> +    ret = virtio_gpu_create_mapping_iov(g, att_rb.nr_entries, sizeof(att_rb),
> +                                        cmd, NULL, &res_iovs, &res_niov);
> +    CHECK(!ret, cmd);
> +
> +    vecs.iovecs = res_iovs;
> +    vecs.num_iovecs = res_niov;
> +
> +    ret = rutabaga_resource_attach_backing(vr->rutabaga, att_rb.resource_id,
> +                                           &vecs);
> +    if (ret != 0) {
> +        virtio_gpu_cleanup_mapping_iov(g, res_iovs, res_niov);
> +    }
> +
> +    CHECK(!ret, cmd);
> +}
> +
> +static void
> +rutabaga_cmd_detach_backing(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
> +{
> +    struct virtio_gpu_simple_resource *res;
> +    struct virtio_gpu_resource_detach_backing detach_rb;
> +
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(detach_rb);
> +    trace_virtio_gpu_cmd_res_back_detach(detach_rb.resource_id);
> +
> +    res = virtio_gpu_find_resource(g, detach_rb.resource_id);
> +    CHECK(res, cmd);
> +
> +    rutabaga_resource_detach_backing(vr->rutabaga,
> +                                     detach_rb.resource_id);
> +
> +    virtio_gpu_cleanup_mapping(g, res);
> +}
> +
> +static void
> +rutabaga_cmd_ctx_attach_resource(VirtIOGPU *g,
> +                                 struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    struct virtio_gpu_ctx_resource att_res;
> +
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(att_res);
> +    trace_virtio_gpu_cmd_ctx_res_attach(att_res.hdr.ctx_id,
> +                                        att_res.resource_id);
> +
> +    result = rutabaga_context_attach_resource(vr->rutabaga, att_res.hdr.ctx_id,
> +                                              att_res.resource_id);
> +    CHECK(!result, cmd);
> +}
> +
> +static void
> +rutabaga_cmd_ctx_detach_resource(VirtIOGPU *g,
> +                                 struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    struct virtio_gpu_ctx_resource det_res;
> +
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(det_res);
> +    trace_virtio_gpu_cmd_ctx_res_detach(det_res.hdr.ctx_id,
> +                                        det_res.resource_id);
> +
> +    result = rutabaga_context_detach_resource(vr->rutabaga, det_res.hdr.ctx_id,
> +                                              det_res.resource_id);
> +    CHECK(!result, cmd);
> +}
> +
> +static void
> +rutabaga_cmd_get_capset_info(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    struct virtio_gpu_get_capset_info info;
> +    struct virtio_gpu_resp_capset_info resp;
> +
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(info);
> +
> +    result = rutabaga_get_capset_info(vr->rutabaga, info.capset_index,
> +                                      &resp.capset_id, &resp.capset_max_version,
> +                                      &resp.capset_max_size);
> +    CHECK(!result, cmd);
> +
> +    resp.hdr.type = VIRTIO_GPU_RESP_OK_CAPSET_INFO;
> +    virtio_gpu_ctrl_response(g, cmd, &resp.hdr, sizeof(resp));
> +}
> +
> +static void
> +rutabaga_cmd_get_capset(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    struct virtio_gpu_get_capset gc;
> +    struct virtio_gpu_resp_capset *resp;
> +    uint32_t capset_size;
> +    uint32_t current_id;
> +    bool found = false;
> +
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(gc);
> +    for (uint32_t i = 0; i < vr->num_capsets; i++) {
> +        result = rutabaga_get_capset_info(vr->rutabaga, i,
> +                                          &current_id, &capset_size,
> +                                          &capset_size);
> +        CHECK(!result, cmd);
> +
> +        if (current_id == gc.capset_id) {
> +            found = true;
> +            break;
> +        }
> +    }
> +
> +    if (!found) {
> +        error_report("capset not found!");
> +        return;
> +    }
> +
> +    resp = g_malloc0(sizeof(*resp) + capset_size);
> +    resp->hdr.type = VIRTIO_GPU_RESP_OK_CAPSET;
> +    rutabaga_get_capset(vr->rutabaga, gc.capset_id, gc.capset_version,
> +                        resp->capset_data, capset_size);
> +
> +    virtio_gpu_ctrl_response(g, cmd, &resp->hdr, sizeof(*resp) + capset_size);
> +    g_free(resp);
> +}
> +
> +static void
> +rutabaga_cmd_resource_create_blob(VirtIOGPU *g,
> +                                  struct virtio_gpu_ctrl_command *cmd)

I am not very clear about rutabaga gfx, and try to understand it a bit
more. So maybe my comments are not very exactly. We are working to enable
virtio-gpu support (venus right now, and next is virtio native context) for
Xen platform. Both of them need to use blob memory.

Originally, Antonio Caggiano implemented the virgl_cmd_resource_xxx_blob in
virtio-gpu-virgl.c. Could you have a way to re-use that kinds of functions
in your implemenation?

(+Dmitry)

Thanks,
Ray

> +{
> +    int result;
> +    struct rutabaga_iovecs vecs = { 0 };
> +    g_autofree struct virtio_gpu_simple_resource *res = NULL;
> +    struct virtio_gpu_resource_create_blob cblob;
> +    struct rutabaga_create_blob rc_blob = { 0 };
> +
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(cblob);
> +    trace_virtio_gpu_cmd_res_create_blob(cblob.resource_id, cblob.size);
> +
> +    CHECK(cblob.resource_id != 0, cmd);
> +
> +    res = g_new0(struct virtio_gpu_simple_resource, 1);
> +
> +    res->resource_id = cblob.resource_id;
> +    res->blob_size = cblob.size;
> +
> +    if (cblob.blob_mem != VIRTIO_GPU_BLOB_MEM_HOST3D) {
> +        result = virtio_gpu_create_mapping_iov(g, cblob.nr_entries,
> +                                               sizeof(cblob), cmd, &res->addrs,
> +                                               &res->iov, &res->iov_cnt);
> +        CHECK(!result, cmd);
> +    }
> +
> +    rc_blob.blob_id = cblob.blob_id;
> +    rc_blob.blob_mem = cblob.blob_mem;
> +    rc_blob.blob_flags = cblob.blob_flags;
> +    rc_blob.size = cblob.size;
> +
> +    vecs.iovecs = res->iov;
> +    vecs.num_iovecs = res->iov_cnt;
> +
> +    result = rutabaga_resource_create_blob(vr->rutabaga, cblob.hdr.ctx_id,
> +                                           cblob.resource_id, &rc_blob, &vecs,
> +                                           NULL);
> +    CHECK(!result, cmd);
> +
> +    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
> +    res = NULL;
> +}
> +
> +static void
> +rutabaga_cmd_resource_map_blob(VirtIOGPU *g,
> +                               struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    uint32_t map_info = 0;
> +    uint32_t slot = 0;
> +    struct virtio_gpu_simple_resource *res;
> +    struct rutabaga_mapping mapping = { 0 };
> +    struct virtio_gpu_resource_map_blob mblob;
> +    struct virtio_gpu_resp_map_info resp = { 0 };
> +
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(mblob);
> +
> +    CHECK(mblob.resource_id != 0, cmd);
> +
> +    res = virtio_gpu_find_resource(g, mblob.resource_id);
> +    CHECK(res, cmd);
> +
> +    result = rutabaga_resource_map_info(vr->rutabaga, mblob.resource_id,
> +                                        &map_info);
> +    CHECK(!result, cmd);
> +
> +    /*
> +     * RUTABAGA_MAP_ACCESS_* flags are not part of the virtio-gpu spec, but do
> +     * exist to potentially allow the hypervisor to restrict write access to
> +     * memory. QEMU does not need to use this functionality at the moment.
> +     */
> +    resp.map_info = map_info & RUTABAGA_MAP_CACHE_MASK;
> +
> +    result = rutabaga_resource_map(vr->rutabaga, mblob.resource_id, &mapping);
> +    CHECK(!result, cmd);
> +
> +    for (slot = 0; slot < MAX_SLOTS; slot++) {
> +        if (vr->memory_regions[slot].used) {
> +            continue;
> +        }
> +
> +        MemoryRegion *mr = &(vr->memory_regions[slot].mr);
> +        memory_region_init_ram_ptr(mr, NULL, "blob", mapping.size,
> +                                   (void *)mapping.ptr);
> +        memory_region_add_subregion(&g->parent_obj.hostmem,
> +                                    mblob.offset, mr);
> +        vr->memory_regions[slot].resource_id = mblob.resource_id;
> +        vr->memory_regions[slot].used = 1;
> +        break;
> +    }
> +
> +    if (slot >= MAX_SLOTS) {
> +        result = rutabaga_resource_unmap(vr->rutabaga, mblob.resource_id);
> +        CHECK(!result, cmd);
> +    }
> +
> +    CHECK(slot < MAX_SLOTS, cmd);
> +
> +    resp.hdr.type = VIRTIO_GPU_RESP_OK_MAP_INFO;
> +    virtio_gpu_ctrl_response(g, cmd, &resp.hdr, sizeof(resp));
> +}
> +
> +static void
> +rutabaga_cmd_resource_unmap_blob(VirtIOGPU *g,
> +                                 struct virtio_gpu_ctrl_command *cmd)
> +{
> +    int32_t result;
> +    uint32_t slot = 0;
> +    struct virtio_gpu_simple_resource *res;
> +    struct virtio_gpu_resource_unmap_blob ublob;
> +
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(ublob);
> +
> +    CHECK(ublob.resource_id != 0, cmd);
> +
> +    res = virtio_gpu_find_resource(g, ublob.resource_id);
> +    CHECK(res, cmd);
> +
> +    for (slot = 0; slot < MAX_SLOTS; slot++) {
> +        if (vr->memory_regions[slot].resource_id != ublob.resource_id) {
> +            continue;
> +        }
> +
> +        MemoryRegion *mr = &(vr->memory_regions[slot].mr);
> +        memory_region_del_subregion(&g->parent_obj.hostmem, mr);
> +
> +        vr->memory_regions[slot].resource_id = 0;
> +        vr->memory_regions[slot].used = 0;
> +        break;
> +    }
> +
> +    CHECK((slot < MAX_SLOTS), cmd);
> +    result = rutabaga_resource_unmap(vr->rutabaga, res->resource_id);
> +    CHECK(!result, cmd);
> +}
> +
> +static void
> +virtio_gpu_rutabaga_process_cmd(VirtIOGPU *g,
> +                                struct virtio_gpu_ctrl_command *cmd)
> +{
> +    struct rutabaga_fence fence = { 0 };
> +    int32_t result;
> +
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    VIRTIO_GPU_FILL_CMD(cmd->cmd_hdr);
> +
> +    switch (cmd->cmd_hdr.type) {
> +    case VIRTIO_GPU_CMD_CTX_CREATE:
> +        rutabaga_cmd_context_create(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_CTX_DESTROY:
> +        rutabaga_cmd_context_destroy(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_RESOURCE_CREATE_2D:
> +        rutabaga_cmd_create_resource_2d(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_RESOURCE_CREATE_3D:
> +        rutabaga_cmd_create_resource_3d(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_SUBMIT_3D:
> +        rutabaga_cmd_submit_3d(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D:
> +        rutabaga_cmd_transfer_to_host_2d(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_TRANSFER_TO_HOST_3D:
> +        rutabaga_cmd_transfer_to_host_3d(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_TRANSFER_FROM_HOST_3D:
> +        rutabaga_cmd_transfer_from_host_3d(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING:
> +        rutabaga_cmd_attach_backing(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING:
> +        rutabaga_cmd_detach_backing(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_SET_SCANOUT:
> +        rutabaga_cmd_set_scanout(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_RESOURCE_FLUSH:
> +        rutabaga_cmd_resource_flush(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_RESOURCE_UNREF:
> +        rutabaga_cmd_resource_unref(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_CTX_ATTACH_RESOURCE:
> +        rutabaga_cmd_ctx_attach_resource(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_CTX_DETACH_RESOURCE:
> +        rutabaga_cmd_ctx_detach_resource(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_GET_CAPSET_INFO:
> +        rutabaga_cmd_get_capset_info(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_GET_CAPSET:
> +        rutabaga_cmd_get_capset(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_GET_DISPLAY_INFO:
> +        virtio_gpu_get_display_info(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_GET_EDID:
> +        virtio_gpu_get_edid(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB:
> +        rutabaga_cmd_resource_create_blob(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB:
> +        rutabaga_cmd_resource_map_blob(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB:
> +        rutabaga_cmd_resource_unmap_blob(g, cmd);
> +        break;
> +    default:
> +        cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
> +        break;
> +    }
> +
> +    if (cmd->finished) {
> +        return;
> +    }
> +    if (cmd->error) {
> +        error_report("%s: ctrl 0x%x, error 0x%x", __func__,
> +                     cmd->cmd_hdr.type, cmd->error);
> +        virtio_gpu_ctrl_response_nodata(g, cmd, cmd->error);
> +        return;
> +    }
> +    if (!(cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_FENCE)) {
> +        virtio_gpu_ctrl_response_nodata(g, cmd, VIRTIO_GPU_RESP_OK_NODATA);
> +        return;
> +    }
> +
> +    fence.flags = cmd->cmd_hdr.flags;
> +    fence.ctx_id = cmd->cmd_hdr.ctx_id;
> +    fence.fence_id = cmd->cmd_hdr.fence_id;
> +    fence.ring_idx = cmd->cmd_hdr.ring_idx;
> +
> +    trace_virtio_gpu_fence_ctrl(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.type);
> +
> +    result = rutabaga_create_fence(vr->rutabaga, &fence);
> +    CHECK(!result, cmd);
> +}
> +
> +static void
> +virtio_gpu_rutabaga_aio_cb(void *opaque)
> +{
> +    struct rutabaga_aio_data *data = opaque;
> +    VirtIOGPU *g = VIRTIO_GPU(data->vr);
> +    struct rutabaga_fence fence_data = data->fence;
> +    struct virtio_gpu_ctrl_command *cmd, *tmp;
> +
> +    uint32_t signaled_ctx_specific = fence_data.flags &
> +                                     RUTABAGA_FLAG_INFO_RING_IDX;
> +
> +    QTAILQ_FOREACH_SAFE(cmd, &g->fenceq, next, tmp) {
> +        /*
> +         * Due to context specific timelines.
> +         */
> +        uint32_t target_ctx_specific = cmd->cmd_hdr.flags &
> +                                       RUTABAGA_FLAG_INFO_RING_IDX;
> +
> +        if (signaled_ctx_specific != target_ctx_specific) {
> +            continue;
> +        }
> +
> +        if (signaled_ctx_specific &&
> +           (cmd->cmd_hdr.ring_idx != fence_data.ring_idx)) {
> +            continue;
> +        }
> +
> +        if (cmd->cmd_hdr.fence_id > fence_data.fence_id) {
> +            continue;
> +        }
> +
> +        trace_virtio_gpu_fence_resp(cmd->cmd_hdr.fence_id);
> +        virtio_gpu_ctrl_response_nodata(g, cmd, VIRTIO_GPU_RESP_OK_NODATA);
> +        QTAILQ_REMOVE(&g->fenceq, cmd, next);
> +        g_free(cmd);
> +    }
> +
> +    g_free(data);
> +}
> +
> +static void
> +virtio_gpu_rutabaga_fence_cb(uint64_t user_data,
> +                             const struct rutabaga_fence *fence) {
> +    struct rutabaga_aio_data *data;
> +    VirtIOGPU *g = (VirtIOGPU *)user_data;
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    /*
> +     * gfxstream and both cross-domain (and even newer versions virglrenderer:
> +     * see VIRGL_RENDERER_ASYNC_FENCE_CB) like to signal fence completion on
> +     * threads ("callback threads") that are different from the thread that
> +     * processes the command queue ("main thread").
> +     *
> +     * crosvm and other virtio-gpu 1.1 implementations enable callback threads
> +     * via locking.  However, on QEMU a deadlock is observed if
> +     * virtio_gpu_ctrl_response_nodata(..) [used in the fence callback] is used
> +     * from a thread that is not the main thread.
> +     *
> +     * The reason is QEMU's internal locking is designed to work with QEMU
> +     * threads (see rcu_register_thread()) and not generic C/C++/Rust threads.
> +     * For now, we can workaround this by scheduling the return of the
> +     * fence descriptors on the main thread.
> +     */
> +
> +    data = g_new0(struct rutabaga_aio_data, 1);
> +    data->vr = vr;
> +    data->fence = *fence;
> +    aio_bh_schedule_oneshot_full(qemu_get_aio_context(),
> +                                 virtio_gpu_rutabaga_aio_cb,
> +                                 (void *)data, "aio");
> +}
> +
> +static void
> +virtio_gpu_rutabaga_debug_cb(uint64_t user_data,
> +                             const struct rutabaga_debug *debug) {
> +
> +    if (debug->debug_type == RUTABAGA_DEBUG_ERROR) {
> +        error_report("%s", debug->message);
> +    } else if (debug->debug_type == RUTABAGA_DEBUG_WARN) {
> +        warn_report("%s", debug->message);
> +    } else if (debug->debug_type == RUTABAGA_DEBUG_INFO) {
> +        info_report("%s", debug->message);
> +    }
> +}
> +
> +static int virtio_gpu_rutabaga_init(VirtIOGPU *g, Error **errp)
> +{
> +    int result;
> +    uint64_t capset_mask;
> +    struct rutabaga_builder builder = { 0 };
> +    char wayland_socket_path[UNIX_PATH_MAX];
> +    struct rutabaga_channel channel = { 0 };
> +    struct rutabaga_channels channels = { 0 };
> +
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +    vr->rutabaga = NULL;
> +
> +    if (!vr->capset_names) {
> +        error_setg(errp, "a capset name from the virtio-gpu spec is required");
> +        return -EINVAL;
> +    }
> +
> +    builder.wsi = RUTABAGA_WSI_SURFACELESS;
> +    /*
> +     * Currently, if WSI is specified, the only valid strings are "surfaceless"
> +     * or "headless".  Surfaceless doesn't create a native window surface, but
> +     * does copy from the render target to the Pixman buffer if a virtio-gpu
> +     * 2D hypercall is issued.  Surfacless is the default.
> +     *
> +     * Headless is like surfaceless, but doesn't copy to the Pixman buffer. The
> +     * use case is automated testing environments where there is no need to view
> +     * results.
> +     *
> +     * In the future, more performant virtio-gpu 2D UI integration may be added.
> +     */
> +    if (vr->wsi) {
> +        if (g_str_equal(vr->wsi, "surfaceless")) {
> +            vr->headless = false;
> +        } else if (g_str_equal(vr->wsi, "headless")) {
> +            vr->headless = true;
> +        } else {
> +            error_setg(errp, "invalid wsi option selected");
> +            return -EINVAL;
> +        }
> +    }
> +
> +    result = rutabaga_calculate_capset_mask(vr->capset_names, &capset_mask);
> +    if (result) {
> +        error_setg(errp, "invalid capset names: %s", vr->capset_names);
> +        return result;
> +    }
> +
> +    builder.fence_cb = virtio_gpu_rutabaga_fence_cb;
> +    builder.debug_cb = virtio_gpu_rutabaga_debug_cb;
> +    builder.capset_mask = capset_mask;
> +    builder.user_data = (uint64_t)g;
> +
> +    /*
> +     * If the user doesn't specify the wayland socket path, we try to infer
> +     * the socket via a process similar to the one used by libwayland.
> +     * libwayland does the following:
> +     *
> +     * 1) If $WAYLAND_DISPLAY is set, attempt to connect to
> +     *    $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY
> +     * 2) Otherwise, attempt to connect to $XDG_RUNTIME_DIR/wayland-0
> +     * 3) Otherwise, don't pass a wayland socket to rutabaga. If a guest
> +     *    wayland proxy is launched, it will fail to work.
> +     */
> +    channel.channel_type = RUTABAGA_CHANNEL_TYPE_WAYLAND;
> +    if (!vr->wayland_socket_path) {
> +        const char *runtime_dir = getenv("XDG_RUNTIME_DIR");
> +        const char *display = getenv("WAYLAND_DISPLAY");
> +        if (!display) {
> +            display = "wayland-0";
> +        }
> +
> +        if (runtime_dir) {
> +            int sprintf_result = snprintf(wayland_socket_path, UNIX_PATH_MAX,
> +                                          "%s/%s", runtime_dir, display);
> +            if (sprintf_result > 0 && sprintf_result < UNIX_PATH_MAX) {
> +                channel.channel_name = wayland_socket_path;
> +            }
> +        }
> +    } else {
> +        channel.channel_name = vr->wayland_socket_path;
> +    }
> +
> +    if ((builder.capset_mask & (1 << RUTABAGA_CAPSET_CROSS_DOMAIN))) {
> +        if (channel.channel_name) {
> +            channels.channels = &channel;
> +            channels.num_channels = 1;
> +            builder.channels = &channels;
> +        }
> +    }
> +
> +    result = rutabaga_init(&builder, &vr->rutabaga);
> +    return result;
> +}
> +
> +static int virtio_gpu_rutabaga_get_num_capsets(VirtIOGPU *g)
> +{
> +    int result;
> +    uint32_t num_capsets;
> +    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
> +
> +    result = rutabaga_get_num_capsets(vr->rutabaga, &num_capsets);
> +    if (result) {
> +        error_report("Failed to get capsets");
> +        return 0;
> +    }
> +    vr->num_capsets = num_capsets;
> +    return num_capsets;
> +}
> +
> +static void virtio_gpu_rutabaga_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
> +{
> +    VirtIOGPU *g = VIRTIO_GPU(vdev);
> +    struct virtio_gpu_ctrl_command *cmd;
> +
> +    if (!virtio_queue_ready(vq)) {
> +        return;
> +    }
> +
> +    cmd = virtqueue_pop(vq, sizeof(struct virtio_gpu_ctrl_command));
> +    while (cmd) {
> +        cmd->vq = vq;
> +        cmd->error = 0;
> +        cmd->finished = false;
> +        QTAILQ_INSERT_TAIL(&g->cmdq, cmd, next);
> +        cmd = virtqueue_pop(vq, sizeof(struct virtio_gpu_ctrl_command));
> +    }
> +
> +    virtio_gpu_process_cmdq(g);
> +}
> +
> +static void virtio_gpu_rutabaga_realize(DeviceState *qdev, Error **errp)
> +{
> +    int num_capsets;
> +    VirtIOGPUBase *bdev = VIRTIO_GPU_BASE(qdev);
> +    VirtIOGPU *gpudev = VIRTIO_GPU(qdev);
> +
> +#if HOST_BIG_ENDIAN
> +    error_setg(errp, "rutabaga is not supported on bigendian platforms");
> +    return;
> +#endif
> +
> +    int result = virtio_gpu_rutabaga_init(gpudev, errp);
> +    if (result) {
> +        error_setg(errp, "virtio_gpu_rutabaga_init failed");
> +        return;
> +    }
> +
> +    num_capsets = virtio_gpu_rutabaga_get_num_capsets(gpudev);
> +    if (!num_capsets) {
> +        return;
> +    }
> +
> +    bdev->conf.flags |= (1 << VIRTIO_GPU_FLAG_RUTABAGA_ENABLED);
> +    bdev->conf.flags |= (1 << VIRTIO_GPU_FLAG_BLOB_ENABLED);
> +    bdev->conf.flags |= (1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED);
> +
> +    bdev->virtio_config.num_capsets = num_capsets;
> +    virtio_gpu_device_realize(qdev, errp);
> +}
> +
> +static Property virtio_gpu_rutabaga_properties[] = {
> +    DEFINE_PROP_STRING("capset_names", VirtIOGPURutabaga, capset_names),
> +    DEFINE_PROP_STRING("wayland_socket_path", VirtIOGPURutabaga,
> +                       wayland_socket_path),
> +    DEFINE_PROP_STRING("wsi", VirtIOGPURutabaga, wsi),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void virtio_gpu_rutabaga_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
> +    VirtIOGPUBaseClass *vbc = VIRTIO_GPU_BASE_CLASS(klass);
> +    VirtIOGPUClass *vgc = VIRTIO_GPU_CLASS(klass);
> +
> +    vbc->gl_flushed = virtio_gpu_rutabaga_gl_flushed;
> +    vgc->handle_ctrl = virtio_gpu_rutabaga_handle_ctrl;
> +    vgc->process_cmd = virtio_gpu_rutabaga_process_cmd;
> +    vgc->update_cursor_data = virtio_gpu_rutabaga_update_cursor;
> +
> +    vdc->realize = virtio_gpu_rutabaga_realize;
> +    device_class_set_props(dc, virtio_gpu_rutabaga_properties);
> +}
> +
> +static const TypeInfo virtio_gpu_rutabaga_info = {
> +    .name = TYPE_VIRTIO_GPU_RUTABAGA,
> +    .parent = TYPE_VIRTIO_GPU,
> +    .instance_size = sizeof(VirtIOGPURutabaga),
> +    .class_init = virtio_gpu_rutabaga_class_init,
> +};
> +module_obj(TYPE_VIRTIO_GPU_RUTABAGA);
> +module_kconfig(VIRTIO_GPU);
> +
> +static void virtio_register_types(void)
> +{
> +    type_register_static(&virtio_gpu_rutabaga_info);
> +}
> +
> +type_init(virtio_register_types)
> +
> +module_dep("hw-display-virtio-gpu");
> diff --git a/hw/display/virtio-vga-rutabaga.c b/hw/display/virtio-vga-rutabaga.c
> new file mode 100644
> index 0000000000..2b2ffed8a6
> --- /dev/null
> +++ b/hw/display/virtio-vga-rutabaga.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "qemu/osdep.h"
> +#include "hw/pci/pci.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/virtio/virtio-gpu.h"
> +#include "hw/display/vga.h"
> +#include "qapi/error.h"
> +#include "qemu/module.h"
> +#include "virtio-vga.h"
> +#include "qom/object.h"
> +
> +#define TYPE_VIRTIO_VGA_RUTABAGA "virtio-vga-rutabaga"
> +
> +typedef struct VirtIOVGARutabaga VirtIOVGARutabaga;
> +DECLARE_INSTANCE_CHECKER(VirtIOVGARutabaga, VIRTIO_VGA_RUTABAGA,
> +                         TYPE_VIRTIO_VGA_RUTABAGA)
> +
> +struct VirtIOVGARutabaga {
> +    VirtIOVGABase parent_obj;
> +    VirtIOGPURutabaga vdev;
> +};
> +
> +static void virtio_vga_rutabaga_inst_initfn(Object *obj)
> +{
> +    VirtIOVGARutabaga *dev = VIRTIO_VGA_RUTABAGA(obj);
> +
> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> +                                TYPE_VIRTIO_GPU_RUTABAGA);
> +    VIRTIO_VGA_BASE(dev)->vgpu = VIRTIO_GPU_BASE(&dev->vdev);
> +}
> +
> +static VirtioPCIDeviceTypeInfo virtio_vga_rutabaga_info = {
> +    .generic_name  = TYPE_VIRTIO_VGA_RUTABAGA,
> +    .parent        = TYPE_VIRTIO_VGA_BASE,
> +    .instance_size = sizeof(VirtIOVGARutabaga),
> +    .instance_init = virtio_vga_rutabaga_inst_initfn,
> +};
> +module_obj(TYPE_VIRTIO_VGA_RUTABAGA);
> +module_kconfig(VIRTIO_VGA);
> +
> +static void virtio_vga_register_types(void)
> +{
> +    if (have_vga) {
> +        virtio_pci_types_register(&virtio_vga_rutabaga_info);
> +    }
> +}
> +
> +type_init(virtio_vga_register_types)
> +
> +module_dep("hw-display-virtio-vga");
> -- 
> 2.41.0.640.ga95def55d0-goog
> 
> 

