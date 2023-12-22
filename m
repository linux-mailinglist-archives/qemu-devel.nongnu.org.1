Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5E781C34D
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 04:16:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGVzf-0007ts-PV; Thu, 21 Dec 2023 22:14:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rGVzd-0007tR-Kx
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 22:14:33 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rGVzb-0007mn-SS
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 22:14:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703214872; x=1734750872;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=d2EjJbX4nUgOeAWakANi9riMAhtsVG2bAgGIXFasRSk=;
 b=idhzyIbWyP5iKO763ygfIJkwAOS9jg1yncG40A0Qj2kHW7/aAUSDrqJG
 JkA5KDV+UPoG0Eq9CCWs2DsruYUjj+faylxjhPQyYs1iO8plnF4nBZJDW
 J5swCR7LHCFScuZi3nH21bGpMgq6YQsrawvPZejjLgmDPdRUeH01CGmEp
 ZWoAdfLeP9ClOIuczTTFZ17DVbW89Y7LjeK66OjMZ95bScSj0ImYtOoAw
 Cugix9GA0FU38WZ+gxExDoDQt6wYjozk/GsS2qfDbp/lCrY5VF0nsG0Vh
 VYXn/SWJd3YupVEhxg9TRW2hau7nTa1tqpsZj5uyOS+p3MalUYQpYe6At g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="3156965"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="3156965"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Dec 2023 19:14:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; d="scan'208";a="18572185"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.12.199])
 ([10.93.12.199])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Dec 2023 19:14:15 -0800
Message-ID: <5314df8a-4173-46cb-bc7e-984c6b543555@intel.com>
Date: Fri, 22 Dec 2023 11:14:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 52/70] i386/tdx: handle TDG.VP.VMCALL<GetQuote>
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
 <20231115071519.2864957-53-xiaoyao.li@intel.com>
 <ZYQb_P6eHokUz9Hh@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZYQb_P6eHokUz9Hh@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
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

On 12/21/2023 7:05 PM, Daniel P. Berrangé wrote:
> On Wed, Nov 15, 2023 at 02:15:01AM -0500, Xiaoyao Li wrote:
>> From: Isaku Yamahata <isaku.yamahata@intel.com>
>>
>> For GetQuote, delegate a request to Quote Generation Service.
>> Add property "quote-generation-socket" to tdx-guest, whihc is a property
>> of type SocketAddress to specify Quote Generation Service(QGS).
>>
>> On request, connect to the QGS, read request buffer from shared guest
>> memory, send the request buffer to the server and store the response
>> into shared guest memory and notify TD guest by interrupt.
>>
>> command line example:
>>    qemu-system-x86_64 \
>>      -object '{"qom-type":"tdx-guest","id":"tdx0","quote-generation-socket":{"type": "vsock", "cid":"2","port":"1234"}}' \
> 
> Here you're illustrating a VSOCK address.  IIUC, both the 'qgs'
> daemon and QEMU will be running in the host. Why would they need
> to be using VSOCK, as opposed to a regular UNIX socket connection ?
> 

We use vsock here because the QGS server we used for testing exposes the 
vsock socket.

I will add more examples in next version to show that any socket type is 
supported.


