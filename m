Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E21B87249AD
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 19:00:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6a1f-0007Jf-8Z; Tue, 06 Jun 2023 12:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q6a1d-0007JQ-CN
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 12:59:17 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q6a1b-0003Er-Ng
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 12:59:16 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-30ae141785bso6286031f8f.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 09:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686070753; x=1688662753;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=szgzR0drBx9FawphjD+kvY+P45U/Wy69spT4nCzqiCg=;
 b=iYjiUNbEfjbX/eDGb7GfTxCQY0ZkK3MZ5B3ZLLBuQ07iB22sB8THAbhpbD3Tnj5k3S
 yDrJl4ZWYa4NR6LzVDw2aewFZ095lm02ApiMwIwpgwkhKlK7gbfWEkTCilbFzFFFGkH+
 3BzDb8YvBpN0d6eB3jrAZ3BP+vN4ON9S2kELPUPhuGarTeIWLsIB9zsMQDNtzbaD9cPv
 ivjPG8yFChqVh/aS4hAZPLP1+fveHkjWYWnWMbIRjgjPpWWWEc3rxHQzydLbWiOdrDad
 a3F243nV3aovwkZvBflkufUMLaS8qa0HBML424ht+EPZgKiecqYpz729obfyEH0lTIHl
 +vZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686070753; x=1688662753;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=szgzR0drBx9FawphjD+kvY+P45U/Wy69spT4nCzqiCg=;
 b=dPv1V1hB9GLcMf3tUuVV44zvasKf9juMQLd1xCZFn84hmAHRbD2p9WHJq5cmWpuaGA
 mu+auhQzhRQ2Out9ldC3E0BPtzYM9b7DYUo0iSO1obBNbyU6CsyfXDeuALc7hRYAH5qd
 Vdx5joRXEcX2UBr6pQdguNkIJA14QvQH8yJ9qv1MLTP6bdkJh+pK3hufSWAUvB8/tLeT
 TruFs5sg7E61RNiANOLIFiSVrqma831x1EYWVzrKSQYIXUHrdr1AVh7ErgM4Eks7Cc6z
 78xCmnPQx4uXzZBuQc5vAHaMtIYtRf/xwwZjNfQWB1QzRMIzYFD41lzDeY34gGTnKu+S
 QuxA==
X-Gm-Message-State: AC+VfDwufQVPVbUXAWOCEu6pRf7t5akVJNuTRiFtSrfNLHrSphmB1CJ0
 vZhWs6Hj8DitEdOvCz8KrAAvbVduo8bXZPvJEAA=
X-Google-Smtp-Source: ACHHUZ72H8jTX9jsrVCnSiQA+rCylOeVk95VEMRA57DCx7e0Wg0Idezar4IfR+6hXEIOYdI4KpUQcQ==
X-Received: by 2002:adf:e5c9:0:b0:306:2cc8:a337 with SMTP id
 a9-20020adfe5c9000000b003062cc8a337mr2279655wrn.45.1686070753218; 
 Tue, 06 Jun 2023 09:59:13 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 c8-20020a7bc848000000b003f72468833esm14519313wml.26.2023.06.06.09.59.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 09:59:12 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 718851FFBB;
 Tue,  6 Jun 2023 17:59:12 +0100 (BST)
References: <CAP5Nno6wrz4qEMK70KFwxoZWeo89+SAyXDXFW8A30mJ-WeFi4A@mail.gmail.com>
 <87ttwts5ur.fsf@linaro.org>
 <CAP5Nno4C6C-sfj73NM92Gstnw8mm7A7RwEYT=oUZm1Fh0QqFYQ@mail.gmail.com>
 <CAFEAcA-wT3OUZzkVA8riMRDWE4M_f3yZD2HLHSTksLUVM+kH3Q@mail.gmail.com>
 <87wn15lrab.fsf@linaro.org>
 <CAP5Nno7q2hh-aJit08BqMww5S1sKq9vmP5_2gtunhxR=CYLovg@mail.gmail.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jun Sun <jsun@junsun.net>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH risu] use time() as random seed and introduce --randseed
 option
Date: Tue, 06 Jun 2023 17:58:54 +0100
In-reply-to: <CAP5Nno7q2hh-aJit08BqMww5S1sKq9vmP5_2gtunhxR=CYLovg@mail.gmail.com>
Message-ID: <87wn0gh6hr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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


Jun Sun <jsun@junsun.net> writes:

> It seems to me that we are OK with random as default behavior but we shou=
ld print out the seed (and abstract it into
> a shared function across arches).
>
> Happy to re-work the patch if my understanding is correct.

Works for me. Please respin.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

