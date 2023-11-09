Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C317E6436
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 08:17:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0zHA-0005CR-Am; Thu, 09 Nov 2023 02:16:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1r0zH5-00059G-H7
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 02:16:23 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1r0zH1-0003Ob-CW
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 02:16:21 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9d2c54482fbso82277366b.2
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 23:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699514177; x=1700118977; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=RcOzC5K65xHmreBnxbCehvlPjXJ9Jer7okFzkyUE/GE=;
 b=KhsJM4CY6qP4hG23Yi2oLsPR8YIfMUOGvrlvwyOKJj+8AtPL9R0WdTzmSvuCttvKCa
 MAxnLiUY6xzO/vuKqAYvOMqe9GoiIV+315LQMVDhDa/6cWFEsnx0/lLTdKsD2LLWZUzJ
 9z1vLNPIO1P/o/mkPm1RczVhbl5qsFofUUd6bNyxurazFcys/yMq8XIMcZqs6Xsaj6yd
 YCJF+BaimFWtn678zwTZ0UPmut6fKBwLcH8bDxmrukgfGFjieT9LSlE8mfXxp5neoJSN
 pMiBMgwEiypdIkpPjNADf+k/My/G21l/5Tc/tay7WejwPu2u7eW+vKXcllpDCNUiPSA3
 rIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699514177; x=1700118977;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RcOzC5K65xHmreBnxbCehvlPjXJ9Jer7okFzkyUE/GE=;
 b=Ieb0xHBWj4z41diu7+S/mQhROcR1BK9hCHiTKD3OmYdU/2kWuaZhAMxjO10Ci/nnjS
 nIwW1u9fz8oEqhcPOLto/G+QOkq4C63tTXmXR6RP35UrmMVd9E2iPAwtMwpZKaUTzqH2
 o9csY+sp6pJ7lq6sIrqwL6rBWJxciIKpxJJAxGytmbagOuhs5ZpG7LqAvS5W/FzVshSk
 ggpwQTxhaV4Wbn3pOb7CxJ6vVA6YOwRwxPl1PssHlJYL+UJFV6eQpTBY6V+UyiJ5EuHE
 wJ5jvVXwtDPbmakX5ausgkwH50a5GyukjZavdtmjAG06PpwpaAOeOAaAe+hQFYWqvl/+
 1I2Q==
X-Gm-Message-State: AOJu0YwiKRC3DXh89QWQDlcxhvsnwKPHxkzNMONyIp5N6eUzw+LCNK4h
 Hu05ODLC4qcI650oJhCUyq4GMw==
X-Google-Smtp-Source: AGHT+IHax2ZV8ZwCJwbXI8Yd55gDtbA1Z2eT2Tv+ktCqPWnQOX7DszE9XFb3wY5e4usUTeZjq5sM0g==
X-Received: by 2002:a17:906:eec6:b0:9d4:55b1:9249 with SMTP id
 wu6-20020a170906eec600b009d455b19249mr3301786ejb.71.1699514177512; 
 Wed, 08 Nov 2023 23:16:17 -0800 (PST)
Received: from [192.168.200.206] (83.11.210.67.ipv4.supernova.orange.pl.
 [83.11.210.67]) by smtp.gmail.com with ESMTPSA id
 r5-20020a170906c28500b009929ab17be0sm2115567ejz.162.2023.11.08.23.16.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 23:16:17 -0800 (PST)
Message-ID: <e036e998-597c-441f-8c8a-569e2350b30a@linaro.org>
Date: Thu, 9 Nov 2023 08:16:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/ide/ahci: fix legacy software reset
Content-Language: pl-PL, en-GB, en-HK
To: Niklas Cassel <nks@flawful.org>, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>, Michael Tokarev <mjt@tls.msk.ru>,
 Niklas Cassel <niklas.cassel@wdc.com>
References: <20231108222657.117984-1-nks@flawful.org>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <20231108222657.117984-1-nks@flawful.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

W dniu 8.11.2023 o 23:26, Niklas Cassel pisze:
> From: Niklas Cassel <niklas.cassel@wdc.com>

> This fixes an issue for FreeBSD where the device would fail to reset.
> The problem was not noticed in Linux, because Linux uses a COMRESET
> instead of a legacy software reset by default.
> 
> Fixes: e2a5d9b3d9c3 ("hw/ide/ahci: simplify and document PxCI handling")
> Reported-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>

Tested-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

FreeBSD 14-rc3 boots fine on AArch64 with this patch:

Trying to mount root from cd9660:/dev/iso9660/14_0_RC3_AARCH64_BO [ro]...
cd0 at ahcich0 bus 0 scbus0 target 0 lun 0
cd0: <QEMU QEMU DVD-ROM 2.5+> Removable CD-ROM SCSI device
cd0: Serial Number QM00001
cd0: 150.000MB/s transfers (SATA 1.x, UDMA5, ATAPI 12bytes, PIO 8192bytes)
cd0: 347MB (177954 2048 byte sectors)
ada0 at ahcich1 bus 0 scbus1 target 0 lun 0
ada0: <QEMU HARDDISK 2.5+> ATA-7 SATA device
ada0: Serial Number QM00003
ada0: 150.000MB/s transfers (SATA 1.x, UDMA5, PIO 8192bytes)
ada0: Command Queueing enabled
ada0: 504MB (1032192 512 byte sectors)
ada1 at ahcich2 bus 0 scbus2 target 0 lun 0
ada1: <QEMU HARDDISK 2.5+> ATA-7 SATA device
ada1: Serial Number QM00005
ada1: 150.000MB/s transfers (SATA 1.x, UDMA5, PIO 8192bytes)
ada1: Command Queueing enabled
ada1: 8192MB (16777216 512 byte sectors)


