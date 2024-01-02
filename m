Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3268224EA
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 23:45:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKnUQ-00011k-Dt; Tue, 02 Jan 2024 17:44:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1rKnUO-00011I-JA
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 17:44:00 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1rKnUN-0000K0-6I
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 17:44:00 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a2821884a09so116669066b.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 14:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704235437; x=1704840237; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A1jLmGTPUWFJlPisnQyQmkworW4nukdFJMKLmx7wZ44=;
 b=XqhLqdQFmxUqkogZCZPcu59Gsa4HGvs9vlo639W6Qy/thWyo4nL91Wbql7uES1oE02
 ukaWV1UHGEwPgFPsl1xpiPSjKLw/OLsKwotKq1caxe3Fi8663FoA+paE6RjaCkBp4y7a
 XqQ3lFmZaObVuTNotJgqz3uAiVj8EGogcgNAYSMbuOM4oYzp50RPkrYTRacHmPsbwdPV
 DC5WGg79Hxz46z8y0VidVMOCiW5f/oUaQyeNcncLDmuPjMqNN+bUSeUTG4I70z+7XuLr
 BxSe9AFwUWRrgORlxuSI4KVOya+TweRSkjCrKBvHYW2NOc23UGODw0hp4P9QuYBk8hxI
 4evA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704235437; x=1704840237;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A1jLmGTPUWFJlPisnQyQmkworW4nukdFJMKLmx7wZ44=;
 b=jUBqYbkn/3TM8ZW5ngdUDKjEw5pUXKuMF9XfWbcCnAm1J75G84joYrsv7MLMjMN3Mp
 GI4u0b3Igc1/7N+Z795CoIIlZbMWb4B0rV8BeKvRKvUJNa6MpWFIp9sSmEviyclbCDMM
 e8hvXt0BrCSO91J4Dg7HcLpPkegkK5nCveVTW2o6DHp8/b4H2DpWl8UR0Q2IW2E0zUsA
 FoYYrhBxmYMWIVsyjuEjo84pT8dJgm4f63xtR7W5YcrhN6JaXW3aJ5kYviZuBd9qg8az
 Ek9QsZY840c7bYx07BhnW+fyHRlciU73xNFO4eJ5/5Y4XSJh41qdvAp6OL7FpXwavh6m
 5CGQ==
X-Gm-Message-State: AOJu0YyvZAOyxDMyF+fEvYwJTqYLTbarewAGCm9NXNi1mIRVW2hlFOGL
 +zlyjbfoH68mHN5o6Qd/m+fqi41Uh0gvKh9Svn8=
X-Google-Smtp-Source: AGHT+IHM2pMidjbKgoK0VyyJeMYpt4e5ieGS3Gilxdw/1So/7Ie6o9QUCfvRfbMu8aMqeeZgCvOkA4jhiGKH4+vPU5c=
X-Received: by 2002:a17:906:f2c2:b0:a28:820f:adf7 with SMTP id
 gz2-20020a170906f2c200b00a28820fadf7mr183128ejb.25.1704235437113; Tue, 02 Jan
 2024 14:43:57 -0800 (PST)
MIME-Version: 1.0
References: <20240102201908.1987-1-quintela@redhat.com>
 <20240102201908.1987-2-quintela@redhat.com>
In-Reply-To: <20240102201908.1987-2-quintela@redhat.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 3 Jan 2024 06:43:50 +0800
Message-ID: <CAEUhbmX3iAwtBkH2hPa031rok0OH01uSkiMPp3fde+wbKxDkhQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Leaving Migration
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@trasno.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=bmeng.cn@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Jan 3, 2024 at 4:20=E2=80=AFAM Juan Quintela <quintela@redhat.com> =
wrote:
>
> I am leaving Red Hat, and as part of that I am leaving Migration
> maintenarship.

maintainership?

>
> You are left in good hands with Peter and Fabiano.
>
> Thanks for all the fish.

Best wishes!

>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  MAINTAINERS | 3 ---
>  .mailmap    | 1 +
>  2 files changed, 1 insertion(+), 3 deletions(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>

