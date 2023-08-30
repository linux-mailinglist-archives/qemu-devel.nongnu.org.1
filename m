Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4764878D734
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 17:44:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbNME-0004Fh-0y; Wed, 30 Aug 2023 11:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qbNMB-0004FA-Ey
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:43:47 -0400
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qbNLx-00049M-3N
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:43:36 -0400
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-34ccedcc584so2643675ab.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 08:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1693410205; x=1694015005;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jlpAzn+ryQ1470M30ft/2xJksecIGbaNT6KlHUeD4Rw=;
 b=kbeTXmRwepecjRkX0bnyw1W+/oDkY/E314cTt2VhDmEFPWn9b05cluw5yYROm3bip2
 l6gHv5AusLQ/1J35AHjHJynFwp5T50ozeX1AA0drn6YdC2y0rQ9wqipYG8lcnV2pnUmG
 xPcZ1HCg+slo7diP9d/6fgNJAs3XiUgiAHRQVdXli24c+0haoXSkfAulogcmrn7Z0A5H
 k4wptYYWsWMlIX7LGXtbRBCcRoi3DIa2Laz+TPf/y+3DtBL4wsQg/RkVnv2b++lamdn7
 YV39mWS4t6ny3oqBi/pxEVI711Sf/IZph5bPOEU3YS6u9kqPYJJnt5/AT6rJqBlTeBTB
 8q2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693410205; x=1694015005;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jlpAzn+ryQ1470M30ft/2xJksecIGbaNT6KlHUeD4Rw=;
 b=gPGw27Z2SVQNL/KJekh8h1OI+et0kiG0zBC2uRCnu78STAQZcVdZpbviZMdj0YCD5L
 f8OvEH587fHwgIUYPBuyapHzTr9CxrdWwidm75Pwezd27Lw1hgoqW0S7pyf9j2OUCNsE
 Ici2Bq+bBF1+/u1lQXLa0RqoLkxNCe8FQ6LIflge8YGRiiYVF95P0U22qpJ8BDlsyinR
 RWspanOx+3kbP21YB1biRgsXOWeNFkCKrMf6vY0mPWG3A33/QnmC77S9iFKorBOUrdNv
 f+ogYhNS0E24oWlJY8fCwsbrdiEaaj95NHMM2PbKp8krt+iRJj0LIGlL7aSlODitDECs
 p8Tg==
X-Gm-Message-State: AOJu0YzZzvvORDRBaywd5yFWvgF3+36nSKcetRJPOdAq6xX7SVJTaLbD
 bHs6KsjIwQ5btF27qSzydE4Cw1H5ldswnRuVhEM=
X-Google-Smtp-Source: AGHT+IE9CMr7MbfB1kpGqstxPb7D1Mw9Q6AArqjd1gzrOzl9Vjnpj84UuXqt0cT5Y6FAj9Pb9g4yhw==
X-Received: by 2002:a92:cf0a:0:b0:346:4f37:9ee7 with SMTP id
 c10-20020a92cf0a000000b003464f379ee7mr5728ilo.13.1693410204813; 
 Wed, 30 Aug 2023 08:43:24 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 h14-20020a92c08e000000b00345e3a04f2dsm3899980ile.62.2023.08.30.08.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 08:43:24 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>
Subject: [PULL 0/1] Quick fix patches
Date: Wed, 30 Aug 2023 09:40:06 -0600
Message-ID: <20230830154007.54297-1-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::12b;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x12b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 813bac3d8d70d85cb7835f7945eb9eed84c2d8d0:

  Merge tag '2023q3-bsd-user-pull-request' of https://gitlab.com/bsdimp/qemu into staging (2023-08-29 08:58:00 -0400)

are available in the Git repository at:

  https://gitlab.com/bsdimp/qemu.git tags/quick-fix-pull-request

for you to fetch changes up to 8a45962be33d4f7449567f8b9e07c724733ca303:

  bsd-user: Move PRAGMA_DISABLE_PACKED_WARNING etc to qemu.h (2023-08-30 08:57:08 -0600)

----------------------------------------------------------------
Pull request: fix ci by fixing clang-user
-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIzBAABCgAdFiEEIDX4lLAKo898zeG3bBzRKH2wEQAFAmTvYpcACgkQbBzRKH2w
EQCKvhAA3nfvm+UMoRbOjFGuOOZKy+HR+nk40rxHa8CzOabbJnx4EtdBZTnNJ+f5
WxLvEIzQw6iLYoqr6Rkcn0MkfYryesDScig7tQW0A87DtivXbDyrRbcmAQuCrcSe
EpEqjBOueiC9xe1U9hzdpNyBkuXQWFUNGKX6swR5vpOEb1hHKzFMY+60vEgcjcjQ
/y7cQcwRJeMNyBEwAM4HSgcVIKxB8ZmIQpIbsWJPAJhEZZE6SvTiKhM0PlZvrwnv
dlEV8F68f3cBka0QmX5JJNJQdXn+2gb2Ix06dm8z7BWtiZoH/rcJ0FfVjMk7bkcC
2e0J0jI9JTf1MKNGHbO8V2YoZw+jCB9nr6N8HEymgla7bK6QPD6LIdTs0i6PUEB8
PUf902NrOS+kbWTGsb9GINegklk3pJ0jnFZagqfCUxARQ2qrqmA6q5vg9d0FjPVl
vJ13weKkSHW126/4Wr23EhUFIoYtiuMjgz/Bjd5TvzhvnVGJiPJaY9sGpgZZ3PJJ
EPCRms5MRut/NE0znKQ9ozAz1FMdVd2XnXeClWJd2NUmGc7ZbBGMcSvUYdC9KLIK
oSQRBTUDgGIdHnB+g367vKs98ir+03gOcpQk9z0fy25wCymmp/Uco8jsm6hCgSGn
x7b9R6/+92xd/IZFZm5N3/llu6JHYPEMhdg8evNp9VTFPoi9PYc=
=jG8p
-----END PGP SIGNATURE-----

----------------------------------------------------------------

Warner Losh (1):
  bsd-user: Move PRAGMA_DISABLE_PACKED_WARNING etc to qemu.h

 bsd-user/qemu.h         | 27 +++++++++++++++++++++++++++
 include/qemu/compiler.h | 30 ------------------------------
 2 files changed, 27 insertions(+), 30 deletions(-)

-- 
2.41.0


