Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C51E9783A10
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 08:37:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYKzq-0003Cw-Om; Tue, 22 Aug 2023 02:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qYKzo-0003CG-NU
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 02:36:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qYKzm-0002rH-Fu
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 02:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692686165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qVE3ooAMGFYQl8Vq3ChV2gQcs4bkbpbsik+TRZOY0KM=;
 b=A+o02sUZt8TVnx6kU1IOwKuAHjhsRDNUdhqqq2PVU59khFx1j+nSJ6fX1Cdwmv4yLbgUdH
 7N5SgVpaW8pVG/OjdX1qIh0mJ3525dWoR7tHz4rzZuFfKD1Kj72eJbmsVdKJnMm8ofHEaC
 Vs5UDkhcqIsOVo94G2ZDhCaSzQzyM4Q=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-567-Xtni8CBoOKOzjpkVGpn9gw-1; Tue, 22 Aug 2023 02:35:20 -0400
X-MC-Unique: Xtni8CBoOKOzjpkVGpn9gw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22B032823800;
 Tue, 22 Aug 2023 06:35:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DC1FD1121314;
 Tue, 22 Aug 2023 06:35:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D4FC421E690D; Tue, 22 Aug 2023 08:35:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Igor
 Mammedov <imammedo@redhat.com>,  Ani Sinha <anisinha@redhat.com>,  Peter
 Xu <peterx@redhat.com>,  David Hildenbrand <david@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Cornelia Huck
 <cohuck@redhat.com>,
 Eric Blake <eblake@redhat.com>,  Marcelo Tosatti <mtosatti@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,  qemu-devel@nongnu.org,
 kvm@vger.kernel.org,  Eduardo Habkost <eduardo@habkost.net>,  Laszlo
 Ersek <lersek@redhat.com>,  Isaku Yamahata <isaku.yamahata@gmail.com>,
 erdemaktas@google.com,  Chenyi Qiang <chenyi.qiang@intel.com>
Subject: Re: [PATCH v2 20/58] i386/tdx: Allows
 mrconfigid/mrowner/mrownerconfig for TDX_INIT_VM
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
 <20230818095041.1973309-21-xiaoyao.li@intel.com>
 <ZOMulbt2Z9+9EEkv@redhat.com>
Date: Tue, 22 Aug 2023 08:35:18 +0200
In-Reply-To: <ZOMulbt2Z9+9EEkv@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 21 Aug 2023 10:29:57 +0100")
Message-ID: <871qfv7ffd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Aug 18, 2023 at 05:50:03AM -0400, Xiaoyao Li wrote:
>> From: Isaku Yamahata <isaku.yamahata@intel.com>
>>=20
>> When creating TDX vm, three sha384 hash values can be provided for
>> TDX attestation.
>>=20
>> So far they were hard coded as 0. Now allow user to specify those values
>> via property mrconfigid, mrowner and mrownerconfig. Choose hex-encoded
>> string as format since it's friendly for user to input.
>>=20
>> example
>> -object tdx-guest, \
>>   mrconfigid=3D0123456789abcdef0123456789abcdef0123456789abcdef012345678=
9abcdef0123456789abcdef0123456789abcdef, \
>>   mrowner=3Dfedcba9876543210fedcba9876543210fedcba9876543210fedcba987654=
3210fedcba9876543210fedcba9876543210, \
>>   mrownerconfig=3D0123456789abcdef0123456789abcdef0123456789abcdef012345=
6789abcdef0123456789abcdef0123456789abcdef
>>=20
>> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>> TODO:
>>  - community requests to use base64 encoding if no special reason
>> ---
>>  qapi/qom.json         | 11 ++++++++++-
>>  target/i386/kvm/tdx.c | 13 +++++++++++++
>>  target/i386/kvm/tdx.h |  3 +++
>>  3 files changed, 26 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index cc08b9a98df9..87c1d440f331 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -873,10 +873,19 @@
>>  #
>>  # @sept-ve-disable: bit 28 of TD attributes (default: 0)
>>  #
>> +# @mrconfigid: MRCONFIGID SHA384 hex string of 48 * 2 length (default: =
0)
>> +#
>> +# @mrowner: MROWNER SHA384 hex string of 48 * 2 length (default: 0)
>> +#
>> +# @mrownerconfig: MROWNERCONFIG SHA384 hex string of 48 * 2 length (def=
ault: 0)
>
> Per previous patch, I suggest these should all be passed in base64
> instead of hex.

I'm upgrading this suggestion to a demand: we use base64 for encoding
binary data everywhere in QAPI/QMP.  Consistency matters.

>                 Also 'default: 0' makes no sense for a string,
> which would be 'default: nil', and no need to document that as
> the default is implicit from the fact that its an optional string
> field. So eg
>
>   @mrconfigid: base64 encoded MRCONFIGID SHA384 digest

Agree.

The member names are abbreviations all run together, wheras QAPI/QMP
favors words-separated-with-dashes.  If you invented them, please change
them to QAPI/QMP style.  If they are established TDX terminology, keep
them as they are, but please point to your evidence.

>> +#
>>  # Since: 8.2
>>  ##
>>  { 'struct': 'TdxGuestProperties',
>> -  'data': { '*sept-ve-disable': 'bool' } }
>> +  'data': { '*sept-ve-disable': 'bool',
>> +            '*mrconfigid': 'str',
>> +            '*mrowner': 'str',
>> +            '*mrownerconfig': 'str' } }
>>=20=20
>>  ##
>>  # @ThreadContextProperties:

[...]


