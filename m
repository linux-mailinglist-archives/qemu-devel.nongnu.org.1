Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF90798288
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:44:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeVDP-0002k0-1U; Fri, 08 Sep 2023 02:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qeVDB-0002fH-W3
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:43:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qeVD8-0001Pl-RC
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694155396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tZH/48hlfmjLLP7RRyo/5DMTz43tK1rWbS2GqaMKAX8=;
 b=bm2J8GwH38PefYSyoHYwnnIMnjyWzhpfxugT1FeoLFUHC0SNa8LecN+PQl67SJfnxya2aR
 mWqQ+tNkUCBEkI9zFgCQCI6T89udgdcAn1CLE8eAHoEh7WYoZv3aYqsQiqXjFPL2Q2Zb4W
 w/7bUoFOSY5x8R9pd6DIZKoff/lP7DI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-mGnfOeScP5i3IythTDUA7g-1; Fri, 08 Sep 2023 02:43:12 -0400
X-MC-Unique: mGnfOeScP5i3IythTDUA7g-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b9d0b3a572so19960811fa.1
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:43:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694155391; x=1694760191;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tZH/48hlfmjLLP7RRyo/5DMTz43tK1rWbS2GqaMKAX8=;
 b=YNW6sCMTZ5lsV/EZRernWCaaEtaXyS9q2fCSQBESNYYXDH4Ro7WbPjCI2xF77MnaC+
 GJAJfOR0p1wAtD/mNAB+EWeeBT+C/RT4htVyVqGuuQp1FQv7s9HmEjT5PZYJ0z2hR7ya
 CwrVWFHp4tilk7pg/3zZ91wUvOa65XdsHx3GdnCCQPhTHifgzIdAPRJzUWf6q18SXhwd
 Jb/9JKoHuceR8b/68taaErxh+yDaGUo8EY3hXZ4CMJLOtXWXqqvHON3jLnkh8U8qrRSJ
 yvvQpKoWbSvV0gM/05J+C19tMgPYlwXjgmnsLtQVLF3U46exHW+X3cUpA+JLcVubPuQ8
 uiYg==
X-Gm-Message-State: AOJu0Yw3h60QIvpVSNqnByV/q8nakfuwuX9kuBlAJhtB9fIvMEE5FicB
 b5CDF+HwlwGSgJiuxEusA7oHlXDdFFpc9MbkA56KRNq4wvM9YAAbYxKms3uD6BfoM26csHS6gfK
 OZqzkjfGaqvgAIUWEqNChevg9Pbahz1E=
X-Received: by 2002:a2e:9919:0:b0:2b9:b9c8:99 with SMTP id
 v25-20020a2e9919000000b002b9b9c80099mr1086039lji.22.1694155391215; 
 Thu, 07 Sep 2023 23:43:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpNtgX6zS2ljZlUGmK63YrJ/fSSWuaDX4eJowsSK+1Ojo0t7XvZMGqrY77n+dVu/M0GxbCd8QoM0wraYdZByM=
X-Received: by 2002:a2e:9919:0:b0:2b9:b9c8:99 with SMTP id
 v25-20020a2e9919000000b002b9b9c80099mr1086029lji.22.1694155390906; 
 Thu, 07 Sep 2023 23:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230831065140.496485-1-andrew@daynix.com>
 <20230831065140.496485-6-andrew@daynix.com>
 <CABcq3pHyiO4AWSzxwWKfUnULfqPGQs1g12MCn14Ms4FqupZAzg@mail.gmail.com>
In-Reply-To: <CABcq3pHyiO4AWSzxwWKfUnULfqPGQs1g12MCn14Ms4FqupZAzg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 8 Sep 2023 14:42:59 +0800
Message-ID: <CACGkMEvBEdV1+uxE00hbXuFWmT2+nqgT9JxBezLXBwEX0b9Vbw@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] ebpf: Updated eBPF program and skeleton.
To: Andrew Melnichenko <andrew@daynix.com>
Cc: mst@redhat.com, armbru@redhat.com, eblake@redhat.com, 
 qemu-devel@nongnu.org, berrange@redhat.com, yuri.benditovich@daynix.com, 
 yan@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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

On Mon, Sep 4, 2023 at 7:23=E2=80=AFPM Andrew Melnichenko <andrew@daynix.co=
m> wrote:
>
> Hi Jason,
> According to our previous conversation, I've added checks to the meson sc=
ript.
> Please confirm that everything is correct

I've queued this series.

Thanks


