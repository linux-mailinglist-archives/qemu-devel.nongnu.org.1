Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 910C881F52A
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 07:47:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIk9g-0008Vf-JA; Thu, 28 Dec 2023 01:46:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rIk9b-0008UX-FX
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 01:46:04 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rIk9Y-0002ok-S9
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 01:46:03 -0500
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-55559e26ccfso1259931a12.3
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 22:45:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703745956; x=1704350756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zH7PaALek5dCOFb7Ny2+p4rfsYDM9MnlJAkHWudp8ho=;
 b=IZF40rRWgQLcvvsDOEjK5YWsRb8YCsDNYj58R5XddEA+z71Lz+t18xtbeVlDgX0I4d
 sZjsoqa2E6zq3xH3hfxiTXx2X7BeHRoEKQc6/hcld3u4ShVKDcwkliIVOH9qvc2Ks0gY
 8BFQYhJt4l+BftX3UM08muJ1MJCfaffofEmt+gMShDMdvQm4O9yzM5LzjG2t34eW4OuS
 HNbcBReTt/pVQzOH+JCCjVKLxGj7s1OnXve8ppE4Rn7SCzEaPUbnCLddcOHS32euYhLK
 bY1wRd/B0Fapkfeqtl3C4ziGlIXOQffvHczt2JQdX+yP0HTSCDJ9fn8QQL9oFsQ8gtwd
 y1ww==
X-Gm-Message-State: AOJu0YxITD/1meLv1QDOTQMkU0Q5u5zltKxAFbCcwgFG4t2QBMrCQzaL
 6ETmfE5og21GRMmngbY5fbw=
X-Google-Smtp-Source: AGHT+IG8NnLwiiRcIVFH+/vcCRt8RKk8HOjoImaSwze632LnNLSq5tfyAa2hD2Kxk/IyUFgP11kQMw==
X-Received: by 2002:a50:c043:0:b0:554:46fd:e4cf with SMTP id
 u3-20020a50c043000000b0055446fde4cfmr4619506edd.70.1703745956086; 
 Wed, 27 Dec 2023 22:45:56 -0800 (PST)
Received: from fedora (ip-109-43-177-107.web.vodafone.de. [109.43.177.107])
 by smtp.gmail.com with ESMTPSA id
 en22-20020a056402529600b00553830eb2fcsm9350901edb.64.2023.12.27.22.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 22:45:55 -0800 (PST)
Date: Thu, 28 Dec 2023 07:45:54 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: laurent@vivier.eu, qemu-devel@nongnu.org
Subject: Re: [PATCH] q800: move dp8393x_prom memory region to Q800MachineState
Message-ID: <20231228074554.47a721c1@fedora>
In-Reply-To: <20231227210212.245106-1-mark.cave-ayland@ilande.co.uk>
References: <20231227210212.245106-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.208.52; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f52.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Am Wed, 27 Dec 2023 21:02:12 +0000
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> There is no need to dynamically allocate the memory region from the heap.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/q800.c         | 7 +++----
>  include/hw/m68k/q800.h | 1 +
>  2 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

