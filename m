Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9BA716067
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:48:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yli-0004kl-51; Tue, 30 May 2023 08:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q3ylR-0004ek-T6
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:47:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q3ylJ-0005ya-5w
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685450856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sJhLxQqdICkY6wR+dB2QDXD5nlsS88dIE1J7b+Goq7Y=;
 b=bAma91dVcYd0PvDV+w1vdIbOIZTCekQe79lm6ghZhJNXLFDf4WApeXqSF46a8H7r3iIdtN
 1NJzT7hQ6huSgG8kq2BD5C8aCg3mLTfgD6wymxylF3dtkL0zlWqRtimyf2kBNHIpCTWm/r
 zPW7AajW2QUTYQqXJHkom8zsrIiTQug=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-V5RCCPVrPW6xIh-PSQY80Q-1; Tue, 30 May 2023 08:47:33 -0400
X-MC-Unique: V5RCCPVrPW6xIh-PSQY80Q-1
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-45703fab0c5so482437e0c.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 05:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685450853; x=1688042853;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sJhLxQqdICkY6wR+dB2QDXD5nlsS88dIE1J7b+Goq7Y=;
 b=ZepHrWMOY5BHgDweOh3pC3hRgdTTOe0Zk9MBY7eq/NRvM1Ugjst53KSaQZmm3FrFDr
 Yoc1gUMp7hfzZw82oQTufkX6ywjuQv+/aJTG0bHKccTAxpp3nMrLch8Wwe4FPn/9is/g
 1b/Hk5g17nWgWvVu6YFKkJseBUJLZsXHy1W1v72CS82dl3zkkdxn+q6PcqFR+jpnrm9/
 QjDfCENf4FFRb5KDSidKyTndKrlHIqD2K+qV+PSUaA5E1LpyUxLgSXj28QJWoqyffCW8
 3hSCbPD/tZsR+ZCxESdtrwrceI132lOH+8+vDmZCQ2hECpS76FH3BPNW4uZ1ob2rYdiX
 SWug==
X-Gm-Message-State: AC+VfDzGOQkq+ikaP1BWxFDzJiPxSLqH8ZA3A3+PVtJ6gC54a/89sUNY
 kDrM8irui2nyc2Ttk3nzp+p91AtZfuu1CousenRt5K5xTh7ScE6BGEMiJtiurKjZgY6+uv9tH76
 lDmESf5Haltydf9y1/YBX5lXQUZ2ohUQ=
X-Received: by 2002:a67:ecd1:0:b0:436:3607:957d with SMTP id
 i17-20020a67ecd1000000b004363607957dmr574647vsp.20.1685450852837; 
 Tue, 30 May 2023 05:47:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Yv1z1tSxEOEbMbZiSVQaKXCgCbCBlpHLsJ1/tbDbbTVrMV4rz9ZhUR1X9lnEiZXycfZvt5um4XS5qr7b5IIE=
X-Received: by 2002:a67:ecd1:0:b0:436:3607:957d with SMTP id
 i17-20020a67ecd1000000b004363607957dmr574643vsp.20.1685450852575; Tue, 30 May
 2023 05:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230527092851.705884-1-pbonzini@redhat.com>
 <ZHXsgqo5gvN8lbv/@redhat.com>
In-Reply-To: <ZHXsgqo5gvN8lbv/@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 30 May 2023 14:47:21 +0200
Message-ID: <CABgObfbT8k+BRH88=UOU+-Go1i=Zb1Sin7vsyJTR-OQaA+Fk8g@mail.gmail.com>
Subject: Re: [PATCH 0/5] meson: replace submodules with wrap files
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, thuth@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, May 30, 2023 at 2:31=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
> > * adding support for firmware with a meson build system to
> >   configure; turn SLOF into a wrap and roms/SLOF into a symlink
> >   for ../pc-bios/s390-ccw/subprojects/SLOF.  I'm mentioning this for
> >   completeness but this is not something I would like.  On the other
> >   hand it could reuse some (or most?) of the code currently used to
> >   generate config-meson.cross, so maybe it isn't that bad...
>
> Is there a reason why SLOF/s390-ccw is handled differently from
> the other ROMs ?  ie, why haven't we checked in the pre-built
> firmware binaries, such that we don't build SLOF by default ?

The SLOF ROM is checked in.

s390-ccw is also checked in, but it is a QEMU-specific ROM like, on
x86, linuxboot.bin or multiboot.bin. Therefore it's rebuilt by "make"
and its build system is part of QEMU's.

The relationship between s390-ccw and SLOF is that s390-ccw _reuses_
the network stack of SLOF, and pc-bios/s390-ccw/Makefile does so by
simply looking at sources at $(SOURCE_PATH)../../roms/SLOF.

Paolo

>
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>


