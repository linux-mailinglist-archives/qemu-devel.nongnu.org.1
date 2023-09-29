Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED577B32F1
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 14:58:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmD3j-0002tT-4h; Fri, 29 Sep 2023 08:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qmD3W-0002t0-4s
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 08:57:20 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qmD3S-0001Eq-Kh
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 08:57:16 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4054496bde3so123300755e9.1
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 05:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695992231; x=1696597031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ldrJbBN8+v+vNgQQCx/m+z4EiDwVAsJyCr9L6JE7RzM=;
 b=YWWdbbYeJepfZgwmguTaRXx7Scrw7ljORQEOIm+4pMyYCs7Ilfm07n9J0leRRiA1Dq
 Pspj7m7wD8Ny4jaFyEfYYhVxZHJEiTsy6wJ+CeffrrDwGvO4EcQBB0tTnSv7+57CatLi
 2db5LOtJbGqiuM5XZF0vLc+wgD7hYvr3NCV21rgAz+otTibrXmNyPCSjYNZ4HfifEe3R
 8xiHHjW7P0HgZYf+ppvEGT2de/1x3dQj/lty68mw4rWC8u5NnB0xTJmwm38InAdCxdT6
 2fkr0hKYg5BP39zLDrdvmVfocrUbfAwdrlO0cSQTAj5Uxf/ilVlQo6pRb20yp2HXsFjn
 es6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695992231; x=1696597031;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ldrJbBN8+v+vNgQQCx/m+z4EiDwVAsJyCr9L6JE7RzM=;
 b=hqjZuHT2skHdGMoWuU4QC6wU/yfExFxDr0DgSHQq9iRJ1Xe8IOA0mc7rvWEcIOfmHm
 4cAoGxrKAXoJN6KO1nKEce8vEaYXg1nwQBWqP86NqiVAwJ7IHvq3S52NicD+xw+ptMnd
 uViJns0y/FvILVqgoKmCou+RsMM7WQYM9IotWe1rGXnFizbxsTiZf5WxNQ+cyIP4/ohV
 L3tihBVT0gdZQq2XyxW4r87CDORcEO/nigTgPswJ3F3TcWLCkmWVaFsJSJ+brMcONHWw
 BExSDIiBF/0PJi92okpUxQQkbnB1mX5X1FZvnmKhSC3Q5nt1r1uErRLiNZSH6bAV/bjS
 PO2Q==
X-Gm-Message-State: AOJu0YwJcJbEVwd/pdpt8JB63FEuaUv8AHDRbUmfeBOvYTM3ljWctpex
 TGxmxwfYfxTEcYEw0l93BvsRtJaHiidgInH6PXI=
X-Google-Smtp-Source: AGHT+IGLnejgHD8F4SQlxpLgP61TS/VcUfudd7aWin7URpjOkvbBHJ2os4Z5Db+jgjpx4fPbQ9tTHA==
X-Received: by 2002:a7b:c419:0:b0:401:dc7e:b688 with SMTP id
 k25-20020a7bc419000000b00401dc7eb688mr3917024wmi.6.1695992231459; 
 Fri, 29 Sep 2023 05:57:11 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 x11-20020a1c7c0b000000b003fe1c332810sm1374781wmc.33.2023.09.29.05.57.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 05:57:11 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 96E031FFBB;
 Fri, 29 Sep 2023 13:57:10 +0100 (BST)
References: <20230928075613.875575-1-pbonzini@redhat.com>
User-agent: mu4e 1.11.20; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] Makefile: build plugins before running TCG tests
Date: Fri, 29 Sep 2023 13:57:04 +0100
In-reply-to: <20230928075613.875575-1-pbonzini@redhat.com>
Message-ID: <87msx5p26x.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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


Paolo Bonzini <pbonzini@redhat.com> writes:

> Add back test-plugins and, since it is always defined, do so unconditiona=
lly.
>
> Reported-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Fixes: 2c13c574418 ("configure, meson: move --enable-plugins to meson", 2=
023-09-07)
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

