Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1847773A33
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 14:40:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTM0P-00025F-4D; Tue, 08 Aug 2023 08:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qTM0K-000236-Co
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 08:40:05 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qTM0E-00044r-DS
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 08:40:00 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3CBFD19065;
 Tue,  8 Aug 2023 15:40:00 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E4F291C6D3;
 Tue,  8 Aug 2023 15:39:56 +0300 (MSK)
Message-ID: <5fca59cd-4995-fbd3-2c20-b0778b2e18c0@tls.msk.ru>
Date: Tue, 8 Aug 2023 15:39:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 1/3] configure: fix detection for x32 linux-user
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, iii@linux.ibm.com,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230808120303.585509-1-pbonzini@redhat.com>
 <20230808120303.585509-2-pbonzini@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230808120303.585509-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

08.08.2023 15:03, Paolo Bonzini wrote:
> x32 uses the same signal handling fragments as x86_64, since host_arch
> is set to x86_64 when Meson runs.  Remove the unnecessary forwarder and
> set the host_arch variable properly in configure.

Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>

/mjt

