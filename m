Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4FA7D225E
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:37:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUsu-0000MG-13; Sun, 22 Oct 2023 05:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1quUsp-0000Ln-Aa
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:36:31 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1quUso-0002pI-10
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:36:31 -0400
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-53f9af41444so3528294a12.1
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697967388; x=1698572188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0YsKhvH+zI3Qt3Ns/5LD7Ug/x6TG5as5u2uFKa9TFL8=;
 b=IMXY+uEN/0AHgciJ8IMXuLUJQ+QEKwu29vFGqWXT/6ehmUkjppccql1t3moWPeKHPV
 +W2S6BWFaBixS2lW6oJtJgTY8ejj9IwRxzYJqX5c+qw8C4jfaYLz+vimAlolmZ3IMYrR
 v2Fc+t/ZNp6hvZ5+KYAsAlq4VeG8ooDsyHMTrezVCNTOw9AZXY1Y4D759g6j2XhbHi68
 8vpu2vStbOqq/nTfRSOPF3k88eO99eVeWbrD3Sxi49y2fgZBAOjyeqRt7TvivjWMcEB9
 MdjRPyxq+S284NUQAXgg8DVD3mxI4izu90oUXC7m3vt5yybIg2KFLTJHNXWOR5AXMisq
 p5HA==
X-Gm-Message-State: AOJu0Yw8k/cHEHK6e7K69/yhrHpIbadYRe/LAN48bdkUuy6MQguyljp6
 w0lHvAS/GsWaVhzbd9GmM8JM6kXmuoU=
X-Google-Smtp-Source: AGHT+IHzqgEH+xGL3KpbVKfZhew+o5gg0SYN2z5K7zHVEsQsJ6ZA84eCXl5TKS6kOKaABwRNb9l0Pg==
X-Received: by 2002:a17:907:7da4:b0:9aa:63d:9ede with SMTP id
 oz36-20020a1709077da400b009aa063d9edemr4976764ejc.9.1697967387997; 
 Sun, 22 Oct 2023 02:36:27 -0700 (PDT)
Received: from fedora (ip-109-43-176-141.web.vodafone.de. [109.43.176.141])
 by smtp.gmail.com with ESMTPSA id
 x13-20020a170906710d00b009ad87fd4e65sm4787251ejj.108.2023.10.22.02.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:36:27 -0700 (PDT)
Date: Sun, 22 Oct 2023 11:36:26 +0200
From: Thomas Huth <huth@tuxfamily.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH 4/6] hw/m68k/mcf_intc: Pass CPU using QOM link property
Message-ID: <20231022113626.372f5fa2@fedora>
In-Reply-To: <20231020150627.56893-5-philmd@linaro.org>
References: <20231020150627.56893-1-philmd@linaro.org>
 <20231020150627.56893-5-philmd@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.208.46; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f46.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am Fri, 20 Oct 2023 17:06:24 +0200
schrieb Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>:

> QOM objects shouldn't access each other internals fields
> except using the QOM API.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Tested-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>

