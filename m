Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 379A775EEB0
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 11:07:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNrWV-0002g4-Ng; Mon, 24 Jul 2023 05:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNrWS-0002ef-G5
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 05:06:32 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNrWQ-0004CK-Io
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 05:06:32 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2b734aea34aso57286821fa.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 02:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690189588; x=1690794388;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CoHa9O3AzLhhFke7seUSrKurMd4rowVqL/5WTUhNoP0=;
 b=qDc5dQcjoQl2dgW1WeGxHaHf0D3RqQ44TtkiP2pitCQzKWuRWSq9eQI737QKsS47pu
 xaAP1uPZlpln6VqUC6QNujX3IJL4wiEa16wUqJ0FXro9/GSChWusUDa38aX8yjCheQ/f
 SAQKZitmoBYtnw3sTsHNgmdxXH2+D8FykZEzQ1AOEipgLvqOwfc/fCGWoFmW6Sco7qgR
 GGouZJKS6ChhfMf/pZ6HBB7rZaV00MRxDxtLv4mfgR2uumk2SNLxNBppANjNGIXUZ7I+
 4SPNvHB/qSTtFaKDTr4X8Y4ohjrWmV45J7a8A6Vj8u4s8cUO7ShF1qHTIAvsyNDAvf3S
 r7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690189588; x=1690794388;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CoHa9O3AzLhhFke7seUSrKurMd4rowVqL/5WTUhNoP0=;
 b=Xm0nhgQHZZ7LqYmOei1jR3f5lyg6mS9NwY8H+eL0HtmiQdsSlessUeCvpBFPnr+URt
 rC2PwoJTGwpYthohzCjchaDIF9wsgounj3wikTemTBQ/5lMRLY4C5JDC4Nt1cuqmU6b+
 ojg0H/Z/JD2ZewXC875Hkr/NFwOJztjlx/q/YYlp3gUKA9QuqBFKeyrE++DmzyX9RnS1
 w3cssOuTk48UZpB9CE/WxGom7eEI71FnO4z7W8ELdC5oBf1rvRIlNxRK2PwN892+odc2
 bVXnIyQ3Po/S1p476dlUk1qH/DuLwfYG5lgtHqWGO4eLloJrSpWPEsWb34rmZhJJYJ8m
 LxUg==
X-Gm-Message-State: ABy/qLZVPDcWCLNB+OZxMD7UGO83E15yHmmwKyMowTqWTPfenQVbfvBr
 0nY5tqcqdeyNXC83cvaDHWV5nmOakQb+d8O+veplzQ==
X-Google-Smtp-Source: APBJJlFsZELD5SgrYgzP7aimqzXRZwgy4+0AS6PJYU+/N3ja46BG1LsCPzHvIYscyquGSIToq1eBvwpm1MjgHTqj96Q=
X-Received: by 2002:a05:6512:3f3:b0:4fb:7c40:9f97 with SMTP id
 n19-20020a05651203f300b004fb7c409f97mr3701168lfq.27.1690189588623; Mon, 24
 Jul 2023 02:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230716115801.1505288-1-mjt@tls.msk.ru>
 <69ff1b09-a795-fcbe-ad0d-52f76f25eba7@linaro.org>
 <c4f93386-688e-3e81-4da5-641b053aad35@tls.msk.ru>
In-Reply-To: <c4f93386-688e-3e81-4da5-641b053aad35@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2023 10:06:17 +0100
Message-ID: <CAFEAcA_f5uD2gKAjnvrKvfy54MNYS_Z_j8Sc6GYenK5AAHz-=A@mail.gmail.com>
Subject: Re: [PATCH 0/6] trivial-patches for 2023-07-16
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x229.google.com
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

On Mon, 17 Jul 2023 at 10:50, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> 16.07.2023 18:58, Philippe Mathieu-Daud=C3=A9 wrote:
> ...
> >> Michael Tokarev (5):
> >>    tree-wide spelling fixes in comments and some messages: migration/
> >>    tree-wide spelling fixes in comments and some messages: s390x
> >>    tree-wide spelling fixes in comments and some messages: arm
> >>    tree-wide spelling fixes in comments and some messages: other
> >>      architectures
> >>    tree-wide spelling fixes in comments and some messages: hw/9pfs
> >
> > FYI patch subject is usually "subsystem: Topic", see
> > https://www.qemu.org/docs/master/devel/submitting-a-patch.html#write-a-=
meaningful-commit-message:
> >
> >    QEMU follows the usual standard for git commit messages: the first
> >    line (which becomes the email subject line) is =E2=80=9Csubsystem: s=
ingle
> >    line summary of change=E2=80=9D.
>
> Yes Philippe, I know. In this case though, it really is "tree-wide". I tr=
ied
> to group them by subsystem but it doesn't work that well.  Especially hav=
ing
> in mind how many changes there are (about 400 in total).

But you have the subsystem name, you just put it on the wrong end
of the subject line. You could fix this up if you're going
to send these as a pull request...

thanks
-- PMM

