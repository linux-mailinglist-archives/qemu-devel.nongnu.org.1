Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C4C714863
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 13:14:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3aod-0003av-TW; Mon, 29 May 2023 07:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q3aoa-0003ah-9H
 for qemu-devel@nongnu.org; Mon, 29 May 2023 07:13:28 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q3aoY-0003bY-IY
 for qemu-devel@nongnu.org; Mon, 29 May 2023 07:13:28 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 14BC191AD;
 Mon, 29 May 2023 14:13:23 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 57C8D826A;
 Mon, 29 May 2023 14:13:22 +0300 (MSK)
Message-ID: <91d1dc45-e43c-ce78-cda8-084f9b1bd497@tls.msk.ru>
Date: Mon, 29 May 2023 14:13:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] meson: Avoid implicit declaration of functions
Content-Language: en-US
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
References: <068f343a62de3dbc3764d0ad98111881b04a60d2.1685346951.git.mprivozn@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <068f343a62de3dbc3764d0ad98111881b04a60d2.1685346951.git.mprivozn@redhat.com>
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

29.05.2023 10:56, Michal Privoznik пишет:
> While detecting a presence of a function via 'cc.links()'
> gives desired result (i.e. detects whether function is present),
> it also produces a warning on systems where the function is not
> present, e.g.:
> 
>    qemu.git/build/meson-private/tmph74x3p38/testfile.c:2:34: \
>    warning: implicit declaration of function 'malloc_trim' [-Wimplicit-function-declaration]
> 
> We can check whether given function exists via
> 'cc.has_function()' firstly.

This just slows down the configure step, it looks like.
Shouldn't we use cc.has_function() *instead* of our cc.links(),
but not both?

/mjt

