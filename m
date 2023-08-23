Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F64E7852D1
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 10:37:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYjMJ-0005lg-65; Wed, 23 Aug 2023 04:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYjMF-0005lE-RU
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:36:55 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYjMD-0004C0-Ga
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:36:55 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8D8B11C4AB;
 Wed, 23 Aug 2023 11:37:08 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id ECB432135B;
 Wed, 23 Aug 2023 11:36:49 +0300 (MSK)
Message-ID: <ee9258a8-ee82-90b8-1e2e-7d13b04a05b1@tls.msk.ru>
Date: Wed, 23 Aug 2023 11:36:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] meson: Use subprocess.check_output()
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
References: <20230812091111.13411-1-akihiko.odaki@daynix.com>
 <1415ac82-0769-a25d-1dbd-c8382b9c52b2@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <1415ac82-0769-a25d-1dbd-c8382b9c52b2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -86
X-Spam_score: -8.7
X-Spam_bar: --------
X-Spam_report: (-8.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.767,
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

23.08.2023 11:33, Thomas Huth wrote:
> On 12/08/2023 11.11, Akihiko Odaki wrote:
>> subprocess.check_output() is a more concise way to execute a subprocess
>> here.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>> Based-on: <20230812061540.5398-1-akihiko.odaki@daynix.com>
>> ("[PATCH] meson: Fix MESONINTROSPECT parsing")
> 
> Since that other patch has never been merged, this patch here does not apply to master ... could you maybe respin it for the plain master branch?

Both patches should be applied, that one first, this one second.
I don't think it needs a respin, just a proper patch series.

/mjt

