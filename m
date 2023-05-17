Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA9C7064BC
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 11:57:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzDtM-0005Wb-15; Wed, 17 May 2023 05:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzDtI-0005WL-UA; Wed, 17 May 2023 05:56:16 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzDtG-0001ZX-Ra; Wed, 17 May 2023 05:56:16 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6B8FB6952;
 Wed, 17 May 2023 12:56:11 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id BDCE75FAA;
 Wed, 17 May 2023 12:56:10 +0300 (MSK)
Message-ID: <82ce4d27-a978-2af8-e467-1a0e7e2534e3@msgid.tls.msk.ru>
Date: Wed, 17 May 2023 12:56:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8.0.1 00/36] Patch Round-up for stable 8.0.1, freeze on
 2023-05-27
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20230517073442.3622973-0-mjt@msgid.tls.msk.ru>
 <62a36798-0088-720a-698a-31394b9c25aa@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <62a36798-0088-720a-698a-31394b9c25aa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.666,
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

17.05.2023 11:41, Thomas Huth wrote:
..
> I'd like to suggest:
> 
>   970641de01908dd09 s390x/tcg: Fix LDER instruction format

This smelled merely cosmetic, I decided to pick it up but didn't, for some reason.
Picked up now.

>   c70bb9a771d467302 docs/about/emulation: fix typo

I tend to avoid picking such just-typo fixes. One thing is when
the original text is wrong or misleading, another is when it is
trivially understandable what it meant.  Picked this one up anyway.

>   88693ab2a53f2f3d2 s390x/pv: Fix spurious warning with asynchronous teardown
> 
>   80bd81cadd127c1e2 util/async-teardown: wire up query-command-line-options
>   (only if it is not too cumbersome to pick, but without this the option is
>   useless for libvirt)

Picked up both, there's just one context conflic~t in docs/about/deprecated.rst.

Thank you for pointing these out!

/mjt

