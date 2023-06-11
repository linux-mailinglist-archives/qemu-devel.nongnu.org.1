Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5A772B2E7
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 18:49:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8OEs-0006wE-LJ; Sun, 11 Jun 2023 12:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q8OEi-0006vG-IZ
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 12:48:20 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q8OEf-0007kt-V0
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 12:48:15 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3A140C02A;
 Sun, 11 Jun 2023 19:48:00 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E4EBCB6D4;
 Sun, 11 Jun 2023 19:47:58 +0300 (MSK)
Message-ID: <baa7eed9-8e39-f454-bad0-e6934ccd0778@tls.msk.ru>
Date: Sun, 11 Jun 2023 19:47:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] target/arm: Handle IC IVAU to improve compatibility
 with JITs
Content-Language: en-US
To: =?UTF-8?Q?John_H=c3=b6gberg?= <john.hogberg@ericsson.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>
References: <833e7382b3fb90a2bbb007932cb5dbb8cfff5a33.camel@ericsson.com>
 <6fc5af6f04a15a84a862b8d65ab3629891234649.camel@ericsson.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <6fc5af6f04a15a84a862b8d65ab3629891234649.camel@ericsson.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.093,
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

11.06.2023 14:53, John Högberg wrote:
...
>   
> +#ifdef CONFIG_USER_ONLY
> +/*
> + * `IC IVAU` is handled to improve compatibility with JITs that dual-
> map their
> + * code to get around W^X restrictions, where one region is writable
> and the
> + * other is executable.

The patches seems to be line-wrap-damaged, and also base64-encoded.
Dunno if it's possible to un-damage it easily...

/mjt

