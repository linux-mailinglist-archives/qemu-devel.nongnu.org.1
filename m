Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 130B4ABC4C4
	for <lists+qemu-devel@lfdr.de>; Mon, 19 May 2025 18:39:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH3We-0006wU-Ln; Mon, 19 May 2025 12:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uH3WY-0006Yl-E6
 for qemu-devel@nongnu.org; Mon, 19 May 2025 12:39:34 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uH3WW-00064p-0f
 for qemu-devel@nongnu.org; Mon, 19 May 2025 12:39:34 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-70cca430085so14837557b3.3
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 09:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747672770; x=1748277570; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cw99MtUfdTaJBGWZodRP45DuFy8O+qjyWzGZDSH7gRM=;
 b=BOXKQwq1mrDlerLHFtRHoPOfvK8R4GkdohSP6q1uuO9O7XAV2NP+jpO4V2btY+X9uR
 Nm4oslEy+cwzgEBUd1O36C/uj5M7lnLlPJgXt4w25fI3rypY0ZmURdPffyCjJSOq5vTg
 QvQd095AszmjQ1oPPC+NHwW91VXc5P2QQg7o+SAE/DqKAEgd+Cy9MP9KMo6th74FL8FY
 9k7zEZmrVDbkZLuW7QAFX601U8Yq+84RFihJLuHUEc1V7VSI2k2hznDhgmDMSAJRGcpp
 wm6aGwKBE0le4TEP6+hLZ14QBxbshx2fc6OZ/nFBIViVnCRq+tr9fONL6sxkVTpdExFN
 bXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747672770; x=1748277570;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cw99MtUfdTaJBGWZodRP45DuFy8O+qjyWzGZDSH7gRM=;
 b=FCCUGU8X5mi65sy08v5yyScZThC31AisPOgIQ91SItd01OAdKs4K0xDHED1WX5ngIS
 qgmRp+wO6gLGcigknAFb/AGWjoCluJrb3dT2TciW5MKyXwGuFJnrgE3YckN3RMJzorNL
 N8BB65L6r7WrqNOmXvD+O9OcLrnv5bXBdn4ANz2Evi7buMS828zu6mQArIVBsHT74K6i
 J1L6ET5+4TFFnliEASIF1dpgTYZB4QmtZglnAjiX+WcQ5QjaDre4ZBwM0DCiW01f3ISh
 gTVxuhs0Iin1TSTvaaZTYHcIq4g/MsuBhsbxZfvecIEJEDOWaqqHgfPGwrc1pjHIZ1o+
 9J5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWD2hPjHKCeSj7Nxf2wVF2pr/QUl3GRXbbt8SZL9MD3+BiNyCbLjhCYJKwodiKoSL1Iw3nsHyh47DTU@nongnu.org
X-Gm-Message-State: AOJu0Yxok8qTd+RRpj6gA/6JpzOUZiWIJjBvlKK28eRatuw782I/y7Ld
 2T/ikS7ZIWB8r4uTUYFOEBgUKoTXdeF7TEbDaxNffwwUvt3RbM/30sj3bceFlzr3e+1Dqx/iTvh
 I1OPOC1duF/+dgf3VRyMQbrgjxQLrTSl8c71zgkemwQ==
X-Gm-Gg: ASbGncuNgplZjspxTJfzHJfxT+rnld+dwRaEx5t4e/zB8IRg0vtPFvWojZCbobVAX4J
 ExPqQKpqoaQOIAAXQrqMxzGu85bN0ucf5PKNE6YJZgMTFvhk1URBYZKyDCzJ+leTfhBKpGteH7F
 8HAyGrJjPBc+pWndAHlqDOpkoIofjAt84GPQ==
X-Google-Smtp-Source: AGHT+IHfNgR0uMU7kdx6aencHuFMtxxi25g3gKyF2NXrgXF4FNxL6X5crzwTNOqjXhQIElTK5rs7rGAgPa0yRrd4Pxs=
X-Received: by 2002:a05:690c:5086:b0:708:c37e:6269 with SMTP id
 00721157ae682-70cab10984cmr158490467b3.37.1747672770051; Mon, 19 May 2025
 09:39:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250515135936.86760-1-berrange@redhat.com>
 <20250515135936.86760-3-berrange@redhat.com>
 <87ldqsr2fq.fsf@draig.linaro.org>
In-Reply-To: <87ldqsr2fq.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 May 2025 17:39:18 +0100
X-Gm-Features: AX0GCFtgRl4IgZtW6M3F0QjC17ZXt8YoyRz-Gyk5_uIddmupptk6pWBBmd1jGn4
Message-ID: <CAFEAcA_t_Hm+ijLpQrabZ2YeoHjk0Sea0daotWr-DFQegz-QtA@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] scripts/checkpatch.pl: fix various indentation
 mistakes
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Mon, 19 May 2025 at 17:27, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>
> > Various checks in the code were under-indented relative to other
> > surrounding code.
>
> Are we accepting that we have hard forked from the Linux checkpatch now?

Yes, I think that ship sailed some years ago: we've never
done more than try to port some specific kernel commits
across to our version; we've not tried to do a sync
to the kernel's version of the script ever since we
first imported the script in 2011.

thanks
-- PMM

