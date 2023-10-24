Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B53387D5991
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 19:15:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKyp-0004OK-Ja; Tue, 24 Oct 2023 13:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qvKyj-0004O1-Hs
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 13:14:05 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qvKyb-0006vk-1R
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 13:14:03 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4079ed65471so38802515e9.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 10:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698167634; x=1698772434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kATxzfH1MFL0zYjp9WrqziRKhhItPTI7aISne1D41J8=;
 b=uhH6j81qfYxEESH0F1TY++q6zO06Uwi7pFpI8WtDZaHG5J1wYpIpdDaokhjFSKB65H
 KNauScVAIJbEOyWZldlsGm/ucwPH48bX7enl1gy56aTgWVucCsBADt01c5N4Dag265pd
 qghk7LOWwjePmeiAraxaxyzMfes10DdZo7ZPmzjY/cxVZ1NDLHq3naewHrGH1eEBFr2p
 NOLrIfcybDLHoyA17wHxO8psvUe2lWmxrZ0m6tgxpCkBNUYluiJpYP9nLlQ6Zko/22di
 j2XR4kf+rKc1j5d5lgrGOgtVYvSANbTZBBQAKoGtUwcZ2mLiq9AaljYJ8T4b/fnTYOzJ
 S8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698167634; x=1698772434;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kATxzfH1MFL0zYjp9WrqziRKhhItPTI7aISne1D41J8=;
 b=KtP7kPLqDif5N6Tkqml9BNEOk4m8TzWhDDPdACcpUrcb/5WSjDltMFgXeb9cpMBsyd
 Qwjhw2sOnkruFMsqo9o49g9P2M3jIbtlmDPxMOJsxIV5kfiE1xwBqeDAy4RtDGigCI27
 SsHMuecSj/mj+9XP/I3UCBa2jS4X796ip4eU1Sc+RCavTUI+8ksC84iUz6Nrsls4AcKD
 IZZWZapm/oJqc9vbmGAH9h1EqGJTA96dEhE/pNFhd8WIXKpzVJfjPfbtjZl01q0pqDKg
 jacQY2gkcjbWMqU+aj0nfnRpllbUWQ+Frxj3Z03883qGEb/dJaOQbxERecvWElRaETXi
 lo1A==
X-Gm-Message-State: AOJu0YwG2johnJ1PlwJzysZ6LYAoIQoRjKcm9msj7StCLisvfYwizLsk
 Rs7vKjpD7akTrjmfcgiGAIx03ecR6Yt7eX8Ju14=
X-Google-Smtp-Source: AGHT+IEKyxBR3IvvDsqhzszOCbHVBExscMDxY/wGVW5a1mM63kILLZQblJMpSdC+3LKnDIzAqdX1nw==
X-Received: by 2002:a05:600c:1c1c:b0:402:f501:447c with SMTP id
 j28-20020a05600c1c1c00b00402f501447cmr9787352wms.0.1698167634251; 
 Tue, 24 Oct 2023 10:13:54 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 17-20020a05600c231100b00401d8181f8bsm17111227wmo.25.2023.10.24.10.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 10:13:53 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 767FC1FFBB;
 Tue, 24 Oct 2023 18:13:53 +0100 (BST)
References: <20231019102657.129512-1-akihiko.odaki@daynix.com>
User-agent: mu4e 1.11.22; emacs 29.1.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-?=
 =?utf-8?Q?Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v14 00/18] plugins: Allow to read registers
Date: Tue, 24 Oct 2023 18:08:17 +0100
In-reply-to: <20231019102657.129512-1-akihiko.odaki@daynix.com>
Message-ID: <87cyx40wq6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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


Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> Based-on: <20231019101030.128431-1-akihiko.odaki@daynix.com>
> ("[PATCH v5 0/6] gdbstub and TCG plugin improvements")
>
> I and other people in the University of Tokyo, where I research processor
> design, found TCG plugins are very useful for processor design
> exploration.

So I reviewed this on top of my gdbstub/next series so needed to make
some tweaks as I didn't have the riscv misa_mxl patches from above
because there still seems to be some debate about them.

If we can get a series that doesn't depend on them (or the RiscV guys to
agree with the changes) with the review comments addressed I think I'm
ready to pull at least 1-15 into my tree for the next pull request.

I want to spend a little more time looking over the plugin API itself
and experiment with some alternatives. But I don't think that need hold
up getting the gdbfeature stuff squared away now.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

