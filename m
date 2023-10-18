Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCE57CDAB1
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 13:39:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt4rx-0006WW-TI; Wed, 18 Oct 2023 07:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qt4rv-0006WK-DB
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 07:37:43 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qt4rs-0007HC-PJ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 07:37:43 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 960842B548;
 Wed, 18 Oct 2023 14:37:48 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 504BB2FD22;
 Wed, 18 Oct 2023 14:37:29 +0300 (MSK)
Message-ID: <b69ac1a7-f52b-4c0d-b761-da0a8244d4a6@tls.msk.ru>
Date: Wed, 18 Oct 2023 14:37:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 17/32] meson, cutils: allow non-relocatable installs
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20231018082752.322306-1-pbonzini@redhat.com>
 <20231018082752.322306-18-pbonzini@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20231018082752.322306-18-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

18.10.2023 11:27, Paolo Bonzini wrote:
> Say QEMU is configured with bindir = "/usr/bin" and a firmware path
> that starts with "/usr/share/qemu".  Ever since QEMU 5.2, QEMU's
> install has been relocatable: if you move qemu-system-x86_64 from
> /usr/bin to /home/username/bin, it will start looking for firmware in
> /home/username/share/qemu.  Previously, you would get a non-relocatable
> install where the moved QEMU will keep looking for firmware in
> /usr/share/qemu.
> 
> Windows almost always wants relocatable installs, and in fact that
> is why QEMU 5.2 introduced relocatability in the first place.
> However, newfangled distribution mechanisms such as AppImage
> (https://docs.appimage.org/reference/best-practices.html), and
> possibly NixOS, also dislike using at runtime the absolute paths
> that were established at build time.
> 
> On POSIX systems you almost never care; if you do, your usecase
> dictates which one is desirable, so there's no single answer.
> Obviously relocatability works fine most of the time, because not many
> people have complained about QEMU's switch to relocatable install,
> and that's why until now there was no way to disable relocatability.
> 
> But a non-relocatable, non-modular binary can help if you want to do
> experiments with old firmware and new QEMU or vice versa (because you
> can just upgrade/downgrade the firmware package, and use rpm2cpio or
> similar to extract the QEMU binaries outside /usr), so allow both.
> This patch allows one to build a non-relocatable install using a new
> option to configure.  Why?  Because it's not too hard, and because
> it helps the user double check the relocatability of their install.
> 
> Note that the same code that handles relocation also lets you run QEMU
> from the build tree and pick e.g. firmware files from the source tree
> transparently.  Therefore that part remains active with this patch,
> even if you configure with --disable-relocatable.

Thank you very much for this Paolo.  It was on my todo list for quite
some time :)

/mjt

