Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CFC76C649
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 09:19:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR67W-0007Yj-Up; Wed, 02 Aug 2023 03:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qR67P-0007Y9-OH
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 03:18:03 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qR67O-0002lY-2z
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 03:18:03 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6bc886d1504so4175170a34.0
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 00:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690960680; x=1691565480;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Tvu6KQ7qKcunwchmnCOmMWwPVTutxDj0/pNXj/mIN20=;
 b=mR5orffc/1HGu1Oi2I423NGIFUKLseqbG2zRxQp5BDvtE7+iS9MtVZLFHyrS+TWOqN
 2eIwtJBxGegrzER9qkCD1RIqShaoV03B4nbsrkFk9QA9LmwBbvtGhtPYtsLAN87zsnMj
 mK8wq7InlwTK908NOAU5UFoQ5KO4geYUhe4fl8TpdjGTK9VDv+yMJ34c/pcB3pEIeRNz
 mXpMkFPWGBOL4T7mQASyeKw72+uBmBLu3sJZn9M0Ptz8JUd5Ok2sXs9TEhz6mGj/4dAJ
 WpBDnqJ2D9AMzAJODaYiEts7oZJcrrztMUpy5orbCe9tDnGObXNBoictEDTg+HR9jDXI
 J5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690960680; x=1691565480;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tvu6KQ7qKcunwchmnCOmMWwPVTutxDj0/pNXj/mIN20=;
 b=d62mXGYfLRIOCjhatE9igarwWckkFE0QoF0Th30PLwjHcSZiqO+rkqWGRZHTjIdLUg
 34APSfjkQxkagci9o9OOTsanotsfnw2QUUclbJZpyBoPo7hX5rFI79vAcp7FdjGUWZwi
 WjB/v6AOFO4CemKILVNbucO5HtfiF7jijs1uS4UF36kyhhnQ/9Cy2G+aqWuCSfGS2KRb
 CrOTAvM0pW3V31zNCyKb5o+PTNcIMWlnA0mrB7r5xf83n2kJeu8wWDmM1hFGZIh75X7j
 mVXF1FaLXWoR12hrR5+uOnG/xQVK8kKy6UXPkPwUo4Skr/+FjuhSmW0j9IduHNcLhW4y
 1QpQ==
X-Gm-Message-State: ABy/qLbCUk/WK1OIyAAMxUzgrsMv0VE5YKUliYaKw3pNnJmsqn+f3pwx
 snoDs1uLEjRYfHNf47dVzsreEw==
X-Google-Smtp-Source: APBJJlF+gKUq56qIkpubevUD+Wcc1YIEyszkOKzcr2QWmMaYZuU4JAr3g0dnubsfriHedGsqZQVxqg==
X-Received: by 2002:a05:6830:1b6d:b0:6b7:1d64:ab84 with SMTP id
 d13-20020a0568301b6d00b006b71d64ab84mr15346474ote.14.1690960680547; 
 Wed, 02 Aug 2023 00:18:00 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 x12-20020a63b20c000000b00528da88275bsm11004440pge.47.2023.08.02.00.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 00:17:59 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Helge Deller <deller@gmx.de>, Joel Stanley <joel@jms.id.au>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 0/6] linux-user: brk/mmap fixes
Date: Wed,  2 Aug 2023 16:17:46 +0900
Message-ID: <20230802071754.14876-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::335;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x335.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

linux-user was failing on M2 MacBook Air. Digging into the details, I found
several bugs in brk and mmap so here are fixes.

V1 -> V2:
  Added reserved_va check. (Richard Henderson)
  Fixed MAP_FIXED_NOREPLACE on old kernels.

Akihiko Odaki (6):
  linux-user: Unset MAP_FIXED_NOREPLACE for host
  linux-user: Fix MAP_FIXED_NOREPLACE on old kernels
  linux-user: Do not call get_errno() in do_brk()
  linux-user: Use MAP_FIXED_NOREPLACE for do_brk()
  linux-user: Do nothing if too small brk is specified
  linux-user: Do not align brk with host page size

 linux-user/elfload.c |  4 +--
 linux-user/mmap.c    | 16 +++++++++--
 linux-user/syscall.c | 67 +++++++++-----------------------------------
 3 files changed, 29 insertions(+), 58 deletions(-)

-- 
2.41.0


