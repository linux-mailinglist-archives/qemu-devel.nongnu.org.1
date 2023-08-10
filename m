Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 077D27773BE
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 11:10:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU1ev-0006gt-R2; Thu, 10 Aug 2023 05:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qU1et-0006gl-PS
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 05:08:43 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qU1es-0006IW-0K
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 05:08:43 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C86E31982B;
 Thu, 10 Aug 2023 12:08:43 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 10BB11D1D9;
 Thu, 10 Aug 2023 12:08:37 +0300 (MSK)
Message-ID: <38e69323-0185-32bb-2de1-8e5b36de2abc@tls.msk.ru>
Date: Thu, 10 Aug 2023 12:08:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: LTP test related to virtio releasing and reassigning resource
 leads to guest hung
Content-Language: en-US
To: "longguang.yue" <kvmluck@163.com>, qemu-devel <qemu-devel@nongnu.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <461df15f.15e2d.189deaa6eed.Coremail.kvmluck@163.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <461df15f.15e2d.189deaa6eed.Coremail.kvmluck@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -109
X-Spam_score: -11.0
X-Spam_bar: -----------
X-Spam_report: (-11.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-4.14,
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

10.08.2023 11:57, longguang.yue wrote:
> Hi, all:
> A ltp test leads to guest hung(io hung), the test releases virtio device resource and then reassign.
> I find device’s mem prefetchable resource 64-bit is changed.
> 
> ltp 
> test: https://github.com/linux-test-project/ltp/blob/522d7fba4afc84e07b252aa4cd91b241e81d6613/testcases/kernel/device-drivers/pci/tpci_kernel/ltp_tpci.c#L428
> 
> Do you know what cause the problem?
> 
> Thanks very much.
> 
> --------------------------
> ENV: kernel 5.10.0, qemu 6.2

Current qemu is 8.1 (well, almost, to be released this month;
previous release is 8.0 anyway).

This might be interesting to test in a current version before
going any further.

Thanks,

/mjt

