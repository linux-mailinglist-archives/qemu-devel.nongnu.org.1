Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BCA827E66
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 06:40:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN4ou-0006Ri-G7; Tue, 09 Jan 2024 00:38:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rN4os-0006RL-J3
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 00:38:34 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rN4op-0002qW-VR
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 00:38:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704778712; x=1736314712;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=XrUn2EeNuhQURB9JbWxsm1XG8XAZDv9HlyO2tI0QvME=;
 b=IgblVrBHC2P00NOPFXzObvmXQWOEjhP2We50NG8lbE3HW61tQR8LZwaq
 AyR8hZWzwlzeBHWJba7i2YPd0sKjAXx0lAuqiXrGMM9mTNsVBsJoFujYJ
 op1qiwZoVJ+O7GgSQKz8Hl4XiHMmFJB3bfec/A4V9ojTSztju3QMQDfGn
 +weegfRYcmBvPW5fExG3dsxLZNx6eBlU/D5PaK1e1aNWOkYcRlv2JgOVX
 kXdaxmg8vDOaO1KUfk5WBRxJQq3EgGyzjWilXDTMUU9wgvKpL40vFuD6I
 o4bL/gSg5dpf2GJlNxxVwPAB679Yksh+KjunleSCmayUdJLpTzAzD9/Np Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="4848051"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="4848051"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jan 2024 21:38:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="781664636"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; d="scan'208";a="781664636"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.22.149])
 ([10.93.22.149])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jan 2024 21:38:22 -0800
Message-ID: <62b421de-33d2-4c2f-81a3-4b5a0abb64c5@intel.com>
Date: Tue, 9 Jan 2024 13:38:19 +0800
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
 <ZVUGtpZDTW27F8Um@redhat.com>
 <db4330cf-d25a-48d3-b681-cf2326c16912@intel.com>
 <ZZwKPH3fVHo9EyBy@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZZwKPH3fVHo9EyBy@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
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

On 1/8/2024 10:44 PM, Daniel P. Berrangé wrote:
> On Fri, Dec 29, 2023 at 10:30:15AM +0800, Xiaoyao Li wrote:
>> On 11/16/2023 1:58 AM, Daniel P. Berrangé wrote:
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
>>>>       -machine confidential-guest-support=tdx0
>>>>
>>>> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
>>>> Codeveloped-by: Chenyi Qiang <chenyi.qiang@intel.com>
>>>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
>>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>>> ---
>>>> Changes in v3:
>>>> - rename property "quote-generation-service" to "quote-generation-socket";
>>>> - change the type of "quote-generation-socket" from str to
>>>>     SocketAddress;
>>>> - squash next patch into this one;
>>>> ---
>>>>    qapi/qom.json         |   5 +-
>>>>    target/i386/kvm/tdx.c | 430 ++++++++++++++++++++++++++++++++++++++++++
>>>>    target/i386/kvm/tdx.h |   6 +
>>>>    3 files changed, 440 insertions(+), 1 deletion(-)
>>>>
>>>> +static void tdx_handle_get_quote_connected(QIOTask *task, gpointer opaque)
>>>> +{
>>>> +    struct tdx_get_quote_task *t = opaque;
>>>> +    Error *err = NULL;
>>>> +    char *in_data = NULL;
>>>> +    MachineState *ms;
>>>> +    TdxGuest *tdx;
>>>> +
>>>> +    t->hdr.error_code = cpu_to_le64(TDX_VP_GET_QUOTE_ERROR);
>>>> +    if (qio_task_propagate_error(task, NULL)) {
>>>> +        t->hdr.error_code = cpu_to_le64(TDX_VP_GET_QUOTE_QGS_UNAVAILABLE);
>>>> +        goto error;
>>>> +    }
>>>> +
>>>> +    in_data = g_malloc(le32_to_cpu(t->hdr.in_len));
>>>> +    if (!in_data) {
>>>> +        goto error;
>>>> +    }
>>>> +
>>>> +    if (address_space_read(&address_space_memory, t->gpa + sizeof(t->hdr),
>>>> +                           MEMTXATTRS_UNSPECIFIED, in_data,
>>>> +                           le32_to_cpu(t->hdr.in_len)) != MEMTX_OK) {
>>>> +        goto error;
>>>> +    }
>>>> +
>>>> +    qio_channel_set_blocking(QIO_CHANNEL(t->ioc), false, NULL);
>>>
>>> You've set the channel to non-blocking, but....
>>>
>>>> +
>>>> +    if (qio_channel_write_all(QIO_CHANNEL(t->ioc), in_data,
>>>> +                              le32_to_cpu(t->hdr.in_len), &err) ||
>>>> +        err) {
>>>
>>> ...this method will block execution of this thread, by either
>>> sleeping in poll() or doing a coroutine yield.
>>>
>>> I don't think this is in coroutine context, so presumably this
>>> is just blocking.  So what was the point in marking the channel
>>> non-blocking ?
>>
>> Hi Dainel,
>>
>> First of all, I'm not good at socket or qio channel thing. Please correct me
>> and teach me when I'm wrong.
>>
>> I'm not the author of this patch. My understanding is that, set it to
>> non-blocking is for the qio_channel_write_all() to proceed immediately?
> 
> The '_all' suffixed methods are implemented such that they will
> sleep in poll(), or a coroutine yield when seeing EAGAIN.
> 
>> If set non-blocking is not needed, I can remove it.
>>
>>> You are setting up a background watch to wait for the reply
>>> so we don't block this thread, so you seem to want non-blocking
>>> behaviour.
>>
>> Both sending and receiving are in a new thread created by
>> qio_channel_socket_connect_async(). So I think both of then can be blocking
>> and don't need to be in another background thread.
>>
>> what's your suggestion on it? Make both sending and receiving blocking or
>> non-blocking?
> 
> I think the code /should/ be non-blocking, which would mean
> using   qio_channel_write, instead of qio_channel_write_all,
> and using a .

I see. will implement in the next version.

> With regards,
> Daniel


