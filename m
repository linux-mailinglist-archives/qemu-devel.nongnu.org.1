Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4687BFE09
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 15:41:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqCyR-0001lW-5r; Tue, 10 Oct 2023 09:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qqCyN-0001kk-EC
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 09:40:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qqCyL-0006oq-Vf
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 09:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696945221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zlVxCCMFwAC8MD0iQFCurIhDhm/Tlylx78KzhuMLWd8=;
 b=OP8FRvuFaLFEOck3ajmkgJxZr+MRpLRbyHR+DL+EQ/x4NRBjqxPxUyt9BQnpDQT9edz4m2
 p0GCI/HOs21JSShAywEwaGv2oNCQSbCkwjsoTmnPtsXFsSmXyE8R3+FOCoD3ejBpAtI12m
 81XFVKKdwqoSsJUdWpqEy3FgxuqAG/E=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-q3f5Ys27NzewYcSs0TdLzQ-1; Tue, 10 Oct 2023 09:40:19 -0400
X-MC-Unique: q3f5Ys27NzewYcSs0TdLzQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-537fb536554so4887110a12.2
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 06:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696945218; x=1697550018;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zlVxCCMFwAC8MD0iQFCurIhDhm/Tlylx78KzhuMLWd8=;
 b=rIr/xrUJNud+bk8xl15CG/HGR5BgydwDCSFykl5/0kfUZOtOIvZltZCmxSU7aiW0r/
 OkWaCF1ZqSO2fuIcmtL5pID7JGvZGkq7qwCc4bNVnbVVtvBkiTk5RNsK+u/ohY+e+o9f
 sT8dKG5TuaH1FxEEj+D2G21HOcwexCKyU2ZMOFSa+YROx2tZAQixwsV7BhkqPMqv71HZ
 2qrOnrTeZ99WnFgZjd04qQXjwug9qCyDt+3A9UIIXxAiQlnaz75kRRFw3+VIN6kqU1Li
 Ee6sjWEH+AOAbW/RCCDd3n1FzZG0pRvzmouThcykGfK+MZN9DvFloOHaCGXEmOggA+DM
 CS7g==
X-Gm-Message-State: AOJu0YyBIeAOXjTLSXI7ZhfXVsBK3+0wQTeuuARuvqBIYFDwxbA8UnGY
 RQTWqWi07FkYKIO35dD1pUKTqI1RX1pX+NbhLjpi5KUakdO6/m49/BlxkCNq+uCTVMcMQkJJCaU
 A9lKkvosQ9w0cAqmvQQ9yLxJYcj45os8=
X-Received: by 2002:aa7:da8a:0:b0:531:9c1:8262 with SMTP id
 q10-20020aa7da8a000000b0053109c18262mr16155814eds.8.1696945218028; 
 Tue, 10 Oct 2023 06:40:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3iDjSUBis99wSMXQqUZOors8A+R14+ZVjugzdZsDsklGjVkgivne2b4etgzfjkgF3Mj+EgG7ANvUSNCAqXnE=
X-Received: by 2002:aa7:da8a:0:b0:531:9c1:8262 with SMTP id
 q10-20020aa7da8a000000b0053109c18262mr16155794eds.8.1696945217714; Tue, 10
 Oct 2023 06:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231010073830.606570-1-marcandre.lureau@redhat.com>
 <20231010073830.606570-17-marcandre.lureau@redhat.com>
 <6365e1f5-bffe-ef11-7e9e-55077e66c4d0@eik.bme.hu>
 <cf0800be-046c-8073-96ce-023dd02469df@eik.bme.hu>
In-Reply-To: <cf0800be-046c-8073-96ce-023dd02469df@eik.bme.hu>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2023 17:40:05 +0400
Message-ID: <CAMxuvazmw=UZxMMztw4azeq8LdL5aBRPJ9FF7mi=UXqh1r2cxg@mail.gmail.com>
Subject: Re: [PATCH v3 16/18] hw/sm501: allow compiling without PIXMAN
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, qemu-arm@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-ppc@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
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

Hi

On Tue, Oct 10, 2023 at 4:30=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
>
> On Tue, 10 Oct 2023, BALATON Zoltan wrote:
> >> @@ -2169,8 +2195,10 @@ static void sm501_pci_class_init(ObjectClass *k=
lass,
> >> void *data)
> >>
> >> static void sm501_pci_init(Object *o)
> >> {
> >> +#ifdef CONFIG_PIXMAN
> >
> > Do you still need the ifdef here if we keep the property even with !PIX=
MAN?
>
> Maybe you intended to remove this help message because the option does no=
t
> work as documented here. In that case maybe add an #else with help saying
> not effective without PIXMAN, always 0 or similiar.
>

Right, I'll simply remove the #ifdef


