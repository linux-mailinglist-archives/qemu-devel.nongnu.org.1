Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3044807112
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 14:44:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAsCA-0001id-T7; Wed, 06 Dec 2023 08:44:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rAsBx-0001iR-Vz
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 08:43:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rAsBu-0003XK-Sg
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 08:43:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701870234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cGbNWein5+1xHR10S1uc1ylcdJmgisND/IaKWA1UWts=;
 b=JuJ/JP359ZUjCcgWYL/o061Et07RvWskz4tK/NaoKlEBh3WNqMcxCssjj0PEiyryZ9uBG8
 RTQT+kVOwARgQdpendFil+RrR1pYfuD/cSSwCFAkJn1rcSz8iTtyDNce71D7n57epmKu0M
 yL87IyqGIkk9yjl2Y2SB1FBhd8hzGC0=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-aDecz-S2Mridt6mBmjkFKg-1; Wed, 06 Dec 2023 08:43:52 -0500
X-MC-Unique: aDecz-S2Mridt6mBmjkFKg-1
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-4b309d9aad0so249639e0c.1
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 05:43:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701870232; x=1702475032;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cGbNWein5+1xHR10S1uc1ylcdJmgisND/IaKWA1UWts=;
 b=QPxB5lMfu67lflB1fJJZIISXC+fs6ayyCI/u2Duhzv8ZsShdij6MKkRN2kEzLHslRN
 DeQAjASbK2GR6vX4zyiAP6YWKMxo+bw69LhxITIUlyou/+C0AEwJHXGaFWCZQDR+KV27
 IpV8oAykpFyIFUNL778dIoyxOBtiAL1kymFeR1x6/wMldHPixo1+aUnhW8Ipf/l5trEq
 s2gJH4rNbEoXCbOSIHs3IYkzlTcDx4U9Fw1RITXCJz9+/eEKbWE24uz5RYCvR4m2W46u
 j5y5ly/ElBvzoMAfg2t+QUr2g9I9XxDQ2ZdQrrJXMFzqPuwhZfDsc1J+22wvEFLLgMqr
 lZOA==
X-Gm-Message-State: AOJu0Ywds7LlVjb0FBiXV8Tcvk0+4cr2vWWXXrFcwHMUjloJagIGHnKk
 vU7PjQUMTLQB4Te5pvjDsuRQQG08ba3wDiBeVF6ipUM45efMQqO5bsp4gkzXAgwsWMxOd3llvUa
 TufQ1hkcZ3aNTN4b4jDjGn+K5yE3NqJk=
X-Received: by 2002:a05:6122:4e26:b0:4b2:c554:ef03 with SMTP id
 ge38-20020a0561224e2600b004b2c554ef03mr940417vkb.21.1701870232155; 
 Wed, 06 Dec 2023 05:43:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYw/IwMhZjw8QhOHqgPBLvQOT8KiowIQ+XS74Wf/xU6c5/sE8vHDL7fpQ0FUEh8TQE+7xHAguLn5NGS3q/sJ8=
X-Received: by 2002:a05:6122:4e26:b0:4b2:c554:ef03 with SMTP id
 ge38-20020a0561224e2600b004b2c554ef03mr940401vkb.21.1701870231925; Wed, 06
 Dec 2023 05:43:51 -0800 (PST)
MIME-Version: 1.0
References: <20231205222816.1152720-1-michael.roth@amd.com>
 <4e78f214-43ee-4c3a-ba49-d3b54aff8737@linaro.org>
 <20231206131248.q2yfrrfpfga7zfie@amd.com>
In-Reply-To: <20231206131248.q2yfrrfpfga7zfie@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 6 Dec 2023 14:43:39 +0100
Message-ID: <CABgObfYbBbjXVR6YXBwt9v6Nmy-DNrCm4+kAEmWUJ-wMjjD09A@mail.gmail.com>
Subject: Re: [PATCH v2 for-8.2?] i386/sev: Avoid SEV-ES crash due to missing
 MSR_EFER_LMA bit
To: Michael Roth <michael.roth@amd.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Marcelo Tosatti <mtosatti@redhat.com>, 
 Tom Lendacky <thomas.lendacky@amd.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, kvm@vger.kernel.org, 
 Lara Lazier <laramglazier@gmail.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
 Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Dec 6, 2023 at 2:13=E2=80=AFPM Michael Roth <michael.roth@amd.com> =
wrote:
> > This 'Fixes:' tag is misleading, since as you mentioned this commit
> > only exposes the issue.
>
> That's true, a "Workaround-for: " tag or something like that might be mor=
e
> appropriate. I just wanted to make it clear that SEV-ES support is no lon=
ger
> working with that patch applied, so I used Fixes: and elaborated on the
> commit message. I can change it if there's a better way to convey this
> though.

That's fine, Fixes is also for automated checks, like "if you have
this commit you also want this one".

> >
> > Commit d499f196fe ("target/i386: Added consistency checks for EFER")
> > or around it seems more appropriate.
>
> Those checks seem to be more for TCG.

Yes, that's 100% TCG code.

> The actual bug is in the host
> kernel, and it seems to have been there basically since the original
> SEV-ES host support went in in 2020. I've also sent a patch to address
> this in KVM:
>
>   https://lore.kernel.org/lkml/20231205234956.1156210-1-michael.roth@amd.=
com/T/#u

Thanks, looking at it.

Paolo


