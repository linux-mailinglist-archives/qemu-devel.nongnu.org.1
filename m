Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB3472E732
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 17:30:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q95ww-00038c-Jg; Tue, 13 Jun 2023 11:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q95wv-00038M-5u
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 11:28:49 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q95wt-00052X-CO
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 11:28:48 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4f654d713c0so6582254e87.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 08:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686670125; x=1689262125;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hgpALJvzjMOdZuCH7jQN7oQrqLsF6RDomTsztZXRmCQ=;
 b=IFZ9XfRpD2D4bwxgSoI73tR9VvxWS5F5H5LvAh7/5kdo1nj3KrVyAEZyhu24RI+ZBW
 12kDFTUtcIN4q/DjqyBlNPXILeDMi0Ewx1h40zilJXbitBjKmQ5rVUxYH8KPZKLW5OjV
 mjUDLLy/b9Wy8WergrkgzA2jTv+3rTA5ZJWw1ya07w5At+HPnTIBKnRmLTXBmGalW1Gw
 HLGq5DFkj64vxi3LpW8+btmWDY0LLcaGjW2XFT/+eqjX2c8AL0ZpEk16PO7XGMpD5+HZ
 XKmcgiBQVFna2U+Bft4TIHsINEaalRCqjOG4B9ZvzvcEvXTyAi85GZ8SpciejqSeAvgL
 zhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686670125; x=1689262125;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hgpALJvzjMOdZuCH7jQN7oQrqLsF6RDomTsztZXRmCQ=;
 b=BrO3HxWmPZDR8liPF6f73w88FHVLP+R1jCMoOuH0EowIAYtfUm2iXXPM97Rld45Ydf
 BGrM4/KAi1t7aqfmQ4wJ1V9/Zvz9IA3O+SLdTW7GrMlzOg1ARLWvqNOAwkfrJE99IZ+0
 1uQ0FBHXLGzrZ9OqUvvvIh9ywOjWzfvydfY6sLkC/manlkfhKJeEYhhYdKkatMV1p1X7
 5exzkeC2nxuG337/dY5g1QXbLYPrmewGDsQwl0FMpzIQHN1FjM7ED0+nnCLK6PtT1pvE
 8yR5lie94MgZLtjLSZsAvEy/3r78ieFOgcit0s0du8TfGxKpWCO5uYgQDLWHCpMdSY9E
 PzGA==
X-Gm-Message-State: AC+VfDxq+4PdapnQYmIbUaWUETZLMcGvif3UangNS84d9lLPW5Fix55k
 +vpecvTEDl1R4IMv/3jkCjU=
X-Google-Smtp-Source: ACHHUZ43/1aH+M/GsJMAt6pJQIfcm9tIzFsFVKfiLKJxHqvkiBBKb+SRn4b0R7MCBTx8CeiTzqRKPw==
X-Received: by 2002:a19:434c:0:b0:4f3:87d7:f7a4 with SMTP id
 m12-20020a19434c000000b004f387d7f7a4mr6202939lfj.62.1686670124732; 
 Tue, 13 Jun 2023 08:28:44 -0700 (PDT)
Received: from [127.0.0.1] ([81.19.4.232]) by smtp.gmail.com with ESMTPSA id
 p4-20020a17090628c400b00977ca819248sm6728623ejd.110.2023.06.13.08.28.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 08:28:44 -0700 (PDT)
Date: Tue, 13 Jun 2023 15:28:37 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
CC: Igor Mammedov <imammedo@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_02/15=5D_hw/pci-host/q35=3A_Fix_do?=
 =?US-ASCII?Q?uble=2C_contradicting_=2Eendianness_assignment?=
In-Reply-To: <20230613110114-mutt-send-email-mst@kernel.org>
References: <20230611103412.12109-1-shentey@gmail.com>
 <20230611103412.12109-3-shentey@gmail.com>
 <20230612150154.438d842f@imammedo.users.ipa.redhat.com>
 <CAG4p6K6yR+iJmjnYOkJFd=GbxPU+QpkzTSEfW1VuUwM95o5_iQ@mail.gmail.com>
 <20230613044810-mutt-send-email-mst@kernel.org>
 <0ff30d22-25f9-750e-3ec1-f0988eee5668@eik.bme.hu>
 <20230613150502.74e46018@imammedo.users.ipa.redhat.com>
 <3b1710cc-b905-e005-a8ab-97513d3c6702@linaro.org>
 <20230613110114-mutt-send-email-mst@kernel.org>
Message-ID: <955BD93B-AE2B-468C-9265-F7B0999283D4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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



Am 13=2E Juni 2023 15:01:40 UTC schrieb "Michael S=2E Tsirkin" <mst@redhat=
=2Ecom>:
>On Tue, Jun 13, 2023 at 03:40:28PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> On 13/6/23 15:05, Igor Mammedov wrote:
>> > On Tue, 13 Jun 2023 13:07:17 +0200 (CEST)
>> > BALATON Zoltan <balaton@eik=2Ebme=2Ehu> wrote:
>> >=20
>> > > On Tue, 13 Jun 2023, Michael S=2E Tsirkin wrote:
>> > > > On Tue, Jun 13, 2023 at 09:46:53AM +0200, Bernhard Beschow wrote:
>> > > > > On Mon, Jun 12, 2023 at 3:01=E2=80=AFPM Igor Mammedov <imammedo=
@redhat=2Ecom> wrote:
>> > > > >=20
>> > > > >      On Sun, 11 Jun 2023 12:33:59 +0200
>> > > > >      Bernhard Beschow <shentey@gmail=2Ecom> wrote:
>> > > > >     > Fixes the following clangd warning (-Winitializer-overrid=
es):
>> > > > >     >
>> > > > >     >=C2=A0 =C2=A0q35=2Ec:297:19: Initializer overrides prior i=
nitialization of this
>> > > > >      subobject
>> > > > >     >=C2=A0 =C2=A0q35=2Ec:292:19: previous initialization is he=
re
>> > > > >     >
>> > > > >     > Settle on native endian which causes the least overhead=
=2E
>> > > > >      indeed it doesn't matter which way we read all ones, so th=
at should work=2E
>> > > > >      but does it really matter (I mean the overhead/what worklo=
ad)?
>> > > > >      If not, I'd prefer explicit LE as it's now to be consisten=
t
>> > > > >      the the rest of memops on Q35=2E
>>=20
>> Meaning trying to optimize this single MR on big-endian is irrelevant :=
)
>>=20
>> > > > >=20
>> > > > > I got a comment from Michael about this in [1], so I've changed=
 it=2E I don't
>> > > > > mind changing it either way=2E
>> > > > >=20
>> > > > > Best regards,
>> > > > > Bernhard
>> > > > >=20
>> > > > > [1] https://patchew=2Eorg/QEMU/20230214131441=2E101760-1-shente=
y@gmail=2Ecom/
>> > > > > 20230214131441=2E101760-3-shentey@gmail=2Ecom/#
>> > > > > 20230301164339-mutt-send-email-mst@kernel=2Eorg
>> > > >=20
>> > > > Hmm it's not terribly important, and the optimization is trivial,
>> > > > but yes people tend to copy code, good point=2E Maybe add a comme=
nt?
>> > > > /*
>> > > > * Note: don't copy this!  normally use DEVICE_LITTLE_ENDIAN=2E Th=
is only
>> > > > * works because we don't allow writes and always read all-ones=2E
>> > > > */
>> > >=20
>> > > Why don't you leave DEVICE_LITTLE_ENDIAN and remove DEVICE_NATIVE_E=
NDIAN
>> > > instead? If this only returns all 1s then it does not matter and al=
so
>> > > DEVICE_LITTLE_ENDIAN was the last assignment so likely that was eff=
ective
>> > > so far anyway=2E
>> >=20
>> > I'm in favor of this as well,
>> > the 'optimization' and then piling comments on top to clarify confusi=
on
>> > should be justified by usefulness of it (no perf numbers/usecase were=
 present so far)=2E
>> > In absence of above, I'd prefer real hw behavior (LE in this case)=2E
>
>
>OK I'm fine with this too=2E Sorry about leading you astray=2E

No worries=2E I'm happy to change it back to LE=2E

Best regards,
Bernhard

