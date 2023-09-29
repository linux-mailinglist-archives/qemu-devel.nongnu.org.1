Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 120BD7B2C18
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 07:55:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm6SY-0002Es-0H; Fri, 29 Sep 2023 01:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qm6ST-0002Ec-LC
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 01:54:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qm6SS-0006po-2Z
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 01:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695966874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3SHPTjfdeFXN7fHSg/+PvSmz67fONnTlLMYZHdSYTUQ=;
 b=VHneKpiGF1h/7cHES2VDmJwoPqwEfO26czsGpVBtAEB5bzpS2AFlFTK4v2frnMeBBQl/fI
 YFfmxUg9/nycNefQaEkUPqXcIG3BnnOkhHgIYOLSL2uRJx6uTmd2Srkhbg26s/3HV+KYmG
 TWGxOjIVnwp/tY9DW8PzMvNYXOlyF5I=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-bqZSG0shPoaMXYO7mOtZ1Q-1; Fri, 29 Sep 2023 01:54:33 -0400
X-MC-Unique: bqZSG0shPoaMXYO7mOtZ1Q-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-56f75e70190so13781457a12.3
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 22:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695966872; x=1696571672;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3SHPTjfdeFXN7fHSg/+PvSmz67fONnTlLMYZHdSYTUQ=;
 b=KNrFmsEA3jwa6OBRGDyrQpB3c3kkbMHCmVkL/58NCfX5Z6DIsvpZVce0WZjzt0WMDC
 L9dVy0Ctx/0KZpAydexHD/0lRgorEOput1ZyKpJwVCqZivQa37reokOE1mkZUebU5K25
 qY8bk0HYGTrB5ZAKbMoH9LKuSdmKSFerCpRzpYhbnZOzUUzK+14ZGuWBhvh929+4T/ZC
 1LBUKc2IRfafxHH0MkXaHkgxwdJdvGZfpMIb63VzWBsBLVeqstkSkDj3maRELcUnueFt
 5p1YRHSvNlPl55q57xBaMRFS+YnF1W88v86X0cXZpqtzqeh2jWzN2hK/b2NHUaL97eVH
 staw==
X-Gm-Message-State: AOJu0Yxbesvs+HNlwOtHmanJZpejuGrFVsfFubNGI++5IRE1C1u+4+kB
 l2NUXDx4xzF31gMKBwVKQaIOLzk1lQ4ZKOnhlBRr40nXzIk20KSLNJFHG1EHBx8R6Cao+0jwLYZ
 wP2k8vE4nfKQRcVc=
X-Received: by 2002:a05:6a20:430a:b0:15c:b7ba:9137 with SMTP id
 h10-20020a056a20430a00b0015cb7ba9137mr3685826pzk.2.1695966866987; 
 Thu, 28 Sep 2023 22:54:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2zAlkyboBOafsHFcSBZhlVuxujVrgx+/0WovMIMzrgbbi1W0euwFPC8JpZK90evckLHDVpw==
X-Received: by 2002:a05:6a20:430a:b0:15c:b7ba:9137 with SMTP id
 h10-20020a056a20430a00b0015cb7ba9137mr3685814pzk.2.1695966866652; 
 Thu, 28 Sep 2023 22:54:26 -0700 (PDT)
Received: from smtpclient.apple ([203.163.239.108])
 by smtp.gmail.com with ESMTPSA id
 a15-20020a17090abe0f00b00256b67208b1sm542271pjs.56.2023.09.28.22.54.22
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 28 Sep 2023 22:54:26 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH] hw/acpi: changes towards enabling -Wshadow=local
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <87msx5jztb.fsf@pond.sub.org>
Date: Fri, 29 Sep 2023 11:24:19 +0530
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>, qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5A625074-8DE2-4B58-8B7D-C7FA578F6688@redhat.com>
References: <20230922124203.127110-1-anisinha@redhat.com>
 <87msx5jztb.fsf@pond.sub.org>
To: Markus Armbruster <armbru@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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



> On 29-Sep-2023, at 11:17 AM, Markus Armbruster <armbru@redhat.com> =
wrote:
>=20
> Ani Sinha <anisinha@redhat.com> writes:
>=20
>> Code changes in acpi that addresses all compiler complaints coming =
from enabling
>> -Wshadow flags. Enabling -Wshadow catches cases of local variables =
shadowing
>> other local variables or parameters. These makes the code confusing =
and/or adds
>> bugs that are difficult to catch.
>>=20
>> The code is tested to build with and without the flag turned on.
>>=20
>> CC: Markus Armbruster <armbru@redhat.com>
>> CC: Philippe Mathieu-Daude <philmd@linaro.org>
>> CC: mst@redhat.com
>> CC: imammedo@redhat.com
>> Message-Id: <87r0mqlf9x.fsf@pond.sub.org>
>=20
> This is my "Help wanted for enabling -Wshadow=3Dlocal" post.

Yes indeed. I wanted to refer to that thread for context in the commit =
log.

>=20
> A commit's Message-Id tag is supposed to point to the patch submission
> e-mail, and git-am will add that:
>=20
>  Message-ID: <20230922124203.127110-1-anisinha@redhat.com>
>=20
> We'll have two Message-IDs then.  Confusing.
>=20
> Could perhaps use
>=20
>  See-also: Message-Id: <87r0mqlf9x.fsf@pond.sub.org>
>=20
> but I doubt it's worth the bother.

OK

>=20
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>=20
> Queued less the extra Message-Id, thanks!


