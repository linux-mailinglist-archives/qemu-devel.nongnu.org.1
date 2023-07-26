Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEE5762D03
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 09:17:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOYkP-0008KT-2G; Wed, 26 Jul 2023 03:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qOYk7-0008Ju-25
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 03:15:31 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qOYk4-0005AC-Uf
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 03:15:30 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 313EA163F1;
 Wed, 26 Jul 2023 10:15:28 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9BBC5196F3;
 Wed, 26 Jul 2023 10:15:24 +0300 (MSK)
Message-ID: <fc51603b-c89a-c3d5-f59c-c191847c6c1d@tls.msk.ru>
Date: Wed, 26 Jul 2023 10:15:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: how to build qemu 8.1 - keycodemapdb?
Content-Language: en-US
From: Michael Tokarev <mjt@tls.msk.ru>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Michael Roth <michael.roth@amd.com>
References: <efc23b6f-861f-43eb-a4b4-900f45e77ef6@tls.msk.ru>
 <93e9c611-9453-e1d2-5b18-547c76f70c6c@tls.msk.ru>
In-Reply-To: <93e9c611-9453-e1d2-5b18-547c76f70c6c@tls.msk.ru>
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

26.07.2023 09:41, Michael Tokarev wrote:

> Looks like scripts/make-release.sh needs some updating.

make-release.sh apparently does the right thing. But the published
tarball does not include the 3 required sub-projects anyway.

Is it about how the release is made?  What is used to make the
actual release tarball, is it not make-release.sh?

/mjt

