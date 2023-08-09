Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C473B7750DE
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 04:23:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTYqO-00062Z-KD; Tue, 08 Aug 2023 22:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ray.Huang@amd.com>) id 1qTYqM-00062L-Tj
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 22:22:39 -0400
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com
 ([40.107.236.41] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ray.Huang@amd.com>) id 1qTYqK-00038G-Eb
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 22:22:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+UbW+JvpNvW6yJkAAEhBrIu86niWFsGPjrkd++eXWo8rcpy5zmbphOK1oFNpuhE7STNBjsmKK7fFhd7oiDU/gCp5yXv4GFLroMgxwX+xmxln0HA66pPhKHgCn/gPjxzijhIwwbP9pAoForoy4qhvDYN+T23kjw4SnlMdQzA3x71jq957nXzBlxsrH0PdqVPPHwrvM1yy5YLoxab9qCr448Nx06GSfYN7zehKSXgyrgkJrMWvoa/BZXWNBpxCCvBFLaY7skNvE2jLjAw8Zl51/P73QNaqe32fl9UafICbw8aR301aenVkHk4Fi1LuVqkSy0/X4KtVSkOHgJiIkjTzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2lKXJVS4+gjLYWF69n5rmPtICr10k/rKa5i3I8KUyA=;
 b=MdgvNwasgBqQI+gFaM6VNy5ZFjuIzXG5mSJnLHtjyhSXdh9LPt4omw/XMBQ/pHNklFLGR6an67yVlbyNdQIFc7jP6sIcAaIHUZib4fhYLCJGJjbdR89Z0S5jjoSGmmSAqepJzHo8wuHCmks+ayMB81ds19vNi7KysOiqdisz8vQuL+dSWWx/NBnf0R1psDn5o9+RYPAvAxzinplAj6NOr3PtgqQtAuFmeQ6Y61hQhcJQb/XFDsxPcb32OiNhs3LmsuFoRuLhULSpPhSm1789nCnT+EkO/AZRbW/XDi1iZuUnCD/CDSygCeqeMat+rZOB4MEd4bI0X2B50yUC9pwKGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2lKXJVS4+gjLYWF69n5rmPtICr10k/rKa5i3I8KUyA=;
 b=jbURgKreyInwkk2Gw+SdhKKxQU7PxEKpgPWbPWqA/dckFEKCS8phlSIjSy/p5RZj9zNgRzg5J51KncrPB+Fg8i6NbFXc8XrCgcsI9HCMn5lFYpmR6EIrkBMsxDun4dOb+PZ7OGaY63vamMwWQpelWixqpSQ0TAFw/zxhCDUk9j0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by MW4PR12MB7031.namprd12.prod.outlook.com (2603:10b6:303:1ef::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 02:17:29 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::da13:5f6:45:fa40]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::da13:5f6:45:fa40%4]) with mapi id 15.20.6652.025; Wed, 9 Aug 2023
 02:17:29 +0000
Date: Wed, 9 Aug 2023 10:17:06 +0800
From: Huang Rui <ray.huang@amd.com>
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: Erico Nunes <ernunes@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "akihiko.odaki@gmail.com" <akihiko.odaki@gmail.com>,
 "dmitry.osipenko@collabora.com" <dmitry.osipenko@collabora.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "shentey@gmail.com" <shentey@gmail.com>, "hi@alyssa.is" <hi@alyssa.is>
Subject: Re: [PATCH v3 0/9] gfxstream + rutabaga_gfx
Message-ID: <ZNL3Ij4zC8KANLqJ@amd.com>
References: <20230803235502.373-1-gurchetansingh@google.com>
 <b9dc2c50-00cf-12ae-d1c9-cb31d089a24d@redhat.com>
 <CAAfnVB=wVMy9zUF+-MYZpH=j3cv9-qHz9-4xOjkFhoour89asg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAfnVB=wVMy9zUF+-MYZpH=j3cv9-qHz9-4xOjkFhoour89asg@mail.gmail.com>
X-ClientProxiedBy: SI1PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::13) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|MW4PR12MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c86b35-3a51-48e0-0dc3-08db987ec7c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nTzENYkjFiftjVdHN2YbGsW/dVUKkCjWpA/XWho5PcIA7wQEZuQkn+Rb8837yBOBsxt9MmlrWqprorAn5irtJKm4NMJRZx3suqIdbHRZ7YhHpcS5Fpr+jxMIMtN5pznCDxA9iCsjkRJoO27NLjfSX/zu2Y/BRAlIoBdkbssvcwJUGdv+l33skByLMQslWhaPyGw3DnQplEdH5ZF5s4sjw4zBo9se9zHjFSIhazqVkcRb83acPjPRx7u+sVqE4MjIoytnb7tN8jNZ1pP2qKZiJ2A9pHthGb/8R1Xs9ChctbCU04AS4nDtx9TwPg6mc2SB2vPA8IvcHJUPYjCoFrhmOrrs9BI1uS0p4v5QaEfxhbrkc2dw1N12WSmgsRgsarCgcCjP8ssKoThk/KMWl4yh0Exb2FiKYh1nWEBNPcpdWK36m22zBZOOwhYapHfxjPCe/U4+7hd16Y9UiXwpxF9jlxcPm939zAh1gGiG332t+dtI8pw6NHoHqUDKUwL0SVZfP5hEvrfWVz1OwdwV+8kOzy9oOhcYHaGyUMO1MFWRt2E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8690.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(39860400002)(396003)(136003)(376002)(346002)(1800799006)(186006)(451199021)(83380400001)(316002)(66556008)(6916009)(66476007)(6506007)(53546011)(4326008)(66946007)(41300700001)(38100700002)(5660300002)(6666004)(26005)(8676002)(8936002)(7416002)(6486002)(966005)(6512007)(54906003)(478600001)(86362001)(2616005)(36756003)(2906002)(66899021);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXVFUlRqTEM2SXBKVHVsTXc0OGtKTnJjRjhmSUoxa24rTzBJU3czZ3g3Vzg2?=
 =?utf-8?B?SHQ5Q2pkaHQzMm5iVWxwUVpONUk0TnY5SWJZTFlDV3JzdkVUcTZuZm8vcE9u?=
 =?utf-8?B?RVVsUUI5d05MeE5IZ3YzTmpvUFg4RnFqaktPd1pBVnliS0hJS1hkb3o5S0lU?=
 =?utf-8?B?ODRUaUVSY0gwVmpUeUI5dEZNeWszRndLNS9neGloaFpoaTUyV2hOM2FEWW9v?=
 =?utf-8?B?cHkyZXo3U2loNmRoaUl3MGozdzBCbnQ1VEd5U2RxMFdnVVJLWXdydHUrWlRs?=
 =?utf-8?B?cDNYamxIaXRrbkdGSFJnUG5lbFVqbXphZHlPNjZnWlBMRjNqTCsxS3RpZFlF?=
 =?utf-8?B?L1hodjBLN2h5ZHdQMmRNb0xFRGJhaXlyTWFWOTFvYVVuem5WUWRsMFQ1UERG?=
 =?utf-8?B?bzYrYkRPc1NvVldQMElzT25KTUF6RlJYU3piWEtyZEk3TGFUVFhSVUZ5NDhD?=
 =?utf-8?B?NGR4YmFwNmd1dDB3eDFwU0hyQUxOM3ZVSS8wcnlEMnExdExTUHQ4UzQ4dUJT?=
 =?utf-8?B?VUxuV2xVMUs4MW5xeUV3MFhOSXlZb1NkVUM5bGRjY2JwNkEvbzZGMmc0c1dy?=
 =?utf-8?B?Y1drVXZJNTEvWXBqb1ZwK2pxbkF3Y0VsbGI5bTdwQ2RSRTJ1cWYrc2NYdEI2?=
 =?utf-8?B?QWs2dGdNYWxlU05EU2liVVU3aVZOc0tzd2R4bFM4QWNCWU93eXhpSXBXdkkz?=
 =?utf-8?B?dGI2Wklya3YvK2Uvb1BEWU5POFJOWUg3ZXNqdm0vRUZ3cnVGT2Z3UGxReWFV?=
 =?utf-8?B?M3VvU2E4UEhMcTFqYnplcmtWcTBaRVpJM0EvVnZGNTBRdDlYeFBkZWZNU3ZP?=
 =?utf-8?B?UFIwanZGL0U3bXVtK3o5ZkxNSWRGTGlGcURpQlBaZCtEY0pLRkJ4N3YvZm5S?=
 =?utf-8?B?Q1pNMnNIRnoweGZIRFUxSkFzaTBxVkJhenMySVVsMlZsVEZMc2lDQTNrc0Nn?=
 =?utf-8?B?QWxwSFQ1ZjBJazlPcnkwWXlIVHZ1VUVBbWdMR0lYTXZOVmJvYVU5NFN3bm5h?=
 =?utf-8?B?MFRUSUQ2RzU4dU1tRGFab1hRd1VvbWptQjBwU3FrZVU4d05STGF3SktKRFBB?=
 =?utf-8?B?MlBDYnZpS1plNzRvUEVMWkUxcXRYL3JpRHRMSlZoejFTUGc4L212KzNHaFZQ?=
 =?utf-8?B?dHpxT05scm1JMTFhT1RpSWpxR296WjBaN2xPUXR3TXR0VFl2d1NockdDUjhj?=
 =?utf-8?B?WDJEVEYrSU5mcjR1bzJKVWdHbUwxZ0tXejBqK0lTRjNPZjlRaXljNHU3MGww?=
 =?utf-8?B?cEhrVWwzTkluTnFaMkxnQnBnenozdHF2eThxSUlHUW5SQS9yU0srQlRpc2py?=
 =?utf-8?B?djVvUUR0d3dXTlpXVjdxZEl3ZFp0LzN0ZHBaV3dhK2ttVERVN2RQZ1Z5L2Rn?=
 =?utf-8?B?WkpMdFpDeVhPTHozZ2pTY0hUYnBPdkloVkpoZ01XZWNLS3RRcm5FY1FsRW5z?=
 =?utf-8?B?bFpVVzUvbUJIOThEZzBBUjVIV0FubTZyNkJZSGNQSzdsWnppSWdXNGtZNStD?=
 =?utf-8?B?UXFSSlk4UytjZ0QvTXIvaTUyMk9ZaDdUV25Hd05Sdmh3ckczRG5mYmNXMnBw?=
 =?utf-8?B?Y2dtWlpGaU1QWGxNTUpDV005V1dxYk9ybmNoOFFYbUt3R2VRenYvN2l6V1Rr?=
 =?utf-8?B?VXZhY3JmSUk4d2prc3VSQmNiUkFvM0ZOOU9yNUtnc0dKSU9xS045S1JNYWFr?=
 =?utf-8?B?K2RLNVdCNEFpY1JNSFJQVDM0bWVoOW1BVUVSOUg4M2p4cXk3V0VXbFMwUE1J?=
 =?utf-8?B?VzdHOUlmOE5aT0pnVWo4cjAzcGIwQ3JmSFg4TVA5Q2htOXRmZXR2WWt4Wmxm?=
 =?utf-8?B?RWNQOThoaCtCRm1nQ1F3OThwZVAyd0FvbWNPVEE0YktoTDhLT0JmWGlRSEpx?=
 =?utf-8?B?dnVwVzRtRVVxTTlEZEV3cVdCL3pUS3BRdjhZUXVNdnF1bmFFbDRLbjYwVU4z?=
 =?utf-8?B?Q3k3MTFBaVBhU3FYbmk3MmZlRTNoRXhyRFdWRmpJWWFHS0VHMHhpZE9YdUQr?=
 =?utf-8?B?TGZySFlmT2RRUjZoL1VUWEY5aDhHbVZ3WktZWFI4MDZ4MkxtdEFTZ2d3S0RW?=
 =?utf-8?B?RjY5L2hXQ0lFSUpCMmpObkdjTEpDb04rdHF1RjVtdnB6MmR3WEdBYkJQeWND?=
 =?utf-8?Q?D08FTFsCHHHyfeOzZFrEfiHLo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c86b35-3a51-48e0-0dc3-08db987ec7c2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 02:17:28.8723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q4y94byYoPnAQ3bhIeH2j0fXFQqVQfK4r38k3M8FS2lD0AA8idnxEVqfDn1IjNo3QcYzu1//2nu/KuOEKQrTyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7031
Received-SPF: softfail client-ip=40.107.236.41; envelope-from=Ray.Huang@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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

On Wed, Aug 09, 2023 at 09:50:29AM +0800, Gurchetan Singh wrote:
>    On Mon, Aug 7, 2023 at 7:24 AM Erico Nunes <[1]ernunes@redhat.com>
>    wrote:
> 
>      Hello,
>      On 04/08/2023 01:54, Gurchetan Singh wrote:
>      > Prior versions:
>      >
>      >
>      [2]https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg05801.ht
>      ml
>      >
>      >
>      [3]https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg02341.ht
>      ml
>      >
>      >
>      [4]https://patchew.org/QEMU/20230421011223.718-1-gurchetansingh@chro
>      mium.org/
>      >
>      > Changes since v2:
>      > - Incorporated review feedback
>      >
>      > How to build both rutabaga and gfxstream guest/host libs:
>      >
>      > [5]https://crosvm.dev/book/appendix/rutabaga_gfx.html
>      >
>      > Branch containing this patch series:
>      >
>      >
>      [6]https://gitlab.freedesktop.org/gurchetansingh/qemu-gfxstream/-/co
>      mmits/qemu-gfxstream-v3
>      I tried this on Fedora with a Fedora guest and I was able to get
>      Vulkan
>      headless applications as well as Wayland proxy with sommelier to
>      work.
>      If you don't mind, I have a few questions.
>      I was not able to run Vulkan applications over the Wayland proxy,
>      only
>      unaccelerated apps. This seems to be unsupported yet; is actually
>      unsupported for now or was something missing in my setup?
> 
>    Yes, currently this is unsupported.  In the near future, I do imagine
>    3D accelerated rendering over cross-domain to be a thing (among many
>    context types, not just gfxstream VK).
>    Re: using gfxstream VK in Linux distros, depends on your use case.  If
>    you are looking for best performance over virtio on open-source Linux
>    platforms, perhaps gfxstream Vulkan (or any API virtualization
>    solution) is not your best bet.  The Mesa native context work looks
>    particularly exciting there:
>    [7]https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/21658

In fact, we will introduce both venus and virtio native context next step
with qemu. :-)

I am cleanning up the codes will send out the qemu very soon.

Thanks,
Ray

>    We are interested in running gfxstream VK in Linux guests, but we
>    envisage that for reference and testing.  For all embedded use cases,
>    using the host driver in the guest will predominate due to performance
>    considerations (either through virtio or HW direct / mediated
>    passthru).
> 
>      Also apparently GL/GLES is only supported on Android right now as
>      you
>      mentioned, since on Linux the gfxstream guest only installs the
>      Vulkan
>      library and icd. What is the plan to support GL on Linux; provide
>      gfxstream GL guest libraries later or enable Zink or some other
>      solution?
>      Then if I understand correctly, Mesa virgl is not used at all with
>      the
>      gfxstream solution, so I guess we would need to find a way to ship
>      the
>      gfxstream guest libraries too on distributions?
> 
> 
> 
>      Also I wonder about including all of the the dependencies required
>      to
>      get this to build on distributions as well to enable the feature on
>      distribution-provided qemu, but I guess we can figure this out
>      later...
>      And finally out of curiosity, I see that rutabaga also has a
>      virgl_renderer (and virgl_renderer_next) backend which would then
>      not
>      use gfxstream but virglrenderer instead. I wonder if there would be
>      any
>      benefit/features in enabling that with qemu later compared to the
>      current qemu virtio/virglrenderer implementation (if that would make
>      sense at all)?
> 
>    Yeah, maybe later if there's developer interest,  rutabaga FFI can
>    build its virglrenderer bindings in a subsequent release.  So far I
>    don't have time to test, and the most important use case is gfxstream +
>    Android for Emulator.  As ever, patches are welcome.
> 
>      Thanks
>      Erico
> 
> References
> 
>    1. mailto:ernunes@redhat.com
>    2. https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg05801.html
>    3. https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg02341.html
>    4. https://patchew.org/QEMU/20230421011223.718-1-gurchetansingh@chromium.org/
>    5. https://crosvm.dev/book/appendix/rutabaga_gfx.html
>    6. https://gitlab.freedesktop.org/gurchetansingh/qemu-gfxstream/-/commits/qemu-gfxstream-v3
>    7. https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/21658

