Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC9D762D28
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 09:24:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOYrp-0003E4-Bc; Wed, 26 Jul 2023 03:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qOYrm-0003DH-Fi
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 03:23:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qOYrk-0001WP-Pv
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 03:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690356203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pmw6wl1dl2hF+adlNw6TZD6m3IUv+FWrjfWGf2H5N7s=;
 b=VmtJQ6iKvqYmc9ng90Fsovv3fThUsvNmME9k4/oF0NaBzENrToO8oj6OxKYKndd6oYxkLD
 ya7X9r8cWwsggq+E4hSCYrklYY+H0TsRCdRozGGYca6/ERW1VdLZIXqgBSfzntL9GsUEzV
 LobF7rEApW4erEKSzESqp7ipFfL3daQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-okeFuGa_M_m1bRCK4v3_xQ-1; Wed, 26 Jul 2023 03:23:21 -0400
X-MC-Unique: okeFuGa_M_m1bRCK4v3_xQ-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1bb8f751372so32318255ad.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 00:23:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690356200; x=1690961000;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pmw6wl1dl2hF+adlNw6TZD6m3IUv+FWrjfWGf2H5N7s=;
 b=fi1tZ1SYVQVddapEnlfGBUp3PRowqmUkUXnxZ7j62spAqWw+BOua1JtyQhiv4xDb0I
 2AhISt3xzm/NopIXGsZqrpwnQn6qpn75JzkRlD3ru1tMXWPxLlPo5Q4G91Xo4SXk71PC
 eMrNhBE60YaR1O+H4KL2YVmeY4JANechdUdaIH8Fbb9l/6CInNSID6G4TZIcwfLSBB60
 WUuBo23fCLSvbtGQhXffGI0SzHTKfCiXa8QCb86rfZigVvpgWtXpNqir/nVpw1OUUrtb
 ukQDF5/rJOhUnHqrZIzxBMvBtgPg+lEPWeViPnGrVhGeucKEJ+066nyL/4oaKOVfCWBo
 O7xA==
X-Gm-Message-State: ABy/qLZRCkOR0jNN5wP8ig3aKwEDx+hiZu8LWz9HEUk6PVBirvwMw9aY
 5wsgAVuWX7OSur0qqoY01va/11TSgvO2sE2+Sxz8qRmq3Xwt17Af9w/a5HmOwJiHdoyANuYFAMe
 S6HhDO+NdJyzX/dY=
X-Received: by 2002:a17:903:1cd:b0:1bb:7d2f:7c19 with SMTP id
 e13-20020a17090301cd00b001bb7d2f7c19mr1349466plh.64.1690356200555; 
 Wed, 26 Jul 2023 00:23:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHEIUibhuwaZAv0T7nUCnb1rcq3zVE2vCo4hWZ4i2aSxzO9NjzH07mzR+MXBDNw+PoXCeCVlw==
X-Received: by 2002:a17:903:1cd:b0:1bb:7d2f:7c19 with SMTP id
 e13-20020a17090301cd00b001bb7d2f7c19mr1349448plh.64.1690356200209; 
 Wed, 26 Jul 2023 00:23:20 -0700 (PDT)
Received: from smtpclient.apple ([115.96.152.59])
 by smtp.gmail.com with ESMTPSA id
 y19-20020a170902ed5300b001b3bf8001a9sm3782491plb.48.2023.07.26.00.23.15
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Jul 2023 00:23:19 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v2 2/6] python/machine: close sock_pair in cleanup path
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <ZMAR3L4O9sSEV4AL@redhat.com>
Date: Wed, 26 Jul 2023 12:53:13 +0530
Cc: John Snow <jsnow@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Hanna Reitz <hreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Joel Stanley <joel@jms.id.au>, Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1E4E4974-524B-497B-B605-8906ABB526DF@redhat.com>
References: <20230725180337.2937292-1-jsnow@redhat.com>
 <20230725180337.2937292-3-jsnow@redhat.com> <ZMAR3L4O9sSEV4AL@redhat.com>
To: =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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



> On 25-Jul-2023, at 11:48 PM, Daniel P. Berrang=C3=A9 =
<berrange@redhat.com> wrote:
>=20
> On Tue, Jul 25, 2023 at 02:03:33PM -0400, John Snow wrote:
>> If everything has gone smoothly, we'll already have closed the socket =
we
>> gave to the child during post_launch. The other half of the pair that =
we
>> gave to the QMP connection should, likewise, be definitively closed =
by
>> now.
>>=20
>> However, in the cleanup path, it's possible we've created the =
socketpair
>> but flubbed the launch and need to clean up resources. These =
resources
>> *would* be handled by the garbage collector, but that can happen at
>> unpredictable times. Nicer to just clean them up synchronously on the
>> exit path, here.
>>=20
>> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

>> ---
>> python/qemu/machine/machine.py | 5 +++++
>> 1 file changed, 5 insertions(+)
>>=20
>> diff --git a/python/qemu/machine/machine.py =
b/python/qemu/machine/machine.py
>> index 8be0f684fe..26f0fb8a81 100644
>> --- a/python/qemu/machine/machine.py
>> +++ b/python/qemu/machine/machine.py
>> @@ -395,6 +395,11 @@ def _post_shutdown(self) -> None:
>>         finally:
>>             assert self._qmp_connection is None
>>=20
>> +        if self._sock_pair:
>> +            self._sock_pair[0].close()
>> +            self._sock_pair[1].close()
>> +            self._sock_pair =3D None
>> +
>=20
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>=20
> With regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    =
https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            =
https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    =
https://www.instagram.com/dberrange :|
>=20


