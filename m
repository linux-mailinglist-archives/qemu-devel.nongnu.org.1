Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 615D672CF4F
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 21:26:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8nAN-000083-6t; Mon, 12 Jun 2023 15:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8nAK-0008WA-8m
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 15:25:24 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1q8nAH-0004GQ-Ur
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 15:25:23 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-977cf86aae5so714202966b.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 12:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686597920; x=1689189920;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MVU/rCpCbtd0jlbCciUbATvr2DovhixhPhqoZ0JvgK4=;
 b=JzXZGLbth2NjQErkexvNzJANLEymVQNQOdFQI+UPRkgu6mV0UZfLgG4p+Qxo++1MOE
 yuwltVIPCUZkrgl7XNRR8MjM1PxmoSYffP2WUjqlqwJZra9+yC/mj4Z97HNBOQRxhxDx
 Er3Orr2L49TXJ2AKksnTzcI5kTBBBtnvksD4Q1sVxWdlZNQgyjN6gMDYFrXvl/L52Cb0
 VQQsV33KqdwrV/QkzyGGMZceOsEeAPog3hDzD6xbq66wsNCPzUauLUqk5T6iLG/t4S7F
 gNhlhPC9FWqmOm36rJqKav6Vz8evjrhIk3+AyF07XLhl+nSDzCC2BOi7Kfz9xf+wnsTW
 VxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686597920; x=1689189920;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MVU/rCpCbtd0jlbCciUbATvr2DovhixhPhqoZ0JvgK4=;
 b=lALWhNw/T29fRHHLYo2UzK3eKdMLf1PYO+s2Hr/b6SRY/6xFNHbE/NDFRALKTGgstE
 zy+2oknxhd2jQ0UgLzYpP0QcVBUvepNquCPBvAWyQIA8FbXjCnkSMbGwk1gUBqT84W6y
 igXjkQGkU76G5ianbucfHXGro84fSVEMarJTpn4TbO4Qh9FadVFfS5fDmdCk0Bd/zSS7
 s6uohE46wRwuuLaq/Sake5tXEyaBlnZRkb7RI9xkoBaZHYQDSjCUP2/vftPapyu3iU5j
 k4JfCc/R8D6YaEQuwMCiNh1LtqUJu4Zb1kikhlwloeeKz3CJZlvbD3C4i7ANlkIKTmxE
 QMhg==
X-Gm-Message-State: AC+VfDy8hc+kKQBTHswZCeLOufXF4BRA/UTQUigKKHE51+llAs3bH1vs
 v38uTDgWNAgeQ2/+kc55+Vs=
X-Google-Smtp-Source: ACHHUZ5vPUjdhzCXB/JxFRVjb+6JhoqmTw9tS+oK8Sp8USRZpGT0k6ec6O2lvhbzgo+2LFhPpNizyQ==
X-Received: by 2002:a17:906:ef07:b0:96a:1c2a:5a38 with SMTP id
 f7-20020a170906ef0700b0096a1c2a5a38mr8926641ejs.11.1686597919965; 
 Mon, 12 Jun 2023 12:25:19 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-013-123-197.77.13.pool.telefonica.de.
 [77.13.123.197]) by smtp.gmail.com with ESMTPSA id
 gv19-20020a170906f11300b0097812e2b66csm5570178ejb.111.2023.06.12.12.25.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jun 2023 12:25:19 -0700 (PDT)
Date: Mon, 12 Jun 2023 17:54:08 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_11/15=5D_hw/pci-host/i440f?=
 =?US-ASCII?Q?x=3A_Add_PCI=5FHOST=5FPROP=5FIO=5FMEM_property?=
In-Reply-To: <e6b98830-4e4e-d117-d6c3-7e0fe525362d@linaro.org>
References: <20230611103412.12109-1-shentey@gmail.com>
 <20230611103412.12109-12-shentey@gmail.com>
 <e6b98830-4e4e-d117-d6c3-7e0fe525362d@linaro.org>
Message-ID: <39D45644-6A61-477D-A03B-B3F3271EC6A8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 12=2E Juni 2023 10:31:48 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <phi=
lmd@linaro=2Eorg>:
>On 11/6/23 12:34, Bernhard Beschow wrote:
>> Introduce the property in anticipation of QOM'ification; Q35 has the sa=
me
>> property=2E
>>=20
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>   hw/pci-host/i440fx=2Ec | 14 ++++++++++----
>>   1 file changed, 10 insertions(+), 4 deletions(-)
>
>
>> @@ -51,6 +50,7 @@ struct I440FXState {
>>       /*< public >*/
>>         MemoryRegion *system_memory;
>> +    MemoryRegion *address_space_io;
>
>"io_mem" like the property? (this is not an AddressSpace)

Agreed=2E I'd name it "io_memory" to be consistent with above attribute=2E

Best regards,
Bernhard

>
>>       MemoryRegion *pci_address_space;
>
>(pre-existing misleading name)
>
>>       MemoryRegion *ram_memory;
>>       Range pci_hole;
>

