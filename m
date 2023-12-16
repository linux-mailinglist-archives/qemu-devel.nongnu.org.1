Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE67815876
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Dec 2023 10:01:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEQXJ-00080A-5r; Sat, 16 Dec 2023 04:00:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rEQXF-0007zy-Lr
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 04:00:37 -0500
Received: from mail-ej1-f43.google.com ([209.85.218.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rEQXD-0001jP-HA
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 04:00:37 -0500
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-a1f8510883aso182071666b.3
 for <qemu-devel@nongnu.org>; Sat, 16 Dec 2023 01:00:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702717233; x=1703322033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g5TS9noVggV5ZUOfqzVMT4hJwjFNXHBwq031kv0/Ouk=;
 b=DsT2VqArw9jWx95cjrsVI0lJHX6pEri1Kq/st0jhTGivy6E6Imh/af8xX7mFW5+aNO
 ZEpsPUA7GNs1ibrRqHAPcxUHPDhvDDAKYTYLzcCeX6bvqRZYtezfz9KY8ThCe+pZam3s
 btYGIIfJjCyYYM5uu4uDd47KXK/i5WeADXNevq19GZrY43lN3lRlrxZYLECOsjcwpDaf
 fIEBdQrAHFjauZA+IySLcxNyMa82O0sStQJBaTmxPfYfhk6tGtC0N1NEEWwdZd/OAVn1
 4IlUM2gIQI1gqFqEQBXutVE7pTtjT9hbbI+ROejaS2+BHSQ8zqwrNWv7O790+vTgw1Su
 gRGA==
X-Gm-Message-State: AOJu0YwPT2oGS/TJP117NSe3loupyanorANQ0OStzV/k9P7eUAHt6kNQ
 OodwwcFZQoL6tJqnXbJGiQ91TqWazSg=
X-Google-Smtp-Source: AGHT+IH03HfOvdVGRaA6k1pShYoH7YfCigmCSTCn5HJe9PMo5E08I2rrVmswKbbLbByIRU2V1NA87Q==
X-Received: by 2002:a17:906:2295:b0:a1c:f0d8:d50e with SMTP id
 p21-20020a170906229500b00a1cf0d8d50emr3205460eja.69.1702717232645; 
 Sat, 16 Dec 2023 01:00:32 -0800 (PST)
Received: from fedora (ip-109-43-178-144.web.vodafone.de. [109.43.178.144])
 by smtp.gmail.com with ESMTPSA id
 kt19-20020a1709079d1300b00a1b65958c54sm11614465ejc.125.2023.12.16.01.00.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Dec 2023 01:00:32 -0800 (PST)
Date: Sat, 16 Dec 2023 10:00:29 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 01/12] next-cube.c: add dummy Ethernet register to allow
 diagnostic to timeout
Message-ID: <20231216100029.3775f650@fedora>
In-Reply-To: <20231215200009.346212-2-mark.cave-ayland@ilande.co.uk>
References: <20231215200009.346212-1-mark.cave-ayland@ilande.co.uk>
 <20231215200009.346212-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.218.43; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f43.google.com
X-Spam_score_int: 19
X-Spam_score: 1.9
X-Spam_bar: +
X-Spam_report: (1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Am Fri, 15 Dec 2023 19:59:58 +0000
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> Add a dummy register at address 0x6000 in the MMIO memory region to allow the
> initial diagnostic test to timeout rather than getting stuck in a loop
> continuously writing "en_write: tx not ready" to the console.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
> index fabd861941..feeda23475 100644
> --- a/hw/m68k/next-cube.c
> +++ b/hw/m68k/next-cube.c
> @@ -429,6 +429,10 @@ static uint32_t scr_readb(NeXTPC *s, hwaddr addr)
>          /* Hack: We need to have this change consistently to make it work */
>          return 0xFF & clock();
>  
> +    /* For now return dummy byte to allow the Ethernet test to timeout */
> +    case 0x6000:
> +        return 0xff;
> +

Good idea!

Tested-by: Thomas Huth <huth@tuxfamily.org>

