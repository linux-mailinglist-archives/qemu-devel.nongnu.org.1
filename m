Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 725F37739F1
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 13:44:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTL7l-0004Da-Jo; Tue, 08 Aug 2023 07:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTL7j-0004DH-Mf
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 07:43:39 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTL7i-0006O4-5D
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 07:43:39 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3179ed1dfbbso4790456f8f.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 04:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691495016; x=1692099816;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RwD1WT2oNYQnjrA2AooQ7Ve5lw3m0d+OWSDXy9Cofvs=;
 b=CnxR6MFb0F+sY+BW6d7BkZdyBX22w2N8GyYixT4dO0cyeR8f93ncrdxKsWw3I2hUwh
 VMYHKo6YHYOD28KNvxOBjD+7i6W9+qCeRVP3dI0wqys+COnBWmwCNIuD5RQk1h8AimAw
 kCXslBUKaLgr6nosoYShPGqVpgGJGlRfE6DaUo3/NlNj3L4PCmw0GP5Mn7yMELoLn+mH
 RERJNNjHgGmy7i92+qDE+Nq+9K2YgxRjnNMnILdgm3VWMlZnPOvDM6SpPvryQZ1+lwPz
 zfuwmt7CL6gFAGluSp6Gu/P6bDEAIG9X5NMDx1nfmyzOGMHJAyC6u7ux2Sk/WLLLcwCO
 +d9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691495016; x=1692099816;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RwD1WT2oNYQnjrA2AooQ7Ve5lw3m0d+OWSDXy9Cofvs=;
 b=L5avZKeA5FWd7s9amgzplep4LR1tJLjfpQEM820jCNxsuu9jRSgITA2bFyR7r5XPvT
 B+ZBVAMJlpcsUcK2kvqawXLKk9YNyehWowMrtCVm5Nc3YlFKhoCyenSGX1lHULQ6Z5QN
 elOjfP08o6Xp/bMMAFQmDm5OWQPTsbcHMqZXT0QK2VgwrZxMvo33nUr5W7qmJlmNreg7
 BqgjQKWumxA4evzLEpg1k2ahAdlSPUCufA92qokFZCV4vQSjYHkJl5i3+tHkAC0jxS0x
 LeOYrzFqesN8RhHdPVFguY8zg59PkBR8mqSFYBf4dKBsFdzzICofSVpjJWYfqK9gCoUv
 MwsA==
X-Gm-Message-State: AOJu0Yz+BdDySju08z/0BUVs9541v12OSH71h4ACMkXpLTPFGQ0PNcK4
 Cmn0tWFr0LBbwQDTTUZ6lhc5Pw==
X-Google-Smtp-Source: AGHT+IFCtMxki2NrtvKy2gQ8fJ+uUEgx+hTx2LF/guDXstwF/XIETbSQNZLNmBWZd6Q4RrxJYPurog==
X-Received: by 2002:adf:dd05:0:b0:317:6e08:ed35 with SMTP id
 a5-20020adfdd05000000b003176e08ed35mr9944324wrm.1.1691495016261; 
 Tue, 08 Aug 2023 04:43:36 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 z15-20020adff74f000000b00317eee26bf0sm4988277wrp.69.2023.08.08.04.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 04:43:35 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 536281FFBB;
 Tue,  8 Aug 2023 12:43:35 +0100 (BST)
References: <20230807163705.9848-1-richard.henderson@linaro.org>
 <20230807163705.9848-10-richard.henderson@linaro.org>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu,
 deller@gmx.de, Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH for-8.1 v10 09/14] linux-user: Use zero_bss for PT_LOAD
 with no file contents too
Date: Tue, 08 Aug 2023 12:43:30 +0100
In-reply-to: <20230807163705.9848-10-richard.henderson@linaro.org>
Message-ID: <87350t92u0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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


Richard Henderson <richard.henderson@linaro.org> writes:

> If p_filesz =3D=3D 0, then vaddr_ef =3D=3D vaddr.  We can reuse the
> code in zero_bss rather than incompletely duplicating it in
> load_elf_image.
>
> Tested-by: Helge Deller <deller@gmx.de>
> Reviewed-by: Helge Deller <deller@gmx.de>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

