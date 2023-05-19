Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F78770A08B
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 22:25:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q06dQ-0004TS-GF; Fri, 19 May 2023 16:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=496baf2b8=nsaenz@amazon.es>)
 id 1q03y3-0008IC-MK
 for qemu-devel@nongnu.org; Fri, 19 May 2023 13:32:40 -0400
Received: from smtp-fw-80009.amazon.com ([99.78.197.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=496baf2b8=nsaenz@amazon.es>)
 id 1q03y0-00026j-N5
 for qemu-devel@nongnu.org; Fri, 19 May 2023 13:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1684517556; x=1716053556;
 h=mime-version:content-transfer-encoding:date:cc:subject:
 from:to:message-id:references:in-reply-to;
 bh=CDpNYbYopL6l908P9YpiX0NY2dAoYXZOF2ciVkFIcHY=;
 b=fF1DoSCPofabPLW1OUwZgw9vrNlg3fiYK09cbE1KxCF4UqjtJ5hJGA5a
 Iqrkz78EBs+gPFl/Nhq8PycV3qJpMNeTvCEa17VIvaIkO21pOSuUVUpcM
 Mfqd+xuaMQM8bp8iXImf46ATV1DHwIJ0m//uwkzn/usPiB3pGUPqsCNgo 8=;
X-IronPort-AV: E=Sophos;i="6.00,177,1681171200"; 
   d="scan'208";a="4343439"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO
 email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com)
 ([10.25.36.214]) by smtp-border-fw-80009.pdx80.corp.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 17:32:31 +0000
Received: from EX19D004EUC001.ant.amazon.com
 (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
 by email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com (Postfix)
 with ESMTPS id 9037C40D80; Fri, 19 May 2023 17:32:28 +0000 (UTC)
Received: from localhost (10.13.235.138) by EX19D004EUC001.ant.amazon.com
 (10.252.51.190) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 19 May
 2023 17:32:14 +0000
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 19 May 2023 17:32:10 +0000
CC: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>,
 Jim Mattson <jmattson@google.com>, "Joerg Roedel" <joro@8bytes.org>, Thomas
 Gleixner <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, "Arnd Bergmann" <arnd@arndb.de>, Naoya Horiguchi
 <naoya.horiguchi@nec.com>, Miaohe Lin <linmiaohe@huawei.com>,
 <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins
 <hughd@google.com>, Jeff Layton <jlayton@kernel.org>, "J . Bruce Fields"
 <bfields@fieldses.org>, "Andrew Morton" <akpm@linux-foundation.org>, Shuah
 Khan <shuah@kernel.org>, "Mike Rapoport" <rppt@kernel.org>, Steven Price
 <steven.price@arm.com>, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Vlastimil Babka <vbabka@suse.cz>, Vishal Annapurve <vannapurve@google.com>,
 Yu Zhang <yu.c.zhang@linux.intel.com>, "Kirill A . Shutemov"
 <kirill.shutemov@linux.intel.com>, <luto@kernel.org>,
 <jun.nakajima@intel.com>, <dave.hansen@intel.com>, <ak@linux.intel.com>,
 <david@redhat.com>, <aarcange@redhat.com>, <ddutile@redhat.com>,
 <dhildenb@redhat.com>, Quentin Perret <qperret@google.com>,
 <tabba@google.com>, Michael Roth <michael.roth@amd.com>, <mhocko@suse.com>,
 <wei.w.wang@intel.com>, <anelkz@amazon.de>
Subject: Re: [PATCH v10 2/9] KVM: Introduce per-page memory attributes
From: Nicolas Saenz Julienne <nsaenz@amazon.com>
To: Chao Peng <chao.p.peng@linux.intel.com>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
 <linux-api@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <qemu-devel@nongnu.org>, <graf@amazon.com>, <seanjc@google.com>
Message-ID: <CSQFE7I30W27.2TPDIHOTZNRIZ@dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com>
X-Mailer: aerc 0.15.2-21-g30c1a30168df-dirty
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-3-chao.p.peng@linux.intel.com>
In-Reply-To: <20221202061347.1070246-3-chao.p.peng@linux.intel.com>
X-Originating-IP: [10.13.235.138]
X-ClientProxiedBy: EX19D037UWB001.ant.amazon.com (10.13.138.123) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)
Precedence: Bulk
Received-SPF: pass client-ip=99.78.197.220;
 envelope-from=prvs=496baf2b8=nsaenz@amazon.es; helo=smtp-fw-80009.amazon.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 19 May 2023 16:23:30 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Hi,

On Fri Dec 2, 2022 at 6:13 AM UTC, Chao Peng wrote:

[...]

> +4.138 KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES
> +-----------------------------------------
> +
> +:Capability: KVM_CAP_MEMORY_ATTRIBUTES
> +:Architectures: x86
> +:Type: vm ioctl
> +:Parameters: u64 memory attributes bitmask(out)
> +:Returns: 0 on success, <0 on error
> +
> +Returns supported memory attributes bitmask. Supported memory attributes=
 will
> +have the corresponding bits set in u64 memory attributes bitmask.
> +
> +The following memory attributes are defined::
> +
> +  #define KVM_MEMORY_ATTRIBUTE_READ              (1ULL << 0)
> +  #define KVM_MEMORY_ATTRIBUTE_WRITE             (1ULL << 1)
> +  #define KVM_MEMORY_ATTRIBUTE_EXECUTE           (1ULL << 2)
> +  #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
> +
> +4.139 KVM_SET_MEMORY_ATTRIBUTES
> +-----------------------------------------
> +
> +:Capability: KVM_CAP_MEMORY_ATTRIBUTES
> +:Architectures: x86
> +:Type: vm ioctl
> +:Parameters: struct kvm_memory_attributes(in/out)
> +:Returns: 0 on success, <0 on error
> +
> +Sets memory attributes for pages in a guest memory range. Parameters are
> +specified via the following structure::
> +
> +  struct kvm_memory_attributes {
> +	__u64 address;
> +	__u64 size;
> +	__u64 attributes;
> +	__u64 flags;
> +  };
> +
> +The user sets the per-page memory attributes to a guest memory range ind=
icated
> +by address/size, and in return KVM adjusts address and size to reflect t=
he
> +actual pages of the memory range have been successfully set to the attri=
butes.
> +If the call returns 0, "address" is updated to the last successful addre=
ss + 1
> +and "size" is updated to the remaining address size that has not been se=
t
> +successfully. The user should check the return value as well as the size=
 to
> +decide if the operation succeeded for the whole range or not. The user m=
ay want
> +to retry the operation with the returned address/size if the previous ra=
nge was
> +partially successful.
> +
> +Both address and size should be page aligned and the supported attribute=
s can be
> +retrieved with KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES.
> +
> +The "flags" field may be used for future extensions and should be set to=
 0s.

We have been looking into adding support for the Hyper-V VSM extensions
which Windows uses to implement Credential Guard. This interface seems
like a good fit for one of its underlying features. I just wanted to
share a bit about it, and see if we can expand it to fit this use-case.
Note that this was already briefly discussed between Sean and Alex some
time ago[1].

VSM introduces isolated guest execution contexts called Virtual Trust
Levels (VTL) [2]. Each VTL has its own memory access protections,
virtual processors states, interrupt controllers and overlay pages. VTLs
are hierarchical and might enforce memory protections on less privileged
VTLs. Memory protections are enforced on a per-GPA granularity.

The list of possible protections is:
- No access -- This needs a new memory attribute, I think.
- Read-only, no execute
- Read-only, execute
- Read/write, no execute
- Read/write, execute

We implemented this in the past by using a separate address space per
VTL and updating memory regions on protection changes. But having to
update the memory slot layout for every permission change scales poorly,
especially as we have to perform 100.000s of these operations at boot
(see [1] for a little more context).

I believe the biggest barrier for us to use memory attributes is not
having the ability to target specific address spaces, or to the very
least having some mechanism to maintain multiple independent layers of
attributes.

Also sorry for not posting our VSM patches. They are not ready for
upstream review yet, but we're working on it.

Nicolas

[1] https://patchwork.kernel.org/comment/25054908/
[2] See Chapter 15 of Microsoft's 'Hypervisor Top Level Functional Specific=
ation':
    https://raw.githubusercontent.com/MicrosoftDocs/Virtualization-Document=
ation/main/tlfs/Hypervisor%20Top%20Level%20Functional%20Specification%20v6.=
0b.pdf

