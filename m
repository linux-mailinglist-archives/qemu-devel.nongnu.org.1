Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED5F70712B
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 20:50:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzMCe-0002iU-El; Wed, 17 May 2023 14:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzMCa-0002hX-Vv
 for qemu-devel@nongnu.org; Wed, 17 May 2023 14:48:46 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzMCX-000493-NF
 for qemu-devel@nongnu.org; Wed, 17 May 2023 14:48:44 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-510b7b6ef59so2063320a12.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 11:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684349319; x=1686941319;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LX9wLiM9yAAxooiKOT7JezegrL3riEfeKVPFQxWEW1s=;
 b=v3bNpEpm2vkifpx5daH8e9ekINYIp/qCWhRBvnfwShWwxJtMAlV9sxKL1/a302K1DE
 iJJDElimGcxGud6NeGPnC0MHw0qsoNt2rYyqYEeEalUslkbRmUQ/m/aBGhutd6r5+tIN
 tIfDHLVz06vvjJFm0jaAintP5mVIkYm1LFiL5st4P91G3Ly0xCA4nJ4IKPDeG9rAjXif
 ZnhSLHWHnKQhPKqi58D8Q1AcWbk/lifjM9buvZYgWyEbfGTYguYBY2PcQmKAoUc1RjO6
 er0Fgy6k+oMfFaiHEidBtrUL3FFbEX7CKatQQJ4XOgj/7zrtfIZOraCHS1HoGruWE6IQ
 THbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684349319; x=1686941319;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LX9wLiM9yAAxooiKOT7JezegrL3riEfeKVPFQxWEW1s=;
 b=OrxO+I0JaSKMuaZBGOAObAIMnajH5fzqocGUy6pJDJyMPs9wocAhL/1Gqg8MKjo6gR
 na4Oe/gSEA36ffpdKIVEdo+LOUsJ62oSKn90tavUvaj8XTVNKUQ4lsKJ8R1K8EFpl3xp
 1a91eMzeFql+/ZryoD/Nflt9sASlR09hrvFN85rPNr6EDl7AQPTTqwk/wB/hAvIjnLzp
 XofEiB9/+79JcumfNU7SsqTwPv3OPfs+pE0R7v3In5BzaKTrSjSGp40LrGHcLH2+icRA
 6rlFErfgfdEy/VyIKX603WsljV2Hy3MY7bW8MFZ3yeGFfK3ARkwXiTBXSevyo2LD95S1
 s2IQ==
X-Gm-Message-State: AC+VfDyHVFNqFHESE44si+mTmcLesnH94GQnWi9JpWojW+kHffcitI87
 lIzf445dnefMhOLXdX11svMLTRtMhos8fI+RLRVTew==
X-Google-Smtp-Source: ACHHUZ6FrlQxvWNSQx7KF/xnST80/iS/SbMndbyIenPDI8U2w29V72mqbZhloi/wUYOKT3GpP5eK83zs4oGnXLkKGgI=
X-Received: by 2002:a50:ee99:0:b0:50b:f7b2:79d0 with SMTP id
 f25-20020a50ee99000000b0050bf7b279d0mr3316507edr.31.1684349319379; Wed, 17
 May 2023 11:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230517174520.887405-1-pbonzini@redhat.com>
 <20230517174520.887405-64-pbonzini@redhat.com>
In-Reply-To: <20230517174520.887405-64-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 17 May 2023 19:48:17 +0100
Message-ID: <CAFEAcA8851_6Ye_sQ-wA85HSzwRTQvMw_Ahmh9E5XafyOwwq_g@mail.gmail.com>
Subject: Re: [PULL 63/68] configure: remove compiler sanity check
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Wed, 17 May 2023 at 18:50, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The comment is not correct anymore, in that the usability test for
> the compiler and linker are done after probing $cpu, and Meson will
> redo them anyway.

The other thing this check is useful for, though, is
providing a helpful error message rather than using
a busted compiler for the other compile checks that
configure does and then producing a confusing error message
when some required-item test fails. (I think traditionally
this was the GLIB_SIZEOF_SIZE_T check, but we may have put
some other tests before that in the meantime.)

-- PMM

