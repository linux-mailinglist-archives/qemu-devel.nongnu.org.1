Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC687423C1
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 12:12:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEodk-00064u-RH; Thu, 29 Jun 2023 06:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qEodi-00064e-2U
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 06:12:38 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qEodg-0003og-GE
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 06:12:37 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3F63310032;
 Thu, 29 Jun 2023 13:12:35 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 89473103A9;
 Thu, 29 Jun 2023 13:12:34 +0300 (MSK)
Message-ID: <3e79215c-2d21-580a-db52-3b1b5df1032b@tls.msk.ru>
Date: Thu, 29 Jun 2023 13:12:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [qemu-web PATCH] Fix installation instructions for Debian/Ubuntu
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
References: <20230629080234.179687-1-thuth@redhat.com>
 <305b3e1f-aa55-8efe-8394-7c1b90ffe3f3@tls.msk.ru>
 <1f0afdee-09f0-83a5-f8fb-d2b86827ba16@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <1f0afdee-09f0-83a5-f8fb-d2b86827ba16@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.089,
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

29.06.2023 12:31, Thomas Huth wrote:
..
>> This is actually a question to QEMU upstream, - I think the same reasoning
>> applies there as well.
> 
> Looking at our docs, it seems like we're lacking an introduction to the the "configure" switches like --enable-system and --enable-user completely, 
> indeed :-(

When I come to qemu 10+ years ago, it was somehow very
difficult to understand what's qemu-user and what's
qemu-system.  Now it is obvious, like breathing, but
that's after 10+ years.. ;))

/mjt


