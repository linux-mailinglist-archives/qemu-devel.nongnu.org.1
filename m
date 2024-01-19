Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAFF833102
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 23:55:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQxkb-0008Iq-3p; Fri, 19 Jan 2024 17:54:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1rQxkZ-0008Ib-1Q
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 17:54:11 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1rQxkX-00032n-Do
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 17:54:10 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a28fb463a28so130148466b.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 14:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1705704847; x=1706309647; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=joD87CEJTxTSqpnu6obhzuVqEcLBoJCcPLOOrv/3Ah8=;
 b=FhlLCnyA9Q/xEiDND5ER6qEs6sD4TQZtYCmGPKNQOi3cYcfxD6+xxBolOhaKSUohGN
 K/2PzvULJzv4QiK47TOQrWBendRBNHVwrmIfPG1bSbSWqP+y/fSRumH1K4t9puLyfzp4
 O9JFZnQi3VZy12wzxt5VBiECtr3ig3yxbpKbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705704847; x=1706309647;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=joD87CEJTxTSqpnu6obhzuVqEcLBoJCcPLOOrv/3Ah8=;
 b=TC1bsxVwhc9/4Qq8/Ey1eIboNJLdBL20vQFaMmmbadvQGuFX/zlYyNyga5KiGRFMe3
 mzCpry2KNhq7QM22JoXFbevM6fqkrv8ZYPunhMn0nlUfUJl91U/cbcV5OiYLbV/SPKWv
 jRt/UOawYYY/RIHIn7a+lYggnGhYfU3KkwgUM05UHZeVoXNSpCmnbnuBzT3jZQXAHsnZ
 elc9P51eIGzcG1yXWL1RGR6J6lcuabaIkSvS19jWftGU62UIQDrBgDbCA8YKkYtkWlr+
 f8eErUZ43mKAGufvA0TxAQr0KzAxi4MPl+C6YsU0THkAo6mVVhtyR20ddr2ma8xZIE0k
 M2CA==
X-Gm-Message-State: AOJu0Yy6fIO5x5Oxx6XxukxwOS3gBVLBaYQOkcm+c7okuboREOiyZvrL
 2HQJjEPLv4joUG2fmuYqBF0NpAxAC9Kt4t6Vs1KsxeEMAB5cgKRr8lNAIvaj7VLVqgbzEpG38cY
 UXQ==
X-Google-Smtp-Source: AGHT+IGDx7RoIBeQfOZaJrlmaF7FkrB/q/mOYxPjzi06KkYIX7C+Tf3KKn1LPLtUdOo1iykxfsKdGQ==
X-Received: by 2002:a17:906:3ad8:b0:a2c:551e:6278 with SMTP id
 z24-20020a1709063ad800b00a2c551e6278mr246165ejd.9.1705704847102; 
 Fri, 19 Jan 2024 14:54:07 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com.
 [209.85.208.50]) by smtp.gmail.com with ESMTPSA id
 o19-20020a17090608d300b00a2adc93e308sm10734293eje.222.2024.01.19.14.54.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jan 2024 14:54:05 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-553e36acfbaso4233a12.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 14:54:05 -0800 (PST)
X-Received: by 2002:a05:6402:370:b0:55a:7d4e:c075 with SMTP id
 s16-20020a056402037000b0055a7d4ec075mr65121edw.2.1705704845239; Fri, 19 Jan
 2024 14:54:05 -0800 (PST)
MIME-Version: 1.0
References: <20231003204500.518-1-gurchetansingh@chromium.org>
 <87wms9d0fi.fsf@alyssa.is>
 <CAAfnVBmiaesEQkZOk4zf08JTh-WM3tqNT8RoyaL=49Lm--5HSQ@mail.gmail.com>
 <87cytxni1n.fsf@alyssa.is>
In-Reply-To: <87cytxni1n.fsf@alyssa.is>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Fri, 19 Jan 2024 14:53:52 -0800
X-Gmail-Original-Message-ID: <CAAfnVBmV3m0-Kh5gcrxzQXotEQ9ktXfEhJr92XAMKi6rXXkuOg@mail.gmail.com>
Message-ID: <CAAfnVBmV3m0-Kh5gcrxzQXotEQ9ktXfEhJr92XAMKi6rXXkuOg@mail.gmail.com>
Subject: Re: [PATCH v15 0/9] rutabaga_gfx + gfxstream
To: Alyssa Ross <hi@alyssa.is>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, 
 akihiko.odaki@gmail.com, ray.huang@amd.com, alex.bennee@linaro.org, 
 shentey@gmail.com, ernunes@redhat.com, manos.pitsidianakis@linaro.org, 
 mark.cave-ayland@ilande.co.uk, thuth@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=gurchetansingh@chromium.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, Jan 19, 2024 at 1:13=E2=80=AFPM Alyssa Ross <hi@alyssa.is> wrote:
>
> Hi Gurchetan,
>
> > Thanks for the reminder.  I did make a request to create the release
> > tags, but changes were requested by Fedora packaging effort:
> >
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D2242058
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D2241701
> >
> > So the request was canceled, but never re-requested.  I'll fire off
> > another request, with:
> >
> > gfxstream: 23d05703b94035ac045df60823fb1fc4be0fdf1c ("gfxstream:
> > manually add debug logic")
> > AEMU: dd8b929c247ce9872c775e0e5ddc4300011d0e82 ("aemu: improve licensin=
g")
> >
> > as the commits.  These match the Fedora requests, and the AEMU one has
> > been merged into Fedora already it seems.
>
> These revisions have the problem I mentioned in my previous message:
>
> >> The gfxstream ref mentioned here isn't compatible with
> >> v0.1.2-rutabaga-release, because it no longer provides logging_base.pc=
,
>
> rutabaga was not fixed to use the new AEMU package names until after the
> v0.1.2-rutabaga-release tag, in commit 5dfd74a06.  So will there be a
> new Rutabaga release that's compatible with these release versions of
> gfxstream and AEMU?

Good catch.

One possible workaround is to build gfxstream as a shared library.  I
think that would avoid rutabaga looking for AEMU package config files.

But if another rutabaga release is desired with support for a static
library, then we can make that happen too.

