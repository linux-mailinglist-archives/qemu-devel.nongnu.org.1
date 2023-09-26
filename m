Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6ABD7AF541
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 22:33:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlEk7-0004Wv-V9; Tue, 26 Sep 2023 16:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlEk5-0004Wg-VY
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:33:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlEk4-00080D-4E
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695760391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eMuVH+oHa9HjcrE286axAI3b0wennb6W5/z1Hxe6p3M=;
 b=c07XOFHAkVMXGMFY6h2kvmZkk07XpMGsnE51vRRnYLIlFgCr+3KWGqO59RD+w0/M56sqqu
 3+y5Un6v8h1090EsU8TbzZtjD296n4q9G+K8EV3xsD6kJwI4paer9ZQ4VFqT7DGj8Yneul
 0QBLOmouEkSFBS7IZaCF+orsmRGEoLc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-151-vi3zmLB1PIGfrOPASWzp7Q-1; Tue, 26 Sep 2023 16:33:07 -0400
X-MC-Unique: vi3zmLB1PIGfrOPASWzp7Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E9CF529ABA1A;
 Tue, 26 Sep 2023 20:33:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B5C0140E950;
 Tue, 26 Sep 2023 20:33:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F3B9D21E6900; Tue, 26 Sep 2023 22:33:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Chenyi Qiang <chenyi.qiang@intel.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  "Markus
 Armbruster"
 <armbru@redhat.com>,  Xiaoyao Li <xiaoyao.li@intel.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  "Igor Mammedov" <imammedo@redhat.com>,  Ani
 Sinha <anisinha@redhat.com>,  Peter Xu <peterx@redhat.com>,  David
 Hildenbrand <david@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Cornelia Huck <cohuck@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Marcelo Tosatti <mtosatti@redhat.com>,  Gerd
 Hoffmann <kraxel@redhat.com>,  <qemu-devel@nongnu.org>,
 <kvm@vger.kernel.org>,  Eduardo Habkost <eduardo@habkost.net>,  Laszlo
 Ersek <lersek@redhat.com>,  Isaku Yamahata <isaku.yamahata@gmail.com>,
 <erdemaktas@google.com>
Subject: Re: [PATCH v2 41/58] i386/tdx: handle TDG.VP.VMCALL<GetQuote>
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
 <20230818095041.1973309-42-xiaoyao.li@intel.com>
 <87wmxn6029.fsf@pond.sub.org> <ZORws2GWRwIGAaJE@redhat.com>
 <d6fbacab-d7e4-9992-438d-a8cb58e179ae@intel.com>
Date: Tue, 26 Sep 2023 22:33:04 +0200
In-Reply-To: <d6fbacab-d7e4-9992-438d-a8cb58e179ae@intel.com> (Chenyi Qiang's
 message of "Tue, 29 Aug 2023 13:31:37 +0800")
Message-ID: <87v8bwisjj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

I sent this reply to your question on the same day, but it got eaten by
malfunctioning servers, and I noticed only now after another failure
made me dig through my logs.  Sorry for the inconvenience!

Chenyi Qiang <chenyi.qiang@intel.com> writes:

> On 8/22/2023 4:24 PM, Daniel P. Berrang=C3=A9 wrote:
>> On Tue, Aug 22, 2023 at 08:52:30AM +0200, Markus Armbruster wrote:
>>> Xiaoyao Li <xiaoyao.li@intel.com> writes:
>>>
>>>> From: Isaku Yamahata <isaku.yamahata@intel.com>
>>>>
>>>> For GetQuote, delegate a request to Quote Generation Service.  Add pro=
perty
>>>> of address of quote generation server and On request, connect to the
>>>> server, read request buffer from shared guest memory, send the request
>>>> buffer to the server and store the response into shared guest memory a=
nd
>>>> notify TD guest by interrupt.
>>>>
>>>> "quote-generation-service" is a property to specify Quote Generation
>>>> Service(QGS) in qemu socket address format.  The examples of the suppo=
rted
>>>> format are "vsock:2:1234", "unix:/run/qgs", "localhost:1234".
>>>>
>>>> command line example:
>>>>   qemu-system-x86_64 \
>>>>     -object 'tdx-guest,id=3Dtdx0,quote-generation-service=3Dlocalhost:=
1234' \
>>>>     -machine confidential-guest-support=3Dtdx0
>>>>
>>>> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
>>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>>> ---
>>>>  qapi/qom.json         |   5 +-
>>>>  target/i386/kvm/tdx.c | 380 ++++++++++++++++++++++++++++++++++++++++++
>>>>  target/i386/kvm/tdx.h |   7 +
>>>>  3 files changed, 391 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>>> index 87c1d440f331..37139949d761 100644
>>>> --- a/qapi/qom.json
>>>> +++ b/qapi/qom.json
>>>> @@ -879,13 +879,16 @@
>>>>  #
>>>>  # @mrownerconfig: MROWNERCONFIG SHA384 hex string of 48 * 2 length (d=
efault: 0)
>>>>  #
>>>> +# @quote-generation-service: socket address for Quote Generation Serv=
ice(QGS)
>>>> +#
>>>>  # Since: 8.2
>>>>  ##
>>>>  { 'struct': 'TdxGuestProperties',
>>>>    'data': { '*sept-ve-disable': 'bool',
>>>>              '*mrconfigid': 'str',
>>>>              '*mrowner': 'str',
>>>> -            '*mrownerconfig': 'str' } }
>>>> +            '*mrownerconfig': 'str',
>>>> +            '*quote-generation-service': 'str' } }
>>>
>>> Why not type SocketAddress?
>>=20
>> Yes, the code uses SocketAddress internally when it eventually
>> calls qio_channel_socket_connect_async(), so we should directly
>> use SocketAddress in the QAPI from the start.
>
> Any benefit to directly use SocketAddress?

Design principle: use JSON to encode structured data as text in
QAPI/QMP.

Do: "mumble": [1, 2, 3]

Don't: "mumble": "1,2,3"

Do: "server": { "type": "inet", "host": "localhost", "port": "12345" }

Don't: "server": "host=3Dlocalhost,port=3D12345"

We violate the principle in a couple of places.  Some are arguably
mistakes, some are pragmatic exceptions.

The principle implies "the only parser QAPI needs is the JSON parser".

The other benefit is consistency with existing interfaces.  They use
SocketAddress (a few old ones use SocketAddressLegacy).

> "quote-generation-service" here is optional, it seems not trivial to add
> and parse the SocketAddress type in QEMU command. After I change 'str'
> to 'SocketAddress' and specify the command like "-object
> tdx-guest,type=3Dvsock,cid=3D2,port=3D1234...", it will report "invalid
> parameter cid".

Try "quote-generation-service.port=3D1234".


