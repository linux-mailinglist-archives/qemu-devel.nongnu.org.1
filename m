Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C781791A33
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 16:59:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdB2g-0001Ng-OZ; Mon, 04 Sep 2023 10:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qdB2e-0001N3-Q8
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:59:04 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qdB2c-0007Mm-J4
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:59:04 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4013454fa93so15732235e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 07:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693839541; x=1694444341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yi9Pjy4wffpi5DCaxkQr6fk2VJGjaDkem6yoejg6Pmg=;
 b=d2r9yEno66d30vhwMP1MLUR5k40Ax5bTEIdQanCuprYLaviPMJ+d6sDrnHRbiW5P5D
 ituGlPNCRmW9GgKXGz6bNphCiU5JW1e7UHzPkzmgyu43p8vDAI4kj9k/noNDuj2baH7q
 kjXqgZSF2wBf9wSnDpn+tngClc6iWHWvDog0RJdbvfqhb4/EOEsLje+6oSpyCzYxZ66X
 TEoKWVfyX3RYcUlJYuJ3aHf7ueY3+d2UE8A1je6SnShhplkmW+pAySaeBWGkFig1z4tt
 UjGMIkdPDXp7GMFdsNCzNrKFz0tZUCHoCmiFcXcw3Dhv9H/cwARd8KeVen+bBCrvAbtT
 rZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693839541; x=1694444341;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Yi9Pjy4wffpi5DCaxkQr6fk2VJGjaDkem6yoejg6Pmg=;
 b=kOvPgkhEdcLtWVxkOnQRjHpFroJWLgNgutFUy6MtmC27QVreDjqFbuWU4Vzk5bs45z
 CXcTgjbgRnrxZaPeSotHV8Wm98Rj5VeWG2fav5BXy2VxgM+wPosuVFwTcLN6nsDAMgIJ
 GiRWevhRCH0bX5oeQOvvluzgtmAhidyTyPhR64HNJ9gFsg9d75Ta/8m9WhhOioeaH7HN
 eEAIgf8YBPOHG2KaRaa3tx5jLELSPKpiadzWzSlzJz1z8bZdlRfo838RCuV5O8KMfGwF
 rst6kg1MpiNjHPauaEyuRc9DXstf6KkHQHpqo9U5G3ei5wskAwSN/D43/BQCiD4030wl
 Q98g==
X-Gm-Message-State: AOJu0Ywu+8FXrsy9W7MBDR2Rns8WTszhmI2OeUpBff9wg5KliSaPIVcN
 pT/gu/EttNLHxMwTPoMBU96fmA==
X-Google-Smtp-Source: AGHT+IH3nj9I3EUu+20jMPQYI5c528JdGkJHddOqYBHD+Zs+lMXuY6ts6FhwFLAHeDyNI2Xr4TRsEw==
X-Received: by 2002:a7b:c457:0:b0:401:b652:b6cf with SMTP id
 l23-20020a7bc457000000b00401b652b6cfmr7154136wmi.13.1693839540772; 
 Mon, 04 Sep 2023 07:59:00 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 p9-20020a1c7409000000b003fee53feab5sm14474500wmc.10.2023.09.04.07.59.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 07:59:00 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0C7431FFBB;
 Mon,  4 Sep 2023 15:59:00 +0100 (BST)
References: <20230829220228.928506-1-richard.henderson@linaro.org>
 <20230829220228.928506-5-richard.henderson@linaro.org>
User-agent: mu4e 1.11.16; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, Philippe =?utf-8?Q?Mathieu-D?=
 =?utf-8?Q?aud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v5 04/20] linux-user: Do not clobber bprm_buf swapping ehdr
Date: Mon, 04 Sep 2023 15:58:55 +0100
In-reply-to: <20230829220228.928506-5-richard.henderson@linaro.org>
Message-ID: <87jzt6htmz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

> Rearrange the allocation of storage for ehdr between load_elf_image
> and load_elf_binary.  The same set of copies are done, but we don't
> modify bprm_buf, which will be important later.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

