Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4387839E9
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 08:28:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYKrS-0000YK-E5; Tue, 22 Aug 2023 02:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qYKrC-0000Xm-OA
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 02:27:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qYKr7-0000pG-Ec
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 02:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692685628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2W9ezE/fsgCEQT0hmrMoiDLXeYnSl+yE0Xw4I5bIhLo=;
 b=cZWU801cajw2WnFIqxJiXx8dfR/+WPA5yOD30aLeQuniZFBosrQFB26Stviez8QxpGj09t
 ce0T3N4x7ZLPCCIQGVI8xwtokM4UaapX/+pU+imHZo7FpC9RQ8V8XexMB3hI1p1pLvkxda
 uj2gBzcJhDXqGOktnrFtWMFSyrkjbXo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-210-m6UzmOWIPn2WcEFiy6fIjQ-1; Tue, 22 Aug 2023 02:27:02 -0400
X-MC-Unique: m6UzmOWIPn2WcEFiy6fIjQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 77189185A791;
 Tue, 22 Aug 2023 06:27:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5060D2166B26;
 Tue, 22 Aug 2023 06:27:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4E03221E690D; Tue, 22 Aug 2023 08:27:00 +0200 (CEST)
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
Subject: Re: [PATCH v2 15/58] i386/tdx: Add property sept-ve-disable for
 tdx-guest object
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
 <20230818095041.1973309-16-xiaoyao.li@intel.com>
 <ZOMnf8n8BksktlGg@redhat.com>
Date: Tue, 22 Aug 2023 08:27:00 +0200
In-Reply-To: <ZOMnf8n8BksktlGg@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 21 Aug 2023 09:59:43 +0100")
Message-ID: <877cpn7ft7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

> On Fri, Aug 18, 2023 at 05:49:58AM -0400, Xiaoyao Li wrote:
>> Bit 28 of TD attribute, named SEPT_VE_DISABLE. When set to 1, it disables
>> EPT violation conversion to #VE on guest TD access of PENDING pages.
>>=20
>> Some guest OS (e.g., Linux TD guest) may require this bit as 1.
>> Otherwise refuse to boot.
>>=20
>> Add sept-ve-disable property for tdx-guest object, for user to configure
>> this bit.
>>=20
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>>  qapi/qom.json         |  4 +++-
>>  target/i386/kvm/tdx.c | 24 ++++++++++++++++++++++++
>>  2 files changed, 27 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index 2ca7ce7c0da5..cc08b9a98df9 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -871,10 +871,12 @@
>>  #
>>  # Properties for tdx-guest objects.
>>  #
>> +# @sept-ve-disable: bit 28 of TD attributes (default: 0)
>
> This description isn't very useful as it forces the user to go off and
> read the TDX specification to find out what bit 28 means. You've got a

Seconded.

> more useful description in the commit message, so please use that
> in the docs too. eg something like this
>
>   @sept-ve-disable: toggle bit 28 of TD attributes to control disabling
>                     of EPT violation conversion to #VE on guest
>                     TD access of PENDING pages. Some guest OS (e.g.
>                     Linux TD guest) may require this set, otherwise
>                     they refuse to boot.

But please format like

# @sept-ve-disable: toggle bit 28 of TD attributes to control disabling
#     of EPT violation conversion to #VE on guest TD access of PENDING
#     pages.  Some guest OS (e.g. Linux TD guest) may require this to
#     be set, otherwise they refuse to boot.

to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
to conform to current conventions).

>> +#
>>  # Since: 8.2
>>  ##
>>  { 'struct': 'TdxGuestProperties',
>> -  'data': { }}
>> +  'data': { '*sept-ve-disable': 'bool' } }
>>=20=20
>>  ##
>>  # @ThreadContextProperties:

[...]


