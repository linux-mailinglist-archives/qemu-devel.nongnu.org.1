Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9A37E48C9
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:53:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0RCl-0005IC-F0; Tue, 07 Nov 2023 13:53:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1r0RCg-0005GJ-7q; Tue, 07 Nov 2023 13:53:34 -0500
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1r0RCU-0002WT-DU; Tue, 07 Nov 2023 13:53:33 -0500
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-da0359751dbso5279838276.1; 
 Tue, 07 Nov 2023 10:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699383201; x=1699988001; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7gjNyXZrHm7qXCkMUjc8N64XhhmRTNnU6Ef5LT2jNhk=;
 b=U3EoZGkOZWzQN6xNzD+tuemyvy3OE8qIia6d0tUGwEq63JAZbXZ4Bk5s2HXykwvdxP
 0l/bKr73FmtQmf1++jnz/P9hz78+Qs2aTMyxuq8h7ROVi0brdMtEN40GC9jLnWZNgHne
 oQwgkfzsGQ2NDKSY4gZSdQyjoQeAFcBtEn+p3S4cNlindl6sNzYKAApUdP7Pv+4ndeTc
 EzQ5Cl01Nx/LaoEPsW8JNXVq8gDvoslJiVycScnhRNaevBTlc7KAIIBZlTmvapVmSS5W
 rMKQXBmrCa2VbMLzSEw9O+fwvJB1kY4KdUIXNsaJMqcDr+frqbfSDW2B8bcvWhhLHFgg
 xcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699383201; x=1699988001;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7gjNyXZrHm7qXCkMUjc8N64XhhmRTNnU6Ef5LT2jNhk=;
 b=Wgpb465KnAQZhjsm60YAI5iv700dHiArXxHYIQnGbdZ+GRuxHNaUFtRXKmwM0+xZaz
 D9L5JsFsp8qc7pH0dux+F6ectSB4ayBM4iyviyXCsmGfnbY71rk9XY4JKt1yiwkDzAct
 CsXe2iXlbYf+yJnrb6V60KsAjpVPsghVMCF55F2yVQ9suVQNT33Zgrx8qwgDaNOQC9lF
 FM+SZhDbW5CA5ZMvsNRlrVvE97xzgUOBJ2mjuFn2eyMQHtvguIY3aue/8hJTkVtuIJYI
 8Uwhra/5y/bg6Tp17WNwxWqlBj1zirrqX+fVuuc3Ct+yViWRRpB79vHvmlqV9avBYJvs
 qTuw==
X-Gm-Message-State: AOJu0YyxA0CjA3yslr08IXc6R9zSaHuNAr4Ik8VmSW1SYSWXUBggIEir
 MdWw6ZmyaHBlEOXxJay6uSpQCgkkHbg=
X-Google-Smtp-Source: AGHT+IGOK30oKKwQg1plLz9q/vP8VGAB6Ekyyt0FnZtqT1KbBoJE22+UwVB3MLOT5opKazxaJ0PDVA==
X-Received: by 2002:a25:cc1:0:b0:d9a:d8bd:7b9c with SMTP id
 184-20020a250cc1000000b00d9ad8bd7b9cmr2392489ybm.11.1699383200759; 
 Tue, 07 Nov 2023 10:53:20 -0800 (PST)
Received: from [192.168.68.107] ([179.193.10.161])
 by smtp.gmail.com with ESMTPSA id
 v17-20020a259111000000b00d7b8a1074d4sm5286568ybl.57.2023.11.07.10.53.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 10:53:20 -0800 (PST)
Message-ID: <9321822c-58d8-464d-91ad-12e078f1d001@gmail.com>
Date: Tue, 7 Nov 2023 15:53:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3] tests/avocado: Add test for amigaone board
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, clg@kaod.org, philmd@linaro.org,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
References: <cover.1698406922.git.balaton@eik.bme.hu>
 <b1a0246840fcff1fe6bbd8685e2474a9231b34c5.1698406922.git.balaton@eik.bme.hu>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <b1a0246840fcff1fe6bbd8685e2474a9231b34c5.1698406922.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=danielhb413@gmail.com; helo=mail-yb1-xb36.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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



On 10/27/23 08:54, BALATON Zoltan wrote:
> Add an avocado test for the amigaone board that tests it with the
> firmware.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---

Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>



>   tests/avocado/ppc_amiga.py | 38 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
>   create mode 100644 tests/avocado/ppc_amiga.py
> 
> diff --git a/tests/avocado/ppc_amiga.py b/tests/avocado/ppc_amiga.py
> new file mode 100644
> index 0000000000..b6f866f91d
> --- /dev/null
> +++ b/tests/avocado/ppc_amiga.py
> @@ -0,0 +1,38 @@
> +# Test AmigaNG boards
> +#
> +# Copyright (c) 2023 BALATON Zoltan
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +from avocado.utils import archive
> +from avocado.utils import process
> +from avocado_qemu import QemuSystemTest
> +from avocado_qemu import wait_for_console_pattern
> +
> +class AmigaOneMachine(QemuSystemTest):
> +
> +    timeout = 90
> +
> +    def test_ppc_amigaone(self):
> +        """
> +        :avocado: tags=arch:ppc
> +        :avocado: tags=machine:amigaone
> +        :avocado: tags=device:articia
> +        :avocado: tags=accel:tcg
> +        """
> +        self.require_accelerator("tcg")
> +        tar_name = 'A1Firmware_Floppy_05-Mar-2005.zip'
> +        tar_url = ('https://www.hyperion-entertainment.com/index.php/'
> +                   'downloads?view=download&format=raw&file=25')
> +        tar_hash = 'c52e59bc73e31d8bcc3cc2106778f7ac84f6c755'
> +        zip_file = self.fetch_asset(tar_name, locations=tar_url,
> +                                    asset_hash=tar_hash)
> +        archive.extract(zip_file, self.workdir)
> +        cmd = f"tail -c 524288 {self.workdir}/floppy_edition/updater.image >{self.workdir}/u-boot-amigaone.bin"
> +        process.run(cmd, shell=True)
> +
> +        self.vm.set_console()
> +        self.vm.add_args('-bios', self.workdir + '/u-boot-amigaone.bin')
> +        self.vm.launch()
> +        wait_for_console_pattern(self, 'FLASH:')

