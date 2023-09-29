Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFDF7B2D8A
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:09:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm8YZ-0002Bp-Ob; Fri, 29 Sep 2023 04:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qm8YW-0002Bd-ST
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:09:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qm8YU-00048A-UP
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695974938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lAU5QDrtrNBCzD7+NRZZpY8bTW8xdT7JotMMU0XIATo=;
 b=dknsxgdx1hDlIbqjUrFbz2xmshNmnJnCB4dGMWIZI02LnqROc9W6fZHn0nQVwZomF3lB11
 bRl3zBQdPBzO49pYc54+9UYkQqUJGp92isLY4yDO7scc8o8iwH9daRUo/kSH2JhTwUHqrB
 umKbfEBLNsaxCZy1CSGCZgXTfrMWEAI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-zs119IRzMFCogzj5EgGhIQ-1; Fri, 29 Sep 2023 04:08:56 -0400
X-MC-Unique: zs119IRzMFCogzj5EgGhIQ-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1c747f637d4so3421035ad.1
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 01:08:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695974935; x=1696579735;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lAU5QDrtrNBCzD7+NRZZpY8bTW8xdT7JotMMU0XIATo=;
 b=PxCOyqPkvu8S4UJ16fJILPi+n3gFGbMmPrPY/VkBW65j5jERltznfWK4GtT4kZ01IH
 7k6zHczVr3DtSZ7/ra6xoamrdC6LbLCqLAwu4Kb4ymZJD8hOOY6NZgSiiI0/nGptjwhz
 lRnKtzr2ZnUBwaXqO3GmhWfpQTQgTWQYv732C4vJoGq87Eums02o745OZaGz2qc0dnMK
 9DAwjOe9J+9CYD6c7AodPQbusPT1Cfr18ZZFYyTnMQvlxQOrpH2rJFWG3A7WjsiFIuD6
 rdtyUQSoDmtQf/9TCuATBWh/d1ZTtw6MUp6xqftNoy4PkKNpRpbcqa2mnCPR6lJii/lg
 7rPA==
X-Gm-Message-State: AOJu0YxYt3q4+FJtjmitAD77LpImutPJnSouH5jz9i7MA8N1ijQ9eXk8
 vM/2FnRN2gPpMIIg2MkXnJmaAFjZJQFY+uXPR8tbp1xW9fAA7nMDTiHHV94SXDvgbYWK6BCj+7/
 AXX+3+0YSjhHdPsU=
X-Received: by 2002:a17:902:6806:b0:1c3:64f9:45ad with SMTP id
 h6-20020a170902680600b001c364f945admr3268118plk.48.1695974934951; 
 Fri, 29 Sep 2023 01:08:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG20ao9H8MVWNvUPTVBsJmCqUQ5ZM4dPo4rfiiJ5RXabfYYd7VfjhIIBsTq+LGWWbc4Ocwj2w==
X-Received: by 2002:a17:902:6806:b0:1c3:64f9:45ad with SMTP id
 h6-20020a170902680600b001c364f945admr3268108plk.48.1695974934570; 
 Fri, 29 Sep 2023 01:08:54 -0700 (PDT)
Received: from smtpclient.apple ([203.163.239.108])
 by smtp.gmail.com with ESMTPSA id
 w8-20020a1709029a8800b001b9f032bb3dsm16223361plp.3.2023.09.29.01.08.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 29 Sep 2023 01:08:51 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH] hw/acpi: changes towards enabling -Wshadow=local
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <874jjdflvg.fsf@pond.sub.org>
Date: Fri, 29 Sep 2023 13:38:47 +0530
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>, qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DA7D0A58-0B6B-4AFB-908A-F60EE2B7CC41@redhat.com>
References: <20230922124203.127110-1-anisinha@redhat.com>
 <87msx5jztb.fsf@pond.sub.org>
 <5A625074-8DE2-4B58-8B7D-C7FA578F6688@redhat.com>
 <87r0mhik1n.fsf@pond.sub.org>
 <B1B5F17E-5EDB-4F4F-ABAE-2A45216FBE68@redhat.com>
 <874jjdflvg.fsf@pond.sub.org>
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



> On 29-Sep-2023, at 1:32 PM, Markus Armbruster <armbru@redhat.com> =
wrote:
>=20
> Ani Sinha <anisinha@redhat.com> writes:
>=20
>>> On 29-Sep-2023, at 11:43 AM, Markus Armbruster <armbru@redhat.com> =
wrote:
>>>=20
>>> Ani Sinha <anisinha@redhat.com> writes:
>>>=20
>>>>> On 29-Sep-2023, at 11:17 AM, Markus Armbruster <armbru@redhat.com> =
wrote:
>>>>>=20
>>>>> Ani Sinha <anisinha@redhat.com> writes:
>>>>>=20
>>>>>> Code changes in acpi that addresses all compiler complaints =
coming from enabling
>>>>>> -Wshadow flags. Enabling -Wshadow catches cases of local =
variables shadowing
>>>>>> other local variables or parameters. These makes the code =
confusing and/or adds
>>>>>> bugs that are difficult to catch.
>>>>>>=20
>>>>>> The code is tested to build with and without the flag turned on.
>>>>>>=20
>>>>>> CC: Markus Armbruster <armbru@redhat.com>
>>>>>> CC: Philippe Mathieu-Daude <philmd@linaro.org>
>>>>>> CC: mst@redhat.com
>>>>>> CC: imammedo@redhat.com
>>>>>> Message-Id: <87r0mqlf9x.fsf@pond.sub.org>
>>>>>=20
>>>>> This is my "Help wanted for enabling -Wshadow=3Dlocal" post.
>>>>=20
>>>> Yes indeed. I wanted to refer to that thread for context in the =
commit log.
>>>=20
>>> I appreciate your diligence.  We just don't have an established tag
>>> convention for "see also" references to e-mail.  I could append
>>>=20
>>>   See also
>>>=20
>>>       Subject: Help wanted for enabling -Wshadow=3Dlocal
>>>       Message-Id: <87r0mqlf9x.fsf@pond.sub.org>
>>>       https://lore.kernel.org/qemu-devel/87r0mqlf9x.fsf@pond.sub.org
>>>=20
>>> to your first paragraph.  Want me to?
>>=20
>> Sure, if that is ok.
>=20
> Done!

Your shadow-next has no changes. Have you not pushed to that branch?=


