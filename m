Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A826E770727
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 19:32:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRyer-00030R-NA; Fri, 04 Aug 2023 13:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRyen-0002zb-CD
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 13:32:09 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRyel-0005cM-Sl
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 13:32:09 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5217ad95029so2927870a12.2
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 10:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691170326; x=1691775126;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MKX+r86oN0XWzBbrq9duCjlqZuPPIl3Tcvsu5wC7wY0=;
 b=oBlzJZfKXxrC57AwjuPZQSBAz8jiFvzRojnOdvtJGsEAxcz3x41IBFrJvvQNDTSHzu
 LK+4y0gHDaqwI51+SPxRlMdeCHzwoUWOzU5WmGJNy7Lo9GwaQph0lBLQU7xAPXiZZ0Ja
 IIKO4E9uLXdE8LVQl2DbRcqteudF8ZV6i3yQ2Fw/PlRVwVPMHdTqLPEatJ3AXEZfGRuP
 fqm4+a2me8IX8NpI08TdAw8S8b+OH4Ox/picAA48zK+WipqDW/Se0maONzZeJw7TrNpA
 5RsQ2vEd1C/1k4Rdr88O6lc2bDQNNQoZIbSeglVKv6EwoLsofryrrGxdXzaN/LCUzrn+
 ArfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691170326; x=1691775126;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MKX+r86oN0XWzBbrq9duCjlqZuPPIl3Tcvsu5wC7wY0=;
 b=Dre+pgTdGO/VraOeuGLBMFQW8JdFEkqZEujKws2a8sLawsfxJgpl+nOdm3CUuKlHn1
 6CeW2zUxhE0HfItclFZpmpAf/GjGsCuweRXFAq55AHPPHSV6KyCSy51TGtEExa1GjKd0
 9Xtg8BnSczmV8ogtw4s73dd6rLFJNpr90Mm1enZ4c2NS/9cyHCOPYmkrGXsfN6WpBBM5
 X3QjJxSQvePJKbxtD1qF9YEMro7o4CxPunMHjFReCVn0PRXoy5+voxT71zMqKedvwLnP
 u5CBLvNz4BOyuzwEXt7VV9CKLSnj8ocpREmevDcRMvGK3zZMthGsXh+Q4XY2sJOlxTWF
 iJfA==
X-Gm-Message-State: AOJu0YzUdbKNYXZ2sc+SrCO+UDy9DvOt5WTUCvW7nhHqsqd5cM8Rtqt0
 1nv8N+ccMcnsGG4t0dqTH3prGW3xwoHlFXL0ClWTyA==
X-Google-Smtp-Source: AGHT+IGdMfiyG++dzHGUSw/tvCVSSbUouSk5Pxs1nt1hiUSQ534dlVQfrvYDr4E9qUkx0O1kupyFg13HYb5RfFI+Fdo=
X-Received: by 2002:aa7:d745:0:b0:523:1400:2d7c with SMTP id
 a5-20020aa7d745000000b0052314002d7cmr1857681eds.35.1691170326260; Fri, 04 Aug
 2023 10:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230727073134.134102-1-akihiko.odaki@daynix.com>
 <20230727073134.134102-7-akihiko.odaki@daynix.com>
In-Reply-To: <20230727073134.134102-7-akihiko.odaki@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2023 18:31:55 +0100
Message-ID: <CAFEAcA_=ZK6vbq+73N_R3D1a--amOts71RjbjmmUUQ_yCS8bKA@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] accel/kvm: Make kvm_dirty_ring_reaper_init() void
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 27 Jul 2023 at 08:31, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> The returned value was always zero and had no meaning.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

