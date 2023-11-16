Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C987EDFF6
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 12:39:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3ah2-0007pQ-NR; Thu, 16 Nov 2023 06:37:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r3agy-0007pG-VX
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 06:37:52 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r3agx-0004IK-Fl
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 06:37:52 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-540c54944c4so1351204a12.1
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 03:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700134670; x=1700739470; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fFIb0eNWa7fpnqgFWaLysV0InSZY9n58QKz0vVnxLZI=;
 b=IlrR+8zQqhDa/7HtaPOJ3OR/XPem+h5/MNxFxuecpRMumpyXX8rAMaBiyeii/PWAgI
 kB+YLc6v8qMuv05VQp1t6xMCwCS9spCCD27OCCCBJX9KhU6QAAc2uoU6TUQJ4nN+JPSb
 R5/ytxuzAKDWz/nTIm11K+avo0V13wKhm6Z3Wmoec12jpTyJjPbGIS3ob4uKgnvXQqZ+
 fLTVoMcqdWCtLGTHFLpPMSPIKwxvREV20qF9CqZf7h+WFW2j7G57OMb99v8L5x1mS0cG
 FoMdC3T11yzDv51LSHc9KZuZ5Wd434JASSztaS0DGsv91bUp6tqKQALF3jL5UJJZmH0S
 +yyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700134670; x=1700739470;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fFIb0eNWa7fpnqgFWaLysV0InSZY9n58QKz0vVnxLZI=;
 b=lSS04+BxBl3LQPeWSfZelmPsBBAgAZYSVZTB1eNwNRQ9hCYuVqt4UnHswaqACMdlwj
 /Rs8TGtN6DzWoi5PIZUUu2YmrE9FAOTs3D4gcGNWTyW8qx5xeCs32bTkSLzXceMcFkI5
 OdlR8bFgL4syy9ndub2i9beCDD6MzXTPukoYYVT0c6p6odLQfFTwCysSVimB8bfrYKgM
 WZ/uStS0mbM2w/kDexvgkCPzw7pca0QJRP9mDhvPJ6znObNQns2elA5aip8L7zl991hB
 d2dpqjmZ0ebMuNbG+S7k8pZisxpeRB+4OHA1T5g20n3f5vOC72/Wa1YrtyH8AJ5G3aSM
 +nZg==
X-Gm-Message-State: AOJu0YzEELy7KIFoNRmw47KKsXg8HKMmdPtLMtlN+UE3tdVYZC4C+6ue
 KyVTghX+5smapDxzxH/BHnVmeLgbxbHu7FiFDLvH3g==
X-Google-Smtp-Source: AGHT+IGdGlk8RJ4SRgTIlpoD2yDIhJrYO+OCn9HPsaFmWc/y469MivEa9stC+0DE+SM9/Sh/GklaA+5ZAdzL4ykjSM0=
X-Received: by 2002:a05:6402:4410:b0:545:2fb3:1ac6 with SMTP id
 y16-20020a056402441000b005452fb31ac6mr1875571eda.2.1700134669763; Thu, 16 Nov
 2023 03:37:49 -0800 (PST)
MIME-Version: 1.0
References: <20231114130415.283228-1-thuth@redhat.com>
 <CAFEAcA_LcmowH28KG9LXRQRPFkAbmDCoPz5RDDK0TG+Am-p73w@mail.gmail.com>
 <e04933cf-1c74-4475-8007-888d9d0591f2@redhat.com>
In-Reply-To: <e04933cf-1c74-4475-8007-888d9d0591f2@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Nov 2023 11:37:38 +0000
Message-ID: <CAFEAcA9Y=H6qu2+s8Aj+K+D=UC9Yw9wf4BHNKV0Rkt=pNDsYHg@mail.gmail.com>
Subject: Re: [PATCH] qom/object: Limit type names to alphanumerical and some
 few special characters
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
 Eduardo Habkost <eduardo@habkost.net>, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Thu, 16 Nov 2023 at 11:17, Thomas Huth <thuth@redhat.com> wrote:
> 2) #define TYPE_RAM_DISCARD_MANAGER "qemu:ram-discard-manager"
>     in include/exec/memory.h ... I believe it should be OK to
>     simply rename it, since it's about an interface type...
>     Or do we use these interface names in migration streams, too?

No, QOM type names are separate from migration stream section
names (unless somebody has explicitly set the migration stream
section name to be the QOM type name using ".name = TYPE_WHATEVER"
in a VMStateDescription struct, which in this case they haven't;
and I'm not sure that even the VMStateDescription names end up
on the wire).

It should be safe to change the type name string here.

thanks
-- PMM

