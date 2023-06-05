Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A89C172236E
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 12:29:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q67RH-0006o6-5q; Mon, 05 Jun 2023 06:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q67RF-0006np-HT
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 06:27:49 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q67RD-0004Zj-QW
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 06:27:49 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3f6e13940daso47296675e9.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 03:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685960865; x=1688552865;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zeSm9UhViuBEmAB45pr1mX+GRQnD0q5Q4XljymYfJWY=;
 b=QN/PIJdavZcCjNKixNjYh6wi3FdQUBMWFtKBHw7JJFC6BQvT0vo4SMD1JtGDLiWrrH
 sT8sgaYqLmig767APO+k2OkXV4w89w7CZdyLDGHSrUwB7jJpM7BGvJbw0YXV7Px5fkUN
 d55HzoWAM+aMREdMQwlT6SfvY2eEdLdYkTofrSw4XdUv/djx5rta8TMzNEhvEmJxe/5g
 oh9KIbTf34WDuUZVgylsNTEq/MscqhvyTdxJDU1hTMh+kH6hnA6AFfY9RTFTpLMHmJgl
 f63oHGjlZmjoUuDr7fiWb5DeUi2NC6jt9dHB8ye+HybgTJPJtqCE0IzbAe2chdIfXlhk
 q+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685960865; x=1688552865;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zeSm9UhViuBEmAB45pr1mX+GRQnD0q5Q4XljymYfJWY=;
 b=b9FKTTFezIvsj3y4NvU47qYiplRP+DpZ92aIZwS9963USPrwTPqa6M03XuH2QS0Zg5
 RbWrCBQ8nlwSFQJeN2ggdLpkd08xtZY9QGuF2iywW5GUctwzHy107QfSz33Dw00TpUBF
 hJjSMdOkyuBM62G2d5ESj5cil4Qaj7iaWtAA+YTWNnNPrcFNXfXDHSAHvH1umgK5Znwu
 YplpE52zKudplNI5RDiowagSt2x0JYbvWE/jAXXIGZT0LBV1JhIdao7hjuYWjOlGGojo
 lsf6MPqZV6zqyhAUL7OQGts/rHeV/LbvrGPzD6b3X3OGBJfTafEcS6yS04ttvHL3RYkH
 GXFg==
X-Gm-Message-State: AC+VfDwqfSS9ciSG2X+X+ax6V0p34XQmuQJ/2WO5Qiwmt481P4vYtS5d
 MYc6NDrnrupEtAOxLSZ3//rVW8K1ah5zL56Qb+E=
X-Google-Smtp-Source: ACHHUZ7+pGNXvsFpCRFNZ7OvCwS5tHl84orblErEdDctLycb4j3Q060g4ZPbzCpzNMSNWqAMbbqa7g==
X-Received: by 2002:a7b:cd8e:0:b0:3f4:e4a2:9f7f with SMTP id
 y14-20020a7bcd8e000000b003f4e4a29f7fmr8313384wmj.36.1685960865235; 
 Mon, 05 Jun 2023 03:27:45 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 8-20020a05600c230800b003f6cf9afc25sm14052120wmo.40.2023.06.05.03.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 03:27:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 63F701FFBB;
 Mon,  5 Jun 2023 11:27:44 +0100 (BST)
References: <20230605095223.107653-1-pbonzini@redhat.com>
 <20230605095223.107653-2-pbonzini@redhat.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: thuth@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 01/10] configure: remove --with-git= option
Date: Mon, 05 Jun 2023 11:27:39 +0100
In-reply-to: <20230605095223.107653-2-pbonzini@redhat.com>
Message-ID: <878rcy19wf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

> The scenario for which --with-git=3D was introduced was to use a SOCKS pr=
oxy
> such as tsocks.  However, this was back in 2017 when QEMU's submodules
> used the git:// protocol, and it is not as important when using the
> "smart HTTP" backend; for example, neither "meson subprojects download"
> nor scripts/checkpatch.pl do not obey the GIT environment variable.
>
> So remove the knob, but test for the presence of git in the configure and
> git-submodule.sh scripts, and suggest using --with-git-submodules=3Dvalid=
ate
> + a manual invocation of git-submodule.sh when git does not work.  Hopefu=
lly
> in the future the GIT environment variable will be supported by Meson.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

