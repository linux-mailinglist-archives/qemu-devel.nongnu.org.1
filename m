Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FF58081BC
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 08:19:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rB8eX-000712-Do; Thu, 07 Dec 2023 02:18:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rB8eV-00070K-Ep
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 02:18:31 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rB8eT-0002rU-GA
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 02:18:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701933509; x=1733469509;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=f+yxBhPM4CtYSl3dlXRi4+On6xfe/pMPniP+d87c89Q=;
 b=n8dYW80mQn5C0/teYVYZuP8aWH4yBE61PcD24ZK8iOrz1z7N0jpi9THh
 6eZyfBAmSatSAf/trjJ3MyNeOcUsUyPWjBxURC3ZzKWWMi/W/k/p5IbrL
 OyssRnKDKNdarKzsqN5ou8XC6oHBR9NlwuPpAorQsym2bfENbJVQJiOn0
 kmIPwJqKVyCbK8vtz4TL8eGQPeXAJzYIYMoItgAhokC8HWxNPGDcDnV5a
 UuFtAFOwx63oqjPQlESysjC63iP6H3rnWUz6e8q1jzlPWQBJEEPrFIwXF
 wMSszarl2e6QSDSMHJjq4MU3RfMXn0FPbebYb3UZLH33xBPpEDSFz8ULy A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="393059197"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; d="scan'208";a="393059197"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Dec 2023 23:18:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="944933801"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; d="scan'208";a="944933801"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.29.154])
 ([10.93.29.154])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Dec 2023 23:18:19 -0800
Message-ID: <f1848765-0247-4f58-8dd6-e69a99a0644c@intel.com>
Date: Thu, 7 Dec 2023 15:18:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/70] i386/tdx: Get tdx_capabilities via
 KVM_TDX_CAPABILITIES
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Michael Roth <michael.roth@amd.com>,
 Sean Christopherson <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Isaku Yamahata
 <isaku.yamahata@gmail.com>, Chenyi Qiang <chenyi.qiang@intel.com>
References: <20231115071519.2864957-1-xiaoyao.li@intel.com>
 <20231115071519.2864957-19-xiaoyao.li@intel.com>
 <ZVSjWxI6c1qt3X9M@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZVSjWxI6c1qt3X9M@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/15/2023 6:54 PM, Daniel P. Berrangé wrote:
>> +static int tdx_ioctl_internal(void *state, enum tdx_ioctl_level level, int cmd_id,
>> +                        __u32 flags, void *data)
>> +{
>> +    struct kvm_tdx_cmd tdx_cmd;
> Add   ' = {}'  to initialize to all-zeros, avoiding the explicit
> memset call

thanks for the suggestion. Will do it in the next version.

