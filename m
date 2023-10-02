Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C61B7B52C0
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 14:11:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnHlF-00043C-Kb; Mon, 02 Oct 2023 08:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnHkv-00042o-Bx; Mon, 02 Oct 2023 08:10:34 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnHki-0005D4-R6; Mon, 02 Oct 2023 08:10:33 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8751D26BF0;
 Mon,  2 Oct 2023 15:11:00 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9C6322C292;
 Mon,  2 Oct 2023 15:10:17 +0300 (MSK)
Message-ID: <24df29be-eb3f-0783-335c-3a77cc957d57@tls.msk.ru>
Date: Mon, 2 Oct 2023 15:10:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1] roms: use PYTHON to invoke python
Content-Language: en-US
To: Olaf Hering <olaf@aepfle.de>, qemu-devel@nongnu.org
References: <20231002101844.13799-1-olaf@aepfle.de>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20231002101844.13799-1-olaf@aepfle.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.321,
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

02.10.2023 13:18, Olaf Hering:
> python3 may not be the expected python version.
> Use PYTHON to invoke python.

Applied to my trivial-patches tree, thanks!

/mjt

> Fixes: 22e11539e1 ("edk2: replace build scripts")
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> 
> diff --git a/roms/Makefile b/roms/Makefile
>   
>   efi:
> -	python3 edk2-build.py --config edk2-build.config \
> +	$(PYTHON) edk2-build.py --config edk2-build.config \
>   		--version-override "edk2-stable202302-for-qemu" \
>   		--release-date "03/01/2023"



