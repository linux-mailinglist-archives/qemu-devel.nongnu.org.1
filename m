Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC3D815C2A
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Dec 2023 23:42:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEdLC-0000UZ-7g; Sat, 16 Dec 2023 17:41:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smarkusg@gmail.com>)
 id 1rEdLA-0000UR-BK
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 17:41:00 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smarkusg@gmail.com>)
 id 1rEdL8-0003Uf-Ub
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 17:41:00 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a1ca24776c3so556316366b.0
 for <qemu-devel@nongnu.org>; Sat, 16 Dec 2023 14:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702766457; x=1703371257; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+UyD2v/WwIwcnusFGS3A56OCR6RcBa5ptVFC6PPbShE=;
 b=YzaILhyodvKtMXJbDPLwGVdADpCtj2vgZsXDo5Cf5DS/3YGaAfT3OzZfenqxWyhDgI
 dr2/O98AXoq5Bz1gXJVDHIiFxbX9m3G5+jATpgBCoE8Vt1KQAmD4ADKLSF1AhxRkmY26
 jA66iHhRiy9cGnD9JgpxcNK8MycgZb8WFYxdy2MoXzzYK0BYxT0HhME2AJr60OkWxwqr
 tpTegi/KmLtrl3qP1SW9LsjIDsdnpZUoDKZJgQ4BJvNqPcAC4wuZk+Lf44q6g949zuF9
 ZSJ+Id2sKp6JxP8VdUn2H+OZi937esUNQl9vaX06QKujDThxiDbqQzC+J5+pQPfAFr9+
 k0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702766457; x=1703371257;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+UyD2v/WwIwcnusFGS3A56OCR6RcBa5ptVFC6PPbShE=;
 b=nvQtv7QKsJYv2aO32MbG1jGuK8rC12g9hiRwinTSWiCPE2cMXN1+R3ACYrEPbt2yAe
 1TKYhBlkyNrxqviOu/bu/WTOuqY6s60r81TyLTRTTnTdlkBOxzCWxx6S79t5y8111yIY
 ORsWGj8OvudylSTL2xKrlazVqLYAHCWguJdi4VwcrcPPJYC6JLcfehE3PRlvjmNwbt/+
 kOxckpJJVwnN/obDfd9C91naYukp3AItut4NudIQksaFnIRYTA6UP8PNhnFlbbJDd+mq
 WEwUNXVbh1FOuvNzzXHa3m/KuEsLVhQZpM9OTAHu/Y4dtuzQk0+8Mzt9ExvUHvTBUBzT
 +GLg==
X-Gm-Message-State: AOJu0YwuqSqhWbG9fWM69V/Ut6E3HsTnkRPC1Tx6xranI/zyDBq+fk9i
 GiaMnw/x2q/ip5EhdyridDk=
X-Google-Smtp-Source: AGHT+IExSABQSVrOELg5g723J0J6o0eFamo4Dbk2r3cKJNNeg1RH3n6Lg/y4fBxsbAu1Vv3IQhwkng==
X-Received: by 2002:a17:906:104d:b0:a19:c793:c85c with SMTP id
 j13-20020a170906104d00b00a19c793c85cmr11511604ejj.6.1702766456507; 
 Sat, 16 Dec 2023 14:40:56 -0800 (PST)
Received: from smtpclient.apple ([178.252.34.151])
 by smtp.gmail.com with ESMTPSA id
 sk26-20020a170906631a00b00a1f7852c877sm11641000ejc.142.2023.12.16.14.40.55
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 16 Dec 2023 14:40:56 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v6] ui/cocoa: Use NSWindow's ability to resize
From: Marek Glogowski <smarkusg@gmail.com>
In-Reply-To: <CADfA340BGjC7vvWfx9xRL=MPpZHLkWX8=3y2uqSiD9EWdZpbzw@mail.gmail.com>
Date: Sat, 16 Dec 2023 23:40:54 +0100
Cc: qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <544280AF-A12F-4D4A-ABBB-150D396C7694@gmail.com>
References: <20231211-cocoa-v6-1-49f3be0191f2@daynix.com>
 <CADfA342Dr5troPrjE6Sf2+mMuPL5J1Q_zuXhJxrUnNo9tT6KsQ@mail.gmail.com>
 <3f15630b-4373-4fbc-83cf-ca568341b4d6@daynix.com>
 <CADfA340BGjC7vvWfx9xRL=MPpZHLkWX8=3y2uqSiD9EWdZpbzw@mail.gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=smarkusg@gmail.com; helo=mail-ej1-x631.google.com
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

Hi

I think I may have found a small error=20
=20
>     if (opts->u.cocoa.has_zoom_to_fit && opts->u.cocoa.zoom_to_fit) {
+        [normalWindow setStyleMask:[normalWindow styleMask] & =
~NSWindowStyleMaskResizable];

it should probably be so, because the window never goes into a good mode=20=

 [normalWindow setStyleMask:[normalWindow styleMask] | =
NSWindowStyleMaskResizable];
=20
and the zoom to fit option will never be checked end enable

  menuItem =3D [[[NSMenuItem alloc] initWithTitle:@"Zoom To Fit" =
action:@selector(zoomToFit:) keyEquivalent:@""] autorelease];
 [menuItem setState: [normalWindow styleMask] & =
NSWindowStyleMaskResizable ? NSControlStateValueOn : =
NSControlStateValueOff];=

