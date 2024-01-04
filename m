Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F23682408F
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 12:26:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLLqO-00041D-Ch; Thu, 04 Jan 2024 06:25:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLLqJ-00040z-MK
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 06:24:55 -0500
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLLqH-0006eu-RO
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 06:24:55 -0500
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2cd0c151cdcso4728731fa.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 03:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704367491; x=1704972291; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r/GK4o5OBGhxdbLRiRvOnFlvZ8Tf9NQwOJLhvPc63W4=;
 b=uKmTS6q7iSalb42LYma/QiwHSeJv7NyWmJ2hX+1Ol6CfUUNUkh11e9JDCpF2EZP4Ol
 f403dNOpwQ9NkGjcmyRGPZ5xo3ACj+LIy/5PlkfMn/0aXNHjl3jXMx5uxZWADCqMjOsQ
 u14ETXJP9g4AsWSdDoCRRkOArE5P6p/1slmOYDgbukqF0QzqMvxceA4+7P0O2Bsl/eUs
 0tdied773IzO82OSnm0NI53uZv/6ZbxzSxpJhTZO4eGHzls8joE+XlXEFvF8IthpMW/C
 TSqv1OJlja6PUlfsERzb02C88rt4qtd3mkquWMtOiWoZ4/EJJD9/fnAX28aZYIo0aBaN
 dLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704367491; x=1704972291;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r/GK4o5OBGhxdbLRiRvOnFlvZ8Tf9NQwOJLhvPc63W4=;
 b=k41O62SCY6lgzFATxeW9bWbcBr2cpAw05/rmI/hpsknO5PI7vL3CfQs5JK50uqRAqH
 LxnIQmkrm8aO+6y8k/GH8GS9yYB9IfoozqH7VsJhEW9cVnKUZhO1oVz65/qDHvEyInDg
 wRfa+Dk3QHGKXrklCq0v8vEUAIO65wc+0jX0ucU88mQlB6WafLyjZdP8pEdb0eDXcJq4
 LlSD1gIeCm02mhuHKzcbfbMBMpxLUXlj8C4njJjIN98Mut1CaUGgtSDYnfgTjgg4hHV4
 eI06Jcvp1m+jfyHuAPwqv0a+FWoyUKuA830L8QiTqi5/8R6Mf/ld1cC1ZDPlxCq387t1
 O6ig==
X-Gm-Message-State: AOJu0YyjtUG/k5gVbrJNpHMRksmrT4xV778Pnk96rEdez/vsk5sdvIUy
 Qmc0NsJ7UXC0jVr6Dz+hDCz+kdmcnDAUAIJy1fM9SeYzGJVA6A==
X-Google-Smtp-Source: AGHT+IFr3X5BWCdrsxinuTM9q0V59nGG8Xlgpk9RfOSHBtZbwyOilnu8aG7HZslo0hqW9/7sCsbHtpp7CQyt+GBD3AM=
X-Received: by 2002:a05:6512:759:b0:50e:745f:b0b7 with SMTP id
 c25-20020a056512075900b0050e745fb0b7mr223863lfs.52.1704367491231; Thu, 04 Jan
 2024 03:24:51 -0800 (PST)
MIME-Version: 1.0
References: <20231221080858.12876-1-abelova@astralinux.ru>
 <0a9f5a65-5747-4575-a5a9-aa209799e096@linaro.org>
In-Reply-To: <0a9f5a65-5747-4575-a5a9-aa209799e096@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jan 2024 11:24:40 +0000
Message-ID: <CAFEAcA9DU7aZjzWc+fnMw14JupM6ff1=ChxaX3+kfGt3LBrP5Q@mail.gmail.com>
Subject: Re: [PATCH] load_elf: fix iterator type in glue
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Anastasia Belova <abelova@astralinux.ru>, qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x235.google.com
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

On Tue, 26 Dec 2023 at 12:04, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi,
>
> On 21/12/23 09:08, Anastasia Belova wrote:
> > file_size is uint32_t, so j < file_size should be
> > uint32_t too.
>
> file_size is of elf_word type, which is either uint32_t
> or uint64_t.
>
> Your explanation is not very clear... Maybe you want an unsigned type?
> In that case, does the following makes your sanitizer happier?

Since file_size is type 'elf_word', the iterator 'j' should
be the matching type. In practice nobody is loading 2GB ELF
files, so we don't really run into this, but it is a bug.

I agree with Philippe that it would be helpful if the
commit message:
 * is clear about the problem it is fixing
 * describes whether there are any real-world consequences
   of the issue and how severe (or not) they are

thanks
-- PMM

