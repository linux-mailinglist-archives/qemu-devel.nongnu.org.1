Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB7480844A
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 10:21:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBAYc-000771-V8; Thu, 07 Dec 2023 04:20:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rBAYY-00076o-Fn
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 04:20:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rBAYW-0008GN-Bx
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 04:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701940826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VPvxqAbgoQQxPyIHkQi8z/jsNTv9iouX3PBx5XJF9PI=;
 b=iDMg1K1qE4jiPlnYWXGVtVxtW3dS9CrbOyrtXTv9JDU28WKTAaVQMe7FZ5MEI+Kcl6AEeL
 9u+13FPFgx5LhUsGdM8hVyUTWVIoKCo4muXvCsPuTEQhAa/1o0fggfaVS4gus4+lixW9yT
 sDbiov9YR85shUYVezhzObj3vTI+j4U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-0XXJrdYgM2i_RbFFkgpl7A-1; Thu,
 07 Dec 2023 04:20:22 -0500
X-MC-Unique: 0XXJrdYgM2i_RbFFkgpl7A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A95703C29A6E;
 Thu,  7 Dec 2023 09:20:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 69CEB2166B35;
 Thu,  7 Dec 2023 09:20:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7BA6621E6A01; Thu,  7 Dec 2023 10:20:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Markus Armbruster <armbru@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  David Hildenbrand <david@redhat.com>,  Igor
 Mammedov <imammedo@redhat.com>,  "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Peter Xu <peterx@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Cornelia Huck
 <cohuck@redhat.com>,
 Daniel =?utf-8?Q?P=2EBerrang=C3=A9?= <berrange@redhat.com>,  Eric Blake
 <eblake@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,  qemu-devel@nongnu.org,
 kvm@vger.kernel.org,  Michael Roth <michael.roth@amd.com>,  Sean
 Christopherson <seanjc@google.com>,  Claudio Fontana <cfontana@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>,  Isaku Yamahata
 <isaku.yamahata@gmail.com>,  Chenyi Qiang <chenyi.qiang@intel.com>
Subject: Re: [PATCH v3 52/70] i386/tdx: handle TDG.VP.VMCALL<GetQuote>
In-Reply-To: <a838be54-89cc-485b-897c-d069fc887d3d@intel.com> (Xiaoyao Li's
 message of "Thu, 7 Dec 2023 15:38:28 +0800")
References: <20231115071519.2864957-1-xiaoyao.li@intel.com>
 <20231115071519.2864957-53-xiaoyao.li@intel.com>
 <87jzpyw5hp.fsf@pond.sub.org>
 <a838be54-89cc-485b-897c-d069fc887d3d@intel.com>
Date: Thu, 07 Dec 2023 10:20:20 +0100
Message-ID: <87il5axtbf.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> On 12/1/2023 7:02 PM, Markus Armbruster wrote:
>> Xiaoyao Li <xiaoyao.li@intel.com> writes:
>> 
>>> From: Isaku Yamahata <isaku.yamahata@intel.com>
>>>
>>> For GetQuote, delegate a request to Quote Generation Service.
>>> Add property "quote-generation-socket" to tdx-guest, whihc is a property
>>> of type SocketAddress to specify Quote Generation Service(QGS).
>>>
>>> On request, connect to the QGS, read request buffer from shared guest
>>> memory, send the request buffer to the server and store the response
>>> into shared guest memory and notify TD guest by interrupt.
>>>
>>> command line example:
>>>    qemu-system-x86_64 \
>>>      -object '{"qom-type":"tdx-guest","id":"tdx0","quote-generation-socket":{"type": "vsock", "cid":"2","port":"1234"}}' \
>>>      -machine confidential-guest-support=tdx0
>>>
>>> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
>>> Codeveloped-by: Chenyi Qiang <chenyi.qiang@intel.com>
>>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>> ---
>>> Changes in v3:
>>> - rename property "quote-generation-service" to "quote-generation-socket";
>>> - change the type of "quote-generation-socket" from str to
>>>    SocketAddress;
>>> - squash next patch into this one;
>>> ---
>>>   qapi/qom.json         |   5 +-
>>>   target/i386/kvm/tdx.c | 430 ++++++++++++++++++++++++++++++++++++++++++
>>>   target/i386/kvm/tdx.h |   6 +
>>>   3 files changed, 440 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>> index fd99aa1ff8cc..cf36a1832ddd 100644
>>> --- a/qapi/qom.json
>>> +++ b/qapi/qom.json
>>> @@ -894,13 +894,16 @@
>>>   #
>>>   # @mrownerconfig: base64 MROWNERCONFIG SHA384 digest
>>>   #
>>> +# @quote-generation-socket: socket address for Quote Generation Service(QGS)
>>> +#
>> Long line.  Better:
>>     # @quote-generation-socket: socket address for Quote Generation
>>     #     Service(QGS)
>
> May I ask what's the limitation for qom.json? if 80 columns limitation doesn't apply to it.

docs/devel/qapi-code-gen.rst section "Documentation markup":

    For legibility, wrap text paragraphs so every line is at most 70
    characters long.

Why is this not 80?  Humans tend to have trouble following long lines
with their eyes (I sure do).  Typographic manuals suggest to limit
columns to roughly 60 characters for exactly that reason[*].

For code, four levels of indentation plus 60 characters of actual text
yields 76.  However, code lines can be awkward to break, and going over
80 can be less bad than an awkward line break.  Use your judgement.

Documentation text, however, tends to be indented much less: 6-10
characters of indentation plus 60 of actual text yields 66-70.  When I
reflowed the entire QAPI schema documentation to stay within that limit
(commit a937b6aa739), not a single line break was awkward.

>>>   # Since: 8.2
>>>   ##
>>>   { 'struct': 'TdxGuestProperties',
>>>     'data': { '*sept-ve-disable': 'bool',
>>>               '*mrconfigid': 'str',
>>>               '*mrowner': 'str',
>>> -            '*mrownerconfig': 'str' } }
>>> +            '*mrownerconfig': 'str',
>>> +            '*quote-generation-socket': 'SocketAddress' } }
>>>     ##
>>>   # @ThreadContextProperties:
>> 

[*] https://en.wikipedia.org/wiki/Column_(typography)#Typographic_style


