Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEDE7EF6B6
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 18:03:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r42DI-000366-RZ; Fri, 17 Nov 2023 12:01:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marex@denx.de>) id 1r42DC-00034g-JK
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 12:01:00 -0500
Received: from phobos.denx.de ([85.214.62.61])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marex@denx.de>) id 1r42DA-0003kt-TA
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 12:00:58 -0500
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B25F486F5C;
 Fri, 17 Nov 2023 18:00:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1700240446;
 bh=fxkOLVuXLks5P66k/HsQyd+FLjWM48wPksneMaJtT/I=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=GcpxVG4FmEJIlIfF5Usfp04dluQJV75zlkLjuIv9Ima7jD7PoRwNPisu6jOzhM24G
 0Xa/t4obODisF9bM9AzUqSnPeCEGc0E5s5N834r5qTntUzLDbQpeLmBQDpNZgCK6gu
 87QnXRXaA+ToKs7n9iwPqvop1LvCR015ldonqum7MiQD+sCdgxVMa0APDqcEcLPGr8
 IRDEaryCjsndE6keJHeEy5mLWJ+Ip8G5JDJA1roHZIqnvJ1793jTaFcPt9MlU96sC+
 9xJHGro4dhQQp2HlHvAXP1uWBLvvrrvIzAYOT71M6wOLEIQBp5+1Rl47TUQ3cIRFFR
 JJonDNX33f3Aw==
Message-ID: <0337cbf2-4477-4670-a45d-0ae38c6c2c0d@denx.de>
Date: Fri, 17 Nov 2023 18:00:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-8.2] target/nios2: Deprecate the Nios II architecture
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Chris Wulff <crwulff@gmail.com>,
 devel@lists.libvirt.org, Sandra Loosemore <sandra@codesourcery.com>
References: <20231117070250.32932-1-philmd@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231117070250.32932-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Received-SPF: pass client-ip=85.214.62.61; envelope-from=marex@denx.de;
 helo=phobos.denx.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/17/23 08:02, Philippe Mathieu-Daudé wrote:
> See commit 9ba1caf510 ("MAINTAINERS: Mark the Nios II CPU as orphan"),
> last contribution from Chris was in 2012 [1] and Marek in 2018 [2].
> 
> [1] https://lore.kernel.org/qemu-devel/1352607539-10455-2-git-send-email-crwulff@gmail.com/
> [2] https://lore.kernel.org/qemu-devel/805fc7b5-03f0-56d4-abfd-ed010d4fa769@denx.de/
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Yes please, go for it, from my side:

Acked-by: Marek Vasut <marex@denx.de>

