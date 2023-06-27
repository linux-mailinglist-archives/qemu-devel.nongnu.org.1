Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5B17400D4
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:23:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBTZ-0007Ul-23; Tue, 27 Jun 2023 12:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBTX-0007UA-7a
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:23:31 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBTV-0002W8-3q
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:23:30 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fa8ce2307dso38498245e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687883007; x=1690475007;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jKnEec/+0oiuznms9BZnW1afU2+8kb+gyTxrjKdP924=;
 b=X5O4azXInAMsERfLrpDGznZppJn+nHgUPK59jVQWx+aEQtyVN3AzJAomVdN6qhSXW5
 Ww1dM+CvazPsi3OyjEO4MotntdqGUvEE9mjjhbdchCzlt72PmeUOBW09kieJ+u/kMczK
 ZGQsbjgPc5ZjAeT8If9dKs4gFXiATnS2S9RMO5YAAgL03aEaNLMkKWmtF75ZCZnCqTuD
 TVWl0BdpvoL7TWABXEMQttRyCGYJnIxaplgAIep+r7tGucS8k3lGHb9+Rmbkbwy0V4/9
 JqGDxtfJ45XdgtarRO+7hawLYfygzGl5C1umrZT4eQ9Mmd7EMseZ75c2pCG+C7FQ4H+D
 FPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687883007; x=1690475007;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jKnEec/+0oiuznms9BZnW1afU2+8kb+gyTxrjKdP924=;
 b=dW978OD9bXO+3MKG8WzYwOfNnqZVH1fw5f8UXn2DVX3TGMtf3kscP7a+u+KO/qhxkY
 VF77Ifp1YpOpDauLcahdN4igwwLWhGRO45GX0fevWKFQSKscYRCQb0bDr5a8FUIslLUS
 ul8S/kclNRgsGYJb0hmGSuQ8bHwyUG/T22Cf4rYDZVLVI4C3se/hoIXzVVrzs1ezckiF
 Yj4nzgBekio1V6BYY0AXqy8TuzaTrpnW3JAm26hgNuH/sq8AXFbAoXXpmBnM5RhapLgF
 IaTWfzoKAJpM89F65pqcYIxGaI1MP1TZzkCFQ2eNCyXzKr7do/s9adrnqrSAs21rK8jo
 50Fw==
X-Gm-Message-State: AC+VfDzfIhbGK8PQKgVg5xn+PJuhVf9Ux/lmb7KWNuAvJrOhKpEKMOaa
 bwQCqcP69aSk40Wuzi8wNScHrg==
X-Google-Smtp-Source: ACHHUZ4jdapv1jpT79J8Vq2v5GTdM2x8JRvk+PhvrTF/1oZoeTuSFMSZ/Y4ZaIEo3VHZSyv0gANz3Q==
X-Received: by 2002:a7b:c5d8:0:b0:3f1:789d:ad32 with SMTP id
 n24-20020a7bc5d8000000b003f1789dad32mr36368852wmk.11.1687883007362; 
 Tue, 27 Jun 2023 09:23:27 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 25-20020a05600c029900b003f42158288dsm14198327wmk.20.2023.06.27.09.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:23:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 919E81FFBD;
 Tue, 27 Jun 2023 17:23:26 +0100 (BST)
References: <20230627160700.2955547-1-alex.bennee@linaro.org>
User-agent: mu4e 1.11.7; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Riku Voipio
 <riku.voipio@iki.fi>, Leonardo Bras <leobras@redhat.com>, Wainer dos
 Santos Moschetta <wainersm@redhat.com>, Leif Lindholm
 <quic_llindhol@quicinc.com>, Yanan Wang <wangyanan55@huawei.com>, Marcin
 Juszkiewicz <marcin.juszkiewicz@linaro.org>, Bandan Das <bsd@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Bin Meng
 <bmeng.cn@gmail.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Stefan
 Hajnoczi <stefanha@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>, Alexandre
 Iooss <erdnaxe@crans.org>, Juan Quintela <quintela@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>, Qiuhao
 Li <Qiuhao.Li@outlook.com>, Mahmoud Mandour <ma.mandourr@gmail.com>, Peter
 Xu <peterx@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>, Darren
 Kenny <darren.kenny@oracle.com>, Laurent Vivier <lvivier@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Alexander
 Bulekov <alxndr@bu.edu>
Subject: Re: [PATCH v3 00/36] maintainer omnibus: testing, fuzz, plugins,
 documentation (pre-PR)
Date: Tue, 27 Jun 2023 17:22:41 +0100
In-reply-to: <20230627160700.2955547-1-alex.bennee@linaro.org>
Message-ID: <87cz1gzxfl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> As softfreeze is fast approaching I thought it would be work combining
> my various trees into an omnibus series to ease the review and
> merging.
>

Doh, apologies for double posting, this thread is incomplete. See:

  https://patchew.org/QEMU/20230627160943.2956928-1-alex.bennee@linaro.org/

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

