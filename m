Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8834F7B5608
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 17:09:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnKWv-0000ik-Br; Mon, 02 Oct 2023 11:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qnKWr-0000iR-16
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 11:08:13 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qnKWn-0005fc-Qx
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 11:08:11 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40652e570d9so44664995e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 08:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696259286; x=1696864086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8KFEIWnp1XTcydWZ25CmpCLdsStZmGIHvtB91rtLXvw=;
 b=Zy3mSyvW7dHqH7FdKkSenFPFXhJW/9i7ZXEPJ/V/S38JDIRJCznS1vHFjIggpLJ5iu
 tfBrVkVU/JxToxKUHmiUhX+te+62J6kMl8rXn5X2ZIGtUg/SpRL3MqhypjlzTTlRoyTi
 Ki3zxb0+0utyxisZDJsgfkVl6mVQzARY2Qz9R6hNgE/xJxcKBrr7r39FiFf1QgECFQUQ
 kw2PsxqfHXtE97nsxV/aH4cA3b55sTmFDvvPBx+twylBt7Phb79DPzdrc7zSeFHBzRNF
 vzbHtOMH7wr5rvVPOzpRFGthJ71IbC2Uz87Xg0L9dZWN+n28ezSCke5dPoZL8V+keWvh
 hVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696259286; x=1696864086;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8KFEIWnp1XTcydWZ25CmpCLdsStZmGIHvtB91rtLXvw=;
 b=FzMqyZJdToMJzAWUdLCVoImELMB0nlsIWf0lMm+4cuoGqOjpTKg0eetRmCCQ6pGy+t
 fxLertlA8+4RQ+x22ny7/+9RwuBjRt9JbNH5BcO3iSMfxEdh9PXzn+ZnV362zl1uhOpJ
 sVA3RVpIaPi6anC9XyjG+jaaoi9o2G/LK4tDXGpYOkpxoaCsfqmUzKh40LtvMYzqgkKQ
 a4RIeuTzEwNJZ4TIZ/+Q9kkn9vUWrNZo6ee3vkMjb/kLVGcMuCNmraOkryaITywJEgMJ
 MK6FRpxm5c0kT5fOfH1H4eP00HRs7bpS+UjVv4I/X77sp1+v5OpuBSfmSzbV0W0n4RXn
 n3aw==
X-Gm-Message-State: AOJu0YzPipfC/ZKHV53HQ1nHPrxT5vxE7tYuf9kLhaXfo6jY7KVboPbq
 Em0tg/wqMhqRMfVoIiKzmOLFtw==
X-Google-Smtp-Source: AGHT+IGSSriOf5EBj8Hor47kFVwKCkTSIvsRhGT4xZwU8HtkRl7qxmdmIRlFkISkaBw+WD1TM4PwyQ==
X-Received: by 2002:a7b:ce16:0:b0:406:4501:9095 with SMTP id
 m22-20020a7bce16000000b0040645019095mr11135356wmc.40.1696259285627; 
 Mon, 02 Oct 2023 08:08:05 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 8-20020a05600c248800b004063c9f68f2sm7386820wms.26.2023.10.02.08.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 08:08:04 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4834B1FFBB;
 Mon,  2 Oct 2023 16:08:04 +0100 (BST)
References: <20231002145104.52193-1-philmd@linaro.org>
 <20231002145104.52193-2-philmd@linaro.org>
User-agent: mu4e 1.11.21; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Beraldo Leal <bleal@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 1/2] tests/vm/ubuntu.aarch64: Correct comment about TCG
 specific delay
Date: Mon, 02 Oct 2023 16:07:57 +0100
In-reply-to: <20231002145104.52193-2-philmd@linaro.org>
Message-ID: <87fs2tysdn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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


Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Wether we use a software MMU or not to set the SSH timeout
> isn't really relevant. What we want to know is if we use
> a hardware or software accelerator (TCG).
> Replace the 'softmmu' mention by 'TCG'.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

