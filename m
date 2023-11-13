Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BBC7EA2EB
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 19:34:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2bl6-0003Ds-1u; Mon, 13 Nov 2023 13:34:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.tyutin@yadro.com>)
 id 1r2bl2-00039C-Bt
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:34:00 -0500
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.tyutin@yadro.com>)
 id 1r2bky-00037n-Sp
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:34:00 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com CB4DEC0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
 t=1699900430; bh=yacChMXC2cujbWnJAnFij5amP4iXDdmaMjj4kd94dzg=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=aNUisCpuXlJy3gnVZZhlTesfxCiO/4gp5PL7vohc1LRWF8AkDpeLZhFCWhlUHLt6x
 RCTe4SQ0mg1GJaDCQ8TgdH8EsmsfsLtfHbavkzY18eDGhY+H/JBcSVQjJRMoihpUqK
 JXXbYoaXMxYAkEdnBzsPjzFbZNhBEy3qwHyxk8ogBYH/qXYwIrFjIiRa7ebnoTSxGB
 JAPwscOFHT3D0UHJSzscBPx+j6sSMXlziMNoiYKJBHwfab0adFw6lFU/oo/1Jgh31D
 AqodkGT7Eo0WgzXpQZj4GVJnRfIKd0aLlPjjg4gQBDz9zZltj4/fYAWaspFiUDHRoS
 rMoaeY0km7A+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
 t=1699900430; bh=yacChMXC2cujbWnJAnFij5amP4iXDdmaMjj4kd94dzg=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=Gj9NC5Ys28ZHrP3KBKELuACFoCvNs5Hko+k7DSEV3ZM9beO76YntTQpU2KcdxzU7Y
 +rNz0ndqZNmgAvAvle/G8PUuH6jHuqOcD94BhvQ9gFRZVhpW+plOrtpjBHLuUNXUJk
 e1wiQy3s3VPviped0/QV5pJ7FLAPCLGTCfjE3NHB0ymrmhiNix4l8bN7MxcqP9y6yD
 d6Kv5um2mqTDiU/XX7Xl7WzPyaFcwKdY1Yl2mGcajGmS16pRnL44agNvgAYDh8Pykd
 qeZOng7iuyhNqg6hiDTLuaZ0JkRcVR7a0WB2GMSkWR8Y+RLAMS3yaSXAt2dSl9lbYw
 q3zWzplWWwlHA==
From: Mikhail Tyutin <m.tyutin@yadro.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Richard Henderson <richard.henderson@linaro.org>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, "erdnaxe@crans.org"
 <erdnaxe@crans.org>, "ma.mandourr@gmail.com" <ma.mandourr@gmail.com>
Subject: Instruction virtual address in TCG Plugins
Thread-Topic: Instruction virtual address in TCG Plugins
Thread-Index: AdoWXsbya+HqTrueTiqiLf6nDJCNng==
Date: Mon, 13 Nov 2023 18:33:48 +0000
Message-ID: <d4f2713a4e2d45858c82ff2efb95f8a3@yadro.com>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=89.207.88.248; envelope-from=m.tyutin@yadro.com;
 helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Greetings,

What is the right way to get virtual address of either translation block or=
 instruction inside of TCG plugin? Does
plugin API allow that or it needs some extension?

So far I use qemu_plugin_tb_vaddr() inside of my block translation callback=
 to get block virtual address and then
pass it as 'userdata' argument into qemu_plugin_register_vcpu_tb_exec_cb().=
 I use it later during code execution.
It works well for user-mode emulation, but sometimes leads to incorrect add=
resses in system-mode emulation.
I suspect it is because of memory mappings by guest OS that changes virtual=
 addresses for that block.

I also looked at gen_empty_udata_cb() function and considered to extend plu=
gin API to pass a program counter
value as additional callback argument. I thought it would always give me va=
lid virtual address of an instruction.
Unfortunately, I didn't find a way to get value of that register in archite=
cture agnostic way (it is 'pc' member in
CPUArchState structure).

---
Mikhail

