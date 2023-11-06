Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DB87E2B67
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 18:43:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r03ck-00067a-I4; Mon, 06 Nov 2023 12:42:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christopherericlentocha@gmail.com>)
 id 1r02ao-0001NC-GV
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 11:36:51 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christopherericlentocha@gmail.com>)
 id 1r02ak-0008Nj-2k
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 11:36:49 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6ce344fa7e4so2874911a34.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 08:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699288604; x=1699893404; darn=nongnu.org;
 h=content-transfer-encoding:from:content-language:subject:to
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F3ImmRFCvsAgbS0iCFx72LAxliwLQdw99uqhD2QAnZI=;
 b=AXv7gpROkizc3hTKI+en3aj+ECYl8aTS2pj+XfeGwkTRR6adq+x7b0TvTItadTvFWN
 JZ7NYALjkl0rjUTcBmIGVSGPNrkbSsWADnhnGGz/UwN+5u34Vku1qsqsGaB/Az7TFIgE
 Lr4mqdtbIM3ApffBTEr191AMb2zmi/AUT5Eikuf2R6mS6vYoM111snsOzRPWn3GnCYZJ
 9+NCuz3KVZG9uIRcT6ILOTu1BGRHMg6egpaNFQU4jqLoWyahcwz70HKjbmsUS8zbcGW5
 tCpgRl1cXRLD04HTh3AtrpXDeGanl0YVW6ZcO7ji8Do4h1XH3y+ZkIQBVJCM93AkLBwF
 rl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699288604; x=1699893404;
 h=content-transfer-encoding:from:content-language:subject:to
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=F3ImmRFCvsAgbS0iCFx72LAxliwLQdw99uqhD2QAnZI=;
 b=juXj5+0CsR5aCwI5lVt5xHVO+5/DMa2H7Rsn3p823HrdI3wNTG6QfOYdeHN2qx8pVR
 PFQYhg5YiIP2Kx8Acvq9bHTnRhuwuLnfTDZTPbzNqTeAT30azndap8lCt7NcsClsoFsO
 Dv3eurTVIaCz3EiIAWIE6gehYTn4g61I7C4bMWX5iFahCrOB4OZq5ElEbz51/8n2gDcp
 0ojvsaGDqJglvadcZx0aD14henPBFDSXonjKN7hHX3rdFOZMeXKectRjxJBj+VwWZcT7
 zKw69/TcIRKeh56BPgcdlL+j5h6CJY6A9Y5KL8Sn1L9l4s0mhBfH59NG07l7PuDQUqem
 vHrg==
X-Gm-Message-State: AOJu0YwvbrTLLsdzyWATcsHubcp83pLIoWtq+QKHvn/da6uEa58fqM8I
 kNYhe8Njpe2fj5hakzzLaTTXOEYbwrac9w==
X-Google-Smtp-Source: AGHT+IHBuXtEjq9CQ8iLXVHB2Z/fJ01sXCS5fjiwSiJ8ZxflCm24zhG7AllbFA0uU1cNE1PQoVSK4Q==
X-Received: by 2002:a9d:7546:0:b0:6d3:3eed:b3e3 with SMTP id
 b6-20020a9d7546000000b006d33eedb3e3mr7626117otl.8.1699288603659; 
 Mon, 06 Nov 2023 08:36:43 -0800 (PST)
Received: from [192.168.1.4] (172-8-197-221.lightspeed.livnmi.sbcglobal.net.
 [172.8.197.221]) by smtp.gmail.com with ESMTPSA id
 o2-20020a9d5c02000000b006d3127234d7sm1309277otk.8.2023.11.06.08.36.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 08:36:43 -0800 (PST)
Message-ID: <3a0d15e0-177e-4650-d79c-d8a2cdf47f37@gmail.com>
Date: Mon, 6 Nov 2023 11:36:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
To: qemu-devel@nongnu.org
Subject: [PATCH] Support Intel 82574L for older macOS native Kext
Content-Language: en-US
From: Christopher Lentocha <christopherericlentocha@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=christopherericlentocha@gmail.com; helo=mail-ot1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 06 Nov 2023 12:42:43 -0500
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


When selecting e1000e as nic for macOS Opencore
or other macOS in QEMU emulation, it doesn't work
but this patch fixes it by changing a PCI ID for
Intel 82574L to support macOS native Intel NIC
Kexts, both IDs (0x10F6 & 0x10D3) are 82574L but
0x1003 as DEV ID works well with macOS, without
any other breaking changes (other than a number
change, which may make Windows Re-Register the
Driver)! (Note: macOS Ventura 13 removes this
kext, so it isn't working in 13 or higher, as
well with other Intel NICs supported by QEMU,
since this is the newest model for Intel, other
than the Para-virt VirtIO card provided by QEMU)

Signed-off-by: Christopher Lentocha <christopherericlentocha@gmail.com>
---
hw/net/e1000x_regs.h | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/e1000x_regs.h b/hw/net/e1000x_regs.h
index cd896fc0ca..d938aa49e8 100644
--- a/hw/net/e1000x_regs.h
+++ b/hw/net/e1000x_regs.h
@@ -84,7 +84,7 @@
#define E1000_DEV_ID_82573E 0x108B
#define E1000_DEV_ID_82573E_IAMT 0x108C
#define E1000_DEV_ID_82573L 0x109A
-#define E1000_DEV_ID_82574L 0x10D3
+#define E1000_DEV_ID_82574L 0x10F6
#define E1000_DEV_ID_82546GB_QUAD_COPPER_KSP3 0x10B5
#define E1000_DEV_ID_80003ES2LAN_COPPER_DPT 0x1096
#define E1000_DEV_ID_80003ES2LAN_SERDES_DPT 0x1098
-- 
2.38.1



