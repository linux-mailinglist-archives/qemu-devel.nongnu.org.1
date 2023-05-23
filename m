Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9F370D60D
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:54:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Mp8-0008Lv-WA; Tue, 23 May 2023 03:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q1Mp2-0008Km-VY
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:52:45 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q1Moy-0008DA-Dv
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:52:42 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6B1EB7C3A;
 Tue, 23 May 2023 10:52:28 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id F04CF71FA;
 Tue, 23 May 2023 10:52:27 +0300 (MSK)
Message-ID: <003b1f33-ba01-1c96-52c2-b885cc28de11@tls.msk.ru>
Date: Tue, 23 May 2023 10:52:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] meson: remove -no-pie linker flag
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: vr_qemu@t-online.de, marcandre.lureau@redhat.com
References: <20230522080816.66320-1-pbonzini@redhat.com>
 <e36730f8-5f32-1bfb-b09a-d6943732f0df@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <e36730f8-5f32-1bfb-b09a-d6943732f0df@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

22.05.2023 18:54, Richard Henderson wrote:
..
> -no-pie is a linker flag, but distro folk that didn't quite know what they were doing made local changes to gcc's specs file.  So it *is* a compiler 
> command-line flag, but only for some builds of gcc.

Which distros is that? Debian?
Patching gcc spec file like this - if that's true - is a way to disaster,
and should be stopped.

Thanks,

/mjt
> We can't just remove -no-pie, we need to probe for it as cc.get_supported_arguments instead of cc.get_supported_link_arguments.
> 
> Or something.  It's a mess, for sure.
> 
> 
> r~
> 
> 


