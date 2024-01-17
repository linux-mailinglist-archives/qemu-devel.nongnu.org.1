Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3226C83065E
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 13:59:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ5UT-0001kG-Nz; Wed, 17 Jan 2024 07:57:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rQ50i-0006gL-O0
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 07:27:12 -0500
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rQ50h-0007vz-A9
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 07:27:12 -0500
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3606dda206aso57158085ab.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 04:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705494429; x=1706099229; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CB/uKWAy2009oZqKN+62zORTKmV/MAzqXizHFj7KY5w=;
 b=BfjIahahbMTVE9hDNpCBe3VSFXtPWRGj0TvMO31KjysPyjZcvIsJa8mSb1lhSjcJGm
 xJuXbNepBO+biXwG5+nrooYdXPTpUj7lzB/A+4fx6tspeXUmitBwnzefW7eXIN8tfEIE
 b3H9kpaqKBb2+9YYO3ulLlk+EsNFRdL3mJ/YP/a9LUoYCQbv5OUm5F3sosGMffpX1mYM
 lyzBo4+iEQFh/LlM7BgWkDOZzDyV7w+lmQKs+h56tPdqYjnmiCPM22lKvBI2L4x2L0BQ
 egUjsXABB9YGs07MaLVkbYjvs7IhVxSxlzz/wI9SS/UB4++CUurINFYTRwGSN0KeQyS1
 hIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705494429; x=1706099229;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CB/uKWAy2009oZqKN+62zORTKmV/MAzqXizHFj7KY5w=;
 b=tbnlZidp18J+T/AoiIEQVhfAwMMcmo2Vv5QGx9HnJ90AZPfIsIOeYqCamhdx5a7ccr
 +ezgowofH6pWe/xoTunW7u+fAXBV4IQ1hPdmcWuJ+oFVk17C5DLBgWIR8z7/2AD7UU0V
 fsnqjnKC93yeHCvisy6/b6EEpfKMWNvwlrii7kMwFRayGQYm8Mz5VKnAKkdISi9hx3Tj
 M8eW6GEzYqi46MwDr55C2EzYNS7roqtd7gns2FrLe9IOSkdM9Rl5wUgYxIBPyRiraeXs
 UYJWzLEtrAV79rV0/udW/+LhWxOp1tDeOOps2mMCQ1RJ8XHcnvA0jAUHaSHbz8aPG6lm
 n7QA==
X-Gm-Message-State: AOJu0YzrFxXr98fq5S3pB9vm4Hd2Vk2jMo1jiUv4WFwcdyVK9GN6UsIZ
 10srWtgT8V3jqQDojX85y+gdDGJKrjgBkEn2k1mKugeEzls=
X-Google-Smtp-Source: AGHT+IHkEPVNCJHyIRGEoQqrGHXlnF2IO9uj4B7yQTww6xrwOe37TlTHPrSYI1indXe5eH+T/oqdJYrx6dz+cmcImno=
X-Received: by 2002:a05:6e02:509:b0:360:2db:b47c with SMTP id
 d9-20020a056e02050900b0036002dbb47cmr10185224ils.19.1705494429638; Wed, 17
 Jan 2024 04:27:09 -0800 (PST)
MIME-Version: 1.0
From: Manolo de Medici <manolodemedici@gmail.com>
Date: Wed, 17 Jan 2024 13:27:05 +0100
Message-ID: <CAHP40mmqdyrMyzaPTHMCx2nzeNGg6G=HY_qUyniddpE+g8RNzQ@mail.gmail.com>
Subject: [PATCH 0/4] Port qemu to GNU/Hurd
To: qemu-devel@nongnu.org
Cc: bug-hurd@gnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::135;
 envelope-from=manolodemedici@gmail.com; helo=mail-il1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 17 Jan 2024 07:57:54 -0500
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

Recently, a testsuite for gnumach, the GNU/Hurd microkernel, was developed
that uses qemu. Currently qemu cannot be compiled for the GNU/Hurd, as such,
this testsuite is available only for GNU/Linux users. As such, porting qemu to
GNU/Hurd became an urgent requirement.

This patcheset represents the minimal effort to make qemu compilable and
running in GNU/Hurd. With this patchset applied, qemu can be compiled with
the '--disable-tpm' and the '--disable-tests' configure options.

Please review, thanks,

Manolo de Medici (4):
  Allow tests to be disabled
  Add the GNU/Hurd as a target host
  Include new arbitrary limits if not already defined
  Avoid multiple definitions of copy_file_range

 block/file-posix.c   | 2 +-
 configure            | 9 +++++++++
 include/qemu/osdep.h | 8 ++++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

--
2.43.0

