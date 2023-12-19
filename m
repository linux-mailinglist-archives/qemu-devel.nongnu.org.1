Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D178180B3
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 05:49:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFS1x-0001yz-4j; Mon, 18 Dec 2023 23:48:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1rFS1u-0001yq-RU
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 23:48:30 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1rFS1s-00038F-Jj
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 23:48:30 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a22deb95d21so475536666b.3
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 20:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1702961305; x=1703566105;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IBiIS4hAHaB8wgdgN85FsPZbAXBCXvBUDaIWlX9adxg=;
 b=XcsiOnBPIUP5bHGSsUYtHSv41Wn9h+suaUFEoU8MiK+HOooMSB/13ZFtRSRV1ekubR
 pHjCE91ap/nkVtKxZKVyvPBzv85e0f8MXY+cZo2y4jIzD8fIu6Ton4KfCAsnd9eLjMQA
 JLG8aIm5Dw1ThJsXbEs5NVFbBPTC3MMYJ3PbG1Gj2kiIjB40wD1VbQw7I4e6WIG+L7JX
 vWWt3ikueDI1ELW9/uJeVtwxmyvQ8DC8r7rTjOgdnkXXqNL1Vnl8ATh4UYykJEmpcz6D
 qPLpgQx36s6JdswKX+gYl/Opey1t9oxPJtPKW0tfKydo2LGKNeh/2P5tcH16jAOcdweu
 m1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702961305; x=1703566105;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IBiIS4hAHaB8wgdgN85FsPZbAXBCXvBUDaIWlX9adxg=;
 b=QRFOsh0g5v7UPHS1qGW2ySSV/wQF/RV0ukyPj6Y+BM38um9zoMmeCl3AAESfJRmuMB
 xje+164wbvPi0VcDLWEn6ygpuAfAMdd63kKN95Cuc0VpAeWPvA3H7qJBvjyQqszxSZWD
 PpY0oFwxkXh2Tol1FWwviNPFSVAeRaOslvLU5UAw/A1+MDfp1GGaGvEqUCcX5KMXYHK1
 sMrIcI2SJxJVbjQcF1gJ8MR5QHYCQIeupqYwJvA/bBCrATTYmyq8pV/Fs+yiN/KVQkqf
 T1/XzJBtXvt5w4lLUkbiY6TsBGqmbwRQkED9pTBhKjLBz1vs1kTAEFbjgi4wDcAN+g/Z
 DmKA==
X-Gm-Message-State: AOJu0YwNQhh+QsC+sdxCYxrWraBEJkdZoq3WM7O6bLJB5Y+ykFWjBf3L
 HTDUzC4NrslB4HxKwgBmCKWHqXlDZusydxcAyrXwIH2j0lFMyoWRi6o=
X-Google-Smtp-Source: AGHT+IHFgp/hrmHvmZ/tJ8UtBFYSJbV0nQcnGjuLHTyvttbjnBO/FIpSLcRia1zmC3+eedierXb947/d6Ri9VS1N/Iw=
X-Received: by 2002:a17:906:245:b0:a08:f837:7802 with SMTP id
 5-20020a170906024500b00a08f8377802mr8291666ejl.14.1702961305308; Mon, 18 Dec
 2023 20:48:25 -0800 (PST)
MIME-Version: 1.0
References: <20231211071204.30156-1-tomoyuki.hirose@igel.co.jp>
In-Reply-To: <20231211071204.30156-1-tomoyuki.hirose@igel.co.jp>
From: Tomoyuki Hirose <tomoyuki.hirose@igel.co.jp>
Date: Tue, 19 Dec 2023 13:48:09 +0900
Message-ID: <CAFS=EckTC5P8X4-cnyF3oB5K1sDCbAeBnwLwpy-aVrAJomt3sw@mail.gmail.com>
Subject: Re: [PATCH 0/2] support unaligned access for some xHCI registers
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=tomoyuki.hirose@igel.co.jp; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

I would be grateful if you would any comments on my patch.

ping,

Tomoyuki HIROSE

On Mon, Dec 11, 2023 at 4:12=E2=80=AFPM Tomoyuki HIROSE
<tomoyuki.hirose@igel.co.jp> wrote:
>
> According to xHCI spec rev 1.2, unaligned access to xHCI Host
> Controller Capability Registers are not prohibited. But current
> implementation does not support unaligned access to 'MemoryRegion'.
> These patches contain 2 changes:
> 1. support unaligned access to 'MemoryRegion'
> 2. allow unaligned access to Host Controller Capability Registers.
>
> Tomoyuki HIROSE (2):
>   system/memory.c: support unaligned access
>   hw/usb/hcd-xhci.c: allow unaligned access to Capability Registers
>
>  hw/usb/hcd-xhci.c |  4 +++-
>  system/memory.c   | 22 ++++++++++++++++------
>  2 files changed, 19 insertions(+), 7 deletions(-)
>
> --
> 2.39.2
>

