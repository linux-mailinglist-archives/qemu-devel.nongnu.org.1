Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F5C7F17CF
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 16:52:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r56Xq-00022M-Ub; Mon, 20 Nov 2023 10:50:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r56Xn-000224-S5; Mon, 20 Nov 2023 10:50:40 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r56Xm-0008Bx-1q; Mon, 20 Nov 2023 10:50:39 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 24ACD34DA6;
 Mon, 20 Nov 2023 18:50:37 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A6FF336642;
 Mon, 20 Nov 2023 18:50:31 +0300 (MSK)
Message-ID: <dcc0522e-9371-4fb7-ba01-77d30f550712@tls.msk.ru>
Date: Mon, 20 Nov 2023 18:50:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Stable-8.1.3 v2 00/59] Patch Round-up for stable 8.1.3, frozen
 on 2023-11-19
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <qemu-stable-8.1.3-20231119211540@cover.tls.msk.ru>
 <d803f166-8fb1-4a3c-942b-6f2d7fe94903@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <d803f166-8fb1-4a3c-942b-6f2d7fe94903@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

20.11.2023 18:33, Thomas Huth :
...
> Maybe add these in case someone wants to run the Avocado tests with 8.1 and the latest version of Python:
> 
> https://gitlab.com/qemu-project/qemu/-/commit/861f724d03e1748cda1c5b9ec8457a368590cbd5
> https://gitlab.com/qemu-project/qemu/-/commit/f0a663b4ced2bf315936c774c2b6ff398fce8905

Yeah, I already marked these to pick for the next point release
(this one is frozen yesterday), noticed them today in the staging
branch.  Together with python raw strings changes.

Thank you for the suggestion!

/mjt

