Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D811679CC82
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 11:56:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg06n-0003rN-S8; Tue, 12 Sep 2023 05:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qg06l-0003r0-DK
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 05:54:59 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qg06e-0004bp-5n
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 05:54:59 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-401da71b83cso61554405e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 02:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1694512489; x=1695117289; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qaqiLwRWuKl4WE8YFES1BRLu2De9al968lzrUPS+QQQ=;
 b=Ep/8PPux6fjL+euXM+6rHEjS/SP0bmkXkWgbAV4VX37GNlnW9pnAkEGqWv6D/8gv3+
 nYM7D+VFTrgObenjg1a0guchZlG1ld+zbEen68TmyKvq0dSp0iXcyY92sd0S25Why4UC
 oITUZXUkmTOFYTM6GZoPEKuvQzwRwCIsAkuW0g+vsQB0WXR36LBG1JUDGdeAxTU65pfn
 HPURcFMVWSNMVduzTxVBgumi1NYv/yXkBXmdb1uoLuDolZGqZ/WTXR09gDa/stcVZv82
 orBgb2+VgjtjhJE2TGNaXnzhDqhsOeRW2moRhRuHhS4yY+PyxpWtD8zLaPHlLRZ2h+Uq
 oAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694512489; x=1695117289;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qaqiLwRWuKl4WE8YFES1BRLu2De9al968lzrUPS+QQQ=;
 b=I4n+cg/q/D+s22yr8+/314FPwd54XQnY/Qie/z2ARcfvYVUib4uoLH1973PSYTtwEI
 91qSEm69Qknw3/+kxEkBk0wrxBsMn3xY0JWXi7JrIB44mLW33/7PdvaesLJ6JvsLpE2P
 Joi+PWwNVeeIEQQ74oJy8EdRN/iQXWWYOrLzTEzfwf5YgSAu+/zPV9dLjv7NYqqd3c4h
 8fhTaY9TQAOqzCcrcfbzyeroy7K1fONHWGxnZkcQEHCIRoWwUVMLKOmWugZ7+RJ5I3EP
 JbBhO0orI915JESLdpd88YtQH+JkSEOmJWfTo/eOtj38mmgg5/nGHUx6r4TNhKPpJLWx
 kHew==
X-Gm-Message-State: AOJu0YzoTiPUl1MdWqtgwPllEBH5yqg/fbO6hZmdpPBp/M8easXiCqbR
 4BZYvpGO30qyGUI3f0Pm3vWN7A==
X-Google-Smtp-Source: AGHT+IFSOrOhtFNfZVdLSJsQtlK8uNpridVi9+Z5v/xyz7W33pvp/pZyHl2b4eDohHxuMoDZYW3OgQ==
X-Received: by 2002:adf:e444:0:b0:319:8c35:37b with SMTP id
 t4-20020adfe444000000b003198c35037bmr10284287wrm.7.1694512489371; 
 Tue, 12 Sep 2023 02:54:49 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 q28-20020a056000137c00b0031989784d96sm12418417wrz.76.2023.09.12.02.54.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 02:54:48 -0700 (PDT)
Date: Tue, 12 Sep 2023 11:54:47 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PULL v2 38/45] hw/riscv/virt.c: fix non-KVM --enable-debug build
Message-ID: <20230912-55e50d06c926f1720048eba9@orel>
References: <20230911064320.939791-1-alistair.francis@wdc.com>
 <20230911064320.939791-39-alistair.francis@wdc.com>
 <e44b65ab-ae5a-c5be-c27e-f961a1d878cc@tls.msk.ru>
 <aad03dca-e1d9-b5c5-22a9-6711841a3516@ventanamicro.com>
 <48e7e9bb-1fb5-5233-bdef-c958498b90c4@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48e7e9bb-1fb5-5233-bdef-c958498b90c4@tls.msk.ru>
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x334.google.com
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

On Tue, Sep 12, 2023 at 09:05:41AM +0300, Michael Tokarev wrote:
> 12.09.2023 00:43, Daniel Henrique Barboza:
> > On 9/11/23 16:54, Michael Tokarev wrote:
> ...
> > > >       /* KVM AIA only has one APLIC instance */
> > > > -    if (virt_use_kvm_aia(s)) {
> > > > +    if (kvm_enabled() && virt_use_kvm_aia(s)) {
> > > >           create_fdt_socket_aplic(s, memmap, 0,
> > > ...
> > > 
> > > As has been discovered earlier (see "target/i386: Restrict system-specific
> > > features from user emulation" threads), this is not enough, - compiler does
> > > not always eliminate if (0 && foo) { bar; } construct, it's too fragile and
> > > does not actually work.  Either some #ifdef'fery is needed here or some other,
> > > more explicit, way to eliminate such code, like introducing stub functions.
> > > 
> > > I know it's too late and this change is already in, but unfortunately that's
> > > when I noticed this.  While the "Fixes:" tag can't be changed anymore, a more
> > > proper fix for the actual problem (with the proper Fixes tag now) can still
> > > be applied on top of this fix.
> > 
> > This works fine on current master on my machine:
> > 
> > $ ../configure --cc=clang --target-list=riscv64-softmmu,riscv64-linux-user,riscv32-softmmu,riscv32-linux-user --enable-debug
> > $ make -j
> > 
> > So I'm not sure what do you mean by 'actual problem'. If you refer to the non-existence
> > of stub functions, earlier today we had a review by Phil in this patch here where I was
> > adding stubs for all KVM functions:
> > 
> > https://lore.kernel.org/qemu-riscv/f30d8589-8b59-2fd7-c38c-3f79508a4ac6@linaro.org/
> > 
> > Phil mentioned that we don't need a function stub if the KVM only function is protected by
> > "kvm_enabled()". And this is fine, but then, from what you're saying, we can't rely on
> > (kvm_enabled() && foo) working all the time, so we're one conditional away from breaking
> > things it seems.
> 
> Please see:
> 
> https://lore.kernel.org/qemu-devel/20230911211317.28773-1-philmd@linaro.org/T/#t  (fix v4)
> https://lore.kernel.org/qemu-devel/ZP9Cmqgy2H3ypDf3@redhat.com/T/#t (fix v3)
> https://lore.kernel.org/qemu-devel/28c832bc-2fbf-8caa-e141-51288fc0d544@linaro.org/T/#t (fix v2)
> https://lore.kernel.org/qemu-devel/ZP74b%2FByEaVW5bZO@redhat.com/T/#t (fix v1)
> 
> and the original issue at
> https://lore.kernel.org/qemu-devel/8ee6684b-cdc3-78cb-9b76-e5875743bdcf@tls.msk.ru/T/#m65801e9edf31688a45722271a97e628ec98a0c23
> (this is an i386 pullreq which removed stub functions in presence of (!kvm_enabled() && foo)).
> 
> It is exactly the same issue as this one, with exactly the same fix, which resulted in
> breakage.  I dunno why your build succeeded, but the whole thing is.. not easy.

virt_use_kvm_aia() gets compiled even without KVM enabled since it's in
the same file and not under a CONFIG_KVM or any guard. We're planning on
moving KVM functions to KVM-only files, which will only be compiled with
KVM enabled. We also wanted to remove stubs and just depend on
kvm_enabled() and the compiler, but now it looks like we got overly
excited about that. Considering clang, the stubs will need to stay.

Thanks,
drew

