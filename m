Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1515F71EF6C
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 18:46:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4lQr-0001QK-80; Thu, 01 Jun 2023 12:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q4lQO-0001O0-FI
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:45:21 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q4lQM-000168-Ni
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:45:20 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-96f5d651170so508744166b.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 09:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685637917; x=1688229917;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=11ObepHFm1VZX7NKytPUbInDRykC2nhHqdcBAYi1ytY=;
 b=OO/81TB0SLm1N57k9ni+ZofhPx/gRjxh2/t2Czqy+BYMj6KZ0Z+sFamVsBT5b9aAYR
 MJM5nZDYarSIwLnK8w49MNJ55jY9zoClQll+vQ5NETtyfomLOE9hdEWGycXlF31YXBtp
 Ie4NPpjzUc6S643eKDHHyRm5/hf5UM7GzfonhsCEKP1BO8N4pQAOCX2Orr2G87+FGZ8t
 kx6Hm7qQ/upOJgVSOPqFfws6Lc7Sks3vhEmjrLR7ZfDc4J2bv+aBunAH454KzK7LofLi
 FuWsN2BuKXJ2JPFil7vkPrBNF5HfYf8g+L73miDPaGDNp9kLu9knYHtjvaS0GXbUpzJV
 Ibrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685637917; x=1688229917;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=11ObepHFm1VZX7NKytPUbInDRykC2nhHqdcBAYi1ytY=;
 b=Hd+7WFmZ+FpszzgSR2W9mjaQbLubs/y+Ye0FX1obWRK7+o/GKeAV1y3Sj+30SFAgR/
 rRkMy0zOGw5oj4A9M6jdFMk5nn9Ww1r8lYcKOnYJIua6hDx4UPbPP8IQzkrPvJCOclDY
 qHoQoM1Xe1qD7I0icDNA2/LMoDjb+SU/TgQYX6Cska1J1Gm/+/aEx+hatsfiule1pPDW
 zuLxbwyJnSEHALz8CgF/CgBrYdQJVvaA2camqHQfsC3/2hRbDtJnAJ+0FxNoJ2hRqK8r
 /GvqaF5U3JrLqZyNVp7SzUx/w8SXf75ntD354lG5yGVfjnhBnUkoCNYNcrWMmlWVwTIs
 jYow==
X-Gm-Message-State: AC+VfDyCZ4Fj65QR02l20sL2deRvMrlIdPOWttMCk63UuEVzSCk1Hnt8
 Ke5cEdHgDA+tf6qmvFQyDhf+6QPOUbNpUzeyu8aG6Q==
X-Google-Smtp-Source: ACHHUZ7uzu+ipAfthhNlTvzqHEFIjC+V5/6Dsq66gF6EZrZJq+cQrGD3nWblsgqyBMucSlqkg4qlUCTlCt/leamT1jw=
X-Received: by 2002:a17:907:3eaa:b0:96f:add6:c1ed with SMTP id
 hs42-20020a1709073eaa00b0096fadd6c1edmr2146654ejc.38.1685637916997; Thu, 01
 Jun 2023 09:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230601143312.69691-1-quic_acaggian@quicinc.com>
 <CAFEAcA-92-zExcOFMwaNYvP5pXLTUETsYi3mpuvTp2txfVEp9Q@mail.gmail.com>
 <11f8fb60-abe7-d99d-c3bb-aaa405425668@quicinc.com>
 <B0A9BD1B-B98C-4710-987D-03ADDBB993B7@quicinc.com>
In-Reply-To: <B0A9BD1B-B98C-4710-987D-03ADDBB993B7@quicinc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Jun 2023 17:45:05 +0100
Message-ID: <CAFEAcA8tCZ0shxEiA4hOVsHhOBvGmQ6HLJq1dPKDuSqBXKdtJw@mail.gmail.com>
Subject: Re: [PATCH] hvf: Handle EC_INSNABORT
To: Mark Burton <quic_mburton@quicinc.com>
Cc: Antonio Caggiano <quic_acaggian@quicinc.com>, 
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 1 Jun 2023 at 17:00, Mark Burton <quic_mburton@quicinc.com> wrote:
> This patch came from a discussion on the KVM call the other day.
> It may well be the case there is a better/different implementation
> - so the patch is more by way of asking the question.
>
> Re-phrasing your question - I think it boils down to =E2=80=9Cshould HVF
> (and KVM) support executing instructions from IO space?=E2=80=9D.

I think this falls into "might theoretically be nice but is
probably too painful to actually implement". In practice
well-behaved guests don't try to execute out of MMIO devices.

> In that case, this is a =E2=80=98partial=E2=80=99 answer to providing suc=
h
> support for HVF - partial in that it relies upon a memory
> region being created =E2=80=9Cdynamically=E2=80=9D for the IO space that
> has been accessed as a side-effect of a normal access.

But nothing in (upstream) QEMU magically creates MemoryRegions
just because the guest tries to access them. Either there's
nothing there in the AddressSpace at all (definitely can't
execute from it) or there's already RAM (happy case) or there's
already a device there. If there's already a device there
then something would need to do a "put a bit of RAM in
temporarily, fill in the single instruction by doing an
address_space_read() to find the data value and writing it
to the scratch RAM, tell KVM/HVF to do a single-step, undo
everything again".

-- PMM

