Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 795D67E6E37
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 17:06:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r17Y6-0002Qm-0M; Thu, 09 Nov 2023 11:06:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r17Y3-0002PY-AZ
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 11:06:27 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r17Y1-000247-QT
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 11:06:27 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-53de0d1dc46so1705573a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 08:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699545984; x=1700150784; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=muGKjYCDRThkEg4VQKCUFNvg9fzbf7hYVXadPFc6UKY=;
 b=Wu4lvrJJHSmcLGJ8NnyTuiAsp+fg55k9lcKD1+pPtnb/JSM1+1roIuIwJrVEUY5xFs
 OrQibivuNPA0vr+naIFkuIWXMLE+cZq9ovTzHOUoWLN8toT1Xs4yBWJrnD8QsYTsdbRC
 7ZD2XYZkE5pKbY+v/iucdtjgp5pvCrGfOisaDezoSWMuViU9KfkbLzqm6x4MSBsqIg3F
 iYJkU3RxPovVO481EEiAQkpOxCc5H6omJc+Y4P2UGCcZHat+4MYVV+aZdvbO3Q4/1UR7
 AIcdE+G2Rxc9vWOrLnkFzyCTWQHCUl2riIzbWBy4YevSgZQbNpg+SfMJ+crjBl1XHok5
 A8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699545984; x=1700150784;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=muGKjYCDRThkEg4VQKCUFNvg9fzbf7hYVXadPFc6UKY=;
 b=ZvcGCay7NrG9yyY/SWPk3wy+Q9s9HjlN53+rIGC7Okkn7uq0wOqjVHMcTS3S2V6cWz
 3W4N9FLKaMDIymeubpOvgphCfk15jY+NQ3thWmrLOkphEBLXBdYPwtgzys9RgqvcXJ48
 m2n6qjXOWk3VXPD625WoLaqq8WrfW2ZyQP0hVfq0HhDoeMz0oIFbowZeI1LdxxQ+yXDf
 67o3kGD7ujhWOFpL1ZWdO2bDEef6MZcyxkLE33hQMphqQWOTP6UbaevBD353dqwu85g/
 i8fgfkhrT+4S+djtgPS/xJRJpFX/jRpZQpjX9WJ3Z97jvCp+KV1WGvIXlKVxWnNLlg8f
 YBZg==
X-Gm-Message-State: AOJu0YzGxU0bXIslBZT5q6QbQzM5DKD+rwfYbM1UT8/BKJ7Vqv5bH4Ar
 2DBwJrP8sTsSu7qqU1RR91pJpwS5+wK2MlcEyZzQGg==
X-Google-Smtp-Source: AGHT+IGt6J1Ma9H3JqhlJtbqxuL2IDdF3ulTnRLLiN5LHRH8uWWVNUTseFLsq1AcId74eVYXNZWhghzX/ujd6tw8K3A=
X-Received: by 2002:a50:ab12:0:b0:543:5927:f969 with SMTP id
 s18-20020a50ab12000000b005435927f969mr4254527edc.3.1699545984249; Thu, 09 Nov
 2023 08:06:24 -0800 (PST)
MIME-Version: 1.0
References: <cover.1699351720.git.mst@redhat.com>
 <2880e676c000a62828d3d9ece7b2ec7a513560a2.1699351720.git.mst@redhat.com>
 <CAFEAcA_TS-B0gc-DUYT6BaKnm8Uauhsx3rW2dmVNUgTToVjSJg@mail.gmail.com>
 <CAAjaMXYV8DVZhzFi-EH-iNdB8bYYQoF2bgM_ACjJTM7Lz3=EPQ@mail.gmail.com>
In-Reply-To: <CAAjaMXYV8DVZhzFi-EH-iNdB8bYYQoF2bgM_ACjJTM7Lz3=EPQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Nov 2023 16:06:13 +0000
Message-ID: <CAFEAcA8t7uHiQ59mN5aW491jXg4Wp8fE6qgS3t6G+ejG7gUyFw@mail.gmail.com>
Subject: Re: [PULL 08/63] Add virtio-sound device stub
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, 
 Igor Skalkin <Igor.Skalkin@opensynergy.com>, 
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Thu, 9 Nov 2023 at 15:51, Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> Hello Peter,
>
> If you want me to, I can roll a new version, otherwise I have attached
> an updated version of just this patch, adding an if check.

This patch is now upstream (which is why it got Coverity-checked), so
you should submit a patch against the current state of git 'master'
that fixes this issue.

thanks
-- PMM

