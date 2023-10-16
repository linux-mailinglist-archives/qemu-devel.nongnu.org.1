Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7885A7CB518
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 23:10:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsUpz-0007Di-NJ; Mon, 16 Oct 2023 17:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsUpu-0007DB-Qq
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 17:09:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsUpt-0007Z4-0w
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 17:09:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697490550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l0SdHVpJMVk8UAOU8+z//KRN2c5dG3lwmbb5N/iJ4kA=;
 b=YhOY7jvUijgA/4M2BGPoQV+3ZuYSx5QoXMfB2oKv8B92258FdL70aM7T7DSgwe3nJ8GsZz
 dWI7ZxlxDF/c0pw/kvPFminLlFklowFBxfyZoWfqrGB49AXJYC7mW1nPoPAYctwDArJroK
 ksuvz34rgVqs6aOshiNZZeNdSrE5yY4=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-xLbnaTbSOBu7bzk_GuZHug-1; Mon, 16 Oct 2023 17:09:07 -0400
X-MC-Unique: xLbnaTbSOBu7bzk_GuZHug-1
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-457cbda3299so763788137.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 14:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697490546; x=1698095346;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l0SdHVpJMVk8UAOU8+z//KRN2c5dG3lwmbb5N/iJ4kA=;
 b=M7NR7RHh+y76X+k/aLaAw2b3IXGhvmAedoyLgma3XpkrguKLJrzz2m0LvNNP+ZZxwH
 S9j+Jxc+ZRoKzUZx5arEuIu8s0cHcLkLN50gwQwQRoTsGEkKQP+i8zzbQGUDrCKUnu+E
 Tuatt72E9dtuzZvRSCBP48qkxk0YO7VjARVaPuHAlHyPZdqc22ACR3vr313fQS13XVzw
 IM5Dz+c+ZK7K2vlSwtSHgGv2d9XXn1FHlF9o6SzzxpDDkqEVdqIuuojcUSd6hNHvhrJO
 bIO43gLE4bT1hB/QaT6Zj5L6EPIKMPZ0PRktwpIef8Bv8/rPJBmmdfNHCQ4lFehyVXC5
 uKCg==
X-Gm-Message-State: AOJu0Yz3UyiopxzzTrBj3cFsX5OlQlAEuKTZdfXHsvAI5dWrdlg4/4Yu
 THKFIp0n4YYJ7u1Re1MWfzqp8p9XeGRAkfoFT/ELQePDTEkDyZundxbiKf7+HbpBxxE3DfDq3xT
 EVwNnP8wp42BC0dT3XL3/vgFNdlY6L8M=
X-Received: by 2002:a67:a643:0:b0:452:81b3:4b07 with SMTP id
 r3-20020a67a643000000b0045281b34b07mr511285vsh.17.1697490546496; 
 Mon, 16 Oct 2023 14:09:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IED4OMSl7Pa8rHTzTR4y0MmmEr99KyXpYk31phgx4fPDSFzFiDFeZOLP7g8Qtn9eM+F1yr4KMDLz6IKJPcWNms=
X-Received: by 2002:a67:a643:0:b0:452:81b3:4b07 with SMTP id
 r3-20020a67a643000000b0045281b34b07mr511272vsh.17.1697490546162; Mon, 16 Oct
 2023 14:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230922140914.13906-1-phil@philjordan.eu>
 <4319fcd1-981c-4ef0-b6b9-1f7f57c1c4ca@redhat.com>
 <CAGCz3vuF1=Ee6_G+23QJD-u+-cY0jVJW8kz9Lrgz+KAoMMy1=w@mail.gmail.com>
 <CABgObfaCFS08LgJ2cYKLdqD=cquW3i475fvZFMnA4ih5r+vnGA@mail.gmail.com>
 <CAGCz3vvZFNvcqrUXccg+JBeu2ZJoEMU0uJwvWeGBXF9AHdjT0w@mail.gmail.com>
In-Reply-To: <CAGCz3vvZFNvcqrUXccg+JBeu2ZJoEMU0uJwvWeGBXF9AHdjT0w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 16 Oct 2023 23:08:54 +0200
Message-ID: <CABgObfZ9_zbnBUnf4SvoOJQyy9=QG3Pj8CkSsrBxw-uiQL+NTg@mail.gmail.com>
Subject: Re: [PATCH 0/3] hvf x86 correctness and efficiency improvements
To: Phil Dennis-Jordan <lists@philjordan.eu>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, dirty@apple.com,
 qemu-devel@nongnu.org, rbolshakov@ddn.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

On Mon, Oct 16, 2023 at 10:05=E2=80=AFPM Phil Dennis-Jordan <lists@philjord=
an.eu> wrote:
> > I think fd and the HVF type should be placed in an anonymous union.
>
> Taking a look at the code and thinking through the implications, I'm
> not actually sure what the intention of the union is

Nevermind, I got confused that AccelCPUState depends on what the
actual accelerator is. So yeah, you can just change the type of "fd";
it was an int only because in the past the field was defined for all
accelerators.

Paolo


