Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA00273CF96
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 10:58:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDLYa-0003Sb-O5; Sun, 25 Jun 2023 04:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qDLYY-0003ST-Ij
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 04:57:14 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qDLYW-0006uC-NI
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 04:57:14 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 43ACEE9A7;
 Sun, 25 Jun 2023 11:57:08 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A47C2F35E;
 Sun, 25 Jun 2023 11:57:07 +0300 (MSK)
Message-ID: <c2917053-e8df-c2bc-9565-6d5f257db901@tls.msk.ru>
Date: Sun, 25 Jun 2023 11:57:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PULL v2 1/3] target/hppa: Fix OS reboot issues
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230624115007.30332-1-deller@gmx.de>
 <20230624115007.30332-2-deller@gmx.de>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230624115007.30332-2-deller@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.09,
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

24.06.2023 14:50, Helge Deller пишет:
> When the OS triggers a reboot, the reset helper function sends a
> qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET) together with an
> EXCP_HLT exception to halt the CPUs.
> 
> So, at reboot when initializing the CPUs again, make sure to set all
> instruction pointers to the firmware entry point, disable any interrupts,
> disable data and instruction translations, enable PSW_Q bit  and tell qemu
> to unhalt (halted=0) the CPUs again.
> 
> This fixes the various reboot issues which were seen when rebooting a
> Linux VM, including the case where even the monarch CPU has been virtually
> halted from the OS (e.g. via "chcpu -d 0" inside the Linux VM).

Is this a -stable material?  It applies cleanly to 8.0 and 7.2.

Thanks,

/mjt

