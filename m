Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E0778D206
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 04:27:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbAth-00013O-IW; Tue, 29 Aug 2023 22:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qbAtc-00012c-Sq
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 22:25:29 -0400
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qbAta-00024i-2e
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 22:25:28 -0400
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-34cafafa50eso17710485ab.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 19:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693362323; x=1693967123;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LHGZTzkhp4dykCDiPkYB2fGJ16RjqE3NFFxhIL4xZaU=;
 b=Mw5sFPFnCJNPFRlgYwcgobsrk1R8DAfm+iZ/zAh/z259TgbqImzKcHPCu+xEqeZfh1
 FrR30UAGBDTXDlxP3h/pN8G242ZFWjyNJwwSAqXh/9dnUS8zeQ9OiDM4JI6qu+GPLC2u
 KGo6vn2w7aFLs8vdv9YcHbBZFXHNJgWnxvvFqfrj4hNRfy816fhg38kloAEgDfnH1d8s
 Fb0HhC5zJeXYUgJdGXdnixolNKVgzgdHRvry2ARKzlCfqwJkKUSiELW0F3tv2LU+2kdz
 XBwGd1ncIls66A9A0M2cJE1YCj5+rlu/VNWHC+5V/E8UtV4dEFgDq8FxKzLzGpB0JP3c
 hCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693362323; x=1693967123;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LHGZTzkhp4dykCDiPkYB2fGJ16RjqE3NFFxhIL4xZaU=;
 b=BsxXk8tt+b/Z6FS+zr91jjeOKfyEfUsNzTQy2F5EhevFswBCi15AxgrrCJxib/EWtj
 n13fltnoMlDN5sxMTroZgwu+azcRJg/SshRB6Ed0qZ/qRtL7wh+jqiG/edgBTtWwvnXK
 qAmQYqagqKswFQxTmXiR+Jw7sR6TXVJzk+yCwZCcBkJ7UWJCDpesg/JW+qTDo01HNXnl
 tZ+1UXBEl3DAOMsfnEVSuwmyllUnjUZBzWgzSppKjENhJo0Kn1Rh4F59Sb9plV+lS6ie
 MsGhCKWNSkubvky0I/fhtXOS4B1AygZSAMYdCTXcQdR3apsxXBVBu+Bgx+xOONqHbmYG
 9ZDw==
X-Gm-Message-State: AOJu0YxFSkSvXD7rBkdruzRp2lSxdgz1t7hNfWLzz+8sTX1bJROwxCqR
 8fblS8bpQKtp4GoSnskA+iiCEqKgtbWA9wX7WRA=
X-Google-Smtp-Source: AGHT+IEwD1TAtkRvC3GGRpthMOHD78KryXBNp/SBQORWUeO3vGp8W0T2lSBVfbfdonhJs9M2/WgaUw==
X-Received: by 2002:a05:6e02:1aaf:b0:34c:e630:e95 with SMTP id
 l15-20020a056e021aaf00b0034ce6300e95mr1080776ilv.20.1693362323407; 
 Tue, 29 Aug 2023 19:25:23 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 h16-20020a0566380f1000b0042b61a5087csm3369250jas.132.2023.08.29.19.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 19:25:23 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Warner Losh <imp@bsdimp.com>
Subject: [PULL 0/1] Quick fix patches
Date: Tue, 29 Aug 2023 20:22:04 -0600
Message-ID: <20230830022205.57878-1-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::12f;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x12f.google.com
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

for you to fetch changes up to de287fb4e8987b32e133f7f37b990e09f3aa6325:

  linux-user: Move PRAGMA_DISABLE_PACKED_WARNING to compiler.h (2023-08-29 20:12:25 -0600)

----------------------------------------------------------------
Pull request: Quick fix for clang user-mode job

Move the linux-user version of PRAGMA_DISABLE_PACKED_WARNING
to qemu/compiler.h and remove it from linux-user/qemu.h.
-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIzBAABCgAdFiEEIDX4lLAKo898zeG3bBzRKH2wEQAFAmTup4sACgkQbBzRKH2w
EQChXw/9H/hKENL0vLz9LE1iq05+bJ6/uY/Kl4avXX3/ZBq39/ZvNHrgT6h26PMb
wU2vFYFL8UTZQsfC8t35B1khmoK3ZUtbTYYUjzpmVQQA1+MGNpflgciSQhsITGkG
zOraHo9kSkM/ByHE246zSxqJlgHTziE/mQ1Hg8AFNvI5KChgedMblFz4gu99ADMA
sVQwBUTAeOJv3uvY9DhXCxtvg5Lj+ZcJd7Uu4pYl86jHp0RSE7Jk6jrJXo+Xp3GF
MnDxK9IrShEmIK1ci+tG8YBiY91GW/GEPVJJxL03JsvWxuRhj8GQsIopD1Mo4xbp
mniDs6AbDTpxnE3DpqrN8UFh+3Ko0qZw+/OjCxckYbQadYrWVeL6n+uHxcs15Z+R
SmIURzBrcLqzvFmvpUD4KHBQxSdIGdZrCQA+PC54Ghx0tqBBPapd/4LPL5kJsVqX
6DOYwegbbnDNcGIXv/5RXoL+sIF00mWpWslV+xCrTP5Dz9KQmjSC/fgPnNucr2H5
MBbe0BAxZvn1KHbgUhxCVNd1WFyaq1Gu5XZRNsXy0BBs5/NzkrJm614JOLbS+jtO
DgvEHvbo57LGB145IBZQOUfAUQUnizyUhb27cK+L8hzg3MHsMG+coQyi5I4zaBGn
5JddIPvbpUFk9mS+i9oeZRr/gPmDgPbylaOQhNGQvYpu8xB8/lU=
=QC7n
-----END PGP SIGNATURE-----

----------------------------------------------------------------

Warner Losh (1):
  linux-user: Move PRAGMA_DISABLE_PACKED_WARNING to compiler.h

 include/qemu/compiler.h |  6 +-----
 linux-user/qemu.h       | 26 --------------------------
 2 files changed, 1 insertion(+), 31 deletions(-)

-- 
2.41.0


