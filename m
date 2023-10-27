Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3577D97A1
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 14:17:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwLlC-0004ag-Ge; Fri, 27 Oct 2023 08:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwLl9-0004a3-QA
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 08:16:16 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwLl8-0006qZ-2E
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 08:16:15 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-53de0d1dc46so3382179a12.3
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 05:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698408972; x=1699013772; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+niAB94xkwrpIXtX89f78vV3+CT29Hlo7jQqkO4CSGY=;
 b=LT7FDkJ1DeRGe9/hxpgpeclFa3PktcPDd6e6ogf+LMzsxRVoZ+3ZRCPJlwcxeeN2IM
 KqW6IezXxY6aSc7V0p4Yl4wYQqhx9MYXEBNtslh02sbiySChXBtzeGN1z4JGzAAHYtbw
 xpcmvcs4p5ZgSQDbDApRVt6Zg7OGUSVSoKYFYip3RGNxMoq9STLeH9A3vbIdPAuZhwg2
 C0k56aVN2iauBw3vWwaHl89prg+KQqZ2yQ7Drar3DeLR/QdGQkRraofUe28E+EQ4MJ+R
 p3RG1jiPUoCuix4du1cfcxO+QJZ70qFt9hpvM03pwA2XVrYElAVqotD4Q6jilMvQ4yv3
 IVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698408972; x=1699013772;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+niAB94xkwrpIXtX89f78vV3+CT29Hlo7jQqkO4CSGY=;
 b=cdIBhBxe1WmtEuHT5n8XbPz1XmIT37Kn+tgdqstFbonq6jNEbfLMcwUYYI1ewnDf4x
 E5rsKsj24h4WGCby150zLVKC6n5SyzW8YpYSQ5hvvd51LywQi3uZ0eB/EQSL/0pNkCWv
 Dknsuxst7Dzo0RlnuCm7evWP9XcemIw00zdYp7BMkyyg1Zx9KVSPf1mIsLHeXspMBiZF
 5WD+GdrPjR3j7xTm7atWSDV/cQ/rc673fgJk4qyb1iBkCQyiGxcP6dCvjpwpvxRgOYUl
 Y9h3d+l4EcqdmhQl+7/sdb21HmCu/aofAFCjzczwRs7IuDAwIvh83q7FTuc3VDvCcYJk
 TMCw==
X-Gm-Message-State: AOJu0Yya3u6RR94iivYr3XvGu2yPB+9QGq87LIoYLK4uY/PnogegxzBW
 qCLkLbQeJJhvrV2wAiqWgjwZ9vbZ+A72N1W7JkBYRQ==
X-Google-Smtp-Source: AGHT+IHX8FSZM5xiqg9rFN/9iE9PFms6NQ7Dbe0ePouW2OVnOVgjIF11hXydnK3tCjF5WxlCx94UcbugTQTJg1HkHbk=
X-Received: by 2002:a05:6402:8c1:b0:53e:afc0:ea43 with SMTP id
 d1-20020a05640208c100b0053eafc0ea43mr2338947edz.4.1698408972054; Fri, 27 Oct
 2023 05:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231017194422.4124691-1-luc.michel@amd.com>
In-Reply-To: <20231017194422.4124691-1-luc.michel@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Oct 2023 13:16:01 +0100
Message-ID: <CAFEAcA94NgfP52=y0dxE+ao_--DsLU+2bBXtjKvK28q-biabNQ@mail.gmail.com>
Subject: Re: [PATCH 00/11] Various updates for the Cadence GEM model
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Frederic Konrad <frederic.konrad@amd.com>, 
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Tue, 17 Oct 2023 at 20:44, Luc Michel <luc.michel@amd.com> wrote:
>
> Hi,
>
> This series brings small changes to the Cadence GEM Ethernet model.
> There is (almost) no behaviour change.
>
> Patches 1 to 9 replace handcrafted defines with the use of REG32 and
> FIELDS macros for register and fields declarations.
>
> Patch 10 fixes PHY accesses so that they are done only on a write to the
> PHYMNTNC register (as the real hardware does).
>
> Patch 11 fixes a potential bug on hosts where unsigned would not be 32
> bits.

Applied to target-arm.next, thanks.

Note to Sai for the future: in Reviewed-by: tags, as with
Signed-off-by: tags, the expected form is "Full Name <email@example.com>",
not just a bare email address. (I would actively ask for a change
on a signed-off-by line with an email alone, but for Reviewed-by
it's less significant.)

thanks
-- PMM

