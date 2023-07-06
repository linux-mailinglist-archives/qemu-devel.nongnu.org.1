Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C6B74A2D9
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 19:09:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHSTY-0000LH-4l; Thu, 06 Jul 2023 13:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qHSTV-0000Kc-Ky; Thu, 06 Jul 2023 13:09:01 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qHSTT-0003ul-Or; Thu, 06 Jul 2023 13:09:01 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8211412195;
 Thu,  6 Jul 2023 20:08:57 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 847BC134CD;
 Thu,  6 Jul 2023 20:08:56 +0300 (MSK)
Message-ID: <dca5c64d-e973-ea7b-89a4-31d73de3bf70@tls.msk.ru>
Date: Thu, 6 Jul 2023 20:08:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] hw/arm/virt-acpi-build.c: Add missing header
Content-Language: en-US
To: Peng Liang <tcx4c70@gmail.com>, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, shannon.zhaosl@gmail.com, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20230706150839.1180137-1-tcx4c70@gmail.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230706150839.1180137-1-tcx4c70@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

06.07.2023 18:08, Peng Liang wrote:
> virt-acpi-build.c uses warn_report. However, it doesn't include
> qemu/error-report.h directly, it include qemu/error-report.h via trace.h
> if we enable log trace backend. But if we disable the log trace backend
> (e.g., --enable-trace-backends=nop), then virt-acpi-build.c will not
> include qemu/error-report.h any more and it will lead to build errors.
> Include qemu/error-report.h directly in virt-acpi-build.c to avoid the
> errors.

Applied to my trivial-patches tree, moving it higher as suggested by Ani
(to sort more alphabetically) and adding the Fixes: line as suggested
by Philippe.

Thanks!

/mjt

