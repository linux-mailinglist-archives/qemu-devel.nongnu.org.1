Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED897F086B
	for <lists+qemu-devel@lfdr.de>; Sun, 19 Nov 2023 20:13:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4nDH-00048Q-SK; Sun, 19 Nov 2023 14:12:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1r4nDF-00048I-8g
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 14:12:09 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1r4nDD-00071S-NJ
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 14:12:09 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6cb9dd2ab56so139260b3a.3
 for <qemu-devel@nongnu.org>; Sun, 19 Nov 2023 11:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700421126; x=1701025926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DzmVfem62qgerqreutq8SnzzvoC2pY3k7WUyEkKbYWI=;
 b=M01e9tBkKSzh1zrY/6jY1GW02bD8BVbubWgkrLwuY6Lh+EbuRz+PgDICfJOODFNpk/
 dsBMz8dpEV/JFDPgSpTs53BvRWrbPjTKLmBUHSPVsyE8PWsG6QEudklvyWtrxMM2ZPaO
 fdknE7ss7l+46YAL3fSoYR7klRy3X6kwYjZZzJQDbz4yTKafjiPm9lEljFFaRMbvUuqE
 f/H2rXDRyoaQF6K9GUx+a3V/UhN5Rc1ZsW4Pwo3QkUgxFhTlcsBgjirDA5f1pyEFwzlc
 TG6R03dCevs2LbaDI2exsJv+KZYKsBOWVMbTDonojc+4sApX49v4Z+QvrFEoffveq74v
 SHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700421126; x=1701025926;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DzmVfem62qgerqreutq8SnzzvoC2pY3k7WUyEkKbYWI=;
 b=vlguTJb3a4ogoNxfKc2lLRO5KccD38u6YMJP6aXFFhRr6hLP9XtuXGwgFsFecXgNEY
 z43d2SDlxY4N7UqMWT7KpEoGbNXwL1Nw/HHubp3RcT1LTKeCC0TSPfH0cLWBiKYF62E5
 x5+MujM4gijRpxJ8RQa5CurwrPf/gt++8csQrTkzcpYY5NHZIKEUj3LH+PWFvE1cC0aG
 e4VdSfY6lmraalRacuhkcagdz9XXcRUtPaEU5b4Is60plZVJc5g0Aj9QJeTbnOI4E2Jr
 rN+19ygpnWq2BPQnn9mnrOwAjQpT0pAEtp1YR/585YRGUWB3uhSfcNltCFUxfGx70flB
 yvxg==
X-Gm-Message-State: AOJu0YxcW8Z4O6/i2Oae1XxqeOjpAkYRnuV1kFKVnl+l5drdTSq4w8+D
 s5I3CPzPrWc1DMaSh9MklTQTyELLWI4=
X-Google-Smtp-Source: AGHT+IFhI8haCaEaWDxafFyN+PaVFWsmU8fYXRwVGcGaeQ/9OauF6Zt5MA8lhxwzE7FjvgONDPmNUw==
X-Received: by 2002:a05:6a21:144e:b0:187:4118:141 with SMTP id
 oc14-20020a056a21144e00b0018741180141mr3573807pzb.5.1700421125697; 
 Sun, 19 Nov 2023 11:12:05 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net
 ([2601:646:a201:19d0:85eb:a1c:1b3a:a140])
 by smtp.gmail.com with ESMTPSA id
 x4-20020a170902ea8400b001b3bf8001a9sm4628680plb.48.2023.11.19.11.12.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 11:12:05 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 0/1] target/xtensa fixes for v8.2
Date: Sun, 19 Nov 2023 11:11:52 -0800
Message-Id: <20231119191152.848781-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The following changes since commit 9c673a41eefc50f1cb2fe3c083e7de842c7d276a:

  Update version for v8.2.0-rc0 release (2023-11-14 12:35:47 -0500)

are available in the Git repository at:

  https://github.com/OSLL/qemu-xtensa.git tags/20231119-xtensa-1

for you to fetch changes up to 1b173d06068c4a4e93fad88205399232925967a4:

  linux-user: xtensa: fix signal delivery in FDPIC (2023-11-19 10:56:26 -0800)

----------------------------------------------------------------
target/xtensa fixes for v8.2:

- fix signal delivery in FDPIC

----------------------------------------------------------------
Max Filippov (1):
      linux-user: xtensa: fix signal delivery in FDPIC

 linux-user/xtensa/signal.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

