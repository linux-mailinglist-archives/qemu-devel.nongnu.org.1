Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D30481E076
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 13:35:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHkAD-0006zY-Es; Mon, 25 Dec 2023 07:34:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rHkAA-0006z1-4M
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 07:34:30 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rHkA7-00027o-2b
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 07:34:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703507667; x=1735043667;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=kBKpPgDUszsD89fUMQpcwLt3lcoERl6NfvEf9e/71sg=;
 b=V6sRpnzSYf9bxbxIzZdyZdOGbGxdOqNblZd4ycT+5EWPgwtRy8KBKxrR
 +MF/RS6f7jBk+mruBh4ZrHsIYVeyeJiyAbvUU5LtqqowT9ToORnsTdkjm
 TTVO05J1Ex6hulSfkX2bVCm1e/naimI+k4WS+icv4lbqkyx+xEBT9rC1X
 BxfiokwBoYxO2CmN7XM9htrchG5F6hCWBus+BClpKyxrHNmMQgGn7f4y2
 a5ZfuIK9bu/45UFp4bc77KAFIgCAhUKSfCoU1k0vPONAMZrQ5ptqupMko
 6lB9yD9Gsjk0/jdlulVe/160OThIduMdYoz5hUvQmBbznITGGJj7gNR74 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="3370913"
X-IronPort-AV: E=Sophos;i="6.04,303,1695711600"; 
   d="scan'208";a="3370913"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Dec 2023 04:34:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="901176927"
X-IronPort-AV: E=Sophos;i="6.04,303,1695711600"; d="scan'208";a="901176927"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.22.149])
 ([10.93.22.149])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Dec 2023 04:34:15 -0800
Message-ID: <9aee1487-fc1a-4db1-b2ff-e572177eb83d@intel.com>
Date: Mon, 25 Dec 2023 20:34:13 +0800
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
 <5314df8a-4173-46cb-bc7e-984c6b543555@intel.com>
 <ZYWLnIfXac_K7EZM@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZYWLnIfXac_K7EZM@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.977,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.998, HK_RANDOM_FROM=0.998, SPF_HELO_NONE=0.001,
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

On 12/22/2023 9:14 PM, Daniel P. Berrangé wrote:
> On Fri, Dec 22, 2023 at 11:14:12AM +0800, Xiaoyao Li wrote:
>> On 12/21/2023 7:05 PM, Daniel P. Berrangé wrote:
>>> On Wed, Nov 15, 2023 at 02:15:01AM -0500, Xiaoyao Li wrote:
>>>> From: Isaku Yamahata <isaku.yamahata@intel.com>
>>>>
>>>> For GetQuote, delegate a request to Quote Generation Service.
>>>> Add property "quote-generation-socket" to tdx-guest, whihc is a property
>>>> of type SocketAddress to specify Quote Generation Service(QGS).
>>>>
>>>> On request, connect to the QGS, read request buffer from shared guest
>>>> memory, send the request buffer to the server and store the response
>>>> into shared guest memory and notify TD guest by interrupt.
>>>>
>>>> command line example:
>>>>     qemu-system-x86_64 \
>>>>       -object '{"qom-type":"tdx-guest","id":"tdx0","quote-generation-socket":{"type": "vsock", "cid":"2","port":"1234"}}' \
>>>
>>> Here you're illustrating a VSOCK address.  IIUC, both the 'qgs'
>>> daemon and QEMU will be running in the host. Why would they need
>>> to be using VSOCK, as opposed to a regular UNIX socket connection ?
>>>
>>
>> We use vsock here because the QGS server we used for testing exposes the
>> vsock socket.
> 
> Is this is the server impl you test with:
> 
>    https://github.com/intel/SGXDataCenterAttestationPrimitives/tree/master/QuoteGeneration/quote_wrapper/qgs

I think it should be.

I used applications/services bundled by internal teams.

> or is there another impl ?
> 
> With regards,
> Daniel


