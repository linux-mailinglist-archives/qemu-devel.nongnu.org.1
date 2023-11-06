Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DD57E2B63
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 18:41:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r03bK-0005Tf-19; Mon, 06 Nov 2023 12:41:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r03bI-0005TC-0d
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 12:41:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r03b4-0005sO-Uc
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 12:41:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699292469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ziINzhKYQb0ixzm3ye3DkbTQln1K75LKKUEyNyhq65Y=;
 b=Fg6JWpVqCYkOGpj2gFsDjtK/hiXGGMH/MYZD0JAkpYeg48Hol0WIWJbcUjclocPubT2lH1
 Uz/RcTyekJoa6r5U5Cy5pqJTmVLfAjK6DC6VQlyy/+dypPPC8Ej74EkWke4NHKTx8r3Xv4
 QzimZy3ZYQP/BsDeb5owHKA3MfjUrjQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-fohD3OePOHWYTXV3TSAA-w-1; Mon, 06 Nov 2023 12:40:51 -0500
X-MC-Unique: fohD3OePOHWYTXV3TSAA-w-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2c506abc320so41373271fa.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 09:40:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699292450; x=1699897250;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ziINzhKYQb0ixzm3ye3DkbTQln1K75LKKUEyNyhq65Y=;
 b=iupFHS7ITyDfcF/2Kypenwwxcrrh2Mssuo2LWcmUXq1zCyb+qOxIrF7qhItbVU5Zz3
 S+FZgdTHQntLUdyAewzP1WErCfof0TLDNWL6m/O/Bzzc8/RLYhHN2gM8ryDsjtqQpcNx
 SztF0eu1xRHAnFJBb/5vBHB6UDXUE3s2p8GTIbRx9cfzVbJ8Sc2pPQcLvGqSQ2Yry8pG
 Z7vDwJcb9CSkSfi494ZlRGDwFNDt74vCY5Hi1F0UbT2R4jHNsIh7CXvFNneCn4vscOMD
 dtG3TtZPST4r3rphVomgNYzSifrVOzLSrPkisnGXxW5vlqGt5gTakaWIP18svl1K+2nQ
 neAQ==
X-Gm-Message-State: AOJu0YzCItPDsmF5wWgl3YMoGLf8M4+AEL9+SxChc9+scz78GsjTHi1a
 gIKj1UNPoFDUN3kbdsMCp/VtnvKxULpCjzMedigF2W1GC6xABHUPF+yvTAHJp7W1Ng3BEWzEjoh
 1VTyhJhiUy5ej3fY=
X-Received: by 2002:a2e:a4c9:0:b0:2c6:ed19:58a6 with SMTP id
 p9-20020a2ea4c9000000b002c6ed1958a6mr10462340ljm.33.1699292450019; 
 Mon, 06 Nov 2023 09:40:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/WkKLAW+HPR0PDMdN9FG3X4uA5tJcXmxomJBYNJOtgCRXuskZT0uSPUpVLx4PszKyIchreg==
X-Received: by 2002:a2e:a4c9:0:b0:2c6:ed19:58a6 with SMTP id
 p9-20020a2ea4c9000000b002c6ed1958a6mr10462328ljm.33.1699292449664; 
 Mon, 06 Nov 2023 09:40:49 -0800 (PST)
Received: from redhat.com ([5.102.242.158]) by smtp.gmail.com with ESMTPSA id
 f13-20020a05600c4e8d00b0040596352951sm12757850wmq.5.2023.11.06.09.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 09:40:49 -0800 (PST)
Date: Mon, 6 Nov 2023 12:40:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhujun2 <zhujun2@cmss.chinamobile.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, anisinha@redhat.com,
 thuth@redhat.com, lvivier@redhat.com
Subject: Re: [PATCH] tests: Fix printf format string in acpi-utils.c
Message-ID: <20231106123942-mutt-send-email-mst@kernel.org>
References: <20231027030930.7739-1-zhujun2@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027030930.7739-1-zhujun2@cmss.chinamobile.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

On Thu, Oct 26, 2023 at 08:09:30PM -0700, zhujun2 wrote:
> Inside of acpi_fetch_table() arguments are
> printed via fprintf but '%d' is used to print @flags (of type
> uint). Use '%u' instead.
> 
> Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>

OK though I never expect this to matter.

> ---
>  tests/qtest/acpi-utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/acpi-utils.c b/tests/qtest/acpi-utils.c
> index 673fc97586..6389f1f418 100644
> --- a/tests/qtest/acpi-utils.c
> +++ b/tests/qtest/acpi-utils.c
> @@ -102,7 +102,7 @@ void acpi_fetch_table(QTestState *qts, uint8_t **aml, uint32_t *aml_len,
>              char *fname = NULL;
>              GError *error = NULL;
>  
> -            fprintf(stderr, "Invalid '%.4s'(%d)\n", *aml, *aml_len);
> +            fprintf(stderr, "Invalid '%.4s'(%u)\n", *aml, *aml_len);
>              fd = g_file_open_tmp("malformed-XXXXXX.dat", &fname, &error);
>              g_assert_no_error(error);
>              fprintf(stderr, "Dumping invalid table into '%s'\n", fname);
> -- 
> 2.17.1
> 
> 


