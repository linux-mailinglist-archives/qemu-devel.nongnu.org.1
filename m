Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07410751FDC
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 13:25:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJuQd-0006WZ-0U; Thu, 13 Jul 2023 07:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJuQY-0006WM-Ef
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 07:24:07 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJuQW-0007s9-NH
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 07:24:06 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-51e4c868ee4so721732a12.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 04:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689247442; x=1691839442;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Jm0nL8dDHJcvUQ9gZ7vrlkdK2iTIymDxnhdto1Tbp68=;
 b=SkR7/OU3AA0/8A8giy9QdthfxrCNYbo6mhMQ/5mlpRPSCxWuv9D8UgDSJ+wgEViQKs
 dshFWpPRbp8NBUn1kf+WCwMFC95CBm3boRXN80/GqbI9QMzGVW2PkeVjXsuayuVv4XzF
 Xiab+B7k+6niJm2+aN2aYJhSy1Htus2IZVQ3KgNUWWzwhMcUu9jSoKjSO5irOI4dcHNf
 loO73oNS/AyHwPL/VOf19dK6Cs6kPTSAQFPn8g3gquV27wiYqHOa56KyjSojz2daf/EL
 oMnnLh8McgHMKvT6kiY6HB1lgvyNdo/kk4PnLugXG3vYBcn9cg2MUnHkKvhbi1VwtkpR
 BMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689247442; x=1691839442;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jm0nL8dDHJcvUQ9gZ7vrlkdK2iTIymDxnhdto1Tbp68=;
 b=L5N7BpHjLCjC3vMEWckDFKucoGT2OXO4YvLaCsFq9xHR609RErVNjFOl4bkwEOu2RF
 ZAphTBgKE506QvNo0lAqciZeVE9WQ2XMRaJT/fNUcjJ4zOLzRx0sNdAoIFudIg7FyX9J
 68iyIFEAbE9s5u7LCa/INdRHWh8KzrioZ2cAnbmT3tqNW+L/xNhqPPAVq38IYk9V+CPd
 oiIbXWQWuhy9TLyTaPRNRldYlcG58PN/sTZ0blUmTbEKKSJrPEqyBDqnzIpU5MkGf86+
 3sXL7xyjhz/8X11fn218eo1J5853HlNFFVuyOAZC2b+miHlornwg9cMxiQs6PsNA76HC
 6ErA==
X-Gm-Message-State: ABy/qLYUbRr3QP+A8NanQatQ+5H2KrLh0nxKWgLbTtDuT7sCK+zuMI9D
 rbwS6Xkrqti61Zh31Iteb93aHT9q55749YQ6Sr7gHg==
X-Google-Smtp-Source: APBJJlFXRATx1O2zsVNokS4/C46dVb2oOrcRgic8X1OJA334xevCcDzV7gCHFz6ZHLH23JAtQ4Hz0gKlW3fFkYsz0Pk=
X-Received: by 2002:aa7:cf0f:0:b0:51d:a94b:f8ec with SMTP id
 a15-20020aa7cf0f000000b0051da94bf8ecmr1571575edy.13.1689247442039; Thu, 13
 Jul 2023 04:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230706195201.18595-1-farosas@suse.de>
 <20230706195201.18595-3-farosas@suse.de>
In-Reply-To: <20230706195201.18595-3-farosas@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jul 2023 12:23:51 +0100
Message-ID: <CAFEAcA-_VD5w5ubznavt+5F6q9_LzhmmVFQyEwCj7JYSuxOXbg@mail.gmail.com>
Subject: Re: [PATCH 2/2] migration: Make it clear that qemu_file_set_error()
 needs a negative value
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Thu, 6 Jul 2023 at 20:52, Fabiano Rosas <farosas@suse.de> wrote:
>
> The convention in qemu-file.c is to return a negative value on
> error.
>
> The only place that could use qemu_file_set_error() to store a
> positive value to f->last_error was vmstate_save() which has been
> fixed in the previous patch.
>
> bdrv_inactivate_all() already returns a negative value on error.
>
> Document that qemu_file_set_error() needs -errno and alter the callers
> to check ret < 0.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/qemu-file.c | 2 ++
>  migration/savevm.c    | 6 +++---
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index acc282654a..8276bac248 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -222,6 +222,8 @@ int qemu_file_get_error(QEMUFile *f)
>
>  /*
>   * Set the last error for stream f
> + *
> + * The error ('ret') should be in -errno format.
>   */
>  void qemu_file_set_error(QEMUFile *f, int ret)
>  {
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 95c2abf47c..f3c303ab74 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1249,7 +1249,7 @@ void qemu_savevm_state_setup(QEMUFile *f)
>      QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>          if (se->vmsd && se->vmsd->early_setup) {
>              ret = vmstate_save(f, se, ms->vmdesc);
> -            if (ret) {
> +            if (ret < 0) {
>                  qemu_file_set_error(f, ret);

You say qemu_file_set_error() should take an errno,
but vmstate_save() doesn't return one. It will directly
return whatever the VMStateInfo put, pre_save, etc hooks
return, which isn't necessarily an errno. (Specifically,
patch 1 in this series makes a .put hook return -1,
rather than an errno. I'm guessing other implementations
might too, though it's a bit hard to find them. A
coccinelle script could probably locate them.)

The de-facto API for all these methods in the VMStateInfo
is "0 on success, non-0 on failure", because
 (a) we don't document what the actual API for these is
 (b) the code which calls the methods and tests their
     return result is just doing "if (ret)" tests

If we want to tighten this up to "return an errno"
I think we would need to
 (a) audit all the implementations
 (b) document the updated API in vmstate.h and perhaps
     also docs/devel/migration.rst

thanks
-- PMM

