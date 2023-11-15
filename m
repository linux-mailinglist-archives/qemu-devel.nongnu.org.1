Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B54B7EC0D0
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 11:36:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3DFC-0000Vt-D1; Wed, 15 Nov 2023 05:35:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r3DFA-0000Vk-Rp
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 05:35:36 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r3DF9-0002EE-B4
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 05:35:36 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-52bd9ddb741so10178184a12.0
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 02:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700044533; x=1700649333; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hU5RFjkcKAbmnyePv6KqpPEs4J+yGij4jn+S7NzgICI=;
 b=hLo3OhzFy22BYA2CcHr5QwHFCTpmH2QvHUxVZdmpiuNj6OV57RHOoXsDXJl+9vqBKQ
 CoPenblnxulXUPkWjbqYtW3h5UxWTG7vPulTxjRoCt5MLyQgCUYwoSrQ4xXSuFRvNbBi
 uO3Z/TC59leKwfok9VYMUsgP0XrVXsEcEEngZXXdONMocSl08WIbgw4De/rsGdIIrXOf
 aFdlkppIfaqF9AW+J1UrZb2ISuZZbcLP1XOCKfUzEwh+bMMHDltQYo5ue6a3EUKPbv28
 k0Iv4hu58Sl+15bveN7lJ926GGhjefbZ7eIU31uFRSqjTErVH4k0XDM1Le5V0zBAKGFy
 L2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700044533; x=1700649333;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hU5RFjkcKAbmnyePv6KqpPEs4J+yGij4jn+S7NzgICI=;
 b=Xc41JI/tf1XyQW78iK0WVrG/MxPNEhIKOnzl2vpdKuiitwldNzugVuLX8+dEL2Ij5d
 CETuDYyfqhHE18jNC1t0xGihjFscDdIAjnJCyAW+GfK52xlCww6PDqXIQalTGWtJJ0IQ
 Ub6aB/ng8maKoSgWeApCNNSvxzXEkN95CnIHqPfPnfniNxA1lNb+qa3gOqtWMP49kM3q
 Phu0BBh0the+/QPUqRv50egObbQtIfkldBpFZt3JQOLTIFxV2ejz3Gh8tF9Kms2qz/LO
 ctavWcbp+owywSJQlzyFY7cd8RcKH+MDQxvsptM2iAVaqXSCthrB9TzMUH2b4rqOvOCv
 Eirg==
X-Gm-Message-State: AOJu0YyJJziaKm8t4XsISUitG9bQTst8sg5ArLvgQwO4ew1OORMSwy1a
 Z21bQWYgF8A7cKM7c2WECvLNgm3O33XvfuLvMQmVXw==
X-Google-Smtp-Source: AGHT+IGBCgeE5vb9vTAnRM+tJ2qihwRRz/0aDKxskWhlwDawYmUC+3OebIYc4Sd3NA+95pUAvaOKvjTz7hX/jl9aE1k=
X-Received: by 2002:aa7:d49a:0:b0:533:97c:8414 with SMTP id
 b26-20020aa7d49a000000b00533097c8414mr9908624edr.7.1700044532809; Wed, 15 Nov
 2023 02:35:32 -0800 (PST)
MIME-Version: 1.0
References: <20231114205507.3792947-1-venture@google.com>
In-Reply-To: <20231114205507.3792947-1-venture@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Nov 2023 10:34:50 +0000
Message-ID: <CAFEAcA_cKSM-N0nkjtg4UYKwQwBRxffifteU3P=BBxxhEyePsw@mail.gmail.com>
Subject: Re: [PATCH] softmmu/memory: use memcpy for multi-byte accesses
To: Patrick Venture <venture@google.com>
Cc: pbonzini@redhat.com, peterx@redhat.com, david@redhat.com, 
 philmd@linaro.org, qemu-devel@nongnu.org, Chris Rauer <crauer@google.com>, 
 Peter Foley <pefoley@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Tue, 14 Nov 2023 at 20:55, Patrick Venture <venture@google.com> wrote:
> Avoids unaligned pointer issues.
>

It would be nice to be more specific in the commit message here, by
describing what kind of guest behaviour or machine config runs into this
problem, and whether this happens in a situation users are likely to
run into. If the latter, we should consider tagging the commit
with "Cc: qemu-stable@nongnu.org" to have it backported to the
stable release branches.

thanks
-- PMM

