Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E747E48CE
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:54:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0RDU-0006h7-Nr; Tue, 07 Nov 2023 13:54:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1r0RDQ-0006V9-4b; Tue, 07 Nov 2023 13:54:21 -0500
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1r0RDM-0002gh-D3; Tue, 07 Nov 2023 13:54:19 -0500
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5b35579f475so70848597b3.3; 
 Tue, 07 Nov 2023 10:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699383255; x=1699988055; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WFQBCNThDpcDIrzMRBsFkzLevLUW/mpbaS6KVfN16cU=;
 b=TME7ddYbu9YPcLPv4PWnvru/D2VKGh8nKs6d6xZwqvhvQ/j+oVTmxdACejvqelTCyp
 bJp/hRabEuKk/7VCWYopsjUvLDIqdLaxLrP+nbekBayMcB9bBHiD04Qi09G8CjU7OLaq
 ZYVv16ahWlhdTBc/RwktMdDuFfJz4wfNOkWEH4K525v2bUpLKD9UdXPBE26V4aR3pkOv
 ZR+Uz2uVyZUT6TorzfkYVFIjn0W9v8+zq+TcDFb9zOwsGp+5XTlJCt7EkCdEp7SlXKPc
 XLctw0gdFpoDjxH8DJJAbOX4LW92rUrgYtT4IK1VNosBoMygIqCMPqF9TUHbMdrbekAf
 k95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699383255; x=1699988055;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WFQBCNThDpcDIrzMRBsFkzLevLUW/mpbaS6KVfN16cU=;
 b=h6VE0uOk33UktMg6GQpiJfK/wrfT+uBL2s1tVUscHCxLPxMUFKzF+N5rPKwiNWBimo
 Z3v+X6DGyXPfLPKCaNKXtyqhwlcmry6fsexvB2Ji1Y1GEZo+ZJdV50F/JLX7p6Gk/tdn
 8QTiX2kWf8tCkB3EGHuPPeukyg0YV+Fkj2d2ik7as0MsE2SLidHV2zYV7kZeivf6C8cs
 LRopaJ2n0loDgGtfQwzfGCjVHU8YuVfsnDgqtwKRVwInisnZSL84nN4x3GniKz2GsrUh
 VqAqbXUmFIsTfG3l1uRLeOoeDk6fWSSCHnh2zw+wg/NLB0F2Qd3eAVvziCCQu81igz7Q
 o5Gw==
X-Gm-Message-State: AOJu0Yz/JXzoMg7TtzHD3M7IfTu2Io2nQsQDyYfuPuSHJkQN1JE5rb7C
 5V8yCY+dWwpdF7OBUGulRC8=
X-Google-Smtp-Source: AGHT+IGIxNOuM4uBnqp7juiX8ASzSh/wft1RP/TjtefmkF/4NHYSttFXwvWqNRqFr4nba2k3dBOveQ==
X-Received: by 2002:a25:9f10:0:b0:dae:1c87:79c0 with SMTP id
 n16-20020a259f10000000b00dae1c8779c0mr7392345ybq.19.1699383255062; 
 Tue, 07 Nov 2023 10:54:15 -0800 (PST)
Received: from [192.168.68.107] ([179.193.10.161])
 by smtp.gmail.com with ESMTPSA id
 v17-20020a259111000000b00d7b8a1074d4sm5286568ybl.57.2023.11.07.10.54.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 10:54:14 -0800 (PST)
Message-ID: <651c05ab-dfa6-4511-a088-3e3b303fe6fc@gmail.com>
Date: Tue, 7 Nov 2023 15:54:13 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Add PowerNV I2C Controller Model
Content-Language: en-US
To: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, philmd@linaro.org
References: <20231016222013.3739530-1-milesg@linux.vnet.ibm.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20231016222013.3739530-1-milesg@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=danielhb413@gmail.com; helo=mail-yw1-x112c.google.com
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

Queued in gitlab.com/danielhb/qemu/tree/ppc-next. Thanks,


Daniel

On 10/16/23 19:20, Glenn Miles wrote:
> Upstreams the PowerNV I2C controller model originally
> authored by Cédric Le Goater with minor changes by
> myself to split the actual addition of the model from
> wiring it up to a power processor model.
> 
> This series only attaches the controller to the powernv9
> chip model, but is expected to eventually also be attached
> to the powernv10 chip model.
> 
> Cédric Le Goater (2):
>    ppc/pnv: Add an I2C controller model
>    ppc/pnv: Connect I2C controller model to powernv9 chip
> 
>   hw/ppc/meson.build         |   1 +
>   hw/ppc/pnv.c               |  28 ++
>   hw/ppc/pnv_i2c.c           | 697 +++++++++++++++++++++++++++++++++++++
>   include/hw/ppc/pnv_chip.h  |   8 +
>   include/hw/ppc/pnv_i2c.h   |  38 ++
>   include/hw/ppc/pnv_xscom.h |   3 +
>   6 files changed, 775 insertions(+)
>   create mode 100644 hw/ppc/pnv_i2c.c
>   create mode 100644 include/hw/ppc/pnv_i2c.h
> 

