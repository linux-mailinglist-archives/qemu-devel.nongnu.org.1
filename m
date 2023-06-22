Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0F573A193
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 15:12:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCK6v-0007rd-Mo; Thu, 22 Jun 2023 09:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCK6t-0007rQ-7C
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:12:27 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCK6r-0008Ke-Nv
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:12:26 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-51bece5d935so445090a12.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 06:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687439544; x=1690031544;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SA/vJ+l8fw/3erSXBdeD5XJaOhP7w1IQ/WvPiGWpej4=;
 b=v59WapG6leh1rE7BRWhskTnfIt7qdPr0QNYzwqi/sXsb3VRgnVKJBbnM2jBsaomgaK
 OP8HKKdzo2L+XQeZA7CHe3/hO9p5sF2QyU+I/VgSL9TmN4cmF1EalHCgonI40jFnv08g
 R8GI5GiFgTPl1D6myNvQoeeG/a/xJWGzfl4y2KtFgEtsM3ZJ4VdDPmk/R+3AtQ22IOtI
 QXMGC++MDs+VN77AFdfQrMsRHxr02hkCP/5wgVTSNgGCstkabxwfzOmvKEOwF775nWYU
 ns1AtQYTQT8Px+c/DUiBuM9Ye/HG7r5lbPo1rcuOx3YCHrcS54oUJ++LzFi9Tbc0aYUD
 c3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687439544; x=1690031544;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SA/vJ+l8fw/3erSXBdeD5XJaOhP7w1IQ/WvPiGWpej4=;
 b=c+K7Tl8QWweaUuB85e9zE6lOTik24g1Tvs5sq8EzV6LF04vSShmuc9liQ2RwDx0/IT
 OK59+6wb3ClYLQ1vhuKYD0ToqSOfJE/YRl2CjgnNLt8pitTAh/MvhEQetTR/JWzMZ0Do
 IZvkJsJLxqZsj2K9BIUzar7OsEmSUlzPu0pVj2SEEFxneb47mBUdtRkreNtDKrQ2rrEs
 UcQg3olRloSjoLUVDQ2fweGq2czTOwvUfx0u3waufo2rpYHyxn3xnUbtyP/ac/CHohde
 eAtc96nVd5kCK8o1AkC2hRhBj3G/ytiu+MjVEJRvsBZVmwk765K2WyfYe+bTN8DH8nsx
 KmHQ==
X-Gm-Message-State: AC+VfDxoBxjUhKFxQk33BX8hYRp1H+3zS0PTS5ar+5+7+ND0E28KUXwZ
 pWmc57weJ6GwjMfIin7u1Sdyt0kVjLdY5zdBAuGYdA==
X-Google-Smtp-Source: ACHHUZ6hdY9cQJ1Jceqn1pX0tfSBzc1+nIhKcyY+JGR1wkuifQdFb0G+4zX7tUSafOMTj6TQDUexYFjQ3Hb1NQNFePo=
X-Received: by 2002:aa7:c48b:0:b0:51a:4975:f515 with SMTP id
 m11-20020aa7c48b000000b0051a4975f515mr11553653edq.38.1687439544203; Thu, 22
 Jun 2023 06:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230620195054.23929-1-lvivier@redhat.com>
 <20230620195054.23929-3-lvivier@redhat.com>
In-Reply-To: <20230620195054.23929-3-lvivier@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Jun 2023 14:12:13 +0100
Message-ID: <CAFEAcA_r31PU1LRka36dSJ6vZ2boP33MB=Ns5hDMRrSTN1Lmag@mail.gmail.com>
Subject: Re: [PATCH 2/2] tpm_crb: mark memory as protected
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 jasowang@redhat.com, mst@redhat.com, David Hildenbrand <david@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, marcandre.lureau@redhat.com,
 eric.auger@redhat.com, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Tue, 20 Jun 2023 at 20:51, Laurent Vivier <lvivier@redhat.com> wrote:
>
> This memory is not correctly aligned and cannot be registered
> by vDPA and VFIO.

Isn't this a vDPA/VFIO problem? There's no requirement
for RAM MemoryRegions to be aligned in any way. Code
that doesn't want to work with small or weirdly aligned
regions should skip them if that's the right behaviour
for that particular code IMHO.

> An error is reported for vhost-vdpa case:
> qemu-kvm: vhost_vdpa_listener_region_add received unaligned region
>
> To make it ignored by VFIO and vDPA devices, mark it as RAM_PROTECTED.
>
> The RAM_PROTECTED flag has been introduced to skip memory
> region that looks like RAM but is not accessible via normal
> mechanims, including DMA.

You can DMA to a small RAM region if you want to...

thanks
-- PMM

