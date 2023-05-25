Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44712710F70
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 17:23:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Cn7-0006CM-QJ; Thu, 25 May 2023 11:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1q2Cn2-0006C5-7o
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:22:08 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1q2Cmz-0006Rc-Hw
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:22:07 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-561d249f045so6128667b3.2
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 08:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685028121; x=1687620121;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SU6QUXaTMTnzZOhtwtwE5WXIqUe9XkrOrzimf5S+CFw=;
 b=nIZGcWDrOna8TSjh/5aKinAhqlmTgdmsJprh3zKWufuh+gpt76ggNAjJkTcsLJ2IKp
 Y206JQIcKYe/QXKZq9IlxYjUyrv5hwA2O9jD/xdNCIDpFnM+Fun6NqXmUwfM2IQLHYuH
 CUJCRR3jAjVYS1WAlqL7pAwFoTmZodeFG1not2mWkv5Gc8kIXcvb9+EcsRkQ68iBexZ7
 g+l8HNQjYjRwVFGCsWn7DQKojQmoeCrElzxz62953ZU2eH1Hh7WX9hzLYq6BTE0TlS1D
 7wXilAR7jOJAfsICd7Vjr1cYNYJfxQCrKkWlIH+Yvhn7XJStuF2MuPjp7/158N+ZbQP3
 bBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685028121; x=1687620121;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SU6QUXaTMTnzZOhtwtwE5WXIqUe9XkrOrzimf5S+CFw=;
 b=BJc43J6Z064eY+ZcNd2CfV9jNN/ZLnIcMzKxjxqtfo2rkrFG84FboAykBbM7oqfCtF
 ZJh7jiiImeg95zErNKIaXb4hMUXSBQ/EEl16sFGz1KfUU+hQVfz91+264kYCZDeceElf
 6GvmJ4voigKMu9lvF+1so/a3l3I9ZCLgJsJqD1DT8XM016SIlCav40KLQTZxDqhRj/v+
 nFlLiRRFcEJB4NTy5o7UapQi+UW+0KR/t2Qb4BdZT7UM7Y11SHWPt3jrpaciGIbzEa02
 3rYfAs3I7KeFekoSp1h16nEPhhKZRmISt1ayJSzTjEsVWMgCDM9xiKS4DhSkjvdhLHsB
 vsjw==
X-Gm-Message-State: AC+VfDxnyZhR/IfR9rnQxS+IjmQEBZcw3wf7UD929Uz64DANky9GQQRv
 qrkhE1WXIAITncLXsDo7jLZlT8vnh0cMZSIs9TeytPff
X-Google-Smtp-Source: ACHHUZ56f6OKmHoeQaKSzsF8SA7vkIdHR2jzyDOfylxyDFdW1Z96oNrxG3CsGpzeflFdKvG7iXQXPsJhEcdXGcHzVzk=
X-Received: by 2002:a0d:dd01:0:b0:561:9051:d2d3 with SMTP id
 g1-20020a0ddd01000000b005619051d2d3mr24288232ywe.11.1685028121243; Thu, 25
 May 2023 08:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <ed0f3a6a-75f3-c6d5-8eb9-3f1575fc0766@redhat.com>
In-Reply-To: <ed0f3a6a-75f3-c6d5-8eb9-3f1575fc0766@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 25 May 2023 11:21:49 -0400
Message-ID: <CAJSP0QWRLsFyzfP_Hn-frAgh6Xrz_5_JJCoxBQPnY6M60vfLag@mail.gmail.com>
Subject: Re: Performance improvement with
 6d740fb01b9f0f5ea7a82f4d5e458d91940a19ee
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=stefanha@gmail.com; helo=mail-yw1-x1130.google.com
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

On Thu, 25 May 2023 at 06:18, Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com> w=
rote:
> the perf-ci detected and bisected the 6d740fb - aio-posix: do not nest po=
ll handlers - as a performance improvement when using multiple concurrent j=
obs and 4k (22%) as well as 1024k (63%) blocks on aarch64 (on a slow rotati=
onal disk).
>
>     https://ldoktor.github.io/tmp/RedHat-virtlab-arm09/v8.0.0/150-improve=
ment.html
>
> Based on the commit message I guess it's expected so take this just as a =
record of an improvement.

The commit was not intended to change performance and I'm not sure why
it happens!

Thanks for letting me know.

Stefan

