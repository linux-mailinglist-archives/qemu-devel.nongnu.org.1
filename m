Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A26802C46
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 08:42:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA3a6-0008Qx-71; Mon, 04 Dec 2023 02:41:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rA3Zz-0008QM-PE
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 02:41:24 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rA3Zu-00031M-Oj
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 02:41:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701675678; x=1733211678;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=jMnjDLBqJ4t4/XvKEv0l+/ysieTqDpI4VbHwZZMz/Hk=;
 b=Pe6XULX4GXNWJzE6vNfwc+nAz/vtRctW88eBZg08xHQGfucywMLBeo+I
 R1iMRSpNOqX1ghL5qJ1kwzAIL3tqU0QbgITMaY6F+qRGDe8d6JL/TQ9Wr
 KqkC8Auc65zja4tP8ypSM4krMBr0DXSp1ogJn0Ed9ZT9oxbDhmoMrnj7a
 79qBK6LDZXEV2K5uOIDyI2MfpBiA5uQNS2avhXWr9d1zffYFmSALyEv3+
 XCQZef50vBWipQE+dPccZb+0wBn9xlaEO2F2qG0lE17s2zX1A7mirDjyj
 Qd0F65yVYweKxsnPNyp/gCSxym9kksSVPYKf0VoiaNpa1Zz5uWjSmC95+ g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="12411513"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; d="scan'208";a="12411513"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2023 23:41:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="763858934"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; d="scan'208";a="763858934"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.29.154])
 ([10.93.29.154])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2023 23:41:02 -0800
Message-ID: <616b5d4e-39a1-4f61-8fa6-1938fb4df1a7@intel.com>
Date: Mon, 4 Dec 2023 15:40:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/70] physmem: replace function name with __func__ in
 ram_block_discard_range()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>, Sean Christopherson
 <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Isaku Yamahata
 <isaku.yamahata@gmail.com>, Chenyi Qiang <chenyi.qiang@intel.com>
References: <20231115071519.2864957-1-xiaoyao.li@intel.com>
 <20231115071519.2864957-9-xiaoyao.li@intel.com>
 <24521a5c-beec-4f08-8e89-2a413788bf8b@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <24521a5c-beec-4f08-8e89-2a413788bf8b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/16/2023 2:21 AM, David Hildenbrand wrote:
> On 15.11.23 08:14, Xiaoyao Li wrote:
>> Use __func__ to avoid hard-coded function name.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
> 
> That can be queued independently.

Will you queue it for 9.0? for someone else?

Do I need to send it separately?

> Reviewed-by: David Hildenbrand <david@redhat.com>
> 


