Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A565C832E64
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 18:53:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQt3L-0003Hp-DV; Fri, 19 Jan 2024 12:53:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1rQt3I-0003He-3W
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 12:53:12 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1rQt3G-0004Tk-BB
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 12:53:11 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40e76626170so11058645e9.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 09:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1705686787; x=1706291587; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=axyLgFdo3SkFiBQBMs8p0RGIUChbsdr7UT58XJRSXHs=;
 b=VWquy3SzPibxq2LbZZv1h6PBG4AJBbvNH4DsoWn8aQia4FhDKsLf1pQHQmYM4H6+S8
 FgEXQIyX6fG8PuZPFVcddJ9O5NIt9+l/veqp0EFEkcBrdl2H8/FJUpxenqrHtjREBnY2
 DRCWUasH81VqiUEvRFNy3sxTOetvx4zBvJE40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705686787; x=1706291587;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=axyLgFdo3SkFiBQBMs8p0RGIUChbsdr7UT58XJRSXHs=;
 b=coRl4m3tRltErgy3Gv1RcitPHJGkwb2uL2l5jLHfOETyxxhDF340oilwFah7x3aOUb
 qajtwllX1XMJzEaCEPFNQJhvpKr2lYyFjv9FSPD3fGmd9QvlZ7D0i25fY+19xaNzYMrX
 2bz9fW6Ipg4hPMvKodLJXxX+ZQb5kO9VTzs7HEHhM+iybJaYbJlsD5+Tc8U/gE0ixFLW
 FQ/fp0btGiRFLOiXacriaYJSGrRKy+d7eud2NjkbZJjh3IbHKEzlEsx8RYPE5OGUvU9h
 ab5T4qdoFB05f4KdVfRm0O4OHNI+XRTchpU9qmUpqVrZdGfWtALzR2HHs58FkgRhsmOI
 EWEw==
X-Gm-Message-State: AOJu0YylHTxl6nluOf3PollqxUOMf0JthCp2yssWWFIgHJFxIxotvSEQ
 wFPY7afcqkSjBJ+58pyO41ZJoXu7d3rHJY4jq5y4kzEJQd5Z+yFDRM17oVkWm3xAbmbSXhLcKkS
 54g==
X-Google-Smtp-Source: AGHT+IGJ9k7Y3LjG3criYldcau8k3PAnlmxH8QoSWTi6/kclAd3uANJ7HRQzkHkvBkSjEk+z/164sw==
X-Received: by 2002:a05:600c:46d3:b0:40e:74fd:51f2 with SMTP id
 q19-20020a05600c46d300b0040e74fd51f2mr68636wmo.23.1705686787259; 
 Fri, 19 Jan 2024 09:53:07 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com.
 [209.85.208.52]) by smtp.gmail.com with ESMTPSA id
 7-20020a0564021f4700b00557de30e1f1sm10877595edz.74.2024.01.19.09.53.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jan 2024 09:53:06 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-55a62fad701so111a12.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 09:53:06 -0800 (PST)
X-Received: by 2002:a05:6402:3126:b0:55a:465a:45a5 with SMTP id
 dd6-20020a056402312600b0055a465a45a5mr2699edb.4.1705686786702; Fri, 19 Jan
 2024 09:53:06 -0800 (PST)
MIME-Version: 1.0
References: <20231003204500.518-1-gurchetansingh@chromium.org>
 <87wms9d0fi.fsf@alyssa.is>
In-Reply-To: <87wms9d0fi.fsf@alyssa.is>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Fri, 19 Jan 2024 09:52:53 -0800
X-Gmail-Original-Message-ID: <CAAfnVBmiaesEQkZOk4zf08JTh-WM3tqNT8RoyaL=49Lm--5HSQ@mail.gmail.com>
Message-ID: <CAAfnVBmiaesEQkZOk4zf08JTh-WM3tqNT8RoyaL=49Lm--5HSQ@mail.gmail.com>
Subject: Re: [PATCH v15 0/9] rutabaga_gfx + gfxstream
To: Alyssa Ross <hi@alyssa.is>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, 
 akihiko.odaki@gmail.com, ray.huang@amd.com, alex.bennee@linaro.org, 
 shentey@gmail.com, ernunes@redhat.com, manos.pitsidianakis@linaro.org, 
 mark.cave-ayland@ilande.co.uk, thuth@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=gurchetansingh@chromium.org; helo=mail-wm1-x32b.google.com
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

On Tue, Jan 16, 2024 at 2:42=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrote:
>
> Hi Gurchetan,
>
> Gurchetan Singh <gurchetansingh@chromium.org> writes:
>
> > - As mentioned in v14:
> >     * AEMU: d6e6b99 "Delete VpxFrameParser.cpp"
> >     * gfxstream: 2131f78d Merge "gfxstream: add egl & gles deps.."
> >
> > are the proposed v.0.1.2 release points.  If those commits are sufficie=
nt
> > for packaging AEMU + gfxstream, let me know and I'll have official rele=
ase
> > tags made.  If additional changes are required for packaging, let me kn=
ow
> > as well.
>
> Were these releases ever made?

Thanks for the reminder.  I did make a request to create the release
tags, but changes were requested by Fedora packaging effort:

https://bugzilla.redhat.com/show_bug.cgi?id=3D2242058
https://bugzilla.redhat.com/show_bug.cgi?id=3D2241701

So the request was canceled, but never re-requested.  I'll fire off
another request, with:

gfxstream: 23d05703b94035ac045df60823fb1fc4be0fdf1c ("gfxstream:
manually add debug logic")
AEMU: dd8b929c247ce9872c775e0e5ddc4300011d0e82 ("aemu: improve licensing")

as the commits.  These match the Fedora requests, and the AEMU one has
been merged into Fedora already it seems.

>
>
> The gfxstream ref mentioned here isn't compatible with
> v0.1.2-rutabaga-release, because it no longer provides logging_base.pc,
> and this email is the last mention I can find of these releases.
>
> In Nixpkgs, I've gone for packaging gfxstream and aemu with your initial
> proposed release points, which works fine, but it would be great to have
> this clearer upstream.

