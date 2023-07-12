Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5A1751110
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 21:17:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJfKL-0005nI-AR; Wed, 12 Jul 2023 15:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1qJfKJ-0005ml-Do
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 15:16:39 -0400
Received: from mail-dm6nam12on2072.outbound.protection.outlook.com
 ([40.107.243.72] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1qJfKG-0001wV-Lf
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 15:16:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHm0PY3F99ueT5IuBiU0AE1r1ZgLjfz++Xoh8fAB6p4UZn4wH+uNZ2cQmbEsd93svrDqq+sdUelz0VJbzT7IAndzEtMp/WsVyCpA3kxzrD1LAyKjaic2br+ymFYzU0eMFKzfJfaYJZ3AIODlNbZLKZcgAxEIhtBcNlvDecc+Bx8h/tf08HM3wF/MEvAcqm1uVgyGb3HJOJFNlewj7TcF++G2QLcQLZeuYeBe/7TN8Y3Ry/zc4orlbUscIvZDbp5sPQ6gyIjv+8iLCGlkGrMEAlh5xcxof5Ehi4EMxdCzBcI8MK1R4w7lanGFhu8pfX9X8YxHGVHJG9GSWquXTuc2Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpoczJ3dkeawaS4Ss+FBIsjgYdJw0EhPqdIPUfsfXaw=;
 b=kymZxTl1B8VRtsClumjndKs43UMDxrjmb5DHEPvWPgHy5cZzg5X3qW0LH34mZYuZopjLCz8XhmWQeGUClitA9a2smkiAUr9PKgerIIWTOzmmbkFzOp7ny/NIowzBmgfPMKh8HOSOGbpQhtctsNvvOWnxJ8scblcsYlDsD7jHykl0C+4G0P6tRwLB9WXpiGbeZtZUZedk9FIjZnEnPBqJJW7979ECCCX4nfATgdsx6MJ/UckV+tIZ5UhFuIW/HG0/e5VLl/Qsj6KK+8ln6etV705AoB9qXOZQtBh2kzawd/5LCKGxlZAXg5RsEnhaS4Ot5iX2Tyrd3qRqm7kbu6wD1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpoczJ3dkeawaS4Ss+FBIsjgYdJw0EhPqdIPUfsfXaw=;
 b=nwrhqNsft9yQ4UKAHBOQ9/qMJkhmCnkf8F6SP94ihI3wU/mVO3t7KS4QQBElZsTlGckBUaG5uX9R8NikUW74Y+ynT+zoKFrkPC23GnHhfuLrPaQU8ZhJ6s70++Xn8+5HCLO97vDrvemeN280s90u5/kHGXPN5kPN6tUPrD+HZRk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 by PH8PR12MB6699.namprd12.prod.outlook.com (2603:10b6:510:1ce::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 12 Jul
 2023 19:11:30 +0000
Received: from BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::2a84:66f8:d8ae:76d9]) by BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::2a84:66f8:d8ae:76d9%6]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 19:11:30 +0000
Date: Wed, 12 Jul 2023 14:11:18 -0500
From: John Allen <john.allen@amd.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, yazen.ghannam@amd.com, michael.roth@amd.com,
 babu.moger@amd.com, william.roche@oracle.com, joao.m.martins@oracle.com
Subject: Re: [PATCH 1/2] i386: Add support for SUCCOR feature
Message-ID: <ZK761jK1wB62T3xv@johallen-workstation>
References: <20230706194022.2485195-1-john.allen@amd.com>
 <20230706194022.2485195-2-john.allen@amd.com>
 <d4c1bb9b-8438-ed00-c79d-e8ad2a7e4eed@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4c1bb9b-8438-ed00-c79d-e8ad2a7e4eed@redhat.com>
X-ClientProxiedBy: YQBPR01CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::40)
 To BL1PR12MB5995.namprd12.prod.outlook.com
 (2603:10b6:208:39b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5995:EE_|PH8PR12MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: 85aaac52-acb3-4af1-4e34-08db830bcca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5+aWXdRuYBGzYyrJE0lmmab+5VwZ7SE5Y3sM+2BrRxDpXlHlc17fteqVLBMT6uuYoxM0lyiyVuOuXj+Dd8Xh7O5TdSW2GYQyqR3rQQjw2LrWhe3S/8dsFDHg+J/cqM+2ho0AFVpOm3eWMXKstGSJ1SniTKz5iBNKWjplFADOMVu7tSAPyxBOEcG9Y3PMZV+NMqbt5AnfS9ZRHhHDrQG+8CWw55BcB8hCz2tm3dOB2vqu1c4ayCjO7fT3VqsJiNSoMLNDVW49vkxoCH73mvvjRuzhe37WFdNHxOjwWZ2pd/gu+JXXTJy2aUr9VzMYfPjkAZ4MS/soXEZFVLLRPool7ld1O0YuXuW7BhYKqhuQwq2xVDVG9brcKYrD4UkDghNuUQ4UxGlPqipaBIT6JoWRyGJZEsT5vgYgQaTxrW1eT5Ws+3hRd1eapq6rBZkQ+vTnkLmCWeKBCZv7139dtU5zKQRz+pobxolIckyN3AQeTaJXnF8r5OaBPj9gsb7T6mBfkE3ISGAcOgC3lbXtkq2TWTEWKcbljphSg3nm8XWFP9akqiv1nJvkCn0z3UkoEtSk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5995.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(7916004)(366004)(376002)(39860400002)(396003)(136003)(346002)(84040400005)(451199021)(186003)(2906002)(5660300002)(26005)(44832011)(6506007)(53546011)(9686003)(83380400001)(6666004)(478600001)(66476007)(41300700001)(8676002)(8936002)(6512007)(316002)(66946007)(4326008)(6486002)(66556008)(6916009)(33716001)(86362001)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VYNg5bqoxVE/4GyBeI/tRZeMtaMFSfLaRw9OlmeQ4LQkSbN7ZPND2Mx92mJW?=
 =?us-ascii?Q?GP6GHyqPzNtbEiRLCSePrnOus6Z1JPeYJ6zXPeAG/d7/Oj35lytpIzGaePFS?=
 =?us-ascii?Q?GXdleTXizjhwrdIOgEeegKhFoGLfjSa/FKXnOdg6v+8PPVN3E9fPocyJEm3O?=
 =?us-ascii?Q?MEPqMKFe4gr6dJrKbZnSj1xxoDoQEPTgiz3ZKb1Zf/xGifPvfLprYkVyNNsH?=
 =?us-ascii?Q?6aZS82OLxxg3d0fzpo9Md5j3adN4dVL3swvNPC4AV68p0QHKnzKjya9peQas?=
 =?us-ascii?Q?LwIAV2abohojV3gheO7SMHaZryGJXQwG0emQ5iFKvDel02FGOghu5P/w41qB?=
 =?us-ascii?Q?RR0W0/ZWlYYWSjkZJgvNm7jVmF73Ztdx07IhkP3qTkiZn8/jGGjD9fo4nL+T?=
 =?us-ascii?Q?+3SyooxJMOQRF/APmWiwlUjnlCF6diEDZqQn3wN/fzcjX6J1VK2Q08CaVsSC?=
 =?us-ascii?Q?YhKXA/YIgj59GduFzNDYYcSxb/91DS4Nqz6toDiJtu5n/8tV1E3jfeddiX1A?=
 =?us-ascii?Q?j//PghKkxTeBMVmhrSRjye6GBI/azU6ttbed8fpewusbNgFFOTDQC20GMPXc?=
 =?us-ascii?Q?4ontEqpu5YCUi9vc9BMeAM1Ihi1fPyzyLMxv3EcO1GhPWZQd8fEo58M1nn5o?=
 =?us-ascii?Q?uqIjvhmaMzWrKrb+E5EfnofCtg8voyBhsws/MgOZsDfIAPu+ZqmDT5/25qKv?=
 =?us-ascii?Q?5YaDW0c919mYJt6RdCjqi3Z1UzvSNL2Qumn5cru4ys5dh7ltPyFLbiGMRZo4?=
 =?us-ascii?Q?GdRNGYjUuLi2Br4Fz6L0h1KzxFOEoQSCOL8V9Nw7BNRyBkPsgYO3ukgZSBSJ?=
 =?us-ascii?Q?HAoll0HKPXPDhErfvRcPS6ExKuELaMFBr8TbdTQIwVthrIj8Q4F8JNaSJ6ZT?=
 =?us-ascii?Q?HiAGG8AHA0B/r00ez9E6aQ2NM8xGwN3iCCKL6GnLkFz8CGsXH6uKgB1/keAY?=
 =?us-ascii?Q?Ey3QHg4LBlE8RZ4vxspdgKOoGELIlGG3DZons3CF30h0s+Lb7tJreM0oPAXT?=
 =?us-ascii?Q?1X4qrAtmebHONZOLaQeG9TM8At/P8dbokU2Ebd434BUaR4VKzc3pttGGKW91?=
 =?us-ascii?Q?ZxxE1aGm71Innut/DuhnrkoJYNRL7LeK1elC2Ev2BnJcUZddLQp7RDs5nqbH?=
 =?us-ascii?Q?/VUtzv/JMlvsaXY9dvkGF0sLrtxqgx8pr9jfhYFnMGdbFoNYLyMsau3Ucb7j?=
 =?us-ascii?Q?mDGVCshgcQjvQbIc09M92QMUs0y6DIrkW1nootvIyYTYn8UW+X+wiVugbmFt?=
 =?us-ascii?Q?U2UwfP0nEtCO+sEDukU5GGiN+8RV+KxYZ5zNOgBhyXLpvuhnuBxj0+1dONRy?=
 =?us-ascii?Q?0UwNhaSFOX1vrb58jZqZ4OQxzrvcNoEHNTC7ruGwLpoLCy9Kt+NjxTwk8swH?=
 =?us-ascii?Q?JebJCTB2mfq+KOXFo0g2ikptocMluIx6NxqSZe527iaVv4P1CdJp+XwL1mb2?=
 =?us-ascii?Q?NFFtLOhpoc0TPraoaaTnQKGKJGrzkF5QUDgH8YGvPYe8AsjahPTK//kR5N3D?=
 =?us-ascii?Q?WCwK9lBKABs5gcLu9lejHZCwoG9sByqgrX6DDT3TEfkkGIMWwRpFTq1LO21/?=
 =?us-ascii?Q?vRew5X1HWTX5tsM7pzO+diB9aObYaTjdO7kw9R6u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85aaac52-acb3-4af1-4e34-08db830bcca3
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5995.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 19:11:30.6064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uS3+/yLiP9hcSnZ8fdUoTVZOFuZ7xXWVhaxQY7xqaV4AdTmArPJ7erEB/8b6/NbM9djunQg0T6cAjo0ShaDJtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6699
Received-SPF: softfail client-ip=40.107.243.72;
 envelope-from=John.Allen@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, Jul 07, 2023 at 04:25:22PM +0200, Paolo Bonzini wrote:
> On 7/6/23 21:40, John Allen wrote:
> >       case 0x80000007:
> >           *eax = 0;
> > -        *ebx = 0;
> > +        *ebx = env->features[FEAT_8000_0007_EBX] | CPUID_8000_0007_EBX_SUCCOR;
> >           *ecx = 0;
> >           *edx = env->features[FEAT_8000_0007_EDX];
> >           break;
> 
> I agree that it needs no hypervisor support, but Babu is right that you
> cannot add it unconditionally (especially not on Intel processors).
> 
> You can special case CPUID_8000_0007_EBX_SUCCOR in
> kvm_arch_get_supported_cpuid() so that it is added even on old kernels.
> There are already several such cases.  Adding it to KVM is nice to have
> anyway, so please send a patch for that.

By adding it to KVM do you mean adding a patch to the kernel to expose
the cpuid bit? Or do you mean just adding the special case to
kvm_arch_get_supported_cpuid?

For the kvm_arch_get_supported_cpuid case, I don't understand how this
would be different from unconditionally exposing the bit as done above.
Can you help me understand what you have in mind for this?

I might add a case like below:
...
    } else if (function == 0x80000007 && reg == R_EBX) {
        ret |= CPUID_8000_0007_EBX_SUCCOR;
...

If we wanted to only expose the bit for AMD cpus, we would then need to
call IS_AMD_CPU with the CPUX86State as a paramter which would mean that
kvm_arch_get_supported_cpuid and all of its callers would need to take
the CPUX86State as a parameter. Is there another way to differentiate
between AMD and Intel cpus in this case?

> 
> Also, the patch does not compile (probably you missed a prerequisite) as it
> lacks all the rigamarole that is needed to add FEAT_8000_0007_EBX.

I'm not encountering any compilation issues. What are the errors that
you are seeing?

Thanks,
John

