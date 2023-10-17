Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 408DB7CC8A0
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 18:21:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsmo0-0007GT-CI; Tue, 17 Oct 2023 12:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsmnt-0007Bu-BB
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 12:20:22 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsmno-0000xm-C6
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 12:20:18 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-53ed4688b9fso3782525a12.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 09:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697559613; x=1698164413; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EsX6nnWGxk/rxIgAnHU3z9k2kGbFPEvt7Nxm3ReVtNg=;
 b=ZJtsgBh68dZbdf48VKeMdCV8x224OOcLgSS/yMXZ3RNrK02VXBirVze4t+QkWgkWdi
 2p7sauKk4IR8ry1BT2EG19WmqyNCCjNP8utbp9toBzIC6rkSQoYOUSwXS0AOkDFgiLxw
 OSK81wgHuZwJVuCY1nFydMParpC/kHsOj4408whr61DS8acQrXYbbAFT//kTDry75r+g
 0suY32ejjKUmnglHGXv6FklV4iwbPo+C7SkQ4ecNzMw0CJJVn2YbtMzmNHkBMScwpH8z
 7ihhN5bsDcbbWe+r78YR4jqvLaLgwRXGOj8z296O3Ogc/ibQR0qOKCi5BIEbGLyPRA6p
 Qxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697559613; x=1698164413;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EsX6nnWGxk/rxIgAnHU3z9k2kGbFPEvt7Nxm3ReVtNg=;
 b=P6prhQBYKv04pnxzKcncljKA01XQ0ZWzMTdNBoEB8uxOShYpGI1NA2n5cz1UOn+yV7
 X7LkTVoaa/TMlv61VRZTzhIHNOzPFmEIlqwCP1Sh+wHxAcZJlsP/BSnTpD4A4krjgZkP
 ow0H25vG2zXTblRrD6AfdBlquHz4pEYkfDfS4MLAnRkZhv3KbGemgh4iEjUmq8mzIzob
 r5wqEGOvvOyrXurW9m3eKveL6e+sch8JcAIv9WuRVUQh6klHlPpLYp33J6LVI5inZxf0
 RYLIQBl9tp0iP+hk+Uf+RNubPm9uXI5HE4X6QSIJtrramhLDDV4EypGid6L33ILr/cBm
 iIqQ==
X-Gm-Message-State: AOJu0YzAqCL/AO2pNZonp6rVBi+HBnbREs8elkChK9w6sZRhNt0sRcyf
 NGRgpqngFCGEBm1TJt3TIGVe0phHdY0Uz3EcMaZzow==
X-Google-Smtp-Source: AGHT+IE8zHfiG0tWFPx4YUwIo0a/0h4ViJVXwyi0s5jqlQ/oh6Q0Lk/to4aLXAKAms2sEx1NMthCCzPOfJk2A8j0+OA=
X-Received: by 2002:a05:6402:17da:b0:53e:1721:146b with SMTP id
 s26-20020a05640217da00b0053e1721146bmr1808916edy.28.1697559613248; Tue, 17
 Oct 2023 09:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231017151857.21328-1-quintela@redhat.com>
 <20231017151857.21328-2-quintela@redhat.com>
In-Reply-To: <20231017151857.21328-2-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Oct 2023 17:20:01 +0100
Message-ID: <CAFEAcA8brMkW8Y6=sOq1YpEwY+Wjvt+NxSqCBTQFw2tBeYRbEw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] migration/doc: Add documentation for backwards
 compatiblity
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Leonardo Bras <leobras@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Tue, 17 Oct 2023 at 16:20, Juan Quintela <quintela@redhat.com> wrote:
>
> State what are the requeriments to get migration working between qemu
> versions.  And once there explain how one is supposed to implement a
> new feature/default value and not break migration.
>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Acked-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  docs/devel/migration.rst | 217 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 217 insertions(+)
>
> diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
> index c3e1400c0c..5ef2b36e9e 100644
> --- a/docs/devel/migration.rst
> +++ b/docs/devel/migration.rst
> @@ -142,6 +142,223 @@ General advice for device developers
>    may be different on the destination.  This can result in the
>    device state being loaded into the wrong device.
>
> +How backwards compatibility works
> +---------------------------------

Is there a better place in this document that we could add
this information? At the moment these new sections have
been placed in the middle of the "Saving the state of one device"
section, which doesn't seem right; worse, it's between the
"General advice for device developers" and the "VMState"
subsections of that section, which means that we end up with
a very long part of the document that is talking about edge
cases, and which splits up the two parts of the document that
are really all most device model authors need to think about.

My guess is that the extra documentation on backwards
compatibility that these patches are adding should get
a new section of its own (at the same level as the current
top-level sections "Transports", "Debugging", etc) which
then has its own subsections; and that this should probably
go either at the bottom of the document, after "Firmware",
or else just before "Stream structure".

We should probably also add a
.. contents::
directive near the start of the page, since it's now big
enough and has enough sections and subsections that a
table of contents would be helpful.

thanks
-- PMM

