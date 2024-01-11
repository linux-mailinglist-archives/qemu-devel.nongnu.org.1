Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B29BF82B1FF
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 16:42:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNxBE-0005D6-MH; Thu, 11 Jan 2024 10:41:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNxBC-0005CP-SF
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 10:41:14 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNxBB-0005t4-0y
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 10:41:14 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5534dcfdd61so9688819a12.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 07:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704987671; x=1705592471; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iEz7sPILT/HMrC7NOzt7pd9/3qFxaGBIjK04DG6KQo8=;
 b=WpRC2Xph05dC0SMDf8VLXWWeTVUeVw4bZGKbizFFUYWTpzcg3Sny6ig9g+iffbojiD
 M44QOzF24iZMsGBS1sqMVs1GrjPgJlLHAVaFQ6XZkO9E3cqj2gYrKbrNPQGuyrd40rg1
 GND0vLw5HW6WqUM7GjLX7rJSCq34H2onB3PQjkueewIFxqxuZdXXQBk1R4CG6H0HaRj4
 5aK5rtLM3IdINls5zwm5Hu0L77EjboC+7u2zBRyx/G1LYuO6puiR46pZ3uQD18nTIsc1
 2yfu/pFzMVDabBuLVg6DCyOAZ2z6BFgzThNRvAKc9V7l8T8FloT9EpjiZofzL845UUKd
 NGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704987671; x=1705592471;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iEz7sPILT/HMrC7NOzt7pd9/3qFxaGBIjK04DG6KQo8=;
 b=rxrTM3SZbAIHMG5yE9PL1Ruo/n/IrMftpM/2MKTuQoviQNFn3Ucd3mujWIoHATrS5R
 qAEYI0lsBp5DPQQelML36Nk66jjXB2WOZU+OaUtDVx1CHtM/UlywHA5Ut5hqXJpgpmIi
 nDQbSiUjSNeWdB0FuqV5oCu0qrujRM8JTqC2XBIiXkCoQGXRi6S/8FhQ12X2ylWnSVZX
 ey6DBqNJx1Gr9I4/JYayWe0B3KAFnTPS02SusQUvv+0kgOdFZArVdGRJ+H0jKg6K+8Uc
 m2oPdG4Ol/2RCHjobRCT+moWaDRPm/WhcJI6xbNHbLidk5T6YZfrUp+3pdlr5jzLSxVL
 Hd5A==
X-Gm-Message-State: AOJu0Ywsblnu/s9pU92rTMIR1CgRdStKCHWlGK11s8dIXz2xZmHMftag
 IQv0ZLKWHzoe5AowwGMiXEB0T4XR/3Jw1ZDdRat2/QipKFmZkg==
X-Google-Smtp-Source: AGHT+IFmYQwcvByHnAdTd1OAPfy2GUwnbqx39gK260JlZskM+pgrBlPAbvyV+jQ0qdMTUPqB79X5L//PGYKkKPZZS3c=
X-Received: by 2002:a05:6402:34c6:b0:557:de62:4be0 with SMTP id
 w6-20020a05640234c600b00557de624be0mr10621edc.28.1704987671033; Thu, 11 Jan
 2024 07:41:11 -0800 (PST)
MIME-Version: 1.0
References: <20230721104437.1199866-1-gshan@redhat.com>
 <CAFEAcA9Sr=eE6PNR7e4jnGVj65wnFgDfbUTHpm+PzSU_5Fy+HQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9Sr=eE6PNR7e4jnGVj65wnFgDfbUTHpm+PzSU_5Fy+HQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2024 15:41:00 +0000
Message-ID: <CAFEAcA-8aTiMNr1op_DDMcZmT+FLyQb7mV0YEh4Eq_DsG73rsw@mail.gmail.com>
Subject: Re: [PATCH] numa: Skip invalidation of cluster and NUMA node boundary
 for qtest
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, eduardo@habkost.net, 
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com, 
 imammedo@redhat.com, pbonzini@redhat.com, shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Fri, 21 Jul 2023 at 12:29, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 21 Jul 2023 at 11:44, Gavin Shan <gshan@redhat.com> wrote:
> >
> > There are warning messages printed from tests/qtest/numa-test.c,
> > to complain the CPU cluster and NUMA node boundary is broken. Since
> > the broken boundary is expected, we don't want to see the warning
> > messages.
> >
> >   # cd /home/gavin/sandbox/qemu.main/build
> >   # MALLOC_PERTURB_=255 QTEST_QEMU_BINARY=./qemu-system-aarch64           \
> >     G_TEST_DBUS_DAEMON=../tests/dbus-vmstate-daemon.sh                    \
> >     QTEST_QEMU_IMG=./qemu-img                                             \
> >     QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon \
> >     tests/qtest/numa-test --tap -k
> >       :
> >     qemu-system-aarch64: warning: CPU-0 and CPU-4 in socket-0-cluster-0   \
> >     have been associated with node-0 and node-1 respectively.             \
> >     It can cause OSes like Linux to misbehave
> >       :
> >
> > Skip the invalidation of CPU cluster and NUMA node boundary when
> > qtest is enabled, to avoid the warning messages.
> >
> > Fixes: a494fdb715 ("numa: Validate cluster and NUMA node boundary if required")
> > Signed-off-by: Gavin Shan <gshan@redhat.com>
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Looks like this got lost last year. I'm going to pick it up and
apply it since the warnings it suppresses are still in the
test output.

thanks
-- PMM

