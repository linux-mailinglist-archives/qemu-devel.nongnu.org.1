Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE728170C9
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 14:47:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFDxw-0005Br-BE; Mon, 18 Dec 2023 08:47:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rFDxu-0005BH-Ll
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 08:47:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rFDxs-0008Cd-PL
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 08:47:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702907243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KpTZCnyPB9urpgeAAc4RRyXIjpQ05VzuR/q4EVUTs4I=;
 b=K6JWan1LCsq09WasQDAqDs595jpCv4uuLZBBqykE3R0l4XK34v13LL0Gwody18MIDsg6Sh
 9PWsP1F1CsQMtff3qQQGzKtMW2EHPBKe7FF1AhhRYgTMQQ8mDoXMuxCh9eYHtDS1fnSDhH
 dQ2kUVeD1CQhrPzUyFPjsroKQek+V7M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-Z2_NQgy8ODaWZhTzKNGriQ-1; Mon, 18 Dec 2023 08:47:19 -0500
X-MC-Unique: Z2_NQgy8ODaWZhTzKNGriQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68D6788D4F6;
 Mon, 18 Dec 2023 13:46:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 25F1FC15968;
 Mon, 18 Dec 2023 13:46:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 229B821E6920; Mon, 18 Dec 2023 14:46:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  David Hildenbrand
 <david@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Peter Xu
 <peterx@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,  Daniel =?utf-8?Q?P=2EBerrang=C3=A9?=
 <berrange@redhat.com>,  Eric Blake <eblake@redhat.com>,  Marcelo Tosatti
 <mtosatti@redhat.com>,  qemu-devel@nongnu.org,  kvm@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>,  Sean Christopherson
 <seanjc@google.com>,  Claudio Fontana <cfontana@suse.de>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Isaku Yamahata <isaku.yamahata@gmail.com>,  Chenyi
 Qiang <chenyi.qiang@intel.com>
Subject: Re: [PATCH v3 31/70] i386/tdx: Allows
 mrconfigid/mrowner/mrownerconfig for TDX_INIT_VM
In-Reply-To: <31d6dbc1-f453-4cef-ab08-4813f4e0ff92@intel.com> (Xiaoyao Li's
 message of "Thu, 14 Dec 2023 11:07:21 +0800")
References: <20231115071519.2864957-1-xiaoyao.li@intel.com>
 <20231115071519.2864957-32-xiaoyao.li@intel.com>
 <87o7faw5k1.fsf@pond.sub.org>
 <31d6dbc1-f453-4cef-ab08-4813f4e0ff92@intel.com>
Date: Mon, 18 Dec 2023 14:46:58 +0100
Message-ID: <87edfjsjvx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.083,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> On 12/1/2023 7:00 PM, Markus Armbruster wrote:
>> Xiaoyao Li <xiaoyao.li@intel.com> writes:
>>=20
>>> From: Isaku Yamahata <isaku.yamahata@intel.com>
>>>
>>> Three sha384 hash values, mrconfigid, mrowner and mrownerconfig, of a TD
>>> can be provided for TDX attestation.
>>>
>>> So far they were hard coded as 0. Now allow user to specify those values
>>> via property mrconfigid, mrowner and mrownerconfig. They are all in
>>> base64 format.
>>>
>>> example
>>> -object tdx-guest, \
>>>    mrconfigid=3DASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN7wE=
jRWeJq83v,\
>>>    mrowner=3DASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN7wEjRW=
eJq83v,\
>>>    mrownerconfig=3DASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN=
7wEjRWeJq83v
>>>
>>> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
>>> Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>> ---
>>> Changes in v3:
>>>   - use base64 encoding instread of hex-string;
>>> ---
>>>   qapi/qom.json         | 11 +++++-
>>>   target/i386/kvm/tdx.c | 85 +++++++++++++++++++++++++++++++++++++++++++
>>>   target/i386/kvm/tdx.h |  3 ++
>>>   3 files changed, 98 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>> index 3a29659e0155..fd99aa1ff8cc 100644
>>> --- a/qapi/qom.json
>>> +++ b/qapi/qom.json
>>> @@ -888,10 +888,19 @@
>>>  #     pages.  Some guest OS (e.g., Linux TD guest) may require this to
>>>  #     be set, otherwise they refuse to boot.
>>>  #
>>> +# @mrconfigid: base64 encoded MRCONFIGID SHA384 digest
>>> +#
>>> +# @mrowner: base64 encoded MROWNER SHA384 digest
>>> +#
>>> +# @mrownerconfig: base64 MROWNERCONFIG SHA384 digest
>>
>> Can we come up with a description that tells the user a bit more clearly
>> what we're talking about?  Perhaps starting with this question could
>> lead us there: what's an MRCONFIGID, and why should I care?
>
> Below are the definition from TDX spec:
>
> MRCONFIGID: Software-defined ID for non-owner-defined configuration of th=
e guest TD =E2=80=93 e.g., run-time or OS configuration.
>
> MROWNER: Software-defined ID for the guest TD=E2=80=99s owner
>
> MROWNERCONFIG: Software-defined ID for owner-defined configuration of the=
 guest TD =E2=80=93 e.g., specific to the workload rather than the run-time=
 or OS

Have you considered using this for the doc comments?  I'd omit
"software-defined" in this context.

> They are all attestation related, and input by users who launches the TD =
. Software inside TD can retrieve them with TDREPORT and verify if it is th=
e expected value.
>
> MROWNER is to identify the owner of the TD, MROWNERCONFIG is to pass OWNE=
R's configuration. And MRCONFIGID contains configuration specific to OS lev=
el instead of OWNER.
>
> Below is the explanation from Intel inside, hope it can get you more clea=
r:
>
> "These are primarily intended for general purpose, configurable software =
in a minimal TD. So, not a legacy VM image cloud customer wanting to move t=
heir VM out into the cloud. Also it=E2=80=99s not necessarily the case that=
 any workload will use them all.
>
> MROWNER is for declaring the owner of the TD. An example use case would b=
e an vHSM TD. HSMs need to know who their administrative contact is. You co=
uld customize the HSM image and measurements, but then people can=E2=80=99t=
 recognize that this is the vHSM product from XYZ. So you put the unmodifie=
d vHSM stack in the TD, which will include MRTD/RTMRs that reflect the vHSM=
, and the owner=E2=80=99s public key in MROWNER. Now, when the vHSM starts =
up, to determine who is authorized to send commands, it does a TDREPORT, an=
d looks at MROWNER.
>
> Extending this model, there could be important configuration information =
from the owner. In that case, MROWNERCONFIG is set to the hash of the confi=
g file that the vHSM should accept.
>
> This results in an attestable environment that explicitly indicates that =
it=E2=80=99s a well recognized vHSM TD, being administered by MROWNER and l=
oading the configuration information that matches MROWNERCONFIG.
>
> Extending this idea of configuration of generally recognized software, it=
 could be that there is a shim OS under the vHSM that itself is configurabl=
e. So MRCONFIGID, which isn=E2=80=99t a great name, can include configurati=
on information intended for the OS level. The ID is confusing, but MRCONFIG=
ID was the name we used for this register for SGX, so we kept the name."

Include a reference to this document?

>>> +#
>>>  # Since: 8.2
>>>  ##
>>>  { 'struct': 'TdxGuestProperties',
>>> -  'data': { '*sept-ve-disable': 'bool' } }
>>> +  'data': { '*sept-ve-disable': 'bool',
>>> +            '*mrconfigid': 'str',
>>> +            '*mrowner': 'str',
>>> +            '*mrownerconfig': 'str' } }
>>>   ##
>>>   # @ThreadContextProperties:
>> [...]
>>=20


