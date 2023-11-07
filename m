Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 867C67E48FC
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 20:09:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0RRh-00053h-LA; Tue, 07 Nov 2023 14:09:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r0RRf-00050v-2Z
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 14:09:03 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r0RRZ-0005vR-2W
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 14:09:02 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9dd5879a126so679940966b.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 11:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699384134; x=1699988934; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SUyRXGt8QSsflk1uarPFgrRI9CYeZWMNnW5Ah80VIL0=;
 b=tKR1BaPo6F+o1xEXk6ZqyOckEmZin/AzOjY46zpNp7YLqQpzJ53+8DQi3eTWarEgFF
 vP9113Ly4RbxNZKb3ZdZR+/c3TAhdF3/kZZoRwNgKCeAN1WwKNJBegf1SAiO4NKJh/UK
 kK1sgXjRU2neP1jGa7u5k6ngYbGfq2BbOcIqVXPv+9GHgTA6PgMiqur5u44dku5itm97
 EnPxE0OEjPw0rBTNJAfyBXI4yDLWA64Xfwv3T5Q9ECRIZU459nMZ6bsT3xDCLOy45QlB
 C4OhX0krioi7lrEwjLPpAeles99DpcN5pRfr5mgr5zssd04l71R+6wCw/XqO7cu6+Pir
 hUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699384134; x=1699988934;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SUyRXGt8QSsflk1uarPFgrRI9CYeZWMNnW5Ah80VIL0=;
 b=WwfK5Hlu8u+9R8tUxXcupJd6OEsS7OTVxiROE4DiNU0lFw83pcTyPX7yuyfkUzf9DK
 QCfQ4UuwiCtd/eUL0wGUPgDDZGBER6QxyIiDTN/tCH5wdJG0V47alMvz1iNtSXWjG39M
 ADTO1S3ngsakUIPJFjODLYJ6y43galKegd2VpLlXbATYjA0jhf+m3EoQxUdqMLk7oyQW
 4NhF2rBQTC8a90vlQOTZIpUB6roCXfbBYEMzhWYGXFwtV67Aq7l/3vd1Am5zH2UFZLMX
 qr9QNUiD0IF5X3nOHO5Xa5qqDo3ifIsxScsZJ+A1+sRX+AXupIlVnup+JjWWVL4Llqin
 jaqw==
X-Gm-Message-State: AOJu0YzwSJky1FFDlRD99BG3VAVFTxjO5cEy9uVsObT3e3dKX4W+DxZr
 /PcSYAgfR6H0JVjgu0/urbP7ofXICFAeuR4xKOiu6A==
X-Google-Smtp-Source: AGHT+IHlrHlXEa6wFWF3DB/lBqdv8jyE+nyyFZuiRuHso9j7gd/DgXCxoOC4xQKN1ye+gwylsabO//73zpk35DIXrnY=
X-Received: by 2002:a17:907:720b:b0:9b2:fa55:5794 with SMTP id
 dr11-20020a170907720b00b009b2fa555794mr16371209ejc.58.1699384134142; Tue, 07
 Nov 2023 11:08:54 -0800 (PST)
MIME-Version: 1.0
References: <20231107185034.6434-1-vr_qemu@t-online.de>
In-Reply-To: <20231107185034.6434-1-vr_qemu@t-online.de>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 7 Nov 2023 21:08:38 +0200
Message-ID: <CAAjaMXbhhd56vea7=EPeqr2FdUzUfVwvR=S-WNwGRBpgL5_B=A@mail.gmail.com>
Subject: Re: [PATCH] hw/audio/virtio-snd-pci: fix the PCI class code
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, 7 Nov 2023 at 20:50, Volker R=C3=BCmelin <vr_qemu@t-online.de> wrot=
e:
>
> The virtio sound device is currently an unclassified PCI device.
>
> ~> sudo lspci -s '00:02.0' -v -nn | head -n 2
> 00:02.0 Unclassified device [00ff]:
>  Red Hat, Inc. Device [1af4:1059] (rev 01)
>         Subsystem: Red Hat, Inc. Device [1af4:1100]
>
> Set the correct PCI class code to change the device to a
> multimedia audio controller.
>
> ~> sudo lspci -s '00:02.0' -v -nn | head -n 2
> 00:02.0 Multimedia audio controller [0401]:
>  Red Hat, Inc. Device [1af4:1059] (rev 01)
>         Subsystem: Red Hat, Inc. Device [1af4:1100]
>
> Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

