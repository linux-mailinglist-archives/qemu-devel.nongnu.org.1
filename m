Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B578672244A
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 13:12:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q687r-0000uP-Mm; Mon, 05 Jun 2023 07:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q687n-0000nv-JB
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 07:11:47 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q687l-00047x-Dj
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 07:11:47 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f6ef9a928fso38876055e9.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 04:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685963503; x=1688555503;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ouerYSLbP0WNwgheq4cxSDk0zvNFbxNt6h4WkO7UULg=;
 b=aVuvpo6fVvHhGynUQFOizsOsh+d5cFPuxWl4TETLdxr0z47/6ViGjd0y9FYbrYgAws
 t+vqeX86dJtCPltYzKj2myGUrdhJXRjMnOFJ9Zn5LcNxoADCa/AHf6utbmQDtRpHcFWt
 LrTz9tB4+t6JiBJnj2RFh4EHL9kjR41G65JZ6nbdSuzsrPPKTLMjSEpiaMIbkimyeuS/
 6nUP0UtwtFR1JZiqCRMwiNrFiXrT0MWHGFj6uwGWYWxYzT9Yf69skRHNqFSqHB2tMxc7
 MHFjIaB7fXXDaERgc+nx240zHlNYBS8Ph6u3kxhAyJe6DYwYIL6r+TkQszUCEm5dkXof
 Xz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685963503; x=1688555503;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ouerYSLbP0WNwgheq4cxSDk0zvNFbxNt6h4WkO7UULg=;
 b=YAxrhxA+q3jTFSQq/h3M3NbT3KURK4bFnI7NY6fu49gZN5EQQ16B3KZ7zc9JrbT59B
 miACzLW6Q0kCTRfP4yjBNHK8b5HpYGZoHcoxGgz7MFa/jbVnipQa+Ckv5mM13wprCoO9
 x7sxalhLwUNxRBzjrzhu8aVdZiJ7ooZYy8kEh/MOD8NIaQc2aGzvlFNvHbPJPKZq3xam
 LjWs0r1kAomm0EQNmHos4FQcGOCynkKoC33Rr4TKHgk4FNpNJ2Rc2Jnq4INVXSKmAS6N
 KQkLd/Cy8pC+ZFef4Ila9+jvRrZX/y+NIlbopwZy16wV4QGLytRgqd3KmofSDSNHe/Ep
 xCfg==
X-Gm-Message-State: AC+VfDx272UipN48fjtxGhQW5n/5IYf3ik4vmY6kVG8+gs+/M3O+6BOv
 I1Uv0Din/MbIEpTuqmjzgfV/9oZAbsOA+2owkKw=
X-Google-Smtp-Source: ACHHUZ62dZjvvneTnjl8CmOIIPrNzCnEp8qAwOMyfzEdjitTLgWrS06EbQPzPLNbEEpUolDESWc/bg==
X-Received: by 2002:a05:600c:220e:b0:3f6:787:4a70 with SMTP id
 z14-20020a05600c220e00b003f607874a70mr5923165wml.15.1685963502869; 
 Mon, 05 Jun 2023 04:11:42 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 24-20020a05600c231800b003f6041f5a6csm10413113wmo.12.2023.06.05.04.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 04:11:42 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1BA1B1FFBB;
 Mon,  5 Jun 2023 12:11:42 +0100 (BST)
References: <20230605095223.107653-1-pbonzini@redhat.com>
 <20230605095223.107653-5-pbonzini@redhat.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: thuth@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 04/10] build: log submodule update from git-submodule.sh
Date: Mon, 05 Jun 2023 12:11:37 +0100
In-reply-to: <20230605095223.107653-5-pbonzini@redhat.com>
Message-ID: <87r0qqyxht.fsf@linaro.org>
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


Paolo Bonzini <pbonzini@redhat.com> writes:

> Print exactly which submodules have been updated, by reusing the logic of
> "git-submodule.sh validate" after executing "git submodule update --init'.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

