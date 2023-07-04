Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9497478F0
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 22:20:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGmU8-0006kh-F6; Tue, 04 Jul 2023 16:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qGmU5-0006k7-3J; Tue, 04 Jul 2023 16:18:49 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qGmU3-0000ha-B7; Tue, 04 Jul 2023 16:18:48 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8C8B7117C8;
 Tue,  4 Jul 2023 23:18:34 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7A39F12DDA;
 Tue,  4 Jul 2023 23:18:34 +0300 (MSK)
Message-ID: <0aa13184-9447-5677-1a3f-a2683bc28094@tls.msk.ru>
Date: Tue, 4 Jul 2023 23:18:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH qemu v5] aspeed add montblanc bmc reference from fuji
Content-Language: en-US
To: ~ssinprem <ssinprem@celestica.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, clg@kaod.org, peter.maydell@linaro.org
Cc: andrew@aj.id.au, joel@jms.id.a, qemu-stable@nongnu.org,
 srikanth@celestica.com, ssumet@celestica.com, thangavelu.v@celestica.com,
 kgengan@celestica.com, anandaramanv@celestica.com
References: <168846918238.25928.7102858062933368556-0@git.sr.ht>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <168846918238.25928.7102858062933368556-0@git.sr.ht>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

04.07.2023 14:06, ~ssinprem wrote:
> From: Sittisak Sinprem <ssinprem@celestica.com>
> 
> - I2C list follow I2C Tree v1.6 20230320
> - fru eeprom data use FB FRU format version 4
> 
> Signed-off-by: Sittisak Sinprem <ssinprem@celestica.com>

Once again, this has nothing to do with qemu-stable@, it is not a fix
suitable for stable releases.

Thanks,

/mjt

