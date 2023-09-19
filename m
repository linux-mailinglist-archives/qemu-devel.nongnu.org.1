Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5497A643E
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 15:02:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiaMi-0003wP-S9; Tue, 19 Sep 2023 09:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qiaMR-0003s5-Iq
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 09:01:53 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qiaMM-0007ka-4q
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 09:01:47 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 38D9123442;
 Tue, 19 Sep 2023 16:01:49 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 825E62918A;
 Tue, 19 Sep 2023 16:01:31 +0300 (MSK)
Message-ID: <9a3d31b5-826f-e4c0-328c-86e504ef154c@tls.msk.ru>
Date: Tue, 19 Sep 2023 16:01:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 00/10] linux-user: Detect and report host crashes
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <20230823051615.1297706-1-richard.henderson@linaro.org>
 <d2e3266e-dbb8-07a6-07d7-008e788c3862@linaro.org>
 <329a2c4b-9fa9-5e73-aa95-57512d60c1ec@gmx.de>
 <36562fcb-77f2-2a18-acec-47f155decf71@tls.msk.ru>
 <51b980aa-1a80-7565-44d6-8dcba3ead422@gmx.de>
 <7a2ccda6-4f23-961c-4d53-b6929af6bd6f@tls.msk.ru>
 <c3e39816-b16a-d3f2-135e-95796814ebf0@gmx.de>
 <4aa85a6c-26ce-0683-e65e-e0e0cb9546a7@tls.msk.ru>
 <df4b309f-6de2-42f5-4c2b-3103fb0d929e@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <df4b309f-6de2-42f5-4c2b-3103fb0d929e@linaro.org>
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

FWIW, there's an interesting read (suggested by iam_tj)
https://stackoverflow.com/questions/39725138/strange-behaviour-while-wrapping-abort-system-call

also https://drewdevault.com/2016/07/19/Using-Wl-wrap-for-mocking-in-C.html

/mjt

