Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA2575C5DF
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 13:30:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMoJy-0004HM-PL; Fri, 21 Jul 2023 07:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMoJw-0004H2-EK
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 07:29:16 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMoJu-0005PF-R2
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 07:29:16 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-521dd3d93bbso2095566a12.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 04:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689938953; x=1690543753;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=opb+4yG0xu0Weds/zVLnpF98J7OYIWUqtQUmL0ELKN0=;
 b=lJqEXKaob5vwzvGfOunwLyzPgbsrJdW5Niaoxz1nqtKwBG1U5OQ/RL0dvI8MizM5CQ
 kcd446EMsK7vj5szodbw/KvQliAIjW0/xCqmPfWsL4qKqBbI5WpRoTCvbcbBAcQH3LxH
 XuoNmH1x4+a0RUqnNYKYA5yVFG4a2PuxdMpE14q9ZCnS5xzNrYZY82+idAi5Ta6iciMX
 2J0zJzdw5XAql7g8sR61DBLQD8Pj1RbitWzM2zbbqG3MEKgyBN7V2WxKyLgm8oT+RqM9
 k2lwcvYlPkPqpfkAQja17G/TuhKE6ooUyEjgKk0KAD6IqjXgw/9WXCARHPzSOaqjqaDx
 n7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689938953; x=1690543753;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=opb+4yG0xu0Weds/zVLnpF98J7OYIWUqtQUmL0ELKN0=;
 b=ebZ19qB9FZfyxBuCY39YjOG1FZGkLdibtgWzn7xHWRbMlHu+1rQXJOo6ATLe5sKKPp
 PCH/LFqbeRSbCQ2NQZbhqsoCdXkDe1yaQDg7rCgrkpGKaS54FSpaGax0hBq1wlo3AQDI
 BXmeWjMJbjUEIajza6wOYfEOlxYuWKalHGSfYG74+fd8/r7tT3DHzgrUpjohCAElZ3iu
 epYuvLFclfH9DlLkUkTP1rnhrltMRGX4h11+FOotYCrgWErswrkB/MRZv6HYqibs2bBc
 AZvSAmD+Jq0UkE1resU4ywjilE5f+I2hqnrrasj6En67dLHRaMElTDaUVie789sL59pS
 K5Cw==
X-Gm-Message-State: ABy/qLZc9oKy1mjHjAVHS0Tuik3d9TC5fQhcWpXWbaEzBDOw7tNKddlj
 94do270TUmfH6vWN8HUwf6ECfHGV1RGU/fYy41fPug==
X-Google-Smtp-Source: APBJJlE4LzkpUcEvrQpEw1/RAqQypBS+3Oc4InjPqCrWH4aHlgIXZ1Eg5MTipr8Z5+pr0PF2R4iC5QRY4faQLc4FsHk=
X-Received: by 2002:aa7:d9d7:0:b0:51e:17d:a1c3 with SMTP id
 v23-20020aa7d9d7000000b0051e017da1c3mr1278080eds.32.1689938953056; Fri, 21
 Jul 2023 04:29:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230721104437.1199866-1-gshan@redhat.com>
In-Reply-To: <20230721104437.1199866-1-gshan@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jul 2023 12:29:01 +0100
Message-ID: <CAFEAcA9Sr=eE6PNR7e4jnGVj65wnFgDfbUTHpm+PzSU_5Fy+HQ@mail.gmail.com>
Subject: Re: [PATCH] numa: Skip invalidation of cluster and NUMA node boundary
 for qtest
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com, 
 imammedo@redhat.com, pbonzini@redhat.com, shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Fri, 21 Jul 2023 at 11:44, Gavin Shan <gshan@redhat.com> wrote:
>
> There are warning messages printed from tests/qtest/numa-test.c,
> to complain the CPU cluster and NUMA node boundary is broken. Since
> the broken boundary is expected, we don't want to see the warning
> messages.
>
>   # cd /home/gavin/sandbox/qemu.main/build
>   # MALLOC_PERTURB_=255 QTEST_QEMU_BINARY=./qemu-system-aarch64           \
>     G_TEST_DBUS_DAEMON=../tests/dbus-vmstate-daemon.sh                    \
>     QTEST_QEMU_IMG=./qemu-img                                             \
>     QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon \
>     tests/qtest/numa-test --tap -k
>       :
>     qemu-system-aarch64: warning: CPU-0 and CPU-4 in socket-0-cluster-0   \
>     have been associated with node-0 and node-1 respectively.             \
>     It can cause OSes like Linux to misbehave
>       :
>
> Skip the invalidation of CPU cluster and NUMA node boundary when
> qtest is enabled, to avoid the warning messages.
>
> Fixes: a494fdb715 ("numa: Validate cluster and NUMA node boundary if required")
> Signed-off-by: Gavin Shan <gshan@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

