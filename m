Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F137A03FF
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 14:36:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qglZr-0005ZE-8r; Thu, 14 Sep 2023 08:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qglZp-0005Yp-4W
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 08:36:09 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qglZn-0000TS-Gf
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 08:36:08 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BB88421E30;
 Thu, 14 Sep 2023 15:36:13 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id DA66528169;
 Thu, 14 Sep 2023 15:36:05 +0300 (MSK)
Message-ID: <136fa9c2-b743-ef11-3c7c-b3cef6771d9e@tls.msk.ru>
Date: Thu, 14 Sep 2023 15:36:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3] hw/cxl: Fix out of bound array access
Content-Language: en-US
To: Dmitry Frolov <frolov@swemel.ru>, jonathan.cameron@huawei.com,
 fan.ni@samsung.com, qemu-devel@nongnu.org
Cc: sdl.qemu@linuxtesting.org
References: <20230913175649.00001447@Huawei.com>
 <20230914070635.1141840-1-frolov@swemel.ru>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230914070635.1141840-1-frolov@swemel.ru>
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

14.09.2023 10:06, Dmitry Frolov wrote:
> According to cxl_interleave_ways_enc(), fw->num_targets is allowed to be up
> to 16. This also corresponds to CXL specs. So, the fw->target_hbs[] array
> is iterated from 0 to 15. But it is statically declared of length 8. Thus,
> out of bound array access may occur.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> v2: assert added
> v3: assert removed

So it's the same as the initial submission.

/mjt

