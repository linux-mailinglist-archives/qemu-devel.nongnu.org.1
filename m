Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE6C79CE74
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 12:36:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg0jp-0003TI-7X; Tue, 12 Sep 2023 06:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qg0jS-0003SI-J9
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:34:58 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qg0jQ-0000DX-46
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:34:58 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6D22A210EF;
 Tue, 12 Sep 2023 13:34:55 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9F9392778E;
 Tue, 12 Sep 2023 13:34:51 +0300 (MSK)
Message-ID: <36562fcb-77f2-2a18-acec-47f155decf71@tls.msk.ru>
Date: Tue, 12 Sep 2023 13:34:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 00/10] linux-user: Detect and report host crashes
Content-Language: en-US
To: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230823051615.1297706-1-richard.henderson@linaro.org>
 <d2e3266e-dbb8-07a6-07d7-008e788c3862@linaro.org>
 <329a2c4b-9fa9-5e73-aa95-57512d60c1ec@gmx.de>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <329a2c4b-9fa9-5e73-aa95-57512d60c1ec@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

12.09.2023 12:45, Helge Deller:

> /usr/bin/ld: /usr/lib/gcc/x86_64-redhat-linux/13/../../../../lib64/libc.a(abort.o): in function `abort':
> (.text.unlikely+0x0): multiple definition of `abort'; 
> libqemu-aarch64-linux-user.fa.p/linux-user_signal.c.o:/srv/_build/../../home/cvs/qemu/qemu/linux-user/signal.c:723: first defined here

[PATCH v4 03/10] linux-user: Use die_with_signal with abort

Sigh.

I'd be double-cautious when overriding system functions like this, - it's
almost always a bad idea.

/mjt

