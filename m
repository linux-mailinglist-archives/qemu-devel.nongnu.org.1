Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9217B666E
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 12:31:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qncfm-0005I5-1p; Tue, 03 Oct 2023 06:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qncfj-0005H5-Ot
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 06:30:35 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qncfi-0007XV-4p
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 06:30:35 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3247d69ed2cso776799f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 03:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696329032; x=1696933832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TxKplnAPyzy2Yy89QezfAUEznF5hGejp+mvALXALfD4=;
 b=iyhYa7LpdgklYoQaVhwok79QHWhyz+WyBQF7I1PXpgvEhfQBec0iIr6iJTDUa0qhTt
 0BylR13ViRefokmWdwtqupN/ZUDrNfvKfB3YGu5JMpD/B2IBBS2jHpe2y80vN7fErucr
 39dOo0+ziPjz/7KX+MbZlFJhkpIfmES4aEgBMfpbxgQxQP3fB4pyMdlXxFA9P+b9hl6/
 KDqeFx/Q64XDCIGzUcOKvjm2dL1zw9UoM0R7cWi/7zNVF0Rt/MSGrGT4iLsrqQtQ98eS
 GypC61BzQNga9mwLBhZMW752QYfR9KBY/Jm4zwq5MepDqSa/7oKVoorxGx1SBuliUob0
 Ha+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696329032; x=1696933832;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TxKplnAPyzy2Yy89QezfAUEznF5hGejp+mvALXALfD4=;
 b=BK4YV7luYxtVgpHUjsqTyIBwW5VmPTsHCVdY2f4vcNBHjHEGxLrm1gv/H1nC+wd0Q3
 9xRcfaDGRfaGBq+D7drId6FCAUchaCKKbT2F89xz/HQZcRzAZI7lmErP4t1la1Wi26Jd
 gdtr0QE7+pjA2MEncwjzmNaQezd8X5/xEovb7P1Jb1Uco7nAWB1b5jg4rjrN1a7pH29N
 sUNArlnLf/BKIMxDDx0pecdwd/8sILfvb6iiBZofHbPT/aaJ4SRrPvMfn2z3Nu2G6mw6
 s+Pz0+HuoftnuNH+FRldn2UwqUc7GqR8cRmeAZrBg133oEG3VVwXMaBftYggqbl/snNS
 /5Jw==
X-Gm-Message-State: AOJu0YxJ3VtbU2ZPWIunUiCjvt0YBxED9EvClaIma7zNoMdpjqBH3zTp
 zFVAPs+YeX1OLl8owQAyafUFhg==
X-Google-Smtp-Source: AGHT+IGMgq7pCLbJGjsX4PQtoLyfwso2gvmb30qVpRLz54vmBlZBdBDR8LiWDeFGIPy6EQ1f+Xpd2w==
X-Received: by 2002:a05:6000:888:b0:321:6de5:68b4 with SMTP id
 cs8-20020a056000088800b003216de568b4mr11083283wrb.52.1696329031077; 
 Tue, 03 Oct 2023 03:30:31 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a5d6a09000000b003232380ffd5sm1245835wru.106.2023.10.03.03.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 03:30:30 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0C56A1FFBB;
 Tue,  3 Oct 2023 11:30:30 +0100 (BST)
References: <20231003063808.66564-1-philmd@linaro.org>
User-agent: mu4e 1.11.21; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Cleber
 Rosa <crosa@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Paolo
 Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Beraldo
 Leal <bleal@redhat.com>, Wainer dos Santos Moschetta
 <wainersm@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH] tests/avocado: Re-enable MIPS Malta tests (GitLab issue
 #1884 fixed)
Date: Tue, 03 Oct 2023 11:30:24 +0100
In-reply-to: <20231003063808.66564-1-philmd@linaro.org>
Message-ID: <8734yshubd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

> Commit 18a536f1f8 ("accel/tcg: Always require can_do_io") fixed
> the GitLab issue #1884: we can now re-enable those tests.
>
> This reverts commit f959c3d87ccfa585b105de6964a6261e368cc1da.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

