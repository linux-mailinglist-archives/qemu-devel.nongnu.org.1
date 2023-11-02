Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4463D7DEFFE
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 11:31:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyUyU-0007cg-Jb; Thu, 02 Nov 2023 06:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qyUyP-0007by-Aa
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:30:49 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qyUyN-000732-NC
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:30:49 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2c6b5841f61so8623811fa.0
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 03:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698921046; x=1699525846; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=LWGjKF9y54CRSKpwqMxi/CKTYjPa4clxASj9U3LZ10M=;
 b=FSQ01lms5wGXbItPtTslSZQUdVXWKM9NXyaKThTbnE6e867DPSvwnH5vxdaxEyd+a4
 oWNrVjSFSIuq8ztEF1BAty2HiTYSfgoia2TXgBSKdWcjP/lSoDZYNYoD6l+OX7vZMBaO
 dpbEjjBY2uFuYM79rln7efTpXsowTk85L893O3yztC+4u3rwG4jnj8PQSa9LzLyyx77w
 g12Wn+fMlF32kOKZFcOTM/SMPnZEUF0Mnytxm2NoZUBemkUyjcWxlsBDyGKPaGwLIrBI
 VWeQ0jUuYnFbe0BEAGnrti30ATJ37LMrwRpSaOF+sbT00c0gRDRZQQ1xOWJJ0tOoXww3
 EVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698921046; x=1699525846;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LWGjKF9y54CRSKpwqMxi/CKTYjPa4clxASj9U3LZ10M=;
 b=hfNMoe9KBKlPHjvqn9Hrmks1Pvhud7XR1Lm60iWw4qdndNWW7rQL3cVJWyQYU2WRwQ
 JSOkKDmyGmgHTeQujmODLkrh88VIlGYR7exZ3CETRcksqDf/sk0nuJrkMAKFBj8yuFoS
 DrvvsVOutgWklEBNciY3cqOcIjSXcci//0nXE8fyE7VKLoIX99GFtSq9MTt0Q1UvVEQ9
 Ca7qX2vU3BHiL2BSbS18utrsLauOgYGD2fdTA2AbrMO/MV3bqo54rmNL8ulWU0PZvglu
 k6L0uwIorDpTMGCFIb1kfwDe8ZdqjAscM9qH/i3RJ+eMow46rhrb00WMGqT8fJb+hzNf
 V4iA==
X-Gm-Message-State: AOJu0Yzk/VJXLBYD1k+flyI2p8rwwmdLjoOMc9luyZfk8h+CxQOX+4Hr
 W9F03ZMtljzgP8k8gCoJl3bwRg==
X-Google-Smtp-Source: AGHT+IGCaMtdmhFPvg4EK3RJFGOYKsoc08g05vzHWP+J6xRz0jEmdmzuGMWsrHOjKTCsJN6lPMFZuQ==
X-Received: by 2002:a05:651c:19ab:b0:2bc:dd8f:ccd7 with SMTP id
 bx43-20020a05651c19ab00b002bcdd8fccd7mr3807532ljb.16.1698921045858; 
 Thu, 02 Nov 2023 03:30:45 -0700 (PDT)
Received: from [192.168.200.206] (83.11.185.48.ipv4.supernova.orange.pl.
 [83.11.185.48]) by smtp.gmail.com with ESMTPSA id
 u10-20020a2e2e0a000000b002c02e57c72bsm420410lju.140.2023.11.02.03.30.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Nov 2023 03:30:45 -0700 (PDT)
Message-ID: <053c4e5b-f446-46e9-9672-30a501d44a42@linaro.org>
Date: Thu, 2 Nov 2023 11:30:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ide/ahci: fix legacy software reset
Content-Language: pl-PL, en-GB, en-HK
To: Niklas Cassel <nks@flawful.org>, John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>, Michael Tokarev <mjt@tls.msk.ru>,
 Niklas Cassel <niklas.cassel@wdc.com>
References: <20231005095322.1133817-1-nks@flawful.org>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <20231005095322.1133817-1-nks@flawful.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lj1-x22a.google.com
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

W dniu 5.10.2023 o 11:53, Niklas Cassel pisze:
> From: Niklas Cassel<niklas.cassel@wdc.com>
> 
> Legacy software contains a standard mechanism for generating a reset to a
> Serial ATA device - setting the SRST (software reset) bit in the Device
> Control register.
> 
> Serial ATA has a more robust mechanism called COMRESET, also referred to
> as port reset. A port reset is the preferred mechanism for error
> recovery and should be used in place of software reset.
> 
> Commit e2a5d9b3d9c3 ("hw/ide/ahci: simplify and document PxCI handling")
> improved the handling of PxCI, such that PxCI gets cleared after handling
> a non-NCQ, or NCQ command (instead of incorrectly clearing PxCI after
> receiving an arbitrary FIS).
> 
> However, simply clearing PxCI after a non-NCQ, or NCQ command, is not
> enough, we also need to clear PxCI when receiving a SRST in the Device
> Control register.
> 
> This fixes an issue for FreeBSD where the device would fail to reset.
> The problem was not noticed in Linux, because Linux uses a COMRESET
> instead of a legacy software reset by default.
> 
> Fixes: e2a5d9b3d9c3 ("hw/ide/ahci: simplify and document PxCI handling")
> Reported-by: Marcin Juszkiewicz<marcin.juszkiewicz@linaro.org>
> Signed-off-by: Niklas Cassel<niklas.cassel@wdc.com>

Sorry, I missed that patch earlier.

FreeBSD 14-rc3 boots fine on aarch64. Thanks!

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

Tested-by: Marcin Juszkiewicz<marcin.juszkiewicz@linaro.org>

