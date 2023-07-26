Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3B4763E18
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 20:02:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOid9-0004aL-5H; Wed, 26 Jul 2023 13:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qOid3-0004Zk-U9
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 13:48:54 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qOid2-0004BO-3u
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 13:48:53 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5221f193817so40049a12.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 10:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690393730; x=1690998530;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7PDGrTz1Iq0I9T31rDXSgEelkMZzjAsZYcmzY8EFChc=;
 b=TTtMDnZTqsEz0Grejcca4RQQdvbjg8pjbs+8AYt62hpwaN0vCZ2Kwm/CW7Q3FfUQ3B
 Ch7VbrjF46oFJeukT0eS+OnEmMkCJxfPWe41ojNOHkDsHXEO8FVFP/mmTU3YU8yLVJK7
 ZnSRR2Tt1cI3MgH0lSIyVQMv5etjqWh7SFW13mBTf1D7a7XVoxtch4z8vJKEOT/G/K3U
 bAahNAFXLdhN9fIX32kcWPm675xqmOaDWXkcNp03V+a0ehG0FaUBg5NIN9zFg0I799qT
 NhexdQoLpPJtSrEFhxIp5F+DC4n+7ctY1aHzKwoHzLl//JhnDglmkExuKmkSYHE9suA7
 AUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690393730; x=1690998530;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7PDGrTz1Iq0I9T31rDXSgEelkMZzjAsZYcmzY8EFChc=;
 b=Sa+pzB/6ukGqqdsIY0H3aCz25XGiEEWs3XZrQcQSafBc8/PxzYxHes7+icnYTj0j1Q
 taOPuhRv3SsqIm+SqAJZcssmTyq3PrtY8t8OVSLGX5ZeU6BPchr7JIfew4s6zKmsZy3D
 hiezPKmGm4MC4P31N27ACQsbhcDC+Ztg7LWsapCAf1U9XKOz6lSV9nLFo+jQXHyW7Sym
 tFzrh5creQ6/ffu7mQSGg8Qs++v8qJahvaiib6nsEspeVtedpynue22QW1YrbW8tnB91
 2cHKZgEm0dx1juQOfoJuH7XsOEUSzg5e5s6hu5+7Ewf09lkFirId47Rk6rkZS44Assec
 oBRA==
X-Gm-Message-State: ABy/qLbSRTu1s9D2W3eyjNuemSZuuImDcYuP/MREcU6riDZbYWw8O+Ey
 iCH1d9S6tVuo8FTuK9l11tM=
X-Google-Smtp-Source: APBJJlHHRQ8fZrVgch2742+mxxGCM/9xJYyTI1rZLbCJp4m4SJVSsU2z8nnqve0Osh66gaVHe97VAQ==
X-Received: by 2002:a17:906:cc14:b0:999:37ff:be94 with SMTP id
 ml20-20020a170906cc1400b0099937ffbe94mr2380363ejb.71.1690393729996; 
 Wed, 26 Jul 2023 10:48:49 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-191-027-174.77.191.pool.telefonica.de.
 [77.191.27.174]) by smtp.gmail.com with ESMTPSA id
 h19-20020a1709062dd300b0097073f1ed84sm9918571eji.4.2023.07.26.10.48.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jul 2023 10:48:49 -0700 (PDT)
Date: Wed, 26 Jul 2023 17:48:47 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: paul@xen.org, Paul Durrant <xadimgnik@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>
CC: Olaf Hering <olaf@aepfle.de>
Subject: =?US-ASCII?Q?Re=3A_i386/xen=3A_prevent_guest_from_bin?=
 =?US-ASCII?Q?ding_loopback_event_channel_to_itself?=
In-Reply-To: <8ff47c7e-81eb-2795-6e61-cb93ea8f1abf@xen.org>
References: <c976d480399a44e09b1da3ad201e3021def223f7.camel@infradead.org>
 <e2df69f7-d7d1-a2c4-6bf0-e2142f64a53b@xen.org>
 <93bcbaee0b800b4a951a76340f3988088dfb1689.camel@infradead.org>
 <8ff47c7e-81eb-2795-6e61-cb93ea8f1abf@xen.org>
Message-ID: <7D25F578-ED4B-4976-A66B-08BA0B738E61@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



Am 26=2E Juli 2023 09:24:28 UTC schrieb Paul Durrant <xadimgnik@gmail=2Eco=
m>:
>On 26/07/2023 10:07, David Woodhouse wrote:
>> On Wed, 2023-07-26 at 09:44 +0100, Paul Durrant wrote:
>>> On 25/07/2023 11:05, David Woodhouse wrote:
>>>> From: David Woodhouse <dwmw@amazon=2Eco=2Euk>
>>>>=20
>>>> Fuzzing showed that a guest could bind an interdomain port to itself,=
 by
>>>> guessing the next port to be allocated and putting that as the 'remot=
e'
>>>> port number=2E By chance, that works because the newly-allocated port=
 has
>>>> type EVTCHNSTAT_unbound=2E It shouldn't=2E
>>>>=20
>>>> Signed-off-by: David Woodhouse <dwmw@amazon=2Eco=2Euk>
>>>> ---
>>>>  =C2=A0 hw/i386/kvm/xen_evtchn=2Ec | 11 +++++++++--
>>>>  =C2=A0 1 file changed, 9 insertions(+), 2 deletions(-)
>>>>=20
>>>=20
>>> Reviewed-by: Paul Durrant <paul@xen=2Eorg>
>>>=20
>>=20
>> Thanks=2E I'll change the title prefix to 'hw/xen' since it's in hw/ no=
t
>> target/i386=2E
>
>Yes, makes sense=2E
>
>> Please can I have also have a review for
>> https://lore=2Ekernel=2Eorg/qemu-devel/20076888f6bdf06a65aafc5cf9542609=
65d45b97=2Ecamel@infradead=2Eorg/
>>=20
>
>Sorry I missed that=2E Done=2E

And that one, too please? https://lore=2Ekernel=2Eorg/qemu-devel/202307200=
72950=2E20198-1-olaf@aepfle=2Ede/

Sorry for cross posting, but the patch would be good to have in 8=2E1=2E

Best regards,
Bernhard

>
>Cheers,
>
>  Paul
>

