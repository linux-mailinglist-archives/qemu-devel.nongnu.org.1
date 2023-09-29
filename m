Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D5B7B2C3A
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 08:15:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm6mi-00022R-81; Fri, 29 Sep 2023 02:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qm6md-00021F-ER
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 02:15:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qm6mb-0002FC-Mg
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 02:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695968123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=voceWY8T5Wr8O/ogXLMOozLXuVgBL2DD+/bPmOHWlrw=;
 b=NGIEEzXBdwVzuzFcJx6shi5sGgs5jTL9CrRbSTqivJdtGTMbVs9wwRMEVnp9WDp91ReuRR
 u3SHSs1vcPCj6zdFbP1OdPXd6sl53BFkhqmuRORyMQIzbTKkpwNSAEyL1T0hFUyIHQqWMR
 6hqeTblHiDG0KEnhCoC7l0Bsw/cTMjI=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-3mCJvyuqO8WPMkmjKVKxvA-1; Fri, 29 Sep 2023 02:15:21 -0400
X-MC-Unique: 3mCJvyuqO8WPMkmjKVKxvA-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-690f9153801so20420404b3a.1
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 23:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695968120; x=1696572920;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=voceWY8T5Wr8O/ogXLMOozLXuVgBL2DD+/bPmOHWlrw=;
 b=H9Yt7zTaTJbGmIAQXHE8f1AyrpOtuf91MdJHwHxk2GG51qUxC5rAXGMJBedNDniOJP
 gmXHPUEcHnUqCFLqgvwoA0GSmYU12hqNT6lTdgBKGp/iJZ5pyXCBLqqoacDBja8XjrSo
 Zfio2VQUGajRDqHUwXMbDt+o9Ft1uCkRDg1uygouudmgQplKTWMRvyDN9F4UJLaOzQxb
 f8JVnazsR784/B/Cj5ZWINs0+Mkc1yizMxwAsqK2rFHFNCjwGDQDtneqWEBp5g0dd7ZD
 wJLWg1mbSLE0GaeP93qmpRS2yZ/NTMKsWXXV6Vp5l4SYDnGRRtkvmUeg/Ii6+O2MpoTz
 4lng==
X-Gm-Message-State: AOJu0YwUq7gKQsfz8wa4b5yXz9oxxoyYLWJsVAzICAR7C+gWvZGCjHaG
 xgj7rpAc9Oobye8CFYwKP1JTDkOqTjR6ohw6lYe/tcR6Xt+vZ7eGF/6BbQz66HDFaq9eKWFIgV1
 J8HdGyxBfHiA9pgWpBulsNbA=
X-Received: by 2002:a05:6a00:2491:b0:692:b8b9:f728 with SMTP id
 c17-20020a056a00249100b00692b8b9f728mr3712220pfv.30.1695968120372; 
 Thu, 28 Sep 2023 23:15:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrIfD05wXEVMB0IzArKJwwJ57nLZX8sicyF/LVPbcsOFPF+O/5OMbLc/KKKr3BLu4zD++nNg==
X-Received: by 2002:a05:6a00:2491:b0:692:b8b9:f728 with SMTP id
 c17-20020a056a00249100b00692b8b9f728mr3712207pfv.30.1695968120009; 
 Thu, 28 Sep 2023 23:15:20 -0700 (PDT)
Received: from smtpclient.apple ([203.163.239.108])
 by smtp.gmail.com with ESMTPSA id
 t26-20020a62ea1a000000b0068fadc9226dsm2137689pfh.33.2023.09.28.23.15.16
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 28 Sep 2023 23:15:19 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH] hw/acpi: changes towards enabling -Wshadow=local
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <87r0mhik1n.fsf@pond.sub.org>
Date: Fri, 29 Sep 2023 11:45:13 +0530
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>, qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B1B5F17E-5EDB-4F4F-ABAE-2A45216FBE68@redhat.com>
References: <20230922124203.127110-1-anisinha@redhat.com>
 <87msx5jztb.fsf@pond.sub.org>
 <5A625074-8DE2-4B58-8B7D-C7FA578F6688@redhat.com>
 <87r0mhik1n.fsf@pond.sub.org>
To: Markus Armbruster <armbru@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 29-Sep-2023, at 11:43 AM, Markus Armbruster <armbru@redhat.com> =
wrote:
>=20
> Ani Sinha <anisinha@redhat.com> writes:
>=20
>>> On 29-Sep-2023, at 11:17 AM, Markus Armbruster <armbru@redhat.com> =
wrote:
>>>=20
>>> Ani Sinha <anisinha@redhat.com> writes:
>>>=20
>>>> Code changes in acpi that addresses all compiler complaints coming =
from enabling
>>>> -Wshadow flags. Enabling -Wshadow catches cases of local variables =
shadowing
>>>> other local variables or parameters. These makes the code confusing =
and/or adds
>>>> bugs that are difficult to catch.
>>>>=20
>>>> The code is tested to build with and without the flag turned on.
>>>>=20
>>>> CC: Markus Armbruster <armbru@redhat.com>
>>>> CC: Philippe Mathieu-Daude <philmd@linaro.org>
>>>> CC: mst@redhat.com
>>>> CC: imammedo@redhat.com
>>>> Message-Id: <87r0mqlf9x.fsf@pond.sub.org>
>>>=20
>>> This is my "Help wanted for enabling -Wshadow=3Dlocal" post.
>>=20
>> Yes indeed. I wanted to refer to that thread for context in the =
commit log.
>=20
> I appreciate your diligence.  We just don't have an established tag
> convention for "see also" references to e-mail.  I could append
>=20
>    See also
>=20
>        Subject: Help wanted for enabling -Wshadow=3Dlocal
>        Message-Id: <87r0mqlf9x.fsf@pond.sub.org>
>        https://lore.kernel.org/qemu-devel/87r0mqlf9x.fsf@pond.sub.org
>=20
> to your first paragraph.  Want me to?

Sure, if that is ok.

>=20
>>> A commit's Message-Id tag is supposed to point to the patch =
submission
>>> e-mail, and git-am will add that:
>>>=20
>>> Message-ID: <20230922124203.127110-1-anisinha@redhat.com>
>>>=20
>>> We'll have two Message-IDs then.  Confusing.
>>>=20
>>> Could perhaps use
>>>=20
>>> See-also: Message-Id: <87r0mqlf9x.fsf@pond.sub.org>
>>>=20
>>> but I doubt it's worth the bother.
>>=20
>> OK
>>=20
>>>=20
>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>=20
>>> Queued less the extra Message-Id, thanks!


