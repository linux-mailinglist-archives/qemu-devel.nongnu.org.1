Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E587C9911
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 15:04:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs0lx-0004U1-Vq; Sun, 15 Oct 2023 09:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qs0lw-0004Tk-Le
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 09:03:08 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qs0lv-0006Ew-2F
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 09:03:08 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9becde9ea7bso202324066b.0
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 06:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697374985; x=1697979785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Of5HaRfp2luUquH/EP7DfLTJ/sopRKIm+wMoSTYbr8Q=;
 b=m7OcdN47HIffll21iVMdFWfQqQkO2PbwB7Ox+u7Fzt9aPrujdodpLVGNMp515JFlEs
 PDwfqfN5SszAsj0J3f7eHbTuOU89D4KyVzf2rb587B8WsNSu/4z9AH6QLD0eTVZp+2S/
 0slwfKfTJKdhMwGG+4is/pkhXZygQ4BGxE4PEXS/03ibOAr3NC0Lo3ll0rwR/GYzhkYa
 7FDxaYBt7Uy9Idg8+eG6OV3Wtx8D13cVhggcP3o8B31hJrmqfxSCQYPOpzNEbz7IIAUQ
 uum5DtVPSR9uzMo78Us1D2Ugy7Py9Q04Z6M8cCax5n29oZQ57FcPMH9LS8VpWuDbOmbU
 0cLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697374985; x=1697979785;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Of5HaRfp2luUquH/EP7DfLTJ/sopRKIm+wMoSTYbr8Q=;
 b=L2WSRKpo7yaUlQ33SVBp0M2Z8OQrZUytc7mafAKvrAjz92dp9MXcJdBIkBm8mS2NGP
 b7xF2IIq4BXPHLWeJaUWujhc3nRF+zrKwLs/MzxhsIPsoBOQ8RRkUVXHko7zCh8MrU7b
 OPzgel0AuoRC9Go0occQy7iVsfMj4xWHlIoVZnQMTE5tWOwpwxUa1FWyCK6TxhqFkSVQ
 H/5FxE4xk4DGPhhDKInapgTw9bfzq5v67x5+4LUS30A0o4CJnHpen9/Vwl2MQ3uWsGtJ
 qcoDi7R0m4QJzCrX9gHdw0hbOwNPNS8lthX/xmofxNF+l30JZhJuKaDLnhDjG1KMiVRd
 CPIg==
X-Gm-Message-State: AOJu0YzH9WbCMlh3Nhw1RLQxoVTqBIFj4MLlx2d7+nbbzJdCUijjX83Z
 2t5LY0xXuw9WrJhpY7wbAgc=
X-Google-Smtp-Source: AGHT+IGxCOhBbwH7kAxXGgIWzil/jno3BlFZZorzpMNDCMwap3T+GPh//6zIctcqFzQuyNc3/0FXAw==
X-Received: by 2002:a17:907:9482:b0:9a5:962c:cb6c with SMTP id
 dm2-20020a170907948200b009a5962ccb6cmr5077580ejc.31.1697374985099; 
 Sun, 15 Oct 2023 06:03:05 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-191-089-197.77.191.pool.telefonica.de.
 [77.191.89.197]) by smtp.gmail.com with ESMTPSA id
 l1-20020a170906078100b009928b4e3b9fsm2264379ejc.114.2023.10.15.06.03.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 06:03:04 -0700 (PDT)
Date: Sun, 15 Oct 2023 13:02:25 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 0/2] Move Fuloong2e PCI IRQ mapping to board code
In-Reply-To: <0360a8f2-cf80-3fb0-51de-c2f249e2b336@linaro.org>
References: <20230105154440.259361-1-shentey@gmail.com>
 <0360a8f2-cf80-3fb0-51de-c2f249e2b336@linaro.org>
Message-ID: <AE878E3E-7240-4E87-8517-2FE0B64EDA57@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



Am 5=2E Januar 2023 16:32:16 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <ph=
ilmd@linaro=2Eorg>:
>On 5/1/23 16:44, Bernhard Beschow wrote:
>
>> Bernhard Beschow (2):
>>    hw/pci-host/bonito: Inline pci_register_root_bus()
>>    hw/pci-host/bonito: Map PCI IRQs in board code
>>=20
>>   include/hw/pci-host/bonito=2Eh |  2 ++
>>   hw/mips/fuloong2e=2Ec          | 22 ++++++++++++++++++++++
>>   hw/pci-host/bonito=2Ec         | 31 ++++---------------------------
>>   3 files changed, 28 insertions(+), 27 deletions(-)
>>=20
>
>Series:
>Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>

Ping


