Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9097C7826B7
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 12:01:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY1iJ-0004kT-RF; Mon, 21 Aug 2023 06:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qY1iG-0004k2-BV
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 06:00:44 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qY1iA-0002id-JL
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 06:00:43 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5236b2b4cdbso3961899a12.3
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 03:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692612036; x=1693216836;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TQmq06GMWHSdNiiKCUAmIvJDnDcqwF2FOPwyp7VOXrk=;
 b=tUUU/v4yR+nvrEuHPZ7v95UcRictpMjQZaBtjuftFG8ArYi+tbcLcC46SFqX90vNM7
 upQb98jw2zvXOm8jajItbEyoHtF392p2xxxKujO7euWRTk3KLoB3WQeFeGvHAMX/1Jyw
 oFMmFfhVMdOE7SUOxDodUpBMJQu/zkAJf+reT14gvStCxQihHEub78fjNdsS7GFh4Lgi
 qR7FTZ1Ced4bJ1xpdJoHC2UXKNxlcUu4x0skxiIyTGbr19lN016BqynA1qcB7BnzrRMF
 WmqfXfNIrUvFmSYkRhNahjixoRIAfKzu0TDJNewPh5E71BLPSvU40Y5mVS+mYMabi8hO
 FVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692612036; x=1693216836;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TQmq06GMWHSdNiiKCUAmIvJDnDcqwF2FOPwyp7VOXrk=;
 b=Gq/XbxhC/WK6/wSGoDqXwRYt/LDAYRYwuhlOb8f3DPVzTBrBNkuwSXSKLGy7ipL789
 Fm3lheyU4dyff9Mwt04krONbkFQHFTNCqfq42wENCQG4WWY0gKpOg8cHbv+bYYVWqzh5
 xNYI7LOX3bJLLezYl82MU245Bkv27Egt/Rhr6gEuSL/cVRh5FM4SdIKT6NiAUZqGTVfI
 rvAJSWYOHAgXZgofRZHtprPkoSqfs8CayLK6XCnS4ATUgryToYUBXJ9N75oy1QR11m99
 GOEWGehTHi6CrIFj2mqm6EXDIw+Ymw+0rexkw9+YJK6uA/Exioehe7AdeRTpCTwm05+J
 eQaw==
X-Gm-Message-State: AOJu0Yx8oDb2YMc+jesrClqZkPUrDKPX+rTnqVdo+erv6gKG0QmhLIuZ
 z9Xc86O7at4FE3df5LIuNQf+mIP78/sLyo0FVCbhHw==
X-Google-Smtp-Source: AGHT+IF8tUC+usJC27+5BDSrpcOy03/oqjkbDh0LrKzsdAk+oyY0UnKcfNyyG3IEo3DqGdKTot656pUORCkLb2lQ0sY=
X-Received: by 2002:a05:6402:545:b0:523:1400:2d7c with SMTP id
 i5-20020a056402054500b0052314002d7cmr3795039edx.35.1692612035979; Mon, 21 Aug
 2023 03:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230818155846.1651287-1-peter.maydell@linaro.org>
 <20230818155846.1651287-2-peter.maydell@linaro.org>
 <3689052.BXi5odulOJ@silver>
In-Reply-To: <3689052.BXi5odulOJ@silver>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Aug 2023 11:00:24 +0100
Message-ID: <CAFEAcA9Xu0CKUssomGNkXKsQaYf8avFsVobiM-CNOvBDbYOnmw@mail.gmail.com>
Subject: Re: [PATCH 1/2] audio/jackaudio: Avoid dynamic stack allocation in
 qjack_client_init
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Mon, 21 Aug 2023 at 09:01, Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
>
> On Friday, August 18, 2023 5:58:45 PM CEST Peter Maydell wrote:
> > Avoid a dynamic stack allocation in qjack_client_init(), by using
> > a g_autofree heap allocation instead.
> >
> > (We stick with allocate + snprintf() because the JACK API requires
> > the name to be no more than its maximum size, so g_strdup_printf()
> > would require an extra truncation step.)
> >
> > The codebase has very few VLAs, and if we can get rid of them all we
> > can make the compiler error on new additions.  This is a defensive
> > measure against security bugs where an on-stack dynamic allocation
> > isn't correctly size-checked (e.g.  CVE-2021-3527).
>
> Sounds good, what compiler flag will that be?

It's "-Wvla".

> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  audio/jackaudio.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/audio/jackaudio.c b/audio/jackaudio.c
> > index 5bdf3d7a78d..7cb2a49f971 100644
> > --- a/audio/jackaudio.c
> > +++ b/audio/jackaudio.c
> > @@ -400,7 +400,8 @@ static void qjack_client_connect_ports(QJackClient *c)
> >  static int qjack_client_init(QJackClient *c)
> >  {
> >      jack_status_t status;
> > -    char client_name[jack_client_name_size()];
> > +    int client_name_len = jack_client_name_size(); /* includes NUL */
>
> I would add `const` here.

Sure, I can do this. (I tend not to use 'const' except when
dealing with pointers, personally, but that's just habit.)

> > +    g_autofree char *client_name = g_new(char, client_name_len);
> >      jack_options_t options = JackNullOption;
> >
> >      if (c->state == QJACK_STATE_RUNNING) {
> > @@ -409,7 +410,7 @@ static int qjack_client_init(QJackClient *c)
> >
> >      c->connect_ports = true;
> >
> > -    snprintf(client_name, sizeof(client_name), "%s-%s",
> > +    snprintf(client_name, client_name_len, "%s-%s",
> >          c->out ? "out" : "in",
> >          c->opt->client_name ? c->opt->client_name : audio_application_name());
>
> Unrelated, but this could be shortened by Elvis operator BTW:
>
>     c->opt->client_name ?: audio_application_name()
>
> Anyway:
>
> Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

thanks
-- PMM

